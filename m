Return-Path: <linux-pci+bounces-23293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE89A58EBA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC0C188F7FE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A38223705;
	Mon, 10 Mar 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cgrDTmbU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E62206B7
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597073; cv=none; b=LMdX4or/spWteIzHgezF5JwYDv3HlvakDPwu6/Ao1UTERSWIYfrgggsTVylguuairrAfm73RCI4Jo/N1AzZu0I9XQxvfk46BMqxpq2q6pNPplr/7lajai7fG0M/pMlysYulWVZFsI5nsMiSmzrM+35db1+SqkiVUzycSutZYZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597073; c=relaxed/simple;
	bh=xtVzbdeOorrzSo2NLxE7wNcL93WxGgbnzdKBJFN16Aw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T/OVBXUaCnAAgsndjH7cMMD8it3A2a5jdJOLpetNgpb55dFferGiC2dxMLWBDayz98y1/fAC45IF9nR+AyceVA/32k3GQHVLBv6gF2648hbNDduZxkX1eVGsdxkWjOwTX4UcSp8+1j+lGjw1ZGOuhPfWPp/2TQc/6irDwbbL6Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cgrDTmbU; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZB9lH4HsTz9sc6;
	Mon, 10 Mar 2025 09:57:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741597067; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSPWdBfnfywIostOoO0RKH7anKcNlAjLY1sPu3D6jWk=;
	b=cgrDTmbUGjzmYdh/Td4VsAz4BWv16UNTkMvamejPf1BLy1w6YVPNeK68bYymd8Elc4eHMG
	MUERoi3lE4/KsH87RFbpi+R1qrDnIctcL+fLL+FLPMhai3TDU5QZpqnNF0YBEVOQr6uu9R
	J1oX095avwpAq6IlAtfRncKNsYOEcxGGZ0v6FhxMo5n4ISxnelR67NTc2SewwtCv0qXyz1
	hbDabhib7HE8qwIQJsSw9HhqKsQt9xGIJ1dqFlOVrzpdldEnIlnD5C0Z7lFjYNEzYNiCF+
	u9I9LJUcIbgIawGXPKM8zfFel9L8sEOlRZFM8dt5Gg+GJ2QJTH4QyKz+63qq7Q==
Message-ID: <409544cb059cd484b8cedb35cf1e8cf13c6593e4.camel@mailbox.org>
Subject: Re: [bug report] PCI: Check BAR index for validity
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: phasta@kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Dan Carpenter
	 <dan.carpenter@linaro.org>
Cc: linux-pci@vger.kernel.org
Date: Mon, 10 Mar 2025 09:57:45 +0100
In-Reply-To: <809eab4e8563d12d2d1f26195cff32bde05c299d.camel@mailbox.org>
References: <20250308210720.GA469242@bhelgaas>
	 <809eab4e8563d12d2d1f26195cff32bde05c299d.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: ho76asqhh5uryn4uzjpjfu6h735w369j
X-MBO-RS-ID: 86147af385683bd8211

On Mon, 2025-03-10 at 08:54 +0100, Philipp Stanner wrote:
> On Sat, 2025-03-08 at 15:07 -0600, Bjorn Helgaas wrote:
> > On Sat, Mar 08, 2025 at 01:23:28PM +0300, Dan Carpenter wrote:
> > > Hello Philipp Stanner,
> > >=20
> > > Commit ba10e5011d05 ("PCI: Check BAR index for validity") from
> > > Mar
> > > 4,
> > > 2025 (linux-next), leads to the following Smatch static checker
> > > warning:
> > >=20
> > > 	drivers/pci/devres.c:632
> > > pcim_remove_bar_from_legacy_table()
> > > 	error: buffer overflow 'legacy_iomap_table' 6 <=3D 15
> >=20
> > Thanks, I dropped this patch for now.
> >=20
> > > drivers/pci/devres.c
> > > =C2=A0=C2=A0=C2=A0 621 static void pcim_remove_bar_from_legacy_table(=
struct
> > > pci_dev *pdev, int bar)
> > > =C2=A0=C2=A0=C2=A0 622 {
> > > =C2=A0=C2=A0=C2=A0 623=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 void __iomem **legacy_iomap_table;
> > > =C2=A0=C2=A0=C2=A0 624=20
> > > =C2=A0=C2=A0=C2=A0 625=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (!pci_bar_index_is_valid(bar))
> > >=20
> > > This line used to check PCI_STD_NUM_BARS (6) but now it's
> > > checking
> > > PCI_NUM_RESOURCES (15).
>=20
> What is even going on here. Why are thos different values? Does a PCI
> device now have at most 6, or 15 BARs?
>=20
> Or is a BAR different from a "resource"?
>=20
> And why would it be 15? I haven't read the standard, but I would
> suspect it should be 16.
>=20
> And which of those two here should be used?
> https://elixir.bootlin.com/linux/v6.14-rc4/source/include/linux/pci.h#L13=
3
>=20
> The comment doesn't say *which one* is "preserved for backwards
> compatibility".

Furthermore, I just saw that the old pcim_ code would then also be
half-broken, because it also uses PCI_STD_NUM_BARS, whereas the pci_
functions use PCI_NUM_RESOURCES:

https://elixir.bootlin.com/linux/v6.8.9/source/drivers/pci/pci.c#L6555


P.


>=20
> So many questions=E2=80=A6
>=20
> But granted, the check is wrong for the devres resource array, and I
> suppose it should be made the same size as pci_dev.resource.
>=20
>=20
> > >=20
> > > =C2=A0=C2=A0=C2=A0 626=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > =C2=A0=C2=A0=C2=A0 627=20
> > > =C2=A0=C2=A0=C2=A0 628=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 legacy_iomap_table =3D (void __iomem
> > > **)pcim_iomap_table(pdev);
> > > =C2=A0=C2=A0=C2=A0 629=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (!legacy_iomap_table)
> > > =C2=A0=C2=A0=C2=A0 630=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > =C2=A0=C2=A0=C2=A0 631=20
> > > --> 632=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 legacy_iomap_=
table[bar] =3D NULL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^
> > > Leading to a buffer overflow.
>=20
> Leading to a *potential* buffer overflow.
>=20
> Anyways, thanks for reporting.
>=20
> P.
>=20
>=20
> > >=20
> > > =C2=A0=C2=A0=C2=A0 633 }
> > >=20
> > > regards,
> > > dan carpenter
>=20


