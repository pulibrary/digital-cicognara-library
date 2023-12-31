# Modeling Items in the *Catalogo Ragionato* 

Cicognara\'s *Catalogo* is not a modern library catalog. While many of
its entries refer to single volumes in Cicognara\'s collection, others
refer to multi-volume works or groups of related printed matter or
manuscripts. Some entries refer to unique bindings of materials
(\"Sammelbands\") in Cicognara\'s collection. Thus the model of a modern
library catalog, with catalog items modeled in MARC records, is a poor
fit.

The modeling becomes even more complex when trying to associate
analogues to Cicognara\'s physical texts with the entries in his
*Catalogo*. This was the primary motivation for the Digital Cicognara
Project: to identify accessible items that correspond with Cicognara\'s
holdings, digitize them at high resolution, and offer them to readers as
simulacra of Cicognara\'s actual volumes, which are too fragile to be
handled and whose microfilm reproductions are unlovely. In some cases,
partner libraries hold copies of Cicognara\'s holdings: items from the
same publication manifestation. For readers whose motive is to access
the text Cicognara collected, these copies are sufficiently true; for
those whose aim is to study the physical manifestation --- to look at
annotations, or the physical condition of the volume or the pages ---
such substitutes are utterly inadequate (the bitonal micro-photographic
images, unpleasing as they may be, are more satisfactory for this use
case).

But these are simple correspondences. The librarians developing the
Digital Cicognara Library aim to provide \"good-enough\" substitutes to
a particular class of reader: a reader interested in the general text of
Cicognara\'s collected items, relatively regardless of its fidelity to
Cicognara\'s holdings. In the judgment of these librarians, quite a wide
range of bibliographic items may satisfy this goal. In addition to
copies of the same manifestation, other printings and other editions are
sufficiently similar; likewise individual volumes of multi-volume works
are valuable, even if they are incomplete.

In creating the Digital Cicognara Library, we have two data sources:
Cicognara\'s *Catalogo* itself, encoded in TEI, and MARC records for the
partner holdings. The DCL librarians have annotated the *Catalogo* items
with pointers to corresponding editions (via identifiers called
dclnums); the digitization partners have included dclnums in their MARC
records.

To maintain a consistent data representation, and to make it possible
for us to curate the data used to run the applications, we represent
each *Catalogo* Item as a \<teiCorpus\> object. This object contains the
metadata from the *Catalogo* entry (formalized into a structured record
in the \<teiHeader\>) and a collection of \<TEI\> documents, each one a
translation of a partner record, containing metadata elements derived
from the MARC and a link (a \<facsimile\> object) to the IIIF manifest
for the partner item.
