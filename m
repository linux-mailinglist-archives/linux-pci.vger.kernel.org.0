Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660D9423BF4
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 13:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbhJFLJA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbhJFLJA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Oct 2021 07:09:00 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DB3C061749;
        Wed,  6 Oct 2021 04:07:07 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id p18so2345063vsu.7;
        Wed, 06 Oct 2021 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbji8tAPNKVbj+4YUvjOTVECNllLMJpJsoiDoHovQ04=;
        b=XgynzjMA1HkCFpY56mFziNBru6k7iP3UXzQgt4g62e/b4AZf5ZoH3zcrkerVPA1Dv9
         T6yWse7LrdKzcdXxJKgwxoI9qHd+x3yqat9rJ5b2PIkkpejtLavhXld5wFGCrvclHg2r
         eNw9XjldfkemJ6b6msJPqlZ6lmZC7NfmpVS63P2K9xtFxJ+sSpaQh7vbkAILoJLTMYu9
         g1TolzB0S9IfgEsoK+2vW+gzKEslmorWnqhfSjVlPyObk6V39OCLK+QWmq1jfxIql/j4
         hkUq9aFdclyL1wayicvtj0xILwKyyML3v56md6r1bvEmgg7XpTZd7wMG//cdRrC/mDuU
         qiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbji8tAPNKVbj+4YUvjOTVECNllLMJpJsoiDoHovQ04=;
        b=kYH61c95vErvTdLLCiUC0vGj3ueII63VIvQ++tNWQQ51jEBSibp3Gq/9Ifi29x5BsQ
         cySp+0EM6tiVs3lZP7k8LRg0aSJhW5ie8C7LWyKwMA2IpmhdSBTbna477hQCmyswd++P
         5YQNg4UlLDLUOJWlt2kA1RSrwvK3WOBQNQNe9cKLk8eqVn4f/lojgYIQrLn8Rvet5JLo
         kbM6v8R4mN1QkTyT2evnDabLTyAJxmakWmhgv2N+u+NqC20KX99FiudIp5lMpUqXRS64
         UhGS66qL/Dq2G7/c82K1tLVv/qzD0VQ9/PiOrb9Im4L/yUcgc8Kff3mqN3XGm3D9/kSd
         LzJw==
X-Gm-Message-State: AOAM533JYTMZ85lKq5WzrQ/ICUN/Sh/sm8uGgdZMWCEacO/MhQiJrd2H
        oj2x7ETRk9K5ru+hxnhBZAgH2pIgDMoSn4OSRMvEthM=
X-Google-Smtp-Source: ABdhPJwkFvlnhlg3mLeEn8yKy0HH0z84qEGWOkEvNykYkn5q92a3kK4Uy2k5iib8yYrOZ+/bwiUBfs/WfDR3sLbsDt8=
X-Received: by 2002:a67:ca1c:: with SMTP id z28mr22830644vsk.40.1633518426789;
 Wed, 06 Oct 2021 04:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
 <87ee8yquyi.wl-maz@kernel.org>
In-Reply-To: <87ee8yquyi.wl-maz@kernel.org>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 6 Oct 2021 12:06:55 +0100
Message-ID: <CALjTZvakX8Hz+ow3UeAuQiicVXtbkXEDFnHU-+n8Ts6i1LRyHQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Marc,

On Wed, 6 Oct 2021 at 12:00, Marc Zyngier <maz@kernel.org> wrote:
>
> Could you please give more context for this error? I assume that this
> is some ATA device probing, but this is unclear at best. A full dmesg
> definitely help.

I'd love to have it, but I don't have a serial console to get it from.
I can take a photo, of course, but there's no stack dump.

> 'lspci -vvnn' would also be useful to understand what the device wants
> in terms of PCI configuration.

Sure thing, here it goes (complete dump):

00:00.0 Host bridge [0600]: NVIDIA Corporation MCP79 Host Bridge
[10de:0a82] (rev b1)
    Subsystem: NVIDIA Corporation MCP79 Host Bridge [10de:cb79]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

00:00.1 RAM memory [0500]: NVIDIA Corporation MCP79 Memory Controller
[10de:0a88] (rev b1)
    Subsystem: NVIDIA Corporation MCP79 Memory Controller [10de:cb79]
    Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

