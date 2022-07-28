//
//  Home.swift
//  UI-624
//
//  Created by nyannyan0328 on 2022/07/28.
//

import SwiftUI

struct Home: View {
    @Namespace var animation
    @State var currentType : BreathType = sampleTypes[0]
    
    @State var startAnimation : Bool = false
    @State var ShowbretheView : Bool = false
    
    @State var timerCount : CGFloat = 0
    @State var bretheString : String = "Breath In"

    @State var count : Int = 0
    
    
    
    
    var body: some View {
        ZStack{
            
            
            BGView()
            
            Content()
            
            Text(bretheString)
                .font(.largeTitle)
                .frame(maxHeight: .infinity,alignment: .top)
                .padding(.top,100)
                .opacity(ShowbretheView ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: ShowbretheView)
                .animation(.easeInOut(duration: 1), value: bretheString)
            
            
        }
        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
            
            if ShowbretheView{
                
                if timerCount >= 3.2{
                    
                    timerCount = 0
                    
                    bretheString = (bretheString ==  "Breath In" ? "Breath End" : "Breath In")
                    withAnimation(.easeInOut(duration: 3)){
                        
                        startAnimation.toggle()
                    }
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
 
                    
                }
                else{
                    
                    timerCount += 0.01
                }
                
                count = 3 - Int(timerCount)
                
                
            }
            else{
                
                timerCount = 0
                
                
            }
            
        }
    }
    @ViewBuilder
    func BGView()->some View{
        
        GeometryReader{proxy in
            
             let size = proxy.size
            
            Image("BG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width,height: size.height)
                .overlay {
                    
                    Rectangle()
                        .fill(
                        
                            LinearGradient(colors: [
                                currentType.color.opacity(0.6),
                                .clear,
                                .clear,
                                .clear,
                            
                            
                            ], startPoint: .top, endPoint: .bottom)
                            
                        
                        )
                       
                        .frame(height:size.height / 1.8)
                        .frame(maxHeight:.infinity,alignment: .top)
                    
                    
                    Rectangle()
                        .fill(
                        
                            LinearGradient(colors: [
                                .clear,
                                .black,
                                .black,
                                .black,
                                .black,
                                .black,
                            
                            
                            ], startPoint: .top, endPoint: .bottom)
                            
                        
                        )
                       
                        .frame(height:size.height / 1.5)
                        .frame(maxHeight:.infinity,alignment: .bottom)
                    
                    
                    
                }
                
             
        }
        .ignoresSafeArea()
    
        
        
    }
    @ViewBuilder
    func Content()->some View{
        
        VStack{
            
            HStack{
                
                
                Text("Breath")
                    .font(.title2.weight(.bold))
                    .foregroundColor(.white)
                      .frame(maxWidth: .infinity,alignment: .leading)
                
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "suit.heart.fill")
                        .font(.title)
                        .padding(15)
                        .background{
                         
                            RoundedRectangle(cornerRadius: 10,style: .continuous)
                                .fill(.ultraThinMaterial)
                        }
                }

                
            }
            .foregroundColor(.white)
            .opacity(ShowbretheView ? 0 : 1)
            .padding()
            
           
                GeometryReader{proxy in
                    
                     let size = proxy.size
                    
                    VStack{
                    
                    BretheView(size : size)
                        
                        
                        Text("Breathe To Reduse")
                            .foregroundColor(.white)
                            .opacity(ShowbretheView ? 0 : 1)
                        
                        ScrollView(.horizontal,showsIndicators: false){
                            
                            HStack{
                                
                                ForEach(sampleTypes){type in
                                    
                                    
                                    Text(type.title)
                                        .foregroundColor(currentType.id == type.id ? .black : .white)
                                        .padding(.vertical,10)
                                        .padding(.horizontal)
                                        .background{
                                         
                                            if currentType.id == type.id{
                                                
                                                RoundedRectangle(cornerRadius: 10,style: .continuous)
                                                    .fill(.white)
                                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                                
                                                
                                            }
                                            else{
                                                
                                                RoundedRectangle(cornerRadius: 10,style: .continuous)
                                                    .stroke(.white)
                                                
                                                
                                            }
                                        }
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            
                                            withAnimation(.easeInOut){
                                                
                                                currentType = type
                                            }
                                        }
                                    
                                }
                                
                                
                            }
                            .padding()
                            
                            
                        }
                        .opacity(ShowbretheView ? 0 : 1)
                        
                        
                        Button {
                            
                            AnimationProperties()
                            
                        } label: {
                            
                            Text(ShowbretheView ? "Finish" : "START")
                                .font(.title)
                                .foregroundColor(ShowbretheView ? .white : .black)
                                .frame(maxWidth:.infinity)
                                .padding(.vertical,20)
                                .background{
                            
                                    if ShowbretheView{
                                        
                                        RoundedRectangle(cornerRadius: 10,style: .continuous)
                                            .stroke(currentType.color)
                                            
                                    }
                                    else{
                                        
                                        RoundedRectangle(cornerRadius: 10,style: .continuous)
                                            .fill(currentType.color)
                                            
                                    }
                                }
                            
                        }
                        .padding()

                        
                }
                    .frame(width: size.width,height: size.height,alignment:.bottom)
                
            }
          
            
            
            
        }
        .frame(maxHeight:.infinity,alignment: .top)
       
        
        
    }
    @ViewBuilder
    func BretheView(size : CGSize)->some View{
        
        ZStack{
            
            ForEach(1...8,id:\.self){index in
                
                Circle()
                    .fill(currentType.color.opacity(0.3))
                    .frame(width: 150,height: 150)
                    .offset(x:startAnimation ? 0 : 75)
                    .rotationEffect(.init(degrees: Double(index * 45)))
                    .rotationEffect(.init(degrees: startAnimation ? -45 : 0))
                    
            }
        }
       
        .scaleEffect(startAnimation ? 0.7 : 1)
        .overlay {
            
            Text("\(count == 0 ? 1 : count)")
                .font(.title2.bold())
                .foregroundColor(.white)
                .animation(.easeInOut,value: ShowbretheView)
                .opacity(ShowbretheView ? 1 : 0)
        }
        .frame(height:size.width - 40)
        
        
        
    }
    func AnimationProperties(){
        
        withAnimation(.interactiveSpring(response: 0.6,dampingFraction:0.6,blendDuration: 0.6)){
            
            ShowbretheView.toggle()
        }
        
        if ShowbretheView{
            
            
            withAnimation(.easeInOut(duration: 3).delay(0.05)){
                startAnimation = true
            }
        }
        else{
            withAnimation(.easeInOut(duration: 1.5)){
                startAnimation = false
            }
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
