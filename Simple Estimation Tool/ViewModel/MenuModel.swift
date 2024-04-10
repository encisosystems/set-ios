//
//  MenuModel.swift
//  Simple Estimation Tool
//
//  Created by andres felipe on 8/04/24.
//

import SwiftUI

class MenuViewModel: ObservableObject{
    
    @Published var selectedMenu = "Home"
    
    @Published var showDrawer = false
}
