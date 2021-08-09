Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3BD3E416A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhHIIOW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 04:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhHIIOV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 04:14:21 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72BAC0613CF
        for <linux-pci@vger.kernel.org>; Mon,  9 Aug 2021 01:14:00 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id z128so27907578ybc.10
        for <linux-pci@vger.kernel.org>; Mon, 09 Aug 2021 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OT124kYnclJ0iFL63DrQTb9pQwpj7PGYGA+YdeaWDnI=;
        b=qu9UAqo87ZceCpWgjYIvjHI/TqkyT+Mpz7k5MLVxofN+Qd9u4D+tPx7h0OMmRWiTK2
         kHoIm2Vwq6ahIX0temQBZqtHEvqAb6Usoafb68rjVifRF3mh2WQXH4h811Hw5BfdJXoi
         PC+zH5kXs3cS/adGwuD+Gm2si3dtA86wIKnewvYkNMFf+vwLFy2XnhWxqqIgCFNZuykb
         9tjZgkJEUgVUvy1jOiCDOg/t9o+oln5JS88FLmZwi+6OkryUVVKvmP7UPiborJdbYEcv
         psqZozwgGtQMqn4n2rb94fzsZ0iiCGxGIIv5WK+9ui+OGRZoe6nfmTok4tLmuaCBWDHS
         hduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OT124kYnclJ0iFL63DrQTb9pQwpj7PGYGA+YdeaWDnI=;
        b=Mr5joujGEA85oj0FpWovu+WH/bOESkNcJBSM601znznfyrZ4Xajl6Ecmxp8xi6Ooo0
         RRgtj+83mKfFKeNnMFgXcOnZEzbLyuHg/XuIejdqZ/4sRSEMJsw+mUMGtjF3PWcB9wnZ
         tBNcCZcVo8yOl1meHrg4bjndu+vIbH2Yxy0e/BD41eDcK1ZJSV5whk1O67J8/vRwrG4y
         E6N1JlVWWUykJeibvAviwCrXhRAIM8j7dl/JZSkFTHVsI0CRrZwd2ZodOfw2xG5Z6S/Q
         aAYwqG51ylW5U7NfrHyfUWptwuTsw+ffaHIvUtyGE1ILFHvhTrHFPsBuonZnSLyyPugx
         Inhg==
X-Gm-Message-State: AOAM532Y9XidubkmkDgIXDL6heb7r28w9x7jyGeFKzbFpy056SvT9SVC
        afM2dhnQgI3vDIfaX/zw9qxH2iY/MIvUwfLIvY2owoGJLAB73w==
X-Google-Smtp-Source: ABdhPJzLmYOifo7YfyEN6mslK/g4xUkaNBxqjHDmLlO+amGatokT0+tKx5NhmJjBHH1q600M070PeonFh1IjhU4u5NQ=
X-Received: by 2002:a25:814f:: with SMTP id j15mr28970224ybm.358.1628496839694;
 Mon, 09 Aug 2021 01:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHn-FMxN4QySUfJ=Pxkm23Pm6hgt8hAoCAQczCpqs=TpygR6Ow@mail.gmail.com>
