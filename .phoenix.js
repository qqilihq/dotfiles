const modifiers = [ 'ctrl', 'shift' ];

Phoenix.set({
  daemon: true,
  openAtLogin: true
});

Key.on('left', modifiers, windowHandler((window, screen) => {
  if (window.at(screen.topHalf()) || window.at(screen.topRightQuarter())) {
    window.setFrame(screen.topLeftQuarter());
  } else if (window.at(screen.bottomHalf()) || window.at(screen.bottomRightQuarter())) {
    window.setFrame(screen.bottomLeftQuarter());
  } else {
    window.setFrame(screen.leftHalf());
  }
}));

Key.on('right', modifiers, windowHandler((window, screen) => {
  if (window.at(screen.topHalf()) || window.at(screen.topLeftQuarter())) {
    window.setFrame(screen.topRightQuarter());
  } else if (window.at(screen.bottomHalf()) || window.at(screen.bottomLeftQuarter())) {
    window.setFrame(screen.bottomRightQuarter());
  } else {
    window.setFrame(screen.rightHalf());
  }
}));

Key.on('up', modifiers, windowHandler((window, screen) => {
  if (window.at(screen.leftHalf()) || window.at(screen.bottomLeftQuarter())) {
    window.setFrame(screen.topLeftQuarter());
  } else if (window.at(screen.rightHalf()) || window.at(screen.bottomRightQuarter())) {
    window.setFrame(screen.topRightQuarter());
  } else if (window.at(screen.full()) || window.at(screen.topLeftQuarter()) || window.at(screen.topRightQuarter()) || window.at(screen.bottomHalf())) {
    window.setFrame(screen.topHalf());
  } else {
    window.setFrame(screen.full());
  }
}));

Key.on('down', modifiers, windowHandler((window, screen) => {
  if (window.at(screen.leftHalf()) || window.at(screen.topLeftQuarter())) {
    window.setFrame(screen.bottomLeftQuarter());
  } else if (window.at(screen.rightHalf()) || window.at(screen.topRightQuarter())) {
    window.setFrame(screen.bottomRightQuarter());
  } else if (window.at(screen) || window.at(screen.topHalf()) || window.at(screen.bottomLeftQuarter()) || window.at(screen.bottomRightQuarter())) {
    window.setFrame(screen.bottomHalf());
  }
}));

// helper functions for creating rectangles within the 2x2 grid
// e.g. `topLeftQuarter` will create a rectangle at x and y position (0,0),
// with half the screen’s width and height

Screen.prototype.full = function () {
  return { ...this.flippedVisibleFrame() };
}
Screen.prototype.leftHalf = function () {
  return { ...this.full(), width: this.full().width / 2 };
}
Screen.prototype.rightHalf = function () {
  return { ...this.full(), x: this.full().x + this.full().width / 2, width: this.full().width / 2 };
}
Screen.prototype.topLeftQuarter = function () {
  return { ...this.full(), width: this.full().width / 2, height: this.full().height / 2 };
}
Screen.prototype.bottomLeftQuarter = function () {
  return { ...this.full(), y: this.full().y + this.full().height / 2, width: this.full().width / 2, height: this.full().height / 2 };
}
Screen.prototype.topRightQuarter = function () {
  return { ...this.full(), x: this.full().x + this.full().width / 2, width: this.full().width / 2, height: this.full().height / 2 };
}
Screen.prototype.bottomRightQuarter = function () {
  return { ...this.full(), x: this.full().x + this.full().width / 2, y: this.full().y + this.full().height / 2, width: this.full().width / 2, height: this.full().height / 2 };
}
Screen.prototype.topHalf = function () {
  return { ...this.full(), height: this.full().height / 2 };
}
Screen.prototype.bottomHalf = function () {
  return { ...this.full(), y: this.full().y + this.full().height / 2, height: this.full().height / 2 };
}

/** Determine whether this window is “snapped” to the given rectangle
 * (consider some pixels “delta” as tolerance, as the values might
 * not match exatctly due to rounding, or the user might have accidentally
 * moved the window a little). */
Window.prototype.at = function (rectangle) {
  const frame = this.frame();
  const delta = 5;
  for (const property of ['x', 'y', 'width', 'height']) {
    if (Math.abs(rectangle[property] - frame[property]) > delta) {
      return false;
    }
  }
  return true;
}

/** Handler utility for window methods. The handler methods only gets
 * called when there’s actually a window. It gets passed the window
 * and the corresponding screen as parameters. */
function windowHandler (handler) {
  return () => {
    const window = Window.focused();
    if (!window) {
      return;
    }
    const screen = window.screen();
    handler(window, screen);
  }
}
