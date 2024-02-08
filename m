Return-Path: <linux-pci+bounces-3242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73FE84E8BF
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 20:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621361F2FF92
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F88636132;
	Thu,  8 Feb 2024 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lo7R4CcH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA436121;
	Thu,  8 Feb 2024 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419573; cv=none; b=ib/lOUYYUEKCIvTEgDPWFutZmp3Vt40A9sToHGOo3b/bSMoJrlYlW7u20aUFJ2LeyfBJkJhsrh8n1T6D9Xpg9M3LEK4WPygg38Qic6zGRmUcZvTIuzf/qmmgOrC4BDiwayUXecjnIlXXFKcqxZN1bVYU36g4Wk6AoOYeotDSu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419573; c=relaxed/simple;
	bh=qxWxhPD5BRxGx/8XjhWHfoKRfl1hlFiGpqLEiC51qZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCngwToU292RZEhw8KAdzyd+YxE++hMYWhMnXWpuYPH5JDHmvSdpettBE5BXSW/bdBDfdFxMHJ9pNnc29AgVsYA/yged/DiZKKIL20b/7zL/r0qngwED0x5OE0+BkhVXggyrC3xsZRO2LJ+h81+xA+q2Cnx43RNo+7yMLP22AJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lo7R4CcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506BBC433F1;
	Thu,  8 Feb 2024 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707419572;
	bh=qxWxhPD5BRxGx/8XjhWHfoKRfl1hlFiGpqLEiC51qZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lo7R4CcHxQOs7jopOpFDfOJl/mXi7YjRJaUBLFVVrbjbqkJnBLIo0D892ioPXPsT1
	 D8TyFzhjX0ub3cvDhGf4OAMpQI/WRa8+WZ80lRvQ5NllZQ3UPOy4LEZIDYK0OLYfzh
	 HmaK6zQ6ql5IMXE9r6+sskT9iSNTD+QCYSl7UP6hQBS6ZnfaPWQzXvRZXLfeTTmLJd
	 NWGm6e4k7WenEMiWxXVO6SXrKoCoofDnKLrwvFimENLNyuoEd/tGFBy54YVd4Jt5Dl
	 FrQErSW/Zb4K3hi68BZEfnMLg6dYbZozsatEGYyxl0sIfYg86ty1PKOZBWkujePgWw
	 PfFdLemuhaoOg==
Date: Thu, 8 Feb 2024 19:12:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 file
Message-ID: <20240208-jarring-frolic-8d4c9b409127@spud>
References: <20240207062403.304367-1-Frank.Li@nxp.com>
 <20240207-yoga-mobility-90a728f6342c@spud>
 <ZcPCn8q7viB/qcOH@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SRpmeCfQQ7dek33O"
Content-Disposition: inline
In-Reply-To: <ZcPCn8q7viB/qcOH@lizhi-Precision-Tower-5810>


--SRpmeCfQQ7dek33O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 12:49:19PM -0500, Frank Li wrote:
> On Wed, Feb 07, 2024 at 05:17:55PM +0000, Conor Dooley wrote:
> > Hey Frank,
> >=20
> > On Wed, Feb 07, 2024 at 01:24:02AM -0500, Frank Li wrote:
> > > Convert layerscape pcie bind document to yaml file.
> > >=20
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  84 +++++++++
> > >  .../bindings/pci/fsl,layerscape-pcie.yaml     | 163 ++++++++++++++++=
++
> > >  .../bindings/pci/layerscape-pci.txt           |  79 ---------
> > >  3 files changed, 247 insertions(+), 79 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layersc=
ape-pcie-ep.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layersc=
ape-pcie.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-=
pci.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pci=
e-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.ya=
ml
> > > new file mode 100644
> > > index 0000000000000..3b592c820eb4c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.ya=
ml
> > > @@ -0,0 +1,84 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Freescale Layerscape PCIe controller
> > > +
> > > +maintainers:
> > > +  - Frank Li <Frank.Li@nxp.com>
> > > +
> > > +description: |+
> >=20
> > Are you sure that you need this chomping operator?
> >=20
> > > +  This PCIe endpoint controller is based on the Synopsys DesignWare =
PCIe IP
> >=20
> > > +  and thus inherits all the common properties defined in snps,dw-pci=
e-ep.yaml.
> >=20
> > You shouldn't need this statement given you have the ref: below.
> >=20
> > > +
> > > +  This controller derives its clocks from the Reset Configuration Wo=
rd (RCW)
> > > +  which is used to describe the PLL settings at the time of chip-res=
et.
> > > +
> > > +  Also as per the available Reference Manuals, there is no specific =
'version'
> > > +  register available in the Freescale PCIe controller register set,
> > > +  which can allow determining the underlying DesignWare PCIe control=
ler version
> > > +  information.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - fsl,ls2088a-pcie-ep
> > > +      - fsl,ls1088a-pcie-ep
> > > +      - fsl,ls1046a-pcie-ep
> > > +      - fsl,ls1028a-pcie-ep
> > > +      - fsl,lx2160ar2-pcie-ep
> >=20
> > Where did the fallback compatible go?
>=20
> So far, no fallback compatible needed now. each devices already have its
> compatible string.

It used to exist though, have you checked that u-boot or *bsd etc do not
use the fallback compatible? You also need to mention your justification
for removing it in the commit message.

> > > +
> > > +  reg:
> > > +    maxItems: 2
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: regs
> > > +      - const: addr_space
> >=20
> > The example uses "regs" and "config". Where did addr_space come from?
>=20
> Example just show pcie-host part. Not show pcie-ep part.
> pcie-ep part need 'addr_space'.

Okay. Again, please mention where this is coming from.

>=20
> >=20
> > > +  fsl,pcie-scfg:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: A phandle to the SCFG device node. The second entry=
 is the
> > > +      physical PCIe controller index starting from '0'. This is used=
 to get
> > > +      SCFG PEXN registers.
> > > +
> > > +  dma-coherent:
> >=20
> > dma-coherent: true
> >=20
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description: Indicates that the hardware IP block can ensure the=
 coherency
> > > +      of the data transferred from/to the IP block. This can avoid t=
he software
> > > +      cache flush/invalid actions, and improve the performance signi=
ficantly.
> > > +
> > > +  big-endian:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description: If the PEX_LUT and PF register block is in big-endi=
an, specify
> > > +      this property.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> >=20
> > This was not previously required, why is it required now?
>=20
> Actually its needed.

Well, if it wasn't, I'd hope that you wouldn't be making it required.
But I asked /why/ and you've not given a reason. Please mention the why
in your commit message for v2.

Cheers,
Conor.


--SRpmeCfQQ7dek33O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcUnrwAKCRB4tDGHoIJi
0mtuAP9E4kgj16HNkIGd1VacL4AXJRLPuj/WspJh0e0xb9YX7wD+I6Mvg4AGjDL0
57vFoWWJHnkFY8XXol6QAMWynXGjggg=
=XvWb
-----END PGP SIGNATURE-----

--SRpmeCfQQ7dek33O--

