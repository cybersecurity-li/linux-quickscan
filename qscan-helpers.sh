detail_log='detailed.log';



# Prints a formatted title to output and qdetailed.log
# $1: Title text (optional)
qtitle() {
    title_text="${1}";
    printf '\n|===================================\n' \
        | tee -a "${detail_log}";
    printf '|%s\n|\n\n' "${title_text}" \
        | tee -a "${detail_log}";
}
