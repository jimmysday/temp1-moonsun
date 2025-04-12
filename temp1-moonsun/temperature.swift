import SwiftUI
import SwiftData

//@Observable
@Model
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

struct ModifyTempView: View {
    @Bindable var temperature: degree
    @State private var isEditing = false
    @State private var isValid: Bool = true
    @FocusState private var isDisplay: Bool
    var body: some View {
        
        HStack{
            Slider(
                value: Binding(
                    get:{Double(temperature.value)},
                    set:{newvalue in temperature.value = Int(newvalue)}
                ),
                in: -50...50,
                step: 5
            ) {
                Text("Speed")
            } minimumValueLabel: {
                Text("-50")
            } maximumValueLabel: {
                Text("50")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            .accessibilityIdentifier("TempSlider")
            
            TextField("", text:Binding(
                get:{String(temperature.value)},
                set:{newvalue in
                    if Int(newvalue) ?? 0 > 50 || Int(newvalue) ?? 0 < -50{
                        isValid = false
                        return
                    }
                    else{
                        isValid = true
                    }
                    temperature.value = Int(newvalue) ?? 0}
            ))
            .frame(width: 50)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .background(isValid ? .green : .red)
            .focused($isDisplay)
            .accessibilityIdentifier("TempTextField")

            Button("Keyboard"){
                isDisplay = true
            }
            .accessibilityIdentifier("ShowKeyboardButton")
            
//            .onAppear{isDisplay = true}
//            Text("\(temperature.value)")
//                .foregroundColor(isEditing ? .red : .blue)
            
            Stepper("",
                    value:Binding(
                        get:{temperature.value},
                        set:{newvalue in temperature.value = newvalue}
                    ),
                    in: -50 ... 50,
                    step: 1
            )
            .accessibilityIdentifier("TempStepper")
        }
    }
}

struct TempView: View {
//    @State private var temperatures: [degree] = [degree(value: 21), degree(value: -11), degree(value: 38), degree(value: -7)]
    
    @Query private var temperatures: [degree]
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        NavigationStack{
            List{
                ForEach(temperatures, id: \.id.self){ item in
                    NavigationLink(destination: ModifyTempView(temperature: item)){
                        DetailView(temperature: item)
                    }
                    
                }
                .onDelete{
                    if let index = $0.first{
//                        self.temperatures.remove(at: index)
                        modelContext.delete(temperatures[index])
                        try? modelContext.save()
                    }
                }
//                .onMove{
//                    temperatures.move(fromOffsets: $0, toOffset: $1)
//                }
            }
            .toolbar{
                EditButton()
                
                Button(action: {
//                    self.temperatures.append(degree(value: Int.random(in: -50...50)))
                    modelContext.insert(degree(value: Int.random(in: -50...50)))
                    try? modelContext.save()
                    print(temperatures)
                    }
                    ,label: {Image(systemName: "plus")})
                
            }
        }
    }
}

#Preview{  
    TempView()
        .modelContainer(for: degree.self)
}
