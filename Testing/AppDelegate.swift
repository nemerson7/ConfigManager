//
//  AppDelegate.swift
//  Testing
//
//  Created by admin-test on 1/21/23.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    public var menu: MenuManager!
    private var statusItem: StatusItem!
    public var interactions: Interactions!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        menu = MenuManager()
        interactions = Interactions()
        statusItem = StatusItem()
        menu.rebuild()
        
        statusItem.show()
        
    }
    
    @objc func statusItemClicked(sender: NSStatusBarButton!) {
        let event = NSApp.currentEvent!
        menu.triggerEvent = event
        statusItem.displayMenu(menu.menu)
    }


}

