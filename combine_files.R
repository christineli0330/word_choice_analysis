## code to combine multiple data files together

# loading packages
library(tidyverse)
library(stringr)

# location of files
dir = 'C:/Users/Christine/Box Sync/data/word_mem'

list = list.files(path = dir, pattern = "*.csv", full.names = TRUE)

# combine data files into single dataframe + 1 conlumn dientifying original file name
df <- list %>%
  setNames(nm = .) %>% 
  map_df(~read_csv(.x, col_types = cols(), col_names = FALSE), .id = "file_name")    

# edit column names function
header.true <- function(df) {
  names(df) <- as.character(unlist(df[1,]))
  df[-1,]
}
df = header.true(df)
colnames(df)[1] <- "batch_id"

# Clean the data by removing not needed columns
df.cleaned = df %>% select(batch_id, run_id, rt, response, ttype, trial_type, trial_index, stimulus, word,
                           mem, stim_left, stim_right, value_left, value_right, mem_left, mem_right, completioncode)


# write full data into csv
write.csv(df.cleaned, 'C:/Users/Christine/Box Sync/data/word_mem/full data/full_word_choice.csv')
