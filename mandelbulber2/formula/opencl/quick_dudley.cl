/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * From M3D
 * @reference http://www.fractalforums.com/3d-fractal-generation/another-shot-at-the-holy-grail/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "QuickDudleyIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 QuickDudleyIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	aux->DE = mad(aux->DE * 2.0f * aux->r, fractal->analyticDE.scale1, fractal->analyticDE.offset1);
	REAL x2 = z.x * z.x;
	REAL y2 = z.y * z.y;
	REAL z2 = z.z * z.z;
	REAL newx = mad(-z.z, 2.0f * z.y, x2);
	REAL newy = mad(z.y, 2.0f * z.x, z2);
	REAL newz = mad(z.z, 2.0f * z.x, y2);
	z.x = newx;
	z.y = newy;
	z.z = newz;
	return z;
}