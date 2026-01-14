Return-Path: <linux-pci+bounces-44882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEFED21C7D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 00:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20032301D5D2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 23:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C2038F924;
	Wed, 14 Jan 2026 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/2LvUhN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DA355020
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768434045; cv=none; b=ZJTOtoLWFaTgtS6hCPrmn/apd1DiOEP+LWUVUGsGfCd5ouKMzXhIx1UQ1oRYKUfuvpYpJ8sktpjMjt55L/jDXxkLUTsKZOehY7lHetr3+vZP9gYcS1+9ahh0pJqwVPnlGocMaKvJp6VhDEM42Zi1verZxwfAwkGL4I028rdc824=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768434045; c=relaxed/simple;
	bh=P9Gx4LiPNtbiKnqgIr5HUbpOGCtt9tPpba1xJhHVHJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrNjOr5m0Br6TkBa8qWEDHbg+KWudIh6lXHgV2pjG5CgMhW6gycrWK2E/WpEcUVbz36yWK26gjzJNeKPd1FWLKwt4BbYeymLlCpkFvO0G3mapulhAZp/5bb1NJTfk5uT84EP2pO7pta7iyp707WQwGvzM6k9T+UgPafZ3rVfZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/2LvUhN; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6a0702b86so858585a.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 15:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768434033; x=1769038833; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3S719EZ/1lZmrlkn38vdBvBEKFntGcO3sbZ5YGzPc3Q=;
        b=M/2LvUhNX/yveKKG2dG4CtgXZHam2fgz5TBFM8Mj/S8cLp6p+4Ny1s4BuLivMX3N6a
         3w8v0PIjv4q6d0qiSfJpltjH5dF1JI+5Keh4lpSqTUfaj+78yTpLFVD7u8DaMeXt0GWn
         hi2BIgqkD8L0SqeUXNI+N3HbxkC8+JzLPPZ7YIUG58Q38Zh+pIrRT0/XBQf6e7UBBbyC
         PVA47DMZV+5+onrfErjfIo/HbHv1TwxQFrhp/aE+IdwU658tH/EGzxWtOhMUr0+MB9Gn
         9bGxv6ykKBCEgWcWlQacaLhwgb2v/nm31ldl5AejVcK+P6Z/k+mHtRFGrac5nl99f5zs
         Owkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768434033; x=1769038833;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S719EZ/1lZmrlkn38vdBvBEKFntGcO3sbZ5YGzPc3Q=;
        b=HTWoedfvtKDGrSZGw7Wa6Tx2/rez7dJVgxTZmYeVJepe9qPCxa3JU4f71HDnIHqPZR
         lyXu9yvkTeJ3f4ALZJ4ovwGw6EZ7f1ars5eITITurhm/0FkDA17nbGy/nbyaMcoQJciY
         XUV15JOQ3eJoiRODontsEGGr+Kp1rsafSdYSnDwCZz0BnoYagneFkRYgdQNp5B3mMNo+
         oQgOM+zRdwcmJEzbADw+NziHsMCEch8rHQvH0oUF4UiY+4eZxas3D9bb7EngmQiwYd/U
         VTQasKk2ZWv0hSWZ8B2uixFaEBYQFSkxI4ElEtdJQE0JjgGwiyBFFZiBoBhlKtrHAYi3
         slzw==
X-Gm-Message-State: AOJu0YwQZlLMGIvH/JCUylR/Jz6wnwZJuErT8h+BuKb5Ag2SxClZ/iMQ
	OJYfrN6zCsLUcArQrKYl8SbwgUkHaO/QhJEVhud+4hGZU3jmvRjkXafwzQNGyQ==
