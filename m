Return-Path: <linux-pci+bounces-4270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BEE86D0E5
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 18:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0D2287E47
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D49570AD1;
	Thu, 29 Feb 2024 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7SoFrJX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39DD16062E;
	Thu, 29 Feb 2024 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228368; cv=none; b=NPT8DFTmzqtpq7pksMQEiqzZetPymp4fxjgLImgktR61mi5Zy7hQC9c+9Gjmb9mrC/th5xFWWC1HPxAWQpsmxrwp+UQ9gbWpPTGmT2nUYHWMA24fbQx8mDKr0cGiix/hhUV8J9ma2wrCkO8pjftXF/D67UOX/FH54L6wO+3srFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228368; c=relaxed/simple;
	bh=TAEnBSFHa8fjG7s2cfv/6tS2N2lEryTRWh/Q2k7wsF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruZNx8DIu229fekn4y4xcvsTTtCnK47jBamHxnFd9pwnqXpXxEpEjei5AzK+bFaZWdygajUxh2hI10QbQ95UQvtuWWBuMNYdOF6wbjXHg1N9gAlwpbbkPmZENazynKs15c3W/R9d4kOvKz6zQkYJji/+3kC27sy5PZBoAWSl7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7SoFrJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CF5C433F1;
	Thu, 29 Feb 2024 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709228367;
	bh=TAEnBSFHa8fjG7s2cfv/6tS2N2lEryTRWh/Q2k7wsF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7SoFrJXIjnJNRrQr2M0Yt0uVblIjivn6pgqMF9sH8K9r4NPI1J1aWm41KJoT9flS
	 /bjMtJnBRbznYdaXPA+1GWvXL/MO1K3d3BoLEtRD84+nMh9u0uyrQGaLxs079WbFwz
	 4NKZeLxpxwO2vHboWvtLmTHRtU3vFClE3UQ2C1tTbi7BCw7n3bVhgJAVlFSd1ScU56
	 P4g7ELUlnjJA+ZOEI9qqT6Q81ujeXWdNw7wY3rcg4h/QLhNYQosLuufcm7oUqX8U3i
	 6zYhUP4zNGfripSY/Gz1NwMhCENAGT9jj7RphHK8bszy5FaZs0F6z0WeLDaatRKAFA
	 PRqTdwRCE+4Hw==
Date: Thu, 29 Feb 2024 17:39:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H
 compatible
Message-ID: <20240229-stabilize-handwrite-09d474911bf0@spud>
References: <20240229120719.2553638-1-yoshihiro.shimoda.uh@renesas.com>
 <20240229120719.2553638-3-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xzp+i1KS10iXyq8k"
Content-Disposition: inline
In-Reply-To: <20240229120719.2553638-3-yoshihiro.shimoda.uh@renesas.com>


--Xzp+i1KS10iXyq8k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 09:07:15PM +0900, Yoshihiro Shimoda wrote:
> Document bindings for R-Car V4H (R8A779G0) PCIe endpoint module.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml =
b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> index fe38f62da066..91b81ac75592 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> @@ -16,7 +16,9 @@ allOf:
>  properties:
>    compatible:
>      items:
> -      - const: renesas,r8a779f0-pcie-ep   # R-Car S4-8
> +      - enum:
> +          - renesas,r8a779f0-pcie-ep      # R-Car S4-8
> +          - renesas,r8a779g0-pcie-ep      # R-Car V4H
>        - const: renesas,rcar-gen4-pcie-ep  # R-Car Gen4
> =20
>    reg:
> --=20
> 2.25.1
>=20

--Xzp+i1KS10iXyq8k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDBSgAKCRB4tDGHoIJi
0mfHAQDGvwZbPhZy3mD3lvgbJGlnIkN329BoGyVIjEia+kY3oAEAwoylQqiATgvu
dlfxFEi9xd2TetJveiY4xUkEIewkdQk=
=P/9A
-----END PGP SIGNATURE-----

--Xzp+i1KS10iXyq8k--

