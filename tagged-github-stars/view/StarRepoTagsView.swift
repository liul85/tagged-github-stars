import SwiftUI

struct StarRepoTagsView: View {
    let starRepo: StarRepo
    
    @State var tag: String = ""
    @EnvironmentObject var store: StateStore
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("new tag", text: self.$tag)
                    .cornerRadius(5)
                
                Button(action: {
                    self.store.addTag(self.tag, repo: self.starRepo.fullName)
                }) {
                    Text("Add New Tag")
                }
            }
            Divider()
            Text("Tags:")
            List {
                HStack(spacing: 20) {
                    ForEach(self.store.getTags(starRepo.fullName), id: \.self) { item in
                        
                        Button(action: {
                            self.store.deleteTag(item.tag, repo: self.starRepo.fullName)
                        }) {
                            Text("\(item.tag)  X")
                        }.onHover { inside in
                            if inside {
                                NSCursor.pointingHand.push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                    }
                }
            }
        }.padding(10)
    }
}