X-Gm-Gg: AY/fxX531oBqCZeWXZ6VA+8i80wOSOqJSrY9CbbWUICbSPMudI52xNx18dEd8aGVeiL
	P2oB8Znuzkqfhc4vi38b+ISxu8TFSq5DN6QF8LRPw8q1mi05AxysPfMKRi39lFZFcf4/xEfkNO2
	ULuNg3R9dJ1YraHw8318fSlXHkoTqqahjncgqiksMH2Ugl1M350BM4Am54Fdm6WfWyWbxt7N7o8
	ckYi2EBzz8Qufgk4o7TLcRsbsdWiOekSiKt1NGPRaeODFUuT8Z7iFT8UdK9EKuWTYy9C8jjMWuh
	4SYL4ftXMmJlXsPldKHFA2Q47M7Y+LBdgZFQkXsmrNRy92sivddssAF4jkJ9bkxkjWvD3RdoQpC
	04/82wUtbaGkIgkBqsXgDE02TIORiJ9mHykOev02BYtXQxOLm4P8UmJPZp/DM6e3+Ye7wKrw8aa
	Qq5kR3o45ggm+zrXPpGH0a1fYEHb83lOyJ4Y3PxjsBSfVyetdBMg==
X-Received: by 2002:a05:620a:4146:b0:8b2:e617:5aa4 with SMTP id af79cd13be357-8c5317f019cmr498595885a.44.1768434032702;
        Wed, 14 Jan 2026 15:40:32 -0800 (PST)
