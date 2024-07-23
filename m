Return-Path: <linux-pci+bounces-10659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22093A2DD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 16:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BD21F235E6
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D5B155321;
	Tue, 23 Jul 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtqKJGB7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93C155307;
	Tue, 23 Jul 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745318; cv=none; b=KxUd8/DDAvxMgNbYaFQY0b4RO4EDLDGEx1kFfEDEwT9hcCP+tyHrI/TQDfPTDBUzd5j1mWXDQVoAADjdXeRBGjf50D/+sSIW7wNNOikJR01e6M51o3C32tCo6hQFMkAVDyvdRgaIv05muYQbnECXU2wgyHjLuYjsAiBXawjTxvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745318; c=relaxed/simple;
	bh=SIEX4jZxPLkLEdwNUU9kodfaZkbypEBKoyUOHUf9f6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjOCQRStQ8WgYgclVDz42Y9B6vwTBJE0vSQ/bJw7R31y/2i2syu2dacrFx1TDduw57zNpTWZsANcpvecJAHSyiw3eoC8Zov7sJvNY3PnkCWYTlqSlfkga4tbtEpCIZnEcvqyjDYDXQHTtkzKwKp2PyXuBBnqgBXZUqE4jjyrxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtqKJGB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF67C4AF0A;
	Tue, 23 Jul 2024 14:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721745318;
	bh=SIEX4jZxPLkLEdwNUU9kodfaZkbypEBKoyUOHUf9f6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtqKJGB7nMmm0EexSy9baNwYb9FRqmQC2CjMotyOTmjI5Vz+cjC14OC8ANYAItDM2
	 9Rgey3t6jQiUABW6WUGo8Wl/BOAPvHcqBmvJdKHTV/XmNUcYiihbPUKC2rWK9WcYrD
	 s8Ryv/ccXoUCZpvpL1yImSx70kgqsIYYDeKCoIrZ6Q7HvPttc6TH/pFIiM8dRBQbpF
	 zeMDSB6yludRCUhCvuMuBuagpkCnE50T/uhsL98aaS65GB39aQRrlNtqEecdZ4kVJJ
	 7hDPHWwYYogkq0uABp2OMK4HIqdqfMWe2gTI8/PCMiNFkbkoVK+YrvSYcj0Vysvxks
	 gxKUQlf2fsdFg==
Date: Tue, 23 Jul 2024 15:35:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v1 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Message-ID: <20240723-spinning-wikipedia-525130c48dcd@spud>
References: <1721634979-1726-1-git-send-email-hongxing.zhu@nxp.com>
 <1721634979-1726-2-git-send-email-hongxing.zhu@nxp.com>
 <20240722-displace-amusable-a884352e0ff9@spud>
 <Zp7FYRaXM4NNO0oM@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f4Ml/B5fxYMPddxi"
Content-Disposition: inline
In-Reply-To: <Zp7FYRaXM4NNO0oM@lizhi-Precision-Tower-5810>


--f4Ml/B5fxYMPddxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 04:47:29PM -0400, Frank Li wrote:
> On Mon, Jul 22, 2024 at 05:37:14PM +0100, Conor Dooley wrote:
> > On Mon, Jul 22, 2024 at 03:56:16PM +0800, Richard Zhu wrote:
> > > Add reg-name: "dbi2", "atu" for i.MX8M PCIe Endpoint.
> > >=20
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml  | 13 +++++++++--=
--
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.=
yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > > index a06f75df8458..309e8953dc91 100644
> > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > > @@ -65,11 +65,13 @@ allOf:
> > >      then:
> > >        properties:
> > >          reg:
> > > -          minItems: 2
> > > -          maxItems: 2
> > > +          minItems: 4
> > > +          maxItems: 4
> > >          reg-names:
> > >            items:
> > >              - const: dbi
> > > +            - const: dbi2
> > > +            - const: atu
> >=20
> > New properties in the middle of the list is potentially an ABI break.
> > Why not add them at the end?
>=20
> Because it ref to snps,dw-pcie-ep.yaml, which already defined the reg
> name orders.

Are you sure that it defines an order for reg? If it did, it would not
allow what you already have in this binding. The order is actually
defined in this file.

> we using reg-names to get reg resource, I don't think it break
> the ABI. Driver already auto detect both 'dbi2' or no 'dbi2' case.

Linux's might, another might not. I don't see any point in breaking the
ABI when you can just put the entries at the end of he list and have no
problems at all.

Thanks,
Conor.

> > >              - const: addr_space
> > > =20
> > >    - if:
> > > @@ -129,8 +131,11 @@ examples:
> > > =20
> > >      pcie_ep: pcie-ep@33800000 {
> > >        compatible =3D "fsl,imx8mp-pcie-ep";
> > > -      reg =3D <0x33800000 0x000400000>, <0x18000000 0x08000000>;
> > > -      reg-names =3D "dbi", "addr_space";
> > > +      reg =3D <0x33800000 0x100000>,
> > > +            <0x33900000 0x100000>,
> > > +            <0x33b00000 0x100000>,
> > > +            <0x18000000 0x8000000>;
> > > +      reg-names =3D "dbi", "dbi2", "atu", "addr_space";
> > >        clocks =3D <&clk IMX8MP_CLK_HSIO_ROOT>,
> > >                 <&clk IMX8MP_CLK_HSIO_AXI>,
> > >                 <&clk IMX8MP_CLK_PCIE_ROOT>;
> > > --=20
> > > 2.37.1
> > >=20
>=20
>=20

--f4Ml/B5fxYMPddxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp+/nwAKCRB4tDGHoIJi
0o1yAP9Ri4U2xMei9m2+GEfjZXiikHHGvpUwLmes7Zt8FfQGUgEAw+oENNzcQbGV
qT0hibbBrevG9+0vEZBZvrBDpf4H0wI=
=PIZD
-----END PGP SIGNATURE-----

--f4Ml/B5fxYMPddxi--

