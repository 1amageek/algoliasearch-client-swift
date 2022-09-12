//
//  SearchResponse+Codable.swift
//  
//
//  Created by Vladislav Fitc on 19/03/2020.
//

import Foundation

extension SearchResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case hits
        case nbHits
        case page
        case hitsPerPage
        case offset
        case length
        case userData
        case nbPages
        case processingTimeMS
        case exhaustiveNbHits
        case exhaustiveFacetsCount
        case query
        case queryAfterRemoval
        case params
        case message
        case aroundLatLng
        case automaticRadius
        case serverUsed
        case indexUsed
        case abTestID
        case abTestVariantID
        case parsedQuery
        case facetsStorage = "facets"
        case disjunctiveFacetsStorage = "disjunctiveFacets"
        case facetStatsStorage = "facets_stats"
        case cursor
        case indexName = "index"
        case processed
        case queryID
        case hierarchicalFacetsStorage = "hierarchicalFacets"
        case explain
        case renderingContent
        case appliedRelevancyStrictness
        case nbSortedHits
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.hits = try container.decode([Hit<JSON>].self, forKey: .hits)
        self.nbHits = try container.decodeIfPresent(Int.self, forKey: .nbHits)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.hitsPerPage = try container.decodeIfPresent(Int.self, forKey: .hitsPerPage)
        self.offset = try container.decodeIfPresent(Int.self, forKey: .offset)
        self.length = try container.decodeIfPresent(Int.self, forKey: .length)
        self.userData = try container.decodeIfPresent([JSON].self, forKey: .userData)
        self.nbPages = try container.decodeIfPresent(Int.self, forKey: .nbPages)
        self.processingTimeMS = try container.decodeIfPresent(Double.self, forKey: .processingTimeMS)
        self.exhaustiveNbHits = try container.decodeIfPresent(Bool.self, forKey: .exhaustiveNbHits)
        self.exhaustiveFacetsCount = try container.decodeIfPresent(Bool.self, forKey: .exhaustiveFacetsCount)
        self.query = try container.decodeIfPresent(String.self, forKey: .query)
        self.queryAfterRemoval = try container.decodeIfPresent(String.self, forKey: .queryAfterRemoval)
        self.params = try container.decodeIfPresent(String.self, forKey: .params)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.aroundLatLng = try container.decodeIfPresent(Point.self, forKey: .aroundLatLng)
        let legacyAutomaticRadius: String? = try container.decodeIfPresent(String.self, forKey: .automaticRadius)
        self.automaticRadius = legacyAutomaticRadius.flatMap(Double.init)
        self.serverUsed = try container.decodeIfPresent(String.self, forKey: .serverUsed)
        self.indexUsed = try container.decodeIfPresent(IndexName.self, forKey: .indexUsed)
        self.abTestID = try container.decodeIfPresent(ABTestID.self, forKey: .abTestID)
        self.abTestVariantID = try container.decodeIfPresent(Int.self, forKey: .abTestVariantID)
        self.parsedQuery = try container.decodeIfPresent(String.self, forKey: .parsedQuery)
        self.facetsStorage = try container.decodeIfPresent(FacetsStorage.self, forKey: .facetsStorage)
        self.disjunctiveFacetsStorage = try container.decodeIfPresent(FacetsStorage.self, forKey: .disjunctiveFacetsStorage)
        self.facetStatsStorage = try container.decodeIfPresent(FacetStatsStorage.self, forKey: .facetStatsStorage)
        self.cursor = try container.decodeIfPresent(Cursor.self, forKey: .cursor)
        self.indexName = try container.decodeIfPresent(IndexName.self, forKey: .indexName)
        self.processed = try container.decodeIfPresent(Bool.self, forKey: .processed)
        self.queryID = try container.decodeIfPresent(QueryID.self, forKey: .queryID)
        self.hierarchicalFacetsStorage = try container.decodeIfPresent(FacetsStorage.self, forKey: .hierarchicalFacetsStorage)
        self.explain = try container.decodeIfPresent(Explain.self, forKey: .explain)
        self.renderingContent = try container.decodeIfPresent(RenderingContent.self, forKey: .renderingContent)
        self.appliedRelevancyStrictness = try container.decodeIfPresent(Int.self, forKey: .appliedRelevancyStrictness)
        self.nbSortedHits = try container.decodeIfPresent(Int.self, forKey: .nbSortedHits)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hits, forKey: .hits)
        try container.encodeIfPresent(nbHits, forKey: .nbHits)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encodeIfPresent(hitsPerPage, forKey: .hitsPerPage)
        try container.encodeIfPresent(offset, forKey: .offset)
        try container.encodeIfPresent(length, forKey: .length)
        try container.encodeIfPresent(userData, forKey: .userData)
        try container.encodeIfPresent(nbPages, forKey: .nbPages)
        try container.encodeIfPresent(processingTimeMS, forKey: .processingTimeMS)
        try container.encodeIfPresent(exhaustiveNbHits, forKey: .exhaustiveNbHits)
        try container.encodeIfPresent(exhaustiveFacetsCount, forKey: .exhaustiveFacetsCount)
        try container.encodeIfPresent(query, forKey: .query)
        try container.encodeIfPresent(queryAfterRemoval, forKey: .queryAfterRemoval)
        try container.encodeIfPresent(params, forKey: .params)
        try container.encodeIfPresent(message, forKey: .message)
        try container.encodeIfPresent(aroundLatLng, forKey: .aroundLatLng)
        let legacyAutomaticRadius = automaticRadius.flatMap { "\($0)" }
        try container.encodeIfPresent(legacyAutomaticRadius, forKey: .automaticRadius)
        try container.encodeIfPresent(serverUsed, forKey: .serverUsed)
        try container.encodeIfPresent(indexUsed, forKey: .indexUsed)
        try container.encodeIfPresent(abTestID, forKey: .abTestID)
        try container.encodeIfPresent(abTestVariantID, forKey: .abTestVariantID)
        try container.encodeIfPresent(parsedQuery, forKey: .parsedQuery)
        try container.encodeIfPresent(facetsStorage, forKey: .facetsStorage)
        try container.encodeIfPresent(disjunctiveFacetsStorage, forKey: .disjunctiveFacetsStorage)
        try container.encodeIfPresent(facetStatsStorage, forKey: .facetStatsStorage)
        try container.encodeIfPresent(cursor, forKey: .cursor)
        try container.encodeIfPresent(indexName, forKey: .indexName)
        try container.encodeIfPresent(processed, forKey: .processed)
        try container.encodeIfPresent(queryID, forKey: .queryID)
        try container.encodeIfPresent(hierarchicalFacetsStorage, forKey: .hierarchicalFacetsStorage)
        try container.encodeIfPresent(explain, forKey: .explain)
        try container.encodeIfPresent(renderingContent, forKey: .renderingContent)
        try container.encodeIfPresent(appliedRelevancyStrictness, forKey: .appliedRelevancyStrictness)
        try container.encodeIfPresent(nbSortedHits, forKey: .nbSortedHits)
    }
    
}
