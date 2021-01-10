import Foundation

enum Errors {
    
    /** Setup a new method to notify the user for errors */
    func notify() {

        /** New process */
        let process = Process()
        
        /** Set the path for launching */
        process.launchPath = launchPath
        
        /** Require arguments for the app */
        process.arguments = arguments
        
        /** New workflow pipe */
        let pipe = Pipe()

        /** Set pipe errors to stdout */
        process.standardOutput = pipe
        
        /** Launch the process */
        process.launch()
    }
    
    /**
     * Chek if OS is linux
     * Then setup the net path
     */
    private var launchPath: String {
        #if os(Linux)
        return "notify-send"
        #else
        return "/usr/bin/osascript"
        #endif
    }
    
    /** Project banner for the process start */
    private var arguments: [String] {
        #if os(Linux)
        return ["Bento Blockchain Network", self.description]
        #else
        return ["-e", "display notification \"Server started on port: 5000\""]
        #endif
    }
    
    /** Setup the agrigates */
    case serverStarted(onPort: Int)
    case serverStopped
    
    /** Check if the server is stoppped */
    private var description: String {
        switch self {
        case .serverStarted(let onPort):
            return "Server started on port:\(onPort)"
        case .serverStopped:
            return "Server stopped"
        }
    }
}
