Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96036C115C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 12:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCTL7H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 07:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCTL7F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 07:59:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22904EB5E
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 04:58:57 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g17so14573857lfv.4
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 04:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679313535;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKYEsyUZvwX1mt9steSaBqbSXhWPQA3Jf8DWn7GbmQw=;
        b=BapQsADDGb5aOt+L+RvpJlJbNQ0DeJK4gWGRmZ9R7V2daiR6YXK/cPb67d3X94/DV1
         tQyvvHs4HNhgTdgyrvyRboFUkZPtMG6gnzaQrELqZXrwYYpBl4idqnuI3BE0TcIhf12/
         6nUktK/+89eymI2rpGSSWGy9pCpDwXUm/jL+vNV/7GGOXQgeZyWLJ6lOh75I+UbH8u7C
         H3ikLDF/whXTxy4hToei+9wEkmZMxOfNfX4p1JLfBLEcy8SD5dri/WxzL3qao80rPp2C
         iZf+6oN/7l2Om62RkUL28d9PiHdxQEq8rrsreDX9Wqgft4fy62ypVpvzDBvvl4Ropqvw
         LNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679313535;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKYEsyUZvwX1mt9steSaBqbSXhWPQA3Jf8DWn7GbmQw=;
        b=OEgvB38VQYPygRszG5XSiKYrluPJ7UbaEhFKLDlSVxl98+EPXjUbD0hHVRdMv6cdtJ
         V0oN2z3S+iHU7r723LXn2LwFlS7zSJoUB6mZuQRVPgTpXzaQ0oG/RA5rJI1YQrDt28Z3
         3ypl2rQTpSXhYeAX7nbmQr1Yy5MnSC3yM5GfgcAaRu13qjqZOrmn1Sa0JcRgXh19IN30
         KzAu2gxfbREWraBCCbpr6nSAg6oTFwz9RxoHo8msGgAAYAz8iOFDKJA/JH9Y40goQAKG
         mjlYBr58l3k9UiFOg6M1Fy2GTCC3XmmQ5IESUF4NxbxaOKsOfFRsTjaipbyM4NMaYPoG
         eDog==
X-Gm-Message-State: AO0yUKXxlxUw4ooplhGFTOh4dt5jdH9O+iy2DJ0Q1e1Pb5DcYdJf0+o5
        sHGgQBis/DRiIF4cDajcCXf0zTZPll0O4UHrIB0yOg==
X-Google-Smtp-Source: AK7set8koUjjInUs+g1f5d7buCxR1YLnI5tlYAvUY5VAG1rCuUj9ohoavFX7i15bLF2U3eePz1fKXQ==
X-Received: by 2002:ac2:50c3:0:b0:4db:4530:2b2d with SMTP id h3-20020ac250c3000000b004db45302b2dmr7019890lfm.49.1679313535090;
        Mon, 20 Mar 2023 04:58:55 -0700 (PDT)
Received: from [192.168.200.206] (83.11.21.111.ipv4.supernova.orange.pl. [83.11.21.111])
        by smtp.gmail.com with ESMTPSA id j3-20020a19f503000000b004d6ebbad989sm1681875lfb.1.2023.03.20.04.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 04:58:54 -0700 (PDT)
Message-ID: <a1a1d17b-94fd-b53d-0850-c8f27440f0bd@linaro.org>
Date:   Mon, 20 Mar 2023 12:58:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: pl-PL, en-GB, en-HK
To:     linux-pci@vger.kernel.org
Cc:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Jon Nettleton <jon@solid-run.com>
From:   Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Samsung PM991 NVME does not work on LX2160A system (Solidrun
 Honeycomb)
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During last week I had to shuffle some of my NVME drives between
systems. One of those systems is Solidrun Honeycomb which uses
LX2160A SoC.

The problem is that I am unable to use Samsung PM991 NVME there.
It is 2242 card so probably also DRAMless. Kernel says:

nvme 0004:01:00.0: Adding to iommu group 4
nvme nvme0: pci function 0004:01:00.0
nvme nvme0: missing or invalid SUBNQN field.
nvme nvme0: 1/0/0 default/read/poll queues
nvme 0004:01:00.0: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update

The SUBNQN part can be handled by adding quirk in nvme/core.c file
but that does not change situation. It also does not appear when
used in x86-64 system.

