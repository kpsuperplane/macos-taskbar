import PromiseKit
import Swindler

enum WindowAPI {
  private static var state: Promise<State>? = nil
  static func getState() -> Promise<Swindler.State> {
    if self.state == nil {
      self.state = Swindler.initialize()
    }
    return self.state!
  }
}
