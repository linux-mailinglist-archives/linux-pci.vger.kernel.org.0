Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81A4D107486
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 16:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKVPIj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 10:08:39 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:33757 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKVPIj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 10:08:39 -0500
Received: by mail-qv1-f52.google.com with SMTP id x14so3016354qvu.0
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 07:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4tL68rYok6wPa/sCglLrxXOuQnuwzuxtkgEXnxHD70=;
        b=HozjPzF+mV32iGPksUBFk25379gKYp4LOkPDfrLWVoH/p+LPr/jYHK/ZP/YhwUdZFJ
         u+0SCDGxGZSYLOjp00gwQz/wBfpQ52Qnbcm5kjz9QGj34lS6pqSbFX/7rXxuGcTSXvEf
         Jw20XDJ9Y69Z8/H2nU1D4kn93fRCuJSSqBoS+uV4vDp/zezwSHGF5p6u0T/DiZ/Q/ZXe
         OXQRzDePgxowJnEhHLJGbGJOyeLlTn6TL5Jxd0NPei/mBsbvNn3pzzr2t7aOdlywt6pw
         32l+/xkkZETj0kItpTPARdKKhHsGSfe2xcCtXMqWmPCy8lQXuqi96MofHSje84aeMf2B
         DwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4tL68rYok6wPa/sCglLrxXOuQnuwzuxtkgEXnxHD70=;
        b=ZEsJbOnDu9XrxVmlJ0XE5Hk3vnFMiD3xvMRQPmHl+zDHBBSQX3RJUwRLC9p0r14zI0
         vnDQL8YArByYtFGwE/arTLnap6xV3NlZ1gH6btwR3tS+Q72KlEto+HnsKIfOj/ZtHhDb
         q1FVBwYrTtyKvZp36XLn4jogUE8PB1jl2EISeJZ0pP0a7Kc1fub/O39W4JBPA/1otVsg
         pecCUB8Hmys4YoqKYTE9o3MTnSp6FcXFFAKJEFePueQndSpbkgDoM+DGIARHEgE/l7fq
         06fAoku+atV8NztLzQGWQrjNErNOrl1dn3Wpy0Dm9Vqf7LSGbcD46mW0Co3uLAwYW1QR
         IImA==
X-Gm-Message-State: APjAAAXaon2cf+90TCHw7fA5Y8NuRgNntzU5LdzDFwLb/2ydY+aQKaCV
        WFpq39KTjZrQsIWaa4eBlQv5psnn5NLhsCI+vhI=
X-Google-Smtp-Source: APXvYqwLfdm5Z2UMzo0KV1b9onMOsVpgdTfJTQVIswrwkFcwGU581kLS7Oze1sjjfV/nft6H+TrXzfBenCUjBRxaehM=
X-Received: by 2002:a05:6214:1051:: with SMTP id l17mr2961350qvr.60.1574435315242;
 Fri, 22 Nov 2019 07:08:35 -0800 (PST)
MIME-Version: 1.0
References: <2a381384-9d47-a7e2-679c-780950cd862d@rock-chips.com> <20191122143616.GA215594@google.com>
In-Reply-To: <20191122143616.GA215594@google.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 22 Nov 2019 10:08:14 -0500
Message-ID: <CAMdYzYpOFAVq30N+O2gOxXiRtpoHpakFg3LKq3TEZq4S6Y0y0g@mail.gmail.com>
Subject: Re: [BUG] rk3399-rockpro64 pcie synchronous external abort
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 9:36 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Nov 21, 2019 at 10:03:27AM +0800, Shawn Lin wrote:
> > From da9db487615c3687a0823c54d8d0790cbd4f79a2 Mon Sep 17 00:00:00 2001
> > From: Shawn Lin <shawn.lin@rock-chips.com>
> > Date: Thu, 21 Nov 2019 09:45:12 +0800
> > Subject: [PATCH] WFT: PCI: rockchip: play game with unsupported request from
> >  EP
> >
> > Native defect prevents this RC far from supporting any response
> > from EP which UR filed is set. Take a big hammer to take over
> > Serror handler and work around it.
>
> Peter, now that you have a way to at least boot, can you collect the
> output of "sudo lspci -vvxxx"?
>
> When we're enumerating devices, we don't know ahead of time which
> devices exist, so we try to read the Vendor ID for each *possible*
> device.  If the device doesn't exist, that config read should be
> terminated with an Unsupported Request completion (see the
> implementation note at the end of PCIe r5.0, sec 2.3.2).  So far this
> is all standard PCIe hardware behavior (and sorry if this is all
> obvious).

