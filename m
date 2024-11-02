Return-Path: <linux-pci+bounces-15847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572349BA186
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 17:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE45CB20D4F
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 16:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA15D175D47;
	Sat,  2 Nov 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="syob1nQC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60396168483
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730566401; cv=none; b=GEYBS4G088T38kGYe1PVT0XMadtWUw3wlFTsMbyNOWsBOy+IHZCqupqe5o86IEDHLCXX5idPeX/Vs5UHLNJmmFfEdeAgHPK38/V84eDuuiCrB40OfCMT+5trWf+TlfWCSsXe67o1izEGtiTOO5frikjFHrC5/JDdqMBJYPyz1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730566401; c=relaxed/simple;
	bh=MgDc+4RKY2xvcW0WbGDQ2dsnT9EDWAKtW3JAXLHOmds=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Vwz7WYOumPeFzLEaexsGJ7O6Ic6cezzHej9kR+yKreuYnLDyCwoE2bIUY8sw3aSk3qcUwZeaU0eXkQe0Wuy7beUlUpGWO5mu18e14Zav2MxL9o8EJGvmd/xAgzbiHcMMEb5moWiRGwRUbhW1btL+YBtKkUXnCe4Q2aOxbyWw4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=syob1nQC; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730566386; x=1731171186; i=wahrenst@gmx.net;
	bh=MgDc+4RKY2xvcW0WbGDQ2dsnT9EDWAKtW3JAXLHOmds=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=syob1nQCX88zf2Gn8rKCgO9up0m1epSns2dVoyO4n0KfQrQEgDoScMwcSjeahWTu
	 7Uj/1WFSkz36xdJi2lEWq91CAC+kn3V4zTIvjR3/2ElxPx+DY9WKh6zST+OcH5SPY
	 m+OBbpNGcQeV0TYwND6ExmOYG9D7eL0Hdq+ULwNKnR7rVxFhs0+YdGbzz4GcN9GvD
	 fBx4tM32Rv+HIA1/YSHvraWbRT0zW6845bq4hMCNLoENhhNwkwLPrEt0UIpcXRyLi
	 yqCElWjQnqJcTsXAHSNd8/1Gz8vE5s74pJn+vDABvgemFlwNVXJS6MTksvaobfQcH
	 LiHLQI0apDTIQLrI2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1ty8yP392u-014Qls; Sat, 02
 Nov 2024 17:53:05 +0100
Message-ID: <dcd660fd-a265-4f47-8696-776a85e097a0@gmx.net>
Date: Sat, 2 Nov 2024 17:53:04 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, kernel-list@raspberrypi.com
From: Stefan Wahren <wahrenst@gmx.net>
Subject: pcie_bwctrl fails to probe on Rpi 4 (linux-next-20241101)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Um/oWJLBebFe/k7pMcRumtOLH+wxRFMab0wEOJT1mBJf1UrRCkS
 Curs1cFiA8IFerU6XBmFxRCRIR5nlfo7o/iD+rCFXY58dGEFybUN4NjWft+YYkmKGjyvFYm
 OfvkGao/Y2qOAcu46SBssH6u923a4hO9W+bqIGsM1Z3dPToLvrOxGhgFKg8vHUKBSAp9yHd
 lljm4zvFlhEdpn0LlWV8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s5AIksf9fKo=;7fd/H3NLb69QkzxqFO+TWUEjJLN
 TA/APhNIJ203Fl4dZpDwpx/5zc0ZFqTrYDs/RTVS8BIuAQPOrbYd9ZfTdjTGruRrK1Wii0ddm
 4w5JI88WnnGXpN18ftJazb08xqCxgyajBWVpmgzGSi4njyh6h6eqewMd5nN4fGZLNRugFyvUs
 g20UlM+G4qjeOhzR7vsICScDYvHahpM2FnpJgrm8iFblwNwOUJlM+EG4xL/nix8js3QldlI8h
 RQBWCSqs/jV8cGS6rLFPLGYVlJ2fKYhkEGjYnXg8bTgSwChfgwt9GVMcK5k1M67LJR8tsOt9U
 Tj1MOgvGYKPnYFc23QJ6DydM41kg3v54vQnI7go4qV5ErbpYltTzWfaknZtmVE66OXjv4CepM
 8JE2mvl+e7rpflAb8mnUHC1A07JY0jf9AB5OMVNhQK/lbEOtLT7bCceq08lhxPV2SQH0YaU0x
 dRpZxADKa83iz43b2/WU3DCUNncBHoGigWKXlh9FAQAuxx8yniDbKvtIRY2uuf3Z8OEcyr+98
 AxBILtuU3EwQi74NZCPFvnHlRO27ed88OTC198H0xMz8X9ML2v4s/KMhaBSdtlop0rtJ6eXpC
 4YU4yTgitR0EDDf5sufnyPszK1JjZz5JNtDKOHzR/cD6JGD1wqai9LOjIyxkBKSq33+eMy4Vy
 6LnWebEnqYUHT5kWiKorQOskyaRfB0DpPzBB7XwscN3WvPXS5aMg6+n7OB4lq9DmeW+2yhBKk
 jOvzfTkBwZR8B+rux1HjU53LCpZD76AwnJN+qJEwd4BY+Nrd7FQIK2wIzP/6wMOb+AxiAr9F1
 g8Dc19Zue/8XqF0br5QFp50g==

