Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E588A51E840
	for <lists+linux-pci@lfdr.de>; Sat,  7 May 2022 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359097AbiEGPpk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 May 2022 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiEGPpj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 May 2022 11:45:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7604F2E9E1
        for <linux-pci@vger.kernel.org>; Sat,  7 May 2022 08:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF27CB80AC7
        for <linux-pci@vger.kernel.org>; Sat,  7 May 2022 15:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B663C385A6;
        Sat,  7 May 2022 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651938108;
        bh=Rc5LpTM7ADMEzoBwyMvFyeeJ86YS2yp0mwc+k75iig0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KBKupm+KCkBiWT+WraJf2SsCxQgf7pvfJVc8XUqBD0NHAOAs4u2yRueZ0Hk/IAVYm
         9di3n0/H0T85zY+DQnv/Q4lGW7RCW+elOpwEixwS+xxoEwMzM3cfEvdjNNemVBY0HD
         X6jZu2QAoIG4xjYD7hGuBpcBbpxu9iDMiJCw8e4a5oe0uzL3SpdjiAo4ZYHleye/Yt
         MOLYLcyOS3AMr/8BTxGkxuF+pAs4JJ29hu/A3tj4BIqdpSHSuXYTXd7fASI8ajN2m+
         5R1jtcOojcWJTHh3U9t6XXQDXdh2/DQnpvFnJwu9uAY/UJvhMl6wPVmM34MxRp4qH1
         jDJmMnY6DRSCg==
Date:   Sat, 7 May 2022 10:41:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Message-ID: <20220507154145.GA568412@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8uhlk1w.fsf@epam.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 07, 2022 at 10:22:32AM +0000, Volodymyr Babchuk wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Wed, May 04, 2022 at 07:56:01PM +0000, Volodymyr Babchuk wrote:
> >> 
> >> I have encountered issue when PCI code tries to use both fields in
> >> 
> >>         union {
> >> 		struct pci_sriov	*sriov;		/* PF: SR-IOV info */
> >> 		struct pci_dev		*physfn;	/* VF: related PF */
> >> 	};
> >> 
> >> (which are part of struct pci_dev) at the same time.
> >> 
> >> Symptoms are following:
> >> 
> >> # echo 1 > /sys/bus/pci/devices/0000:01:00.0/sriov_numvfs
> >> 
> >> pci 0000:01:00.2: reg 0x20c: [mem 0x30018000-0x3001ffff 64bit]
> >> pci 0000:01:00.2: VF(n) BAR0 space: [mem 0x30018000-0x30117fff 64bit] (contains BAR0 for 32 VFs)
> >>  Unable to handle kernel paging request at virtual address 0001000200000010