Card is visible but only as PCIe device, no NVME block devices.

lspci says:

0004:01:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd NVMe SSD Controller 980 [144d:a809] (prog-if 02 [NVM Express])
         Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller 980 [144d:a801]
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 106
         NUMA node: 0
         IOMMU group: 1
         Region 0: Memory at a400000000 (64-bit, non-prefetchable) [size=16K]
         Expansion ROM at a040000000 [disabled] [size=128K]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [70] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 15.000W
                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 8GT/s (ok), Width x4 (ok)
                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                          FRS+ TPHComp- ExtTPHComp-
                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
                          AtomicOpsCtl: ReqEn-
                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS+
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
                          EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported
         Capabilities: [b0] MSI-X: Enable+ Count=13 Masked-
                 Vector table: BAR=0 offset=00003000
                 PBA: BAR=0 offset=00002000
         Capabilities: [d0] Vital Product Data
                 Not readable
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
         Capabilities: [158 v1] Power Budgeting <?>
         Capabilities: [168 v1] Secondary PCI Express
                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                 LaneErrStat: 0
         Capabilities: [188 v1] Latency Tolerance Reporting
                 Max snoop latency: 0ns
                 Max no snoop latency: 0ns
         Capabilities: [190 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=0us LTR1.2_Threshold=0ns
                 L1SubCtl2: T_PwrOn=10us
         Capabilities: [1a0 v1] Dynamic Power Allocation <?>
         Capabilities: [1d0 v1] Readiness Time Reporting <?>
         Capabilities: [1dc v1] Vendor Specific Information: ID=0002 Rev=3 Len=100 <?>
         Capabilities: [2dc v1] Vendor Specific Information: ID=0001 Rev=1 Len=038 <?>
         Capabilities: [314 v1] Precision Time Measurement
                 PTMCap: Requester:+ Responder:- Root:-
                 PTMClockGranularity: Unimplemented
                 PTMControl: Enabled:- RootSelected:-
                 PTMEffectiveGranularity: Unknown
         Capabilities: [320 v1] Vendor Specific Information: ID=0003 Rev=1 Len=054 <?>
         Kernel driver in use: nvme
         Kernel modules: nvme


I am able to use it without issues on my AMD Ryzen 3 3600 system:

pci 0000:23:00.0: [144d:a809] type 00 class 0x010802
pci 0000:23:00.0: reg 0x10: [mem 0xfc900000-0xfc903fff 64bit]
pci_bus 0000:23: resource 1 [mem 0xfc900000-0xfc9fffff]
pci 0000:23:00.0: Adding to iommu group 24
nvme nvme2: pci function 0000:23:00.0
nvme nvme2: Shutdown timeout set to 8 seconds
nvme nvme2: allocated 64 MiB host memory buffer.
nvme nvme2: 12/0/0 default/read/poll queues
  nvme2n1: p1 p2 p3 p4 p5


Here lspci does not mention VPD part at all:

23:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd NVMe SSD Controller 980 [144d:a809] (prog-if 02 [NVM Express])
         Subsystem: Samsung Electronics Co Ltd Device [144d:a801]
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 39
         NUMA node: 0
         IOMMU group: 24
         Region 0: Memory at fc900000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [70] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 8GT/s, Width x4
                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                          FRS- TPHComp- ExtTPHComp-
                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled,
                          AtomicOpsCtl: ReqEn-
                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
                          EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported
         Capabilities: [b0] MSI-X: Enable+ Count=13 Masked-
                 Vector table: BAR=0 offset=00003000
                 PBA: BAR=0 offset=00002000
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
         Capabilities: [158 v1] Power Budgeting <?>
         Capabilities: [168 v1] Secondary PCI Express
                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                 LaneErrStat: 0
         Capabilities: [188 v1] Latency Tolerance Reporting
                 Max snoop latency: 1048576ns
                 Max no snoop latency: 1048576ns
         Capabilities: [190 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=0us LTR1.2_Threshold=32768ns
                 L1SubCtl2: T_PwrOn=10us
         Kernel driver in use: nvme
         Kernel modules: nvme


Any idea what can be wrong? Other than usual "it is fault of
used PCI Express implementation".

NOTE: Honeycomb does not expose root ports to the OS.
