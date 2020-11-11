Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5CC2AEAC9
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 09:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgKKIEF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 03:04:05 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:51944 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgKKIEA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 03:04:00 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201111080354epoutp0102111ac1066d8927be332ba74cffcbe1~GZWyosUDf0141701417epoutp01s
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 08:03:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201111080354epoutp0102111ac1066d8927be332ba74cffcbe1~GZWyosUDf0141701417epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605081834;
        bh=Swua7dlsOudovzTh/8vyh2V97HGug/r1LqH0VMcpLGg=;
        h=From:To:Subject:Date:References:From;
        b=A0I+ktxOR1u35c3Wa22RbPOxcqLqW8B9s98Ivh94X9+/M1Rr5gLdw67Rr0jnVoj2q
         D7e4Yw5kNykRdnd23Hn6aa0M2owJzGHLRPjYfEA+HcfjwHAPo2uDcjUkThr1k9j78F
         I7GqkTZXKWfPUWgaOdu5VwYlektZ/v1IaE4EW1Bg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201111080354epcas1p3451c99cfc4bea37287b2fbc37cf6ef0c~GZWyc4J_Z2088020880epcas1p3R
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 08:03:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CWHLH2hCVzMqYkh for
        <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 08:03:51 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.58.09577.4EA9BAF5; Wed, 11 Nov 2020 17:03:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201111080348epcas1p4b855295d155929cd8cb4e4361adafabb~GZWs4kP6F3137431374epcas1p4F
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 08:03:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201111080348epsmtrp2f4275577f0c1d6ec4aa7364f5cebd234~GZWs4AYgE2549525495epsmtrp2S
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 08:03:48 +0000 (GMT)
X-AuditID: b6c32a39-bfdff70000002569-32-5fab9ae4ee09
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.55.08745.4EA9BAF5; Wed, 11 Nov 2020 17:03:48 +0900 (KST)
Received: from [10.113.76.82] (unknown [10.113.76.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201111080348epsmtip1051ce4c6af20b308e475af358c103da2~GZWsvTsX_2166621666epsmtip1C
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 08:03:48 +0000 (GMT)
From:   Jonghwa Lee <jonghwa3.lee@samsung.com>
To:     linux-pci@vger.kernel.org
Subject: [Q] dwc: EP device couldn't complete DMA operation
Message-ID: <0b6246f1-82bb-b99d-c7b4-b1f8e3d9e6fb@samsung.com>
Date:   Wed, 11 Nov 2020 17:07:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmvu6TWavjDQ5ctLQ4O+84mwOjx+dN
        cgGMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBD
        lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFlgV6xYm5xaV56XrJ+blWhgYGRqZA
        hQnZGT2LepkKJrYwVTxtf8XewPjiEWMXIweHhICJxKQn/F2MXBxCAjsYJfauWMAM4UxikjjQ
        MZOli5ETyJnMJHF7GyOIDdKw81sfG0TRLkaJ7zcfQXV0M0nMnrCZGaSKTUBH4v++m+wgtoiA
        rMTHy3vYQGxhAWuJWTfugU3lFbCTOPVpL5jNIqAqcebYC7AaUYFIiZ1PX7JD1AhKnJz5BKyG
        WUBeonnrbGYIW1zi1pP5TCCLJQTmsUv8en2DBeI8F4m/6zewQtjCEq+Ob2GHsKUkPr/bywZh
        l0tMmPCVHaK5hVGiZfkaqN/sJe7fmsAKChhmAU2J9bv0IcKKEjt/z2WEWMwn8e5rDysk7Hgl
        OtqEIErUJN5dug61Skai6cpDqFUeEh/Wt0JDMVZixboLrBMY5WcheW0WktdmIXltFsIRCxhZ
        VjGKpRYU56anFhsWmCJH8SZGcCrTstzBOP3tB71DjEwcjIcYJTiYlUR4mdpWxQvxpiRWVqUW
        5ccXleakFh9iNAUG9kRmKdHkfGAyzSuJNzQ1MjY2tjAxNDM1NFQS5/2j3REvJJCeWJKanZpa
        kFoE08fEwSnVwFTRZbd8fU+23ISu/pz/J8vbGKKc5j+N+VDo+0QuUU041v/ifbEZu+1aKyZn
        /Vd51+oQqinBb1CqxPn9p9StmZKZiZa/9pw0zHLaUWDFuX5FO8OFiWVGChW7P9cnyM75x23x
        V3Weqd/FHc0l/1+L3dy0a+nMHv+pe7kdrb3//3hiMzcu+8Ft9UX+KVyMIWVcFqlRF90mP9i1
        6LjUBr8O91Op55a9bHzONFlbzXeB+0alz3uPl0jILZ767Mk28a1XAqytj76Q3nV/Qtv6jevO
        p774lCDjK1PNdbLi55kTshkHEtUaOirXd5t6cXx/P+Ol80+Zpfv6/KZIcJzZlKfF5jD94XHt
        +douTTsuKrAx6CmxFGckGmoxFxUnAgAeXY+C7gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSnO6TWavjDZ6vELY4O+84mwOjx+dN
        cgGMUVw2Kak5mWWpRfp2CVwZPYt6mQomtjBVPG1/xd7A+OIRYxcjJ4eEgInEzm99bF2MXBxC
        AjsYJba1TWKGSMhIXFx9gKmLkQPIFpY4fLgYoqaTSaL/yi8WkBo2AR2J//tusoPYIgKyEh8v
        72EDsYUFrCVm3bgHVsMrYCdx6tNeMJtFQFXizLEXbCAzRQUiJXbusIQoEZQ4OfMJWAmzgJnE
        vM0PmSFseYnmrbOhbHGJW0/mM01g5J+FpGUWkpZZSFpmIWlZwMiyilEytaA4Nz232LDAKC+1
        XK84Mbe4NC9dLzk/dxMjOBS1tHYw7ln1Qe8QIxMH4yFGCQ5mJRFeprZV8UK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5v85aGCckkJ5YkpqdmlqQWgSTZeLglGpgauaZP0/1kkp8heUfl7qZNfY8
        /881y296bvjIXnazWeH0h9OmvZ6k0rBCQuSz8URVlXMXs5v/vt731iiV89BizgAp3kkmc8Tt
        j7RZXMmbt4nxgeWWis1nklkeG9/+cV64WHu6dvgHs5WiX1amKajW2F6NOrp+z/WjPguLK66v
        tkxh2jmx+u4zL/OVzHMSXbWmbF2lkNa3yuAzw3OJrMbj3Sfn75y4L+NByFq3hiymnHC3f0oN
        SmU7v7W1srZHX5Ri7revTlwt82fF7Imnf5Ws16tZkPBKR4FFf6Wt9Nlqh/kXLbMtzMy2TtjQ
        d2Wh4d+vSro31bi/FkxrDg5Yptnm4cMfyX3S6MK9v2nf8+oclViKMxINtZiLihMBBF6CiLQC
        AAA=
X-CMS-MailID: 20201111080348epcas1p4b855295d155929cd8cb4e4361adafabb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201111080348epcas1p4b855295d155929cd8cb4e4361adafabb
References: <CGME20201111080348epcas1p4b855295d155929cd8cb4e4361adafabb@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello


I'v been struggled with enabling r8169 PCIe NIC and uPD72021 PCIe-USB 
host controller over DWC PCIe RC and need some help to solve the problem.

My SoC is Exynos and it uses Designware's IP for PCIe controller 
internally. And there are two end point devices which are ethernet 
controller IC and USB host controller IC.

The link training was done successfully. It can detect EPs and also 
loaded adequate kernel drivers after link up.

After drivers are probed, I could access all PCIe configuration space 
and checked the MSI interrupt is also working. So outbound is just fine, 
meanwhile inbound operation is not working.

For example, Ethernet Controller never raise MSI for Tx completion. All 
Tx requests are timed out. And for USB controller, there was no MSI 
after write request.

Therefore, it seems that all DMA requests directed as "to device" are 
expired and never completed.


My test environment and symptoms are following.

[ Environment ]

i) Kernel : 4.14.137+ 64bit

ii) CPU : Cortex A76 (ARMv8)

