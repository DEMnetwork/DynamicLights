/*
 *   Copyright (c) 2025 DEMnetwork
 *   All rights reserved.
 *
 *   Permission is hereby granted, free of charge, to any person obtaining a copy
 *   of this software and associated documentation files (the "Software"), to deal
 *   in the Software without restriction, including without limitation the rights
 *   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *   copies of the Software, and to permit persons to whom the Software is
 *   furnished to do so, subject to the following conditions:
 *
 *   The above copyright notice and this permission notice shall be included in all
 *   copies or substantial portions of the Software.
 *
 *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *   SOFTWARE.
 */

#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "miniz.h"

// ASCII-only check
int is_ascii(const char* str) {
    while (*str) {
        if ((unsigned char)*str > 127) return 0;
        str++;
    }
    return 1;
}

void zip_directory(const char* base_path, const char* relative_path, mz_zip_archive* zip) {
    char search_path[MAX_PATH];
    if (strlen(relative_path) == 0)
        snprintf(search_path, MAX_PATH, "%s\\*", base_path);
    else
        snprintf(search_path, MAX_PATH, "%s\\%s\\*", base_path, relative_path);

    WIN32_FIND_DATAA fd;
    HANDLE hFind = FindFirstFileA(search_path, &fd);
    if (hFind == INVALID_HANDLE_VALUE) {
        printf("Directory not found: %s\n", search_path);
        return;
    }

    do {
        if (strcmp(fd.cFileName, ".") == 0 || strcmp(fd.cFileName, "..") == 0) continue;
        if (!is_ascii(fd.cFileName)) {
            printf("Skipping non-ASCII path: %s\n", fd.cFileName);
            continue;
        }

        char full_path[MAX_PATH];
        char zip_path[MAX_PATH];

        if (strlen(relative_path) == 0) {
            snprintf(full_path, MAX_PATH, "%s\\%s", base_path, fd.cFileName);
            snprintf(zip_path, MAX_PATH, "%s", fd.cFileName);
        } else {
            snprintf(full_path, MAX_PATH, "%s\\%s\\%s", base_path, relative_path, fd.cFileName);
            snprintf(zip_path, MAX_PATH, "%s/%s", relative_path, fd.cFileName);
        }

        if (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
            char folder_path[MAX_PATH];
            snprintf(folder_path, MAX_PATH, "%s/", zip_path);
            mz_zip_writer_add_mem(zip, folder_path, NULL, 0, MZ_BEST_COMPRESSION);
            zip_directory(base_path, zip_path, zip);
        } else {
            if (!mz_zip_writer_add_file(zip, zip_path, full_path, NULL, 0, MZ_BEST_COMPRESSION)) {
                printf("Failed to add file: %s\n", full_path);
            } else {
                printf("Added: %s\n", zip_path);
            }
        }
    } while (FindNextFileA(hFind, &fd));
    FindClose(hFind);
}

int main(int argc, char* args[]) {
    if (argc != 3) {
        printf("Usage: %s <source_dir> <target_zip>\n", args[0]);
        return 3;
    }

    mz_zip_archive zip;
    memset(&zip, 0, sizeof(zip));

    if (!mz_zip_writer_init_file(&zip, args[2], 0)) {
        printf("Failed to initialize ZIP file: %s\n", args[2]);
        return 1;
    }

    zip_directory(args[1], "", &zip);

    mz_zip_writer_finalize_archive(&zip);
    mz_zip_writer_end(&zip);

    printf("ZIP created successfully: %s\n", args[2]);
    return 0;
}