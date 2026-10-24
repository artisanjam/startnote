# Useful timestamps in Universal Coordinated Time (UTC) using `date`.
#
# Author: Jay P.

# Long, human-readable timestamp in UTC.
timestamp() {
    date -u "+%Y-%m-%dT%H:%M:%S.%NZ"
} 

# Compact timestamp in UTC.
minstamp() {
    date -u "+%Y%m%dT%H%MZ"
}
