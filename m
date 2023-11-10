Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFB27E8262
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 20:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346078AbjKJTUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 14:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346179AbjKJTUA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 14:20:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3428739740
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 06:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699626905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0jbSLocU8Qu+t0aHk24/qSe4dawu00kk74v0Zid600=;
        b=hWrlm3a9XDPdDm2Vpq5VRRM4IfYZuRjPEOrhTCg+IEC993f5XOyb/EpS5MRsrw0OCkOZPQ
        o9NOSS6HB990vu0npdjCtxZd4obCV2r+C/c2v7yrLnlI6iB/af04S4iTfYtVxUOCSNmS98
        bbPj2MFn2v1wWLU7LfewSdtsAmIo6fY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-0UC3bZtFNpuzogss_RWrQw-1; Fri, 10 Nov 2023 09:35:03 -0500
X-MC-Unique: 0UC3bZtFNpuzogss_RWrQw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9e644d94d85so74167466b.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 06:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699626902; x=1700231702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0jbSLocU8Qu+t0aHk24/qSe4dawu00kk74v0Zid600=;
        b=NYsh/QRczuDfad8Myq0d5zT26tCJz3fGs0RhFRlpZlqDHXxKzdEGOOwqqhZhkxTjbP
         lmSXhUKFm3gqhssdMKT6vTvdwYeZBCyIQQprMOzsAJQDrd8/GXRYcxLiwt+uRKbSrka3
         Cev7rLwumlmaRBycukmWvSEuzNnRWlOrs/PHGp0V5Cnd8N1JHeCc+swxya5qZVFmXG7m
         KLtjCZC7PvT5u3gIqLYZs3g3ch1aXD9mB3nPSU9iYR5n4nBQBQIweE4A681sqDURK0Hm
         O3hFEvCE7vFhDKAo8i65t/tcQvC20l49LLh0MCAOqvCty4EJSknWMaZxngHgYaSRediM
         wS9w==
X-Gm-Message-State: AOJu0Yzit6CX4AJhC6sdYdN9HdIgZbJtT0ot2XnVRWUZ9YFeObTA0FXH
        iEyvI8ZgSlfh5K1enGt2KubBBLm5cXO5RHguSBCJ8ENBj/hGNVGMnpkqu2n8BWTHjrRB6kAfg8z
        KGX/wCqV+ENPBcVp6eYr6
X-Received: by 2002:a17:906:1c8e:b0:9d5:96e7:5ae1 with SMTP id g14-20020a1709061c8e00b009d596e75ae1mr2213151ejh.12.1699626902633;
        Fri, 10 Nov 2023 06:35:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9uHdtYMXLxTcY/0b1/LwOT+o0u++Jc/LSsPYHzKMr5iLqhZpN/FN2epi+fQaVQ3HJwY3CwQ==
X-Received: by 2002:a17:906:1c8e:b0:9d5:96e7:5ae1 with SMTP id g14-20020a1709061c8e00b009d596e75ae1mr2213136ejh.12.1699626902351;
        Fri, 10 Nov 2023 06:35:02 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id ti11-20020a170907c20b00b009e62bb0439bsm909806ejc.212.2023.11.10.06.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 06:35:01 -0800 (PST)
Date:   Fri, 10 Nov 2023 15:35:00 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: Work around ASMedia ASM2824 PCIe link training
 failures
Message-ID: <20231110153500.316862fd@imammedo.users.ipa.redhat.com>
In-Reply-To: <alpine.DEB.2.21.2201022100430.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201022100430.56863@angie.orcam.me.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2 Jan 2022 23:25:25 +0000 (GMT)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> Attempt to handle cases with a downstream port of the ASMedia ASM2824 
> PCIe switch where link training never completes and the link continues 
> switching between speeds indefinitely with the data link layer never 
> reaching the active state.
> 
> It has been observed with a downstream port of the ASMedia ASM2824 Gen 3 
> switch wired to the upstream port of the Pericom PI7C9X2G304 Gen 2 
> switch, using a Delock Riser Card PCI Express x1 > 2 x PCIe x1 device, 
> P/N 41433, wired to a SiFive HiFive Unmatched board.  In this setup the 
> switches are supposed to negotiate the link speed of preferably 5.0GT/s, 
> falling back to 2.5GT/s.

