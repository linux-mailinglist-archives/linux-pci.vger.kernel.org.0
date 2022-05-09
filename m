Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311D25202EE
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiEIQxa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 12:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239390AbiEIQx3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 12:53:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CD923BB5C
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 09:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD74FB8120C
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 16:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC47CC385AC;
        Mon,  9 May 2022 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652114972;
        bh=a/mC25Jih82obDCeHFZaK0jtmkkinjDAfNbm30UuZxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VasGih3psF0vWIPr33cWV1vqjAxTEhxWWJwgEa6Ry1gRb4LnNgk/1fMXfOwRZ+S8l
         /J4ZOwr1+6Ti2Mqdisjc1jB20cyNNt1Te2vL4T8ADvD/in9qiW9QDDK+1Mj8K3IvH7
         z31FCI26rB9y5gFKWvOSpk3ywAPDCBIzqRI/7EFvyWkTNjlerw/ICdHiITQQmqt9yA
         ZfeZoCg22mKZFYmKB674Amd8DpAgirWSC2ejujofFCFGjyNzemD054QvU5jyvCCoOt
         V8qjumq04/C7d52bZI5MmDBrbPojDpbwBQvpVEe6UfNuUPJ/2aWvR7V4zd0Xij4G7r
         9pb+32esvkWWA==
Date:   Mon, 9 May 2022 11:49:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Message-ID: <20220509164929.GA602900@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee14l1tx.fsf@epam.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 08, 2022 at 11:07:40AM +0000, Volodymyr Babchuk wrote:

> I had another crash in nvme_pci_enable(), for which I made quick
> workaround. And now yeah, it looks like I have some issues with
> my root complex HW:

Please point to the root complex issue you see.

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
>                 Capabilities: [70] Express (v2) Endpoint, MSI 00
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
>         Capabilities: [b0] MSI-X: Enable- Count=64 Masked-
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
>                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy-
>                 IOVSta: Migration-
>                 Initial VFs: 32, Total VFs: 32, Number of VFs: 1, Function Dependency Link: 00
>                 VF offset: 2, stride: 1, Device ID: a824
>                 Supported Page Size: 00000553, System Page Size: 00000001
>                 Region 0: Memory at 0000000030018000 (64-bit, non-prefetchable)
>                 VF Migration: offset: 00000000, BIR: 0
>         Capabilities: [3a4 v1] Data Link Feature <?>
>         Kernel driver in use: nvme
>         Kernel modules: nvme
> 
> 01:00.2 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a824 (prog-if 02 [NVM Express])
>         Subsystem: Samsung Electronics Co Ltd Device a809
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 0
>         NUMA node: 0
>         Region 0: Memory at 30018000 (64-bit, non-prefetchable) [size=32K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [70] Express (v2) Endpoint, MSI 00
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
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [b0] MSI-X: Enable- Count=64 Masked-
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
>                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy-
>                 IOVSta: Migration-
>                 Initial VFs: 32, Total VFs: 32, Number of VFs: 1, Function Dependency Link: 00
>                 VF offset: 2, stride: 1, Device ID: a824
>                 Supported Page Size: 00000553, System Page Size: 00000001
>                 Region 0: Memory at 0000000030018000 (64-bit, non-prefetchable)
>                 VF Migration: offset: 00000000, BIR: 0
>         Capabilities: [3a4 v1] Data Link Feature <?>
>         Kernel modules: nvme
> 
> As you can see, output for func 0 and func 2 is identical, so yeah,
> looks like my system reads config space for func 0 in both cases.

They are not identical:

  01:00.0 Non-Volatile memory controller
    Region 0: Memory at 30010000

  01:00.2 Non-Volatile memory controller
    Region 0: Memory at 30018000

> On other hand, I'm wondering if it is correct to have both is_virtfn and
> is_physfn in the first place, as there can 4 combinations and only two
> (or three?) of them are valid. Maybe it is worth to replace them with
> enum?

Good question.  I think there was a reason, but I can't remember it
right now.

Bjorn
