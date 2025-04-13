import SwiftUI

struct SampleView: View {
    
    @State private var number = [0,1,2,3,4,5,6]
    @State private var images: [[String]] = Array(repeating: Array(repeating:"square",count:7),count:7)
    
    @State private var vibrateOnRing: Bool = false
    
    @State private var sliderVal1: Int = 7
    
    @State private var isEditing: Bool = false
    
    @State private var postalCode: String = ""
    
    @State private var text:String = " "
    
    @State private var lines:String = " "

    var body: some View {
        VStack{ 
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

            TextField("",text:Binding(
                get: {String(sliderVal1)},
                set: { newvalue in
                    sliderVal1 = Int(newvalue) ?? 7
                }))
                .border(.black, width: 2)

            SecureField("Secure Line of Text", text: $text)
            TextEditor(text: $lines)
             .border(.black, width: 2)
            
            Stepper("",//\(sliderVal1) Rows/Columns",
                    value: Binding(get: {
                sliderVal1
            }, set: { newValue in
                sliderVal1 = newValue
                UserDefaults.standard.set(sliderVal1, forKey: "rowVal")
            }),
                    in: 2...10)
            .accessibilityIdentifier("settingStepperRow")
            
            
            Slider(
                value: Binding(
                    get:{Double(sliderVal1)},
                    set:{newvalue in sliderVal1 = Int(newvalue)}
                ),
                in: 0...100,
                step: 5
            ) {
                Text("Speed")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("100")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            Text("\(sliderVal1)")
                .foregroundColor(isEditing ? .red : .blue)

            PostalCodeField(postalCode: $postalCode)

        }
    }
}

struct PostalCodeField: View {
    @Binding var postalCode: String
    @State private var error = false
    var body: some View {
    VStack{
        TextField(
            "Postal Code",
            text: Binding(
                    get: {
                        postalCode
                    },
                    set: {
                        newValue in
                        let regex = /[A-Z]\d[A-Z]\s*\d[A-Z]\d/
                        error = newValue.wholeMatch(of: regex) == nil
                        postalCode = newValue
                    }
                )
            )
            if error {
                Text("Invalid Postal Code")
            }
        }
    }
}

struct ForEachView: View {
    @State private var capitals = ["Victoria", "Edmonton"]
    var body: some View {
        VStack {
            List {
                ForEach(capitals, id: \.self) { capital in
                    Text(capital)
                }
            }
        }
        .padding()
    }
}

#Preview {
    SampleView()
}
