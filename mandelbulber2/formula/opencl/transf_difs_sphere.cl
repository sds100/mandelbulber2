/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * TransfDifsSphereIteration  fragmentarium code, mdifs by knighty (jan 2012)

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfDIFSSphereIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfDIFSSphereIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 zc = z;

	REAL vecLen;
	if (!fractal->transformCommon.functionEnabled4dFalse)
		vecLen =length((REAL3){(zc.x, zc.y, zc.z});
	else
		vecLen = length(zc);

	REAL spD = vecLen - fractal->transformCommon.offsetR1;

	aux->dist = min(aux->dist, native_divide(spD, aux->DE));
	return z;
}
