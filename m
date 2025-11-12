Return-Path: <linux-pci+bounces-40983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E42BC51ECD
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 12:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1793BE487
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 11:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13C02D2390;
	Wed, 12 Nov 2025 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=rol7and@gmx.com header.b="VvIivwVZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5322BE7CD;
	Wed, 12 Nov 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946173; cv=none; b=gUP0qLG0sZAk1r5PLxZ2aHWaXv5znipd0Ehn1w5cg+ic6JyDWsno3bYU7bMyDr1MYr5tPX+Cya1lc/lTbAEr/kKAL+r1XhR7djNoEdgL8IUU0ga1QOF5CFlJKcbAD1N6U1YMdoLK0mmN5Z4p80fxN3l1SvLY+ojRTJBcGOLrkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946173; c=relaxed/simple;
	bh=7LFsq6zPgzEG1xgnfD1CN2ptFpdtR8YL2pLWPVvB0aI=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=E4EYRKETZaCedmfgskQolO5b3NDXxuq1qKtYh2AV9LQzdLP+gHuOLGAtV3cu/k+MpZ9cvC6Jq0IRFWS2uHy3aKdogBDZRrTMwa+MpQ64WPMTqZ3IHvIKPLb/zBrOSyL8nJfmluDUR5AuZ/4mPqnY/fjsddDPoVxh91VFB0ZApOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=rol7and@gmx.com header.b=VvIivwVZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762946142; x=1763550942; i=rol7and@gmx.com;
	bh=V3dMfSLDA9/5oLhZRelXMXFipEIatIZnUCKkgQaeT+A=;
	h=X-UI-Sender-Class:From:To:CC:Date:Message-ID:In-Reply-To:
	 References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VvIivwVZdI6pguO96OlUtgefexm3BEswgEO7vaXyp7sWowv/7w6GzwfL4rsss0hA
	 ekqMxf8Y+pciWq5PFIr4vRxSX6Tcqv6kLHnrttiMKxN8hgNDpiN/ywX2f0l+KdkBs
	 AQW4JXzoR73pUW2kvq7ouR6DD75faV7AR1wus3EQt3bpHgMS2JP4WABdE3REgrNXS
	 rg9ng7Kz64w+vICwQkVjR0uGrh/Mqx+XqIM/xJtgtt8sLnKj1o5NInQCup2W/R3ie
	 0ECyJOghV5J6mCJpHqlZ2PgzQdnuuJRF+WDTtcdenSvpJgCwWJq8RoT2HZedoxsSJ
	 9Z5jrpZi1yoo+lanVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([81.197.35.33]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mzyya-1w54XY103a-017cWZ; Wed, 12
 Nov 2025 12:15:42 +0100
From: Roland <rol7and@gmx.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	R . T . Dickinson <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	luigi burdo <intermediadc@hotmail.com>,
	Al <al@datazap.net>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au,
	linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Nov 2025 13:15:44 +0200 (EET)
Message-ID: <5a084954898.59053dc9@mail.gmx.com>
In-Reply-To: <20251111171125.GA2190513@bhelgaas>
References: <20251110222929.2140564-1-helgaas@kernel.org>
 <20251111171125.GA2190513@bhelgaas>
User-Agent: YAM/2.10-dev (AmigaOS4; PPC; rv:20210601-b6f7110)
Subject: Re: PCI/ASPM: Allow quirks to avoid L0s and L1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:EqKJ57t0N3ZHa+lDhvy8GiMuetI+banQcpulZjM3kqdTlN1LBCZ
 QXJ9XL5cnvHJgXh0IaltLyx8zv6KL5RQ0RvB8QENtBBUX1GQLlbKQFYvrCdpXFFqiAHa3HN
 dIkCpBeULDm8sVLxokZxzu0pf+moAm3MwnOp1K/2so4OHbKQR1f3Mb2AzZ8FCTOnOmXVn2E
 fLZFm2a3T+xLXbdAmTMSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sa5qCy8gJIs=;BN0vMc95JN7p8mSt/wB7j/NaAtA
 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
Content-Transfer-Encoding: quoted-printable

Hello all!

I started to get to my email these discussions about Linux a few days ago.=
 I have not subscribed any mailing list, or given anyone permission to inc=
lude my name on such list!

So, if there is a moderator on this list, could you PLEASE remove immediat=
ely my email (rol7and@gmx.com) from the recipients/cc list? Thank you!

If there is no moderator, could the participants then please take care to =
remove my email from their messages? Thank you!

Regards,

Roland



> On Mon, Nov 10, 2025 at 04:22:24PM -0600, Bjorn Helgaas wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>>=20
>> We enabled ASPM too aggressively in v6.18-rc1.  f3ac2ff14834 ("PCI/ASPM=
:
>> Enable all ClockPM and ASPM states for devicetree platforms") enabled
>> ASPM L0s, L1, and (if advertised) L1 PM Substates.
>>=20
>> df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree
>> platforms") (v6.18-rc3) backed off and omitted Clock PM and L1 Substate=
s
>> because we don't have good infrastructure to discover CLKREQ# support,
>> and L1 Substates may require device-specific configuration.
>>=20
>> L0s and L1 are generically discoverable and should not require
>> device-specific support, but some devices advertise them even though
>> they don't work correctly.  This series is a way to add quirks avoid L0=
s
>> and L1 in this case.
>>=20
>>=20
>> Bjorn Helgaas (4):
>>   PCI/ASPM: Cache L0s/L1 Supported so advertised link states can be
>>     overridden
>>   PCI/ASPM: Add pcie_aspm_remove_cap() to override advertised link
>>     states
>>   PCI/ASPM: Convert quirks to override advertised link states
>>   PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
>>=20
>>  drivers/pci/pci.h       |  2 ++
>>  drivers/pci/pcie/aspm.c | 25 +++++++++++++++++--------
>>  drivers/pci/probe.c     |  7 +++++++
>>  drivers/pci/quirks.c    | 38 +++++++++++++++++++-------------------
>>  include/linux/pci.h     |  2 ++
>>  5 files changed, 47 insertions(+), 27 deletions(-)
>
> Applied to pci/for-linus, hoping for v6.18.  Thanks Shawn and Lukas
> for testing and reviewing.  Any other comments and testing would be
> very welcome.
>
> I think we'll need to add a similar quirk for Christian's X1000
> (https://lore.kernel.org/r/a41d2ca1-fcd9-c416-b111-a958e92e94bf@xenosoft=
.de),
> but I don't know the device ID for it yet.
>
>> --=20
>>=20
>> v1:
>> https://lore.kernel.org/r/20251106183643.1963801-1-helgaas@kernel.org
>
>> Changes between v1 and v2:
>> - Cache just the two bits for L0s and L1 support, not the entire Link
>>   Capabilities (Lukas)
>> - Add pcie_aspm_remove_cap() to override the ASPM Support bits in Link
>>   Capabilities (Lukas)
>> - Convert existing quirks to use pcie_aspm_remove_cap() instead of
>>   pci_disable_link_state(), and from FINAL to HEADER (Mani)
Regards


