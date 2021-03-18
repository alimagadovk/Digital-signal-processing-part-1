#include "stdafx.h"
#define _USE_MATH_DEFINES
#include <iostream>
#include <fstream>
#include <complex>
#include <algorithm>
#include <math.h>
#include <iterator>
#include <vector>
#include <string>
#include <cmath>
#include <time.h> 
#include <windows.h>


typedef std::complex<double> compl;
typedef std::vector<compl> vec_compl;

using namespace std;


// чтение из файла
vec_compl read(string name_f) {
	ifstream file(name_f);
	if (!file) {
		std::cout << "Can't open file\r\n";
	}
	vec_compl temp1;
	double temp2, temp3;
	if (!file.eof()) file >> temp2 >> temp3;
	while (!file.eof()) {
		temp1.push_back(compl(temp2, temp3));
		file >> temp2 >> temp3;
	}
	file.close();
	return std::move(temp1);
}

vec_compl read(string name_f, int num) {
	ifstream file(name_f);
	int  count = 0;
	if (!file) {
		std::cout << "Can't open file\r\n";
	}
	vec_compl temp1;
	double temp2, temp3;
	if (!file.eof()) file >> temp2 >> temp3;
	while (!file.eof()) {
		temp1.push_back(compl(temp2, temp3));
		file >> temp2 >> temp3;
		count++;
		if (count == num) {
			break;
		}
	}
	file.close();
	return std::move(temp1);
}

// запись в файл
bool write(vec_compl vect_in, string name_f) {
	std::ofstream file(name_f);
	if (!file) {
		std::cout << "Can't open file for writing\r\n";
		return false;
	}
	for (unsigned int i = 0; i < vect_in.size(); i++) {
		file << "    " << vect_in[i].real() << "    " << vect_in[i].imag() << endl;
	}
	file.close();
	return true;
}

// элеметы матрицы ДПФ
compl inline w_jk(unsigned int N, unsigned int j, unsigned int k, int sign) {
	return exp(compl(0, (double)sign * 2 * M_PI*(double)j*(double)k / ((double)N)));
}

// элеметы матрицы БПФ
compl inline w2_jk(unsigned int j, unsigned int k, int sign) {
	return exp(compl(0, (double)sign * 2 * M_PI*(double)j / ((double)(1 << k))));
}


// преобразование Фурье
vec_compl ft(vec_compl vect_in, int sign) {
	vec_compl result(vect_in.size());
	for (unsigned int k = 0; k < result.size(); k++) {
		for (unsigned int j = 0; j < result.size(); j++) {
			result[k] = result[k] + vect_in[j] * w_jk(vect_in.size(), j, k, sign) / sqrt((double)vect_in.size());
		}
	}
	return result;
}

// быстрое преобразование Фурье 
vec_compl fft(vec_compl vect_in, int sign, unsigned int n) {
	vec_compl result(vect_in.size());
	unsigned int N = vect_in.size();
	for (unsigned int k = 1; k <= n; k++) {
		for (unsigned int j = 0; j <= (1 << (k - 1)) - 1; j++) {
			for (unsigned int l = 0; l <= (1 << (n - k)) - 1; l++) {
				result[j*(1 << (n - k)) + l] = vect_in[j*(1 << (n - k + 1)) + l] + w2_jk(j, k, sign) * vect_in[j*(1 << (n - k + 1)) + l + (1 << (n - k))];
				result[(1 << (n - 1)) + j*(1 << (n - k)) + l] = vect_in[j*(1 << (n - k + 1)) + l] - w2_jk(j, k, sign) * vect_in[j*(1 << (n - k + 1)) + l + (1 << (n - k))];
			}
		}
		for (int i = 0; i < N; i++) {
			vect_in[i] = result[i];
		}
	}
	for (int i = 0; i < N; i++) {
		vect_in[i] = vect_in[i] / sqrt(N);
	}
	return move(vect_in);
}

