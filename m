Return-Path: <linux-pci+bounces-3247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7302984E918
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 20:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DAB287910
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 19:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1343381C1;
	Thu,  8 Feb 2024 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l85qlyGz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92F381BE;
	Thu,  8 Feb 2024 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707421504; cv=none; b=fGqdYxudkqiyXvBBWcTasEcFVQjUW7uEpVIwQJLn44IXX6POegrI8fnt454pORubgo14ewWQ31GN9tWjxHlCIDPqaPC7J9snA2sMaF3r/FRsz11G20tBzu0Jz5jcoQyhmV0O3fPy5vALXMJHq3ajKvumAI1B/3+Wf6MxDjACMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707421504; c=relaxed/simple;
	bh=2l1tUOHCZWdiX/9Elx5aQIoUXcEcudfp7fVDeYyh7Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gn0chvp5evJsW6zgtZotWbXere7NZSH2s9RxpGSMB1T/X8em6hseokTycO/lwANilp8GWBtegBciT5LxdubVl2Vq9k6mcvIG9hqk/soJAyOF4bGZBg9cXXXw0rmxuiFy/qruQpOoJ1Mta+k3/CBxwxKZIy+5/gjAwBJO7ZxylbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l85qlyGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C054FC433F1;
	Thu,  8 Feb 2024 19:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707421504;
	bh=2l1tUOHCZWdiX/9Elx5aQIoUXcEcudfp7fVDeYyh7Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l85qlyGzwjrx1J9QVyRPLQdeZ97wSwh5w19HA0aHLOEKbmgVfa4vLLCxL8TNeQoX9
	 X3BlxdpOtNHmUujbHeBXC/YeSYhf10TkjgUdt+7Tq9LQMCz00URsdXTNHa/OtY4RR0
	 OcpqXaNmnAUATC3w8YNaYj6w8SydUoFBx2js+0kvzNCHTLllxEArCRJp0E8ZHkdk+L
	 iPw+yO/I7fcS3iKjQ+8Pq1CgQFrkaM9lbr38wPnH9+jS6D8VlHE72fss6oYXPqVWG9
	 NYJ8JP0qIUJKwcVZKcPZkO1/NhjtZdCtKjb5XtfQd0/CicsI0dQQlDBamW5mHtwCva
	 TZ69Rfze9uq7A==
Date: Thu, 8 Feb 2024 19:44:59 +0000
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
Message-ID: <20240208-revoke-doorman-5ba34f39c743@spud>
References: <20240207062403.304367-1-Frank.Li@nxp.com>
 <20240207-yoga-mobility-90a728f6342c@spud>
 <ZcPCn8q7viB/qcOH@lizhi-Precision-Tower-5810>
 <20240208-jarring-frolic-8d4c9b409127@spud>
 <ZcUs16+Z+I4m4q00@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rMxUxceKvHhVm2vW"
Content-Disposition: inline
In-Reply-To: <ZcUs16+Z+I4m4q00@lizhi-Precision-Tower-5810>


--rMxUxceKvHhVm2vW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 02:34:47PM -0500, Frank Li wrote:
> On Thu, Feb 08, 2024 at 07:12:47PM +0000, Conor Dooley wrote:
> > On Wed, Feb 07, 2024 at 12:49:19PM -0500, Frank Li wrote:
> > > On Wed, Feb 07, 2024 at 05:17:55PM +0000, Conor Dooley wrote:
> > > > On Wed, Feb 07, 2024 at 01:24:02AM -0500, Frank Li wrote:

> > > > > +
> > > > > +  This controller derives its clocks from the Reset Configuratio=
n Word (RCW)
> > > > > +  which is used to describe the PLL settings at the time of chip=
-reset.
> > > > > +
> > > > > +  Also as per the available Reference Manuals, there is no speci=
fic 'version'
> > > > > +  register available in the Freescale PCIe controller register s=
et,
> > > > > +  which can allow determining the underlying DesignWare PCIe con=
troller version
> > > > > +  information.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - fsl,ls2088a-pcie-ep
> > > > > +      - fsl,ls1088a-pcie-ep
> > > > > +      - fsl,ls1046a-pcie-ep
> > > > > +      - fsl,ls1028a-pcie-ep
> > > > > +      - fsl,lx2160ar2-pcie-ep
> > > >=20
> > > > Where did the fallback compatible go?
> > >=20
> > > So far, no fallback compatible needed now. each devices already have =
its
> > > compatible string.
> >=20
> > It used to exist though, have you checked that u-boot or *bsd etc do not
> > use the fallback compatible? You also need to mention your justification
> > for removing it in the commit message.
>=20
> This commit just convert binding doc from txt to yaml. I just make sure
> which equal to what descript in txt.

The text binding does have a fallback compatible though:
  EP mode:
	"fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep"
So this is a change compared to the text binding, without any
justification for it being okay to do.

> If there are someting wrong in "uboot"
> or "bsd", we can fixed it later.

If other bits of software are using the fallback, you cannot remove it.

> I checked driver code. exited dts tree
> under kernel, which use unexited fallback compatible string
> "fsl, lx-pcie-ep", which should be removed at dts file.

What do you mean by "unexisted"? It was in the text binding, so it is
perfectly fine to have it in the dts. Given it has users, I don't think
you should be removing the fallback without a very good justification.

> > > > > +  reg:
> > > > > +    maxItems: 2
> > > > > +
> > > > > +  reg-names:
> > > > > +    items:
> > > > > +      - const: regs
> > > > > +      - const: addr_space
> > > >=20
> > > > The example uses "regs" and "config". Where did addr_space come fro=
m?
> > >=20
> > > Example just show pcie-host part. Not show pcie-ep part.
> > > pcie-ep part need 'addr_space'.
> >=20
> > Okay. Again, please mention where this is coming from.
>=20
> Ideally it comes from snsp,dwc-pcie-ep.yaml. but it is use 'dbi' instead
> of 'regs'. It needs extra effort to make driver code algin common
> snps,dwc-pcie-ep.yaml, and update exist all dts files.
>=20
> I think it will be deleted soon.=20

What I am looking for here is you to explain in the commit message that
the endpoint driver in linux and the dts have always used "addr_space".
Checking that there's not a u-boot or *bsd that uses "config" would also
be very helpful.

Thanks,
Conor.


--rMxUxceKvHhVm2vW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcUvOwAKCRB4tDGHoIJi
0pEOAQC+6pG9TSecqqT+uAlpAWFYvajdjJeRy9uODgGeXd24MgEA2eU3EIx1Ow4G
bun7vzHAbXh2WeyPo16JHqUZjTFBRAQ=
=Du8B
-----END PGP SIGNATURE-----

--rMxUxceKvHhVm2vW--

