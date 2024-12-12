Return-Path: <linux-pci+bounces-18344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F099EFD03
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 21:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC1516BE38
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 20:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11F91917D6;
	Thu, 12 Dec 2024 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9Afro7D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAD9189F2F
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034221; cv=none; b=RjrvCMX4RYrLAOUub+aHWk9RT3pUjdShP88tINlR4qkLh2L1PcgT+pjqkaF2q9XcZ3xRtgkClkggzizEhQQZwtC/9wqLFHsLICvsiqQuIl0BI7aRRHVQDn4qjC27lfc9UXc4iOpI+4ueoCaXFHeiQ19Qbrk6tjPbYEShgxGFY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034221; c=relaxed/simple;
	bh=opwhn1W3agyYrGoMDZgKYT+0Uhul2rcCVal9CgmojF8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F632/666C8loI5J9hVC34eaNgToDAl6QeifPyiRuyO2kizbaIjp4gwwz6ugX4bksVeDod6r5JUmBtgEs7XCA7WOp85JoxzvasVUeF01kvxTBpKKk5bF56mraEOrKZ/lPTVAbJJGjIh/FLJ660UcjifcT+WbAbn7NPZ0a24gPLgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9Afro7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48278C4CECE;
	Thu, 12 Dec 2024 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734034220;
	bh=opwhn1W3agyYrGoMDZgKYT+0Uhul2rcCVal9CgmojF8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=O9Afro7Dbj8LBgcujDbLuzLWw0P3IB6iwuOIbVnsK/wBcnvnEW1o/oCCWKUve7e8E
	 5pd2KACRJstb1JIUn6jAQd5jdHYlyMI4NJ6Pq6dA3MI+6fkKXIKE84fSNmaKqgGrGR
	 AQFjfge6tWVssNbjxTjmsh9fkQH7s2pI0rxZ19TGuIWUjvfQ3vD5ccp2GV+rx4G9CP
	 7bMgI9hbwLM9lNocP+XTgLc/8n8LA12n+xBJ4kZj0J2j2rL5DFmKOEMfzoe73DqU19
	 KQV2vSQvcgI5KTj6wPwM/CUNOoBf9W3DDwIVHiYeFOciHKsCy42DTRJ/PF7Pi+GVTU
	 5r/UL6+xPSUmw==
Message-ID: <5f479208803a38e373df97f2f9a83400d0286571.camel@kernel.org>
Subject: Re: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
From: Niklas Schnelle <niks@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>,  "Maciej W. Rozycki"	 <macro@orcam.me.uk>
Date: Thu, 12 Dec 2024 21:10:17 +0100
In-Reply-To: <30db80fd-15bd-c4a7-9f73-a86a062bce52@linux.intel.com>
References: 
	<e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de>
	 <30db80fd-15bd-c4a7-9f73-a86a062bce52@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-12 at 16:33 +0200, Ilpo J=C3=A4rvinen wrote:
> On Thu, 12 Dec 2024, Lukas Wunner wrote:
>=20
> > The Supported Link Speeds Vector in the Link Capabilities 2 Register
> > indicates the *supported* link speeds.  The Max Link Speed field in
> > the Link Capabilities Register indicates the *maximum* of those speeds.
> >=20
> > Niklas reports that the Intel JHL7540 "Titan Ridge 2018" Thunderbolt
> > controller supports 2.5-8 GT/s speeds, but indicates 2.5 GT/s as maximu=
m.
> > Ilpo recalls seeing this inconsistency on more devices.
> >=20
> > pcie_get_supported_speeds() neglects to honor the Max Link Speed field
> > and will thus incorrectly deem higher speeds as supported.  Fix it.
> >=20
> > Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> > Reported-by: Niklas Schnelle <niks@kernel.org>
> > Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d1=
369.camel@kernel.org/
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/pci.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 35dc9f2..b730560 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6240,12 +6240,14 @@ u8 pcie_get_supported_speeds(struct pci_dev *de=
v)
> >  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
> >  	speeds =3D lnkcap2 & PCI_EXP_LNKCAP2_SLS;
> > =20
> > +	/* Ignore speeds higher than Max Link Speed */
> > +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > +	speeds &=3D GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 0);
>=20
> Hi Lukas,
>=20
> Why do you start GENMASK() from 0th position? That's the reserved bit.
> (I doesn't exactly cause a misbehavior to & the never set 0th bit but
> it is slightly confusing).
>=20
> I suggest to get that either from PCI_EXP_LNKCAP2_SLS_2_5GB or=20
> PCI_EXP_LNKCAP2_SLS (e.g. with __ffs()) and do not use literal at all
> to make it explicit where it originates from.
>=20

Hi Ilpo,

I agree this is quite confusing even in the PCIe spec. According to
PCIe r6.2 the value of the Max Link Speed field references a bit in the
Supported Link Speeds Vector with a value of 0b0001 in Max Link Speeds
referring to bit 0 in Supported Link Speeds, a value of 0xb0010 to bit
1 and so on.=C2=A0So the value is actually shiftet left by 1 versus the
typical (i.e. non IBM ;-)) bit counting.

Then looking at the Supported Link Speeds description they refer to bit
0 as 2.5 GT/s, bit 1 as 5 GT/s up to bit 6 (RsvdP) while in the figure
the RsvdP is the right most bit. So unless I have completely confused
myself playing around with this genmask calculator[0] we actually want
GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 1) because just like the Supported
Link Speeds field the dev->supported_speeds also reserves the LSB. And
I feel this actually matches the spec wording pretty well. What do you
think?

Thanks,
Niklas

[0] https://mazdermind.de/genmask/

