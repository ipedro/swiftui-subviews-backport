//  Copyright (c) 2024 Pedro Almeida
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import protocol SwiftUI.View
import struct SwiftUI.ViewBuilder
import struct SwiftUI.Group

@available(iOS, introduced: 13.0, deprecated: 18.0, message: "Please use the built in Group(subviews: ...) init")
@available(macOS, introduced: 10.15, deprecated: 15.0, message: "Please use the built in Group(subviews: ...) init")
@available(tvOS, introduced: 13.0, deprecated: 18.0, message: "Please use the built in Group(subviews: ...) init")
@available(watchOS, introduced: 6.0, deprecated: 11.0, message: "Please use the built in Group(subviews: ...) init")
@available(visionOS, introduced: 1.0, deprecated: 2.0, message: "Please use the built in Group(subviews: ...) init")
extension Group where Content: View {
    
    /// Constructs a group from the subviews of the given view.
    ///
    /// Use this initializer to create a group that gives you programmatic
    /// access to the group's subviews. The following `CardsView` defines the
    /// group's structure based on the set of views that you provide to it:
    ///
    /// ```swift
    /// struct CardsView<Content: View>: View {
    ///     var content: Content
    ///
    ///     init(@ViewBuilder content: () -> Content) {
    ///         self.content = content()
    ///     }
    ///
    ///     var body: some View {
    ///         VStack {
    ///             Group(subviews: content) { subviews in
    ///                 HStack {
    ///                     if subviews.count >= 2 {
    ///                         SecondaryCard { subview[1] }
    ///                     }
    ///                     if let first = subviews.first {
    ///                         FeatureCard { first }
    ///                     }
    ///                     if subviews.count >= 3 {
    ///                         SecondaryCard { subviews[2] }
    ///                     }
    ///                 }
    ///                 if subviews.count > 3 {
    ///                     subviews[3...]
    ///                 }
    ///             }
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// You can use `CardsView` with its view builder-based initializer to
    /// arrange a collection of subviews:
    ///
    /// ```swift
    /// CardsView {
    ///     NavigationLink("What's New!") { WhatsNewView() }
    ///     NavigationLink("Latest Hits") { LatestHitsView() }
    ///     NavigationLink("Favorites") { FavoritesView() }
    ///     NavigationLink("Playlists") { MyPlaylists() }
    /// }
    /// ```
    ///
    /// Subviews collection constructs subviews on demand, so only access the
    /// part of the collection you need to create the resulting content.
    ///
    /// Subviews are proxies to the view they represent, which means
    /// that modifiers that you apply to the original view take effect before
    /// modifiers that you apply to the subview. SwiftUI resolves the view
    /// using the environment of its container rather than the environment of
    /// its subview proxy. Additionally, because subviews represent a
    /// single view or container, a subview might represent a view after the
    /// application of styles. As a result, applying a style to a subview might
    /// have no effect.
    ///
    /// - Parameters:
    ///   - view: The view to get the subviews of.
    ///   - transform: A closure that constructs a view from the collection of
    ///     subviews.
    ///
    /// - SeeAlso: Check also ``SwiftUICore/ForEach/init(subviews:content:)``
    ///
    @_alwaysEmitIntoClient
    public init<V, Result>(
        subviews view: V,
        @ViewBuilder transform: @escaping (_Subviews) -> Result
    ) where Content == MultiViewTree<V, Result>, V: View, Result: View {
        self.init {
            MultiViewTree(subviews: view, transform: transform)
        }
    }
}