00:03.0 ISA bridge [0601]: NVIDIA Corporation MCP79 LPC Bridge
[10de:0aad] (rev b2)
    Subsystem: ZOTAC International (MCO) Ltd. MCP79 LPC Bridge [19da:a108]
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Region 0: I/O ports at 4f00 [size=256]

00:03.1 RAM memory [0500]: NVIDIA Corporation MCP79 Memory Controller
[10de:0aa4] (rev b1)
    Subsystem: ZOTAC International (MCO) Ltd. MCP79 Memory Controller
[19da:a108]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:03.2 SMBus [0c05]: NVIDIA Corporation MCP79 SMBus [10de:0aa2] (rev b1)
    Subsystem: ZOTAC International (MCO) Ltd. MCP79 SMBus [19da:a108]
    Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin A routed to IRQ 10
    Region 0: I/O ports at 4900 [size=64]
    Region 4: I/O ports at 4d00 [size=64]
    Region 5: I/O ports at 4e00 [size=64]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:03.3 RAM memory [0500]: NVIDIA Corporation MCP79 Memory Controller
[10de:0a89] (rev b1)
    Subsystem: NVIDIA Corporation MCP79 Memory Controller [10de:cb79]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:03.5 Co-processor [0b40]: NVIDIA Corporation MCP79 Co-processor
[10de:0aa3] (rev b1)
    Subsystem: ZOTAC International (MCO) Ltd. MCP79 Co-processor [19da:a108]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin B routed to IRQ 11
    Region 0: Memory at fae80000 (32-bit, non-prefetchable) [size=512K]

00:04.0 USB controller [0c03]: NVIDIA Corporation MCP79 OHCI USB 1.1
Controller [10de:0aa5] (rev b1) (prog-if 10 [OHCI])
    Subsystem: ZOTAC International (MCO) Ltd. MCP79 OHCI USB 1.1
Controller [19da:a108]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin A routed to IRQ 23
    Region 0: Memory at fae7f000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: ohci-pci

00:04.1 USB controller [0c03]: NVIDIA Corporation MCP79 EHCI USB 2.0
Controller [10de:0aa6] (rev b1) (prog-if 20 [EHCI])
    Subsystem: ZOTAC International (MCO) Ltd. MCP79 EHCI USB 2.0
Controller [19da:a108]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin B routed to IRQ 22
    Region 0: Memory at fae7ec00 (32-bit, non-prefetchable) [size=256]
    Capabilities: [44] Debug port: BAR=1 offset=00a0
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: ehci-pci

00:06.0 USB controller [0c03]: NVIDIA Corporation MCP79 OHCI USB 1.1
Controller [10de:0aa7] (rev b1) (prog-if 10 [OHCI])
    Subsystem: ZOTAC International (MCO) Ltd. MCP79 OHCI USB 1.1
Controller [19da:a108]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin A routed to IRQ 21
    Region 0: Memory at fae7d000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: ohci-pci

00:06.1 USB controller [0c03]: NVIDIA Corporation MCP79 EHCI USB 2.0
Controller [10de:0aa9] (rev b1) (prog-if 20 [EHCI])
    Subsystem: ZOTAC International (MCO) Ltd. MCP79 EHCI USB 2.0
Controller [19da:a108]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin B routed to IRQ 20
    Region 0: Memory at fae7e800 (32-bit, non-prefetchable) [size=256]
    Capabilities: [44] Debug port: BAR=1 offset=00a0
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: ehci-pci

00:08.0 Audio device [0403]: NVIDIA Corporation MCP79 High Definition
Audio [10de:0ac0] (rev b1)
    Subsystem: PC Partner Limited / Sapphire Technology MCP79 High
Definition Audio [174b:437b]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0 (500ns min, 1250ns max)
    Interrupt: pin A routed to IRQ 23
    Region 0: Memory at fae78000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: snd_hda_intel

00:09.0 PCI bridge [0604]: NVIDIA Corporation MCP79 PCI Bridge
[10de:0aab] (rev b1) (prog-if 01 [Subtractive decode])
    Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=248
    I/O behind bridge: [disabled]
    Memory behind bridge: [disabled]
    Prefetchable memory behind bridge: [disabled]
    Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr+ DiscTmrStat- DiscTmrSERREn-
    Capabilities: [b8] Subsystem: ZOTAC International (MCO) Ltd. MCP79
