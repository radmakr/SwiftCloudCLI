import ArgumentParser

struct SwiftCloudCLI: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to manage Swift Cloud") //,
//        subcommands: [Build.self])
    
    @Argument(help: "Build for WASM")
    private var build: String
    
    init() { }
    
    func run() throws {
        do {
            try compile()
        } catch {
            print("Error building")
        }
    }
    
    private func compile() throws {
        try shell("swift build -c debug --triple wasm32-unknown-wasi")
    }
    
    private func runLocally() throws {
        // TODO: get the project name
        try shell("fastly compute serve --skip-build --file ./.build/debug/BarstoolTV-BFF.wasm")
    }
}

SwiftCloudCLI.main()

//struct Build: ParsableCommand {
//    public static let configuration = CommandConfiguration(abstract: "Build Swift Cloud Locally")
//    
//    @Argument(help: "Build for WASM")
//    private var build: String
//    
//    func run() throws {
//        do {
//            try shell("ls")
//        } catch {
//            print("Error building")
//        }
//    }
//}
