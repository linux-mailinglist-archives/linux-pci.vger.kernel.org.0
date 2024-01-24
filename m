Return-Path: <linux-pci+bounces-2528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EBC83AE07
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 17:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769151C23796
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E41A7C09A;
	Wed, 24 Jan 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txqt/r9E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F7540C1B;
	Wed, 24 Jan 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112629; cv=none; b=cKyiHq3o1AstkyJjLv699kI9IEhOTXoutaRzK8zT2XGKIEQK8jP3wkMT7br9VxVQeTlyyd6Yw0NOdjYZ29hTHCNNa3EOxIeU3lzmFhsnRvkg7wjPx7pU8zHhnxt2uNafBGvXr3Om7MPxuPP84tqNWTaFSHPrv8Z6z80wxSFT1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112629; c=relaxed/simple;
	bh=SalXPkmNubfGiQcSbtanqRQSq5xrw4Ucd7dpoHNEfPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK9j234Qep87NZq3uV0lVvxO817RC1s/LofeMTfDfhp8gqckRry03BtIj9P9/7uxuKuZ+1Wqk0TRB1/P4fF6chBm7MESy4MNOI02JeZvQq020bEojuFflqrJ3dKt80zAvlE2Vzk5qJq12/PUH6tOnltS5RDWb+Ti84LH4Rt3uFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txqt/r9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ADDC433C7;
	Wed, 24 Jan 2024 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112629;
	bh=SalXPkmNubfGiQcSbtanqRQSq5xrw4Ucd7dpoHNEfPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Txqt/r9E4X+x35VNp0w/xCp316LfHogdEXOyL+dfA+JhLsthGLWmBPZVc7aAmwVjs
	 oAYyBDzF6pCTvE3Lly4F3Q09AEetMXO9i06J7YJEt2ckvA4n0/Jido+oJfC0ObyLWd
	 XC2ZZ/TG7MAhLyg48x/Ks5U1DNUZ6cctYX02P+ZZnBajhdVaWxe+KG2g5Ln1+DeGt5
	 g+2lRiDKODDHjOqPZt4M5RPecQLJAK8sAdryi1eIOUMX8OCXr6rnfR7vbISEGCRVZm
	 MvvhxCEev7ZKdLLQXrqY7CllqJjOzsEzBFlWDa1tEkqBwlX4oQmYwJfGFstKbiZkJp
	 ODRbW4wYNQvcA==
Date: Wed, 24 Jan 2024 16:10:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, afd@ti.com,
	srk@ti.com
Subject: Re: [PATCH v3] dt-bindings: PCI: ti,j721e-pci-host: Add support for
 J722S SoC
Message-ID: <20240124-unmatched-plating-019a3055cf5e@spud>
References: <20240124122936.816142-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XMTtUXZ1FD8n2B8o"
Content-Disposition: inline
In-Reply-To: <20240124122936.816142-1-s-vadapalli@ti.com>


--XMTtUXZ1FD8n2B8o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 05:59:36PM +0530, Siddharth Vadapalli wrote:
> TI's J722S SoC has one instance of a Gen3 Single-Lane PCIe controller.
> The controller on J722S SoC is similar to the one present on TI's AM64
> SoC, with the difference being that the controller on AM64 SoC supports
> up to Gen2 link speed while the one on J722S SoC supports Gen3 link speed.
>=20
> Update the bindings with a new compatible for J722S SoC.
>=20
> Technical Reference Manual of J722S SoC: https://www.ti.com/lit/zip/spruj=
b3
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>=20
> Hello,
>=20
> This patch is based on linux-next tagged next-20240124.
>=20
> v2:
> https://lore.kernel.org/r/20240122064457.664542-1-s-vadapalli@ti.com/
> Changes since v2:
> - Added fallback compatible for "ti,j722s-pcie-host" as
>   "ti,j721e-pcie-host" based on Conor's suggestion at:
>   https://lore.kernel.org/r/20240122-getting-drippy-bb22a0634092@spud/#t
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
>  Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml=
 b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index b7a534cef24d..ac69deeaf1ee 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -23,6 +23,10 @@ properties:
>          items:
>            - const: ti,j7200-pcie-host
>            - const: ti,j721e-pcie-host
> +      - description: PCIe controller in J722S
> +        items:
> +          - const: ti,j722s-pcie-host
> +          - const: ti,j721e-pcie-host
> =20
>    reg:
>      maxItems: 4
> --=20
> 2.34.1
>=20

--XMTtUXZ1FD8n2B8o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbE2bwAKCRB4tDGHoIJi
0jHrAQCIBSaSCKrkq41PAo1JM5MQwnH1H5lerQzNSHd34orjQQD/QiTReBxf2B8K
0HBXqv1UMcgBysJE8No3ifA4Cdp2vA0=
=tVT8
-----END PGP SIGNATURE-----

--XMTtUXZ1FD8n2B8o--

