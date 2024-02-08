Return-Path: <linux-pci+bounces-3252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DC784EA33
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E621F21DEB
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F544C3C6;
	Thu,  8 Feb 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnjmVS27"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670AE4EB2B;
	Thu,  8 Feb 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427213; cv=none; b=dmeIXo94Lrz8gNUyVyPBP4ndmo/HYgFr7IlCVq9jJDGIbbUqz2qIzTjvIC0yIzxzstOAv4bbN017QyYZjmMKa9o7xRg4yjyU49ICBG15K1EJkoKksveURVyhQKiDmDE1Hi7C6WHaFA2ZU4ER4wkEjJFapd9mpq53BtKY1CQ2SDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427213; c=relaxed/simple;
	bh=0wWe0YAzwZgyv/3+8weFv30HET9B4Cd2WgTwkK3SakI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suo2fmeQpgJlpx20hQsTNcZN0CB/cF1IIqYuxmpkX0Fa9MN3yHH22k6AVB7fogcKYP86ggg+SR3hohAAmZFAl6XBK1LS5gQjzpHufiM+256Od4Tn2cCAnvc3eCvWG8Lwun/s3IrskzDJmsCKGktxqMcGksZrOvLQL/PvrHTsrHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnjmVS27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC03BC433F1;
	Thu,  8 Feb 2024 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707427212;
	bh=0wWe0YAzwZgyv/3+8weFv30HET9B4Cd2WgTwkK3SakI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnjmVS27glab5wa0li66EW96HAkQDCAhBiyH29TYFhy29nAcK/5BhDaJFbWoaCjhj
	 uVw4X2CYYZCDBRVmHl0T9Z/2qfBm5ZWrtfZqDdQsNbPl9vghfAwICGDMLvvn6tWjVz
	 D/HPwODfh8kD2e359ph+RiDuXWZEXJ4tSJSBTXYYIQ1CrVAH3CUV/GYAUFbGUrsXwb
	 awQOO4R442XqoSaI8D5kiwo7XoP1r7aPL2hZ/7p4fqEjSwwbOIsMo8QKVxFz6+fSEa
	 7l35MmM1yClqLti6/QPyeV4fLNCKYhDEfEf4AAVicgm9EelSRA/UEfN164aNIenyZr
	 ly4JxZeLc07EA==
Date: Thu, 8 Feb 2024 21:20:08 +0000
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
Message-ID: <20240208-outing-nature-74b6fab0cdea@spud>
References: <20240207062403.304367-1-Frank.Li@nxp.com>
 <20240207-yoga-mobility-90a728f6342c@spud>
 <ZcPCn8q7viB/qcOH@lizhi-Precision-Tower-5810>
 <20240208-jarring-frolic-8d4c9b409127@spud>
 <ZcUs16+Z+I4m4q00@lizhi-Precision-Tower-5810>
 <20240208-revoke-doorman-5ba34f39c743@spud>
 <ZcU3ohEg5Z1ky+/W@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BkMhcd+HVPXZrhES"
Content-Disposition: inline
In-Reply-To: <ZcU3ohEg5Z1ky+/W@lizhi-Precision-Tower-5810>


--BkMhcd+HVPXZrhES
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 03:20:50PM -0500, Frank Li wrote:

> > > > > > > +  reg:
> > > > > > > +    maxItems: 2
> > > > > > > +
> > > > > > > +  reg-names:
> > > > > > > +    items:
> > > > > > > +      - const: regs
> > > > > > > +      - const: addr_space
> > > > > >=20
> > > > > > The example uses "regs" and "config". Where did addr_space come=
 from?
> > > > >=20
> > > > > Example just show pcie-host part. Not show pcie-ep part.
> > > > > pcie-ep part need 'addr_space'.
> > > >=20
> > > > Okay. Again, please mention where this is coming from.
> > >=20
> > > Ideally it comes from snsp,dwc-pcie-ep.yaml. but it is use 'dbi' inst=
ead
> > > of 'regs'. It needs extra effort to make driver code algin common
> > > snps,dwc-pcie-ep.yaml, and update exist all dts files.
> > >=20
> > > I think it will be deleted soon.=20
> >=20
> > What I am looking for here is you to explain in the commit message that
> > the endpoint driver in linux and the dts have always used "addr_space".
> > Checking that there's not a u-boot or *bsd that uses "config" would also
> > be very helpful.
>=20
> I confused. Actually this two part PCIE-RC and PCIE-EP.
> PCIE-RC using 'config'
> PCIE-EP using 'addr_spcae'

Yeah, I get this. The text binding makes it seem like "config" should be
used for both RC and EP, so I am just asking you to check that there are
no drivers in other kernels or bootloaders that use "config" for EP
mode.

> I check old txt file, which have not mention it. I can remove it.

if you drop "addr_space", you'll need to update the endpoint driver so
that it supports both "addr_space" and "config". If there are no
endpoint drivers using "config" in other operating systems, and all the
dts files use "addr_space", documenting "reg" and "addr_space" for
endpoint mode seems fair to me.

Thanks,
Conor.

--BkMhcd+HVPXZrhES
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcVFiAAKCRB4tDGHoIJi
0ncZAP426ohLG4dEVQblOtRj+sLza17dCRAZyQZGHBrzsJo9nAD+PL9tt9coV6Vx
iDk3vgPZfq9rP5eThu72FRj53o6qtg0=
=NA3v
-----END PGP SIGNATURE-----

--BkMhcd+HVPXZrhES--

