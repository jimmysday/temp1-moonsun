//import SwiftData
//
//@Model
//final class temp: Identifiable{
//    var tempture: Int
//    init(tempture: Int){
//        self.tempture = tempture
//    }
//}

//struct ContentView: View {
//    @State private var tempratures:[temp]
//    var body: some View {
//        VStack{
//            NavigationStack{
//                List{
//                    ForEach(tempratures){ t in
//                        TextField("temp", text: "\(t.tempture)")
//                    }
//                    
//                }
//            }
//        }
//    }
    //        var images=["gauge.with.dots.needle.0percent",
    //                    "gauge.with.dots.needle.33percent",
    //                    "gauge.with.dots.needle.67percent",
    //                    "gauge.with.dots.needle.100percent"]
    //        @State private var imageindex = 0
    //        var body: some View {
    //            HStack {
    //                Button(action:{
    //                    imageindex = (imageindex - 1 + 4) % 4
    //                }, label:{
    //                    Image(systemName: "arrowshape.left.fill")
    //                        .resizable()
    //                        .scaledToFit()
    //                })
    //                Image(systemName: images[imageindex])
    //                    .resizable()
    //                    .scaledToFit()
    //                    .foregroundStyle(.tint)
    //                Button(action:{
    //                    imageindex = (imageindex + 1) % 4
    //                }, label:{
    //                    Image(systemName: "arrowshape.right.fill")
    //                    .resizable()
    //                    .scaledToFit()})
    //            }
    //            .padding()
    //        }
    //    @State private var pageindex = false
    //    @State private var selectedColor: Color = .blue
    //    var body: some View{
    //        NavigationStack{
    //            VStack{
    //                if(pageindex){
    //                    Image(systemName: "globe")
    //                        .resizable()
    //                        //.foregroundStyle(.tint)
    //                        .scaledToFit()
    //                        .foregroundColor(selectedColor)
    //                }
    //                else{
    //                    ColorPicker("icon color", selection: $selectedColor)
    //                        .padding()
    //                }
    //            }
    //            .toolbar {
    //                //ToolbarItemGroup(placement: .bottomBar) {
    //                    //change the page when click the menu
    //                ToolbarItemGroup{
    //                    Button(action: {
    //                        pageindex.toggle()
    //                    },label:{
    //                        Image(systemName: "paintbrush")
    //                    })
    //                    .frame(width: 100, height: 25)
    //                    .accessibilityIdentifier("contentButton") //the identify for getting item in test
    //                }
    //            }
    //        }
    //    }
//}
