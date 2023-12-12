Return-Path: <linux-pci+bounces-795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219B780E935
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 11:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4569F1C20A29
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834421373;
	Tue, 12 Dec 2023 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEXltCsl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E64A6
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 02:34:54 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3ba04b9b103so1824416b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 02:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702377293; x=1702982093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HqSg3/ked2DQeNHC4jb0tMjewAk88iiTBjuz2viSAOI=;
        b=hEXltCslnPbla0ByOGQoAQXC54zhHTzVxzwH7jASrTYq4X4WxxDPsKshjccbrSIbSk
         dljZm6ayHlK29tAgCvjJPhElUZWT9zqFpKo8l8v4i6+KQ5L1tKJoJgKLbhPnafT7XOXD
         XmsfB6Q9fdoHTMeg18wnzwhFgrXfLFIv6IJoJgKMQxy1hk7EfR/ixPCIfi8GDjUWhCGI
         thXS4BQ+M0vu1gODgpPqmUilO8EPJHSzDZ7b7m0lm3rpKXgJaDGiD6uaAmaa2tQvzBO4
         6P7/O31KJYEF68r9scSRn0C32Vgj3VHmzZo2oh0f4i+R1+IAGuZol/51njRkPUZQa5HW
         lAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702377293; x=1702982093;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqSg3/ked2DQeNHC4jb0tMjewAk88iiTBjuz2viSAOI=;
        b=uxRuQ76HcvZ7j1hw2uUyJpHQe3u3QyhnGkkJTChSxUV/qahfQUrFvtuPkN+4HVnpRC
         0aqv4dLHj1ciWvbC3UMAclD8qcZOIjylVRhgfZhb5hnJTN+E1VFf5zqGrgwOtclHEbpc
         9JJqgydVy1+Hq8aRS+b56MJjxrlxckhy6OulczIdkCtfwF3kZzehHUb7Si1e4yZgdN5Q
         /A+Zs28VzvWufGuOH1Pwo/Bl0NTVm6k2m59+Q3N8OKhhQbXI+BdEsOtYHa3faqY8k0jI
         WWqD+TVttsI0qFF3jYGHt9J4SxgVsGujVN+8oO/vMJq6K7rRptcHxg1DDvc1BSI+aVW4
         2OEQ==
X-Gm-Message-State: AOJu0Yw1ON+661+c43GSZQSHsUBZvo2V1Y6ioc2ISNzYpYcc2ltV0fra
	s+DZ004hneBeP7Wiqrq8cGdTF4bB0bzWVw+GVEarkTh7RZM=
X-Google-Smtp-Source: AGHT+IHS2Own3fRdWYQwb2OIsgTsmwwHX29SOE1RfgDtP4QU0+zoAsmeSS5jEGwGcrxAgQ761PbER+vtPRjRGxPT11g=
X-Received: by 2002:a05:6808:1898:b0:3b9:e2a5:d64e with SMTP id
 bi24-20020a056808189800b003b9e2a5d64emr6709785oib.82.1702377293036; Tue, 12
 Dec 2023 02:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ashutosh Sharma <ashutosh.dandora4@gmail.com>
Date: Tue, 12 Dec 2023 16:04:41 +0530
Message-ID: <CADOvten7jG7KjW6W1MRd7i8_E18L0xCCaCzmZOY_vvgJhdfOSw@mail.gmail.com>
Subject: PCI device hot insert is not detected
To: linux-pci@vger.kernel.org
Cc: alex.williamson@redhat.com, helgaas@kernel.org, dwmw2@infradead.org, 
	yi.l.liu@intel.com, majosaheb@gmail.com, cohuck@redhat.com, 
	zhenzhong.duan@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a system running Ubuntu 22.04.3 LTS with kernel version
5.15.0-89-generic. There are 10 NVMe drives connected with this
system, attached to the "vfio-pci" driver.

Removed one NVMe drive (pci address 0000:83:00.0), it got unbound
successfully from "vfio-pci" driver but saw below error in the syslog.

can't change power state from D0 to D3hot (config space inaccessible)

Then after 2:30 min approx, re-inserted the same drive to the same PCI
slot. But the drive was not detected.

