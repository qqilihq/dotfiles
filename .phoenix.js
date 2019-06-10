const modifiers = [ 'ctrl', 'shift' ];

Phoenix.set({
  daemon: true,
  openAtLogin: true
});

Key.on('z', modifiers, function () {
  const screen = Screen.main().flippedVisibleFrame();
  const window = Window.focused();
  if (window) {
    window.setTopLeft({
      x: screen.x + (screen.width / 2) - (window.frame().width / 2),
      y: screen.y + (screen.height / 2) - (window.frame().height / 2)
    });
  }
});

Key.on('left', modifiers, function () {
  const screen = Screen.main().flippedVisibleFrame();
  const window = Window.focused();
  if (window) {
    window.setFrame({ ...screen, width: screen.width / 2 });
  }
});

Key.on('right', modifiers, function () {
  const screen = Screen.main().flippedVisibleFrame();
  const window = Window.focused();
  if (window) {
    window.setFrame({ ...screen, x: screen.width / 2, width: screen.width / 2 });
  }
});

Key.on('up', modifiers, function () {
  const screen = Screen.main().flippedVisibleFrame();
  const window = Window.focused();
  if (window) {
    window.setFrame(screen);
  }
});
