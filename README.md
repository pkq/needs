
<!-- README.md is generated from README.Rmd. Please edit that file -->



[![Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)

# needs

`needs` is a simple R function to make package loading / installation hassle-free &mdash; use it in place of `library` to attach packages and automatically install any that are missing. You can also supply a minimum version number, and it will update old packages as needed. No more changing your code to reinstall packages every time you update R &mdash; `needs` does it for you.


```r
devtools::install_github("joshkatz/needs")
library(needs)   

# answer "yes" when prompted, and you will never have
# to type library or install.packages again. hooray.
```

### Usage
Once installed, use just as you would `library`. With the added bonus of being able to give multiple unquoted arguments in one single function call. Specify a required package version with a pairlist:


```r
needs(foo,
      bar = "0.9.1",
      baz = "0.4.3")
```


### Rprofile
`needs` can help make code-sharing easier. In your project directory:

```r
needs::toProfile()
```
This extracts the package contents and appends it to the Rprofile in your working directory. Now if someone else clones your project, your code runs without requiring any extra installation or throwing errors for uninstalled packages.
