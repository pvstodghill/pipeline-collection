# directory into which the results are written.
#DATA=.
#DATA=data # default

# ------------------------------------------------------------------------

GENOMES_DIRS=  # Points to results of pipeline-genomes
GENOMES_DIRS+=" ../genomes"
GENOMES_DIRS+=" $HOME/lab/projects/our-genomes/Pantoea_allii_*"

# ------------------------------------------------------------------------

GENOME_NAME_ARGS=
# GENOME_NAME_ARGS+=" -s" # Do not include genus/species in genome names
# GENOME_NAME_ARGS+=" -a" # Remove non-alphabetic chars from genome names
# GENOME_NAME_ARGS+=" -u" # Make genome names uppercase
# GENOME_NAME_ARGS+=" -d" # Throw error if dup names detected
GENOME_NAME_ARGS+=" -D" # Mark older redundent assemblies heuristically

# ------------------------------------------------------------------------

# accessions to exclude
COLLECT_EXCLUDE=GCF_002307475.1 # first Pantoea allii LMG 24248

# abbrevations for genome names
COLLECT_ABBREVS=
COLLECT_ABBREVS+=" Pal_=Pantoea_allii_"
COLLECT_ABBREVS+=" Pand_=Pantoea_ananatis_"

# ------------------------------------------------------------------------

# Criteria for selecting genomes for analysis
REMOVE_REDUNDENT=1
REQUIRE_BUSCO_DB=enterobacterales
REQUIRE_BUSCO_C=99
REQUIRE_BUSCO_D=2


# ------------------------------------------------------------------------

# Run <https://github.com/rrwick/Assembly-Dereplicator/>
RUN_DEREPLICATOR=1
#DEREPLICATOR_ARGS="--distance 0.001" # prune slightly
#DEREPLICATOR_ARGS="--distance 0.025" # approx one assembly per species/subspecies
DEREPLICATOR_ARGS="--count 5" # choose the distance adaptively

# ------------------------------------------------------------------------

# # Uncomment to get packages from HOWTO
# PACKAGES_FROM=howto

# Uncomment to use conda
PACKAGES_FROM=conda
CONDA_ENV=pipeline-collected

#THREADS=$(nproc --all)

# ------------------------------------------------------------------------
