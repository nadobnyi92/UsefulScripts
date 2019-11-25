#!/bin/bash
find . -name '*.[cpp|c|h|hpp|py]' -type f | xargs cat | wc -l
