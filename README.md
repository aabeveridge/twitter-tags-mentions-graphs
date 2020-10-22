# Visualizing Twitter Hashtag and Username Co-occurances in R

## Twitter Quanteda Tutorial
The following tutorial uses the `quanteda` package and translates the tutorial available at <https://quanteda.io/articles/pkgdown/examples/twitter.html> for Twitter data collected by [MassMine](https://www.massmine.org/). The code example in `tags-mentions-graphs.R` uses a dataset saved in CSV format. For instructions on how this data was converted from MassMine's JSON output, please see the `json_conversion.R` code example in the [twitter-json-conversion](https://github.com/aabeveridge/twitter-json-conversion/blob/master/json_conversion.R) repository.

## Extend Data Collection Workflow

In addition to modifying `tags-mentions-graphs.R` for your own Twitter dataset, the goals for this week's workshop include learning how to collect Twitter data using config files in MassMine. Included in this repository are two example config files. The first file, `rehydrate_example_config.txt`, provides a config example for rehydrating a list of Tweet IDs, and the second file, `user_example_config.txt`, provides a config example for collecting tweet histories for a list of users. You will need to ensure that you have downloaded the newest version of MassMine (version 1.2.2 or greater).

## Tutorial Goals
- Use config file to collect Twitter data with MassMine
- Read CSV file and convert to quanteda corpus
- Explore top hashtags
- Graph co-occurance of hashtags
- Explore top usernames
- Graph co-occurance of username mentions
