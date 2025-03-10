Return-Path: <linux-pci+bounces-23283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D9BA58D84
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390A4188C4EC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F341A221F08;
	Mon, 10 Mar 2025 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dIdcJfKZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251003D3B3
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593708; cv=none; b=SnnWvhBlIePNCiHulzvGMNEcc4HKAIlyNB6Z20+4I5aS8f2egHEdcTeW3T00RYbn/DWkBcQq3hEX2p5URu8sXj55d/7yTIpCmIJROKChm+N90WiNzhpbwk4KF8fK5XIGWLasxPFTMO9r+/2GvZeFudMkQ/uzzT9MkgUbwu1nJHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593708; c=relaxed/simple;
	bh=nsL6N6ZyCgLBLlVkXC/5HFe7YjtgekPx7xKs92HpaqI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S0JKi2R+YJDwF1YSnndeOuqnI3vmmZ9RKp7j1gbNShpuj/dMgNnfsGmxQkCcsWWjM//3Ebzh6y337obbNAjMOpxXXE4AbqsyG/7xT8iLLrnG4HVJd6rrG7hncWLP3iKwVHTWNvM0y65nJaS5Z0jsz2mk70JwGU6ycJwVpBq/5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dIdcJfKZ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZB8Lm35n6z9tRp;
	Mon, 10 Mar 2025 08:54:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741593296; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sa4ZvGh1lQvg5deuv1neI9pHuNc+BpUrYariqIqgqCo=;
	b=dIdcJfKZWt7iB3YxsAUQRHWj8jhGGdzuL1xwh4S9CEZ6f+qQ9OiEWhozGO4NkxhfnGuRK2
	r/0+Lmwqzk9kBZJVWvzniMDH8yA8MgSah4oevWKiKByADQqW7+je8byn+AwGIEDfSTlpx1
	SrBbIUIWl6yO46B41wKSUZpKszgt3ztTWULbMWF0unqXGSIKkYICtZFaJlrbpum4CvKwxb
	GeZ7OVBMrxEvQL1uI1ERQOHMljRWk64dshkyV4GTyuXFz2c0Gb8jyR29YF7TUzCPXZj9d5
	ZhcnnO3ftuktM4xpHwHL57anfSCMriwzF3xRVPoYaYmd5jjaZOaFQKlV4vPJ2Q==
Message-ID: <809eab4e8563d12d2d1f26195cff32bde05c299d.camel@mailbox.org>
Subject: Re: [bug report] PCI: Check BAR index for validity
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>
Cc: Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Date: Mon, 10 Mar 2025 08:54:54 +0100
In-Reply-To: <20250308210720.GA469242@bhelgaas>
References: <20250308210720.GA469242@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: bqir4r15aoyfandj91qsoqo7113tbe5j
X-MBO-RS-ID: b876f486aa6f8fca5c6

On Sat, 2025-03-08 at 15:07 -0600, Bjorn Helgaas wrote:
> On Sat, Mar 08, 2025 at 01:23:28PM +0300, Dan Carpenter wrote:
> > Hello Philipp Stanner,
> >=20
> > Commit ba10e5011d05 ("PCI: Check BAR index for validity") from Mar
> > 4,
> > 2025 (linux-next), leads to the following Smatch static checker
> > warning:
> >=20
> > 	drivers/pci/devres.c:632
> > pcim_remove_bar_from_legacy_table()
> > 	error: buffer overflow 'legacy_iomap_table' 6 <=3D 15
>=20
> Thanks, I dropped this patch for now.
>=20
> > drivers/pci/devres.c
> > =C2=A0=C2=A0=C2=A0 621 static void pcim_remove_bar_from_legacy_table(st=
ruct
> > pci_dev *pdev, int bar)
> > =C2=A0=C2=A0=C2=A0 622 {
> > =C2=A0=C2=A0=C2=A0 623=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
void __iomem **legacy_iomap_table;
> > =C2=A0=C2=A0=C2=A0 624=20
> > =C2=A0=C2=A0=C2=A0 625=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (!pci_bar_index_is_valid(bar))
> >=20
> > This line used to check PCI_STD_NUM_BARS (6) but now it's checking
> > PCI_NUM_RESOURCES (15).

What is even going on here. Why are thos different values? Does a PCI
device now have at most 6, or 15 BARs?

Or is a BAR different from a "resource"?

And why would it be 15? I haven't read the standard, but I would
suspect it should be 16.

And which of those two here should be used?
https://elixir.bootlin.com/linux/v6.14-rc4/source/include/linux/pci.h#L133

The comment doesn't say *which one* is "preserved for backwards
compatibility".

So many questions=E2=80=A6

But granted, the check is wrong for the devres resource array, and I
suppose it should be made the same size as pci_dev.resource.


> >=20
> > =C2=A0=C2=A0=C2=A0 626=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > =C2=A0=C2=A0=C2=A0 627=20
> > =C2=A0=C2=A0=C2=A0 628=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
legacy_iomap_table =3D (void __iomem
> > **)pcim_iomap_table(pdev);
> > =C2=A0=C2=A0=C2=A0 629=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (!legacy_iomap_table)
> > =C2=A0=C2=A0=C2=A0 630=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > =C2=A0=C2=A0=C2=A0 631=20
> > --> 632=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 legacy_iomap_ta=
ble[bar] =3D NULL;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^
> > Leading to a buffer overflow.

Leading to a *potential* buffer overflow.

Anyways, thanks for reporting.

P.


> >=20
> > =C2=A0=C2=A0=C2=A0 633 }
> >=20
> > regards,
> > dan carpenter


