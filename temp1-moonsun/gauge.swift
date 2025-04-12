import SwiftUI

struct GaugeView: View {
    @State private var images: [String] = ["gauge.with.dots.needle.0percent", "gauge.with.dots.needle.33percent", "gauge.with.dots.needle.67percent", "gauge.with.dots.needle.100percent"]
    @State private var index = 0
    var body: some View {
        HStack {
            
            Button(action:{
                index = (index-1+4) % 4;
            }, label:{
                Image(systemName: "arrowshape.left.fill")
                    .resizable()
                    .scaledToFit()
            })
            
            Image(systemName: images[index])
                .resizable()
                .scaledToFit()
            
            Button(action:{
                index = (index+1) % 4;
                
            }, label:{
                Image(systemName: "arrowshape.right.fill")
                    .resizable()
                    .scaledToFit()
            })
        }
    }
}

#Preview {
    GaugeView()
}
