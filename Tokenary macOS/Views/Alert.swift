// Copyright © 2021 Tokenary. All rights reserved.

import Cocoa

class Alert: NSAlert {
    
    override func runModal() -> NSApplication.ModalResponse {
        defer {
            Agent.shared.statusBarButtonIsBlocked = false
        }
        Agent.shared.statusBarButtonIsBlocked = true
        return super.runModal()
    }
    
    static func showWithMessage(_ message: String, style: NSAlert.Style) {
        let alert = Alert()
        alert.messageText = message
        alert.alertStyle = style
        alert.addButton(withTitle: Strings.ok)
        _ = alert.runModal()
    }
    
    static func showSafariPrompt() {
        let alert = Alert()
        alert.messageText = "Tokenary now works great in Safari."
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Enable Safari extension")
        alert.addButton(withTitle: Strings.ok)
        if alert.runModal() == .alertFirstButtonReturn {
            Agent.shared.enableSafariExtension()
        }
    }
    
}

class PasswordAlert: Alert {
    
    let passwordTextField: NSSecureTextField = {
        let passwordTextField = NSSecureTextField(frame: NSRect(x: 0, y: 0, width: 160, height: 20))
        passwordTextField.bezelStyle = .roundedBezel
        passwordTextField.isAutomaticTextCompletionEnabled = false
        passwordTextField.alignment = .center
        return passwordTextField
    }()
    
    init(title: String) {
        super.init()
        
        messageText = title
        alertStyle = .informational
        addButton(withTitle: "OK")
        addButton(withTitle: "Cancel")
        accessoryView = passwordTextField
    }
}

class LoadingAlert: Alert {
    
    init(title: String) {
        super.init()
        
        addButton(withTitle: Strings.cancel)
        messageText = title
        let progress = NSProgressIndicator(frame: NSRect(x: 0, y: 0, width: 230, height: 20))
        progress.style = .spinning
        progress.startAnimation(nil)
        accessoryView = progress
    }
}