// свертка
vec_compl conv(vec_compl vect_in1, vec_compl vect_in2) {
	int n1 = vect_in1.size();
	int n2 = vect_in2.size();
	vec_compl v1, v2;
	int n = max(n1, n2);
	vec_compl result(n << 1);
	v1 = vect_in1;
	v2 = vect_in2;
	v2.resize(n << 1);
	v1.resize(n << 1);
	for (int i = 0; i < (n << 1); i++) {
		for (int j = 0; j <= i; j++) {
				result[i] = result[i] + v1[j] * v2[i - j];
		}
	}
	return result;
}

// свертка с БПФ
vec_compl conv_fft(vec_compl vect_in1, vec_compl vect_in2, int n1, int n2) {
	int N1 = 1 << n1;
	int N2 = 1 << n2;
	vec_compl v1, v2;
	int N = max(N1, N2);
	vec_compl result(N << 1);
	int n = max(n1, n2) + 1;
	v1 = vect_in1;
	v2 = vect_in2;
	v2.resize(N << 1);
	v1.resize(N << 1);
	v1 = fft(v1, -1, n);
	v2 = fft(v2, -1, n);
	for (unsigned int k = 0; k < (N << 1); k++) {
		result[k] = v1[k] * v2[k] * sqrt(N << 1);
	}
	result = fft(result, 1, n);
	return result;
}

//сравнение векторов
void equal(string x1s, string x2s, string result)
{
	vec_compl x1 = read(x1s);
	vec_compl x2 = read(x2s);
	vec_compl res;
	int N = x1.size();
	int M = x2.size();
	int n = max(M, N);
	x1.resize(n);
	x2.resize(n);
	res.resize(n);
	for (int i = 0; i < n; i++) {
		res[i] = x1[i] - x2[i];
	}

	auto mmax = max_element(res.begin(), res.end(), [](compl v1, compl v2) {return abs(v1) < abs(v2); });
	cout << "Maximum deviation: ";
	cout << abs(*mmax) << endl;

	write(res, result);
}

// задание 3
void task3ft() {
	string xs = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3_x.txt";
	string ys = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3ft_y_C.txt";
	string xys = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3ft_xy.txt";
	vec_compl x = read(xs);
	vec_compl y = ft(x, -1); // ДПФ
	write(y, ys);
	y = ft(y, 1);			// ОДПФ
	write(y, xys);
}

void task3fft() {
	string xs = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3_x.txt";
	string ys = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3fft_y_C.txt";
	string xys = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3fft_xy.txt";
	vec_compl x = read(xs);
	vec_compl y = fft(x, -1, 4);
	write(y, ys);
	y = fft(y, 1, 4);
	write(y, xys);
}

// сравнение векторов задания 3
void task3_eq() {
	cout << "Check for equality ft and fft" << endl;
	string x1s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3ft_y_C.txt";
	string x2s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3fft_y_C.txt";
	string result = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3_eq1.txt";
	equal(x1s, x2s, result);

	cout << "Check for equality ift and ifft" << endl;
	x1s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3ft_xy.txt";
	x2s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3fft_xy.txt";
	result = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3_eq2.txt";
	equal(x1s, x2s, result);

	cout << "Check for equality fft and MATLAB fft" << endl;
	x1s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3_y_ml.txt";
	x2s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3fft_y_C.txt";
	result = "C:/Users/Курбан/source/repos/ConsoleApplication11/task3_eq3.txt";
	equal(x1s, x2s, result);
}

