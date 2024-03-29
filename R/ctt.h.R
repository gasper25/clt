
# This file is automatically generated, you probably don't want to edit this

cttOptions <- if (requireNamespace("jmvcore", quietly=TRUE)) R6::R6Class(
    "cttOptions",
    inherit = jmvcore::Options,
    public = list(
        initialize = function(
            dist = "normal",
            sample = 25,
            repeats = 100, ...) {

            super$initialize(
                package="clt",
                name="ctt",
                requiresData=FALSE,
                ...)

            private$..dist <- jmvcore::OptionList$new(
                "dist",
                dist,
                options=list(
                    "normal",
                    "uniform",
                    "geometric",
                    "lognormal",
                    "binomial"),
                default="normal")
            private$..sample <- jmvcore::OptionInteger$new(
                "sample",
                sample,
                min=1,
                max=200,
                default=25)
            private$..repeats <- jmvcore::OptionInteger$new(
                "repeats",
                repeats,
                min=1,
                max=5000,
                default=100)

            self$.addOption(private$..dist)
            self$.addOption(private$..sample)
            self$.addOption(private$..repeats)
        }),
    active = list(
        dist = function() private$..dist$value,
        sample = function() private$..sample$value,
        repeats = function() private$..repeats$value),
    private = list(
        ..dist = NA,
        ..sample = NA,
        ..repeats = NA)
)

cttResults <- if (requireNamespace("jmvcore", quietly=TRUE)) R6::R6Class(
    "cttResults",
    inherit = jmvcore::Group,
    active = list(
        izpis2 = function() private$.items[["izpis2"]],
        picp = function() private$.items[["picp"]],
        pics = function() private$.items[["pics"]]),
    private = list(),
    public=list(
        initialize=function(options) {
            super$initialize(
                options=options,
                name="",
                title="Central Limit Theorem")
            self$add(jmvcore::Table$new(
                options=options,
                name="izpis2",
                title="Sampling",
                rows=1,
                columns=list(
                    list(
                        `name`="size", 
                        `title`="Sample size", 
                        `type`="integer"),
                    list(
                        `name`="repeats", 
                        `title`="No. of samples", 
                        `type`="integer"),
                    list(
                        `name`="means", 
                        `title`="Mean (of sample means)", 
                        `type`="number"),
                    list(
                        `name`="sds", 
                        `title`="SD (of sample means)", 
                        `type`="number"),
                    list(
                        `name`="serror", 
                        `title`="St. error of mean\u00B0", 
                        `type`="number")),
                notes=list(
                    `1`="\u00B0 Calculated standard error")))
            self$add(jmvcore::Image$new(
                options=options,
                name="picp",
                title="Sample means with source distribution",
                visible=TRUE,
                width=600,
                height=300,
                renderFun=".picp"))
            self$add(jmvcore::Image$new(
                options=options,
                name="pics",
                title="Distribution of sample means - closer",
                visible=TRUE,
                width=600,
                height=300,
                renderFun=".pics"))}))

cttBase <- if (requireNamespace("jmvcore", quietly=TRUE)) R6::R6Class(
    "cttBase",
    inherit = jmvcore::Analysis,
    public = list(
        initialize = function(options, data=NULL, datasetId="", analysisId="", revision=0) {
            super$initialize(
                package = "clt",
                name = "ctt",
                version = c(1,0,0),
                options = options,
                results = cttResults$new(options=options),
                data = data,
                datasetId = datasetId,
                analysisId = analysisId,
                revision = revision,
                pause = NULL,
                completeWhenFilled = FALSE,
                requiresMissings = FALSE,
                weightsSupport = 'na')
        }))

#' Central Limit Theorem
#'
#' 
#' @param dist .
#' @param sample .
#' @param repeats .
#' @return A results object containing:
#' \tabular{llllll}{
#'   \code{results$izpis2} \tab \tab \tab \tab \tab a table \cr
#'   \code{results$picp} \tab \tab \tab \tab \tab an image \cr
#'   \code{results$pics} \tab \tab \tab \tab \tab an image \cr
#' }
#'
#' Tables can be converted to data frames with \code{asDF} or \code{\link{as.data.frame}}. For example:
#'
#' \code{results$izpis2$asDF}
#'
#' \code{as.data.frame(results$izpis2)}
#'
#' @export
ctt <- function(
    dist = "normal",
    sample = 25,
    repeats = 100) {

    if ( ! requireNamespace("jmvcore", quietly=TRUE))
        stop("ctt requires jmvcore to be installed (restart may be required)")


    options <- cttOptions$new(
        dist = dist,
        sample = sample,
        repeats = repeats)

    analysis <- cttClass$new(
        options = options,
        data = data)

    analysis$run()

    analysis$results
}

