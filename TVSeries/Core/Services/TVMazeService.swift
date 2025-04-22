//
//  TVMazeService.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import Foundation

protocol TVMazeServiceProtocol {
    func fetchShows(page: Int) async throws -> [Show]
    func searchShows(query: String) async throws -> [ShowSearchResult]
    func fetchShowDetails(id: Int) async throws -> Show
    func fetchShowEpisodes(id: Int) async throws -> [Episode]
}

final class TVMazeService: TVMazeServiceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchShows(page: Int) async throws -> [Show] {
        do {
            return try await apiClient.request(TVMazeEndpoint.shows(page: page))
        } catch {
            throw error
        }
    }
    
    func searchShows(query: String) async throws -> [ShowSearchResult] {
        do {
            return try await apiClient.request(TVMazeEndpoint.searchShows(query: query))
        } catch {
            throw error
        }
    }
    
    func fetchShowDetails(id: Int) async throws -> Show {
        do {
            return try await apiClient.request(TVMazeEndpoint.showDetails(id: id))
        } catch {
            throw error
        }
    }
    
    func fetchShowEpisodes(id: Int) async throws -> [Episode] {
        do {
            return try await apiClient.request(TVMazeEndpoint.showEpisodes(id: id))
        } catch {
            throw error
        }
    }
}
