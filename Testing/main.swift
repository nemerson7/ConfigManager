//
//  main.swift
//  Jumpcut
//
//

/* Full nibless setup; thanks to Łukasz Adamczak's handy tutorial!
 https://czak.pl/2015/09/23/single-file-cocoa-app-with-swift.html
 */
import Cocoa
let delegate = AppDelegate()
NSApplication.shared.delegate = delegate
NSApp.setActivationPolicy(.accessory)
NSApp.run()
