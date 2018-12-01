# CSE305 Movie Database

This is a final project for CSE305 of Fall 2018. We are creating a movie database with movies after 2013 and an interface that allows users to interact with the database and find movies they like.

## How to Use

Enter desired keywords and select desired categories in webpage, and click search.

## Developer Notes

Reusable display elements (i.e. search bar.) have all been broken down in a component based system
that resides in html_compomnents. Jquery is used to assemble these pages dynamically from user queries - the templates can be found in the "views" folder.

Esj is used to load information from postgres query.

Please remember that video URLs should preferrably be 'embed' youtube URLs. The default 'watch' url will not function for displays if used.

## Team Members

* Jeremy Ahn
* Peter Ly

## Languages Utilizied

* postgresql
* HTML
* Node.js
* Jquery