# Data Cleaning and Manipulation

## Import Data
mentalhealth <- 
  read_csv("Data/F2022-NHIS-MentalHealth_raw.csv")

## Make HRSLEEP NA values
mentalhealth <- mentalhealth %>% 
  mutate(HRSLEEP = ifelse(HRSLEEP %in% c(00,97,98,99), NA, HRSLEEP))

## Make binary HRSLEEP variable
mentalhealth <- mentalhealth %>% 
  mutate(sleep_mt7hr = ifelse(HRSLEEP<7, 0, 1))

## Make NA values
mentalhealth <- mentalhealth %>%
  mutate(AEFFORT = ifelse(AEFFORT %in% c(6:9), NA, AEFFORT)) %>% 
  mutate(AHOPELESS = ifelse(AHOPELESS %in% c(6:9), NA, AHOPELESS)) %>% 
  mutate(ANERVOUS = ifelse(ANERVOUS %in% c(6:9), NA, ANERVOUS)) %>% 
  mutate(ARESTLESS = ifelse(ARESTLESS %in% c(6:9), NA, ARESTLESS)) %>%
  mutate(ASAD = ifelse(ASAD %in% c(6:9), NA, ASAD)) %>% 
  mutate(AWORTHLESS = ifelse(AWORTHLESS %in% c(6:9), NA, AWORTHLESS))

# mentalhealth %>% 
  # mutate(across(.cols = c(AEFFORT,AHOPELESS,ANERVOUS,ARESTLESS,AWORTHLESS,ASAD),
                # .fns = \(x) ifelse(x %in% 6:9, NA, x)))


# Create kessler score
mentalhealth <- mentalhealth %>%
  mutate(kessler_score = AEFFORT+AHOPELESS+ANERVOUS+ARESTLESS+AWORTHLESS+ASAD)
         
# Create mental health severe

mentalhealth <- mentalhealth %>% 
  mutate(mentalhealth_severe = ifelse(kessler_score<13,0,1))
         
# Clean age and POORYN
mentalhealth <- mentalhealth %>%
  mutate(AGE = ifelse(AGE == c(997,998,999), NA, AGE)) %>% 
  mutate(POORYN = ifelse(POORYN == 9,NA,POORYN))

# Save
write_rds(mentalhealth, "Data/Clean.Data.rds")




