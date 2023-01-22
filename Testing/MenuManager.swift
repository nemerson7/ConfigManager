//
//  MenuManager.swift
//  Testing
//
//  Created by admin-test on 1/21/23.
//

import Cocoa

public class MenuManager {
    @IBOutlet public var menu: NSMenu!
    weak private var delegate: AppDelegate?
    
    public var triggerEvent: NSEvent?
    public var selectedEnv: String
    
    
    init() {
        menu = NSMenu()
        delegate = (NSApplication.shared.delegate as? AppDelegate)!
        selectedEnv = ""
    }
    
    public func rebuild() {
        menu.removeAllItems()
        menu.addItem(NSMenuItem.separator())
        for env in ["dev", "stage", "prod"] {
            let item = NSMenuItem(
                title: env,
                action: #selector(self.delegate!.interactions!.changeEnv(sender:)),
                keyEquivalent: ""
            )
            if env == selectedEnv {
                item.state = NSControl.StateValue.on
            }
            item.target = self.delegate!.interactions!
            menu.addItem(item)
        }
        menu.addItem(NSMenuItem.separator())
        let quit = NSMenuItem(
            title: "quit",
            action: #selector(self.delegate!.interactions!.quit(sender:)),
            keyEquivalent: ""
        )
        quit.target = self.delegate!.interactions!
        menu.addItem(quit)
        
    }
}
