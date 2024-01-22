Return-Path: <linux-pci+bounces-2410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED17835E98
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD0F281922
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD663AC34;
	Mon, 22 Jan 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvxWjROX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34113A1DF;
	Mon, 22 Jan 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916876; cv=none; b=MszXcqMQ1YTUrUQjxP4KMWjBCdByERlfbFVT1iGx60JTOgd/jNXbo8NvlVEwGSAymFy6R0ElMpKBAYvXzVjkGRzwhXK6CNYap3ha0V8gIOnDTp5Do8VHk/eqZxQu4rmic3OKnyoVJNIytZc4JPJUp9P/CqyjsOZFnlWsFwgzRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916876; c=relaxed/simple;
	bh=1eeeFMJuwEGvEGwe1mAIgVTWo7sLJAozc02+4nfg3IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hE3BTwGWMmXVsPxMmIJbrur7aJjOENFhncljTTmhtYMze29xkIEq2K8EbX4w2ViW+mZPIDQqQO1aFwlVw9zQ0NU0AfF+NC9b9t47rwFNo/7vZt2elXrEK17tudXW59A65wXj98X2J2cQfYWX4GgPYvIMd+g4kf1Tz5+ZWi257DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvxWjROX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FEEC43390;
	Mon, 22 Jan 2024 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705916876;
	bh=1eeeFMJuwEGvEGwe1mAIgVTWo7sLJAozc02+4nfg3IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvxWjROXM9JxEVJqOxHuC/R7Eokuk6tNp79nmnzJ6qyb5Trz2Q0lcDQ6XBGxRWbha
	 eFgpTDT/Ur405ErTFOtijonDrIbIbH6m9njidlyr0YOOYp6iJDMARizchJnyLKaHz6
	 L37NP6efhzj2q5ZFeySGOqHZvwkchnDUYeDhrrKqquUp5cjxCWGgTU99qQaKhmaFpV
	 4Eu9rwsMo23OTk07hBTcEUXs+CeksJYRmAl8JqcjZNeu/Q2b7oqumIruBRZjvt8Z+x
	 tWpAzhXb6slgvsq5LaFI7R0+hJ+wjAn9sNU+WmpgplIGcXLz6w9lXGHP8OyvBTO6sW
	 E23da5aEYAcbw==
Date: Mon, 22 Jan 2024 09:47:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, afd@ti.com,
	srk@ti.com
Subject: Re: [PATCH v2] dt-bindings: PCI: ti,j721e-pci-host: Add support for
 J722S SoC
Message-ID: <20240122-getting-drippy-bb22a0634092@spud>
References: <20240122064457.664542-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MB4v+1ZTataoFot5"
Content-Disposition: inline
In-Reply-To: <20240122064457.664542-1-s-vadapalli@ti.com>


--MB4v+1ZTataoFot5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:14:57PM +0530, Siddharth Vadapalli wrote:
> TI's J722S SoC has one instance of a Gen3 Single-Lane PCIe controller.
> The controller on J722S SoC is similar to the one present on TI's AM64
> SoC, with the difference being that the controller on AM64 SoC supports
> up to Gen2 link speed while the one on J722S SoC supports Gen3 link speed.
>=20
> Update the bindings with a new compatible for J722S SoC.

Since the difference is just that this device supports a higher link
speed, should it not have a fallback compatible to the am64 variant?
Or is the programming model different for this device for the lower link
speeds different?

Thanks,
Conor.

>=20
> Technical Reference Manual of J722S SoC: https://www.ti.com/lit/zip/spruj=
b3
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>=20
> Hello,
>=20
> This patch is based on linux-next tagged next-20240122.
>=20
> v1:
> https://lore.kernel.org/r/20240117102526.557006-1-s-vadapalli@ti.com/
> Changes since v1:
> - Dropped patches 1/3 and 2/3 of the v1 series as discussed in the v1
>   thread.
> - Updated patch 3/3 which is the v1 for this patch by dropping the checks
>   for the "num-lanes" property and "max-link-speed" property since the PCI
>   driver already validates the "num-lanes" property.
>=20
> Regards,
> Siddharth.
>=20
>  Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml=
 b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index b7a534cef24d..a7b5c4ce2744 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -14,6 +14,7 @@ properties:
>    compatible:
>      oneOf:
>        - const: ti,j721e-pcie-host
> +      - const: ti,j722s-pcie-host
>        - const: ti,j784s4-pcie-host
>        - description: PCIe controller in AM64
>          items:
> --=20
> 2.34.1
>=20

--MB4v+1ZTataoFot5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa45xgAKCRB4tDGHoIJi
0gPPAP9r7u6mPuwvim0hfPgkksx+qLpzH4bCYXoMh2kBRkzN3gEAov+DNvSIQ2nN
GPKc5v4ISfqN1mZtrXvCkZsKU22obAU=
=avKc
-----END PGP SIGNATURE-----

--MB4v+1ZTataoFot5--

