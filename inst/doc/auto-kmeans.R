## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message = FALSE,
  warning = FALSE,
  fig.width = 8,
  fig.height = 4.5,
  fig.align = 'center',
  out.width = '95%',
  dpi = 100
)

## ----setup--------------------------------------------------------------------
library(healthyR.ai)
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(h2o))

## ----iris_data----------------------------------------------------------------
df_tbl <- iris

glimpse(df_tbl)

## ----automl_kmeas-------------------------------------------------------------
column_names <- names(iris)
target_col <- "Species"
predictor_cols <- setdiff(column_names, target_col)

## ----run_auto_ml, eval=FALSE--------------------------------------------------
#  h2o.init()
#  
#  output <- hai_kmeans_automl(
#    .data = df_tbl,
#    .predictors = predictor_cols,
#    .standardize = FALSE
#  )
#  
#  h2o.shutdown(prompt = FALSE)

## ----data_section, eval=FALSE-------------------------------------------------
#  output$data

## ----autom_obj, eval=FALSE----------------------------------------------------
#  output$auto_kmeans_obj

## ----best_model, eval=FALSE---------------------------------------------------
#  output$model_id

## ----scree_plot, eval=FALSE---------------------------------------------------
#  print(output$scree_plt)

