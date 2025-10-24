Return-Path: <linux-pci+bounces-39285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 540BAC077A5
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 19:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C3E1B86111
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 17:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01B313E0F;
	Fri, 24 Oct 2025 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcUygfWu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE91A3160;
	Fri, 24 Oct 2025 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325609; cv=none; b=jI551fkq/LwkyCpMSoTVLQ7ryMxXAXziJtsauBCYu31rPA+wDfs4lYEjhWbvjfR3qFSEHBcVpuX7ATcloW5bUB/mYeFo+jfFVVwiKVKDgHxphpx2RXwHgQNs+YppSzVvmrRLFTM2ZAIlZKIGkxCP+HDAZHMMOZOy/esPq/wZtWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325609; c=relaxed/simple;
	bh=Ury8HZVn+UOCZQaBhNOWpNwaBpO6odlNFuHtT24PBy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVw4XDmgm/RmmeDdybRStADohcjljSpIb2ti3XOzuLAJuBTel/I22813byorXuJabpy23zJ5YewsqklQb9zPqiYyGiEbs9xA+yxVFvvdWRottm4brEehl6HTFlcp2s/Kkcnth3TLmkpjeJqBBHMLvsVA9iIF+lj43dOkhTVYT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcUygfWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8883C4CEFB;
	Fri, 24 Oct 2025 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761325609;
	bh=Ury8HZVn+UOCZQaBhNOWpNwaBpO6odlNFuHtT24PBy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bcUygfWuhpmiNMIMzxAEmZzKLgnXJlJaUEmIbEohiaIh9SrtftsiBAQxlcMw95MKu
	 i4GjX5+yhFZxdw83YlRwWEGHWhV8DeFrmk1DazVUQ/E8ha1U2zu2dO3JM7zD2U4fUv
	 ARCD28C47ovhLur4SbW1WKItzR5rU3o4nhgoRjtXwxebIJcxy/tXaf/qRnaS3XlcNE
	 jAhdkkgVTFlhmLXfQz7fZVM/ndeIuU6SlXgrkulzNDwhLBytBUrglScCVozQh6F7+P
	 WqVzVuWvlgojyvfavFTDyHM0C7CDm/UElVnWCjFcNfEhyJ1qh7U5+EjA6tbDzxyHLU
	 f/ymsROZchy2Q==
Date: Fri, 24 Oct 2025 18:06:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] dt-bindings: PCI: pci-imx6: Add external
 reference clock input
Message-ID: <20251024-unburned-lip-6f142d83ed76@spud>
References: <20251024024013.775836-1-hongxing.zhu@nxp.com>
 <20251024024013.775836-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XcZSjLvU49YOzPxG"
Content-Disposition: inline
In-Reply-To: <20251024024013.775836-3-hongxing.zhu@nxp.com>


--XcZSjLvU49YOzPxG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:40:12AM +0800, Richard Zhu wrote:
> i.MX95 PCIes have two reference clock inputs: one from internal PLL, the
> other from off chip crystal oscillator. The "extref" clock refers to a
> reference clock from an external crystal oscillator.
>=20
> Add external reference clock input for i.MX95 PCIes.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/=
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index ca5f2970f217c..b4c40d0573dce 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -212,14 +212,17 @@ allOf:
>      then:
>        properties:
>          clocks:
> +          minItems: 4
>            maxItems: 5
>          clock-names:
> +          minItems: 4
>            items:
>              - const: pcie

1

>              - const: pcie_bus

2

>              - const: pcie_phy

3

>              - const: pcie_aux

4

>              - const: ref

5

> +            - const: extref  # Optional

6

There are 6 clocks here, but clocks and clock-names in this binding do
not permit 6:
|  clocks:
|    minItems: 3
|    items:
|      - description: PCIe bridge clock.
|      - description: PCIe bus clock.
|      - description: PCIe PHY clock.
|      - description: Additional required clock entry for imx6sx-pcie,
|           imx6sx-pcie-ep, imx8mq-pcie, imx8mq-pcie-ep.
|      - description: PCIe reference clock.
|
|  clock-names:
|    minItems: 3
|    maxItems: 5

AFAICT, what this patch actually did is make "ref" an optional clock,
but the claim in the patch is that extref is optional. With this patch
applied, you can have a) no reference clocks or b) only "ref". "extref"
is never allowed.

Is it supposed to be possible to have "ref" and "extref"?
Or "extref" without "ref"?
Neither "ref" or "extref"?
I don't know the answer to that question because you're doing things
that are contradictory in your patch and the commit message isn't clear.

I don't see how this can have been successfully tested.

pw-bot: changes-requested


--XcZSjLvU49YOzPxG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPuyIwAKCRB4tDGHoIJi
0qmAAP43Y5c5EpXWguFo8pYVr2jdc1RmVmgslABpylj0GDLEawEAjzc9MPMpxAcT
3CM8pI7Q006oqHCJD34NB+JJATROLw4=
=XZe8
-----END PGP SIGNATURE-----

--XcZSjLvU49YOzPxG--

