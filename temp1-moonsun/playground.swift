import SwiftUI
struct PlaygroundView: View {
    var body: some View {
        Button(action:{
            print(sameints(list:[1,2,3,4,3,2]))
            print(sameints(list:[5,5,5,5,5,5]))

            print(sameints_reduce(list:[1,2,3,4,3,2]))
            print(sameints_reduce(list:[5,5,5,5,5,5]))
            
            print("single peak: " , singlepeak(list:[1,2,3,4,1,2]))
            print("single peak reduce: " , singlepeak_reduce(list:[1,2,3,4,1,2]))

            var arr:[Int] = [2,3,4,5,6]

            print(arr.reduce(0,{x,y in x+y}))

            print(arr.reduce(0,{$0 + $1}))

            print(arr.reduce(0) { $0 + $1 })
            print(arr.reduce(0) { x,y in x + y })
            print(arr.reduce(true) { $0 && $1 == arr.first })

            let gpa = 9.0
            print("My GPA is \(gpa)")
            print("My GPA is", gpa)
            print("My GPA is " + String(gpa))
            print("My GPA is", gpa, separator:"...", terminator:"!")// Prints out "My GPA is...9.0!"


            var statHolidays: [String] = []
            statHolidays.append("Christmas")
            statHolidays += ["Boxing Day", "New Year's Day", "FamilyDay"]
          
            statHolidays.insert("Remembrance Day", at: 0)
   
            statHolidays.remove(at: 0)

            for i in 0...10 {
             print(i)
            }

            for j: UInt in stride(from:10, through:100, by:10) {
            print(j)
            }
    
            for j: UInt in stride(from:10, to:100, by:10) {
            print(j)
            }

            var i: UInt = 0
            repeat {
            i += 1
            } while i < 100
            print(i)



          let temperature = 10
          print("\(temperature)\u{00B0}") // Output: 10°
          print("\(temperature)°") // Output: 10°

          let list = [1,2,3,4,5]
          let x = list.map { if $0 % 2 == 0 { "Even" } else { "Odd" }}

          let s = ["1", "2", "3"]
          print( s.joined(separator: " ")) 

          var marks = [nil, 9, 10, 1, 9, 8]
          let (total, count) = marks.reduce((0, 0)) {
            let (sum, cnt) = $0
            if $1 == nil {
              return (sum, cnt)
            }
            return (sum + $1!, cnt + 1)
          }
          if (count > 0) {
            print("Average is", Double(total) / Double(count))
          }

            var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
          for day in days {
            print(day, terminator:": ")
            switch day {
              case "Monday" :
              print("The work week begins...")
              case "Friday":
              print("The work week ends...")
              case "Saturday":
              fallthrough
              case "Sunday":
              print("Weekend...")
              default :
              print("")
            }
          }

          //import UIKit // Required for URL below
          func download(url: URL?) -> String {
            if url != nil {
              do {
                return try String(contentsOf: url!)
              }
              catch { // catch == catch let error
                return "Error: \(error)"
              }
            }
            return ""
          }
          print(download(url: URL(string:"http://deepblue.cs.camosun.bc.ca")))


        },label:{
            Text("Run")
        })
    }
}
//exercise 1
func sameints(list:[Int])->Bool {
  if (list.count < 2){
    return true
  }

  for i in 1 ..< list.count {
    if(list[i] != list[0])
    {
      return false
    }
  }
  return true
}

func sameints_reduce(list:[Int])->Bool{
  if(list.count < 2) {
    return true
  }

  //return list.reduce(true) { $0 && $1 == list.first }
  //return list.reduce(x = true, {x,y in x && y != y+1})
 return list.reduce(true) { resultSoFar, currentElement in
    resultSoFar && currentElement == list.first
  }
}



//exercise 2
func singlepeak(list:[Int])->Bool {
  if(list.count < 2){
    return true
  }

  enum direction{
    case starting
    case rising
    case falling
  }

  var d = direction.starting
  var haspeak: Bool = false

  for i in 1 ..< list.count {
    if list[i] > list[i-1] {
      if(d ==  direction.starting){
        d = .rising
      }
      if(d == .falling){
        if(haspeak){
          return false
        }else{
          haspeak = true
          d = .rising
        }        
      }
    }else if list[i] < list[i-1]{
      if(d == .starting){
        d = .falling
      }
      if(d == .rising){
        if(haspeak){
          return false
        }else{
          haspeak = true
          d = .falling
        }
      }
    }
  }
  if(haspeak || d != .starting){
    return true
  }
  else{
    return false
  }
}

func singlepeak_reduce(list:[Int])->Bool {
  if(list.count < 2){
    return true
  }

  enum direction{
    case starting
    case rising
    case falling
  }

  var d = direction.starting
  var haspeak: Bool = false
  //var prev = list[0]

  let (singlepeak,_) = list.reduce((false,list[0])) {
    let(result,prev) = $0
    if $1 > prev {
      if(d ==  direction.starting){
        d = .rising
      }
      if(d == .falling){
        if(haspeak){
          return (false, prev)
        }else{
          haspeak = true
          d = .rising
        }        
      }
    }else if $1 < prev{
      if(d == .starting){
        d = .falling
      }
      if(d == .rising){
        if(haspeak){
          return (false, prev)
        }else{
          haspeak = true
          d = .falling
        }
      }
    }
    return (haspeak,prev)

  }
  if(singlepeak || d != .starting){
    return true
  }
  else{
    return false
  }
  // for i in 1 ..< list.count {
  //   if list[i] > list[i-1] {
  //     if(d ==  direction.starting){
  //       d = .rising
  //     }
  //     if(d == .falling){
  //       if(haspeak){
  //         return false
  //       }else{
  //         haspeak = true
  //         d = .rising
  //       }        
  //     }
  //   }else if list[i] < list[i-1]{
  //     if(d == .starting){
  //       d = .falling
  //     }
  //     if(d == .rising){
  //       if(haspeak){
  //         return false
  //       }else{
  //         haspeak = true
  //         d = .falling
  //       }
  //     }
  //   }
  // }
  // if(haspeak || d != .starting){
  //   return true
  // }
  // else{
  //   return false
  // }
}


#Preview{
    PlaygroundView()
}
