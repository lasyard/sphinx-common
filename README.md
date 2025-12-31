# sphinx-common

Common staffs used by sphinx documentation projects.

## Usage

In your project directory:

```sh
git submodule add git@github.com:lasyard/sphinx-common.git
```

First of all, add the sub directory to exclude patterns to prevent it from being parsed by Sphinx. In the configuration file (generally `conf.py`) file of your project:

```py
exclude_patterns += ['sphinx-common']
```

### Extensions

In the configuration file:

```py
from pathlib import Path

sys.path.append(str(Path('sphinx-common/ext').resolve()))

extensions += [
    'lasyard_literalinclude',
    'ellipsis_to_vertical',
]
```

The `lasyard_literalinclude` is an override of the standard `literalinclude` directive, which have the following features:

- Automatically set `language` option according to the extension of included file
- Remove the `---`, `+++` headers if `diff` options is used to hide the file paths which may be sensitive

The `ellipsis_to_vertical` is to replace single lines of `...` to vertical `⋮`s in literal blocks if the language is `console`.

### Styles

CSS files were provided to adjust the appearance of html pages. In the configuration file:

```py
html_static_path = ['sphinx-common/static']

if html_theme == 'sphinx_rtd_theme':
    html_css_files = ['lasyard_sphinx_rtd_theme.css']
```

### Scripts

There are scripts to build `drawio` and `puml` files to `png` files, just run in the root of source directory:

```sh
sphinx-common/scripts/build.sh
```

Or clean the output images by:

```sh
sphinx-common/scripts/build.sh clean
```

Note `drawio` and `plantuml` tools must be installed, and the varible `DRAWIO_CMD` and `PUML_CMD` in file `drawio.mk` and `puml.mk` may need to be changed to the real path of the tools.

The default image source files is searched in directory `_images` and the target images is in `_generated_images`.

### MIT License

<https://lasy.fwh.is/mit_license>
