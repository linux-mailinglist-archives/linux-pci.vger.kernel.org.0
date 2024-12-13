Return-Path: <linux-pci+bounces-18399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61DF9F1382
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 18:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE381188D8E6
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FF31E3DEF;
	Fri, 13 Dec 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQrXubfX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516481E2843
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110473; cv=none; b=sQBnHzMYpBVx6aEASyTj9ehlA4gqJmJYW3nFF/gjXGoB1GhiXqkIwV1sz1yi949QmGkl3We8AWZEvrnKZs0Z6g/2yyGJIYERXaKQdoyXn42qVyN7VYE2BUlOqUBfWY957oBr3MvYrWqkRMlV1yzViMoIeRjWtNsP6eoJq2Osju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110473; c=relaxed/simple;
	bh=O6BEWB0qNMPXLIG9Ljl6WARQhVnfpXlw3ZtoKL3AcNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q21sp2FoD8MkYJ4gx+cbSCEZFMrC7UO4d9IodCENhSFfKHNQLZEw5MmPKGq/pkHPKsJOJZSKb9T344tHDqZ9V2cqIrKyZHYSYIspU1lssxKR8G7Oy/CyjGXYuU67nEh3YcsahYgS8QTss3UxAlQ1u/4fbHqbMHBIg25jxaozjpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQrXubfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FD2C4CED0;
	Fri, 13 Dec 2024 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734110472;
	bh=O6BEWB0qNMPXLIG9Ljl6WARQhVnfpXlw3ZtoKL3AcNg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rQrXubfXWcui+QBMnbyFs5RZIQ7BHsZXE3elOd6sAGN/+jxIKbYldmjoiwUPbSozi
	 TTloZLVKJ4deNCO2x0hAbi5STFOOY96l62Johq1nHfQh+hrPDvEjJ1hITF5Qv4Tbgk
	 Skbf6JGhx36W51w9YH981MFNKZC/ckFadOMOvDdWjVFD9PttSxga0xyWHNKqIlxRsT
	 xJut1LzP1Hrrpnf2Mu7lJ2Sx64nxOu1xe206wIGQiN6/7aKmYEZpKoM7OpOHy9bWlx
	 JCRGa/0WHrxBdCxL1+VYkxydTMa1JUSD3d1X0n03Dm2mSVdFf42D1+rjX4g9SxYcVa
	 shUgEGqfpC/3w==
Message-ID: <21441f5a56a1b70789ffa915cc1a492eb67751ab.camel@kernel.org>
Subject: Re: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
From: Niklas Schnelle <niks@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>,  "Maciej W. Rozycki"	 <macro@orcam.me.uk>
Date: Fri, 13 Dec 2024 18:21:09 +0100
In-Reply-To: <f8bf764f-4233-0486-54b6-2380b446cd5a@linux.intel.com>
References: 
	<e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de>
	 <30db80fd-15bd-c4a7-9f73-a86a062bce52@linux.intel.com>
	 <Z1tgJoTRnldq8NYE@wunner.de>
	 <f8bf764f-4233-0486-54b6-2380b446cd5a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 12:12 +0200, Ilpo J=C3=A4rvinen wrote:
> On Thu, 12 Dec 2024, Lukas Wunner wrote:
>=20
> > On Thu, Dec 12, 2024 at 04:33:23PM +0200, Ilpo J=C3=A4rvinen wrote:
> > > On Thu, 12 Dec 2024, Lukas Wunner wrote:
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -6240,12 +6240,14 @@ u8 pcie_get_supported_speeds(struct pci_dev=
 *dev)
> > > >  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
> > > >  	speeds =3D lnkcap2 & PCI_EXP_LNKCAP2_SLS;
> > > > =20
> > > > +	/* Ignore speeds higher than Max Link Speed */
> > > > +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > > > +	speeds &=3D GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 0);
> > >=20
> > > Why do you start GENMASK() from 0th position? That's the reserved bit=
.
> > > (I doesn't exactly cause a misbehavior to & the never set 0th bit but
> > > it is slightly confusing).
> >=20
> > GENMASK() does a BUILD_BUG_ON(l > h) and if a broken PCIe device
> > does not set any bits in the PCI_EXP_LNKCAP_SLS field, I'd risk
> > doing a GENMASK(0, 1) here, fulfilling the l > h condition.
> >=20
> > Granted, the BUILD_BUG_ON() only triggers if l and h can be
> > evaluated at compile time, which isn't the case here.
> >=20
> > Still, I felt uneasy risking any potential future breakage.
> > Including the reserved bit 0 is harmless because it's forced to
> > zero by the earlier "speeds =3D lnkcap2 & PCI_EXP_LNKCAP2_SLS"
> > expression.
>=20
> Fair but that's quite many thoughts you didn't record into the commit=20
> message. If you intentionally do confusing tricks like that, please be=
=20
> mindful about the poor guy who has to figure this out years from now. :-)
> (One of the most annoying thing in digging into commits far in the past=
=20
> are those nagging "Why?" questions nobody is there to answer.)
>=20
> I know it doesn't misbehave because of bit 0 is cleared by the earlier=
=20
> statement. (I also thought of the GENMASK() inversion.)
>=20
> Another option would be to explicitly ensure PCI_EXP_LNKCAP_SLS is at=20
> least PCI_EXP_LNKCAP2_SLS_2_5GB which would also ensure pre-3.0 part
> returns always at least one speed (which the current code doesn't=20
> guarantee).
>=20
> As in more broader terms there are other kinds of broken devices this=20
> code doesn't handle. If PCI_EXP_LNKCAP2_SLS is empty of bits but the=20
> device has >5GT/s in PCI_EXP_LNKCAP_SLS, this function will return 0.
>=20
> > > I suggest to get that either from PCI_EXP_LNKCAP2_SLS_2_5GB or=20
> > > PCI_EXP_LNKCAP2_SLS (e.g. with __ffs()) and do not use literal at all
> > > to make it explicit where it originates from.
> >=20
> > Pardon me for being dense but I don't understand what you mean.
>=20
> I meant that instead of GENMASK(..., 0) use
> GENMASK(..., __ffs(PCI_EXP_LNKCAP2_SLS)). But it doesn't matter
> if go with this bit 0 included into GENMASK() approach.
>=20


So that's essentially GENMASK(=E2=80=A6, 1). The reason I'm not sure if it
really is more self documenting is that anyone trying to grok this is
going to look in the PCIe spec and that already shows the bit 0 as
reserved (if it still is reserved then) and the bit numbering
explaining the offset and the __ffs() is just going to add confusion.
Instead I prefer your other idea of GENMASK(=E2=80=A6,
PCI_EXP_LNKCAP2_SLS_2_5GB) because together with that constant's
comment it clearly communicates "starting at LNKCAP2 SLS Vector bit 0".

For the issue of GENMASK() not being well defined for l =3D=3D 0, I think
the code should handle lnkcap2 =3D=3D 0 explizitly which is basically your
point above about other broken devices.

Thanks,
Niklas

