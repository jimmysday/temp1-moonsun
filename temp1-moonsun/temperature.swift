import SwiftUI
import SwiftData

@Observable
class degree: Identifiable {
    var value: Int
    init(value: Int) {
        self.value = value
    }
}

struct DetailView: View {
    @Bindable var temperature: degree
    var body: some View {
        Text("\(temperature.value) *C")
    }
}

struct TempView: View {
    @State private var temperatures: [degree] = [degree(value: 21), degree(value: -11), degree(value: 38), degree(value: -7)]
    var body: some View {
        NavigationStack{
            List{
                ForEach(temperatures, id: \.id.self){ item in
                    DetailView(temperature: item)
                }
                .onDelete{
                    if let index = $0.first{
                        self.temperatures.remove(at: index)
                    }
                }
                .onMove{
                    temperatures.move(fromOffsets: $0, toOffset: $1)
                }
            }
            .toolbar{
                EditButton()
                
                Button(action: {
                    self.temperatures.append(degree(value: Int.random(in: -50...50)))
                    print(temperatures)
                    }
                    ,label: {Image(systemName: "plus")})
                
            }
        }
    }
}

#Preview{  
    TempView()
    //    .modelContainer(for: degree.self)
}
