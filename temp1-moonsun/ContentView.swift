//
//  ContentView.swift
//  temp1-moonsun
//
//  Created by ICS 224 on 2025-04-11.
//

import SwiftUI

struct ContentView: View {
    @State private var images = Array(repeating: Array(repeating: "square", count: 7), count:7)
    @State private var imagesitems = ["sun.max.circle","moon.circle.fill"]
    @State private var itemindex = [0, 1]
    @State private var currentindex = 0
    @State private var counter = [0,0]
    @State private var counterall = 0
    @State private var direction = [[1,0],[0,1],[-1,0],[0,-1]]
  
    var body: some View {
        VStack {
            if(counterall<49){
//
                Image(systemName: imagesitems[currentindex])
                    .resizable()
                    .frame(width:50,height:50)
                    .padding()
                VStack{
                    ForEach(0..<7){ row in
                        HStack{
                            ForEach( 0..<7) { col in
                                Image(systemName: images[row][col])
                                    .resizable()
                                    .frame(width:40,height:40)
                                    .onTapGesture {
                                        if(images[row][col] == "square"){
                                            images[row][col] = imagesitems[currentindex]
                                            counter[currentindex] += 1
                                         
                                            counterall += 1
                                            print(counterall)
                                            
                                            print("position:",row)
                                            print("position:",col)
                                            
                                            for d in direction {
                                                var memoryitems:[[Int]] = []
                                                var nr = row + d[0]
                                                var nc = col + d[1]
                                   
                                                print("checkposition", nr)
                                                print("checkposition", nc)
                                                while(nr >= 0 && nr<7 && nc >= 0 && nc<7){
                                                    if(images[nr][nc] != "square" ){
                                                        if(images[nr][nc] != images[row][col]){
                                                            memoryitems.append([nr,nc])
                                                        }else{
                                                            for it in memoryitems{
                                                                images[it[0]][it[1]] = imagesitems[currentindex]
                                                            }
                                                            counter[currentindex] += memoryitems.count
                                                            counter[(currentindex+1)%2] -= memoryitems.count
                                                            break
                                                        }
                                                        
                                                        nr += d[0]
                                                        nc += d[1]
                                                        print("checkposition", nr)
                                                        print("checkposition", nc)
                                                    }else{
                                                        break
                                                    }
                                                }
                                            }
                                            
                                            currentindex = (currentindex+1)%2
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                }
                .padding()
                HStack{
                    Image(systemName: imagesitems[0])
                    Text("\(counter[0])")
                    Image(systemName: imagesitems[1])
                    Text("\(counter[1])")
                    
                }
            }
            else{
                Text("Game End!")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
