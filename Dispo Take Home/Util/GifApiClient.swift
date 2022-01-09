import UIKit

struct GifAPIClient {
    // TODO: Implement
    // PY - Implemented
    func getTrendingGifs(completion: @escaping (APIListResponse?, Error?) -> ()) {
        let trendingUrl = Constants.baseUrl + "trending?api_key=" + Constants.giphyApiKey + "&limit=25&rating=pg"
        
        guard let url = URL(string: trendingUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            var result: APIListResponse?
            if let data = data, error == nil {
                do {
                    result = try JSONDecoder().decode(APIListResponse.self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
            completion(result, error)
        }
        task.resume()
    }
    
    func searchGifsByTerm(searchString: String, completion: @escaping (APIListResponse?, Error?) -> ()) {
        let searchUrl = Constants.baseUrl + "search?api_key=" + Constants.giphyApiKey + "&q=" + searchString + "&limit=25&offset=0&rating=pg&lang=en"
        
        guard let url = URL(string: searchUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            var result: APIListResponse?
            if let data = data, error == nil {
                do {
                    result = try JSONDecoder().decode(APIListResponse.self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
            completion(result, error)
        }
        task.resume()
    }
    
    func getGifById(id: String, completion: @escaping (GifObject?, Error?) -> ()) {
        let gifUrl = Constants.baseUrl + id + "?api_key=" + Constants.giphyApiKey
        
        guard let url = URL(string: gifUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            var result: APIGifResponse?
            if let data = data, error == nil {
                do {
                    result = try JSONDecoder().decode(APIGifResponse.self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
            completion(result?.data, error)
        }
        task.resume()
    }
}
