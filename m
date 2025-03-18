Return-Path: <linux-pci+bounces-24055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CACCA67841
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D334717B144
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 15:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9207520F080;
	Tue, 18 Mar 2025 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxakiy0j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CEC13D;
	Tue, 18 Mar 2025 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312828; cv=none; b=dfoxrk15kvwIY+QTauKTf9Nm/RukF4VTjvqkDCn2tpLbOEbYe81hgCM+0AVVoJ7hqKNquZbCCztJWbSUjxWthKRqzTOUxGnwNrclMO7uYOi2SnHAnGLHVlt9Kz4R9hD28DvWLPK/EDDGBOjC54szLReoLqOT9FQfUP0lk6zJWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312828; c=relaxed/simple;
	bh=0MaYnIsChMUN9giEuvCDNyH9h+h5TJpyAwY37+2hNrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLjG3c2/E5gnTLY99l30EbtJaKshBVO/6esGDi/j8+eJ7FhztJOjeT3WtxnBewAFsuxApRG0ZynC+BJ/TSrs6aO/GVNiU5ilMElH876/dvVVA6O3huGW5Zg2uSghkv7yosigXJ0QmeteV39E2KNCutNsGUloAo7G4wJqIYs3loA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxakiy0j; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1103674766b.3;
        Tue, 18 Mar 2025 08:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742312824; x=1742917624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W1KG5F1F4z1dCUy+3aXzIkKLhVoDYjwR6ekkTPuhhnQ=;
        b=Yxakiy0jarafyGsUVPxjxb2disAr5CCWuYtFifpaiRB1Sw5HoRU48juKtVa4yuGA+T
         jCUE6GBLtnMcOPwu0iLRNvwr384U0F0tnwFqdWSBe1S82H96UxaOpPJzXabZPZW7s/av
         2VH89zllWi6gppxol7MylmVQy07DXm0KVcVG1Ar8/Ue2xJBGbaD7ZkkAEQWb0Eg9hoTY
         uAGgCJjJCBkGnhspg/P3H4Cx7GetkaqUgiDXYMQk0g4vcBZubs71uYFiSlALMciMa7fd
         lu6Lcr9XMDe37m+TqWNDwy8bUjGz3sNTFcY3kXPp41hOqbhAPMVBTPKqUPf8oIc3WZ/y
         Sbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312824; x=1742917624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1KG5F1F4z1dCUy+3aXzIkKLhVoDYjwR6ekkTPuhhnQ=;
        b=bIkRnrM0I766FcUM4AAAZmhi4muOzkrGrKTC4jcPWeMv9u+5bN4tJC1BmZOtl0kLGx
         ULegIRcwaLtnQVGtXNW2ZmvIerDXxieLh60Dy5/Vvge46tbpcIhtj8wIBe0KgFb6GWiU
         PbRHpu6rLgzP2+sRz1SG92hUIl4aqDu/qRe/xaM97WBi7vvKhHnRCIk0vEPDra2bkW18
         NGYcShlprXjaZRmcK74/jtvVND8azb4aNMFBsL30G83Q4gJiIDQ5RICzwlcBZeuTFK53
         Sga366I/bsOy4kQY5E0Tu+g0GFZ69qGeOnHtvasF81yHCrHfmvdI3Tj4AR+Li5SyFt0/
         sJWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkZz9j+scq2nbawfY0tpI4ko7L7zrKt9uvNDrQJxGxTplF5wcGuKJlY2KlJb8FogUfI3OJFSdQS3oJZTA=@vger.kernel.org, AJvYcCX9f2DgkB3kExT+l8mkEPwsR+oQlphBmzUwpy022xmts4XwHbT6KvIkW/l+G/CzVBJ78JUjVGnOlCo2@vger.kernel.org
X-Gm-Message-State: AOJu0YymEtNkkx/VXpaB4IIh68f7//xD1fNMUvEgsskpbM1sX3fBagHy
	4d7erfogtRkj6ZH9EFuQNcr6USCp1INgtywG5Hsh9rcWY2eiNAV4FI21L8r32HROkh3Auzm8Cuq
	buDMHw+jVAqsCIK4Re54Bc3PcPMw=
