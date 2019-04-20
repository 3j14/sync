//
//  StatusMenuController.swift
//  sync
//
//  Created by Jonas Drotleff on 03.01.19.
//  Copyright © 2019 Jonas Drotleff. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    @IBOutlet weak var itemOne: NSMenuItem!
    @IBOutlet weak var itemTwo: NSMenuItem!
    
    var isRunning: Bool = false
    
    override func awakeFromNib() {
        let icon = NSImage(named: NSImage.refreshFreestandingTemplateName)
        icon?.isTemplate = true
        statusItem.button?.image = icon
        statusItem.menu = statusMenu
    }
    
    @IBAction func itemClicked(sender: NSMenuItem) {
        if isRunning {
            print("Process is still running")
            return
        }
        
        let task: Process = Process()
        task.launchPath = Bundle.main.path(forResource: "sync_files", ofType: "sh")
        task.arguments = []
        
        if sender == itemOne {
            // TODO: change SOURCE and DEST
            task.arguments?.append("[SOURCE]")
            task.arguments?.append("[DEST]")
            sender.state = NSControl.StateValue.on
        } else if sender == itemTwo {
            // TODO: change SOURCE and DEST
            task.arguments?.append("[SOURCE]")
            task.arguments?.append("[DEST]")
            sender.state = NSControl.StateValue.on
        } // ... etc.
        else {
            return
        }
        task.terminationHandler = { (process) in
            self.isRunning = false
            self.itemOne?.isEnabled = true
            self.itemTwo?.isEnabled = true
            
            // Send notification
            let notification = NSUserNotification()
            notification.title = "Sync"
            notification.subtitle = "Done! Sync has been completed"
            notification.soundName = NSUserNotificationDefaultSoundName
            NSUserNotificationCenter.default.deliver(notification)
            
            sender.state = NSControl.StateValue.off
        }
        
        self.itemOne?.isEnabled = false
        self.itemTwo?.isEnabled = false
        
        isRunning = true
        
        do {
            try task.run()
        } catch let err as NSError {
            print("Something went wrong")
            print(err)
        }
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        if isRunning && !closeDialog(){
            return
        }
        NSApplication.shared.terminate(self)
    }
    
    func closeDialog() -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = "Sync is running"
        alert.informativeText = "It appears a process is still running."
        alert.alertStyle = NSAlert.Style.warning
        alert.addButton(withTitle: "Close anyway")
        alert.addButton(withTitle: "Cancel")
        let res = alert.runModal()
        if res == NSApplication.ModalResponse.alertFirstButtonReturn {
            return true
        }
        return false
    }
    

}
