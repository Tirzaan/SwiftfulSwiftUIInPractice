//
//  BumbleFilterView.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Tirzaan on 10/27/25.
//

import SwiftUI

struct BumbleFilterView: View {
    var options: [String] = ["Everyone", "Trending"]
    @Binding var selectedOption: String
    @Namespace private var nameSpace
    
    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            ForEach(options, id: \.self) { option in
                VStack(spacing: 8) {
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    if selectedOption == option {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selection", in: nameSpace)
                    } else {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .opacity(0)
                    }
                }
                .padding(.top, 8)
                .background(Color.black.opacity(0.001))
                .foregroundStyle(selectedOption == option ? .bumbleBlack : .bumbleGray)
                .onTapGesture {
                    selectedOption = option
                }
            }
        }
        .animation(.smooth, value: selectedOption)
    }
}

fileprivate struct BumbleFilterViewPreview: View {
    var options: [String] = ["Everyone", "Trending"]
    @State private var selectedOption: String = "Everyone"
    
    var body: some View {
        BumbleFilterView(options: options, selectedOption: $selectedOption)
    }
}

#Preview {
    BumbleFilterViewPreview()
        .padding()
}
