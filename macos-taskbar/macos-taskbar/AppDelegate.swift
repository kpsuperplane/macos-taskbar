import AXSwift
import SwiftUI
import Swindler

class AppDelegate: NSObject, NSApplicationDelegate {
  var taskbarPanel: TaskbarPanel!
  func applicationDidFinishLaunching(_ aNotification: Notification) {

    // close the window we just opened
    if let window = NSApplication.shared.windows.first {
      window.close()
    }

    let taskbarView = TaskbarView().edgesIgnoringSafeArea(.top)

    if let screenWidth = NSScreen.main?.frame.width {
      print(screenWidth)
      taskbarPanel = TaskbarPanel(
        contentRect: NSRect(x: 0, y: 0, width: screenWidth, height: 40), backing: .buffered,
        defer: false)
      taskbarPanel.title = "MacOS Taskbar"
      taskbarPanel.contentView = NSHostingView(rootView: taskbarView)
      taskbarPanel.orderFront(nil)
      taskbarPanel.makeKey()
    }

    guard AXSwift.checkIsProcessTrusted(prompt: true) else {
      print("Not trusted as an AX process; please authorize and re-launch")
      NSApp.terminate(self)
      return
    }

    WindowAPI.getState().done { state in
      print(state.screens)
      print(state.knownWindows)
    }

  }
  func applicationWillTerminate(_ aNotification: Notification) {
    taskbarPanel.close()
  }
}

@main
struct macosTaskbarApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  var body: some Scene {
    WindowGroup {
    }
  }
}
