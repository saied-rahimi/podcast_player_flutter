const String queryAllPodcasts = r"""
query {
getPodcasts{
  id
  title
  episodsList{
    id
    title
    isPlayed
  }
}
}

""";

const String createPodcast = r"""
mutation CreatePodcast($title: String!) {
  createPodcast(title: $title) {
    id
    title
  }
}
""";

const String removePodcast = r"""
mutation RemovePodcast($podcastId: Int!) {
  removePodcast(podcastId: $podcastId) {
    id
    title
  }
}
""";

const String createEpisode = r"""
mutation CreateEpisode($podcastId: Int!, $title: String!) {
  createEpisod(podcastId: $podcastId, title: $title) {
    id
    title
    podcastId
    isPlayed
  }
}
""";

const String removeEpisode = r"""
mutation RemoveEpisode($episodeId: Int!) {
  removeEpisode(episodeId: $episodeId) {
    id
    title
  }
}
""";

const String markEpisodePlayed = r"""
mutation MarkEpisodePlayed($episodId: Int!) {
  markEpisodPlayed(episodId: $episodId) {
    id
    title
    isPlayed
  }
}
""";