Kernel log:
Dec 11 23:52:05 node-4 kernel: [183519.565000] pcieport 0000:80:03.2:
pciehp: Slot(14): Link Down
Dec 11 23:52:05 node-4 kernel: [183519.565020] vfio-pci 0000:83:00.0:
Relaying device request to user (#0)
Dec 11 23:52:05 node-4 kernel: [183519.567467] vfio-pci 0000:83:00.0:
vfio_bar_restore: reset recovery - restoring BARs
Dec 11 23:52:06 node-4 kernel: [183519.629302] vfio-pci 0000:83:00.0:
can't change power state from D0 to D3hot (config space inaccessible)
Dec 11 23:52:06 node-4 kernel: [183519.639070] pci 0000:83:00.0:
Removing from iommu group 41
Dec 11 23:54:39 node-4 kernel: [183672.630191] pcieport 0000:80:03.2:
pciehp: Slot(14): Attention button pressed
Dec 11 23:54:39 node-4 kernel: [183672.630195] pcieport 0000:80:03.2:
pciehp: Slot(14) Powering on due to button press
Dec 11 23:54:44 node-4 kernel: [183677.671931] pcieport 0000:80:03.2:
pciehp: Slot(14): Card present
Dec 11 23:54:46 node-4 kernel: [183679.783922] pcieport 0000:80:03.2:
pciehp: Slot(14): No link
Dec 12 00:09:17 node-4 kernel: [184550.808980] pcieport 0000:80:03.2:
pciehp: Slot(14): Attention button pressed
Dec 12 00:09:17 node-4 kernel: [184550.808991] pcieport 0000:80:03.2:
pciehp: Slot(14) Powering on due to button press
Dec 12 00:09:22 node-4 kernel: [184556.025139] pcieport 0000:80:03.2:
pciehp: Slot(14): Card present
Dec 12 00:09:24 node-4 kernel: [184558.189151] pcieport 0000:80:03.2:
pciehp: Slot(14): No link

lspci output:
 +-[0000:80]-+-00.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Root Complex
 |           +-00.2  Advanced Micro Devices, Inc. [AMD] Milan IOMMU
 |           +-01.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
 |           +-01.1-[81]--+-00.0  Mellanox Technologies MT28908 Family
[ConnectX-6]
 |           |            \-00.1  Mellanox Technologies MT28908 Family
[ConnectX-6]
 |           +-02.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
 |           +-03.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
 |           +-03.1-[82]----00.0  Samsung Electronics Co Ltd NVMe SSD
Controller PM9A1/PM9A3/980PRO
 |           +-03.2-[83]--
 |           +-03.3-[84]--
 |           +-03.4-[85]--
 |           +-04.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
 |           +-05.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
 |           +-07.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
 |           +-07.1-[86]--+-00.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Function
 |           |            \-00.2  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PTDMA
 |           +-08.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
 |           \-08.1-[87]--+-00.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Reserved SPP
 |                        \-00.2  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PTDMA
 +-[0000:40]-+-00.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Root Complex

Since the slot 14 link was down, Although the drive was physically
present, the value of power remained 0 in the sysfs, even echo 1 to
this power was also not working here.

admin@node-4:/sys/bus/pci/slots/14$ cat address
0000:83:00
admin@node-4:~$
admin@node-4:/sys/bus/pci/slots/14$ cat power
0
admin@node-4:/sys/bus/pci/slots/14$
admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
echo: write error: Operation not permitted
admin@node-4:/sys/bus/pci/slots/14$

Dec 12 09:18:09 node-4 kernel: [217484.101870] pcieport 0000:80:03.2:
pciehp: Slot(14): Card present
Dec 12 09:18:12 node-4 kernel: [217486.272077] pcieport 0000:80:03.2:
pciehp: Slot(14): No link


But after system reboot, the drive detected successfully. So, can I
get some insight like why the drive was not detecting before the
system reboot ?

Here are some system details:

lspci tree:
admin@node-4:~$ sudo lspci -t -vvv
 +-[0000:80]-+-00.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Root Complex
 |           +-00.2  Advanced Micro Devices, Inc. [AMD] Milan IOMMU
 |           +-01.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
 |           +-01.1-[81]--+-00.0  Mellanox Technologies MT28908 Family
[ConnectX-6]
 |           |            \-00.1  Mellanox Technologies MT28908 Family
[ConnectX-6]
 |           +-02.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
 |           +-03.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
 |           +-03.1-[82]----00.0  Samsung Electronics Co Ltd NVMe SSD
Controller PM9A1/PM9A3/980PRO
 |           +-03.2-[83]----00.0  Samsung Electronics Co Ltd NVMe SSD
Controller PM9A1/PM9A3/980PRO

lspci output of the said drive:
83:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
NVMe SSD Controller PM9A1/PM9A3/980PRO (prog-if 02 [NVM Express])
        Subsystem: Samsung Electronics Co Ltd General DC NVMe PM9A3
        Physical Slot: 14
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 469
        NUMA node: 2
        IOMMU group: 41
        Region 0: Memory at f2410000 (64-bit, non-prefetchable) [size=16K]
        Expansion ROM at f2400000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
FLReset+ SlotPowerLimit 75.000W
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM not supported
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 16GT/s (ok), Width x4 (ok)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
NROPrPrP- LTR+
                         10BitTagComp+ 10BitTagReq- OBFF Not
Supported, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
LTR+ OBFF Disabled,
                         AtomicOpsCtl: ReqEn-
                LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink-
Retimer+ 2Retimers+ DRS-
                LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
                         EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: Upstream Port
        Capabilities: [b0] MSI-X: Enable+ Count=130 Masked-
                Vector table: BAR=0 offset=00003000
                PBA: BAR=0 offset=00002000
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO+ CmpltAbrt-
UnxCmplt+ RxOF+ MalfTLP+ ECRC+ UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
                AERCap: First Error Pointer: 00, ECRCGenCap+
ECRCGenEn+ ECRCChkCap+ ECRCChkEn+
                        MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [168 v1] Alternative Routing-ID Interpretation (ARI)
                ARICap: MFVC- ACS-, Next Function: 0
                ARICtl: MFVC- ACS-, Function Group: 0
        Capabilities: [178 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                LaneErrStat: 0
        Capabilities: [198 v1] Physical Layer 16.0 GT/s <?>
        Capabilities: [1bc v1] Lane Margining at the Receiver <?>
        Capabilities: [3a0 v1] Data Link Feature <?>
        Kernel driver in use: vfio-pci
        Kernel modules: nvme

lspci output of the pci port:
80:03.2 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin ? routed to IRQ 41
        NUMA node: 2
        IOMMU group: 29
        Bus: primary=80, secondary=83, subordinate=83, sec-latency=0
        I/O behind bridge: 0000f000-00000fff [disabled]
        Memory behind bridge: f2400000-f24fffff [size=1M]
        Prefetchable memory behind bridge:
00000180a0400000-00000180a05fffff [size=2M]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0
                        ExtTag+ RBE+
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
                LnkCap: Port #2, Speed 16GT/s, Width x4, ASPM L1, Exit
Latency L1 <64us
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 16GT/s (ok), Width x4 (ok)
                        TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+
HotPlug+ Surprise+
                        Slot #14, PowerLimit 75.000W; Interlock+ NoCompl-
                SltCtl: Enable: AttnBtn+ PwrFlt- MRL- PresDet-
CmdCplt+ HPIrq+ LinkChg+
                        Control: AttnInd Off, PwrInd On, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCap: CRSVisible+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible+
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
NROPrPrP- LTR+
                         10BitTagComp+ 10BitTagReq+ OBFF Not
Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS- LN System CLS Not Supported, TPHComp+
ExtTPHComp- ARIFwd+
                         AtomicOpsCap: Routing+ 32bit+ 64bit+ 128bitCAS-
                DevCtl2: Completion Timeout: 65ms to 210ms,
TimeoutDis- LTR+ OBFF Disabled, ARIFwd+
                         AtomicOpsCtl: ReqEn- EgressBlck-
                LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink-
Retimer+ 2Retimers+ DRS-
                LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
                         EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee00000  Data: 0000
        Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc.
[AMD] Starship/Matisse GPP Bridge
        Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
        Capabilities: [100 v1] Vendor Specific Information: ID=0001
Rev=1 Len=010 <?>
        Capabilities: [150 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO+ CmpltAbrt-
UnxCmplt+ RxOF+ MalfTLP+ ECRC+ UnsupReq- ACSViol+
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
                AERCap: First Error Pointer: 00, ECRCGenCap+
ECRCGenEn+ ECRCChkCap+ ECRCChkEn+
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn- NFERptEn- FERptEn-
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Capabilities: [270 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                LaneErrStat: 0
        Capabilities: [2a0 v1] Access Control Services
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans+
                ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans-
        Capabilities: [370 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2-
ASPM_L1.1+ L1_PM_Substates+
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                L1SubCtl2:
        Capabilities: [380 v1] Downstream Port Containment
                DpcCap: INT Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP
PIO Log 6, DL_ActiveErr+
                DpcCtl: Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP-
SwTrigger- DL_ActiveErr-
                DpcSta: Trigger- Reason:00 INT- RPBusy- TriggerExt:00
RP PIO ErrPtr:1f
                Source: 0000
        Capabilities: [400 v1] Data Link Feature <?>
        Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
        Capabilities: [440 v1] Lane Margining at the Receiver <?>
        Kernel driver in use: pcieport

admin@node-4:~$ sudo inxi -c 42
CPU: 64-core AMD EPYC 7713P (-MCP-) speed/min/max: 2000/1500/3721 MHz
Kernel: 5.15.0-89-generic x86_64 Up: 12m Mem: 565419.6/1019777.2 MiB (55.4%)

Regards,
Ashutosh

