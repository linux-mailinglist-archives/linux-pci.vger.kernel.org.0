Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B84285C25
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 11:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgJGJ4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 05:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgJGJ4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 05:56:45 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEF1C061755
        for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2020 02:56:44 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x20so1374573ybs.8
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2020 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=59U5YHRhYoK3QiwxwbVozJdpsBtw0yLMXKBGhphwwaY=;
        b=OZ/sjR1iCEl5q0iUoXcvfXEKQfuNj2qXQsseHAIxikYfNefqhZR2sjZjtJEZo0a9my
         Xt9uP85cVOlRIImn+wV2Thr8ehOFz4FQmUFkKRcoL5ncta4tRGgPrJTw/mynNU+Wbgma
         dGWV9npmoN2dTI28E2+mlcG16wWLOvVOhWmk7IKPbjWMpeCYIRdW0SF6rICe2GaYjFHM
         WWvxliex92LCnBTW7J/rCHum8BFI5a8jLWR4Aik+pal7Mv+bplFVJyYl3gU4B4CU3p/t
         lioCcXuRfD1jOVrbxgdS4hngaArknmScq3vmnESUY19CG0SaT1jdausXuJCEhbYWny70
         ulhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=59U5YHRhYoK3QiwxwbVozJdpsBtw0yLMXKBGhphwwaY=;
        b=LKLU1lpM4C2Q4EMlWmozDYIfEY0+9gv7At8Z0f60+TyftK9YPqSw6fEFYnn9aNy9sW
         2LfrLGZ/dZn17nkzJAyf9Ea5ZuVYhf1KcHlhM7V0cf5yykUBWhFdkeoSwetM/SEgfgnc
         32GspwdxjvBUjlkkdFNSlRbhJ+nnlEbz+Q+yBV0Ntaojspgv+lR9HpHqWWjBiefwvtR3
         S2dHt7EcpYKFJwUulIlBI5lXWmsqZu3PfvJz6ASzpJAt23sb9E9q+YKWEo45+/0jqw6F
         HE5TWO6QcdcIqkXKiLrq9b7xNZHuaQBkrdiWevOSylWXr1dG6tuFJysFrfMuwpuOoPxZ
         bz3Q==
X-Gm-Message-State: AOAM530ByTJNEkxUc4JhqR4eY7OSIm7uU+vTSKsMjle2Jj7w9ddtP6Sk
        L5LOn1NbZLGbqNTSqrzPIrMpMyG1QYEc+BwWZ5dQYKZexH1Q73Zn
X-Google-Smtp-Source: ABdhPJyhD80ag5l1ruhWN8m472kLlem+t8D1rZ/gBKG4jTVFr/LBo/Guh42C7itiUuSbOn9K/5m6I/U6YUNEarkYZao=
X-Received: by 2002:a25:8505:: with SMTP id w5mr2842089ybk.486.1602064603858;
 Wed, 07 Oct 2020 02:56:43 -0700 (PDT)
MIME-Version: 1.0
From:   Billy Araujo <billyaraujo@gmail.com>
Date:   Wed, 7 Oct 2020 10:56:33 +0100
Message-ID: <CAEt4U6V22Abudp1TRJ2SGkYH=2o+RFWa8nrGbKDoLFXcZJV7qA@mail.gmail.com>
Subject: PCI IRQ assignment broken from 4.9 onwards (swizzle?)
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I have been testing a TI AM57xx board and a NXP iMX8 board with a GPIB
PCIe card.

TI board (Phytec): https://www.phytec.com/product/phycore-am57x/
NXP board (Variscite):
https://www.variscite.com/product/system-on-module-som/cortex-a53-krait/var-som-mx8m-mini-nxp-i-mx8m-mini/

The GPIB PCIe card has a Texas Instruments XIO2000(A)/XIO2200A PCI
Express-to-PCI Bridge.

Issue:
I have noticed is that on Linux kernel 4.9, the Linux PCI driver
assigns correctly an IRQ number:

Linux am5728-phycore-rdk 4.9.41-ga962b18-BSP-Yocto-TISDK-AM57xx-PD18.1.0
02:00.0 Communication controller: National Instruments PCIe-GPIB (rev 02)
        Subsystem: National Instruments PCIe-GPIB
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 470

On a newer kernel (this case 4.19), PCI driver doesn't assign an IRQ number.

Linux am57xx-phycore-kit 4.19.79-g35d36cd54d #1 SMP PREEMPT Wed Sep 30
14:04:18 UTC 2020 armv7l GNU/Linux
02:00.0 Communication controller: National Instruments PCIe-GPIB (rev 02)
        Subsystem: National Instruments PCIe-GPIB
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 0

Same issue happened on the NXP board, so it seems Linux related. I
have tested kernels 4.14, 4.19 and 5.4.3.

The IRQ is important to get the legacy interrupts working.

Looking at the code there has been some refactoring of how PCI assigns
IRQ number when there is a chain of bridges. I am not too familiar
with how the code works but I wonder if this has affected how the PCI
assignment works.

Looking in setup-irq.c:

/* If this device is not on the primary bus, we need to figure out
   which interrupt pin it will come in on.   We know which slot it
   will come in on 'cos that slot is where the bridge is.   Each
   time the interrupt line passes through a PCI-PCI bridge we must
   apply the swizzle function.  */

Line 44: if (hbrg->swizzle_irq)

From my understanding, this "if" didn't exist in Linux kernel 4.9. If
swizzle function isn't assigned in the newer kernels it just stays as
0.

This might be completely unrelated as I said I have no understanding
how this code is supposed to work.

What I ask is if anyone has experienced any issues similar to this in
these more recent kernel versions.

Regards,

Billy.

Debug output with the issue:

root@am57xx-phycore-kit:~# uname -a
Linux am57xx-phycore-kit 4.19.79-g35d36cd54d #1 SMP PREEMPT Wed Sep 30
14:04:18 UTC 2020 armv7l GNU/Linux

root@am57xx-phycore-kit:~# lspci -vv
00:00.0 PCI bridge: Texas Instruments Multicore DSP+ARM KeyStone II
SOC (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 180
        Region 0: Memory at 20100000 (64-bit, non-prefetchable) [size=1M]
        Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: 20200000-202fffff [size=1M]
        Prefetchable memory behind bridge: None
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000ae15b000  Data: 0000
        Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x2, ASPM L0s L1,
Exit Latency L0s <512ns, L1 <64us
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (downgraded), Width x1 (downgraded)
                        TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
LTR-, OBFF Not Supported ARIFwd-
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn+ NFERptEn+ FERptEn+
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Kernel driver in use: pcieport

01:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200A PCI
Express-to-PCI Bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: 20200000-202fffff [size=1M]
        Prefetchable memory behind bridge: None
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- VGA16- MAbort+ >Reset- FastB2B+
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+
        Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [80] Subsystem: Device 0000:0000
        Capabilities: [90] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE-
SlotPowerLimit 0.000W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ BrConfRtry-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq-
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <1us, L1 <16us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
                AERCap: First Error Pointer: 00, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000

02:00.0 Communication controller: National Instruments PCIe-GPIB (rev 02)
        Subsystem: National Instruments PCIe-GPIB
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 20204000 (32-bit, non-prefetchable)
[disabled] [size=2K]
        Region 1: Memory at 20200000 (32-bit, non-prefetchable)
[disabled] [size=16K]
