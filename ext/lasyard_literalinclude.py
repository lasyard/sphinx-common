from sphinx.directives.code import LiteralInclude
from docutils import nodes

import re

# Map file extensions to Sphinx's Pygments language names
EXT_LANG_MAP = {
    ".txt": "text",
    ".yaml": "yaml",
    ".yml": "yaml",
    ".json": "json",
    ".sql": "sql",
    ".properties": "properties",
    ".py": "python",
    ".js": "javascript",
    ".ts": "typescript",
    ".c": "c",
    ".cpp": "cpp",
    ".h": "c",
    ".hpp": "cpp",
    ".css": "css",
    ".html": "html",
    ".xml": "xml",
    ".rst": "rst",
    ".md": "markdown",
    ".sh": "bash",
    ".ini": "ini",
    ".toml": "toml",
    ".go": "go",
    ".rb": "ruby",
    ".java": "java",
    ".php": "php",
    ".lua": "lua",
    ".rs": "rust",
    ".swift": "swift",
}

def guess_language(filename):
    import os
    _, ext = os.path.splitext(filename)
    return EXT_LANG_MAP.get(ext.lower())

def strip_diff_headers(diff_text):
    lines = diff_text.splitlines(keepends=True)
    header_re = re.compile(r"^---|^\+\+\+")
    return ''.join(line for line in lines if not header_re.match(line))

class LasyardLiteralInclude(LiteralInclude):
    def run(self):
        # Only set language if not given
        if "language" not in self.options or not self.options["language"]:
            if self.arguments:
                filename = self.arguments[0]
                lang = guess_language(filename)
                if lang:
                    self.options["language"] = lang
        if 'diff' in self.options:
            [result] = super().run()
            stripped = strip_diff_headers(result.astext())
            new_result = nodes.literal_block(stripped, stripped, language="udiff")
            return [new_result]
        return super().run()

def setup(app):
    app.add_directive("literalinclude", LasyardLiteralInclude, override=True)
    return {
        "version": "1.0",
        "parallel_read_safe": True,
        "parallel_write_safe": True,
    }
