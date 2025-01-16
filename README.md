# Riley's Selenium 3.X Container

I put this together so I could use [RSelenium](https://github.com/ropensci/RSelenium) to connect to a containerized selenium instance instead of wrangling all the pieces (selenium server, browser instance, browser driver, etc) together manually. RSelenium doesn't work well with Selenium 4+, and the Selenium 3.X containers ship with an ancient set of browsers that were causing problems with the sites I wanted to scrape.

This container runs Selenium 3.X with a more recent version of Chrome.

It should work for arm and x86, but notably I could not get it to run the **x86 version on arm via rosetta emulation.** No idea why, but not relevant to my use case so I have ignored it.

Why was I using R for scraping? Don't ask, man. Jeez.

If you're using this for some reason, I'm pretty new to the whole container scene, let me know if something is horribly wrong here. Thanks dawg.
