Return-Path: <linux-pci+bounces-39283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449EDC07667
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 18:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E091C438A3
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FEE337689;
	Fri, 24 Oct 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVBBqno+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75386342;
	Fri, 24 Oct 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324725; cv=none; b=ocUGOgogTk+/YiWu+NGZTYG7z8xPXKWocpSizc/HuCwZRPyA14tUI2O68ktt05mpHAGmlGC3gTnUwG5YppvNEEj1bvTDRiNhRaWdDKK3Bb8sxw0LaVL65LXW2y5VZaaZ8/jDHOsuDYGDAHEJdOdvqg63HKWhLo/1EMUheIYBrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324725; c=relaxed/simple;
	bh=lgoCh5NfGUWOtbjiChw+bb2GcRy5VqS7KaWQ/o8KLXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYBG4whmYtDJ0vEFoMfk4+FUw1vzkFIRG2alAfiQ/SBeG7MT3F8meGhspOlBD18MIYyEiymeJ+MVg1FQmmSsamhYj3nuNdfCzRWc3+ZzKezClcogeD2emSBT3zJ5blp7vKP/SQwEfWXbQF16SdXMLBnrh7bpVzvMCyMokUzPR5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVBBqno+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56878C4CEF1;
	Fri, 24 Oct 2025 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761324723;
	bh=lgoCh5NfGUWOtbjiChw+bb2GcRy5VqS7KaWQ/o8KLXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVBBqno+lUi6yslcWHVf4Vr0KEp50KgDLtx6xiZARKFaq5Pm8J1KyMZfJ7Zn1Q9wb
	 e2hZbvYoclgsVmq/VPppgS/8n6wIUtOeRD51/wGoPvf2SCRqJTADRtr9e17gq2kkbf
	 F3fJ6KnkJBplQT5JW5aK+GjXYmurNcPExJPZ0o5iilCJsAA/JySIDah0V/BOY2LDzC
	 U2ugWTZ+ZBZ+d7QQ9jZUjtN5Ab4ydi6Si5OTCE/tzdfvLH3IWroDSHKZ92Wj6jaK+9
	 EDFFuj8B/eb9K4fvprVOVAm1mm7qfTEQyNd2nt9wVbbeN+HyHs1FzuYYDKhD1ksJ+e
	 GXMcgJwCe/Kaw==
Date: Fri, 24 Oct 2025 17:51:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] dt-bindings: PCI: dwc: Add external reference
 clock input
Message-ID: <20251024-mandolin-starlet-f7cfd8ba4210@spud>
References: <20251024024013.775836-1-hongxing.zhu@nxp.com>
 <20251024024013.775836-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wn545wI6sdJnFSMd"
Content-Disposition: inline
In-Reply-To: <20251024024013.775836-2-hongxing.zhu@nxp.com>


--wn545wI6sdJnFSMd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:40:11AM +0800, Richard Zhu wrote:
> Add external reference clock input "extref" for a reference clock that
> comes from external crystal oscillator.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.ya=
ml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index 34594972d8dbe..0134a759185ec 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -105,6 +105,12 @@ properties:
>              define it with this name (for instance pipe, core and aux can
>              be connected to a single source of the periodic signal).
>            const: ref
> +        - description:
> +            Some dwc wrappers (like i.MX95 PCIes) have two reference clo=
ck
> +            inputs, one from an internal PLL, the other from an off-chip=
 crystal
> +            oscillator. If present, 'extref' refers to a reference clock=
 from
> +            an external oscillator.
> +          const: extref
>          - description:
>              Clock for the PHY registers interface. Originally this is
>              a PHY-viewport-based interface, but some platform may have
> --=20
> 2.37.1
>=20

--wn545wI6sdJnFSMd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPuurgAKCRB4tDGHoIJi
0qtfAP9syKT1Z8zD9ng04ytzgsxPxEic8yXDd2w7tDb/8OUUKgEA7ZWAfIKWjjfL
CozvH+SLFOAb9sAqsRNoc8HC8+RRngI=
=S1Ab
-----END PGP SIGNATURE-----

--wn545wI6sdJnFSMd--

