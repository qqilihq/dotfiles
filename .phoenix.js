// https://github.com/kasper/phoenix/blob/2.6.2/docs/API.md

// TODO minimize/hide all windows except current?
// TODO minimize other application windows

const modifiers = [ 'ctrl', 'shift' ];

Phoenix.set({
  daemon: true,
  openAtLogin: true
});

Key.on('left', modifiers, windowHandler((window, screen) => {
  if (window.at(screen.topHalf()) || window.at(screen.topRightQuarter())) {
    return screen.topLeftQuarter();
  } else if (window.at(screen.bottomHalf()) || window.at(screen.bottomRightQuarter())) {
    return screen.bottomLeftQuarter();
  } else if (window.at(screen.leftHalf())) {
    return screen.full();
  } else {
    return screen.leftHalf();
  }
}));

Key.on('right', modifiers, windowHandler((window, screen) => {
  if (window.at(screen.topHalf()) || window.at(screen.topLeftQuarter())) {
    return screen.topRightQuarter();
  } else if (window.at(screen.bottomHalf()) || window.at(screen.bottomLeftQuarter())) {
    return screen.bottomRightQuarter();
  } else if (window.at(screen.rightHalf())) {
    return screen.full();
  } else {
    return screen.rightHalf();
  }
}));

Key.on('up', modifiers, windowHandler((window, screen) => {
  if (window.at(screen.leftHalf()) || window.at(screen.bottomLeftQuarter())) {
    return screen.topLeftQuarter();
  } else if (window.at(screen.rightHalf()) || window.at(screen.bottomRightQuarter())) {
    return screen.topRightQuarter();
  } else if (window.at(screen.full()) || window.at(screen.bottomHalf())) {
    return screen.topHalf();
  } else {
    return screen.full();
  }
}));

Key.on('down', modifiers, windowHandler((window, screen) => {
  if (window.at(screen.leftHalf()) || window.at(screen.topLeftQuarter())) {
    return screen.bottomLeftQuarter();
  } else if (window.at(screen.rightHalf()) || window.at(screen.topRightQuarter())) {
    return screen.bottomRightQuarter();
  } else if (window.at(screen.full()) || window.at(screen.topHalf()) || window.at(screen.bottomLeftQuarter()) || window.at(screen.bottomRightQuarter())) {
    return screen.bottomHalf();
  } else if (window.at(screen.bottomHalf())) {
    return screen.full();
  }
}));

Key.on('c', modifiers, windowHandler(window => window.center()));

// const growMoveDistance = 50;

// move window
// Key.on('w', modifiers, windowHandler(window => window.move('vertical', -growMoveDistance)));
// Key.on('s', modifiers, windowHandler(window => window.move('vertical', growMoveDistance)));
// Key.on('a', modifiers, windowHandler(window => window.move('horizontal', -growMoveDistance)));
// Key.on('d', modifiers, windowHandler(window => window.move('horizontal', growMoveDistance)));

// grow/shrink window
// Key.on('y', modifiers, windowHandler(window => window.grow('width', -growMoveDistance)));
// Key.on('x', modifiers, windowHandler(window => window.grow('width', growMoveDistance)));
// Key.on('f', modifiers, windowHandler(window => window.grow('height', -growMoveDistance)));
// Key.on('v', modifiers, windowHandler(window => window.grow('height', growMoveDistance)));

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
  const delta = 20;
  for (const property of ['x', 'y', 'width', 'height']) {
    if (Math.abs(rectangle[property] - frame[property]) > delta) {
      return false;
    }
  }
  return true;
}

Window.prototype.center = function () {
  const screen = this.screen().flippedVisibleFrame();
  const frame = this.frame();
  this.setTopLeft({ x: (screen.width - frame.width) / 2, y: (screen.height - frame.height) / 2 });
}

Window.prototype.move = function (direction, by) {
  const frame = this.frame();
  switch (direction) {
    case 'vertical': frame.y += by; break;
    case 'horizontal': frame.x += by; break;
  }
  this.setFrame(frame);
}

Window.prototype.grow = function (direction, by) {
  const frame = this.frame();
  frame[direction] += by;
  this.setFrame(frame);
}

/** Handler utility for window methods. The handler methods only gets
 * called when there’s actually a window. It gets passed the window
 * and the corresponding screen as parameters and should return the
 * new position (or nothing if no action should be taken). */
function windowHandler (handler) {
  return () => {
    const window = Window.focused();
    if (!window) {
      return;
    }
    const screen = window.screen();
    const position = handler(window, screen);
    if (position) {
      window.setFrame(position);
    }
  }
}

// space-related: move current window to previous/or next space
Key.on('p', modifiers, () => moveSpace(true));
Key.on('o', modifiers, () => moveSpace(false));

function moveSpace (nextOrPrevious) {
  const window = Window.focused();
  if (!window) {
    return;
  }
  const currentSpace = window.screen().currentSpace();
  if (currentSpace.isFullScreen()) {
    return; // do not move windows from full screen space
  }
  let destinationSpace = currentSpace;
  for (;;) {
    destinationSpace = nextOrPrevious ? destinationSpace.next() : destinationSpace.previous()
    if (!destinationSpace.isFullScreen()) { // do not move to full screen space
      break;
    }
  }
  currentSpace.removeWindows([window]);
  destinationSpace.addWindows([window]);
  window.focus();
}
