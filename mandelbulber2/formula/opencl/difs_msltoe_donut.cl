/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * DIFSMsltoeDonutIteration
 * @reference
 * http://www.fractalforums.com/new-theories-and-research/
 * low-hanging-dessert-an-escape-time-donut-fractal/msg90171/#msg90171

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "DIFSMsltoeDonutIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 DIFSMsltoeDonutIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 zt = z;
	REAL radius2 = fractal->donut.ringThickness;
	REAL nSect = native_divide(M_PI_2x, fractal->donut.number);

	REAL R2 = fractal->donut.ringRadius - native_sqrt(mad(z.x, z.x, z.y * z.y));
	R2 *= R2;
	REAL t = R2 + mad(z.z, z.z, -radius2 * radius2);
	REAL theta2 = nSect * round(native_divide(atan2(z.y, z.x), nSect));

	if (t > 0.03f)
	{
		REAL c1 = native_cos(theta2);
		REAL s1 = native_sin(theta2);

		z.x = mad(c1, zt.x, s1 * z.y) - fractal->donut.ringRadius;
		z.z = mad(-s1, zt.x, c1 * z.y); // z.y z.z swap
		z.y = zt.z;
		z *= fractal->donut.factor;
		aux->DE *= fractal->donut.factor;
	}
	else
	{
		z /= t;
	}

	t = native_sqrt(mad(zt.z, zt.z, R2)) - radius2;
	aux->dist = min(aux->dist, native_divide(t, (aux->DE + 1.0f)));

	// aux->color
	if (fractal->foldColor.auxColorEnabled) aux->color += fractal->foldColor.difs1;
	return z;
}