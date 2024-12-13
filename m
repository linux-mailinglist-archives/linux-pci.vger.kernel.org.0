Return-Path: <linux-pci+bounces-18403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C2B9F1415
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 18:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B26282483
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 17:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EBA1E5702;
	Fri, 13 Dec 2024 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6nJdMZg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036117B505
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734111689; cv=none; b=kSERAh/XeD7qc/4neGxDp6m/EHnxtWsOMMrP7zAgAYMar4IKg37yX64M0fa/LmVHhCNx8NY/8q/lf1KHgKQwjJGOY0KAY9g5em665YRKV1+6lIN/zi8L7wz6n4QcyOb8OYFoBEor4p6BWLHU9ArzQGIQPZcL5QNjoOBAlyQasLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734111689; c=relaxed/simple;
	bh=gviHR/V7n23AGgmG4qi0mDfAV/LbyKvjKLrG+BLRTQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUYIRIbn255aBzUeLCYWZXdJFxXzbTbFdjjl6Vyz7GBIeynAVPCgxQmAG2mvZZfzcmmf+VmMfLEw3HXz3TDLU/5NQZynEIoA4caJv8Q0B9MijfehgCOIfiTAaCMjIBYG8Gn0Fbxjo1bGdqR+o3ziY4q3zQZ2ujFJnQy/66QYKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6nJdMZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2329EC4CEE3;
	Fri, 13 Dec 2024 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734111686;
	bh=gviHR/V7n23AGgmG4qi0mDfAV/LbyKvjKLrG+BLRTQ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U6nJdMZgpt+Fztbai5f0H1UhYzWJhK1uBauDAXbbxtdQkQSe56JjoQtIla0xCgmSG
	 e58+nXNwFKcRXREFUMns/hZqvlhYoYSe7Nw8rJ4Wwj6trSpeMEQ71o8LCS51qN3DW+
	 jAvqTaOztWGNXqv3fcqhR0bRwnjn6mK/strKpUh1gplkaJxI2NIOxb6vGz79eSBiU2
	 Q++kdSCMmszpWANfAr95EJAxZCuljoQKyUkcfarQeVY9LaPB8ChoWB2zhE5eQfqTc+
	 xkttfks5JUy+CdnoEOoYxGSovynLQ0T26PE3u0FkdKERzsSlsJooU2MYd3oeIG+LFp
	 6i2nOA7WmWRQg==
Message-ID: <71784f5660f0f5d9927f01b7313a1395155f9214.camel@kernel.org>
Subject: Re: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
From: Niklas Schnelle <niks@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>,  "Maciej W. Rozycki"	 <macro@orcam.me.uk>
Date: Fri, 13 Dec 2024 18:41:23 +0100
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
>=20

---8<---

> As in more broader terms there are other kinds of broken devices this=20
> code doesn't handle. If PCI_EXP_LNKCAP2_SLS is empty of bits but the=20
> device has >5GT/s in PCI_EXP_LNKCAP_SLS, this function will return 0.

On second look I don't think it will. If lnkcap2 & PCI_EXP_LNKCAP2_SLS
is 0 it will proceed to the synthesize part and rely on
PCI_EXP_LNKCAP_SLS alone. The potentially broken part I see is when
lnkcap2 has bits set but lnkcap doesn't which is also when the
GENMASK(=E2=80=A6, 1) would become weird. Not sure what the right handling =
for
that is though.


