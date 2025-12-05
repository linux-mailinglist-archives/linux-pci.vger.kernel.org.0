Return-Path: <linux-pci+bounces-42699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6996CA7E89
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 15:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FCA83092F41
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 14:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483D228852B;
	Fri,  5 Dec 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="Idk5TT7Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E6261B9D
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764944162; cv=none; b=fPOI+1UFJltpOQb9S39UGY6s3vtFWfUZ6sIM7mJoewhTwVqPQ0dprNtqAlTvWgrSnzlbZgcr2VW2RIMwRiFutJHB0n6BNz0ENFgwv3jMGSR90awnRusqJfdKzYlR/8ZQMwf7Uun5ZYeDMhLGeEtaS8rvFL2/N3AjmRn9y186FzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764944162; c=relaxed/simple;
	bh=ELoSBBujhNy8F1ARZKXk+hLYwup56GKsOiwJvHLxoa8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mkZHW6aEcZ+se8yDZrP3ct/R83+WBcWedr1MGPuTP+JlrDvJ8SJ32mUDBdFfmTaTlagMvsRJoNPQ0O6CwWr4YupvFpWvB+kPjDm3tPJ49LSGvYyzQoThdrkNFt5VFaIbl9F1O7J+KS+KlALXikZmOSk6wCJt7BBmfQ+aPOynD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=Idk5TT7Q; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1764944146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faEdQwyqALbEvfgGmDIxXomnR131YER9QVOUbxN2Vfw=;
	b=Idk5TT7QPwh/gNKN4gh1LhQ8PaTc8RWP2Noj9basMbh+dFn+ErvaCbeiiJPg/cqZm+K1n5
	E2n3olE5h83ofUsdjeOIff+MxHzV6OUjgQLAq+CskrwpqFtJJyAaU4VvwSSJgo18RqIe/Y
	AA1aoaVoXVq9xdqPIUzPgiqTEEqavas6MkCPxWB0eWMT34NcvTTQxpzgFzUay5R+uP++CB
	NodoSZG5OpzLbkufKbianG4h8Q031ftaPJbcU+SDNNA3blbtiYtOGJyWsagvDb3SkY/YpF
	YlViJArhEm6XZ4WZ5DZwWEA2vdpBdPiMKHxs25ebPdjb2DZG1Cn1Raina9uu6A==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Dec 2025 15:15:39 +0100
Message-Id: <DEQCHCIUQ8KK.DXHGCLW95XUC@cknow-tech.com>
Cc: "Haotian Zhang" <vulab@iscas.ac.cn>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] regulator: fixed: Rely on the core freeing the enable
 GPIO
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Mark Brown" <broonie@kernel.org>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Diederik de Haas" <diederik@cknow-tech.com>
References: <20251204-regulator-fixed-fix-gpiod-leak-v1-1-48efea5b82c2@kernel.org>
In-Reply-To: <20251204-regulator-fixed-fix-gpiod-leak-v1-1-48efea5b82c2@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu Dec 4, 2025 at 8:39 PM CET, Mark Brown wrote:

s/enable GPIO/enabled GPIOs/ ? (in Subject)

> In order to simplify ownership rules for enable GPIOs supplied by drivers
> regulator_register() always takes ownership of them, even if it ends up
> failing for some other reason. We therefore should	not free the GPIO if
> registration fails but just let the core worry about things.

I built a 6.18 kernel with this patch added and that fixed the problem.
Thanks :-) Feel free to add:

Tested-by: Diederik de Haas <diederik@cknow-tech.com>

Cheers,
  Diederik

> Fixes: 636f4618b1cd (regulator: fixed: fix GPIO descriptor leak on regist=
er failure)
> Reported-by: Diederik de Haas <diederik@cknow-tech.com>
> Closes: https://lore.kernel.org/r/DEPEYUF5BRGY.UKFBWRRE8HNP@cknow-tech.co=
m
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/regulator/fixed.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> index a2d16e9abfb5..254c0a8a4555 100644
> --- a/drivers/regulator/fixed.c
> +++ b/drivers/regulator/fixed.c
> @@ -330,13 +330,10 @@ static int reg_fixed_voltage_probe(struct platform_=
device *pdev)
> =20
>  	drvdata->dev =3D devm_regulator_register(&pdev->dev, &drvdata->desc,
>  					       &cfg);
> -	if (IS_ERR(drvdata->dev)) {
> -		ret =3D dev_err_probe(&pdev->dev, PTR_ERR(drvdata->dev),
> -				    "Failed to register regulator: %ld\n",
> -				    PTR_ERR(drvdata->dev));
> -		gpiod_put(cfg.ena_gpiod);
> -		return ret;
> -	}
> +	if (IS_ERR(drvdata->dev))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->dev),
> +				     "Failed to register regulator: %ld\n",
> +				     PTR_ERR(drvdata->dev));
> =20
>  	platform_set_drvdata(pdev, drvdata);
> =20
>
> ---
> base-commit: 81d431130ae1af4e64030f6a956ee9137e6fc1b0
> change-id: 20251204-regulator-fixed-fix-gpiod-leak-b1f50fb8c388
>
> Best regards,
> -- =20
> Mark Brown <broonie@kernel.org>


