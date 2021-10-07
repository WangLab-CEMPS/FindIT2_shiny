
# How to setup

step1: Download or clone this repo to your local compute or local server

```bash
git clone https://github.com/WangLab-CEMPS/FindIT2_shiny
```


step2: install the following packages in R

- shiny
- shinydashboard
- TxDb.Athaliana.BioMart.plantsmart28
- TxDb.Hsapiens.UCSC.hg19.knownGene
- FindIT2

step3: open R terminal, and run the following command

```
library(shiny)

runApp("/path/to/FindIT2_shiny", port=9999, host="0.0.0.0")
```


If you have any question, please report in [GitHub issue](https://github.com/WangLab-CEMPS/FindIT2_shiny/issues)