Everything I know about pcie I've learned from this event, so nothing
is obvious to me ;)

>
> Sec 6.2.5 and 6.2.6 show several configuration bits that affect how
> that UR is handled and ultimately reported, possibly via SERR#.  In
> most Linux systems, a UR completion does not cause an SERR#, but the
> PCI core does not manage those configuration bits directly (it
> probably *should* be more proactive about this), so this is more a
> result of how platform firmware set them than anything else.
>
> I'm speculating that you may have PCI_COMMAND_SERR and similar bits
> set, which will cause SERR# in cases where we don't see SERR# on other
> platforms.  Your lspci output should show this.
>
> Bjorn

As requested:
# lspci -vvxxx
00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI
Express Root Port (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 228
        Bus: primary=00, secondary=01, subordinate=06, sec-latency=0
        I/O behind bridge: 00000000-00000fff [size=4K]
        Memory behind bridge: None
        Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [80] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable+ 64bit+
                Address: 00000000fee30040  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
                Vector table: BAR=0 offset=00000000
                PBA: BAR=0 offset=00000008
        Capabilities: [c0] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L1,
Exit Latency L1 <8us
                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
                LnkSta: Speed 2.5GT/s (ok), Width x1 (downgraded)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd Off, Power+ Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL+ CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range B, TimeoutDis+,
LTR+, OBFF Via message ARIFwd+
                         AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
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
                RootSta: CERcvd+ MultCERcvd+ UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                ErrorSrc: ERR_COR: 0238 ERR_FATAL/NONFATAL: 0000
        Capabilities: [274 v1] Transaction Processing Hints
                Interrupt vector mode supported
                Device specific mode supported
                Steering table in TPH capability structure
        Kernel driver in use: pcieport
00: 87 1d 00 01 04 04 10 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 06 00 00 00 00 00
20: f0 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 e3 01 02 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 90 03 5a 08 00 00 00 00 00 00 00 00 00 00 00
90: 05 b0 81 01 40 00 e3 fe 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 11 c0 00 00 00 00 00 00 08 00 00 00 00 00 00 00
c0: 10 00 42 01 01 81 00 00 3f 28 00 00 41 a8 61 00
d0: 48 0c 11 10 00 00 00 00 c0 07 20 00 08 00 00 00
e0: 00 00 00 00 72 18 04 00 00 04 00 00 00 00 00 00
f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
(prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 229
        Bus: primary=01, secondary=02, subordinate=06, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: None
        Prefetchable memory behind bridge: None
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee30040  Data: 0000
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] Express (v2) Upstream Port, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
SlotPowerLimit 0.000W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <2us, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (downgraded), Width x1 (ok)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis-, LTR-, OBFF Not Supported
                         AtomicOpsCap: Routing-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                         AtomicOpsCtl: EgressBlck-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [c0] Subsystem: ASMedia Technology Inc. ASM1184e
PCIe Switch Port
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [200 v1] Advanced Error Reporting
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
                AERCap: First Error Pointer: 1f, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [300 v1] Vendor Specific Information: ID=0000
Rev=0 Len=c00 <?>
        Kernel driver in use: pcieport
00: 21 1b 84 11 04 04 10 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 01 02 06 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 e3 01 02 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 78 81 00 40 00 e3 fe 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 01 80 03 c8 08 00 00 00
80: 10 c0 52 00 21 80 00 00 30 29 10 00 12 dc 43 00
90: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 0d 00 00 00 21 1b 8f 11 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:01.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
(prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 231
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: None
        Prefetchable memory behind bridge: None
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee30040  Data: 0000
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag+ RBE+
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr+ TransPend-
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (downgraded), Width x1 (ok)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #1, PowerLimit 26.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis-, LTR-, OBFF Not Supported ARIFwd-
                         AtomicOpsCap: Routing-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                         AtomicOpsCtl: EgressBlck-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [c0] Subsystem: ASMedia Technology Inc. ASM1184e
PCIe Switch Port
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending+ InProgress-
        Capabilities: [200 v1] Advanced Error Reporting
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
                AERCap: First Error Pointer: 1f, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Kernel driver in use: pcieport
00: 21 1b 84 11 04 04 10 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 02 03 03 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 e6 01 02 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 78 81 00 40 00 e3 fe 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 01 80 03 c8 08 00 00 00
80: 10 c0 62 01 21 80 00 00 30 29 10 00 12 fc 73 01
90: 00 00 11 10 00 0d 08 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 0d 00 00 00 21 1b 8f 11 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:03.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
(prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 233
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: None
        Prefetchable memory behind bridge: None
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee30040  Data: 0000
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag+ RBE+
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq-
AuxPwr+ TransPend-
                LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <2us, L1 unlimited
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (downgraded), Width x1 (ok)
                        TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #3, PowerLimit 26.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState+
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis-, LTR-, OBFF Not Supported ARIFwd-
                         AtomicOpsCap: Routing-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                         AtomicOpsCtl: EgressBlck-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [c0] Subsystem: ASMedia Technology Inc. ASM1184e
PCIe Switch Port
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [200 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
                AERCap: First Error Pointer: 1f, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Kernel driver in use: pcieport
00: 21 1b 84 11 04 04 10 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 02 04 04 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 e8 01 02 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 78 81 00 40 00 e3 fe 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 01 80 03 c8 08 00 00 00
80: 10 c0 62 01 21 80 00 00 30 29 11 00 12 dc 73 03
90: 40 00 11 70 00 0d 18 00 00 00 00 01 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 0d 00 00 00 21 1b 8f 11 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:05.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
(prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 234
        Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: None
        Prefetchable memory behind bridge: None
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee30040  Data: 0000
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag+ RBE+
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr+ TransPend-
                LnkCap: Port #5, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (downgraded), Width x1 (ok)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #5, PowerLimit 26.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis-, LTR-, OBFF Not Supported ARIFwd-
                         AtomicOpsCap: Routing-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                         AtomicOpsCtl: EgressBlck-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [c0] Subsystem: ASMedia Technology Inc. ASM1184e
PCIe Switch Port
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending+ InProgress-
        Capabilities: [200 v1] Advanced Error Reporting
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
                AERCap: First Error Pointer: 1f, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Kernel driver in use: pcieport
00: 21 1b 84 11 04 04 10 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 02 05 05 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 e6 01 02 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 78 81 00 40 00 e3 fe 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 01 80 03 c8 08 00 00 00
80: 10 c0 62 01 21 80 00 00 30 29 10 00 12 fc 73 05
90: 00 00 11 10 00 0d 28 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 0d 00 00 00 21 1b 8f 11 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:07.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
(prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 235
        Bus: primary=02, secondary=06, subordinate=06, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: None
        Prefetchable memory behind bridge: None
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee30040  Data: 0000
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag+ RBE+
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq-
AuxPwr+ TransPend-
                LnkCap: Port #7, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <2us, L1 unlimited
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                        TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #7, PowerLimit 26.000W; Interlock-
NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState+
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis-, LTR-, OBFF Not Supported ARIFwd-
                         AtomicOpsCap: Routing-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                         AtomicOpsCtl: EgressBlck-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [c0] Subsystem: ASMedia Technology Inc. ASM1184e
PCIe Switch Port
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [200 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP+ BadDLLP+ Rollover- Timeout-
AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
                AERCap: First Error Pointer: 1f, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres-
HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Kernel driver in use: pcieport
00: 21 1b 84 11 04 04 10 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 02 06 06 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 e8 01 02 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 78 81 00 40 00 e3 fe 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 01 80 03 c8 08 00 00 00
80: 10 c0 62 01 21 80 00 00 30 29 11 00 12 dc 73 07
90: 40 00 12 70 00 0d 38 00 00 00 00 01 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 0d 00 00 00 21 1b 8f 11 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

04:00.0 VGA compatible controller: NVIDIA Corporation GK106 [GeForce
GTX 645 OEM] (rev a1) (prog-if 00 [VGA controlle
r])
        Subsystem: Pegatron GK106 [GeForce GTX 645 OEM]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 232
        Region 1: Memory at <unassigned> (64-bit, prefetchable) [disabled]
        Region 3: Memory at <unassigned> (64-bit, prefetchable) [disabled]
        Region 5: I/O ports at <unassigned> [disabled]
        Capabilities: [60] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 <64us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
FLReset- SlotPowerLimit 26.000W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
                LnkCap: Port #3, Speed 8GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <512ns, L1 <4us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (downgraded), Width x1 (downgraded)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range AB, TimeoutDis+,
LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [b4] Vendor Specific Information: Len=14 <?>
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [128 v1] Power Budgeting <?>
        Capabilities: [600 v1] Vendor Specific Information: ID=0001
Rev=1 Len=024 <?>
        Capabilities: [900 v1] Secondary PCI Express <?>
        Kernel modules: nouveau
00: de 10 c4 11 00 00 10 00 a1 00 00 03 00 00 80 00
10: 00 00 00 00 0c 00 00 00 00 00 00 00 0c 00 00 00
20: 00 00 00 00 01 00 00 00 00 00 00 00 0a 1b cc 90
30: 00 00 00 00 60 00 00 00 00 00 00 00 e8 01 00 00
40: 0a 1b cc 90 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 01 00 00 00 ce d6 23 00 00 00 00 00
60: 01 68 03 00 08 00 00 00 05 78 80 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 10 b4 02 00 e1 8d 68 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 13 00 00 00
a0: 00 00 00 00 0e 00 00 00 03 00 00 00 00 00 00 00
b0: 00 00 00 00 09 00 14 01 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

04:00.1 Audio device: NVIDIA Corporation GK106 HDMI Audio Controller (rev a1)
        Subsystem: Pegatron GK106 HDMI Audio Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin B routed to IRQ 0
        Capabilities: [60] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 <64us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
FLReset- SlotPowerLimit 26.000W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
                LnkCap: Port #3, Speed 8GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <512ns, L1 <4us
                        ClockPM+ Surprise- LLActRep- BwNot-
ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (downgraded), Width x1 (downgraded)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range AB, TimeoutDis+,
LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
00: de 10 0b 0e 00 00 10 00 a1 00 03 04 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 0a 1b cc 90
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 02 00 00
40: 0a 1b cc 90 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 ce d6 23 00 00 00 00 00
60: 01 68 03 00 08 00 00 00 05 78 80 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 10 00 02 00 e1 8d 68 00
80: 30 29 00 00 03 3d 45 03 40 00 11 10 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 13 00 00 00
a0: 00 00 00 00 0e 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

06:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9123 PCIe
SATA 6.0 Gb/s controller (rev 11) (prog-if 01 [A
HCI 1.0])
        Subsystem: Marvell Technology Group Ltd. 88SE9123 PCIe SATA
6.0 Gb/s controller
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 232
        Region 0: I/O ports at 0000
        Region 1: I/O ports at 0000
        Region 2: I/O ports at 0000
        Region 3: I/O ports at 0000
        Region 4: I/O ports at 0000
        Expansion ROM at <ignored> [disabled]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s
<1us, L1 <8us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
FLReset-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <512ns, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot-
ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (ok), Width x1 (ok)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis+, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP- BadDLLP+ Rollover- Timeout-
AdvNonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap-
ECRCGenEn- ECRCChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres-
HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
00: 4b 1b 23 91 03 00 10 00 11 01 06 01 00 00 80 00
10: 01 80 00 00 41 80 00 00 01 81 00 00 41 81 00 00
20: 01 00 80 00 00 00 90 00 00 00 00 00 4b 1b 23 91
30: 00 00 00 d0 40 00 00 00 00 00 00 00 e8 01 00 00
40: 01 50 03 40 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 00 12 00 02 87 68 00 30 20 09 00 12 3c 03 00
80: 40 00 12 10 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00
a0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

06:00.1 IDE interface: Marvell Technology Group Ltd. 88SE912x IDE
Controller (rev 11) (prog-if 8f [PCI native mode co
ntroller, supports both channels switched to ISA compatibility mode,
supports bus mastering])
        Subsystem: Marvell Technology Group Ltd. 88SE912x IDE Controller
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin B routed to IRQ 0
        Region 0: I/O ports at 0000
        Region 1: I/O ports at 0000
        Region 2: I/O ports at 0000
        Region 3: I/O ports at 0000
        Region 4: I/O ports at 0000
        Region 5: Memory at <ignored> (32-bit, non-prefetchable)
        Expansion ROM at <unassigned>
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s
<1us, L1 <8us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <512ns, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (ok), Width x1 (ok)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis+, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP- BadDLLP+ Rollover- Timeout-
AdvNonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap-
ECRCGenEn- ECRCChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
00: 4b 1b a4 91 03 00 10 00 11 8f 01 01 00 00 80 00
10: 01 82 00 00 41 82 00 00 01 83 00 00 41 83 00 00
20: 01 00 82 00 00 00 92 00 00 00 00 00 4b 1b a4 91
30: 01 00 00 00 40 00 00 00 00 00 00 00 00 02 00 00
40: 01 50 03 40 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 00 12 00 02 87 68 00 30 20 09 00 12 3c 03 00
80: 40 00 12 10 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
