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
