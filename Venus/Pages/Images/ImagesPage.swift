import Foundation
import SwiftUI
import Combine 

struct PSImagePage: View {
    @EnvironmentObject var router: Router

    var body: some View {
        VStack{
            PSNavbarComponent()
            ImagesGridComponent()
        }
        .frame(
          minWidth: 0,
          maxWidth: .infinity,
          minHeight: 0,
          maxHeight: .infinity,
          alignment: .topLeading
        ).padding(0)
    }
 
}


#Preview {
    PSImagePage( )
        .modelContainer(for: Item.self, inMemory: true)
}
