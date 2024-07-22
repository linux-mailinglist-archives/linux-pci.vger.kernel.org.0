Return-Path: <linux-pci+bounces-10615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDC993929E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 18:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9171F214DF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17FE16EB6E;
	Mon, 22 Jul 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCt7bRqg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644526ACD;
	Mon, 22 Jul 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666239; cv=none; b=cnZf+QLY8evXCp0bivcsNZF3HzJRM6mRsL33YtnSC2ReXgZPgSvb23ZttC2CFVVBunGBk09B+e0JuSMOpE3fbzudgMA4lp3xQa1rXTSCyosTLvddxk2wda7C4d7ts/E8WwRVb+eDlf6mzUcc7/BYI1QRnKRwtm/1GO9TPjvD3do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666239; c=relaxed/simple;
	bh=r7wrzTEhZ4vHnTem3SM0inPLsOlVUJANiUV8d/psgLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3/QPm8Pm0C/3MuELDA6OWGotEVKlmCl8qYHWV7KPYF/gLecXxCrTub+bxPnBfFUNSYygc2M/vmVJaVgLKoLO97CtllUYBnOT2AWNvm0scN4qz75FnxNqOP6IbzcKsMsTxik6wKXWpfELIOsYiWCJhtW5GMkSHG8zmqp1gd/ZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCt7bRqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA3FC116B1;
	Mon, 22 Jul 2024 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721666239;
	bh=r7wrzTEhZ4vHnTem3SM0inPLsOlVUJANiUV8d/psgLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCt7bRqgrIJtorXDDgsI6aVgh2IyB/qT8wPQEcU4ritxCOg5W2l4bfnNPTpo0vnRa
	 qXZOIcU7D/Y+y47Eb0F8p4FC0gACBAUSVYAdkpp4eU2DFNP74XRFgZcmUZOWu2x565
	 vgqaSTi0bLF6+fQEgrWPDomt3kCdf+HQBNZUoX4Xi+Q7AFVPXUsQekJu0wN9R6fOwS
	 J24bebXY4t1ldyKxlhp0qRNcnl1zzvFEKCV/aHT2eEFDvm17R3KnFeGHV8uyhiF5oh
	 EAd0xzza24suP4hsWn5fS9Y5dhZtDW823bb67/8S1NzVgaSF6m2qC6GSW2X+jVRheg
	 9/iBsMc0CKh3Q==
Date: Mon, 22 Jul 2024 17:37:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v1 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Message-ID: <20240722-displace-amusable-a884352e0ff9@spud>
References: <1721634979-1726-1-git-send-email-hongxing.zhu@nxp.com>
 <1721634979-1726-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xyn3EpKJewT48NFm"
Content-Disposition: inline
In-Reply-To: <1721634979-1726-2-git-send-email-hongxing.zhu@nxp.com>


--xyn3EpKJewT48NFm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 03:56:16PM +0800, Richard Zhu wrote:
> Add reg-name: "dbi2", "atu" for i.MX8M PCIe Endpoint.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml  | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml=
 b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> index a06f75df8458..309e8953dc91 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> @@ -65,11 +65,13 @@ allOf:
>      then:
>        properties:
>          reg:
> -          minItems: 2
> -          maxItems: 2
> +          minItems: 4
> +          maxItems: 4
>          reg-names:
>            items:
>              - const: dbi
> +            - const: dbi2
> +            - const: atu

New properties in the middle of the list is potentially an ABI break.
Why not add them at the end?

>              - const: addr_space
> =20
>    - if:
> @@ -129,8 +131,11 @@ examples:
> =20
>      pcie_ep: pcie-ep@33800000 {
>        compatible =3D "fsl,imx8mp-pcie-ep";
> -      reg =3D <0x33800000 0x000400000>, <0x18000000 0x08000000>;
> -      reg-names =3D "dbi", "addr_space";
> +      reg =3D <0x33800000 0x100000>,
> +            <0x33900000 0x100000>,
> +            <0x33b00000 0x100000>,
> +            <0x18000000 0x8000000>;
> +      reg-names =3D "dbi", "dbi2", "atu", "addr_space";
>        clocks =3D <&clk IMX8MP_CLK_HSIO_ROOT>,
>                 <&clk IMX8MP_CLK_HSIO_AXI>,
>                 <&clk IMX8MP_CLK_PCIE_ROOT>;
> --=20
> 2.37.1
>=20

--xyn3EpKJewT48NFm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp6KugAKCRB4tDGHoIJi
0iZjAP9MWw8PkOtx8+vjhpvxv3uO7ors0U0S+LKqUtQKj1HO2wD/YM74SYCGKKyu
CopteoUYR8rynNHrukYnXQJY+Zqavg8=
=T1co
-----END PGP SIGNATURE-----

--xyn3EpKJewT48NFm--

