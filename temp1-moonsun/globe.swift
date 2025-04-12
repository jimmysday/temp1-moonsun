import SwiftUI

struct GlobeView: View {
    @State var showPicker: Bool = false
    @State var color: Color = .blue
    var body: some View {
        NavigationStack{
            VStack{
                if(showPicker){
                    ColorPicker("Icon Color", selection:$color)
                        .padding()
                }
                else{
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFit()
                    //.navigationBarTitle("Globe")
                        .foregroundColor(color)
                        .padding()
                }
            }
            .toolbar{
                Button(action:{
                    showPicker.toggle()
                }
                ,label:{Image(systemName: "paintbrush")})
            }
            
        }
    }
}

#Preview {
    GlobeView()
}
