path_source <- 'data/Outcome of Care Measures.csv'
path_cleaned <- 'cache/outcome.cleaned.RData'

# Lösche Spalten die nur Text enthalten und ...
tidy_data <- function() {
  # Lade das csv File im Data-Ordner und caste alles zu charactern
  csv_df <- read.csv(path_source, colClasses = "character")
  # Schleife über alle Spalten mit "Inhalt" hier bleiben Die Adressen etc. außen vor
  for (spalte in length(csv_df):8) {
    # sum(grepl('[0-9]', csv_df[,spalte])) Prüft ob Ziffern als Spalteninhalt vorkommen
    # Falls die Summe == 0 wird die Spalte gelöscht. Somit fallen alle Spalten aus dem
    # Dataframe, welche nur Text enthalten
    
    if (sum(grepl('[0-9]', csv_df[,spalte])) == 0) {
      print(paste("Spalte", colnames(csv_df[spalte]), "gelöscht"))
      csv_df[,spalte] <- NULL
    }
  }
  
  # weiter Umformungen
  # Entfernen aller Punkte in den Spaltennamen
  # Durch gsub wird ein Ausdruck in den Spaltennamen gesucht und angepasst
  names(csv_df) <- gsub('\\.', ' ', names(csv_df))
  # Entfernen der Leerzeichen zwichen 30 und Day
  names(csv_df) <- gsub('30 Day', '30-Day', names(csv_df))
  # Doppelte Leerzeichen entfernen um Trennungen besser ersichtlich zu machen
  names(csv_df) <- gsub('   ', ' - ', names(csv_df))
  # Death Mortality Rates durch Mortality Rate ersetzen
  names(csv_df) <- gsub('Death  Mortality  Rates', 'Mortality Rates', names(csv_df))
  
  hnames <- csv_df$'Hospital Name'
  hnames <- gsub('MED CENTER', 'M.C.', hnames)
  hnames <- gsub('MEDICAL CENTER', 'M.C.', hnames)
  hnames <- gsub('MEDICAL CTR', 'M.C.', hnames)
  hnames <- gsub('MED CENTER', 'M.C.', hnames)
  hnames <- gsub('MEMORIAL HOSPITAL', 'M.H.', hnames)
  hnames <- gsub('HOSPITALS CENTER', 'H.C.', hnames)
  hnames <- gsub('HOSPITAL CENTER', 'H.C.', hnames)
  hnames <- gsub('HOSPITALS', 'H.', hnames)
  hnames <- gsub('HOSPITAL', 'H.', hnames)
  hnames <- gsub('HEALTH SYSTEM', 'H.S.', hnames)
  hnames <- gsub(', THE$', '', hnames)
  hnames <- gsub('HEALTHCARE', 'HC.', hnames)
  hnames <- gsub('UNIVERSITY', 'UNIV.', hnames)
  hnames <- gsub('SYSTEMS', 'S.', hnames)
  hnames <- gsub('SYSTEM', 'S.', hnames)
  hnames <- gsub('CENTERS', 'C.', hnames)
  hnames <- gsub('CENTER', 'C.', hnames)
  csv_df$Hospital <- hnames
  csv_df
}

save_cleaned_data <- function() {
  csv_df <- tidy_data()
  save(csv_df, file=path_cleaned)
}

load_cleaned_data <- function() {
  #   teste ob file existiert
  if (!file.exists(path_cleaned)) {
    parent <- dirname(path_cleaned)
    if (!file.exists(parent)) {
      #       erstelle path_cleaned wenn nicht vorhanden
      dir.create(parent)
    }
    save_cleaned_data()
  }
  #   falls dir vorhanden rufe load RData
  load(file=path_cleaned)
  csv_df
}


# Lade tidy Data
csv_df <- load_cleaned_data()

# Alle States des DataFrames
states <- unique(csv_df$State)

# Spaltenauswahl einschränken
spalten <- colnames(csv_df[11:(length(csv_df)-1)])

# Alle Spalten außer die ersten 10 [Provider Number - Phone Number]
# Für das "Ranking nach" in der ui.R
outcomes <- colnames(csv_df[11:(length(csv_df)-1)])

mid <- function(csv_df, nmin, nmax) {
  tail(head(csv_df, nmax), nmax - nmin + 1)
}


# gibt die Nummer der Spalte (name) aus
get_col_index <- function(csv_df, name) {
  which(colnames(csv_df) == name)
}

