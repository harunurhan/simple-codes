#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>


#include <stdio.h>
#define M 16 //row
#define N 16
#define THREAD_PER_BLOCK_X 2;
#define THREAD_PER_BLOCK_Y 2; 

__global__ void transposeMatrix(int *a, int *c)
{
	int row = blockIdx.x * blockDim.x + threadIdx.x;
	int column = blockIdx.y * blockDim.y + threadIdx.y;
	int index = row * M + column;
	int indexT = column * N + row;
	c[indexT] = a[index];
}

int main()
{
	int a[M][N], c[N][M];
	int *d_a, *d_c;
	int size = sizeof(int) * N * M;
	cudaMalloc((void **)&d_a, size);
	cudaMalloc((void **)&d_c, size);

	//init matrix
	int i, j;
	for (i = 0; i < M; i++) {
		for (j = 0; j < N; j++) {
			a[i][j] = i;
			printf("%d ", a[i][j]);
		}
		printf("\n");
	}
	printf("*********\n");
	cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);

	dim3 grid, block;
	grid.x = M / THREAD_PER_BLOCK_X;
	grid.y = N / THREAD_PER_BLOCK_Y;

	block.x = THREAD_PER_BLOCK_X;
	block.y = THREAD_PER_BLOCK_Y;

	transposeMatrix<<<grid, block>>>(d_a, d_c);
	cudaDeviceSynchronize(); //is it necessary?

	cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

	//print result
	int m, n;
	for (m = 0; m < M; m++) {
		for (n = 0; n < N; n++) {
			printf("%d ", c[m][n]);
		}
		printf("\n");
	}

	cudaFree(d_a);
	cudaFree(d_c);

	return 0;
}