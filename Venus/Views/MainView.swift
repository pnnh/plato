import SwiftData
import SwiftUI

struct PSMainView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var router: Router

    var body: some View {

        Grid {
            GridRow {
                VStack {
                    Image(.files)
                        .font(.system(size: 56))
                        .foregroundColor(.accentColor)
                    Text("资源管理器")
                        .onTapGesture {
                            print("Double tapped!")
                            router.navigate(to: .files)
                        }
                }
                VStack {
                    Image(.notes)
                        .font(.system(size: 56))
                        .foregroundColor(.accentColor)
                    Text("笔记管理")
                        .onTapGesture {
                            print("Double tapped!")
                            router.navigate(to: .notes(owner: "详细信息"))
                        }
                }
                VStack {
                    Image(.images)
                        .font(.system(size: 56))
                        .foregroundColor(.accentColor)
                    Text("图片管理")
                        .onTapGesture {
                            print("Double tapped!")
                            router.navigate(to: .images)
                        }
                }
            }
        }
        .padding()
    }
}

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

#Preview {
    PSMainView()
        .modelContainer(for: Item.self, inMemory: true)
}
