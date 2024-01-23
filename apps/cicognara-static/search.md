---
layout: default
title: Search
---

<h1>Search</h1>

<input type="text" id="searchTerms" placeholder="text to search" />
<button id="searchButton">Search</button>
<div id="searchResults"> </div>

<!--
  Load the search index (i.e. declares the searchIndex variable)
-->
<script src="/assets/fuseindex.js"></script>

<script>
  // Adapted from https://www.fusejs.io/demo.html
  var runSearch = function() {
    var i, item;

    const fuseOptions = {
            keys: ["filename",
               "ciconum",
               "author",
               "title",
               "people",
               "orgs",
               "languages",
               "dates",
               "places",
               "keywords",
              ],
    };

    // Clear the previous results
    var searchResultsDiv = document.getElementById("searchResults");
    searchResultsDiv.innerHTML = "";

    // Run the search
    const fuse = new Fuse(searchIndex, fuseOptions);
    const searchTerms = document.getElementById("searchTerms").value;
    const results = fuse.search(searchTerms);
    if (results.length == 0) {
      searchResultsDiv.innerHTML = `<p>No results were found for ${searchTerms}</p>`;
      return;
    }

    // Display the total number of results found
    var totalsEl = document.createElement("p");
    totalsEl.textContent = `${results.length} results were found`;
    searchResultsDiv.appendChild(totalsEl);

    // Loop throught results and add them to the page
    for(i = 0; i < results.length; i++) {
    // var resultEl = document.createElement("p");
      var result = results[i].item;

      var linkEl = document.createElement("a");
      linkEl.href = `/catalogo/${result.filename}`;
      linkEl.text = result.title[1];

      // var resultEl = document.createElement("p");
      
      var resultDl = document.createElement("dl");
      resultDl.classList.add("compact");
      searchResultsDiv.appendChild(resultDl);

      var resultDt = document.createElement("dt");
      resultDt.appendChild(document.createTextNode('ciconum'));
      resultDl.appendChild(resultDt);
      
      var resultDd = document.createElement("dd");
      resultDd.appendChild(document.createTextNode(result.ciconum));
      resultDl.appendChild(resultDd);
      
      var resultDt = document.createElement("dt");
      resultDt.appendChild(document.createTextNode('author'));
      resultDl.appendChild(resultDt);
      
      var resultDd = document.createElement("dd");
      resultDd.appendChild(document.createTextNode(result.author));
      resultDl.appendChild(resultDd);
      
      var resultDt = document.createElement("dt");
      resultDt.appendChild(document.createTextNode('title'));
      resultDl.appendChild(resultDt);
      
      var resultDd = document.createElement("dd");
      resultDd.appendChild(linkEl);
      resultDl.appendChild(resultDd);

      // resultEl.appendChild(linkEl);
      // searchResultsDiv.appendChild(resultEl);
    }
  }

  // Wire the search button to run the serch
  document.getElementById("searchButton").addEventListener("click", (event) => {
    runSearch();
  });

  // Wire the enter key on the search textbox to run the search
  // Source https://stackoverflow.com/a/46063448/446681
  document.getElementById("searchTerms").addEventListener("keyup", (event) => {
    if (event.key === "Enter") {
      runSearch();
    }
  });

  // Give the focus to the search box
  document.getElementById("searchTerms").focus();
</script>
