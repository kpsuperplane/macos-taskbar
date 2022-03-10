// from https://www.markusbodner.com/til/2021/02/08/create-a-spotlight/alfred-like-window-on-macos-with-swiftui/
import AppKit

class TaskbarPanel: NSPanel {
  init(contentRect: NSRect, backing: NSWindow.BackingStoreType, defer flag: Bool) {
    super.init(
      contentRect: contentRect,
      styleMask: [.nonactivatingPanel, .titled, .closable, .fullSizeContentView], backing: backing,
      defer: flag)
    self.isFloatingPanel = true
    self.level = .floating
    self.collectionBehavior.insert(.fullScreenAuxiliary)
    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true
    self.isReleasedWhenClosed = false
    self.standardWindowButton(.closeButton)?.isHidden = true
    self.standardWindowButton(.miniaturizeButton)?.isHidden = true
    self.standardWindowButton(.zoomButton)?.isHidden = true
    self.isMovable = false
    self.isMovableByWindowBackground = false
    self.hasShadow = false
    self.styleMask = .fullSizeContentView
    self.isOpaque = false
    self.backgroundColor = NSColor.clear
  }

  override var canBecomeKey: Bool {
    return true
  }

  override var canBecomeMain: Bool {
    return true
  }
}