Received: from thinkpad (ip-74-215-254-164.dynamic.fuse.net. [74.215.254.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530be76d1sm267709685a.48.2026.01.14.15.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 15:40:32 -0800 (PST)
Date: Wed, 14 Jan 2026 18:40:30 -0500
From: Adam Stylinski <kungfujesus06@gmail.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Kernel regression in 6.13
Message-ID: <aWgpbG1I6a2VChM4@thinkpad>
References: <aUFlNgmLA5sI0FaJ@eggsbenedict>
 <3c61a43d-2a2f-0cd7-eafc-e34fb36f2274@linux.intel.com>
 <aUFreCbbgfb-5Wh1@eggsbenedict>
 <fcf1a483-8ef8-7450-2e9e-f82be527a49d@linux.intel.com>
 <aURK74sGvdTGBMdb@eggsbenedict>
 <3fd99997-a639-d971-e43e-bcc973aa6d04@linux.intel.com>
 <aUWG4H3GH-k2ebpa@eggsbenedict>
 <aVyBBOXXDEN8dses@thinkpad>
 <2c078897-3a1e-a016-1d93-237cfb71fb94@linux.intel.com>
 <aWgnZLSenkOiXiuM@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWgnZLSenkOiXiuM@thinkpad>
User-Agent: Mutt/2.2.16 (7b98015d) (2025-11-22)

On Wed, Jan 14, 2026 at 06:31:51PM -0500, Adam Stylinski wrote:
> On Tue, Jan 13, 2026 at 07:15:11PM +0200, Ilpo Järvinen wrote:
> > On Mon, 5 Jan 2026, Adam Stylinski wrote:
> > 
> > > On Fri, Dec 19, 2025 at 12:09:52PM -0500, Adam Stylinski wrote:
> > > > On Fri, Dec 19, 2025 at 05:28:09PM +0200, Ilpo Järvinen wrote:
> > > > > On Thu, 18 Dec 2025, Adam Stylinski wrote:
> > > > > 
> > > > > > On Thu, Dec 18, 2025 at 03:54:32PM +0200, Ilpo Järvinen wrote:
> > > > > > > On Tue, 16 Dec 2025, Adam Stylinski wrote:
> > > > > > > > On Tue, Dec 16, 2025 at 04:14:10PM +0200, Ilpo Järvinen wrote:
> > > > > > > > > On Tue, 16 Dec 2025, Adam Stylinski wrote:
> > > > > > > > > 
> > > > > > > > > > On Tue, Dec 16, 2025 at 11:49:45AM +0200, Ilpo Järvinen wrote:
> > > > > > > > > > > On Mon, 15 Dec 2025, Adam Stylinski wrote:
> > > > > > > > > > > 
> > > > > > > > > > > > Hello,
> > > > > > > > > > > > 
> > > > > > > > > > > > I seem to be encountering a regression that prevents my system from 
> > > > > > > > > > > > booting.  The regression occurred between 6.12 and 6.13.  I've bisected 
> > > > > > > > > > > > it to this commit:
> > > > > > > > > > > > 665745f274870c921020f610e2c99a3b1613519b
> > > > > > > > > > > > 
> > > > > > > > > > > > Some info about this system: it's ancient. It's a Q9650 that I used as a 
> > > > > > > > > > > > mythbackend/frontend for over a decade. This booting failure on newer 
> > > > > > > > > > > > kernels finally forced my hand to buy new a "new" PCI Express based 
> > > > > > > > > > > > tuner and upgrade the system into the modern age. It boots via MBR on a 
> > > > > > > > > > > > P45 based chipset (A P5Q Plus board, to be precise).  Given the age, I 
> > > > > > > > > > > > chalked the issue up to possibly some failing hardware or memory 
> > > > > > > > > > > > corruption that happened at compile time. I recently pulled the system 
> > > > > > > > > > > > back out again to do some performance testing in zlib-ng only to find 
> > > > > > > > > > > > out it hangs on the latest Ubuntu server ISO. I figured at this point it 
> > > > > > > > > > > > wasn't something specific to my kernel config / compilation and it's 
> > > > > > > > > > > > likely a regression. It's also old enough that I may be in the position 
> > > > > > > > > > > > of the only one having this problem, so I took it upon myself to bisect 
> > > > > > > > > > > > what was going on. Let me know if there's anything you'd like me to test 
> > > > > > > > > > > > or try.
> > > > > > > > > > > 
> > > > > > > > > > > Hi,
> > > > > > > > > > > 
> > > > > > > > > > > Thanks for the report.
> > > > > > > > > > > 
> > > > > > > > > > > In pcie_bwnotif_enable() there's pcie_capability_set_word() that enables
> > > > > > > > > > > bandwidth notifications:
> > > > > > > > > > > 
> > > > > > > > > > > 	        pcie_capability_set_word(port, PCI_EXP_LNKCTL,
> > > > > > > > > > >                                  PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> > > > > > > > > > > 
> > > > > > > > > > > So as the first step change those PCI_EXP_LNKCTL_LBMIE | 
> > > > > > > > > > > PCI_EXP_LNKCTL_LABIE into 0 to see if not enabling the bandwitdh 
> > > > > > > > > > > notification allows the system to come up.
> > > > > > > > > > > 
> > > > > > > > > > > I suggest not trying this directly at the top of 665745f27487 
> > > > > > > > > > > ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller") 
> > > > > > > > > > > but on a kernel that is expected to have fixes since 665745f27487 
> > > > > > > > > > > including those made to the other PCIe service drivers that share 
> > > > > > > > > > > interrupt handler with bwctrl (so basically some stable version).
> > > > > > > > > > > 
> > > > > > > > > > > If that works try to enable those bits one at a time.
> > > > > > > > > > > 
> > > > > > > > > > > Please also send lspci -vvv.
> > > > > > > > > > > 
> > > > > > > > > > > -- 
> > > > > > > > > > >  i.
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > I'll try changing those values atop of the 6.18 tagged commit and let you know how it goes.  Thanks for looking into this.
> > > > > > > > > > The privileged lspci -vv output is below:
> > > > > > > > > > 
> > > > > > > > > > 00:00.0 Host bridge: Intel Corporation 4 Series Chipset DRAM Controller (rev 03)
> > > > > > > > > > 	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> > > > > > > > > > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> > > > > > > > > > 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
> > > > > > > > > > 	Latency: 0
> > > > > > > > > > 	Capabilities: [e0] Vendor Specific Information: Intel <unknown>
> > > > > > > > > > 
> > > > > > > > > > 00:01.0 PCI bridge: Intel Corporation 4 Series Chipset PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
> > > > > > > > > > 	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> > > > > > > > > > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
> > > > > > > > > > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > > > > > > > > > 	Latency: 0, Cache Line Size: 32 bytes
> > > > > > > > > > 	Interrupt: pin A routed to IRQ 24
> > > > > > > > > > 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> > > > > > > > > > 	I/O behind bridge: c000-cfff [size=4K] [16-bit]
> > > > > > > > > > 	Memory behind bridge: fd000000-fe9fffff [size=26M] [32-bit]
> > > > > > > > > > 	Prefetchable memory behind bridge: c0000000-dfffffff [size=512M] [32-bit]
> > > > > > > > > > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> > > > > > > > > > 	BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
> > > > > > > > > > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > > > > > > > > > 	Capabilities: [88] Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> > > > > > > > > > 	Capabilities: [80] Power Management version 3
> > > > > > > > > > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > > > > > > > > > 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > > > > > > > > > 	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > > > > > > > > 		Address: fee02000  Data: 0020
> > > > > > > > > > 	Capabilities: [a0] Express (v2) Root Port (Slot+), IntMsgNum 0
> > > > > > > > > > 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> > > > > > > > > > 			ExtTag- RBE+ TEE-IO-
> > > > > > > > > > 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > > > > > > > > > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > > > > > > > > > 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> > > > > > > > > > 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> > > > > > > > > > 		LnkCap:	Port #2, Speed 5GT/s, Width x16, ASPM L0s, Exit Latency L0s <256ns
> > > > > > > > > > 			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
> > > > > > > > > > 		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
> > > > > > > > > > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
> > > > > > > > > > 		LnkSta:	Speed 2.5GT/s, Width x16
> > > > > > > > > > 			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt+
> > > > > > > > > 
> > > > > > > > > At least this Root Port has both BWMgmt and ABWMgmt asserted (not a 
> > > > > > > > > problem in itself, necessarily).
> > > > > > > > > 
> > > > > > > > > If you get the system working by changing that set_word call, it's worth 
> > > > > > > > > to check if these got reasserted (bwctrl tries to clear them right after 
> > > > > > > > > the set word call but it could be they get reasserted).
> > > > > > > > > 
> > > > > > > > > -- 
> > > > > > > > >  i.
> > > > > > > > 
> > > > > > > > Yes, I was able to boot after forcing those flags to zero.  Here's lspci -vvv after booting into 6.18:
> > > > > > > > 
> > > > > > > > 00:00.0 Host bridge: Intel Corporation 4 Series Chipset DRAM Controller (rev 03)
> > > > > > > > 	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> > > > > > > > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> > > > > > > > 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
> > > > > > > > 	Latency: 0
> > > > > > > > 	Capabilities: [e0] Vendor Specific Information: Intel <unknown>
> > > > > > > > lspci: Unable to load libkmod resources: error -2
> > > > > > > > 
> > > > > > > > 00:01.0 PCI bridge: Intel Corporation 4 Series Chipset PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
> > > > > > > > 	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> > > > > > > > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
> > > > > > > > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > > > > > > > 	Latency: 0, Cache Line Size: 32 bytes
> > > > > > > > 	Interrupt: pin A routed to IRQ 24
> > > > > > > > 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> > > > > > > > 	I/O behind bridge: c000-cfff [size=4K] [16-bit]
> > > > > > > > 	Memory behind bridge: fd000000-fe9fffff [size=26M] [32-bit]
> > > > > > > > 	Prefetchable memory behind bridge: c0000000-dfffffff [size=512M] [32-bit]
> > > > > > > > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> > > > > > > > 	BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
> > > > > > > > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > > > > > > > 	Capabilities: [88] Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> > > > > > > > 	Capabilities: [80] Power Management version 3
> > > > > > > > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > > > > > > > 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > > > > > > > 	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > > > > > > 		Address: fee02000  Data: 0020
> > > > > > > > 	Capabilities: [a0] Express (v2) Root Port (Slot+), IntMsgNum 0
> > > > > > > > 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> > > > > > > > 			ExtTag- RBE+ TEE-IO-
> > > > > > > > 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > > > > > > > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > > > > > > > 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> > > > > > > > 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> > > > > > > > 		LnkCap:	Port #2, Speed 5GT/s, Width x16, ASPM L0s, Exit Latency L0s <256ns
> > > > > > > > 			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
> > > > > > > > 		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
> > > > > > > > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
> > > > > > > > 		LnkSta:	Speed 2.5GT/s, Width x16
> > > > > > > > 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> > > > > > > > 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> > > > > > > > 			Slot #0, PowerLimit 75W; Interlock- NoCompl-
> > > > > > > > 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> > > > > > > > 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> > > > > > > > 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> > > > > > > > 			Changed: MRL- PresDet+ LinkState-
> > > > > > > > 		RootCap: CRSVisible-
> > > > > > > > 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> > > > > > > > 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> > > > > > > > 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
> > > > > > > > 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
> > > > > > > > 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> > > > > > > > 			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
> > > > > > > > 			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> > > > > > > > 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
> > > > > > > > 			 AtomicOpsCtl: ReqEn- EgressBlck-
> > > > > > > > 			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
> > > > > > > > 			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> > > > > > > > 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> > > > > > > > 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> > > > > > > > 			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> > > > > > > > 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
> > > > > > > > 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
> > > > > > > > 			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
> > > > > > > > 	Capabilities: [100 v1] Virtual Channel
> > > > > > > > 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
> > > > > > > > 		Arb:	Fixed- WRR32- WRR64- WRR128-
> > > > > > > > 		Ctrl:	ArbSelect=Fixed
> > > > > > > > 		Status:	InProgress-
> > > > > > > > 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> > > > > > > > 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > > > > > > > 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
> > > > > > > > 			Status:	NegoPending- InProgress-
> > > > > > > > 	Capabilities: [140 v1] Root Complex Link
> > > > > > > > 		Desc:	PortNumber=02 ComponentID=01 EltType=Config
> > > > > > > > 		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- LinkType=MemMapped LinkValid+
> > > > > > > > 			Addr:	00000000fed19000
> > > > > > > > 	Kernel driver in use: pcieport
> > > > > > > 
> > > > > > > Hi.
> > > > > > > 
> > > > > > > Here's a quirk patch to disable bwctrl on this Root Port, assuming I 
> > > > > > > guessed the PCI device ID for it right, please check it matches to 00:01.0 
> > > > > > > (I should have asked lspci with -n to see the raw number but you can 
> > > > > > > easily correct it yourself too before compiling the kernel).
> > > > > > > 
> > > > > > > From 1e13651f8789fb9df060269a7b7c396211d910f8 Mon Sep 17 00:00:00 2001
> > > > > > > From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
> > > > > > > Date: Thu, 18 Dec 2025 15:45:25 +0200
> > > > > > > Subject: [PATCH 1/1] PCI/bwctrl: Disable BW controller on Intel P45 using a quirk
> > > > > > > MIME-Version: 1.0
> > > > > > > Content-Type: text/plain; charset=UTF-8
> > > > > > > Content-Transfer-Encoding: 8bit
> > > > > > > 
> > > > > > > The commit 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as
> > > > > > > PCIe BW controller") was found to lead to a boot hang on a Intel P45
> > > > > > > system. Testing without setting Link Bandwidth Management Interrupt
> > > > > > > Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable (LABIE)
> > > > > > > (PCIe r7.0, sec. 7.5.3.7) in bwctrl allowed system to come up.
> > > > > > > 
> > > > > > > Add no_bw_notif into the struct pci_dev and quirk Intel P45 Root Port
> > > > > > > with it.
> > > > > > > 
> > > > > > > Reported-by: Adam Stylinski <kungfujesus06@gmail.com>
> > > > > > > Link: https://lore.kernel.org/linux-pci/aUCt1tHhm_-XIVvi@eggsbenedict/
> > > > > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > > > > ---
> > > > > > >  drivers/pci/pcie/bwctrl.c |  3 +++
> > > > > > >  drivers/pci/quirks.c      | 10 ++++++++++
> > > > > > >  include/linux/pci.h       |  1 +
> > > > > > >  3 files changed, 14 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> > > > > > > index 36f939f23d34..4ae92c9f912a 100644
> > > > > > > --- a/drivers/pci/pcie/bwctrl.c
> > > > > > > +++ b/drivers/pci/pcie/bwctrl.c
> > > > > > > @@ -250,6 +250,9 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
> > > > > > >  	struct pci_dev *port = srv->port;
> > > > > > >  	int ret;
> > > > > > >  
> > > > > > > +	if (port->no_bw_notif)
> > > > > > > +		return -ENODEV;
> > > > > > > +
> > > > > > >  	/* Can happen if we run out of bus numbers during enumeration. */
> > > > > > >  	if (!port->subordinate)
> > > > > > >  		return -ENODEV;
> > > > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > > > index b9c252aa6fe0..6ef42a2c4831 100644
> > > > > > > --- a/drivers/pci/quirks.c
> > > > > > > +++ b/drivers/pci/quirks.c
> > > > > > > @@ -1359,6 +1359,16 @@ static void quirk_transparent_bridge(struct pci_dev *dev)
> > > > > > >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge);
> > > > > > >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA,	0x605,	quirk_transparent_bridge);
> > > > > > >  
> > > > > > > +/*
> > > > > > > + * Enabling Link Bandwidth Management Interrupts (BW notifications) can cause
> > > > > > > + * boot hangs on P45.
> > > > > > > + */
> > > > > > > +static void quirk_p45_bw_notifications(struct pci_dev *dev)
> > > > > > > +{
> > > > > > > +	dev->no_bw_notif = 1;
> > > > > > > +}
> > > > > > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e21, quirk_p45_bw_notifications);
> > > > > > > +
> > > > > > >  /*
> > > > > > >   * Common misconfiguration of the MediaGX/Geode PCI master that will reduce
> > > > > > >   * PCI bandwidth from 70MB/s to 25MB/s.  See the GXM/GXLV/GX1 datasheets
> > > > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > > > > index 864775651c6f..3a556cd749e3 100644
> > > > > > > --- a/include/linux/pci.h
> > > > > > > +++ b/include/linux/pci.h
> > > > > > > @@ -406,6 +406,7 @@ struct pci_dev {
> > > > > > >  						      user sysfs */
> > > > > > >  	unsigned int	clear_retrain_link:1;	/* Need to clear Retrain Link
> > > > > > >  						   bit manually */
> > > > > > > +	unsigned int	no_bw_notif:1;	/* BW notifications may cause issues */
> > > > > > >  	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
> > > > > > >  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
> > > > > > >  
> > > > > > > 
> > > > > > > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > > > > > > -- 
> > > > > > > 2.39.5
> > > > > > 
> > > > > > You are correct on the ID, however I'm having some issues applying that 
> > > > > > patch.  The pcie_bwnotif_probe functions do no return in 6.18, 6.13, or 
> > > > > > even on master.
> > > > > 
> > > > > I didn't get what you meant with that "no return" description.
> > > > > 
> > > > > > Am I missing a patch or maybe you did that on top of a 
> > > > > > WIP branch?  
> > > > > 
> > > > > The patch is made on top of 6.19-rc1. I don't see what would prevent 
> > > > > applying it to 6.18 (in fact, I just tried and it applied cleanly on top
> > > > > of 6.18.2). Maybe it got corrupted somehow while you were saving the patch 
> > > > > from email.
> > > > > 
> > > > > I've attached a "backport" made on top of 6.18.2, it shouldn't get as 
> > > > > easily corrupted while saving.
> > > > > 
> > > > > -- 
> > > > >  i.
> > > > 
> > > > > From 17d1513a976d94d55dbeb497ac679db9182f7cb4 Mon Sep 17 00:00:00 2001
> > > > > From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
> > > > > Date: Thu, 18 Dec 2025 15:45:25 +0200
> > > > > Subject: [PATCH 1/1] PCI/bwctrl: Disable BW controller on Intel P45 using a
> > > > >  quirk
> > > > > MIME-Version: 1.0
> > > > > Content-Type: text/plain; charset=UTF-8
> > > > > Content-Transfer-Encoding: 8bit
> > > > > 
> > > > > The commit 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as
> > > > > PCIe BW controller") was found to lead to a boot hang on a Intel P45
> > > > > system. Testing without setting Link Bandwidth Management Interrupt
> > > > > Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable (LABIE)
> > > > > (PCIe r7.0, sec. 7.5.3.7) in bwctrl allowed system to come up.
> > > > > 
> > > > > Add no_bw_notif into the struct pci_dev and quirk Intel P45 Root Port
> > > > > with it.
> > > > > 
> > > > > Reported-by: Adam Stylinski <kungfujesus06@gmail.com>
> > > > > Link: https://lore.kernel.org/linux-pci/aUCt1tHhm_-XIVvi@eggsbenedict/
> > > > > Signed-off-by: Ilpo J??rvinen <ilpo.jarvinen@linux.intel.com>
> > > > > ---
> > > > >  drivers/pci/pcie/bwctrl.c |  3 +++
> > > > >  drivers/pci/quirks.c      | 10 ++++++++++
> > > > >  include/linux/pci.h       |  1 +
> > > > >  3 files changed, 14 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> > > > > index 36f939f23d34..4ae92c9f912a 100644
> > > > > --- a/drivers/pci/pcie/bwctrl.c
> > > > > +++ b/drivers/pci/pcie/bwctrl.c
> > > > > @@ -250,6 +250,9 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
> > > > >  	struct pci_dev *port = srv->port;
> > > > >  	int ret;
> > > > >  
> > > > > +	if (port->no_bw_notif)
> > > > > +		return -ENODEV;
> > > > > +
> > > > >  	/* Can happen if we run out of bus numbers during enumeration. */
> > > > >  	if (!port->subordinate)
> > > > >  		return -ENODEV;
> > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > index b9c252aa6fe0..6ef42a2c4831 100644
> > > > > --- a/drivers/pci/quirks.c
> > > > > +++ b/drivers/pci/quirks.c
> > > > > @@ -1359,6 +1359,16 @@ static void quirk_transparent_bridge(struct pci_dev *dev)
> > > > >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge);
> > > > >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA,	0x605,	quirk_transparent_bridge);
> > > > >  
> > > > > +/*
> > > > > + * Enabling Link Bandwidth Management Interrupts (BW notifications) can cause
> > > > > + * boot hangs on P45.
> > > > > + */
> > > > > +static void quirk_p45_bw_notifications(struct pci_dev *dev)
> > > > > +{
> > > > > +	dev->no_bw_notif = 1;
> > > > > +}
> > > > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e21, quirk_p45_bw_notifications);
> > > > > +
> > > > >  /*
> > > > >   * Common misconfiguration of the MediaGX/Geode PCI master that will reduce
> > > > >   * PCI bandwidth from 70MB/s to 25MB/s.  See the GXM/GXLV/GX1 datasheets
> > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > > index bf97d49c23cf..05aeee8c8844 100644
> > > > > --- a/include/linux/pci.h
> > > > > +++ b/include/linux/pci.h
> > > > > @@ -406,6 +406,7 @@ struct pci_dev {
> > > > >  						      user sysfs */
> > > > >  	unsigned int	clear_retrain_link:1;	/* Need to clear Retrain Link
> > > > >  						   bit manually */
> > > > > +	unsigned int	no_bw_notif:1;	/* BW notifications may cause issues */
> > > > >  	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
> > > > >  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
> > > > >  
> > > > > 
> > > > > base-commit: 78d82960b939df64cf7d26ca5ed34eb87f44c9e5
> > > > > -- 
> > > > > 2.39.5
> > > > > 
> > > > 
> > > > Yes, that patch applied cleanly.  Looking back, I must have attempted to patch the wrong function by hand somehow, because that function does indeed return an integer.  Sorry for the confusion - that fix definitely works.
> > > > 
> > > 
> > > Is there anything else you'd like me to test with this?  I realize this 
> > > is low priority and probably fell off your radar but it'd be nice to not 
> > > have to remember to manually patch this each kernel bump. just let me 
> > > know.
> > 
> > Hi,
> > 
> > Thanks for testing.
> > 
> > Do you want to give your Tested-by tag for this? If yes, please post that 
> > into that public thread. I'll then include it into the real submission of 
> > the patch for inclusion (please note that if you give a tag, it will 
> > become a public record in the kernel's git history).
> > 
> > -- 
> >  i.
> 
> Sure thing.
> Tested-by: Adam Stylinski <kungfujesus06@gmail.com>
CC'ing list

