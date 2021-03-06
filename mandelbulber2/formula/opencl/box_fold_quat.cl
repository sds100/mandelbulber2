/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * BoxFold Quaternion
 * This formula contains aux.color, aux.pos_neg and aux.actualScale
 * Sometimes Delta DE Linear works best.

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "BoxFoldQuatIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 BoxFoldQuatIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// REAL4 c = aux->const_c;
	REAL colorAdd = 0.0f;
	REAL rrCol = 0.0f;
	REAL4 zCol = z;
	REAL4 oldZ = z;
	// tglad fold
	if (aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
	{
		z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
					- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
		z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
					- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;
		z.z = fabs(z.z + fractal->transformCommon.additionConstant111.z)
					- fabs(z.z - fractal->transformCommon.additionConstant111.z) - z.z;
		zCol = z;
	}

	// spherical fold
	if (aux->i >= fractal->transformCommon.startIterationsS
			&& aux->i < fractal->transformCommon.stopIterationsS)
	{

		REAL rr = dot(z, z);
		rrCol = rr;
		z += fractal->mandelbox.offset;

		// if (r2 < 1e-21f) r2 = 1e-21f;
		if (rr < fractal->transformCommon.minR2p25)
		{
			REAL tglad_factor1 =
				native_divide(fractal->transformCommon.maxR2d1, fractal->transformCommon.minR2p25);
			z *= tglad_factor1;
			aux->DE *= tglad_factor1;
		}
		else if (rr < fractal->transformCommon.maxR2d1)
		{
			REAL tglad_factor2 = native_divide(fractal->transformCommon.maxR2d1, rr);
			z *= tglad_factor2;
			aux->DE *= tglad_factor2;
		}
		z -= fractal->mandelbox.offset;
	}
	// scale
	if (aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{

		REAL useScale = aux->actualScaleA + fractal->transformCommon.scale;

		z *= useScale;
		aux->DE = aux->DE * fabs(useScale);

		if (aux->i >= fractal->transformCommon.startIterationsX
				&& aux->i < fractal->transformCommon.stopIterationsX)
		{
			// update actualScale for next iteration
			REAL vary = fractal->transformCommon.scaleVary0
									* (fabs(aux->actualScaleA) - fractal->transformCommon.scaleB1);
			if (fractal->transformCommon.functionEnabledMFalse)
				aux->actualScaleA = -vary;
			else
				aux->actualScaleA = aux->actualScaleA - vary;
		}
	}

	if (fractal->transformCommon.functionEnabledXFalse
			&& aux->i >= fractal->transformCommon.startIterationsTM
			&& aux->i < fractal->transformCommon.stopIterationsTM1)
	{
		REAL tempXZ = mad(z.x, SQRT_2_3, -z.z * SQRT_1_3);
		z = (REAL4){
			(tempXZ - z.y) * SQRT_1_2, (tempXZ + z.y) * SQRT_1_2, z.x * SQRT_1_3 + z.z * SQRT_2_3, z.w};
		REAL4 temp = z;
		REAL tempL = length(temp);
		z = fabs(z) * fractal->transformCommon.scale3D333;
		// if (tempL < 1e-21f) tempL = 1e-21f;
		REAL avgScale = native_divide(length(z), tempL);
		aux->DE = aux->DE * avgScale;
		z = (fabs(z + fractal->transformCommon.additionConstantA111)
				 - fabs(z - fractal->transformCommon.additionConstantA111) - z);
		tempXZ = (z.y + z.x) * SQRT_1_2;
		z = (REAL4){z.z * SQRT_1_3 + tempXZ * SQRT_2_3, (z.y - z.x) * SQRT_1_2,
			z.z * SQRT_2_3 - tempXZ * SQRT_1_3, z.w};
	}

	// octo
	if (fractal->transformCommon.functionEnabledDFalse
			&& aux->i >= fractal->transformCommon.startIterationsD
			&& aux->i < fractal->transformCommon.stopIterationsD)

	{
		if (z.x + z.y < 0.0f) z = (REAL4){-z.y, -z.x, z.z, z.w};

		if (z.x + z.z < 0.0f) // z.xz = -z.zx;
			z = (REAL4){-z.z, z.y, -z.x, z.w};

		if (z.x - z.y < 0.0f) // z.xy = z.yx;
			z = (REAL4){z.y, z.x, z.z, z.w};

		if (z.x - z.z < 0.0f) // z.xz = z.zx;
			z = (REAL4){z.z, z.y, z.x, z.w};

		z.x = fabs(z.x);
		z = mad(z, fractal->transformCommon.scaleA2,
			-fractal->transformCommon.offset100 * (fractal->transformCommon.scaleA2 - 1.0f));

		aux->DE *= fabs(fractal->transformCommon.scaleA2);
	}

	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);

	if (fractal->transformCommon.functionEnabledFFalse
			&& aux->i >= fractal->transformCommon.startIterationsM
			&& aux->i < fractal->transformCommon.stopIterationsM)
	{ // fabs() and menger fold
		z = fabs(z + fractal->transformCommon.additionConstantA000);
		if (z.x - z.y < 0.0f)
		{
			REAL temp = z.y;
			z.y = z.x;
			z.x = temp;
		}
		if (z.x - z.z < 0.0f)
		{
			REAL temp = z.z;
			z.z = z.x;
			z.x = temp;
		}
		if (z.y - z.z < 0.0f)
		{
			REAL temp = z.z;
			z.z = z.y;
			z.y = temp;
		}
		// menger scales and offsets
		z *= fractal->transformCommon.scale2;
		z.x -= 2.0f * fractal->transformCommon.constantMultiplier111.x;
		z.y -= 2.0f * fractal->transformCommon.constantMultiplier111.y;
		z.z -= 2.0f * fractal->transformCommon.constantMultiplier111.z;
		aux->DE *= fractal->transformCommon.scale2;
	}

	if (aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		aux->r = length(z);
		aux->DE = aux->DE * 2.0f * aux->r;

		if (fractal->analyticDE.enabledFalse)
		{
			aux->DE = mad(aux->DE, fractal->analyticDE.scale1, fractal->analyticDE.offset1);
		}
		z = (REAL4){z.x * z.x - z.y * z.y - z.z * z.z, z.x * z.y, z.x * z.z, z.w};

		REAL tempL = length(z);
		z *= fractal->transformCommon.constantMultiplier122;
		// if (tempL < 1e-21f) tempL = 1e-21f;
		REAL4 tempAvgScale = (REAL4){z.x, native_divide(z.y, 2.0f), native_divide(z.z, 2.0f), z.w};
		REAL avgScale = native_divide(length(tempAvgScale), tempL);
		REAL tempAux = aux->DE * avgScale;
		aux->DE = mad(fractal->transformCommon.scaleA1, (tempAux - aux->DE), aux->DE);

		if (fractal->transformCommon.functionEnabledAxFalse)
		{
			REAL4 offsetAlt = aux->pos_neg * fractal->transformCommon.additionConstant000;
			z += offsetAlt;
			aux->pos_neg *= -fractal->transformCommon.scale1;
		}
		else
		{
			z += fractal->transformCommon.additionConstant000;
		}
	}

	if (fractal->foldColor.auxColorEnabledFalse)
	{
		if (zCol.x != oldZ.x)
			colorAdd += fractal->mandelbox.color.factor.x
									* (fabs(zCol.x) - fractal->transformCommon.additionConstant111.x);
		if (zCol.y != oldZ.y)
			colorAdd += fractal->mandelbox.color.factor.y
									* (fabs(zCol.y) - fractal->transformCommon.additionConstant111.y);
		if (zCol.z != oldZ.z)
			colorAdd += fractal->mandelbox.color.factor.z
									* (fabs(zCol.z) - fractal->transformCommon.additionConstant111.z);

		if (rrCol < fractal->transformCommon.maxR2d1)
		{
			if (rrCol < fractal->transformCommon.minR2p25)
				colorAdd +=
					mad(fractal->mandelbox.color.factorSp1, (fractal->transformCommon.minR2p25 - rrCol),
						fractal->mandelbox.color.factorSp2
							* (fractal->transformCommon.maxR2d1 - fractal->transformCommon.minR2p25));
			else
				colorAdd += fractal->mandelbox.color.factorSp2 * (fractal->transformCommon.maxR2d1 - rrCol);
		}

		aux->color += colorAdd;
	}
	return z;
}