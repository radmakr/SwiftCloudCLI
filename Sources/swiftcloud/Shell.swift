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
    
    // Fallback to a default shell if SHELL environment variable is not set
    // in this case zsh because MacOS defaults to zsh
    let shellPath = ProcessInfo.processInfo.environment["SHELL"] ?? "/bin/zsh"
    task.executableURL = URL(fileURLWithPath: shellPath)
    
    task.standardInput = nil
    try task.run()
    task.waitUntilExit()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    guard let output = String(data: data, encoding: .utf8) else { throw ShellError.badDataString }
    
    return output
}
