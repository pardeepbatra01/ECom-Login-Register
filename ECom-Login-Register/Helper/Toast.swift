//
//  Toast.swift
//  Demo
//
//  Created by Sushil Chaudhary on 13/09/24.
//
import SwiftMessages

class UtilityClass {

    // Singleton instance to prevent redundant allocations
    static let shared = UtilityClass()
    

    // Private initializer to prevent external instantiation
    private init() {}
    

    // Show toast message with proper memory management
    @MainActor func showToastMessage(
        title: String,
        body: String,
        interactiveHide: Bool = false,
        position: SwiftMessages.PresentationStyle = .top,
        theme: Theme = .warning,
        layout: MessageView.Layout = .messageView
    ) {
        // Return early if no content to display
        if title.isEmpty && body.isEmpty { return }

        // Configuring SwiftMessages appearance and behavior
        var config = SwiftMessages.Config()
        config.presentationStyle = position
        config.presentationContext = .window(windowLevel: .statusBar)
        config.duration = .automatic
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = interactiveHide
        config.preferredStatusBarStyle = .lightContent

        // Using a weak reference to avoid strong capture in the closure
        config.eventListeners.append { [weak self] event in
            if case .didHide = event {
                print("Toast message did hide")
                self?.handleToastDidHide()
            }
        }

        // Creating the message view
        let messageView = MessageView.viewFromNib(layout: layout)
        messageView.configureTheme(theme)
        messageView.configureDropShadow()
        messageView.configureContent(title: title, body: body)

        // Hide the button to make it just a toast
        messageView.button?.isHidden = true

        // Add tap handler to print interaction (weak self used here as well)
        messageView.tapHandler = { [weak self] _ in
            print("\n\nToast message tapped\n\n")
            self?.handleToastTap()
        }

        // Show the message using SwiftMessages
        SwiftMessages.show(config: config, view: messageView)
    }

    // MARK: - Helper Methods

    // Handle event when the toast is tapped
    private func handleToastTap() {
        // Any logic for when the toast is tapped can be added here
        print("Handle additional logic when the toast is tapped.")
    }

    // Handle event when the toast is hidden
    private func handleToastDidHide() {
        // Clean up or release any resources if needed after the toast is hidden
        print("Toast message is fully dismissed and memory is cleaned.")
    }
}
