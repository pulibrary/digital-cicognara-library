# Digital Cicognara Library #
This repository combines the data and code from two earlier project repositories into a single source for the DCL.

  * *cicognara-catalogo*  a repository for managing the TEI-encoded edition of Cicognara's catalog. The original repository also contained some old code for managing associated Voyager records and a set of scripts and programs that were used to gather data and statistics about the catalogo items and their corresponding dclnums.
  
  * *cicognara-static*  a repository containing the static site for the project and the Jekyll machinery for generating it.  This static site replaces the outdated Rails app originally developed for the Digital Cicognara Project.
  
## Repository Structure  ##
  * *apps/*  This directory is for applications related to the Cicognara Digital Library and the Digital Cicognara Project.  At the moment, it contains a single application, the static website application.
  
  * *data/*  This directory contains the principal assets of the Project: the TEI encoding of Cicognara's *Catalogo Ragionato*, and metadata about the surrogates being compiled by the Project partners.  It also contains several indexes used by the static website builder and the Project maintainers.
  
  * *docs/* A directory of documentation about the way the Project models the *Catalogo*, the items it contains, and the surrogate resources being digitized by the Partner institutions.


## Managing Tasks with Rake ##

The DCL contains [rake tasks](https://www.rubyguides.com/2019/02/ruby-rake/) that may be used to download metadata from the Getty Portal and convert it into formats used by the static web application. **NB**: these tasks are being deprecated in favor of a more targeted ingest of Getty-portal metadata, which will allow for local curation and augmentation of the data managed by the Project and displayed on its websites.