iii) EP devices : @pcie2 : Realtek RTL8111HS gigabit ethernet 
controller, @pcie3 : Renesas uPD72021 USB Host controller (*pcie0, pcie1 
lanes are disabled.)


[ Symptoms ]

i) For USB HCD, some input devices (e.g. mouse, keyboard ..) are 
working, but mounting USB stick falls into timeout error.

    [ 336.617919] sd 2:0:0:0: [sdf] Attached SCSI disk

    --- 40 secs after typing 'mount /dev/sdf1 /mnt/' ----

    [ 378.846029] xhci_hcd 0000:01:00.0: xHCI host not responding to 
stop endpoint command.

    [ 378.846167] xhci_hcd 0000:01:00.0: xHCI host controller not 
responding, assume dead

ii) For Ethernet NIC, Rx operation is working, but Tx operation is never 
done and also falls into timeout error.

    [ 151.009297] NETDEV WATCHDOG: eth1 (r8169): transmit queue 0 timed out


I suspect that DMA was not working properly for inbound operation but 
I'm not convinced.

What would you recommend to check for this kind of problem ? What should 
I check first ?

My question and guess might be humble and unclear since I'm not used to 
PCIe devices and its working.

Any comments would be helpful and be welcomed.


I attach result of lspci and PCIe log below.

