---
layout: default
title: Search
---

<h1>Search</h1>

<input type="text" id="searchTerms" placeholder="text to search" />
<button id="searchButton">Search</button>
<div id="searchResults"> </div>

<script>
// Adapted from https://www.fusejs.io/demo.html
// Data to search on
const list = [
{
"title": "Old Man's War",
"author": {
"firstName": "John",
"lastName": "Scalzi"
}
},
{
"title": "The Lock Artist",
"author": {
"firstName": "Steve",
"lastName": "Hamilton"
}
},
{
"title": "HTML5",
"author": {
"firstName": "Remy",
"lastName": "Sharp"
}
},
{
"title": "Right Ho Jeeves",
"author": {
"firstName": "P.D",
"lastName": "Woodhouse"
}
},
{
"title": "The Code of the Wooster",
"author": {
"firstName": "P.D",
"lastName": "Woodhouse"
}
},
{
"title": "Thank You Jeeves",
"author": {
"firstName": "P.D",
"lastName": "Woodhouse"
}
},
{
"title": "The DaVinci Code",
"author": {
"firstName": "Dan",
"lastName": "Brown"
}
},
{
"title": "Angels & Demons",
"author": {
"firstName": "Dan",
"lastName": "Brown"
}
},
{
"title": "The Silmarillion",
"author": {
"firstName": "J.R.R",
"lastName": "Tolkien"
}
},
{
"title": "Syrup",
"author": {
"firstName": "Max",
"lastName": "Barry"
}
},
{
"title": "The Lost Symbol",
"author": {
"firstName": "Dan",
"lastName": "Brown"
}
},
{
"title": "The Book of Lies",
"author": {
"firstName": "Brad",
"lastName": "Meltzer"
}
},
{
"title": "Lamb",
"author": {
"firstName": "Christopher",
"lastName": "Moore"
}
},
{
"title": "Fool",
"author": {
"firstName": "Christopher",
"lastName": "Moore"
}
},
{
"title": "Incompetence",
"author": {
"firstName": "Rob",
"lastName": "Grant"
}
},
{
"title": "Fat",
"author": {
"firstName": "Rob",
"lastName": "Grant"
}
},
{
"title": "Colony",
"author": {
"firstName": "Rob",
"lastName": "Grant"
}
},
{
"title": "Backwards, Red Dwarf",
"author": {
"firstName": "Rob",
"lastName": "Grant"
}
},
{
"title": "The Grand Design",
"author": {
"firstName": "Stephen",
"lastName": "Hawking"
}
},
{
"title": "The Book of Samson",
"author": {
"firstName": "David",
"lastName": "Maine"
}
},
{
"title": "The Preservationist",
"author": {
"firstName": "David",
"lastName": "Maine"
}
},
{
"title": "Fallen",
"author": {
"firstName": "David",
"lastName": "Maine"
}
},
{
"title": "Monster 1959",
"author": {
"firstName": "David",
"lastName": "Maine"
}
}
];

var runSearch = function() {
var i, item;

const fuseOptions = {
keys: [
"title",
"author.firstName"
]
};

// Clear the previous results
var searchResultsDiv = document.getElementById("searchResults");
searchResultsDiv.innerHTML = "";

// Run the search
const fuse = new Fuse(list, fuseOptions);
const searchTerms = document.getElementById("searchTerms").value;
const results = fuse.search(searchTerms);
if (results.length == 0) {
searchResultsDiv.innerHTML = `<p>No results were found for ${searchTerms}</p>`;
} else {
// Loop throught results and add them to the page
for(i = 0; i < results.length; i++) {
var resultEl = document.createElement("p");
var result = results[i].item;
resultEl.textContent = result.title + " by " + result.author.firstName + " " + result.author.lastName;
searchResultsDiv.appendChild(resultEl);
}
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
