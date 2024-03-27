import Foundation

enum ShellError: Error {
    case badDataString
}

@discardableResult
func shell(_ command: String) throws -> String {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    // TODO: figure out the user's shell and update this path (bash, ZShell, etc..)
    task.executableURL = URL(fileURLWithPath: "/bin/zsh")
    task.standardInput = nil

    try task.run()
    task.waitUntilExit()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    guard let output = String(data: data, encoding: .utf8) else { throw ShellError.badDataString }
    
    return output
}
