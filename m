Return-Path: <linux-pci+bounces-18409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9819A9F153A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 19:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5EB1634F9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F4918871E;
	Fri, 13 Dec 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCbPbzcC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2342A1547CA
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115796; cv=none; b=cZkl1boTDJdjFJNgEeOb95URQdbQCj1Phdqhuo2MEnl3vfSg4xV/1pOkDKrJ07YsTseBK6nTuuVt7jFSaqW5I+2+hg71Kkzhmw5DVIQmSvvB++pbn7S9AAu88mJqHnnNOjpH6nExG2bZQcrRiOdwPjTCNMZzLE0LM/Avs3gWBsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115796; c=relaxed/simple;
	bh=NHMaCImy5uCpgK+P8XFSDKqBeD5tlffhitsqC2f3SAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vA7Y+MuI4iudkDaBr+Pk+PCBNEvWfWErYLs9w10Y57jMAzEjlR4Y/3G4aw6hTHn/mIE5zVzUlaDBv+vI8v7cCVqc4aYrgACqPLKNflotsPlmCxbLA5AABsfOPsrfU4bjgfltVuHRRnMlyze0iqyoq1dWySC3ibtv+SSNIexah5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCbPbzcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DC6C4CED0;
	Fri, 13 Dec 2024 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734115795;
	bh=NHMaCImy5uCpgK+P8XFSDKqBeD5tlffhitsqC2f3SAM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sCbPbzcCqTak7QUaCb8ugV7P6py/pgFbsb5q1ARbEjtt/nVy35mB7qmUxyjdur+vl
	 hAtGFa2f/CKPPiM9J7/ANs47tLfSg6umfveCubRAa3+ivqEIaTgfW8BQ7lua9UHKkA
	 j1PSekcZ4MXdUixtvktkXc8Kpnw5ZjXYpvDWnt2iVNz8Nl6xmymDRdfjwmCkhe8Kgj
	 yuKwSTKJH1UcTfpViTeb57f+Zc052cSKxh1vIYN3CfFb/dtoTlTIJNoM9P74CUyN3x
	 GsUKdOvjhaN9hpVtk1UJZAOL2FZZHsiVybTOaprviiLc436IrsHyTxPcn2KvxpazsQ
	 O8Wn7EVAHOA7w==
Message-ID: <e34ace63dfb3331cb36778d13696457a92e39892.camel@kernel.org>
Subject: Re: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
From: Niklas Schnelle <niks@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>,  "Maciej W. Rozycki"	 <macro@orcam.me.uk>
Date: Fri, 13 Dec 2024 19:49:52 +0100
In-Reply-To: <71784f5660f0f5d9927f01b7313a1395155f9214.camel@kernel.org>
References: 
	<e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de>
		 <30db80fd-15bd-c4a7-9f73-a86a062bce52@linux.intel.com>
		 <Z1tgJoTRnldq8NYE@wunner.de>
		 <f8bf764f-4233-0486-54b6-2380b446cd5a@linux.intel.com>
	 <71784f5660f0f5d9927f01b7313a1395155f9214.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 18:41 +0100, Niklas Schnelle wrote:
> On Fri, 2024-12-13 at 12:12 +0200, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 12 Dec 2024, Lukas Wunner wrote:
> >=20
> > > On Thu, Dec 12, 2024 at 04:33:23PM +0200, Ilpo J=C3=A4rvinen wrote:
> > > > On Thu, 12 Dec 2024, Lukas Wunner wrote:
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > > > > @@ -6240,12 +6240,14 @@ u8 pcie_get_supported_speeds(struct pci_d=
ev *dev)
> > > > >  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
> > > > >  	speeds =3D lnkcap2 & PCI_EXP_LNKCAP2_SLS;
> > > > > =20
> > > > > +	/* Ignore speeds higher than Max Link Speed */
> > > > > +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > > > > +	speeds &=3D GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 0);
> > > >=20
> >=20
>=20
> ---8<---
>=20
> > As in more broader terms there are other kinds of broken devices this=
=20
> > code doesn't handle. If PCI_EXP_LNKCAP2_SLS is empty of bits but the=
=20
> > device has >5GT/s in PCI_EXP_LNKCAP_SLS, this function will return 0.
>=20
> On second look I don't think it will. If lnkcap2 & PCI_EXP_LNKCAP2_SLS
> is 0 it will proceed to the synthesize part and rely on
> PCI_EXP_LNKCAP_SLS alone. The potentially broken part I see is when
> lnkcap2 has bits set but lnkcap doesn't which is also when the
> GENMASK(=E2=80=A6, 1) would become weird. Not sure what the right handlin=
g for
> that is though.

Never mind, I missed the >5 GT/s bit. Though I think that returning 0
speeds is probably the safest bet for a broken device, no?

