import Foundation
import SwiftUI
import Combine 

struct PSNotesView: View {
    @EnvironmentObject var router: Router
    var ownerName: String
    
    
    var body: some View {
            VStack{
                PSNavbarComponent()
                
                Button("\(ownerName) Home") {
                    router.navigate(to: .home)
                }
                .padding(.top, 12)
            }
            .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            ).padding(0)
            .background(Color.purple)
    }
 
}


#Preview {
    PSNotesView(ownerName: "xxxxPreview")
        .modelContainer(for: Item.self, inMemory: true)
}
