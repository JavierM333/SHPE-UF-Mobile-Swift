//
//  SHPEUFAppViewModel.swift
//  SHPE-UF-Mobile-Swift
//
//  Created by Daniel Parra on 3/9/24.
//

import Foundation

class AppViewModel: ObservableObject
{
    static let appVM = AppViewModel()
    @Published var pageIndex:Int
    @Published var shpeito:SHPEito
    
    private init() {
        self.pageIndex = -1
        self.shpeito = SHPEito()
    }
    
    public func setPageIndex(index:Int)
    {
        self.pageIndex = index
    }
}