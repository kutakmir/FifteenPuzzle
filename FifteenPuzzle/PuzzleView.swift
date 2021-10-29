//
//  ContentView.swift
//  FifteenPuzzle
//
//  Created by Miroslav Kutak on 10/28/2021.
//

import SwiftUI
import Combine

struct PuzzleView: View {

    @StateObject var model = FifteenPuzzleModel()

    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()

            VStack(spacing: 60) {
                titleView

                gameBoardView

                buttonToolbarView
            }
        }
    }

    @ViewBuilder
    var titleView: some View {
        VStack {
            Text("The 15 Puzzle")
                .font(.headline)
            Text("Have fun!")
                .font(.subheadline)
        }
    }

    @ViewBuilder
    var gameBoardView: some View {
        let matrix = model.matrix
        HStack {
            ForEach(0..<4) { x in
                let column = matrix[x]
                VStack {
                    ForEach(0..<4) { y in
                        let element = column.values[y]
                        if let point = Coordinate(x: x, y: y) {
                            cell(element, point: point)
                        }
                    }
                }//: HStack
            }
        }//: VStack
        .padding(2)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }


    @ViewBuilder
    var buttonToolbarView: some View {
        HStack {
            Button(action: model.shuffle) {
                Text("Shuffle")
            }

            Button(action: model.sort) {
                Text("Sort")
            }
            .disabled(model.isSorted)
        }
        .buttonStyle(BorderedProminentButtonStyle())
        .padding(2)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    @ViewBuilder
    private func cell(_ element: PuzzleValue, point: Coordinate) -> some View {
        let valueString = element.value.description

        VStack {

            if element.value > 0 {
                Text(valueString)
                    .padding()
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded({ value in
                        let threshold: CGFloat = 10
                        if value.translation.width < -threshold {
                            // Left
                            model.move(from: point, direction: .left)
                        } else
                        if value.translation.width > threshold {
                            // Right
                            model.move(from: point, direction: .right)
                        } else
                        if value.translation.height < -threshold {
                            // Up
                            model.move(from: point, direction: .up)
                        } else
                        if value.translation.height > threshold {
                            // Down
                            model.move(from: point, direction: .down)
                        }
                    }))
            }
        }
        .frame(width: 50, height: 50)
        .background(Color(UIColor.secondarySystemBackground).opacity(element.value == 0 ? 0 : 1))
//        .background(Color(.sRGB, white: 0.9, opacity: element.value == 0 ? 0 : 1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
    }
}