<lspci>

0000:00:00.0 PCI bridge: Samsung Electronics Co Ltd Device ecee (rev 01) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 146
         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
         I/O behind bridge: 00000000-00000fff [size=4K]
         Memory behind bridge: 00000000-000fffff [size=1M]
         Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- VGA16- MAbort- >Reset- 
FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: fffffffe  Pending: 00000000
         Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag+ RBE+
                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 256 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x0, ASPM L1, Exit 
Latency L1 unlimited
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 5GT/s (downgraded), Width x1 (strange)
                         TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt+
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- 
PMEIntEna- CRSVisible+
                 RootCap: CRSVisible+
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, 
LTR+, OBFF Not Supported ARIFwd-
                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, 
LTR-, OBFF Disabled ARIFwd-
                          AtomicOpsCtl: ReqEn- EgressBlck-
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- 
SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
         Capabilities: [b0] MSI-X: Enable- Count=32 Masked-
                 Vector table: BAR=5 offset=00000000
                 PBA: BAR=5 offset=00010000
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
                 RootCmd: CERptEn- NFERptEn- FERptEn-
                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                          FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
         Capabilities: [158 v1] Secondary PCI Express <?>
         Capabilities: [1b0 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ 
ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=10us 
PortTPowerOnTime=130us
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=10us LTR1.2_Threshold=0ns
                 L1SubCtl2: T_PwrOn=10us
         Kernel driver in use: pcieport

0000:01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 
Host Controller (rev 03) (prog-if 30 [XHCI])
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupt: pin A routed to IRQ 147
         Region 0: [virtual] Memory at 40000000 (64-bit, 
non-prefetchable) [size=8K]
         Capabilities: [50] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [90] MSI-X: Enable- Count=8 Masked-
                 Vector table: BAR=0 offset=00001000
                 PBA: BAR=0 offset=00001080
         Capabilities: [a0] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 0.000W
                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, 
Exit Latency L0s <4us, L1 unlimited
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 5GT/s (ok), Width x1 (ok)
                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported, 
TimeoutDis+, LTR+, OBFF Not Supported
                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, 
LTR-, OBFF Disabled
                          AtomicOpsCtl: ReqEn-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- 
SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [150 v1] Latency Tolerance Reporting
                 Max snoop latency: 0ns
                 Max no snoop latency: 0ns
         Kernel driver in use: xhci_hcd

0001:00:00.0 PCI bridge: Samsung Electronics Co Ltd Device ecef (rev 01) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 178
         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
         I/O behind bridge: 00000000-00000fff [size=4K]
         Memory behind bridge: 00000000-000fffff [size=1M]
         Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- VGA16- MAbort- >Reset- 
FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag+ RBE+
                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 256 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x0, ASPM L1, Exit 
Latency L1 unlimited
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s (downgraded), Width x1 (strange)
                         TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- 
PMEIntEna- CRSVisible+
                 RootCap: CRSVisible+
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, 
LTR+, OBFF Not Supported ARIFwd-
                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, 
LTR-, OBFF Disabled ARIFwd-
                          AtomicOpsCtl: ReqEn- EgressBlck-
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- 
SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
         Capabilities: [b0] MSI-X: Enable- Count=32 Masked-
                 Vector table: BAR=5 offset=00000000
                 PBA: BAR=5 offset=00010000
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
                 RootCmd: CERptEn- NFERptEn- FERptEn-
                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                          FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
         Capabilities: [158 v1] Secondary PCI Express <?>
         Capabilities: [1b0 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ 
ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=10us 
PortTPowerOnTime=130us
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=10us LTR1.2_Threshold=0ns
                 L1SubCtl2: T_PwrOn=10us
         Kernel driver in use: pcieport

0001:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)
         Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 
PCI Express Gigabit Ethernet Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 128 bytes
         Interrupt: pin A routed to IRQ 179
         Region 0: I/O ports at 1000 [size=256]
         Region 2: Memory at 180004000 (64-bit, non-prefetchable) [size=4K]
         Region 4: Memory at 180000000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                 Address: 00000000c7801000  Data: 0001
         Capabilities: [70] Express (v2) Endpoint, MSI 01
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 0.000W
                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 4096 bytes
                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Exit Latency L0s unlimited, L1 <64us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, 
LTR+, OBFF Via message/WAKE#
                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, 
LTR-, OBFF Disabled
                          AtomicOpsCtl: ReqEn-
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
                 Vector table: BAR=4 offset=00000000
                 PBA: BAR=4 offset=00000800
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [140 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending- InProgress-
         Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
         Capabilities: [170 v1] Latency Tolerance Reporting
                 Max snoop latency: 0ns
                 Max no snoop latency: 0ns
         Capabilities: [178 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ 
ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=150us 
PortTPowerOnTime=150us
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=0us LTR1.2_Threshold=0ns
                 L1SubCtl2: T_PwrOn=10us
         Kernel driver in use: r8169
         Kernel modules: r8169

<kernel log>

[   18.629430] exynos-pcie 17a80000.pcie2: [exynos_pcie_poweron] start 
of poweron, pcie state: 0
[   18.629569] exynos-pcie 17a80000.pcie2: pcie clk enable, ret value = 0
[   18.629680] exynos-pcie 17a80000.pcie2: [exynos_pcie_poweron] start 
pmu bypass
[   18.640315] exynos-pcie 17a80000.pcie2: [exynos_phy_all_pwrdn_clear]
[   18.650289] exynos-pcie 17a80000.pcie2: phy clk enable, ret value = 0
[   18.660361] exynos-pcie 17a80000.pcie2: [exynos_pcie_phy_config] 
linkA:3 linkB:3
[   18.671381] exynos-pcie 17a80000.pcie2: [exynos_pcie_phy_config] 
phy_config_level:0
[   18.682718] exynos-pcie 17a80000.pcie2: lane0(0xD24)=0xf
[   18.691606] exynos-pcie 17a80000.pcie2: lane1(0x1524)=0xf
[   18.700636] exynos-pcie 17a80000.pcie2: [exynos_pcie_phy_config] 
bifurcation?(to be 0x0, 0x40) 0x40
[   18.713318] exynos-pcie 17a80000.pcie2: [exynos_pcie_phy_config] 
PCIE_MAC RST
[   18.724166] exynos-pcie 17a80000.pcie2: [exynos_pcie_establish_link] 
Set PERST to HIGH, gpio val = 1
[   18.736846] exynos-pcie 17a80000.pcie2: [exynos_pcie_setup_rc] Before 
RC BAR0 = 0x4
[   18.748116] exynos-pcie 17a80000.pcie2: [exynos_pcie_setup_rc] After 
RC BAR0 = 0x4
[   18.759316] exynos-pcie 17a80000.pcie2: [exynos_pcie_setup_rc] Before 
RC Expansion ROM = 0x0
[   18.771380] exynos-pcie 17a80000.pcie2: [exynos_pcie_setup_rc] After 
RC Expansion ROM = 0x0
[   18.783364] exynos-pcie 17a80000.pcie2: [exynos_pcie_setup_rc] 
EQ-Off(0x12001) 0x12001
[   18.794908] exynos-pcie 17a80000.pcie2: D state: 0, 126600
[   18.804115] exynos-pcie 17a80000.pcie2: [exynos_pcie_establish_link] 
Link up:3f9d011
[   18.815400] pci_bus 0000:00: scanning bus
[   18.823036] pcieport 0000:00:00.0: scanning [bus 01-ff] behind 
bridge, pass 0
[   18.833794] pci_bus 0000:01: scanning bus
[   18.841485] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
[   18.851157] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
[   18.861591] pcie_set_mps: 4993 :: v(1) pcie_mpss(0)
[   18.869988] pci 0000:01:00.0: can't set Max Payload Size to 256; if 
necessary, use "pci=pcie_bus_safe" and report a bug
[   18.884566] pci 0000:01:00.0: PME# supported from D0 D3hot
[   18.893523] pci 0000:01:00.0: PME# disabled
[   18.913351] pci_bus 0000:01: bus scan returning with max=01
[   18.913456] pcieport 0000:00:00.0: scanning [bus 01-ff] behind 
bridge, pass 1
[   18.921304] pci_bus 0000:00: bus scan returning with max=ff
[   18.930499] pcieport 0000:00:00.0: BAR 8: assigned [mem 
0x40000000-0x400fffff]
[   18.941346] pci 0000:01:00.0: BAR 0: assigned [mem 
0x40000000-0x40001fff 64bit]
[   18.952317] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x850
[   18.962534] pci 0000:01:00.0: enabling device (0000 -> 0002)
[   18.972355] pci 0000:01:00.0: Try to download FW to uPD720201
[   19.348274] pci 0000:01:00.0: FW loading is done
[   19.352034] xhci_hcd 0000:01:00.0: assign IRQ: got 106
[   19.352222] xhci_hcd 0000:01:00.0: enabling bus mastering
[   19.352327] xhci_hcd 0000:01:00.0: xHCI Host Controller
[   19.360892] xhci_hcd 0000:01:00.0: new USB bus registered, assigned 
bus number 7
[   19.377879] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 
0x100 quirks 0x0000000100000410
[   19.384684] xhci_hcd 0000:01:00.0: enabling Mem-Wr-Inval
[   19.394284] hub 7-0:1.0: USB hub found
[   19.401020] hub 7-0:1.0: 4 ports detected
[   19.409089] xhci_hcd 0000:01:00.0: xHCI Host Controller
[   19.417484] xhci_hcd 0000:01:00.0: new USB bus registered, assigned 
bus number 8
[   19.428513] xhci_hcd 0000:01:00.0: Host supports USB 3.0 SuperSpeed
[   19.438560] usb usb8: We don't know the algorithms for LPM for this 
host, disabling LPM.
[   19.450641] hub 8-0:1.0: USB hub found
[   19.457614] hub 8-0:1.0: 4 ports detected
[   19.465729] exynos-pcie 17a80000.pcie2: [exynos_pcie_msi_init] val:0x3
[   19.475394] exynos-pcie 17a80000.pcie2: Current Link Speed is GEN2 
(MAX GEN3)
[   19.486143] exynos-pcie 17a80000.pcie2: [exynos_pcie_poweron] end of 
poweron, pcie state: 3
[   20.306153] usb 8-3: new SuperSpeed USB device number 2 using xhci_hcd
[   20.331259] usb-storage 8-3:1.0: USB Mass Storage device detected
[   20.332161] scsi host2: usb-storage 8-3:1.0
[   21.345967] scsi 2:0:0:0: Direct-Access     SanDisk Extreme          
0001 PQ: 0 ANSI: 6
[   21.346799] sd 2:0:0:0: [sdf] 30651688 512-byte logical blocks: (15.7 
GB/14.6 GiB)
[   21.348294] sd 2:0:0:0: [sdf] Write Protect is off
[   21.355029] sd 2:0:0:0: [sdf] Mode Sense: 33 00 00 08
[   21.365000] sd 2:0:0:0: [sdf] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[   21.385088]  sdf: sdf1 sdf2 sdf3 sdf4
[   21.388662] sd 2:0:0:0: [sdf] Attached SCSI disk
[   27.701422] exynos-pcie 17a90000.pcie3: [exynos_pcie_poweron] start 
of poweron, pcie state: 0
[   27.701561] exynos-pcie 17a90000.pcie3: pcie clk enable, ret value = 0
[   27.701672] exynos-pcie 17a90000.pcie3: [exynos_pcie_poweron] start 
pmu bypass
[   27.712305] exynos-pcie 17a90000.pcie3: [exynos_phy_all_pwrdn_clear]
[   27.722284] exynos-pcie 17a90000.pcie3: phy clk enable, ret value = 0
[   27.732353] exynos-pcie 17a90000.pcie3: [exynos_pcie_phy_config] 
linkA:0 linkB:2
[   27.743372] exynos-pcie 17a90000.pcie3: [exynos_pcie_phy_config] 
phy_config_level:1
[   27.754720] exynos-pcie 17a90000.pcie3: [exynos_pcie_establish_link] 
Set PERST to HIGH, gpio val = 1
[   27.767451] exynos-pcie 17a90000.pcie3: [exynos_pcie_setup_rc] Before 
RC BAR0 = 0x4
[   27.778704] exynos-pcie 17a90000.pcie3: [exynos_pcie_setup_rc] After 
RC BAR0 = 0x4
[   27.789901] exynos-pcie 17a90000.pcie3: [exynos_pcie_setup_rc] Before 
RC Expansion ROM = 0x0
[   27.801968] exynos-pcie 17a90000.pcie3: [exynos_pcie_setup_rc] After 
RC Expansion ROM = 0x0
[   27.813958] exynos-pcie 17a90000.pcie3: [exynos_pcie_setup_rc] 
EQ-Off(0x12001) 0x12001
[   27.825490] exynos-pcie 17a90000.pcie3: D state: 0, d2600
[   27.834598] exynos-pcie 17a90000.pcie3: [exynos_pcie_establish_link] 
Link up:386a511
[   27.845916] pci_bus 0001:00: scanning bus
[   27.853537] pcieport 0001:00:00.0: scanning [bus 01-ff] behind 
bridge, pass 0
[   27.864300] pci_bus 0001:01: scanning bus
[   27.871990] pci 0001:01:00.0: [10ec:8168] type 00 class 0x020000
[   27.881669] pci 0001:01:00.0: reg 0x10: [io  0x0000-0x00ff]
[   27.890837] pci 0001:01:00.0: reg 0x18: [mem 0x00000000-0x00000fff 64bit]
[   27.901231] pci 0001:01:00.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit]
[   27.911643] pcie_set_mps: 4993 :: v(1) pcie_mpss(0)
[   27.920111] pci 0001:01:00.0: can't set Max Payload Size to 256; if 
necessary, use "pci=pcie_bus_safe" and report a bug
[   27.934801] pci 0001:01:00.0: supports D1 D2
[   27.942414] pci 0001:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   27.952666] pci 0001:01:00.0: PME# disabled
[   27.969401] pci_bus 0001:01: bus scan returning with max=01
[   27.969666] pcieport 0001:00:00.0: scanning [bus 01-ff] behind 
bridge, pass 1
[   27.980451] pci_bus 0001:00: bus scan returning with max=ff
[   27.989655] pcieport 0001:00:00.0: BAR 8: assigned [mem 
0x180000000-0x1800fffff]
[   28.000663] pcieport 0001:00:00.0: BAR 7: assigned [io 0x1000-0x1fff]
[   28.010827] pci 0001:01:00.0: BAR 4: assigned [mem 
0x180000000-0x180003fff 64bit]
[   28.032489] pci 0001:01:00.0: BAR 2: assigned [mem 
0x180004000-0x180004fff 64bit]
[   28.054339] pci 0001:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
[   28.076087] r8169 0001:01:00.0: assign IRQ: got 110
[   28.096323] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   28.115617] r8169 0001:01:00.0: enabling device (0000 -> 0003)
[   28.135588] r8169 0001:01:00.0: enabling Mem-Wr-Inval
[   28.165666] r8169 0001:01:00.0: enabling bus mastering
[   28.195964] r8169 0001:01:00.0 eth1: RTL8168h/8111h at 
0xffffff800c17d000, 00:e0:4c:68:00:02, XID 14100800 IRQ 179
[   28.219491] r8169 0001:01:00.0 eth1: jumbo features [frames: 9200 
bytes, tx checksumming: ko]


Thanks,

Best regards