Hi,
I tested linux-next-20241101 with the Raspberry Pi 4 (8 GB RAM,
arm64/defconfig) and during boot the driver pcie_bwctrl fails to probe.
Since this driver is very new, I assume this never worked before:

[=C2=A0=C2=A0=C2=A0 6.843802] brcm-pcie fd500000.pcie: host bridge /scb/pc=
ie@7d500000
ranges:
[=C2=A0=C2=A0=C2=A0 6.843851] brcm-pcie fd500000.pcie:=C2=A0=C2=A0 No bus =
range found for
/scb/pcie@7d500000, using [bus 00-ff]
[=C2=A0=C2=A0=C2=A0 6.843900] brcm-pcie fd500000.pcie:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 MEM
0x0600000000..0x0603ffffff -> 0x00f8000000
[=C2=A0=C2=A0=C2=A0 6.843940] brcm-pcie fd500000.pcie:=C2=A0=C2=A0 IB MEM
0x0000000000..0x00bfffffff -> 0x0400000000
[=C2=A0=C2=A0=C2=A0 6.859915] vchiq: module is from the staging directory,=
 the quality
is unknown, you have been warned.
[=C2=A0=C2=A0=C2=A0 6.885670] brcm-pcie fd500000.pcie: PCI host bridge to =
bus 0000:00
[=C2=A0=C2=A0=C2=A0 6.885704] pci_bus 0000:00: root bus resource [bus 00-f=
f]
[=C2=A0=C2=A0=C2=A0 6.885725] pci_bus 0000:00: root bus resource [mem
0x600000000-0x603ffffff] (bus address [0xf8000000-0xfbffffff])
[=C2=A0=C2=A0=C2=A0 6.885823] pci 0000:00:00.0: [14e4:2711] type 01 class =
0x060400 PCIe
Root Port
[=C2=A0=C2=A0=C2=A0 6.885858] pci 0000:00:00.0: PCI bridge to [bus 01]
[=C2=A0=C2=A0=C2=A0 6.885876] pci 0000:00:00.0:=C2=A0=C2=A0 bridge window =
[mem
0x600000000-0x6000fffff]
[=C2=A0=C2=A0=C2=A0 6.885954] pci 0000:00:00.0: PME# supported from D0 D3h=
ot
[=C2=A0=C2=A0=C2=A0 6.909911] pci_bus 0000:01: supply vpcie3v3 not found, =
using dummy
regulator
[=C2=A0=C2=A0=C2=A0 6.910159] pci_bus 0000:01: supply vpcie3v3aux not foun=
d, using
dummy regulator
[=C2=A0=C2=A0=C2=A0 6.910251] pci_bus 0000:01: supply vpcie12v not found, =
using dummy
regulator
[=C2=A0=C2=A0=C2=A0 6.922254] mmc1: new high speed SDIO card at address 00=
01
[=C2=A0=C2=A0=C2=A0 7.013175] brcm-pcie fd500000.pcie: clkreq-mode set to =
default
[=C2=A0=C2=A0=C2=A0 7.015309] brcm-pcie fd500000.pcie: link up, 5.0 GT/s P=
CIe x1 (SSC)
[=C2=A0=C2=A0=C2=A0 7.015526] pci 0000:01:00.0: [1106:3483] type 00 class =
0x0c0330 PCIe
Endpoint
[=C2=A0=C2=A0=C2=A0 7.015626] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00=
000fff 64bit]
[=C2=A0=C2=A0=C2=A0 7.015954] pci 0000:01:00.0: PME# supported from D0 D3h=
ot
[=C2=A0=C2=A0=C2=A0 7.062153] pci 0000:00:00.0: bridge window [mem
0x600000000-0x6000fffff]: assigned
[=C2=A0=C2=A0=C2=A0 7.062191] pci 0000:01:00.0: BAR 0 [mem 0x600000000-0x6=
00000fff
64bit]: assigned
[=C2=A0=C2=A0=C2=A0 7.062221] pci 0000:00:00.0: PCI bridge to [bus 01]
[=C2=A0=C2=A0=C2=A0 7.062237] pci 0000:00:00.0:=C2=A0=C2=A0 bridge window =
[mem
0x600000000-0x6000fffff]
[=C2=A0=C2=A0=C2=A0 7.062255] pci_bus 0000:00: resource 4 [mem 0x600000000=
-0x603ffffff]
[=C2=A0=C2=A0=C2=A0 7.062269] pci_bus 0000:01: resource 1 [mem 0x600000000=
-0x6000fffff]
[=C2=A0=C2=A0=C2=A0 7.062590] pcieport 0000:00:00.0: enabling device (0000=
 -> 0002)
[=C2=A0=C2=A0=C2=A0 7.062812] pcieport 0000:00:00.0: PME: Signaling with I=
RQ 39
[=C2=A0=C2=A0=C2=A0 7.072890] pcieport 0000:00:00.0: AER: enabled with IRQ=
 39
[=C2=A0=C2=A0=C2=A0 7.091767] v3d fec00000.gpu: [drm] Using Transparent Hu=
gepages
[=C2=A0=C2=A0=C2=A0 7.124274] genirq: Flags mismatch irq 39. 00002084 (PCI=
e bwctrl) vs.
00200084 (PCIe PME)
[=C2=A0=C2=A0=C2=A0 7.124391] pcie_bwctrl 0000:00:00.0:pcie010: probe with=
 driver
pcie_bwctrl failed with error -16