X-Gm-Gg: ASbGncshS2WeTaVHT2qZ1uXWv+vxpsW5uYP9CACAtvwEPH62aTPh870rkes6P8v9QGx
	q8SEU3+6g9INkg3V65v0iEmb4HyIN/RosD0tLdp+KiRF6MctffFsoC15Efxj1XlAT07XUI9/bNm
	jQHo0fbGIdtO9C4THBbmF/xHoFzQ==
X-Google-Smtp-Source: AGHT+IGjOi33MqotC5BAUH/EsVdUZm5Z3SO+Zq7ljhmXTPC0q1+Dby3oHsVEVKqt7Q7+tl8glBRV9S8HaAvGIrlOXno=
X-Received: by 2002:a17:906:ee85:b0:ac3:26fb:f420 with SMTP id
 a640c23a62f3a-ac38d552e50mr477319566b.42.1742312823784; Tue, 18 Mar 2025
 08:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316171250.5901-1-linux.amoon@gmail.com> <20250316171250.5901-2-linux.amoon@gmail.com>
 <SHXPR01MB08630F70345E05F6124B54B8E6DF2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <CANAwSgQObUP-Jxk4o5KokA=U4RsNz5uoqvyfU-Tcmj=YNM=pYQ@mail.gmail.com> <SJ1PR11MB6249AC13C9F44545FF18A31C96DE2@SJ1PR11MB6249.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6249AC13C9F44545FF18A31C96DE2@SJ1PR11MB6249.namprd11.prod.outlook.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 18 Mar 2025 21:16:45 +0530
X-Gm-Features: AQ5f1JqF6mj6yoTt1BZm0oHB51itUqKmPG8UV7MlJehZpNJN8X1zpEVxmqCXfGE
Message-ID: <CANAwSgSOGh+csVFU175xh0BSHEv=Y83JeC8bcywko9+s6O7y=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: starfive: Simplify event doorbell bitmap
 initialization in pcie-starfive
To: Daire.McNamara@microchip.com
Cc: minda.chen@starfivetech.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com, 
	kevin.xie@starfivetech.com, Conor.Dooley@microchip.com, 
	mason.huo@starfivetech.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Daier,

On Tue, 18 Mar 2025 at 16:28, <Daire.McNamara@microchip.com> wrote:
>
> Hi Anand,
>
>
>
> Just a general point.  It might be wise to count the number of doorbell interrupts you see being generated if you apply this patch.  On the Polarfire variant of this driver, they appeared excessive to me
>
I understand the StarFive PCIe supports a PCI bridge: PLDA XpressRich-AXI,
which is integrated with USB and PCIe NVMe drivers, as mentioned in the
StarFive JH-7110 Datasheet.

[1] https://doc-en.rvspace.org/JH7110/PDF/JH7110_Datasheet.pdf

I am looking for the document for register maps for Starfive PCIe but
could not find it.

Since the PLDA  PCIe driver is generic to the PolarFire variant and
StarFive PCIe architecture,
I chose to maskout the AXI and PCIe doorbell.

I have checked before and after the doorbell interrupts, with no major
difference.

$ cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 10:     751464     533527     506565     458964 RISC-V INTC   5 Edge
    riscv-timer
 12:          3          0          0          0 SiFive PLIC 111 Edge
    17030000.power-controller
 13:         77          0          0          0 SiFive PLIC  30 Edge
    1600c000.rng
 14:          0          0          0          0 SiFive PLIC   1 Edge
    ccache_ecc
 15:          0          0          0          0 SiFive PLIC   3 Edge
    ccache_ecc
 16:          0          0          0          0 SiFive PLIC   4 Edge
    ccache_ecc
 17:          0          0          0          0 SiFive PLIC   2 Edge
    ccache_ecc
 20:          0          0          0          0 SiFive PLIC  73 Edge
    dw_axi_dmac_platform
 21:       1973          0          0          0 SiFive PLIC  32 Edge      ttyS0
 22:          0          0          0          0 SiFive PLIC  35 Edge
    10030000.i2c
 23:          0          0          0          0 SiFive PLIC  75 Edge
    dw-mci
 24:          0          0          0          0 SiFive PLIC  37 Edge
    10050000.i2c
 25:        949          0          0          0 SiFive PLIC  50 Edge
    12050000.i2c
 26:          0          0          0          0 SiFive PLIC  51 Edge
    12060000.i2c
 27:      22491          0          0          0 SiFive PLIC  74 Edge
    dw-mci
 28:          6          0          0          0 SiFive PLIC  25 Edge
    13010000.spi
 29:          0          0          0          0 SiFive PLIC  38 Edge      pl022
 41:          0          0          0          0 17020000.pinctrl  41
Edge      16020000.mmc cd
 46:          0          0          0          0 PLDA PCIe MSI   0
Edge      PCIe PME, PCIe bwctrl
 62:          0          0          0          0 PLDA PCIe MSI
134217728 Edge      PCIe PME, PCIe bwctrl
 63:       1431          0          0          0 SiFive PLIC   7 Edge      end0
 64:          0          0          0          0 SiFive PLIC   6 Edge      end0
 65:          0          0          0          0 SiFive PLIC   5 Edge      end0
 66:         13          0          0          0 PLDA PCIe MSI
134742016 Edge      nvme0q0
 67:          0          0          0          0 SiFive PLIC  78 Edge      end1
 68:          0          0          0          0 SiFive PLIC  77 Edge      end1
 69:          0          0          0          0 SiFive PLIC  76 Edge      end1
-----8<----------8<----------
 70:       7420          0          0          0 PLDA PCIe MSI
134742017 Edge      nvme0q1
 71:      15898          0          0          0 PLDA PCIe MSI
134742018 Edge      nvme0q2
 72:      16890          0          0          0 PLDA PCIe MSI
134742019 Edge      nvme0q3
 73:      44615          0          0          0 PLDA PCIe MSI
134742020 Edge      nvme0q4
-----8<----------8<----------
 75:          0          0          0          0 SiFive PLIC 108 Edge
    10100000.usb
 76:          0          0          0          0 SiFive PLIC 110 Edge
    10100000.usb
 77:      32525          0          0          0 PLDA PCIe MSI 524288
Edge      xhci_hcd
IPI0:      1834       5317       5230       3479  Rescheduling interrupts
IPI1:    175653     135005     114705     111404  Function call interrupts
IPI2:         0          0          0          0  CPU stop interrupts
IPI3:         0          0          0          0  CPU stop (for crash
dump) interrupts
IPI4:      9845       6986       6327       5227  IRQ work interrupts
IPI5:         0          0          0          0  Timer broadcast interrupts
IPI6:         0          0          0          0  CPU backtrace interrupts
IPI7:         0          0          0          0  KGDB roundup interrupts

 $ sudo lspci  -vv
