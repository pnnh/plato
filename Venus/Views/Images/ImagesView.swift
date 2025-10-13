import Foundation
import SwiftUI
import Combine 

struct PSImageView: View {
    @EnvironmentObject var router: Router
    
    
    var body: some View {
        VStack{
            PSNavbarComponent()
            
            Button("Images Home") {
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
    PSImageView( )
        .modelContainer(for: Item.self, inMemory: true)
}
