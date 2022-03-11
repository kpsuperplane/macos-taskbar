import SwiftUI

import class Swindler.Application
import class Swindler.State
import class Swindler.Window
import struct Swindler.WindowCreatedEvent
import struct Swindler.WindowDestroyedEvent

struct Application {
  let frontmost: Bool
  let application: Swindler.Application
}

extension Swindler.Window {
  var id: ObjectIdentifier { ObjectIdentifier(self) }
}

struct TaskbarWindowList: View {
  @SwiftUI.State var state: State? = nil
  @SwiftUI.State var refresh: Bool = false
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 10) {
        if self.state != nil {
          ForEach(self.state!.runningApplications, id: \.processIdentifier) {
            application in
            ForEach(application.knownWindows, id: \.id) {
              window in TaskbarWindow(window: window)
            }
          }
        } else {
          TaskbarWindow(title: "Loading...")
        }
      }
      .frame(maxHeight: .infinity)
      .padding(5)
    }
    .onAppear {
      WindowAPI.getState().done { state in
        self.state = state
        state.on { (event: Swindler.WindowCreatedEvent) in
          refresh.toggle()
        }
        state.on { (event: Swindler.WindowDestroyedEvent) in
          refresh.toggle()
        }
      }
    }
  }
}
