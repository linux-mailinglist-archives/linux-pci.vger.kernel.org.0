Return-Path: <linux-pci+bounces-3263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EECE84EB5D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 23:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444891F29FF1
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802A4F8AA;
	Thu,  8 Feb 2024 22:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezKlEX8z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843F51018;
	Thu,  8 Feb 2024 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430286; cv=none; b=Emkemasj4Kn9B0hsBTBmdVAI4xJKjLewIw4pLIn9Rj8NjAft3Ov4exq55Cl9dO749fk/GSmLAkm1EwRXA5jONPcxnKldOLs2gRcO5mfj/CEx7Gg50bM0CSf4KeWXPu2xpI6QRw3sGeWYy/1rZk3pyURy1jeGyO7oxc5XDRqoKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430286; c=relaxed/simple;
	bh=sUvaMWVgfLPM3IN3kP/Sfp4tQsrwPgz8kE7lgIpeMlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uctg8Ba5+Ya0ApxmoLyh3l5uFxC3YkUF1sIY34fgxmXIrT9m4MdffCRsMPfPYwQKgnlLBeEoqNJVye3o8EpODxQYrmXPt+urZV9vrmOAMEfY+kzUuh0ot/6o2V0pC7fbmZ6FIdI6CLxIzrRxlbNcCxjtSOVjnXwzu3lVjUqWWgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezKlEX8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A895C433C7;
	Thu,  8 Feb 2024 22:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707430285;
	bh=sUvaMWVgfLPM3IN3kP/Sfp4tQsrwPgz8kE7lgIpeMlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezKlEX8zXSUDJqybqX+QHV4c2jcM/bJJNBIrg2J/YRLTPCdoyujq3V6ofrwZmRhuv
	 34m6lynRMNqP2vmpOMzgXyEdF+AnVKnDg0oY0qC/ZAfLJSTFz/Utl2UO7kfo6Fp1YL
	 R/sDB/yKvsIZ9jOOsUc/s3euwlWCfQkwZF1sHVx0L+kUlwBkhtmgGgyWIsI3u5phT5
	 ZWwe6ZXuCcvxrvu+idHaE6wRo/wx7RxYuOv+3pfyIuhfsNNLIEuAg6y9bz3c5oI/z3
	 vRFoFGIyk6XpHps2Zm5SyO4AKiwfsYiyppsx0jkEqXnydb2o69eDvmMOnFGetMRmj+
	 uqDOCCYq+iskQ==
Date: Thu, 8 Feb 2024 22:11:20 +0000
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
Message-ID: <20240208-nanometer-coke-07811889bafc@spud>
References: <20240207062403.304367-1-Frank.Li@nxp.com>
 <20240207-yoga-mobility-90a728f6342c@spud>
 <ZcPCn8q7viB/qcOH@lizhi-Precision-Tower-5810>
 <20240208-jarring-frolic-8d4c9b409127@spud>
 <ZcUs16+Z+I4m4q00@lizhi-Precision-Tower-5810>
 <20240208-revoke-doorman-5ba34f39c743@spud>
 <ZcU3ohEg5Z1ky+/W@lizhi-Precision-Tower-5810>
 <20240208-outing-nature-74b6fab0cdea@spud>
 <ZcVI23X4T04cFyJL@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1wFBWAeU2OQ4hQEl"
Content-Disposition: inline
In-Reply-To: <ZcVI23X4T04cFyJL@lizhi-Precision-Tower-5810>


--1wFBWAeU2OQ4hQEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 04:34:19PM -0500, Frank Li wrote:
> On Thu, Feb 08, 2024 at 09:20:08PM +0000, Conor Dooley wrote:
> > On Thu, Feb 08, 2024 at 03:20:50PM -0500, Frank Li wrote:
> >=20
> > > > > > > > > +  reg:
> > > > > > > > > +    maxItems: 2
> > > > > > > > > +
> > > > > > > > > +  reg-names:
> > > > > > > > > +    items:
> > > > > > > > > +      - const: regs
> > > > > > > > > +      - const: addr_space
> > > > > > > >=20
> > > > > > > > The example uses "regs" and "config". Where did addr_space =
come from?
> > > > > > >=20
> > > > > > > Example just show pcie-host part. Not show pcie-ep part.
> > > > > > > pcie-ep part need 'addr_space'.
> > > > > >=20
> > > > > > Okay. Again, please mention where this is coming from.
> > > > >=20
> > > > > Ideally it comes from snsp,dwc-pcie-ep.yaml. but it is use 'dbi' =
instead
> > > > > of 'regs'. It needs extra effort to make driver code algin common
> > > > > snps,dwc-pcie-ep.yaml, and update exist all dts files.
> > > > >=20
> > > > > I think it will be deleted soon.=20
> > > >=20
> > > > What I am looking for here is you to explain in the commit message =
that
> > > > the endpoint driver in linux and the dts have always used "addr_spa=
ce".
> > > > Checking that there's not a u-boot or *bsd that uses "config" would=
 also
> > > > be very helpful.
> > >=20
> > > I confused. Actually this two part PCIE-RC and PCIE-EP.
> > > PCIE-RC using 'config'
> > > PCIE-EP using 'addr_spcae'
> >=20
> > Yeah, I get this. The text binding makes it seem like "config" should be
> > used for both RC and EP, so I am just asking you to check that there are
> > no drivers in other kernels or bootloaders that use "config" for EP
> > mode.
>=20
> There are not 'config' concept for EP mode. Only RC mode have 'config'
> space concept to get PCIe device's config space. EP mode only have
> "add_space" for outbound windows. If other place using "config" for EP, it
> is totally wrong, they should fix it.

It might be a totally wrong concept, but it is what the binding said, so
they are within their rights to use that name.

>=20
> >=20
> > > I check old txt file, which have not mention it. I can remove it.
> >=20
> > if you drop "addr_space", you'll need to update the endpoint driver so
> > that it supports both "addr_space" and "config". If there are no
> > endpoint drivers using "config" in other operating systems, and all the
> > dts files use "addr_space", documenting "reg" and "addr_space" for
> > endpoint mode seems fair to me.
>=20
> It is up to how to create patches. "addr_space" needs. If you want me to
> create one version, which 100% match original txt. I can do that. Then
> create increment patch to fix the problem.
>=20
> If want to create a basic work version like this, which included some min=
us
> fixes. =20
>=20
> The both method is fine for me. Second method just need more efforts.

I don't have a problem with you making it "addr_space" as long as you
check to make sure that there are no users of "config" outside the
kernel and you mention in the commit message that this is a difference
=66rom the text binding (and why).

Thanks,
Conor.

--1wFBWAeU2OQ4hQEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcVRiAAKCRB4tDGHoIJi
0jBnAQCTnRYkic8ytH+lBjI2iV6es96Hip0STSW/bDe2HdeSmAEA9DDxK8QheU2Q
BzbwvLnS5EhLH7ofoK7nlfCGHTwkHw4=
=lYmd
-----END PGP SIGNATURE-----

--1wFBWAeU2OQ4hQEl--

