Return-Path: <linux-pci+bounces-12292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32519613C9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 18:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC691F240E2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588511C8700;
	Tue, 27 Aug 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfVH/Usz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A731C6896;
	Tue, 27 Aug 2024 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775278; cv=none; b=TuwTxPcdUcgXpaU6RLGWCStogy6lFM7+07vCJl2WFKUqGZPWgGE31I1tfSu5m8i/WULvDw66GodFJE60VpSwmtVGr37CuofT0WLePtKe4d3/ARkxB25d02bwSDkaXavmQOYWTKr0LCfUiGrHB2+HtVvaxKbChWdIueqj6XjDavA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775278; c=relaxed/simple;
	bh=XQOrELheCNTfFki4NiQiUySwm2hodBHPIZEfeS+lrWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujTVYkdVW/MpoGAsXqU7yT/EZtDGR1/0uu7bbOTGmBLTlM2aZuCJ5jPj+Ohe3NCa59uPSruQdpNCtrVcoqu2EfRTLTS86hyZnzEqMPqJMsYWlwtgKzKL80LQmWd6WhMEGPpAVhWxWGPqOcqkb7LBr9tJVyyyYJ6xmbGseprZDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfVH/Usz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D07C55DF1;
	Tue, 27 Aug 2024 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724775277;
	bh=XQOrELheCNTfFki4NiQiUySwm2hodBHPIZEfeS+lrWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfVH/Usz4u4GkgChRFZXAoX9NhY29MHd3mUwPkL+wjZyJtGX9el032F8C3e7r/3+J
	 cuHs+W2hjB6NpnWFGkC/pMOhF28JSdJPDkHKRsTdytefrtfEvRcafPBKi0kjsPDkYG
	 uqXhT+qtKP3dJaGxUiSBFDJpFEZo1tzOWFDYpkH+AAAax6s/TMU/ct4E08PIH8BKaw
	 B4q+8HTVNa7CDcJdwFTbwZ3O6CBq4QqIELU99U50lL9nYChejV5XUw4RX679SZqavb
	 FYaBz3nYA2oMmZCrjcJeDSUe+j2wB/5lZsI4DQ7LgBBLHujzmAzg5Yns9PgQ6ZeXJ6
	 +O+tBzHWq7zxA==
Date: Tue, 27 Aug 2024 17:14:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/3] dt-bindings: PCI: layerscape-pci: Replace
 fsl,lx2160a-pcie with fsl,lx2160ar2-pcie
Message-ID: <20240827-breeding-vagrancy-22cd1e1f9428@spud>
References: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
 <20240826-2160r2-v1-1-106340d538d6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bt5Rvhkl7gxoqXpk"
Content-Disposition: inline
In-Reply-To: <20240826-2160r2-v1-1-106340d538d6@nxp.com>


--bt5Rvhkl7gxoqXpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 05:38:32PM -0400, Frank Li wrote:
> fsl,lx2160a-pcie compatible is used for mobivel according to
> Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
>=20
> fsl,layerscape-pcie.yaml is used for designware PCIe controller binding. =
So
> change it to fsl,lx2160ar2-pcie and allow fall back to fsl,ls2088a-pcie.
>=20
> Sort compatible string.
>=20
> Fixes: 24cd7ecb3886 ("dt-bindings: PCI: layerscape-pci: Convert to YAML f=
ormat")

I don't understand what this fixes tag is for, this is a brand new
compatible that you are adding, why does it need a fixes tag pointing to
the conversion?

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/pci/fsl,layerscape-pcie.yaml          | 26 ++++++++++++----=
------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.ya=
ml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> index 793986c5af7ff..daeab5c0758d1 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> @@ -22,18 +22,20 @@ description:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - fsl,ls1021a-pcie
> -      - fsl,ls2080a-pcie
> -      - fsl,ls2085a-pcie
> -      - fsl,ls2088a-pcie
> -      - fsl,ls1088a-pcie
> -      - fsl,ls1046a-pcie
> -      - fsl,ls1043a-pcie
> -      - fsl,ls1012a-pcie
> -      - fsl,ls1028a-pcie
> -      - fsl,lx2160a-pcie
> -
> +    oneOf:
> +      - enum:
> +          - fsl,ls1012a-pcie
> +          - fsl,ls1021a-pcie
> +          - fsl,ls1028a-pcie
> +          - fsl,ls1043a-pcie
> +          - fsl,ls1046a-pcie
> +          - fsl,ls1088a-pcie
> +          - fsl,ls2080a-pcie
> +          - fsl,ls2085a-pcie
> +          - fsl,ls2088a-pcie
> +      - items:
> +          - const: fsl,lx2160ar2-pcie
> +          - const: fsl,ls2088a-pcie
>    reg:
>      maxItems: 2
> =20
>=20
> --=20
> 2.34.1
>=20

--bt5Rvhkl7gxoqXpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZs37aAAKCRB4tDGHoIJi
0li6AQDshWQiSjHpn+JM9L4E8yJd3JsNPQm+apaGIZ5X4oeo7gEA94IChaKCz0Ew
E9INeCxYrEtNXfbdXtmjigX3O10+WQo=
=braS
-----END PGP SIGNATURE-----

--bt5Rvhkl7gxoqXpk--

