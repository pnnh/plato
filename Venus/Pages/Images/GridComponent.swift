import Combine
import Foundation
import SwiftUI

struct ImagesGridComponent: View {
    @State var active: (Int, Int) = (0, 0)

        func getPath(index: Int) -> String {
            if index % 2 == 0 {
                return "/Users/Larry/Pictures/bear.jpg"
            } else if index % 3 == 0 {
                return "/Users/Larry/Pictures/dog.png"
            } else {
                return "/Users/Larry/Pictures/cplus.jpg"
            }
        }
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {

        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {  // spacing: Gap between items
                ForEach(0..<12, id: \.self) { index in
                    EmoView2(
                        path: getPath(index:index),
                        colWidth: 10
                    )
                    .frame(maxWidth: .infinity)
                    .background(Color.white).cornerRadius(2).overlay(

                        RoundedRectangle(cornerRadius: 2)
                            .stroke(
                                Color.blue,
                                lineWidth: self.active == (0, 0) ? 2 : 0
                            )
                    )
                }
            }
            .padding()
        }
    }

}

class Model: ObservableObject {
    init() {
        print("Model Created")
    }
    @Published var imageText: String = "图片备注"
    @Published var show: Bool = false
}

struct EmoView2: View {

    private var columnWidth: Double
    @State private var model: ImageModel
    @State private var show: Bool = false
    private var path: String

    @State private var windowRef: NSWindow?

    @ObservedObject var model2 = Model()

    init(path: String, colWidth: Double) {
        self.path = path
        self.columnWidth = colWidth
        self.model = ImageModel(Path: path, Text: "新")
        _show = State(initialValue: false)
        print("onAppear \(path)")
    }

    @MainActor func showWindow(imgPath: String) {
        if let existingWindow = windowRef {
            existingWindow.makeKeyAndOrderFront(nil)
            return
        }

        let newWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 600, height: 600),
            styleMask: [
                .titled, .closable, .miniaturizable, .resizable,
                .fullSizeContentView,
            ],
            backing: .buffered,
            defer: false
        )
        newWindow.contentView = NSHostingView(
            rootView: PSImageComponent(imagePath: imgPath)
        )
        
        newWindow.center()
        newWindow.isReleasedWhenClosed = false  // 阻止窗口关闭时被释放，否则可能遇到空指针错误
        newWindow.makeKeyAndOrderFront(nil)
        windowRef = newWindow  // Store the strong reference

    }

    func getNSImage() -> ImageWrapper? {

        if model.Path == "" {
            return nil
        }
        var imgPath = self.path
        if !imgPath.hasPrefix("/") {
            imgPath = "Documents/\(self.model.Path)"
        }
        print("aaa \(self.model) \(imgPath)")

        if let nsImg = NSImage(contentsOfFile: imgPath) {
            //print("width height \(nsImg.size.width) \(nsImg.size.height)")
            let width = CGFloat(columnWidth)
            let height =
                CGFloat(columnWidth) / nsImg.size.width * nsImg.size.height
            //print("width2 \(height)")

            return ImageWrapper(
                Image: nsImg,
                width: width,
                height: height,
                filePath: imgPath
            )

        }

        return nil

    }

    var body: some View {
        VStack(alignment: .center, spacing: nil) {

            if let nsImg = getNSImage() {
                Spacer(minLength: 0)
                HStack(alignment: .center) {
                    Spacer(minLength: 0)
                    Button(action: {
                        print("jjjdfs3")
                        self.model2.show.toggle()
                        self.show.toggle()
                        self.showWindow(imgPath: self.path)
                    }) {
                        Image(nsImage: nsImg.Image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)  //.background(Color.pink)
                            .frame(maxWidth: .infinity)  //.border(Color.gray, width: 0.5)
                        //.frame(width: nsImg.width, height: nsImg.height)

                    }.buttonStyle(EmptyButtonStyle())
                    Spacer(minLength: 0)
                }  //
                Spacer(minLength: 0)
                HStack {
                    Text("图片备注").foregroundColor(Color.gray)
                        .font(Font.system(size: 10, design: .default))
                    Spacer()
                }.padding(2)  //.frame(height:20)
            }
        }

    }

}

struct ImageWrapper {
    var Image: NSImage
    var width: CGFloat
    var height: CGFloat
    var filePath: String
}

struct EmptyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
