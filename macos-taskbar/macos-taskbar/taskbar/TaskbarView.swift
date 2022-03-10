import SwiftUI

struct VisualEffectView: NSViewRepresentable {
  let material: NSVisualEffectView.Material
  let blendingMode: NSVisualEffectView.BlendingMode

  func makeNSView(context: Context) -> NSVisualEffectView {
    let visualEffectView = NSVisualEffectView()
    visualEffectView.material = material
    visualEffectView.blendingMode = blendingMode
    visualEffectView.state = NSVisualEffectView.State.active
    visualEffectView.appearance = NSAppearance(named: .vibrantDark)
    return visualEffectView
  }

  func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context) {
    visualEffectView.material = material
    visualEffectView.blendingMode = blendingMode
  }
}

struct TaskbarView: View {
  var body: some View {
    HStack {
      Image("logo")
        .resizable()
        .scaledToFit()
        .padding(10)

      Spacer()
      VStack {
        Text("22:52")
          .foregroundColor(.white)
        Text("03/09/2022")
          .foregroundColor(.white)
      }
      .padding(10)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      VisualEffectView(
        material: NSVisualEffectView.Material.sidebar,
        blendingMode: NSVisualEffectView.BlendingMode.behindWindow))
  }
}

struct TaskbarView_Previews: PreviewProvider {
  static var previews: some View {
    TaskbarView()
      .frame(width: 400.0, height: 50.0)
  }
}
