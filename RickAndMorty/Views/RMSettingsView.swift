//
//  RMSettingsView.swift
//  RickAndMorty
//
//  Created by Abdallah Adel on 29/01/2025.
//

import SwiftUI

struct RMSettingsView: View {
    let viewModel: RMSettingsViewViewModel

    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            // App Info Section
            Section {
                ForEach(viewModel.cellViewModels) { cellViewModel in
                    SettingsRowView(viewModel: cellViewModel)
                }
            } header: {
                Text("App")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            // About Section
            Section {
                VStack(alignment: .center, spacing: 12) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 40))
                        .foregroundColor(Color(UIColor(red: 0.0, green: 0.85, blue: 0.45, alpha: 1.0)))
                    
                    Text("Rick & Morty")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Version 1.0.0")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("Built with 💚 by Abdallah Adel")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
            } header: {
                Text("About")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct SettingsRowView: View {
    let viewModel: RMSettingsCellViewModel
    
    var body: some View {
        Button(action: {
            viewModel.onTapHandler(viewModel.type)
        }) {
            HStack(spacing: 14) {
                // Icon with glass-like background
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(viewModel.iconContainerColor))
                        )
                }
                
                // Text content
                VStack(alignment: .leading, spacing: 2) {
                    Text(viewModel.title)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    if let subtitle = viewModel.subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(Color(.tertiaryLabel))
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(.plain)
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({
            return RMSettingsCellViewModel(type: $0) { _ in }
        })))
    }
}
