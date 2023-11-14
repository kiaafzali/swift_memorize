//
//  MemorizeView.swift
//  Memorize
//
//  Created by kia on 10/16/23.
//

import SwiftUI

struct MemorizeView: View {
    
    @ObservedObject var viewModel : MemorizeViewModel
    
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack{
            Text("MEMORIZE")
                .font(.largeTitle)
                .bold()

            Cards
                .animation(.default, value: viewModel.cards)
            Button(action: {viewModel.shuffle()}, label: {Text("shuffle")})
        }
        .padding()
        .foregroundColor(.orange)
    }
    
    private var Cards: some View {
        GeometryReader { geometry in
            
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            
            LazyVGrid(columns:[GridItem(.adaptive(minimum:gridItemSize), spacing: 0)], spacing:0){
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(Color.orange)
    }
    
        
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
//        return 65.0
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}
    



struct CardView: View {
    let card: MemorizeModel.Card
    
    init(_ card: MemorizeModel.Card){
        self.card = card
    }
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 10)
        ZStack {
            Group{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 3)
                Text(self.card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.001)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(self.card.isFaceUp ? 1 : 0 )
            base.opacity(self.card.isFaceUp ? 0 : 1)
            
        } .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}



#Preview {
    MemorizeView(viewModel: MemorizeViewModel())
}
