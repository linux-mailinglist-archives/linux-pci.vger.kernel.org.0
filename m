Return-Path: <linux-pci+bounces-2952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B181845F58
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 19:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE0E1C21A7F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A71F8562B;
	Thu,  1 Feb 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyPwuxEo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D27A12FB23;
	Thu,  1 Feb 2024 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810602; cv=none; b=IfuZE21mk/xuGKfyKOQS9xRUNSlwKWONsP5fnUvgsoSRcE51XHkf3XKfHl3eO7I01/rYXpX4tK7kXUPUpiZRs5C2vuH8T2Ff61LTWLt4ggaW5xtDM3hVpgAQwm6ADXtliNYfk+mc8GDy6YYStJE70CxGjtLp0qV+dN176DhZRrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810602; c=relaxed/simple;
	bh=IHGeOhNmTq/Miy26ULOV+ol8yhUBuZfpnAv1+z5inds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqKTCNZZ+6CQUqrrMWQvvYFE1zG3l30V6UFy6r5pLjY5VqzJct4+LTGZSoL4UOtg6zPh5ynmvfEEW/Pqk0M7fBdFKEMzpdMCBwjZG+Bp8e3t3NH7RVvQrkimhLwI4iP2480J/txnXlyvn0lcmyRK9wr0ohFCMPlSXYp9EhYud+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyPwuxEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246D4C43390;
	Thu,  1 Feb 2024 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706810601;
	bh=IHGeOhNmTq/Miy26ULOV+ol8yhUBuZfpnAv1+z5inds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyPwuxEoZ+a/WT4Sioh/sLEa6oFvRvgjU2HIsQx7q1M4ib1P9OSEQ60vxQ1THvQXr
	 xOerEV1YFJPO6kmZM9fzBX4irtmdnKQfpNuSqXYt3EwutHkKh+i4Lgl1C5H7sOGOAA
	 JnEn4RteBKaYRIY17i6i3mtjvSEjgJfI/NwolZ5Ss7XxGKG5yR3Tqel+fUAPUkyOwd
	 fmpUqBpSCERigJZCkAiZE7B+ZIGyf1rhXg1rQc4VTnJQkNkRMvoUrpuCXr8mM4U+8T
	 nfxEy3lvBIr+Y1FdT6YyHY1pxyJo08udAHqlfHKS5yIPU2hOQvKF9CGEHKG3RpjfUn
	 UdJBJE4hIVcww==
Date: Thu, 1 Feb 2024 18:03:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rcar-pci-host: Add missing IOMMU
 properties
Message-ID: <20240201-unstable-browsing-6b50c854276e@spud>
References: <babc878a93cb6461a5d39331f8ecfa654dfda921.1706802597.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Riy75lIy6Zn+XAA"
Content-Disposition: inline
In-Reply-To: <babc878a93cb6461a5d39331f8ecfa654dfda921.1706802597.git.geert+renesas@glider.be>


--0Riy75lIy6Zn+XAA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 04:52:01PM +0100, Geert Uytterhoeven wrote:
> make dtbs_check:
>=20
>     arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb: pcie@fe000000: =
Unevaluated properties are not allowed ('iommu-map', 'iommu-map-mask' were =
unexpected)
> 	    from schema $id: http://devicetree.org/schemas/pci/rcar-pci-host.yam=
l#
>=20
> Fix this by adding the missing IOMMU-related properties.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/pci/rcar-pci-host.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/D=
ocumentation/devicetree/bindings/pci/rcar-pci-host.yaml
> index b6a7cb32f61e5d4f..835b6db00c27968a 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
> @@ -77,6 +77,9 @@ properties:
>    vpcie12v-supply:
>      description: The 12v regulator to use for PCIe.
> =20
> +  iommu-map: true
> +  iommu-map-mask: true
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.34.1
>=20

--0Riy75lIy6Zn+XAA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbvc5AAKCRB4tDGHoIJi
0hcAAP98iYm8ag91wFwbH63MTL0owenyu1Bzh8LczR0ML6hDVQEAkgXtJH6zqAyI
9KP7s+BYmEYp8s/7bv7uf7JS8VQg+Q8=
=Gn/8
-----END PGP SIGNATURE-----

--0Riy75lIy6Zn+XAA--

