//
//  ChartView.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/15/24.
//

import Foundation
import SwiftUI
import Charts


struct ChartView: View {
    @StateObject var viewModel: ChartViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    VStack {
                        ChartView1()
                        ChartView2().frame(height: 200)
                        ChartView3().frame(height: 300)
                        ChartView4().frame(height: 400)
                    }
                }
                .shadow(color: .gray, radius: 10, x: 0, y: 0)
            }
            .navigationTitle("ChartView")
        }
    }
}

struct ChartView1: View {
    @State private var numbers = (0...10)
        .map { _ in Int.random(in: 0...10) }
    
    var body: some View {
        Chart {
            RuleMark(y: .value("Limit", 5)).foregroundStyle(.red)
            ForEach(Array(numbers.enumerated()), id: \.element) { index, number in
                LineMark(
                    x: .value("index", index),
                    y: .value("value", number)
                )
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [1]))

                PointMark(
                    x: .value("index", index),
                    y: .value("value", number)
                ) 
                .symbol(.diamond)
                .annotation {
                    Text("\(number)")
                }
            }
        }
        .frame(minWidth: 200, maxWidth: .infinity)
    }
}

struct Candle: Hashable {
    let open: Double
    let close: Double
    let low: Double
    let high: Double
}

struct ChartView2: View {
    let candles: [Candle] = [
        .init(open: 3, close: 6, low: 1, high: 8),
        .init(open: 4, close: 7, low: 2, high: 9),
        .init(open: 5, close: 8, low: 3, high: 10)
    ]
    
    var body: some View {
        Chart {
            ForEach(Array(zip(candles.indices, candles)), id: \.1) { index, candle in
                RectangleMark(
                    x: .value("index", index),
                    yStart: .value("low", candle.low),
                    yEnd: .value("high", candle.high),
                    width: 4
                )
                
                RectangleMark(
                    x: .value("index", index),
                    yStart: .value("open", candle.open),
                    yEnd: .value("close", candle.close),
                    width: 16
                )
                .foregroundStyle(.red)
            }
        }
    }
}

struct CandleStickMark<X: Plottable, Y: Plottable>: ChartContent {
    let x: PlottableValue<X>
    let low: PlottableValue<Y>
    let high: PlottableValue<Y>
    let open: PlottableValue<Y>
    let close: PlottableValue<Y>
    
    init(
        x: PlottableValue<X>,
        low: PlottableValue<Y>,
        high: PlottableValue<Y>,
        open: PlottableValue<Y>,
        close: PlottableValue<Y>
    ) {
        self.x = x
        self.low = low
        self.high = high
        self.open = open
        self.close = close
    }
    
    var body: some ChartContent {
        RectangleMark(x: x, yStart: low, yEnd: high, width: 4)
        RectangleMark(x: x, yStart: open, yEnd: close, width: 16)
            .foregroundStyle(.red)
    }
}

struct ChartView3: View {
    var body: some View {
        Chart {
            ForEach(0...10, id: \.self) { index in
                CandleStickMark(
                    x: .value("index", index),
                    low: .value("low", Int.random(in: 0...2)),
                    high: .value("high", Int.random(in: 8...10)),
                    open: .value("open", Int.random(in: 2...8)),
                    close: .value("close", Int.random(in: 2...8))
                )
                .foregroundStyle(.green)
            }
        }
    }
}


enum Gender: String {
    case male
    case female
    case notSet
}

extension Gender: Plottable {
    var primitivePlottable: String {
        rawValue
    }
}

struct Stats {
    let city: String
    let population: Int
    let gender: Gender
}

struct ChartView4: View {
    let stats: [Stats] = [.init(city: "London", population: 100, gender: .male),
                          .init(city: "London", population: 200, gender: .female),
                          .init(city: "New York", population: 200, gender: .female),
                          .init(city: "Paris", population: 300, gender: .notSet)]
    
    var body: some View {
        Chart {
            ForEach(stats, id: \.city) { stat in
                BarMark(
                    x: .value("City", stat.city),
                    y: .value("Population", stat.population)
                )
                .foregroundStyle(by: .value("Gender", stat.gender))
                .position(by: .value("Gender", stat.gender))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .opacity(0.6)
                .annotation(position: .overlay, alignment: .top, spacing: 6) {
                    Text(verbatim: stat.population.formatted())
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    ChartView(viewModel: ChartViewModel())
}
