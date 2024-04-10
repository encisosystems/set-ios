//
//  Drawer.swift
//  Simple Estimation Tool
//
//  Created by andres felipe on 8/04/24.
//

import SwiftUI

struct Drawer: View{
    
    @EnvironmentObject var menuData: MenuViewModel
    
    var animation: Namespace.ID
    
    var body: some View{
        VStack{
            HStack{
                
                Spacer()
                
                
                if menuData.showDrawer{
                    DrawerCloseButton(animation: animation)
                }
            }
            .padding()
            VStack(alignment: .leading, spacing: 10, content: {
                Text("SET")
                    .font(.title)
                    .fontWeight(.heavy)
                    
            })
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top,5)
            
            VStack(spacing: 22){
                
                MenuButton(name: "Home", image: "house.fill", selectedMenu: $menuData.selectedMenu, animation: animation)
                
                MenuButton(name: "Acerca de", image: "info.circle.fill", selectedMenu: $menuData.selectedMenu, animation: animation)
            }
            .padding(.leading)
            .frame(width: 250, alignment: .leading)
            .padding(.top,30)
            
            Spacer()
        }
        .frame(width: 250)
        .background(Color(red:0, green: 0, blue: 0.20)
                .ignoresSafeArea(.all, edges:.vertical)
        )
    }
}


struct DrawerCloseButton: View{
    
    @EnvironmentObject var menuData: MenuViewModel
    
    var animation: Namespace.ID
    
    var body: some View{
        Button(action: {
            withAnimation(.easeInOut){
                menuData.showDrawer.toggle()
            }
        }, label: {
           
            VStack(spacing: 5){
                
                Capsule()
                    .fill(menuData.showDrawer ? Color.white : Color.primary)
                    .frame(width: 35, height: 3)
                    .rotationEffect(.init(degrees: menuData.showDrawer ? -50 : 0))
                
                    .offset(x: menuData.showDrawer ? 2 : 0, y: menuData.showDrawer ? 9 : 0)
                
                VStack(spacing: 5){
                    
                    Capsule()
                        .fill(menuData.showDrawer ? Color.white : Color.primary)                        .frame(width: 35, height: 3)
                    
                    Capsule()
                        .fill(menuData.showDrawer ? Color.white : Color.primary)                        .frame(width: 35, height: 3)
                    
                        .offset(y: menuData.showDrawer ? -8 : 0)
                }
                
                .rotationEffect(.init(degrees: menuData.showDrawer ? 50 : 0))
            }
        })
        .scaleEffect(0.8)
        .matchedGeometryEffect(id: "MENU_BUTTON", in: animation)
    }
}
