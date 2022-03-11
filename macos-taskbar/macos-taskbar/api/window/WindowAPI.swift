import PromiseKit
import Swindler

enum WindowAPI {
  private static var state: Promise<State> = Swindler.initialize()
  static func getState() -> Promise<Swindler.State> {
    return self.state
  }
}
