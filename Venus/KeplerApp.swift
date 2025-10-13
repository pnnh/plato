import Cocoa
import SwiftUI
import AppKit
import MTKepler
import Logging
import SwiftData

@main
struct KeplerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
//    var window: PSMainWindow!


//    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        // Create the SwiftUI view that provides the window contents.
//        //let contentView = ContentView()
////        let contentView = GridLayoutView()
//        let contentView = PSMainView()
//
//        window = PSMainWindow(
//            contentRect: NSRect(x: 0, y: 0, width: PSMainWindow.minWinSize.width, height: PSMainWindow.minWinSize.height),
//            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
//            backing: .buffered, defer: false)
//        window.isReleasedWhenClosed = false
//        window.center()
//        window.setFrameAutosaveName("Main Window")
//        window.contentView = NSHostingView(rootView: contentView)
//        window.makeKeyAndOrderFront(nil)
//        
//        // 尝试调用C++侧的日志打印
//        MTKepler.quark.Logger.LogInfo("Call From Swift")
//        
//        // 尝试调用SPM里的Swift-log来打印日志
//        let logger = Logger(label: "xyz.huable.venus.main")
//        logger.info("Hello Venus")
//    }
    @ObservedObject var router = Router()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                PSMainView()
               .navigationDestination(for: Router.Destination.self) { destination in
                   switch destination {
                   case .files:
                       PSFilesView().navigationBarBackButtonHidden(true)
                   case .notes(_):
                       PSNotesView(ownerName: "xxxNotes").navigationBarBackButtonHidden(true)
                   case .images:
                       PSImageView().navigationBarBackButtonHidden(true)
                   default:
                       PSMainView().navigationBarBackButtonHidden(true)
                   }
               }
           }.padding(0)
            .frame(width: 1024, height: 750)  // 高度减去标题栏
           .environmentObject(router)
        }
        .windowStyle(.hiddenTitleBar)
        .modelContainer(sharedModelContainer)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
//    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
     
//        window = NSWindow(
//            contentRect: NSRect(x: 0, y: 0, width: 1024, height: 768),
//            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
//            backing: .buffered, defer: false)
//        
//        window.center()
//        window.title = "Venus"
//        
//        window.titlebarAppearsTransparent = true
//        window.titleVisibility = .hidden
//        
//        let toolbar = NSToolbar(identifier: "VenusToolbar")
//        window.toolbar = toolbar
//        
//        let contentView = ContentView()
//        window.contentViewController = NSHostingController(rootView: contentView)
//        
//        window.makeKeyAndOrderFront(nil)
        
    }
}
