Return-Path: <linux-pci+bounces-20030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F40A14A0D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 08:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B223A4799
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46D91F7586;
	Fri, 17 Jan 2025 07:20:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailproxy01.manitu.net (mailproxy01.manitu.net [217.11.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5B22619
	for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098412; cv=none; b=NoXT+gnfP35IAEuBTVvmuarm/P9i7Fcelmg3UPVT3i0/Xqmr35BI6mgnKXNK+TJHeMVpXxnCm29M0wZlNe7gOMj4ovweOTkB1juUhataVY33mxzvGuYzI4g1ONIfnUzhewD34ZesZ7chU8yXnETTq77Qg99OrkGK4bO/PwNkmm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098412; c=relaxed/simple;
	bh=dPmrakCeozE0ryUZncHOhA07D6ydvd4OH7duHGDHXos=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=GF9dFyLf5O6Dx3V0bc+pIG16dICRla85EwiFzGf7xAzMYELO1WeaWhjmEhNSCwL9pxoaBTHDlefr96KtxNKG7G6cR/6UBDECVCIGKZ3ev3S6XaGOZzdPlYKicndMKzxAlgrB8xcfoP8y8/LWfvqy2kfWDnoGfxZ43NlOc8OJyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mehrfeuer.de; spf=pass smtp.mailfrom=mehrfeuer.de; arc=none smtp.client-ip=217.11.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mehrfeuer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mehrfeuer.de
From: Dennis Thase <dennis@mehrfeuer.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.9\))
Subject: nointxmask RME audio pcie devices
Message-Id: <7CF56E21-ACC5-48D2-AD6C-8FBE8916DAF3@mehrfeuer.de>
Date: Fri, 17 Jan 2025 08:14:16 +0100
To: linux-pci@vger.kernel.org

Greetings,
i try to use two different pcie audio devices manufactured by RME on =
proxmox ve with vfio. They only work fine with nointxmask option. =
Otherwise there are hearable audio gaps. The disadvantage is that i =
cannot passthrough any other device to another vm in pve because the =
intx device is busy with nointxmask enabled. I attached the lspci of =
both RME devices.
Thanks for support.
Regards,
Dennis

07:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall =
DSP MADI (rev d2)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 19
        IOMMU group: 22
        Region 0: Memory at 81a00000 (32-bit, non-prefetchable) =
[size=3D64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 =
PME-
        Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s =
<64ns, L1 <1us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- =
SlotPowerLimit 10W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- =
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit =
Latency L0s <4us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1
                        TrErr- Train- SlotClk- DLActive- BWMgmt- =
ABWMgmt-
        Capabilities: [100 v1] Device Serial Number =
00-00-00-01-01-00-0a-35
        Kernel driver in use: vfio-pci
        Kernel modules: snd_hdspm
00: ee 10 c6 3f 06 00 10 00 d2 00 01 04 10 00 00 00
10: 00 00 a0 81 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
40: 01 48 03 00 08 20 00 1e 05 58 80 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 10 00 01 00 20 80 90 05
60: 10 29 00 00 11 64 03 00 00 00 11 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



09:00.0 Multimedia audio controller: Xilinx Corporation Device 3fc7 (rev =
d5)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16
        IOMMU group: 24
        Region 0: Memory at 81900000 (32-bit, non-prefetchable) =
[size=3D128K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 =
PME-
        Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s =
<64ns, L1 <1us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- =
SlotPowerLimit 25W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- =
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit =
Latency L0s unlimited
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1
                        TrErr- Train- SlotClk- DLActive- BWMgmt- =
ABWMgmt-
        Kernel driver in use: vfio-pci
00: ee 10 c7 3f 06 00 10 00 d5 00 01 04 10 00 00 00
10: 00 00 90 81 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
40: 01 48 03 70 08 20 00 1e 05 58 80 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 10 00 01 00 20 80 e8 07
60: 10 29 00 00 11 f4 03 00 00 00 11 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=