0000:00:00.0 PCI bridge: PLDA XpressRich-AXI Ref Design (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 46
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: 30000000-300fffff [size=1M] [32-bit]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [80] Express (v2) Root Port (Slot+), IntMsgNum 0
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag+ RBE+ TEE-IO-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
                LnkSta: Speed 5GT/s, Width x1
                        TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #0, PowerLimit 0W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCap: CRSVisible-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Not
Supported, ExtFmt+ EETLPPrefix-
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS- LN System CLS Not Supported, TPHComp-
ExtTPHComp- ARIFwd-
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                         IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink-
Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB
de-emphasis, 0dB preshoot
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [e0] MSI: Enable+ Count=1/32 Maskable+ 64bit+
                Address: 0000000000000190  Data: 0000
                Masking: fffffffe  Pending: 00000000
        Capabilities: [f8] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Vendor Specific Information: ID=1556
Rev=1 Len=008 <?>
        Capabilities: [200 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                CESta:  RxErr+ BadTLP+ BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr+ HeaderOF-
                AERCap: First Error Pointer: 00, ECRCGenCap-
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn- NFERptEn- FERptEn-
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Kernel driver in use: pcieport

0000:01:00.0 USB controller: VIA Technologies, Inc. VL805/806 xHCI USB
3.0 Controller (rev 01) (prog-if 30 [XHCI])
        Subsystem: VIA Technologies, Inc. VL805/806 xHCI USB 3.0 Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 77
        Region 0: Memory at 30000000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [80] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot-,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] MSI: Enable+ Count=1/4 Maskable- 64bit+
                Address: 0000000000000190  Data: 0001
        Capabilities: [c4] Express (v2) Endpoint, IntMsgNum 0
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
FLReset- SlotPowerLimit 0W TEE-IO-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM not supported
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR-
                         10BitTagComp- 10BitTagReq- OBFF Not
Supported, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                         AtomicOpsCtl: ReqEn-
                         IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis+
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB
de-emphasis, 0dB preshoot
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
                        ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr- HeaderOF-
                AERCap: First Error Pointer: 00, ECRCGenCap-
ECRCGenEn- ECRCChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci

0001:00:00.0 PCI bridge: PLDA XpressRich-AXI Ref Design (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 62
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: 38000000-380fffff [size=1M] [32-bit]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [80] Express (v2) Root Port (Slot+), IntMsgNum 0
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag+ RBE+ TEE-IO-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
                LnkSta: Speed 5GT/s, Width x1
                        TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #0, PowerLimit 0W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCap: CRSVisible-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Not
Supported, ExtFmt+ EETLPPrefix-
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS- LN System CLS Not Supported, TPHComp-
ExtTPHComp- ARIFwd-
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                         IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink-
Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB
de-emphasis, 0dB preshoot
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [e0] MSI: Enable+ Count=1/32 Maskable+ 64bit+
                Address: 0000000000000190  Data: 0000
                Masking: fffffffe  Pending: 00000000
        Capabilities: [f8] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Vendor Specific Information: ID=1556
Rev=1 Len=008 <?>
        Capabilities: [200 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr+ HeaderOF-
                AERCap: First Error Pointer: 00, ECRCGenCap-
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn- NFERptEn- FERptEn-
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Kernel driver in use: pcieport

0001:01:00.0 Non-Volatile memory controller: Micron/Crucial Technology
P2 [Nick P2] / P3 / P3 Plus NVMe PCIe SSD (DRAM-less) (rev 01)
(prog-if 02 [NVM Express])
        Subsystem: Micron/Crucial Technology P2 [Nick P2] / P3 / P3
Plus NVMe PCIe SSD (DRAM-less)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 61
        Region 0: Memory at 38000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
FLReset+ SlotPowerLimit 0W TEE-IO-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
                LnkCap: Port #1, Speed 8GT/s, Width x4, ASPM L1, Exit
Latency L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (downgraded), Width x1 (downgraded)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Not
Supported, ExtFmt+ EETLPPrefix-
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                         AtomicOpsCtl: ReqEn-
                         IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB
de-emphasis, 0dB preshoot
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: Upstream Port
        Capabilities: [d0] MSI-X: Enable+ Count=9 Masked-
                Vector table: BAR=0 offset=00002000
                PBA: BAR=0 offset=00003000
        Capabilities: [e0] MSI: Enable- Count=1/8 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [f8] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [110 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=10us PortTPowerOnTime=220us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=0us LTR1.2_Threshold=0ns
                L1SubCtl2: T_PwrOn=10us
        Capabilities: [200 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP+
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr+ HeaderOF-
                AERCap: First Error Pointer: 00, ECRCGenCap-
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [300 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                LaneErrStat: 0
        Kernel driver in use: nvme
        Kernel modules: nvme

> BR
>
> Daire
>
Thanks
-Anand

