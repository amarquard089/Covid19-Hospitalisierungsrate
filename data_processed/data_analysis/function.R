require(forecast)

# Algorithmus für optimales Modell
opt_mod <- function(y, window = 12, h = 1) {
  n <- nrow(y)
  res <- c()
  mods <- list()
  for (i in seq(0, n - window - h)) {
    train <- window(y, start = 1 + i, end = window + i)
    test <- window(y, start = window + 1 + i, end = window + h + i)
    b <- auto.arima(train, stepwise = F, approximation = F)
    mods[[as.character(i)]] <- b
    e <- tsCV(y, function(x, h_) forecast(Arima(x, model = b), h = h_), h = h, initial = 0, window = window)
    if (h == 1) {
      res <- append(res, sqrt(mean(e^2, na.rm = T)))
    } else {
      res <- append(res, sqrt(mean(e[,h]^2, na.rm = T)))
    }
    acc_fc <- accuracy(forecast(b, h = h), test)
  }
  b_mod <- mods[[as.character(which.min(res))]]
  n_train <- window(y, start = n - window - 1, end = n - h)
  n_test <- window(y, start = n - h + 1, end = n)
  c <- Arima(n_train, model = b_mod)
  fc <- forecast(c, h = h)
  print(accuracy(fc, n_test))
  print(fc)
  plot(fc)
  lines(x = seq(n-h+1,n), y = as.numeric(n_test), col = "red", type = "p")
  
  fin <- list("best_mod" = b_mod, "rmse" = res[which.min(res)], 
              "all" = list("mods" = mods, "rmse" = res))
  return(fin)
}
