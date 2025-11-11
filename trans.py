import re

lower_exceptions = {"and", "or", "the", "in", "on", "with", "for", "to", "at", "by", "of", "vs"}

def is_all_lower(word: str) -> bool:
    return word.isalpha() and word == word.lower()

def capitalize_word(word: str, is_first: bool) -> str:
    if not is_all_lower(word):
        return word
    lw = word.lower()
    if is_first:
        return lw.capitalize()
    if lw in lower_exceptions:
        return lw
    return lw.capitalize()

def capitalize_segment(text: str) -> str:
    parts = re.split(r'(\W+)', text)
    result = []
    first = True
    for p in parts:
        if not p.isalpha():
            result.append(p)
            continue
        result.append(capitalize_word(p, first))
        first = False
    return "".join(result)

def capitalize_prefix(prefix: str) -> str:
    parts = re.split(r'(\W+)', prefix)
    result = []
    for p in parts:
        if not p.isalpha():
            result.append(p)
            continue
        if is_all_lower(p):
            result.append(p.capitalize())
        else:
            result.append(p)
    return "".join(result)

def capitalize_title(title: str) -> str:
    if ":" in title:
        prefix, rest = title.split(":", 1)
        new_prefix = capitalize_prefix(prefix)
        return new_prefix + ":" + capitalize_segment(rest)
    return capitalize_segment(title)

def process_bib_file(input_path, output_path):
    with open(input_path, "r", encoding="utf-8") as f:
        content = f.read()

    def repl(match):
        original = match.group(1)
        new_title = capitalize_title(original)
        return f"title={{{{{new_title}}}}}"

    new_content = re.sub(r'title=\{\{(.*?)\}\}', repl, content, flags=re.DOTALL)

    with open(output_path, "w", encoding="utf-8") as f:
        f.write(new_content)

# Example usage:
process_bib_file("p.bib", "p_new.bib")