It looks like I might have similar issue on EPYC system with this switch.

In my case ASM2824 switch board connected to EPYC's root port (via SlimSAS 8i cable and on upstream site it negotiates expected 8GT/s x8) 
were supposed to provide 10x slots with PCIe x1 Gen3 links.
However lspci shows that link is capped at 2.5GT/s and NVME plugged into one of
the slots is downgraded to 2.5GT/s.

I wonder if it could be fixed to get expected 8GT/s per lane.

Downstream port in question:

07:00.0 PCI bridge: ASMedia Technology Inc. ASM2824 PCIe Gen3 Packet Switch (rev 01) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 35
IOMMU group: 20
Bus: primary=07, secondary=08, subordinate=08, sec-latency=0
I/O behind bridge: [disabled] [32-bit]
Memory behind bridge: ee700000-ee7fffff [size=1M] [32-bit]
Prefetchable memory behind bridge: [disabled] [64-bit]
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00000 Data: 0000
Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
DevCap: MaxPayload 512 bytes, PhantFunc 0
ExtTag+ RBE+
DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x2, ASPM L1, Exit Latency L1 <64us
ClockPM+ Surprise+ LLActRep+ BwNot+ ASPMOptComp+
LnkCtl: ASPM Disabled; Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1
TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
Slot #0, PowerLimit 0W; Interlock- NoCompl-
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState-
DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
FRS- ARIFwd+
AtomicOpsCap: Routing-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled, ARIFwd-
AtomicOpsCtl: EgressBlck-
LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis+, Selectable De-emphasis: -3.5dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
Retimer- 2Retimers- CrosslinkRes: unsupported
Capabilities: [c0] Subsystem: Device 0000:0000
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
Capabilities: [140 v1] Power Budgeting <?>
Capabilities: [160 v1] Latency Tolerance Reporting
Max snoop latency: 0ns
Max no snoop latency: 0ns
Capabilities: [180 v1] Multicast
McastCap: MaxGroups 64, ECRCRegen-
McastCtl: NumGroups 1, Enable-
McastBAR: IndexPos 0, BaseAddr 0000000000000000
McastReceiveVec: 0000000000000000
McastBlockAllVec: 0000000000000000
McastBlockUntransVec: 0000000000000000
McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 0000000000000000
Capabilities: [1c0 v1] Secondary PCI Express
LnkCtl3: LnkEquIntrruptEn- PerformEqu-
LaneErrStat: 0
Capabilities: [200 v1] Vendor Specific Information: ID=001a Rev=0 Len=000 <?>
Kernel driver in use: pcieport

NVME:

08:00.0 Non-Volatile memory controller: Silicon Motion, Inc. SM2263EN/SM2263XT (DRAM-less) NVMe SSD Controllers (rev 03) (prog-if 02 [NVM Express])
Subsystem: Biwin Storage Technology Co., Ltd. Device 2263
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 34
NUMA node: 0
IOMMU group: 20
Region 0: Memory at ee700000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit+
Address: 0000000000000000 Data: 0000
Masking: 00000000 Pending: 00000000
Capabilities: [70] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W
DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <8us
ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s (downgraded), Width x1 (downgraded)
TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
FRS- TPHComp- ExtTPHComp-
AtomicOpsCap: 32bit- 64bit- 128bitCAS-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
AtomicOpsCtl: ReqEn-
LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
Retimer- 2Retimers- CrosslinkRes: unsupported
Capabilities: [b0] MSI-X: Enable+ Count=16 Masked-
Vector table: BAR=0 offset=00002000
PBA: BAR=0 offset=00002100
Capabilities: [100 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
Capabilities: [158 v1] Secondary PCI Express
LnkCtl3: LnkEquIntrruptEn- PerformEqu-
LaneErrStat: 0
Capabilities: [178 v1] Latency Tolerance Reporting
Max snoop latency: 0ns
Max no snoop latency: 0ns
Capabilities: [180 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
T_CommonMode=0us LTR1.2_Threshold=0ns
L1SubCtl2: T_PwrOn=10us
Kernel driver in use: nvme
Kernel modules: nvme


full lspci output:
https://pastebin.mozilla.org/Kb8Fs5Mj




