//
//  Interactions.swift
//  Testing
//
//  Created by admin-test on 1/21/23.
//

import Cocoa

public class Interactions: NSObject {
    
    weak private var delegate: AppDelegate?
    
    private var basePath: String
    
    @objc public func changeEnv(sender: NSMenuItem) {
        let env = sender.title
        delegate?.menu.selectedEnv = env
        delegate?.menu.rebuild()
        
        //logic to move files around
        
        assertDirectoriesExist(env: env)
        let filemanager:FileManager = FileManager()
        let currPath = basePath + env
        let files = filemanager.enumerator(atPath: currPath)
        while let file = files?.nextObject() as? String{
            let tmpPath = currPath + "/" + file
            do {
                let content = try String(contentsOfFile: tmpPath, encoding: String.Encoding.utf8)
                let destPath = basePath + file
                do {
                    try content.write(toFile: destPath, atomically: false, encoding: .utf8)
                } catch {
                    exit(1);
                }
            } catch {
                exit(1);
            }
        }
    }
    
    @objc public func quit(sender: NSMenuItem) {
        exit(1);
    }
    
    private func assertDirectoriesExist(env: String) {
        var isDir:ObjCBool = true
        if !FileManager.default.fileExists(atPath: basePath, isDirectory: &isDir) {
            /*
            do {
                try FileManager.default.createDirectory(at: URL(string: basePath)!, withIntermediateDirectories: true)
            } catch {
                exit(1)
            }
             */
            exit(1)
        }
        let path = basePath + env
        if !FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
            /*
            do {
                try FileManager.default.createDirectory(at: URL(string: path)!, withIntermediateDirectories: true)
            } catch {
                exit(1)
            }
             */
            exit(1)
        }
    }
    
    override init() {
        delegate = (NSApplication.shared.delegate as? AppDelegate)!
        basePath = FileManager.default.homeDirectoryForCurrentUser.path + "/secrets/"
    }
}