> >> Debugging showed the following:
> >> 
> >> pci_iov_add_virtfn() allocates new struct pci_dev:
> >> 
> >> 	virtfn = pci_alloc_dev(bus);
> >> and sets physfn:
> >> 	virtfn->is_virtfn = 1;
> >> 	virtfn->physfn = pci_dev_get(dev);
> >> 
> >> then we will get into sriov_init() via the following call path:
> >> 
> >> pci_device_add(virtfn, virtfn->bus);
> >>   pci_init_capabilities(dev);
> >>     pci_iov_init(dev);
> >>       sriov_init(dev, pos);
> >
> > We called pci_device_add() with the VF.  pci_iov_init() only calls
> > sriov_init() if it finds an SR-IOV capability on the device:
> >
> >   pci_iov_init(struct pci_dev *dev)
> >     pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
> >     if (pos)
> >       return sriov_init(dev, pos);
> >
> > So this means the VF must have an SR-IOV capability, which sounds a
> > little dubious.  From PCIe r6.0:
> 
> [...]
> 
> Yes, I dived into debugging and came to the same conclusions. I'm still
> investigating this, but looks like my PCIe controller (DesignWare-based)
> incorrectly reads configuration space for VF. Looks like instead of
> providing access VF config space, it reads PF's one.
> 
> > Can you supply the output of "sudo lspci -vv" for your system?
> 
> Sure:
> 
> root@spider:~# lspci -vv
> 00:00.0 PCI bridge: Renesas Technology Corp. Device 0031 (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 189
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: [disabled]
>         Memory behind bridge: 30000000-301fffff [size=2M]
>         Prefetchable memory behind bridge: [disabled]
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] MSI: Enable+ Count=128/128 Maskable+ 64bit+
>                 Address: 0000000004030040  Data: 0000
>                 Masking: fffffffe  Pending: 00000000
>         Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0
>                         ExtTag+ RBE+
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 5GT/s, Width x2, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
>                         ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 5GT/s (ok), Width x2 (ok)
>                         TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
>                 RootCap: CRSVisible-
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis+, NROPrPrP+, LTR+
>                          10BitTagComp+, 10BitTagReq-, OBFF Not Supported, ExtFmt-, EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                          FRS-, LN System CLS Not Supported, TPHComp-, ExtTPHComp-, ARIFwd-
>                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
>                          AtomicOpsCtl: ReqEn- EgressBlck-
>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
>                         MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>                 RootCmd: CERptEn- NFERptEn- FERptEn-
>                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>                          FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>         Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
>         Capabilities: [158 v1] Secondary PCI Express
>                 LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
>                 LaneErrStat: 0
>         Capabilities: [178 v1] Physical Layer 16.0 GT/s <?>
>         Capabilities: [19c v1] Lane Margining at the Receiver <?>
>         Capabilities: [1bc v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=10us PortTPowerOnTime=14us
>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                            T_CommonMode=0us LTR1.2_Threshold=0ns
>                 L1SubCtl2: T_PwrOn=10us
>         Capabilities: [1cc v1] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
>         Capabilities: [2cc v1] Vendor Specific Information: ID=0001 Rev=1 Len=038 <?>
>         Capabilities: [304 v1] Data Link Feature <?>
>         Capabilities: [310 v1] Precision Time Measurement
>                 PTMCap: Requester:+ Responder:+ Root:+
>                 PTMClockGranularity: 16ns
>                 PTMControl: Enabled:- RootSelected:-
>                 PTMEffectiveGranularity: Unknown
>         Capabilities: [31c v1] Vendor Specific Information: ID=0004 Rev=1 Len=054 <?>
>         Kernel driver in use: pcieport
>         Kernel modules: pci_endpoint_test
> 
> 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a824 (prog-if 02 [NVM Express])
>         Subsystem: Samsung Electronics Co Ltd Device a809
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 0
>         NUMA node: 0
>         Region 0: Memory at 30010000 (64-bit, non-prefetchable) [size=32K]
>         Expansion ROM at 30000000 [virtual] [disabled] [size=64K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [70] Express (v2) Endpoint, MSI 00                                                                                                                               [8/5710]
>                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
>                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM not supported
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 5GT/s (downgraded), Width x2 (downgraded)
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, NROPrPrP-, LTR-
>                          10BitTagComp+, 10BitTagReq-, OBFF Not Supported, ExtFmt-, EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                          FRS-, TPHComp-, ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>                          AtomicOpsCtl: ReqEn-
>                 LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [b0] MSI-X: Enable+ Count=64 Masked-
>                 Vector table: BAR=0 offset=00004000
>                 PBA: BAR=0 offset=00003000
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>                         MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Capabilities: [148 v1] Device Serial Number d3-42-50-11-99-38-25-00
>         Capabilities: [168 v1] Alternative Routing-ID Interpretation (ARI)
>                 ARICap: MFVC- ACS-, Next Function: 0
>                 ARICtl: MFVC- ACS-, Function Group: 0
>         Capabilities: [178 v1] Secondary PCI Express
>                 LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
>                 LaneErrStat: 0
>         Capabilities: [198 v1] Physical Layer 16.0 GT/s <?>
>         Capabilities: [1c0 v1] Lane Margining at the Receiver <?>
>         Capabilities: [1e8 v1] Single Root I/O Virtualization (SR-IOV)
>                 IOVCap: Migration-, Interrupt Message Number: 000
>                 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-
>                 IOVSta: Migration-
>                 Initial VFs: 32, Total VFs: 32, Number of VFs: 0, Function Dependency Link: 00
>                 VF offset: 2, stride: 1, Device ID: a824
>                 Supported Page Size: 00000553, System Page Size: 00000001
>                 Region 0: Memory at 0000000030018000 (64-bit, non-prefetchable)
>                 VF Migration: offset: 00000000, BIR: 0
>         Capabilities: [3a4 v1] Data Link Feature <?>
>         Kernel driver in use: nvme
>         Kernel modules: nvme

I guess this is before enabling SR-IOV on 01:00.0, so it doesn't show
the VFs themselves.

> > It could be that the device has an SR-IOV capability when it
> > shouldn't.  But even if it does, Linux could tolerate that better
> > than it does today.
> 
> Agree there. I can create simple patch that checks for is_virtfn
> in sriov_init(). But what to do if it is set?

Maybe something like this?  It makes no sense to me that a VF would
have an SR-IOV capability, but ...

If the below avoids the problem, maybe collect another "lspci -vv"
output including the VF(s).

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 952217572113..9c5184384a45 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -901,6 +901,10 @@ int pci_iov_init(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return -ENODEV;
 
+	/* Some devices include SR-IOV cap on VFs as well as PFs */
+	if (dev->is_virtfn)
+		return -ENODEV;
+
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
 	if (pos)
 		return sriov_init(dev, pos);
