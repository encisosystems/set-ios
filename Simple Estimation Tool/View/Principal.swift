import SwiftUI


struct PrincipalView: View{
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    @StateObject var menuData = MenuViewModel()
    
    @Namespace var animation
    
    var body: some View{
        
        HStack(spacing: 0){
            Drawer(animation: animation)
            
            TabView(selection: $menuData.selectedMenu){
                
                EstimationToolView()
                    .tag("Home")
                About()
                    .tag("Acerca de")
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .frame(width: UIScreen.main.bounds.width)
        .offset(x: menuData.showDrawer ? 125 : -125)
        .overlay(
            ZStack{
                if !menuData.showDrawer{
                    DrawerCloseButton(animation: animation)
                        .padding()
                }
            },
            alignment: .topLeading
        )
        .environmentObject(menuData)
    }
}


struct PrincipalView_Previews:PreviewProvider{
    static var previews:some View{
        PrincipalView()
    }
}
