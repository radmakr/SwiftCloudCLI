import ArgumentParser

#warning("Complete this list of todos")
// TODO: create an argument to init a swift cloud project
// This will call this shell command `swift package init --type executable`
// modify the package.swift file to include .package(url: "https://github.com/swift-cloud/Compute", from: "2.3.0") as a dependency
// and .executableTarget(
//          name: "MyApp",
//          dependencies: ["Compute"]
//          )
// This should also use Carton to set the swift WASM version for the project
// Is modifying the package.swift file possible via this CLI tool?

// TODO: create an argument to build the project via this shell command `swift build -c debug --triple wasm32-unknown-wasi`
// TODO: create an argument to run the project locally via `fastly compute serve --skip-build --file ./.build/debug/BarstoolTV-BFF.wasm`
// TODO: create an argument to create a fastly.toml file and an env.json file (add env.json to gitignore)
// TODO: make it possible to install swiftcloud via homebrew - brew install swiftcloud
// This should also install carton and fastly CLI

struct SwiftCloudCLI: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to manage Swift Cloud",
        subcommands: [
            `Init`.self,
            Build.self,
            Run.self
        ])
    
    init() { }
}

SwiftCloudCLI.main()

struct `Init`: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Create a new Swift Cloud project")
    
    @Option(wrappedValue: true, name: .shortAndLong, help: "Set this option to false to prevent a git repo from being created")
    private var includeGit: Bool
    
    func run() throws {
        do {
            let output = try shell("swift package init --type executable")
            print(output)
            
            if includeGit {
                let gitOutput = try shell("git init")
                print(gitOutput)
            }
        } catch {
            print("There was an error: \(error.localizedDescription)")
        }
    }
}

struct Build: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Build Swift Cloud")
    
    func run() throws {
        do {
            let output = try shell("swift build -c debug --triple wasm32-unknown-wasi")
            print(output)
        } catch {
            print("Error building")
        }
    }
}

struct Run: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Run Swift Cloud Locally")
    
    @Argument(help: "The target name for you executable")
    private var name: String
    
    func run() throws {
        do {
            let output = try shell("fastly compute serve --skip-build --file ./.build/debug/\(name).wasm")
            print(output)
        } catch {
            print("Error running")
        }
    }
}
