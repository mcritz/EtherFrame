//
//  File.swift
//  
//
//  Created by Michael Critz on 10/14/19.
//

// #!/usr/bin/env swift

import Foundation

struct ImageRenderer {
    
    func display(_ path: URL) throws -> Int32 {
        do {
            return shell(["sudo", "IT8951", "0", "0", path.absoluteString])
        } catch {
            fatalError("Video driver failed to render")
        }
    }
    
    @discardableResult
    private func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
}
