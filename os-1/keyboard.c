// boot2.c の代わり

#define KBD_STATUS    0x64
#define KBD_DATA      0x60
#define KEY_UP_BIT    0x80
#define SCREEN_WIDTH  320

// 関数 boot2() より前に他の関数の定義(実装)や、大域変数宣言を書いてはいけない

void boot2() {
  while(1)
  {
    while ((in8(KBD_STATUS) & 1) == 0)
      ;

    int value = in8(KBD_DATA);
    // if (value & KEY_UP_BIT)    // if key up
    //   print(1, 100, 50, 15);
    // else
    //   print(0, 100, 50, 15);

    int key = value & 0x7f;
    if (key < 16)
      print(key, 100, 50, 15);
  }
  halt();
}
int xpos = 100;
int ypos = 60;
int key_number = -1;

void boot2() {
  int value;
  register_kbd_handler();
  while (1) {
    cli();
    if (key_number != -1) {
      // キー番号を保存してある大域変数を読み書き
      value = key_number;
      key_number = -1;
      sti();
      // キー番号を表示
      if (value < 16)
        print(value, xpos, ypos, 15);
      xpos += 5;

    }
    else
      sti_and_halt();
  }
}

// 関数の宣言は省略する。
// C89 までは、戻り値が int である関数は事前に宣言しなくてもよかった。
// 適当な戻り値がない場合は 0 を返すことにする。

int kbd_handler() {
  out8(0x20, 0x61);	// PIC0_OCW2: accept IRQ1 again
  int value = in8(KBD_DATA);
  key_number = value & 0x7f;
  // 表示: ここを書き換えればよい
}

// 割り込み処理関数を登録する
int register_kbd_handler() {
  int* ptr = (int*)0x7e00;
  *ptr = (int)kbd_handler;
  sti();
  out8(0x21, 0xf9);	// PIC0_IMR: accept only IRQ1 and IRQ2 (PIC1)
  out8(0xa1, 0xff);	// PIC1_IMR: no interrupt
}

int print(int num, int x, int y, int color) {
  static char bitmaps[][4] = {
    { 0x7e, 0x81, 0x81, 0x7e },	// 0
    { 0x00, 0x41, 0xff, 0x01 },	// 1
    { 0x47, 0x89, 0x91, 0x61 }, // 2
    { 0x42, 0x81, 0x99, 0x66 }, // 3
    { 0x38, 0x48, 0xff, 0x08 }, // 4
    { 0xfa, 0x91, 0x91, 0x8d }, // 5
    { 0x7d, 0x89, 0x89, 0x46 }, // 6
    { 0xc3, 0x8c, 0xb0, 0xc0 }, // 7
    { 0x66, 0x99, 0x99, 0x66 }, // 8
    { 0x60, 0x90, 0x90, 0xff }, // 9
    { 0x3f, 0xc8, 0xc8, 0x3f }, // A
    { 0xff, 0x99, 0x99, 0x66 }, // B
    { 0x7e, 0x81, 0x81, 0x66 }, // C
    { 0xff, 0x81, 0xc3, 0x7e }, // D
    { 0xff, 0x99, 0x99, 0x99 }, // E
    { 0xff, 0x88, 0x88, 0x88} // F
  };

  int i, j;
  char* vram = (char*)0xa0000;
  char* map = bitmaps[num];
  vram += (y * SCREEN_WIDTH + x); 

  for (i = 0; i < 8; i++) {
    for (j = 0; j < 4; j++) {
      char bits = map[j];
      if (bits & (0x80 >> i))
        *(vram + j) = color;
      else 
        *(vram + j) = 0;
    }

    vram += SCREEN_WIDTH;
  }

  return 0;
}

// in 命令で port の値 (8bit) を読む
int in8(int port) {
  int value;
  asm volatile ("mov $0, %%eax\n\tin %%dx,%%al"
                : "=a" (value) : "d" (port));
  return value;
}

// out 命令で port に値 (8bit) を書き込む
int out8(int port, int value) {
  asm volatile ("out %%al,%%dx"
                : : "d" (port), "a" (value));
  return 0;
}

// sti 命令 (割り込み許可) を実行
int sti() {
  asm volatile ("sti");
  return 0;
}

// cli 命令 (割り込み禁止) を実行
int cli() {
  asm volatile ("cli");
  return 0;
}

// hlt 命令でプロセッサを停止させる
int halt() {
  asm volatile ("hlt");
  return 0;
}

// sti 命令と hlt 命令を連続して実行
// sti してから hlt までのわずかの時間に割り込みが発生しないようにする。
int sti_and_halt() {
  asm volatile ("sti\n\thlt");
  return 0;
}
