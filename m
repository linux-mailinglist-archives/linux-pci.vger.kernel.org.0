Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312D92C82A1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 11:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgK3KvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 05:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgK3KtS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 05:49:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E40C0613D2;
        Mon, 30 Nov 2020 02:48:38 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606733316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyDTMLyFsHvgk6tCq0IoBNcW7U3alEedaxXe+RbbUq4=;
        b=fVjb+sI3P+i4FMtiFgaH4kBUcZykYJ80ngiffhNwWNhq+qluo4tp+kSwimYyvZanBlxolq
        9/71ZkN2Cm4o1IHmBn33RiEX2839V5XM9vpDE7rnKRmt9EFieEy7LfB19s+RqzNK6DoiUT
        wXkOKRSayYYiodnkgkQRbNoXg1Yyr2XW7Sb4tClseE3TMw7u28e32E0/UKYejx+Qdm0gPv
        3y/K/UBpaojU7/htz89T0mOvfxoEfcpdPPVEYIsqbi71DwU6Or0MQhSN4Bi6tkOhhhUySJ
        B4i8iRBcyEpTyYdxG/Pf+nEEF4V3dIprnQm4NWuoWVmnkR0tn/yVubUTG1/3eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606733316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyDTMLyFsHvgk6tCq0IoBNcW7U3alEedaxXe+RbbUq4=;
        b=w97QXJmyaQ8pnsP9h56uYRKUisYSGBgxmHiACJyaNA900behOAvaCqEQAbPywQAtk6p68V
        pxrsKWrMhyMGKKBw==
To:     Stefan =?utf-8?Q?B=C3=BChler?= 
        <stefan.buehler@tik.uni-stuttgart.de>,
        sean.v.kelley@linux.intel.com
Cc:     bhelgaas@google.com, bp@alien8.de, corbet@lwn.net,
        kar.hin.ong@ni.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mingo@redhat.com, sassmann@kpanic.de, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: boot interrupt quirk (also in 4.19.y) breaks serial ports (was: [PATCH v2 0/2] pci: Add boot interrupt quirk mechanism for Xeon chipsets)
In-Reply-To: <7b54abab-fe38-4035-7c23-1f7456359c9e@tik.uni-stuttgart.de>
References: <20200220192930.64820-1-sean.v.kelley@linux.intel.com> <b2da25c8-121a-b241-c028-68e49bab0081@tik.uni-stuttgart.de> <87zh35k5xa.fsf@nanos.tec.linutronix.de> <d512469f-de04-2f66-ca42-21ec3c5331ba@tik.uni-stuttgart.de> <87blfjk7go.fsf@nanos.tec.linutronix.de> <7b54abab-fe38-4035-7c23-1f7456359c9e@tik.uni-stuttgart.de>
Date:   Mon, 30 Nov 2020 11:48:36 +0100
Message-ID: <87r1obi0hn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Stefan,

On Fri, Nov 27 2020 at 10:17, Stefan B=C3=BChler wrote:
> On 11/27/20 12:45 AM, Thomas Gleixner wrote:
>> Can you please run this as root so the Capabilities are accessible?
>
> My bad, sorry. I did intend to run it as root, but should have checked
> the output.  Again see attached file.

No problem.

> 05:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-P=
CI Bridge (rev aa) (prog-if 00 [Normal decode])
> 	Physical Slot: 1
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 32 bytes
> 	Interrupt: pin A routed to IRQ 16
> 	NUMA node: 0
> 	Bus: primary=3D05, secondary=3D06, subordinate=3D06, sec-latency=3D64
> 	I/O behind bridge: 0000e000-0000efff
> 	Memory behind bridge: fb400000-fb4fffff
> 	Prefetchable memory behind bridge: fff00000-000fffff
> 	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000

So the bridge would support MSI, but obviously the devices on the PCI
side do not.

> 06:00.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad 1695=
0 UART) function 0 (Uart) (prog-if 06 [16950])
> 	Subsystem: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) functio=
n 0 (Uart)
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin A routed to IRQ 16
> 	NUMA node: 0
> 	Region 0: I/O ports at e0e0 [size=3D32]
> 	Region 1: Memory at fb407000 (32-bit, non-prefetchable) [size=3D4K]
> 	Region 2: I/O ports at e0c0 [size=3D32]
> 	Region 3: Memory at fb406000 (32-bit, non-prefetchable) [size=3D4K]
> 	Capabilities: [40] Power Management version 1
> 		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=3D0mA PME(D0+,D1-,D2+,D3hot+,D3c=
old-)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-

But that should still work because the boot interrupt quirk should not
affect interrupts which are routed through the IOAPIC.

Sean, any idea what's going on here?

Thanks,

        tglx