PCI Bridge [19da:a108]

00:0a.0 Ethernet controller [0200]: NVIDIA Corporation MCP79 Ethernet
[10de:0ab0] (rev b1)
    Subsystem: ZOTAC International (MCO) Ltd. MCP79 Ethernet [19da:a108]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0 (250ns min, 5000ns max)
    Interrupt: pin A routed to IRQ 20
    Region 0: Memory at fae7c000 (32-bit, non-prefetchable) [size=4K]
    Region 1: I/O ports at d080 [size=8]
    Region 2: Memory at fae7e400 (32-bit, non-prefetchable) [size=256]
    Region 3: Memory at fae7e000 (32-bit, non-prefetchable) [size=16]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
    Kernel driver in use: forcedeth

00:0b.0 SATA controller [0106]: NVIDIA Corporation MCP79 AHCI
Controller [10de:0ab8] (rev b1) (prog-if 01 [AHCI 1.0])
    Subsystem: ZOTAC International (MCO) Ltd. MCP79 AHCI Controller [19da:a108]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin A routed to IRQ 30
    Region 0: I/O ports at d000 [size=8]
    Region 1: I/O ports at cc00 [size=4]
    Region 2: I/O ports at c880 [size=8]
    Region 3: I/O ports at c800 [size=4]
    Region 4: I/O ports at c480 [size=16]
    Region 5: Memory at fae76000 (32-bit, non-prefetchable) [size=8K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [8c] SATA HBA v1.0 InCfgSpace
    Capabilities: [b0] MSI: Enable+ Count=1/8 Maskable- 64bit+
        Address: 00000000fee02004  Data: 0026
    Kernel driver in use: ahci

00:0c.0 PCI bridge [0604]: NVIDIA Corporation MCP79 PCI Express Bridge
[10de:0ac4] (rev b1) (prog-if 00 [Normal decode])
    Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 24
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: [disabled]
    Memory behind bridge: [disabled]
    Prefetchable memory behind bridge: [disabled]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Subsystem: ZOTAC International (MCO) Ltd. MCP79
PCI Express Bridge [19da:a108]
    Capabilities: [48] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
        Address: 00000000fee04004  Data: 0021
    Capabilities: [80] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0
            ExtTag+ RBE+
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <512ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
        LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s (ok), Width x16 (ok)
            TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq+ LinkChg+
            Control: AttnInd Off, PwrInd On, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCap: CRSVisible-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR-
             10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
             EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
             FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
             AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
        DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR-
OBFF Disabled, ARIFwd-
             AtomicOpsCtl: ReqEn- EgressBlck-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
             EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
             Retimer- 2Retimers- CrosslinkRes: unsupported
    Kernel driver in use: pcieport

00:10.0 PCI bridge [0604]: NVIDIA Corporation MCP79 PCI Express Bridge
[10de:0aa0] (rev b1) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 0000e000-0000efff [size=4K]
    Memory behind bridge: faf00000-fbffffff [size=17M]
    Prefetchable memory behind bridge:
00000000e0000000-00000000f9ffffff [size=416M]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Subsystem: ZOTAC International (MCO) Ltd. MCP79
PCI Express Bridge [19da:a108]
    Capabilities: [48] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable- Count=1/2 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000

00:15.0 PCI bridge [0604]: NVIDIA Corporation MCP79 PCI Express Bridge
[10de:0ac6] (rev b1) (prog-if 00 [Normal decode])
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 25
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
    I/O behind bridge: [disabled]
    Memory behind bridge: feb00000-febfffff [size=1M]
    Prefetchable memory behind bridge: [disabled]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Subsystem: ZOTAC International (MCO) Ltd. MCP79
PCI Express Bridge [19da:a108]
    Capabilities: [48] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
        Address: 00000000fee08004  Data: 0021
    Capabilities: [80] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0
            ExtTag+ RBE+
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
        LnkCap:    Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
        LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
            TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq+ LinkChg+
            Control: AttnInd Off, PwrInd On, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState+
        RootCap: CRSVisible-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR-
             10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
             EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
             FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
             AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
        DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR-
OBFF Disabled, ARIFwd-
             AtomicOpsCtl: ReqEn- EgressBlck-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
             EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
             Retimer- 2Retimers- CrosslinkRes: unsupported
    Kernel driver in use: pcieport

00:16.0 PCI bridge [0604]: NVIDIA Corporation MCP79 PCI Express Bridge
[10de:0ac7] (rev b1) (prog-if 00 [Normal decode])
    Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 26
    Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
    I/O behind bridge: [disabled]
    Memory behind bridge: [disabled]
    Prefetchable memory behind bridge: [disabled]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Subsystem: ZOTAC International (MCO) Ltd. MCP79
PCI Express Bridge [19da:a108]
    Capabilities: [48] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
        Address: 00000000fee01004  Data: 0021
    Capabilities: [80] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0
            ExtTag+ RBE+
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
        LnkCap:    Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
        LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
            TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq+ LinkChg+
            Control: AttnInd Off, PwrInd On, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCap: CRSVisible-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR-
             10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
             EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
             FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
             AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
        DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR-
OBFF Disabled, ARIFwd-
             AtomicOpsCtl: ReqEn- EgressBlck-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
             EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
             Retimer- 2Retimers- CrosslinkRes: unsupported
    Kernel driver in use: pcieport

00:17.0 PCI bridge [0604]: NVIDIA Corporation MCP79 PCI Express Bridge
[10de:0ac7] (rev b1) (prog-if 00 [Normal decode])
    Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 27
    Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
    I/O behind bridge: [disabled]
    Memory behind bridge: [disabled]
    Prefetchable memory behind bridge: [disabled]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Subsystem: ZOTAC International (MCO) Ltd. MCP79
PCI Express Bridge [19da:a108]
    Capabilities: [48] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
        Address: 00000000fee02004  Data: 0022
    Capabilities: [80] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0
            ExtTag+ RBE+
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
        LnkCap:    Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
        LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
            TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq+ LinkChg+
            Control: AttnInd Off, PwrInd On, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCap: CRSVisible-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR-
             10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
             EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
             FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
             AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
        DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR-
OBFF Disabled, ARIFwd-
             AtomicOpsCtl: ReqEn- EgressBlck-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
             EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
             Retimer- 2Retimers- CrosslinkRes: unsupported
    Kernel driver in use: pcieport

00:18.0 PCI bridge [0604]: NVIDIA Corporation MCP79 PCI Express Bridge
[10de:0ac7] (rev b1) (prog-if 00 [Normal decode])
    Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 28
    Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
    I/O behind bridge: [disabled]
    Memory behind bridge: [disabled]
    Prefetchable memory behind bridge: [disabled]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Subsystem: ZOTAC International (MCO) Ltd. MCP79
PCI Express Bridge [19da:a108]
    Capabilities: [48] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
        Address: 00000000fee04004  Data: 0022
    Capabilities: [80] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0
            ExtTag+ RBE+
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
        LnkCap:    Port #6, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
        LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
            TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq+ LinkChg+
            Control: AttnInd Off, PwrInd On, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCap: CRSVisible-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR-
             10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
             EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
             FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
             AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
        DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR-
OBFF Disabled, ARIFwd-
             AtomicOpsCtl: ReqEn- EgressBlck-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
             EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
             Retimer- 2Retimers- CrosslinkRes: unsupported
    Kernel driver in use: pcieport

03:00.0 VGA compatible controller [0300]: NVIDIA Corporation C79 [ION]
[10de:087d] (rev b1) (prog-if 00 [VGA controller])
    Subsystem: ZOTAC International (MCO) Ltd. C79 [ION] [19da:a108]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 29
    Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at e0000000 (64-bit, prefetchable) [size=256M]
    Region 3: Memory at f8000000 (64-bit, prefetchable) [size=32M]
    Region 5: I/O ports at ec00 [size=128]
    Expansion ROM at 000c0000 [disabled] [size=128K]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee04004  Data: 0023
    Kernel driver in use: nouveau

04:00.0 Network controller [0280]: Ralink corp. RT2790 Wireless
802.11n 1T/2R PCIe [1814:0781]
    Subsystem: Ralink corp. RT2790 Wireless 802.11n 1T/2R PCIe [1814:2790]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 19
    Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=64K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [70] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<128ns, L1 <2us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0.000W
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl:    ASPM Disabled; RCB 128 bytes, Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
            TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
    Kernel driver in use: rt2800pci

Let me know if you need anything else.

Thanks,
Rui
