import SwiftUI

struct SampleView: View {
    
    @State private var number = [0,1,2,3,4,5,6]
    @State private var images: [[String]] = Array(repeating: Array(repeating:"square",count:7),count:7)
    
    @State private var vibrateOnRing: Bool = false
    
    var body: some View {
        Text("\(number[3])")
        
        Image(systemName: images[number[0]][number[0]])
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .onTapGesture {
                self.number.shuffle()
                self.images.shuffle()
            }
            //.foregroundStyle(.tint)
            .foregroundColor(Color.yellow)
            .padding()

        Toggle(
               "Vibrate on Ring",
               systemImage: "dot.radiowaves.left.and.right",
               isOn: $vibrateOnRing
           )


    }
}

#Preview {
    SampleView()
}
