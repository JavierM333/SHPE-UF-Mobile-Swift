//HOMEPAGE

import SwiftUI

struct HomePageContentView: View {
    @StateObject private var appVM:AppViewModel = AppViewModel.appVM
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab: Int = 0
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var coreEvents: FetchedResults<CalendarEvent>
    
    var body: some View {
        TabView(selection: $selectedTab){
            HomeView(viewModel: HomeViewModel(coreEvents: coreEvents, viewContext: viewContext))
                .tag(0)
                .tabItem {
                    Image(selectedTab == 0 ? "icon_calendar" : colorScheme == .dark ? "unclicked_calendar":"unclicked_calendar_light")
                }
            
            PointsView(vm: PointsViewModel(shpeito: appVM.shpeito))
                .tag(1)
                .tabItem {
                    Image(selectedTab == 1 ? "clicked_leaderboard" : colorScheme == .dark ? "dark_leaderboard":"Leaderboard")
                }
            
            ProfileView(vm: ProfileViewModel(shpeito: appVM.shpeito))
                .tag(2)
                .tabItem {
                    Image(selectedTab == 2 ? "clicked_customer" : colorScheme == .dark ? "dark_customer":"Customer")
                }
        }
    }
}

#Preview {
    HomePageContentView()
}


