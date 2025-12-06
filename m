Return-Path: <linux-pci+bounces-42718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2E4CAA3A0
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 11:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E838330DB82E
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E657B2046BA;
	Sat,  6 Dec 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="WRBVWFAy"
X-Original-To: linux-pci@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081112745C;
	Sat,  6 Dec 2025 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765015380; cv=none; b=S0eNKU5JQwDUwAwVtoKZkEmSLXmozD0NefLcIAaUwfSN4fVDzpY4mbvHQK6LezJtcka/9etZdwYbYO8bp4ss20NIGodVEJCqIisw5t42sP4IoMDzTa0ACQ4kBno2quRcBXc9JZTI1elMEoib1X1v0BzPB0BpWw9x5VSG/biuw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765015380; c=relaxed/simple;
	bh=PhD7vmRVfx6/WtsKvbaaHUXkRnVD9oSVu/kdnqj6nrw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=giHiqt1aHgiGrfXTOF/YIETRhXt1+ymefDIdxRHqGCAmMdR92dqk2iHME1AfTQQB76x3nhytJkThG0okEmPfX5xKt11+V3HSE4FgIDb/BazT5g57i87yvpX3pJj3Eo5mJGVmnJh4mzO9C2ijZgmrr1A7TikhVT6ythFCjiJI3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=WRBVWFAy; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=r+Vh+B9G/g6oH8Py8PgV9MCmFgG8TRslOQfdXJixcEM=; b=WRBVWFAykkEc7EZbktGSOz/DKw
	HrXxaP2e7KIj+bX7uAr4pjXPlEiYw4ZVOS30b0znpPVe0tzewHCBS7/N71gXR1A4Pt0D7cxOEq5hF
	hRiLNK4TpEBFql1cjgDdsE/R4ytJk7T5SZ3BSwweeA1ke4yQJ0JaWShKgmFTAG2l2C6mjUV2MZepJ
	VIAIVIKfs/P4HSbnh9Ly8mZmUhCtM64WIdgbfIRF7SGsD1RNYBbxFr/9P/4Ok0DhQzlZmzlCTNDGD
	6FgawlKtt4YlGKVaARZJNg24zZJdW08lEcQroaGBgU0VmddCdKvJZoAFhzVAanZtF5bh1EILnQYJl
	wEO3gjNQ==;
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
In-Reply-To: <f419b6d8a36e43c90e1875da5fb67a7f2a18a219.camel@physik.fu-berlin.de>
Date: Sat, 6 Dec 2025 11:02:51 +0100
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 riccardo.mottola@libero.it
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1DED1E0-BA75-466E-AEDA-6C56B8B163C3@exactco.de>
References: <20251202.174007.745614442598214100.rene@exactco.de>
 <05c588754dcb83badaec6930499392fdd26be539.camel@physik.fu-berlin.de>
 <20251202.180451.409161725628042305.rene@exactco.de>
 <alpine.DEB.2.21.2512050237490.49654@angie.orcam.me.uk>
 <f419b6d8a36e43c90e1875da5fb67a7f2a18a219.camel@physik.fu-berlin.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

(Resent, was accidentally HTML before :-/)
Hey,

On 6. Dec 2025, at 09:31, John Paul Adrian Glaubitz =
<glaubitz@physik.fu-berlin.de> wrote:
>=20
> On Sat, 2025-12-06 at 01:07 +0000, Maciej W. Rozycki wrote:
>> On Tue, 2 Dec 2025, Ren=C3=A9 Rebe wrote:
>>=20
>>>> Is there actually a justification to restrict the use of D3 to =
ARM64,
>>>> PPC64 and RISCV? What about MIPS, LoongArch or s390x?
>>>=20
>>> Because the ones I picked are more modern, and thus more likely to
>>> work. MIPS is very old. [...]
>>=20
>> How old is "very old?"
>=20
> I've got two desktop and one embedded Loongson MIPS systems at home =
(not LoongArch)
> and these are very recent (made in the 2020s). The desktop systems =
already come with
> PCI Express slots.

That=E2=80=99s great and all, but did you test a recent kernel since =
this PCI change I bisected
for sparc64?

I love my quirky Sgi MIPS64 Octane and O2 also very much, but fact is: =
those
systems had not only special proprietary high speed xbow interconnects, =
but also
very glitchy PCI bridges that already barely work to start with.

Also that just one modern Loongson system might work, does not mean all =
the
history of MIPS(64) system will be okay.

Just yesterday I found this change also breaking my HP PA-RISC C8000 [1] =
with:

BT Port failed to come ready!
BT_TRANSFER_INIT: B_BUSY failed to clear!

There was a reason given my experience keeping all CPU ISAs supported,
I had initially only chosen to allow modern ones. And again, they all =
where
not allowed to D3hot before, and only randomly allow listed since =
a5fb3ff63287
("PCI: Allow PCI bridges to go to D3Hot on all non-x86=E2=80=9D), Mar 20 =
11:06:04 2025.

So we probably should update this to at least include HPPA until someone
finds time to further debug and patch this better.

That being said I did not yet found an issue on old x86 systems with the =
2015
Year check removed to d3hot those more than mainline currently does.

Mit freundlichen Gr=C3=BC=C3=9Fen,
	Ren=C3=A9

[1] https://t2linux.com/hardware/desktop/HP/c8000/

--=20
https://exactco.de =E2=80=A2 https://t2linux.com =E2=80=A2 =
https://patreon.com/renerebe


