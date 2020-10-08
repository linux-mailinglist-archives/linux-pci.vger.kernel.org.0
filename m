Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0BC2870D5
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 10:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgJHIjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 04:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHIje (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2020 04:39:34 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A96AC061755;
        Thu,  8 Oct 2020 01:39:34 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id a2so3974126ybj.2;
        Thu, 08 Oct 2020 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nKhZgxRWPwhyCcN9MKu01QnLQx5ZBvx0IuEgknU19s=;
        b=Ob8/hkOH2/A6dh1DsOVz6XYVDs6x82YqzGl6URVrPsBuIEE/WvPwOhfaBHgUTj0w25
         +5C7FC9XQlEXlXkmMCLj1ICnoWLosYCK8TXP90jSbDHvom5Ls/pyDJ5WvXPDWfoLjDbJ
         ceSmImv4oV8Va4p0bu3wMVSYUWQVr8lu0uLYFDVRWtycJ1RXuCPzjcPIoRqVyw/LKn9m
         l2yqRI69IDRVCHYHt/nzxBybI7m+Yc0d7yhois1Ux+llKg2kJf1CI49KniNTxgi3r+0A
         COl3I2dOPFvn1i0yilH2/n6eoGzt2TftohAtBxniKDocW5oAmf+oHURxr16U74US/qdL
         bQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nKhZgxRWPwhyCcN9MKu01QnLQx5ZBvx0IuEgknU19s=;
        b=kISgU6corgr4sOe+UKKimjWy+wL5tXaa/nyFSfkADswIkJ8uyee1OuaxLR62kbzCue
         yn/KAKOHp1/9m7mWxdVYCMfd9UAjKAXjTKR5NHC98EmeywanMZvoGHYckGrs307bV04e
         tDiGVNsEncgeVHy/xRuxQuwdAzCKW//ojqxZA0ujg0SaDsYL3a/8xf7DCrwqtmpCyk0D
         YGik9Wa7wtCT8UbWI0vcie7Q5IPdjcGl8rtZCrYxzqd2Wq+i8r1rS7n8vm4ZWLqKPPU7
         Kn0Q0gx2omOC+2bHiLw61Nd9vfOiJ187+N8ZOrIVS6qYOH/NTITIF9AH4RJ0FNg7eNKb
         h5wg==
X-Gm-Message-State: AOAM533WaPaRv5VCmdOr8rDNGJUpiUIsY8XTPYVMq7u8iLu23HT9NMbW
        FiF9Dw5lpMRC/+rovdA49wK4wsc0F5WBWofYmAc=
X-Google-Smtp-Source: ABdhPJylCb3YjFXXqVBk3V82SRJILqZwmuqUPQM1AFpbG+OtIAcAPJakGT17hYnRaCB9Ghj0oaYDRnoqzHsfqEWQ8uc=
X-Received: by 2002:a25:c642:: with SMTP id k63mr8638857ybf.111.1602146373545;
 Thu, 08 Oct 2020 01:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAEt4U6V22Abudp1TRJ2SGkYH=2o+RFWa8nrGbKDoLFXcZJV7qA@mail.gmail.com>
 <20201007164141.GA3249809@bjorn-Precision-5520>
In-Reply-To: <20201007164141.GA3249809@bjorn-Precision-5520>
From:   Billy Araujo <billyaraujo@gmail.com>
Date:   Thu, 8 Oct 2020 09:39:23 +0100
Message-ID: <CAEt4U6Xqo8GU6VtBi86iK2-Q3usyHazoASdj1qb_BK-_Gso2kA@mail.gmail.com>
Subject: Re: PCI IRQ assignment broken from 4.9 onwards (swizzle?)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for your answer. Yes, that would be my next step.
I am also hoping the latest kernel doesn't have this issue because
that would mean I would be stuck with version 4.9.
Also I could discover from which patch this stopped working but that
would be very time consuming. If I was to add some debug prints where
should I start? Would this be done in setup-irq.c?
In other words, is "pci_assign_irq" function responsible for all irq
assignments?

Regards,

Billy.



On Wed, Oct 7, 2020 at 5:41 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Kishon, linux-omap (maybe this is dra7xx-related?)]
>
> On Wed, Oct 07, 2020 at 10:56:33AM +0100, Billy Araujo wrote:
> > Hi,
> >
> > I have been testing a TI AM57xx board and a NXP iMX8 board with a GPIB
> > PCIe card.
> >
> > TI board (Phytec): https://www.phytec.com/product/phycore-am57x/
> > NXP board (Variscite):
> > https://www.variscite.com/product/system-on-module-som/cortex-a53-krait/var-som-mx8m-mini-nxp-i-mx8m-mini/
> >
> > The GPIB PCIe card has a Texas Instruments XIO2000(A)/XIO2200A PCI
> > Express-to-PCI Bridge.
> >
> > Issue:
> > I have noticed is that on Linux kernel 4.9, the Linux PCI driver
> > assigns correctly an IRQ number:
> >
> > Linux am5728-phycore-rdk 4.9.41-ga962b18-BSP-Yocto-TISDK-AM57xx-PD18.1.0
> > 02:00.0 Communication controller: National Instruments PCIe-GPIB (rev 02)
> >         Subsystem: National Instruments PCIe-GPIB
> >         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr+ Stepping- SERR+ FastB2B- DisINTx-
> >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Interrupt: pin A routed to IRQ 470
> >
> > On a newer kernel (this case 4.19), PCI driver doesn't assign an IRQ number.
> >
> > Linux am57xx-phycore-kit 4.19.79-g35d36cd54d #1 SMP PREEMPT Wed Sep 30
> > 14:04:18 UTC 2020 armv7l GNU/Linux
> > 02:00.0 Communication controller: National Instruments PCIe-GPIB (rev 02)
> >         Subsystem: National Instruments PCIe-GPIB
> >         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr+ Stepping- SERR+ FastB2B- DisINTx-
> >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Interrupt: pin A routed to IRQ 0
> >
> > Same issue happened on the NXP board, so it seems Linux related. I
> > have tested kernels 4.14, 4.19 and 5.4.3.
> >
> > The IRQ is important to get the legacy interrupts working.
> >
> > Looking at the code there has been some refactoring of how PCI assigns
> > IRQ number when there is a chain of bridges. I am not too familiar
> > with how the code works but I wonder if this has affected how the PCI
> > assignment works.
> >
> > Looking in setup-irq.c:
> >
> > /* If this device is not on the primary bus, we need to figure out
> >    which interrupt pin it will come in on.   We know which slot it
> >    will come in on 'cos that slot is where the bridge is.   Each
> >    time the interrupt line passes through a PCI-PCI bridge we must
> >    apply the swizzle function.  */
> >
> > Line 44: if (hbrg->swizzle_irq)
> >
> > From my understanding, this "if" didn't exist in Linux kernel 4.9. If
> > swizzle function isn't assigned in the newer kernels it just stays as
> > 0.
> >
> > This might be completely unrelated as I said I have no understanding
> > how this code is supposed to work.
> >
> > What I ask is if anyone has experienced any issues similar to this in
> > these more recent kernel versions.
>
> Sorry for the issue, and thanks very much for the report.  Is it
> possible to test a current kernel, e.g., v5.8 or v5.9-rc8?
>
> My guess is this is related to the PCI controller driver; would that
> be pci-dra7xx.c?
>
> > Debug output with the issue:
> >
> > root@am57xx-phycore-kit:~# uname -a
> > Linux am57xx-phycore-kit 4.19.79-g35d36cd54d #1 SMP PREEMPT Wed Sep 30
> > 14:04:18 UTC 2020 armv7l GNU/Linux
> >
> > root@am57xx-phycore-kit:~# lspci -vv
> > 00:00.0 PCI bridge: Texas Instruments Multicore DSP+ARM KeyStone II
> > SOC (rev 01) (prog-if 00 [Normal decode])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr+ Stepping- SERR+ FastB2B- DisINTx+
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0, Cache Line Size: 64 bytes
> >         Interrupt: pin A routed to IRQ 180
> >         Region 0: Memory at 20100000 (64-bit, non-prefetchable) [size=1M]
> >         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> >         I/O behind bridge: None
> >         Memory behind bridge: 20200000-202fffff [size=1M]
> >         Prefetchable memory behind bridge: None
> >         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > <TAbort- <MAbort+ <SERR- <PERR-
> >         BridgeCtl: Parity+ SERR- NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> >                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >         Capabilities: [40] Power Management version 3
> >                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
> > PME(D0+,D1+,D2-,D3hot+,D3cold-)
> >                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> >         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
> >                 Address: 00000000ae15b000  Data: 0000
> >         Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
> >                 DevCap: MaxPayload 256 bytes, PhantFunc 0
> >                         ExtTag- RBE+
> >                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> >                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> >                         MaxPayload 128 bytes, MaxReadReq 512 bytes
> >                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > AuxPwr- TransPend-
> >                 LnkCap: Port #0, Speed 5GT/s, Width x2, ASPM L0s L1,
> > Exit Latency L0s <512ns, L1 <64us
> >                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
> >                 LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk-
> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                 LnkSta: Speed 2.5GT/s (downgraded), Width x1 (downgraded)
> >                         TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
> >                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> > PMEIntEna+ CRSVisible-
> >                 RootCap: CRSVisible-
> >                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> >                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
> > LTR-, OBFF Not Supported ARIFwd-
> >                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> >                 DevCtl2: Completion Timeout: 50us to 50ms,
> > TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
> >                          AtomicOpsCtl: ReqEn- EgressBlck-
> >                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> >                          Transmit Margin: Normal Operating Range,
> > EnterModifiedCompliance- ComplianceSOS-
> >                          Compliance De-emphasis: -6dB
> >                 LnkSta2: Current De-emphasis Level: -3.5dB,
> > EqualizationComplete-, EqualizationPhase1-
> >                          EqualizationPhase2-, EqualizationPhase3-,
> > LinkEqualizationRequest-
> >         Capabilities: [100 v2] Advanced Error Reporting
> >                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> >                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> >                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> >                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr-
> >                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr+
> >                 AERCap: First Error Pointer: 00, ECRCGenCap+
> > ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> >                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> >                 HeaderLog: 00000000 00000000 00000000 00000000
> >                 RootCmd: CERptEn+ NFERptEn+ FERptEn+
> >                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
> >                          FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
> >                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
> >         Kernel driver in use: pcieport
> >
> > 01:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200A PCI
> > Express-to-PCI Bridge (rev 03) (prog-if 00 [Normal decode])
> >         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr+ Stepping- SERR+ FastB2B- DisINTx-
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
> >         I/O behind bridge: None
> >         Memory behind bridge: 20200000-202fffff [size=1M]
> >         Prefetchable memory behind bridge: None
> >         Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium
> > >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> >         BridgeCtl: Parity+ SERR- NoISA- VGA- VGA16- MAbort+ >Reset- FastB2B+
> >                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >         Capabilities: [50] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> >                 Bridge: PM- B3+
> >         Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
> >                 Address: 0000000000000000  Data: 0000
> >         Capabilities: [80] Subsystem: Device 0000:0000
> >         Capabilities: [90] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00
> >                 DevCap: MaxPayload 512 bytes, PhantFunc 0
> >                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE-
> > SlotPowerLimit 0.000W
> >                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ BrConfRtry-
> >                         MaxPayload 128 bytes, MaxReadReq 512 bytes
> >                 DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq-
> > AuxPwr- TransPend-
> >                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
> > Exit Latency L0s <1us, L1 <16us
> >                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
> >                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                 LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
> >                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> >         Capabilities: [100 v1] Advanced Error Reporting
> >                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> >                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> >                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> >                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr-
> >                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr-
> >                 AERCap: First Error Pointer: 00, ECRCGenCap+
> > ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> >                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> >                 HeaderLog: 00000000 00000000 00000000 00000000
> >
> > 02:00.0 Communication controller: National Instruments PCIe-GPIB (rev 02)
> >         Subsystem: National Instruments PCIe-GPIB
> >         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr+ Stepping- SERR+ FastB2B- DisINTx-
> >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Interrupt: pin A routed to IRQ 0
> >         Region 0: Memory at 20204000 (32-bit, non-prefetchable)
> > [disabled] [size=2K]
> >         Region 1: Memory at 20200000 (32-bit, non-prefetchable)
> > [disabled] [size=16K]
