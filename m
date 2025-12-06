Return-Path: <linux-pci+bounces-42719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CC0CAA3DF
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 11:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B9F4300A6F6
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 10:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739A82DECA8;
	Sat,  6 Dec 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="t9suDVTk"
X-Original-To: linux-pci@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB312D9ED1;
	Sat,  6 Dec 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765016059; cv=none; b=aBRjQhN/G6C3Yxq1gdh5HAe0HpZwUDBIhbizMDf05Zj7FJxZfTQISxM9q0L5o5JvFCoGubWo3HfuUrnnWtOk7zPfTx+4XTB4a4D1BXPnRqE+1BImjDSdohFRaUK1JKiXtsxeWzS1W/0MrbGtk79kVi4MiPTNVDTR27IeNOjUu18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765016059; c=relaxed/simple;
	bh=RvXY1mK21fMf76rVzO0xfzxgkltUDfNA1Ma7vJmuDSw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TiYDxRNtCNkIP4bUuABHl7m3TCp12v+GCC2/Z0EPSYN7cKJ9p8R6AKWxfu1sRhSxRxNabB4D5CQdaPm/g04EBRokC+lB3LdtR6Kmprr6ypJAmOqLNhmxHC8thX6rICyEsk2/n3x98OLH/oolkCNAdharYvcCPoRqQ7+e4Ce1Y4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=t9suDVTk; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FUeR/pdT2p/5K9RdNPtaaovNOMCb4BxH4cinQgeLprI=; b=t9suDVTk6RCEte9MQKNP4yFKs1
	TEmP5E6YeDbbVZVq/s29cR0EJjmqXAlxNGnJd4C+jGOUbPk9GzDWunHrZdwml7u/+uOpzjTpEZ8Ev
	pIHnBY7O3DLQC6LPo9X3J9NeFS8AISVYlNEDNMKbs/1dwoaA46o6Hg1b/73vNucdTQcAPJjbXEOPd
	Ys3U7fc9ScZ6LTX/7ffovd3ZdNjP5nre6QW7lIR3+7ZZvWCWr9qoIvcLUQwAUqtm00LtDo0mGBZHB
	1umLHfQXig1F5SbfpQTzFALdTY5x7oh2RGjhWjx893KGnwTic/B1zfEQ8tCNp8YhCXFUrh38dvy86
	hNYTg3Pw==;
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
In-Reply-To: <alpine.DEB.2.21.2512050237490.49654@angie.orcam.me.uk>
Date: Sat, 6 Dec 2025 11:14:05 +0100
Cc: glaubitz@physik.fu-berlin.de,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 riccardo.mottola@libero.it
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FB48A2F-A8E9-4E1D-8052-568FB1E72643@exactco.de>
References: <20251202.174007.745614442598214100.rene@exactco.de>
 <05c588754dcb83badaec6930499392fdd26be539.camel@physik.fu-berlin.de>
 <20251202.180451.409161725628042305.rene@exactco.de>
 <alpine.DEB.2.21.2512050237490.49654@angie.orcam.me.uk>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi,

> On 6. Dec 2025, at 02:07, Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>=20
> On Tue, 2 Dec 2025, Ren=C3=A9 Rebe wrote:
>=20
>>> Is there actually a justification to restrict the use of D3 to =
ARM64,
>>> PPC64 and RISCV? What about MIPS, LoongArch or s390x?
>>=20
>> Because the ones I picked are more modern, and thus more likely to
>> work. MIPS is very old. [...]
>=20
> How old is "very old?"
>=20
> Granted, the newest MIPS CPU/system controller (aka host bridge) I own =
is
> from 2013 and conventional PCI only, but that is just because the core =
was=20
> synthesised for interfacing a conventional PCI base board I have the =
core=20
> card plugged into.  Is it very old already or just somewhat old?
>=20
> Chips continue being manufactured to date and I'm not sure as to new =
core
> designs, but those went through to at least 2018 and I'd expect some =
were=20
> combined with PCIe system controller IP.
>=20
> So this seems like something that needs to be keyed off perhaps the=20
> capabilities of the system controller/host bridge?  If you give me a =
shell=20
> recipe to trigger the issue you came across, then I can see what =
happens=20
> with some of my MIPS systems.  I've got a bunch of options with =
PCI-PCIe=20
> reverse bridges and PCIe switches I could try.

Just booting a kernel with or since a5fb3ff63287 ("PCI: Allow PCI =
bridges to go
to D3Hot on all non-x86=E2=80=9D) should be enough. The systems that =
fail for me do
so instantly booting, usually earlier than later. e.g. when a storage, =
network or
system controller driver initializes.

Best,
	Ren=C3=A9

--=20
https://exactco.de =E2=80=A2 https://t2linux.com =E2=80=A2 =
https://patreon.com/renerebe


