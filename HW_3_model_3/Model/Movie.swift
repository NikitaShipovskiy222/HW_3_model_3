
// MARK: - TrendingMoviesResponse
struct TrendingMoviesResponse: Codable {
    let total, totalPages: Int
    let items: [Movie]
}

// MARK: Movie
struct Movie: Codable {
    let kinopoiskID: Int
    let imdbID, nameRu: String?
    let nameEn: JSONNull?
    let nameOriginal: String?
    let countries: [Country]
    let genres: [Genre]
    let ratingKinopoisk: Double
    let ratingImdb: Double?
    let year: Int
    let type: String
    let posterURL, posterURLPreview: String

    enum CodingKeys: String, CodingKey {
        case kinopoiskID = "kinopoiskId"
        case imdbID = "imdbId"
        case nameRu, nameEn, nameOriginal, countries, genres, ratingKinopoisk, ratingImdb, year, type
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
    }
}

// MARK:  Country
struct Country: Codable {
    let country: String
}

// MARK:  Genre
struct Genre: Codable {
    let genre: String
}

// MARK:  Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

