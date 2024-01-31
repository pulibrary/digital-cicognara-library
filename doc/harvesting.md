# Harvesting metadata from the Getty Research Portal

1. Download the most recent data dump from the Getty Research Portal
   ```
   rake fetch_getty_records
   ```

2. Remove non-Cicognara records from the data dump
   ```
   rake winnow_getty_records
   ```

3. Generate TEI fragments
   ```
   rake convert_getty_to_tei
   ```

4. Generate indexes on identifiers
   ```
   rake generate_ciconum_index
   rake generate_dclnum_index
   ```

5. Generate digital object viewer files
   ```
   rake generate_item_files
   ```

6. Generate the Fuse index for searching
   ```
   rake generate_fuse_index
   ```
