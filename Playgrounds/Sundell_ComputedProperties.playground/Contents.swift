//https://www.swiftbysundell.com/articles/computed-properties-in-swift/

import UIKit

struct Episode {
    let state: State
    let title: String
    let duration: Float
}

extension Episode {
    enum State {
        case awaitingDownload
        case downloaded
        case listening(progress: Double)
        case finished
    }
}

//Good use of computed properites

extension Episode {
    var isDownloaded: Bool {
        switch state {
        case .awaitingDownload:
            return false
        case .downloaded, .listening, .finished:
            return true
        }
    }
}

struct Podcast {
    let episodes: [Episode]
}

struct Library {
    let lastSyncDate: Date
    let downloadNewEpisodes: Bool
    let podcasts: [Podcast]
}

//Bad use of computed properites because of linear complexity

extension Library {
    var allEpisodes: [Episode] {
        return podcasts.flatMap { $0.episodes }
    }
}
let testLibrary = Library(lastSyncDate: Date.init(), downloadNewEpisodes: true, podcasts: [])

// Example of possible problem with allEpisodes

class AllEpisodesViewController: UITableViewController {
    
    let library: Library = testLibrary
    let reuseIdentifier = "AllEpisodesViewController"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath
        )

        // Here we're accessing allEpisodes just as if it was a
        // stored property, and there's no way of telling that this
        // will actually cause an O(N) evaluation under the hood:
        let episode = library.allEpisodes[indexPath.row]
        cell.textLabel?.text = episode.title
        cell.detailTextLabel?.text = String(episode.duration)

        return cell
    }
}
