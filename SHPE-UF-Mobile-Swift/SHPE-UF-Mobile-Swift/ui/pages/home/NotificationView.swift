//Notification View

//  NotificationView.swift
//  SHPE-UF-Mobile-Swift
//  Created by Matthew Segura on 2/15/24.
//  Simar: 02/29/24 fixed icon clickability issue, added comments throughout code.
import SwiftUI

// Define a view for managing notification settings within the app
struct NotificationView: View {
    // Manage the presentation state of the view
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    // State variables to track which event types are selected for notifications
    @State private var isGBMSelected = false
    @State private var isInfoSelected = false
    @State private var isWorkShopSelected = false
    @State private var isVolunteeringSelected = false
    @State private var isSocialSelected = false
    
    // A flag to manage notification permissions for all event types
    @State private var allowForAll = false
    
    @ObservedObject var viewNotificationModel = NotificationViewModel()
    
    // Adjust text color for dark mode
    var textColor: Color {
        colorScheme == .dark ? .white : Constants.DescriptionTextColor
    }
    
    // Adjust circle and background colors for dark mode
    var circleColor: Color {
        colorScheme == .dark ? .black : Color.gray
    }
    
    var backgroundColor: Color {
        colorScheme == .dark ? Color(red: 0, green: 0, blue: 0.55) : Constants.BackgroundColor
    }
    
    var body: some View {
        // Stack the views vertically with spacing
        VStack(spacing: 20){
            // Use a ZStack for layering the background and button horizontally
            ZStack{
                backgroundColor
                    .frame(height: 93)
                HStack{
                    Button {
                        // Dismiss the current view when the button is pressed
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        // Button label with an image
                        Image("Back")
                            .frame(height:70,alignment: .bottomLeading)
                    }
                    Spacer()
                    // Notification settings title
                    Text("Notification Settings")
                    .font(Font.custom("Viga", size: 24))
                    .foregroundColor(.white)
                    .frame(height: 75, alignment: .bottomLeading)
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
           
            // Stack for the main content area
            ZStack {
                VStack(spacing: 50) {
                    Spacer()
                    // Prompt text for user action
                    Text("Tap an event to get notifications")
                        .font(Font.custom("Viga", size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(textColor)
                        .frame(height: 50, alignment: .bottomLeading)
                    
                    // Horizontal stack for event type buttons
                    HStack(spacing: 30) {
                        // Each event type button with its corresponding label and icon
                        eventButtonSection(eventName: "GBM", eventIcon: "Business_Group", isSelected: $isGBMSelected)
                        eventButtonSection(eventName: "Info Sessions", eventIcon: "Info", isSelected: $isInfoSelected)
                        eventButtonSection(eventName: "Workshops", eventIcon: "Training", isSelected: $isWorkShopSelected)
                    }
                    
                    // Horizontal stack for Volunteering and Socials buttons
                    HStack(spacing: 30){
                        eventButtonSection(eventName: "Volunteering", eventIcon: "Volunteering", isSelected: $isVolunteeringSelected)
                        eventButtonSection(eventName: "Socials", eventIcon: "Users", isSelected: $isSocialSelected)
                    }

                    Spacer()
                    
                    // Button to toggle notifications for all event types
                    Button(action: {
                       allowForAll.toggle()
                       // Update the selection state for all event types
                       isGBMSelected = allowForAll
                       isInfoSelected = allowForAll
                       isWorkShopSelected = allowForAll
                       isVolunteeringSelected  = allowForAll
                       isSocialSelected = allowForAll
                        if allowForAll {
                            viewNotificationModel.turnOnEventNotification(eventType: "GBM")
                            viewNotificationModel.turnOnEventNotification(eventType: "Info")
                            viewNotificationModel.turnOnEventNotification(eventType: "Workshop")
                            viewNotificationModel.turnOnEventNotification(eventType: "Volunteering")
                            viewNotificationModel.turnOnEventNotification(eventType: "Social")
                        } else {
                            viewNotificationModel.turnOffEventNotification(eventType: "GBM")
                            viewNotificationModel.turnOffEventNotification(eventType: "Info")
                            viewNotificationModel.turnOffEventNotification(eventType: "Workshop")
                            viewNotificationModel.turnOffEventNotification(eventType: "Volunteering")
                            viewNotificationModel.turnOffEventNotification(eventType: "Social")
                        }
                            
                    }){
                       ZStack{
                           Rectangle()
                               .foregroundColor(allowForAll ? Color(red: 0.58, green: 0.22, blue: 0.08) : Constants.orange)
                               .frame(width: 254, height: 41)
                               .cornerRadius(30)
                           Text("Allow for all")
                               .font(Font.custom("UniversLTStd", size: 16))
                               .foregroundColor(.white)
                               .frame(width: 106.88688, height: 15.94444, alignment: .topLeading)
                       }
                       .frame(width: 254, height: 41)
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            // Check for notification permission when the view appears
            viewNotificationModel.checkForPermission()
        }
        .background(backgroundColor)
        .edgesIgnoringSafeArea(.all) // Ignore the safe area to extend to the edges
        .navigationBarHidden(true) // Hide the navigation bar for this view
    }

    // Helper function for creating button sections
    private func eventButtonSection(eventName: String, eventIcon: String, isSelected: Binding<Bool>) -> some View {
        VStack(spacing: 20) {
            Button(action: {
                isSelected.wrappedValue.toggle()
                if isSelected.wrappedValue {
                    viewNotificationModel.turnOnEventNotification(eventType: eventName)
                } else {
                    viewNotificationModel.turnOffEventNotification(eventType: eventName)
                }
            }) {
                ZStack {
                    Image(isSelected.wrappedValue ? "Ellipse_selected" : "Ellipse")
                        .frame(width: 92, height: 90)
                        .foregroundColor(circleColor) // Adjusted for dark mode
                    Image(eventIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 42, height: 42)
                }
            }
            Text(eventName)
                .font(Font.custom("UniversLTStd", size: 16))
                .foregroundColor(textColor)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
            .preferredColorScheme(.light) // For light mode preview
        NotificationView()
            .preferredColorScheme(.dark) // For dark mode preview
    }
}
