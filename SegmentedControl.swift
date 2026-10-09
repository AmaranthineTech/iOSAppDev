//
//  SegmentedControl.swift
//  SegmentedControlUI
//
//  Created by Instructor on 09/10/26.
//

import SwiftUI

struct SegmentedControl: View {
    
    @Binding var selectedIndex  : Int {
        didSet {
            self.internalIndex = self.selectedIndex
        }
    }
    
    @State private var internalIndex    : Int = 1
    
    var body: some View {
        HStack {
            ForEach([1,2,3,4,5], id:\.self) { index in
                Button(action: {
                    self.selectedIndex = index
                }, label: {
                    Image(systemName: self.internalIndex >= index ? "star.fill" : "star")
                })
            }
        }
    }
}

#Preview {
    SegmentedControl(selectedIndex: Binding<Int>.constant(1))
}

//MARK: - ViewModifiers
struct CompanyTextThemeModifier : ViewModifier {
    let textColor   : Color             = .blue
    let textBgrn    : Color             = .black
    let textPadding : CGFloat           = 25.0
    let textShape   : RoundedRectangle  = RoundedRectangle(cornerRadius: 20.0)
    
    func body(content: Content) -> some View {
        content
            .padding(self.textPadding)
            .foregroundStyle(self.textColor)
            .background(self.textBgrn)
            .clipShape(self.textShape)
    }
}

extension View {
    func companyTheme() -> some View {
        self
            .modifier(CompanyTextThemeModifier())
    }
}

//MARK: - Library modifiers
struct SegmentedControlLibraryModifier : LibraryContentProvider {
    @State private var index : Int = 1
    
    @LibraryContentBuilder var views: [LibraryItem] {
        LibraryItem(SegmentedControl(selectedIndex: self.$index),
                    visible: true,
                    title: "Segmented Control",
                    category: .control)
    }
}

struct CompanyThemeLibraryModifier : LibraryContentProvider {
    @LibraryContentBuilder func modifiers(base: any View) -> [LibraryItem] {
        LibraryItem(base.companyTheme(),
                    title: "Company Theme Modifier",
                    category: .effect)
    }
}