// задание 4
void task4() {
	cout << "Wait...";
	string xs = "C:/Users/Курбан/source/repos/ConsoleApplication11/task4_x.txt";
	std::ofstream file_fft("C:/Users/Курбан/source/repos/ConsoleApplication11/task4_time_fft.txt");
	std::ofstream file_ft("C:/Users/Курбан/source/repos/ConsoleApplication11/task4_time_ft.txt");
	LARGE_INTEGER timerFrequency, timerStart, timerStop;
	vec_compl x, y;
	double m_fft[50][10], m_ft[50][10];
	vector<double> ms_fft(10), ms_ft(10);
	for (int j = 0; j < 50; j++) {
		for (int i = 1; i <= 10; i++) {
			x = read(xs, (1 << i));
			QueryPerformanceFrequency(&timerFrequency);
			QueryPerformanceCounter(&timerStart);
			y = fft(x, -1, i);
			QueryPerformanceCounter(&timerStop);
			m_fft[j][i - 1] = static_cast<double>(timerStop.QuadPart - timerStart.QuadPart) / timerFrequency.QuadPart;
			QueryPerformanceFrequency(&timerFrequency);
			QueryPerformanceCounter(&timerStart);
			y = ft(x, -1);
			QueryPerformanceCounter(&timerStop);
			m_ft[j][i - 1] = static_cast<double>(timerStop.QuadPart - timerStart.QuadPart) / timerFrequency.QuadPart;
		}
	}
	for (int i = 0; i < 10; i++) {
		for (int j = 0; j < 50; j++) {
			ms_fft[i] = ms_fft[i] + m_fft[j][i];
			ms_ft[i] = ms_ft[i] + m_ft[j][i];
		}
		ms_fft[i] = ms_fft[i] / 50.;
		file_fft << ms_fft[i] << " ";

		ms_ft[i] = ms_ft[i] / 50.;
		file_ft << ms_ft[i] << " ";
	}
	file_fft.close();
	file_ft.close();
	cout << endl << "Complete!";
}

// задание 5
void task5() {
	string x1s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task5_x1.txt";
	string x2s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task5_x2.txt";
	string ys = "C:/Users/Курбан/source/repos/ConsoleApplication11/task5_y.txt";
	vec_compl x1 = read(x1s);
	vec_compl x2 = read(x2s);
	vec_compl y = conv(x1, x2);
	write(y, ys);
}

// задание 6
void task6() {
	string x1s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task5_x1.txt";
	string x2s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task5_x2.txt";
	string ys = "C:/Users/Курбан/source/repos/ConsoleApplication11/task6_y.txt";
	vec_compl x1 = read(x1s);
	vec_compl x2 = read(x2s);
	vec_compl y = conv_fft(x1, x2, 4, 4);
	write(y, ys);
}

// задание 7
void task7()
{
	cout << "Check for equality conv and MATLAB conv" << endl;
	string x1s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task5_y.txt";
	string x2s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task7_y_ml.txt";
	string result = "C:/Users/Курбан/source/repos/ConsoleApplication11/task7_eq1.txt";
	equal(x1s, x2s, result);

	cout << "Check for equality conv_fft and MATLAB conv" << endl;
	x1s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task6_y.txt";
	x2s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task7_y_ml.txt";
	result = "C:/Users/Курбан/source/repos/ConsoleApplication11/task7_eq2.txt";
	equal(x1s, x2s, result);
}