In-Reply-To: <CAHn-FMxN4QySUfJ=Pxkm23Pm6hgt8hAoCAQczCpqs=TpygR6Ow@mail.gmail.com>
From:   Manish Raturi <raturi.manish@gmail.com>
Date:   Mon, 9 Aug 2021 13:43:47 +0530
Message-ID: <CAHn-FMxkBbPLN95dsRsm+ZSipMyW0YkmJ=upBB6RJHTyK0GBHg@mail.gmail.com>
Subject: Re: Link is not coming up in Gen4 between Intel CPU and PEX switch
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 5, 2021 at 10:37 AM Manish Raturi <raturi.manish@gmail.com> wrote:
>
> Hi All,
>
> I am facing an issue where CPU PCIE root port has x16 lanes and is
> bifurcated in x4,x4,x8 , On x8 bifurcated port we have PEX switch at
> downstream port connected in x4 mode. Also I have enabled the hotplug
> on CPU PCIE root port, so that PEX switch can be taken out of reset in
> the kernel and link training happens in the kernel. I am observing the
> below behaviour:
>
> 1)   In the kernel whenever we enumerate this PEX switch the link
> never comes in GEN 4 it sometimes comes in GEN3 and sometimes in GEN2
> as well.
>
> 2) If I disable the link between CPU and PEX and retrain the link then
> also the link comes in Gen3 or Gen2.
>
> 3) One experiment where I see GEN 4 coming is when the PEX switch is
> out of reset in kernel and we do a reboot and as the switch is out of
> reset , the BIOS enumerates it and we are able to see a link coming up
> in GEN 4 in the BIOS.
>
> 4) Whenever we enumerate the PEX switch in the kernel we don't see a
> link coming up in GEN4 in the kernel.
>
> 5) Kernel version we are using is 5.2.
>
> Queries:
>
> 1) What are the parameters which can be checked for GEN4 links not coming up.
> 2) Does ASPM play any role in bringing the link down to lesser speed ?
> 3) Please suggest what else I can check in software ?
>
> Logs when the PEX switch comes up fine in GEN4 in BIOS:
> ==============================================
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
> Stepping- SERR+ FastB2B- DisINTx+
>
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>
> Latency: 0, Cache Line Size: 64 bytes
>
> Interrupt: pin A routed to IRQ 36
>
> NUMA node: 0
>
> Region 0: Memory at 21fc0000000 (64-bit, non-prefetchable) [size=128K]
>
> Bus: primary=14, secondary=30, subordinate=c5, sec-latency=0
>
> I/O behind bridge: 0000f000-00000fff [empty]
>
> Memory behind bridge: c0000000-cfffffff [size=256M]
>
> Prefetchable memory behind bridge: 0000021f80000000-0000021fbfffffff [size=1G]
>
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>
> BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>
> DevCap: MaxPayload 512 bytes, PhantFunc 0
>
> ExtTag+ RBE+
>
> DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>
> RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
>
> MaxPayload 512 bytes, MaxReadReq 4096 bytes
>
> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
>
> LnkCap: Port #3, Speed 16GT/s, Width x8, ASPM L1, Exit Latency L1 <16us
>
> ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
>
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk-
>
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>
> LnkSta: Speed 16GT/s (ok), Width x4 (downgraded)
>
> TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>
> Slot #83, PowerLimit 75.000W; Interlock- NoCompl-
>
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
>
> Control: AttnInd Off, PwrInd Off, Power- Interlock-
>
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>
> Changed: MRL- PresDet- LinkState-
>
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
>
> RootCap: CRSVisible+
>
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR-, OBFF Not
> Supported ARIFwd+
>
> AtomicOpsCap: Routing+ 32bit+ 64bit+ 128bitCAS+
>
> DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-, LTR-, OBFF
> Disabled ARIFwd-
>
> AtomicOpsCtl: ReqEn+ EgressBlck-
>
> LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
>
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>
> Compliance De-emphasis: -6dB
>
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+,
> EqualizationPhase1+
>
> EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
>
> Capabilities: [80] Power Management version 3
>
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>
> Capabilities: [88] Subsystem: Intel Corporation Device 347c
>
> Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>
> Address: fee00058  Data: 0000
>
> Capabilities: [100 v1] Advanced Error Reporting
>
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>
> UEMsk: DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq+ ACSViol-
>
> UESvrt: DLP+ SDES- TLP+ FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>
> AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>
> MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap+
>
> HeaderLog: 4a000001 33000004 fd000000 00000000
>
> RootCmd: CERptEn+ NFERptEn+ FERptEn+
>
> RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>
> FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>
> ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>
> Capabilities: [148 v1] Access Control Services
>
> ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
>
> ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
>
> Capabilities: [180 v1] Vendor Specific Information: ID=0003 Rev=0 Len=00a <?>
>
> Capabilities: [190 v1] Downstream Port Containment
>
> DpcCap: INT Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
>
> DpcCtl: Trigger:1 Cmpl- INT+ ErrCor- PoisonedTLP- SwTrigger- DL_ActiveErr-
>
> DpcSta: Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO ErrPtr:1f
>
> Source: 0000
>
> Capabilities: [1e0 v2] Precision Time Measurement
>
> PTMCap: Requester:- Responder:+ Root:+
>
> PTMClockGranularity: 2ns
>
> PTMControl: Enabled:+ RootSelected:+
>
> PTMEffectiveGranularity: 2ns
>
> Capabilities: [200 v1] Secondary PCI Express <?>
>
> Capabilities: [400 v1] Data Link Feature <?>
>
> Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
>
> Capabilities: [450 v1] Lane Margining at the Receiver <?>
>
> Kernel driver in use: pcieport
>
> Failing Logs
> ==========
>
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
> Stepping- SERR+ FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 36
> NUMA node: 0
> Region 0: Memory at 21fc0000000 (64-bit, non-prefetchable) [size=128K]
> Bus: primary=14, secondary=30, subordinate=c5, sec-latency=0
> I/O behind bridge: 0000f000-00000fff [empty]
> Memory behind bridge: fff00000-000fffff [empty]
> Prefetchable memory behind bridge: 0000021f80000000-0000021fbfffffff [size=1G]
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 512 bytes, PhantFunc 0
> ExtTag+ RBE+
> DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 4096 bytes
> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> LnkCap: Port #3, Speed 16GT/s, Width x8, ASPM L1, Exit Latency L1 <64us
> ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 8GT/s (downgraded), Width x4 (downgraded)
> TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
> Slot #83, PowerLimit 75.000W; Interlock- NoCompl-
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
> Control: AttnInd Off, PwrInd Off, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
> RootCap: CRSVisible+
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR-, OBFF Not
> Supported ARIFwd+
> AtomicOpsCap: Routing+ 32bit+ 64bit+ 128bitCAS+
> DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-, LTR-, OBFF
> Disabled ARIFwd-
> AtomicOpsCtl: ReqEn+ EgressBlck-
> LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+,
> EqualizationPhase1+
> EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest+
> Capabilities: [80] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [88] Subsystem: Intel Corporation Device 347c
> Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> Address: fee00058  Data: 0000
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq+ ACSViol-
> UESvrt: DLP+ SDES- TLP+ FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap+
> HeaderLog: 4a000001 33000004 fd000000 00000000
> RootCmd: CERptEn+ NFERptEn+ FERptEn+
> RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
> FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
> ErrorSrc: ERR_COR: 1420 ERR_FATAL/NONFATAL: 0000
> Capabilities: [148 v1] Access Control Services
> ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
> ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
> EgressCtrl- DirectTrans-
> Capabilities: [180 v1] Vendor Specific Information: ID=0003 Rev=0 Len=00a <?>
> Capabilities: [190 v1] Downstream Port Containment
> DpcCap: INT Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
> DpcCtl: Trigger:1 Cmpl- INT+ ErrCor- PoisonedTLP- SwTrigger- DL_ActiveErr-
> DpcSta: Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO ErrPtr:1f
> Source: 0000
> Capabilities: [1e0 v2] Precision Time Measurement
> PTMCap: Requester:- Responder:+ Root:+
> PTMClockGranularity: 2ns
> PTMControl: Enabled:+ RootSelected:+
> PTMEffectiveGranularity: 2ns
> Capabilities: [200 v1] Secondary PCI Express <?>
> Capabilities: [400 v1] Data Link Feature <?>
> Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
> Capabilities: [450 v1] Lane Margining at the Receiver <?>
> Kernel driver in use: pcieport
>
> Thanks & Regards
> Manish Raturi

Any suggestions ?
