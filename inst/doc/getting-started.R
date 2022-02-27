## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(healthyR.ai)

## ----lib_load-----------------------------------------------------------------
suppressPackageStartupMessages(library(timetk))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(purrr))
suppressPackageStartupMessages(library(healthyR.data))
suppressPackageStartupMessages(library(rsample))
suppressPackageStartupMessages(library(recipes))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(plotly))

## ----data_set-----------------------------------------------------------------
data_tbl <- healthyR_data %>%
    select(visit_end_date_time) %>%
    summarise_by_time(
        .date_var = visit_end_date_time,
        .by       = "month",
        value     = n()
    ) %>%
    set_names("date_col","value") %>%
    filter_by_time(
        .date_var = date_col,
        .start_date = "2013",
        .end_date = "2020"
    )

head(data_tbl)

## ----splits-------------------------------------------------------------------
splits <- initial_split(data = data_tbl, prop = 0.8)

splits

head(training(splits))

## ----initial_rec_obj----------------------------------------------------------
rec_obj <- recipe(value ~ ., training(splits)) %>%
    step_timeseries_signature(date_col) %>%
    step_rm(matches("(iso$)|(xts$)|(hour)|(min)|(sec)|(am.pm)"))

rec_obj

get_juiced_data(rec_obj) %>% glimpse()

## ----pca_your_rec-------------------------------------------------------------
pca_list <- pca_your_recipe(
  .recipe_object = rec_obj,
  .data          = data_tbl,
  .threshold     = 0.8,
  .top_n         = 5
)

## ----pca_transform------------------------------------------------------------
pca_rec_obj <- pca_list$pca_transform

pca_rec_obj

## ----var_loadings-------------------------------------------------------------
pca_list$variable_loadings

## ----var_variance-------------------------------------------------------------
pca_list$variable_variance

## ----pca_estimates------------------------------------------------------------
pca_list$pca_estimates

## ----juice_bake---------------------------------------------------------------
pca_list$pca_juiced_estimates %>% glimpse()

pca_list$pca_baked_data %>% glimpse()

## ----rotation_df--------------------------------------------------------------
pca_list$pca_rotation_df %>% glimpse()

## ----var_df-------------------------------------------------------------------
pca_list$pca_variance_df %>% glimpse()

## ----scree_plt, fig.width=8, fig.height=8-------------------------------------
pca_list$pca_variance_scree_plt

## ----loading_plots------------------------------------------------------------
pca_list$pca_loadings_plt

pca_list$pca_top_n_loadings_plt