// задание 8
void task8() {
	cout << "Wait...";
	string x1s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task8_x1.txt";
	string x2s = "C:/Users/Курбан/source/repos/ConsoleApplication11/task8_x2.txt";
	std::ofstream file_fft("C:/Users/Курбан/source/repos/ConsoleApplication11/task8_time_conv_fft.txt");
	std::ofstream file_ft("C:/Users/Курбан/source/repos/ConsoleApplication11/task8_time_conv.txt");
	LARGE_INTEGER timerFrequency, timerStart, timerStop;
	vec_compl x1, x2, y;
	double m_fft[10][10], m_ft[10][10];
	vector<double> ms_fft(10), ms_ft(10);

	// одинаковой длины
	for (int j = 0; j < 10; j++) {
		for (int i = 1; i <= 10; i++) {
			x1 = read(x1s, (1 << i));
			x2 = read(x2s, (1 << i));
			QueryPerformanceFrequency(&timerFrequency);
			QueryPerformanceCounter(&timerStart);
			y = conv_fft(x1, x2, i, i);
			QueryPerformanceCounter(&timerStop);
			m_fft[j][i - 1] = static_cast<double>(timerStop.QuadPart - timerStart.QuadPart) / timerFrequency.QuadPart;
			QueryPerformanceFrequency(&timerFrequency);
			QueryPerformanceCounter(&timerStart);
			y = conv(x1, x2);
			QueryPerformanceCounter(&timerStop);
			m_ft[j][i - 1] = static_cast<double>(timerStop.QuadPart - timerStart.QuadPart) / timerFrequency.QuadPart;
		}
	}
	for (int i = 0; i < 10; i++) {
		for (int j = 0; j < 10; j++) {
			ms_fft[i] = ms_fft[i] + m_fft[j][i];
			ms_ft[i] = ms_ft[i] + m_ft[j][i];
		}
		ms_fft[i] = ms_fft[i] / 10.;
		file_fft << ms_fft[i] << " ";

		ms_ft[i] = ms_ft[i] / 10.;
		file_ft << ms_ft[i] << " ";
	}
	file_fft << endl;
	file_ft << endl;
	ms_ft.clear(); ms_ft.resize(10);
	ms_fft.clear(); ms_fft.resize(10);

	// один из векторов - фиксированной длины
	for (int j = 0; j < 10; j++) {
		for (int i = 1; i <= 10; i++) {
			x1 = read(x1s, (1 << i));
			x2 = read(x2s, (1 << 10));
			QueryPerformanceFrequency(&timerFrequency);
			QueryPerformanceCounter(&timerStart);
			y = conv_fft(x1, x2, i, 10);
			QueryPerformanceCounter(&timerStop);
			m_fft[j][i - 1] = static_cast<double>(timerStop.QuadPart - timerStart.QuadPart) / timerFrequency.QuadPart;
			QueryPerformanceFrequency(&timerFrequency);
			QueryPerformanceCounter(&timerStart);
			y = conv(x1, x2);
			QueryPerformanceCounter(&timerStop);
			m_ft[j][i - 1] = static_cast<double>(timerStop.QuadPart - timerStart.QuadPart) / timerFrequency.QuadPart;
		}
	}
	for (int i = 0; i < 10; i++) {
		for (int j = 0; j < 10; j++) {
			ms_fft[i] = ms_fft[i] + m_fft[j][i];
			ms_ft[i] = ms_ft[i] + m_ft[j][i];
		}
		ms_fft[i] = ms_fft[i] / 10.;
		file_fft << ms_fft[i] << " ";

		ms_ft[i] = ms_ft[i] / 10.;
		file_ft << ms_ft[i] << " ";
	}

	// оба вектора разной длины
	for (int j = 0; j < 10; j++) {
		for (int i = 1; i <= 5; i++) {
			x1 = read(x1s, (1 << i));
			x2 = read(x2s, (1 << (i << 1)));
			QueryPerformanceFrequency(&timerFrequency);
			QueryPerformanceCounter(&timerStart);
			y = conv_fft(x1, x2, i, i << 1);
			QueryPerformanceCounter(&timerStop);
			m_fft[j][i - 1] = static_cast<double>(timerStop.QuadPart - timerStart.QuadPart) / timerFrequency.QuadPart;
			QueryPerformanceFrequency(&timerFrequency);
			QueryPerformanceCounter(&timerStart);
			y = conv(x1, x2);
			QueryPerformanceCounter(&timerStop);
			m_ft[j][i - 1] = static_cast<double>(timerStop.QuadPart - timerStart.QuadPart) / timerFrequency.QuadPart;
		}
	}
	for (int i = 0; i < 5; i++) {
		for (int j = 0; j < 10; j++) {
			ms_fft[i] = ms_fft[i] + m_fft[j][i];
			ms_ft[i] = ms_ft[i] + m_ft[j][i];
		}
		ms_fft[i] = ms_fft[i] / 10.;
		file_fft << ms_fft[i] << " ";

		ms_ft[i] = ms_ft[i] / 10.;
		file_ft << ms_ft[i] << " ";
	}

	file_fft.close();
	file_ft.close();
	cout << endl << "Complete!";
}

void main() {
	task3ft();
	task3fft();
	task3_eq();
	task4();
	task5();
	task6();
	task7();
	task8();
	system("pause");
}