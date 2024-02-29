Return-Path: <linux-pci+bounces-4269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A9E86D0E2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 18:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82006B216A0
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104A870AC4;
	Thu, 29 Feb 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnNk5ArJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B4C6CBF3;
	Thu, 29 Feb 2024 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228342; cv=none; b=MjaCgoEKHXpxmXcKOT1JPdKlG/7kORdYFStgKM6qzil7i5cy9V1e/U9rfWjHpdsnh8JcO1CYOQgPvxKmYGJJzFw8W4zbfrABi5ouSP7Ak2DgXKZ7FdqAbi+3u7VdY4xHlLNMqFuAU9PWzGxLFePPHbb7GZPrzJ8vC2g/5T0SO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228342; c=relaxed/simple;
	bh=ZwUvt/f+7G+OeisKaMdN5s3i0cHecbiW7F+SUpW6wIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWBPINgyUBZ4DdKCALttZq0CHUuCL1x0ITPNCzXOmrbu2WSsm2x2vEvRA/Mou+xFhn0PNaDUd+9Ku87lOTRnlEZZMWd44EN3L6s377FGDZnAwrAYXnQIXCODgLPkw4UjgR081Sw7Qos6Lb5QIiXC6MiFHfqUX6vOxxjy+KGsz9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnNk5ArJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1079C433C7;
	Thu, 29 Feb 2024 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709228341;
	bh=ZwUvt/f+7G+OeisKaMdN5s3i0cHecbiW7F+SUpW6wIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnNk5ArJJwicNvpwkRa1xw66zPXxFWr0CZrX0og7T4f1e+Wiv91aXLseg+/pANM0o
	 /wBLckVsX12A6gsag/Qz3p335Jtd+1KKjzuC7VUTN0dxcHmhUA390b4P2JZCkY5E6b
	 F+n9DphUOg6BwzPSyuaT9bhDh0LCKM23j2tKRfnWX5Y0KGn7goQuy4CrED/jQdEKc+
	 nexyNVxe1fvgenmS7A8+Szgo0aSrbBJQ5jzJV6Iyp+vLvk3mZe15qdMVzmQVjezEGk
	 TL+uYBI4iLhrO3u6Dzlzoke9YSYJlYLl5YqEjpEp/2T/b3jfn8sK+BeGMEw2npUK39
	 FncbJ65e4kzbw==
Date: Thu, 29 Feb 2024 17:38:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H
 compatible
Message-ID: <20240229-lion-overdrawn-b84dad3f19eb@spud>
References: <20240229120719.2553638-1-yoshihiro.shimoda.uh@renesas.com>
 <20240229120719.2553638-2-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TuhhfISF/dk6oxmB"
Content-Disposition: inline
In-Reply-To: <20240229120719.2553638-2-yoshihiro.shimoda.uh@renesas.com>


--TuhhfISF/dk6oxmB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 09:07:14PM +0900, Yoshihiro Shimoda wrote:
> Document bindings for R-Car V4H (R8A779G0) PCIe host module.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yam=
l b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> index ffb34339b637..955c664f1fbb 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> @@ -16,7 +16,9 @@ allOf:
>  properties:
>    compatible:
>      items:
> -      - const: renesas,r8a779f0-pcie   # R-Car S4-8
> +      - enum:
> +          - renesas,r8a779f0-pcie      # R-Car S4-8
> +          - renesas,r8a779g0-pcie      # R-Car V4H
>        - const: renesas,rcar-gen4-pcie  # R-Car Gen4
> =20
>    reg:
> --=20
> 2.25.1
>=20

--TuhhfISF/dk6oxmB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDBMAAKCRB4tDGHoIJi
0h5NAPwI4jpJxo9OSZ1pyAqXIs1P3G6I14AKZ717ubGuIS5p/gEA7HckjFaH/vTr
vN7PErR3oyfARU+3Roe4P79TWYj8xg4=
=WFP1
-----END PGP SIGNATURE-----

--TuhhfISF/dk6oxmB--

