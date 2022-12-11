import ArgumentParser

struct SwiftCloudCLI: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "A Swift command-line tool to manage Swift Cloud")

    init() { }
}

SwiftCloudCLI.main()
