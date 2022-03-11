import SwiftUI

import class Swindler.Window

struct TaskbarWindow: View {
  var title: String
  var window: Swindler.Window? = nil
  init(title: String) {
    self.title = title
  }
  init(window: Swindler.Window) {
    self.title = window.title.value
    self.window = window
  }
  func focus() {
    if let window = self.window {
      window.application.mainWindow.set(window)
      window.application.swindlerState.frontmostApplication.set(window.application)
    }
  }
  var body: some View {
    Button(action: self.focus) {
      HStack {
        Text(self.title)
          .foregroundColor(Color.white)
          .bold()
          .fixedSize()
      }
    }
    .buttonStyle(.borderless)
    .frame(maxHeight: .infinity)
    .padding(.horizontal, 10)
    .background(Color.white.opacity(0.25))
    .clipShape(RoundedRectangle(cornerRadius: 5))
  }
}

struct TaskbarWindow_Previews: PreviewProvider {
  static var previews: some View {
    TaskbarWindow(title: "Some Application")
      .frame(width: 400.0, height: 50.0)
      .background(Color.black)
      .padding(10)
  }
}
