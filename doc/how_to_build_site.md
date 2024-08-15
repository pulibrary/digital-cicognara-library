# How to Build (and Update) the Digital Cicognara Library Site

## Introduction

The DCL site is generated from records in the Getty Research Portal. Those records are updated irregularly; when they are, the records must be downloaded and the site regenerated.

Doing so requires several steps:

1. Download the most recent data dump from the Getty Research Portal
2. Remove non-Cicognara records from the data dump
3. Generate a TEI file for each Getty record
4. Generate indexes on identifiers
5. Generate digital-object viewer files
6. Generate Fuse index for searching

There is a collection of Rake tasks in the `rakelib` directory that may be used to automate these processes.  You can review these tasks by typing `rake -T` on the command line.

### How to Download Data from the Getty Research Portal
From time to time, the Getty Research Portal generates a dump of all its records, so that they may be harvested (see [the FAQ](https://portal.getty.edu/faq)).

Run the rake task named `fetch_getty_records` to download the latest dump.

``` shell
rake fetch_getty_records
```

### How to Remove non-Cicognara Records from the Data Dump
The data dump contains records for *all* of the resources in the Getty Portal.  To winnow the dump to include only records specific to the Cicognara project, run the `winnow_getty_records` Rake task:


   ```shell
   rake winnow_getty_records
   ```

This will retain only records that have are part of the Getty Cicognara Collection, have a DCL number, and have a IIIF manifest.



### Generate Getty TEI files
The Marquand Library sometimes has data that differs from that in the Getty Records, and its staff asked that there be an intermediate form of the Cicognara records that they could manage. To maintain consistency with the *Catalogo*, this intermediate form is TEI XML.  Run the following rake task to generate an XML file for each Getty MARC record:


   ```shell
   rake convert_getty_to_tei
   ```
NB: The workflow for editing and managing these non-Getty changes has not been established, so running this process will overwrite all the TEI files.

### How to Generate Indexes
The Cicognara site relies on a complex mapping between "Cicognara numbers" (usually but not always entries in Cicognara's *Catalogo*) and "DCL numbers, " or Digital Chicognara Library numbers (corresponding, usually but not always, with digital objects created by partner libraries). The subsequent steps in the site-building process therefore require two indexes: one from Cicognara number to DCL number, and one from DCL number to Cicognara number.  To generate these indexes, run the `ciconum_index_generator` and the `dclnum_index_generator` Rake tasks:

   ```shell
   rake ciconum_index_generator
   rake dclnum_index_generator
   ```
NB: the dclnum_index_generator depends on the TEI derivatives of the Getty MARC records.

### How to Generate TEI files for Catalogo Items
Each item in the Catalogo (i.e., each ciconum) is represented as a TEI Corpus document.  The top-level teiHeader contains metadata derived from the Catalogo; for each dclnum associated with a particular Catalogo item, metadata from the corresponding Getty TEI record is included as a document in the corpus.

To generate these files, run the `items_generator` Rake task:

   ```shell
   rake items_generator
   ```


### How to Generate HTML files
There are two types of HTML pages in the site (besides the *Catalogo* page): a page for each entry in the *Catalogo*, displaying bibliographic metadata and a list of links to pages for each associated digital object; and a page for each of those digital objects, displaying a Mirador IIIF viewer.  Run the following shell scripts (not Rake tasks) to generate these pages:

   ```shell
   generate_item_pages
   generate_viewer_pages
   ```

### How to Generate a Search Index
Finally, generate an index used to support searching:

   ```shell
   rake generate_fuse_index
   ```
