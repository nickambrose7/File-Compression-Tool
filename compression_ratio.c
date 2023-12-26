#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <original file> <compressed file>\n", argv[0]);
        return 1;
    }

    FILE *original = fopen(argv[1], "rb");
    if (!original) {
        perror("Failed to open original file");
        return 2;
    }

    FILE *compressed = fopen(argv[2], "rb");
    if (!compressed) {
        perror("Failed to open compressed file");
        fclose(original);
        return 3;
    }

    fseek(original, 0, SEEK_END);
    fseek(compressed, 0, SEEK_END);

    long originalSize = ftell(original);
    long compressedSize = ftell(compressed);

    fclose(original);
    fclose(compressed);

    if (originalSize == 0) {
        fprintf(stderr, "Original file size is 0, cannot compute compression.\n");
        return 4;
    }

    double compressionRatio = (double)compressedSize / originalSize;
    printf("Compression ratio: %.2f%%\n", (1 - compressionRatio) * 100);

    return 0;
}
