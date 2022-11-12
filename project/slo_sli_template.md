# API Service

| Category     | SLI | SLO                                                                                                         |
|--------------|-----|-------------------------------------------------------------------------------------------------------------|
| Availability |  successful requests / total requests   | 99%                                                                                                         |
| Latency      |  buckets of requests in a histogram showing the 90th percentile below 100ms   | 90% of requests below 100ms                                                                                 |
| Error Budget |     | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   |  total number of successful requests over a period of time, 5 requests RPS its good for example| 5 RPS indicates the application is functioning                                                              |
