Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A486C1B2B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCTQUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjCTQTg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 12:19:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1F540C1
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 09:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AF7FB80ED7
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 16:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8EDC4339E;
        Mon, 20 Mar 2023 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679328661;
        bh=1P7wgkzEjsLcQs4tKsnVlNsjzslc9W/B/lWfRmbppXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Z6zhb4TENagTZVHxpxHImIwArs1lFw0qsNno5rSLP4uTVjPbT01tQWYCSVYCP4/4V
         v2VqW75LyD0PPSCEruHepKSgjq8MzpHHcZt8CQnddkat4hYa5jMquGnCiu8A+YeZYD
         T3C9BfFRHxNZ1K8SUj22VIYOrM6yGTTUpAXlf+rpULhLTVK9f1hZ20ywxepA/SKQY7
         hvarEkvatQEqCWpcmxiZnWckDx0k8aHm2zzbIGXMRCUYj2b5RO/+JbUsx4AZx/8Usy
         19tLjhwbIIGojeulqYU6xhILUJHd3+PBhzr680wjvm/uGNj1NTGqqSR3fTPqS7uweq
         +L0YspeEu6P6A==
Date:   Mon, 20 Mar 2023 11:11:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc:     linux-pci@vger.kernel.org, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Jon Nettleton <jon@solid-run.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: Samsung PM991 NVME does not work on LX2160A system (Solidrun
 Honeycomb)
Message-ID: <20230320161100.GA2292748@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1a1d17b-94fd-b53d-0850-c8f27440f0bd@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc NVMe folks]

On Mon, Mar 20, 2023 at 12:58:52PM +0100, Marcin Juszkiewicz wrote:
> During last week I had to shuffle some of my NVME drives between
> systems. One of those systems is Solidrun Honeycomb which uses
> LX2160A SoC.
> 
> The problem is that I am unable to use Samsung PM991 NVME there.
> It is 2242 card so probably also DRAMless. Kernel says:
> 
> nvme 0004:01:00.0: Adding to iommu group 4
> nvme nvme0: pci function 0004:01:00.0
> nvme nvme0: missing or invalid SUBNQN field.
> nvme nvme0: 1/0/0 default/read/poll queues
> nvme 0004:01:00.0: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update
> 
> The SUBNQN part can be handled by adding quirk in nvme/core.c file
> but that does not change situation. It also does not appear when
> used in x86-64 system.
> 
> Card is visible but only as PCIe device, no NVME block devices.
> 
> lspci says:
> 
> 0004:01:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd NVMe SSD Controller 980 [144d:a809] (prog-if 02 [NVM Express])
>         Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller 980 [144d:a801]
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 106
>         NUMA node: 0
>         IOMMU group: 1
>         Region 0: Memory at a400000000 (64-bit, non-prefetchable) [size=16K]
>         Expansion ROM at a040000000 [disabled] [size=128K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [70] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 15.000W
>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 8GT/s (ok), Width x4 (ok)
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
>                          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                          FRS+ TPHComp- ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
>                          AtomicOpsCtl: ReqEn-
>                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS+
>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
>                          EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported
>         Capabilities: [b0] MSI-X: Enable+ Count=13 Masked-
>                 Vector table: BAR=0 offset=00003000
>                 PBA: BAR=0 offset=00002000
>         Capabilities: [d0] Vital Product Data
>                 Not readable
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>                         MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
>         Capabilities: [158 v1] Power Budgeting <?>
>         Capabilities: [168 v1] Secondary PCI Express
>                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>                 LaneErrStat: 0
>         Capabilities: [188 v1] Latency Tolerance Reporting
>                 Max snoop latency: 0ns
>                 Max no snoop latency: 0ns
>         Capabilities: [190 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
>                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                            T_CommonMode=0us LTR1.2_Threshold=0ns
>                 L1SubCtl2: T_PwrOn=10us
>         Capabilities: [1a0 v1] Dynamic Power Allocation <?>
>         Capabilities: [1d0 v1] Readiness Time Reporting <?>
>         Capabilities: [1dc v1] Vendor Specific Information: ID=0002 Rev=3 Len=100 <?>
>         Capabilities: [2dc v1] Vendor Specific Information: ID=0001 Rev=1 Len=038 <?>
>         Capabilities: [314 v1] Precision Time Measurement
>                 PTMCap: Requester:+ Responder:- Root:-
>                 PTMClockGranularity: Unimplemented
>                 PTMControl: Enabled:- RootSelected:-
>                 PTMEffectiveGranularity: Unknown
>         Capabilities: [320 v1] Vendor Specific Information: ID=0003 Rev=1 Len=054 <?>
>         Kernel driver in use: nvme
>         Kernel modules: nvme
> 
> 
> I am able to use it without issues on my AMD Ryzen 3 3600 system:
> 
> pci 0000:23:00.0: [144d:a809] type 00 class 0x010802
> pci 0000:23:00.0: reg 0x10: [mem 0xfc900000-0xfc903fff 64bit]
> pci_bus 0000:23: resource 1 [mem 0xfc900000-0xfc9fffff]
> pci 0000:23:00.0: Adding to iommu group 24
> nvme nvme2: pci function 0000:23:00.0
> nvme nvme2: Shutdown timeout set to 8 seconds
> nvme nvme2: allocated 64 MiB host memory buffer.
> nvme nvme2: 12/0/0 default/read/poll queues
>  nvme2n1: p1 p2 p3 p4 p5
> 
> 
> Here lspci does not mention VPD part at all:
> 
> 23:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd NVMe SSD Controller 980 [144d:a809] (prog-if 02 [NVM Express])
>         Subsystem: Samsung Electronics Co Ltd Device [144d:a801]
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 39
>         NUMA node: 0
>         IOMMU group: 24
>         Region 0: Memory at fc900000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [70] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 8GT/s, Width x4
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
>                          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                          FRS- TPHComp- ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled,
>                          AtomicOpsCtl: ReqEn-
>                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
>                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
>                          EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported
>         Capabilities: [b0] MSI-X: Enable+ Count=13 Masked-
>                 Vector table: BAR=0 offset=00003000
>                 PBA: BAR=0 offset=00002000
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>                         MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
>         Capabilities: [158 v1] Power Budgeting <?>
>         Capabilities: [168 v1] Secondary PCI Express
>                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>                 LaneErrStat: 0
>         Capabilities: [188 v1] Latency Tolerance Reporting
>                 Max snoop latency: 1048576ns
>                 Max no snoop latency: 1048576ns
>         Capabilities: [190 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
>                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                            T_CommonMode=0us LTR1.2_Threshold=32768ns
>                 L1SubCtl2: T_PwrOn=10us
>         Kernel driver in use: nvme
>         Kernel modules: nvme
> 
> 
> Any idea what can be wrong? Other than usual "it is fault of
> used PCI Express implementation".
> 
> NOTE: Honeycomb does not expose root ports to the OS.
