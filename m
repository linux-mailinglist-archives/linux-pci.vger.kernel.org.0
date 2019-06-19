Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35DA84B7BB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 14:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfFSMMy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 19 Jun 2019 08:12:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43841 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSMMy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 08:12:54 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so37493974ios.10
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 05:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wAC6dTEdKpUnZYCOPTz4eJNBAqBLkErVVmWS93s4/zg=;
        b=XiHnT0Ev0ox6icOPTdQJyisoA5dBrJVT5hHcayyyhXt/DTh+leUBoksQtuo8Umqe+M
         nbmbP8P+2DTSxtNsUOi/VKXKSzF9EMHBNiiVfQajrkdx3IzZG0wTxIBCyBUutiswL0hZ
         6MPfIPWG2n+yxyDEPzrhEg1NBXCAAuLannN5+lBRqHB/r4wWnsYAxoZbyFgGkhXQqJVx
         5XtJtfM9P8H66qoCJOmSUO09lv0PVubmNUkyM5ecU8Gq1vunniSqpYJrqP2KHmvGv28l
         6JnbuaslnFvTTvye4Z6SC4ZPcoVta1ARJwLxIz8Yw+vZvzMFE1JLZD5YS8JI/gBaNapr
         s+OA==
X-Gm-Message-State: APjAAAU9nbh/T+OA+YOR8ezNyvrNUmuA8Agd126JWo8mLKkSG7f2XqJc
        iGDjfzMAWDEKWsmfmScPsUbsscX4dOhO2CjZR5cJyg==
X-Google-Smtp-Source: APXvYqyCZoMFdQsM7cyaQca/D3k4KtSH4tx+DYxtbt7Q6Irkbzef6egkl3mUWGn+HkNFChmc4mjvAOPxjgGlTdIIDFI=
X-Received: by 2002:a6b:5815:: with SMTP id m21mr10085636iob.171.1560946371706;
 Wed, 19 Jun 2019 05:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190507201245.9295-5-kherbst@redhat.com> <20190520211933.GA57618@google.com>
 <CACO55tsHi+4gRMC=XqOypJttztKNe5oKxxk0eqEVxGZoMzS+4Q@mail.gmail.com>
 <20190521131033.GC57618@google.com> <CACO55ts=u7aZ1uZYJ4eMZPvSycwYpzr-W6Xn8oDBLrxsivLOAw@mail.gmail.com>
 <20190521141317.GD57618@google.com> <CACO55tvVzugMpFFNbnxgsfkXNXcN-PqoaXkjWHL0et=fAcThhg@mail.gmail.com>
 <CACO55tv2nnAxNAr=DTd2EzQXmQ5KLT1TR04J+WhVsnkV2_gBnw@mail.gmail.com>
 <CACO55tsdev_gXMRcRBtxs0ee3exoxRFS7z-di6PD87FWJyb=yw@mail.gmail.com>
 <CACO55ttv4f_XkCgOdCbnuBiXqYjs9p1Q2LEczv7FNYxogqWTfg@mail.gmail.com>
 <20190603181025.GD189360@google.com> <CACO55ts8fmdaN=+ca_=dv-mKiMHnLL0dE9=HsRkQDpPnQ1Njuw@mail.gmail.com>
In-Reply-To: <CACO55ts8fmdaN=+ca_=dv-mKiMHnLL0dE9=HsRkQDpPnQ1Njuw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 19 Jun 2019 14:12:40 +0200
Message-ID: <CACO55tt-UmzeHRqsXz47vjoYDwzo3TrgQ7Bb+8dixbQ9GW7x1A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pci: save the boot pcie link speed and restore it
 on fini
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ohh nvm. It was a mistake on my end. Sorry for the noise

On Wed, Jun 19, 2019 at 2:07 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> Hi Bjorn,
>
> I was playing around with some older information again (write into the
> PCI config to put the card into d3 state). And there is something
> which made me very curious:
> If I put the card manually into any other state besides D0 via the
> 0x64 pci config register, the card just dies and pci core seems to
> expect this to not happen. pci_raw_set_power_state has this
> "pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);" call,
> and reads the value back later, but if the card is already gone, maybe
> we can't do this for nvidia GPUs?
>
> No idea why I didn't played around more with that register, but if the
> card already dies there then this kind of shows there is indeed an
> issue on a PCI level, no?
>
> On Mon, Jun 3, 2019 at 8:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Mon, Jun 03, 2019 at 03:18:56PM +0200, Karol Herbst wrote:
> > > @bjorn: any further ideas? Otherwise I'd like to just go ahead and fix
> > > this issue inside Nouveau and leave it there until we have a better
> > > understanding or non Nouveau cases of this issue.
> >
> > Nope, I have no more ideas.
> >
> > > On Tue, May 21, 2019 at 7:48 PM Karol Herbst <kherbst@redhat.com> wrote:
> > > >
> > > > doing the same on the bridge controller with my workarounds applied:
> > > >
> > > > please note some differences:
> > > > LnkSta: Speed 8GT/s (ok) vs Speed 2.5GT/s (downgraded)
> > > > SltSta: PresDet+ vs PresDet-
> > > > LnkSta2: Equalization stuff
> > > > Virtual channel: NegoPending- vs NegoPending+
> > > >
> > > > both times I executed lspci while the GPU was still suspended.
> > > >
> > > > 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th
> > > > Gen Core Processor PCIe Controller (x16) (rev 05) (prog-if 00 [Normal
> > > > decode])
> > > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > > >         Latency: 0
> > > >         Interrupt: pin A routed to IRQ 16
> > > >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> > > >         I/O behind bridge: 0000e000-0000efff [size=4K]
> > > >         Memory behind bridge: ec000000-ed0fffff [size=17M]
> > > >         Prefetchable memory behind bridge:
> > > > 00000000c0000000-00000000d1ffffff [size=288M]
> > > >         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > > > <TAbort- <MAbort+ <SERR- <PERR-
> > > >         BridgeCtl: Parity- SERR- NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
> > > >                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > > >         Capabilities: [88] Subsystem: Dell Device 07be
> > > >         Capabilities: [80] Power Management version 3
> > > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > > >                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > > >         Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
> > > >                 Address: 00000000  Data: 0000
> > > >         Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
> > > >                 DevCap: MaxPayload 256 bytes, PhantFunc 0
> > > >                         ExtTag- RBE+
> > > >                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > > >                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > > >                         MaxPayload 256 bytes, MaxReadReq 128 bytes
> > > >                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > > > AuxPwr- TransPend-
> > > >                 LnkCap: Port #2, Speed 8GT/s, Width x16, ASPM L0s L1,
> > > > Exit Latency L0s <256ns, L1 <8us
> > > >                         ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
> > > >                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> > > >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > > >                 LnkSta: Speed 8GT/s (ok), Width x16 (ok)
> > > >                         TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt+
> > > >                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
> > > > HotPlug- Surprise-
> > > >                         Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
> > > >                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
> > > > CmdCplt- HPIrq- LinkChg-
> > > >                         Control: AttnInd Unknown, PwrInd Unknown,
> > > > Power- Interlock-
> > > >                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
> > > > PresDet+ Interlock-
> > > >                         Changed: MRL- PresDet+ LinkState-
> > > >                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> > > > PMEIntEna- CRSVisible-
> > > >                 RootCap: CRSVisible-
> > > >                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> > > >                 DevCap2: Completion Timeout: Not Supported,
> > > > TimeoutDis-, LTR+, OBFF Via WAKE# ARIFwd-
> > > >                          AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
> > > >                 DevCtl2: Completion Timeout: 50us to 50ms,
> > > > TimeoutDis-, LTR+, OBFF Via WAKE# ARIFwd-
> > > >                          AtomicOpsCtl: ReqEn- EgressBlck-
> > > >                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
> > > >                          Transmit Margin: Normal Operating Range,
> > > > EnterModifiedCompliance- ComplianceSOS-
> > > >                          Compliance De-emphasis: -6dB
> > > >                 LnkSta2: Current De-emphasis Level: -6dB,
> > > > EqualizationComplete+, EqualizationPhase1+
> > > >                          EqualizationPhase2+, EqualizationPhase3+,
> > > > LinkEqualizationRequest-
> > > >         Capabilities: [100 v1] Virtual Channel
> > > >                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
> > > >                 Arb:    Fixed- WRR32- WRR64- WRR128-
> > > >                 Ctrl:   ArbSelect=Fixed
> > > >                 Status: InProgress-
> > > >                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> > > >                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > > >                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> > > >                         Status: NegoPending- InProgress-
> > > >         Capabilities: [140 v1] Root Complex Link
> > > >                 Desc:   PortNumber=02 ComponentID=01 EltType=Config
> > > >                 Link0:  Desc:   TargetPort=00 TargetComponent=01
> > > > AssocRCRB- LinkType=MemMapped LinkValid+
> > > >                         Addr:   00000000fed19000
> > > >         Capabilities: [d94 v1] Secondary PCI Express <?>
> > > >         Kernel driver in use: pcieport
> > > > 00: 86 80 01 19 07 00 10 00 05 00 04 06 00 00 81 00
> > > > 10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 e0 00 20
> > > > 20: 00 ec 00 ed 01 c0 f1 d1 00 00 00 00 00 00 00 00
> > > > 30: 00 00 00 00 88 00 00 00 00 00 00 00 ff 01 10 00
> > > > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > 70: 00 00 00 00 00 00 00 00 00 62 17 00 00 00 00 0a
> > > > 80: 01 90 03 c8 08 00 00 00 0d 80 00 00 28 10 be 07
> > > > 90: 05 a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > a0: 10 00 42 01 01 80 00 00 20 00 00 00 03 ad 61 02
> > > > b0: 40 00 03 d1 80 25 0c 00 00 00 48 00 00 00 00 00
> > > > c0: 00 00 00 00 80 0b 08 00 00 64 00 00 0e 00 00 00
> > > > d0: 43 00 1e 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > f0: 00 00 00 84 4e 01 01 20 00 00 00 00 e0 00 10 00
> > > >
> > > > On Tue, May 21, 2019 at 7:35 PM Karol Herbst <kherbst@redhat.com> wrote:
> > > > >
> > > > > was able to get the lspci prints via ssh. Machine rebooted
> > > > > automatically each time though.
> > > > >
> > > > > relevant dmesg:
> > > > > kernel: nouveau 0000:01:00.0: Refused to change power state, currently in D3
> > > > > kernel: nouveau 0000:01:00.0: Refused to change power state, currently in D3
> > > > > kernel: nouveau 0000:01:00.0: Refused to change power state, currently in D3
> > > > > kernel: nouveau 0000:01:00.0: tmr: stalled at ffffffffffffffff
> > > > >
> > > > > (last one is a 64 bit mmio read to get the on GPU timer value)
> > > > >
> > > > > # lspci -vvxxx -s 0:01.00
> > > > > 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th
> > > > > Gen Core Processor PCIe Controller (x16) (rev 05) (prog-if 00 [Normal
> > > > > decode])
> > > > >        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > > ParErr- Stepping- SERR- FastB2B- DisINTx-
> > > > >        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > > > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > > > >        Latency: 0
> > > > >        Interrupt: pin A routed to IRQ 16
> > > > >        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> > > > >        I/O behind bridge: 0000e000-0000efff [size=4K]
> > > > >        Memory behind bridge: ec000000-ed0fffff [size=17M]
> > > > >        Prefetchable memory behind bridge:
> > > > > 00000000c0000000-00000000d1ffffff [size=288M]
> > > > >        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > > > > <TAbort- <MAbort+ <SERR- <PERR-
> > > > >        BridgeCtl: Parity- SERR- NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
> > > > >                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > > > >        Capabilities: [88] Subsystem: Dell Device 07be
> > > > >        Capabilities: [80] Power Management version 3
> > > > >                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > > > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > > > >                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > > > >        Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
> > > > >                Address: 00000000  Data: 0000
> > > > >        Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
> > > > >                DevCap: MaxPayload 256 bytes, PhantFunc 0
> > > > >                        ExtTag- RBE+
> > > > >                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > > > >                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > > > >                        MaxPayload 256 bytes, MaxReadReq 128 bytes
> > > > >                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > > > > AuxPwr- TransPend-
> > > > >                LnkCap: Port #2, Speed 8GT/s, Width x16, ASPM L0s L1,
> > > > > Exit Latency L0s <256ns, L1 <8us
> > > > >                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
> > > > >                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> > > > >                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > > > >                LnkSta: Speed 2.5GT/s (downgraded), Width x16 (ok)
> > > > >                        TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt+
> > > > >                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
> > > > > HotPlug- Surprise-
> > > > >                        Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
> > > > >                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> > > > > HPIrq- LinkChg-
> > > > >                        Control: AttnInd Unknown, PwrInd Unknown,
> > > > > Power- Interlock-
> > > > >                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
> > > > > PresDet- Interlock-
> > > > >                        Changed: MRL- PresDet+ LinkState-
> > > > >                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> > > > > PMEIntEna- CRSVisible-
> > > > >                RootCap: CRSVisible-
> > > > >                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> > > > >                DevCap2: Completion Timeout: Not Supported,
> > > > > TimeoutDis-, LTR+, OBFF Via WAKE# ARIFwd-
> > > > >                         AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
> > > > >                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,
> > > > > LTR+, OBFF Via WAKE# ARIFwd-
> > > > >                         AtomicOpsCtl: ReqEn- EgressBlck-
> > > > >                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
> > > > >                         Transmit Margin: Normal Operating Range,
> > > > > EnterModifiedCompliance- ComplianceSOS-
> > > > >                         Compliance De-emphasis: -6dB
> > > > >                LnkSta2: Current De-emphasis Level: -6dB,
> > > > > EqualizationComplete-, EqualizationPhase1-
> > > > >                         EqualizationPhase2-, EqualizationPhase3-,
> > > > > LinkEqualizationRequest-
> > > > >        Capabilities: [100 v1] Virtual Channel
> > > > >                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
> > > > >                Arb:    Fixed- WRR32- WRR64- WRR128-
> > > > >                Ctrl:   ArbSelect=Fixed
> > > > >                Status: InProgress-
> > > > >                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> > > > >                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> > > > >                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> > > > >                        Status: NegoPending+ InProgress-
> > > > >        Capabilities: [140 v1] Root Complex Link
> > > > >                Desc:   PortNumber=02 ComponentID=01 EltType=Config
> > > > >                Link0:  Desc:   TargetPort=00 TargetComponent=01
> > > > > AssocRCRB- LinkType=MemMapped LinkValid+
> > > > >                        Addr:   00000000fed19000
> > > > >        Capabilities: [d94 v1] Secondary PCI Express <?>
> > > > >        Kernel driver in use: pcieport
> > > > > 00: 86 80 01 19 07 00 10 00 05 00 04 06 00 00 81 00
> > > > > 10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 e0 00 20
> > > > > 20: 00 ec 00 ed 01 c0 f1 d1 00 00 00 00 00 00 00 00
> > > > > 30: 00 00 00 00 88 00 00 00 00 00 00 00 ff 01 10 00
> > > > > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > 70: 00 00 00 00 00 00 00 00 00 62 17 00 00 00 00 0a
> > > > > 80: 01 90 03 c8 08 00 00 00 0d 80 00 00 28 10 be 07
> > > > > 90: 05 a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > a0: 10 00 42 01 01 80 00 00 20 00 00 00 03 ad 61 02
> > > > > b0: 40 00 01 d1 80 25 0c 00 00 00 08 00 00 00 00 00
> > > > > c0: 00 00 00 00 80 0b 08 00 00 64 00 00 0e 00 00 00
> > > > > d0: 43 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > f0: 00 40 01 00 4e 01 01 22 00 00 00 00 e0 00 10 00
> > > > >
> > > > > lspci -vvxxx -s 1:00.00
> > > > > 01:00.0 3D controller: NVIDIA Corporation GP107M [GeForce GTX 1050
> > > > > Mobile] (rev ff) (prog-if ff)
> > > > >        !!! Unknown header type 7f
> > > > >        Kernel driver in use: nouveau
> > > > >        Kernel modules: nouveau
> > > > > 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > >
> > > > > On Tue, May 21, 2019 at 4:30 PM Karol Herbst <kherbst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, May 21, 2019 at 4:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, May 21, 2019 at 03:28:48PM +0200, Karol Herbst wrote:
> > > > > > > > On Tue, May 21, 2019 at 3:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > On Tue, May 21, 2019 at 12:30:38AM +0200, Karol Herbst wrote:
> > > > > > > > > > On Mon, May 20, 2019 at 11:20 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > > > On Tue, May 07, 2019 at 10:12:45PM +0200, Karol Herbst wrote:
> > > > > > > > > > > > Apperantly things go south if we suspend the device with a different PCIE
> > > > > > > > > > > > link speed set than it got booted with. Fixes runtime suspend on my gp107.
> > > > > > > > > > > >
> > > > > > > > > > > > This all looks like some bug inside the pci subsystem and I would prefer a
> > > > > > > > > > > > fix there instead of nouveau, but maybe there is no real nice way of doing
> > > > > > > > > > > > that outside of drivers?
> > > > > > > > > > >
> > > > > > > > > > > I agree it would be nice to fix this in the PCI core if that's
> > > > > > > > > > > feasible.
> > > > > > > > > > >
> > > > > > > > > > > It looks like this driver changes the PCIe link speed using some
> > > > > > > > > > > device-specific mechanism.  When we suspend, we put the device in
> > > > > > > > > > > D3cold, so it loses all its state.  When we resume, the link probably
> > > > > > > > > > > comes up at the boot speed because nothing did that device-specific
> > > > > > > > > > > magic to change it, so you probably end up with the link being slow
> > > > > > > > > > > but the driver thinking it's configured to be fast, and maybe that
> > > > > > > > > > > combination doesn't work.
> > > > > > > > > > >
> > > > > > > > > > > If it requires something device-specific to change that link speed, I
> > > > > > > > > > > don't know how to put that in the PCI core.  But maybe I'm missing
> > > > > > > > > > > something?
> > > > > > > > > > >
> > > > > > > > > > > Per the PCIe spec (r4.0, sec 1.2):
> > > > > > > > > > >
> > > > > > > > > > >   Initialization – During hardware initialization, each PCI Express
> > > > > > > > > > >   Link is set up following a negotiation of Lane widths and frequency
> > > > > > > > > > >   of operation by the two agents at each end of the Link. No firmware
> > > > > > > > > > >   or operating system software is involved.
> > > > > > > > > > >
> > > > > > > > > > > I have been assuming that this means device-specific link speed
> > > > > > > > > > > management is out of spec, but it seems pretty common that devices
> > > > > > > > > > > don't come up by themselves at the fastest possible link speed.  So
> > > > > > > > > > > maybe the spec just intends that devices can operate at *some* valid
> > > > > > > > > > > speed.
> > > > > > > > > >
> > > > > > > > > > I would expect that devices kind of have to figure out what they can
> > > > > > > > > > operate on and the operating system kind of just checks what the
> > > > > > > > > > current state is and doesn't try to "restore" the old state or
> > > > > > > > > > something?
> > > > > > > > >
> > > > > > > > > The devices at each end of the link negotiate the width and speed of
> > > > > > > > > the link.  This is done directly by the hardware without any help from
> > > > > > > > > the OS.
> > > > > > > > >
> > > > > > > > > The OS can read the current link state (Current Link Speed and
> > > > > > > > > Negotiated Link Width, both in the Link Status register).  The OS has
> > > > > > > > > very little control over that state.  It can't directly restore the
> > > > > > > > > state because the hardware has to negotiate a width & speed that
> > > > > > > > > result in reliable operation.
> > > > > > > > >
> > > > > > > > > > We don't do anything in the driver after the device was suspended. And
> > > > > > > > > > the 0x88000 is a mirror of the PCI config space, but we also got some
> > > > > > > > > > PCIe stuff at 0x8c000 which is used by newer GPUs for gen3 stuff
> > > > > > > > > > essentially. I have no idea how much of this is part of the actual pci
> > > > > > > > > > standard and how much is driver specific. But the driver also wants to
> > > > > > > > > > have some control over the link speed as it's tight to performance
> > > > > > > > > > states on GPU.
> > > > > > > > >
> > > > > > > > > As far as I'm aware, there is no generic PCIe way for the OS to
> > > > > > > > > influence the link width or speed.  If the GPU driver needs to do
> > > > > > > > > that, it would be via some device-specific mechanism.
> > > > > > > > >
> > > > > > > > > > The big issue here is just, that the GPU boots with 8.0, some on-gpu
> > > > > > > > > > init mechanism decreases it to 2.5. If we suspend, the GPU or at least
> > > > > > > > > > the communication with the controller is broken. But if we set it to
> > > > > > > > > > the boot speed, resuming the GPU just works. So my assumption was,
> > > > > > > > > > that _something_ (might it be the controller or the pci subsystem)
> > > > > > > > > > tries to force to operate on an invalid link speed and because the
> > > > > > > > > > bridge controller is actually powered down as well (as all children
> > > > > > > > > > are in D3cold) I could imagine that something in the pci subsystem
> > > > > > > > > > actually restores the state which lets the controller fail to
> > > > > > > > > > establish communication again?
> > > > > > > > >
> > > > > > > > >   1) At boot-time, the Port and the GPU hardware negotiate 8.0 GT/s
> > > > > > > > >      without OS/driver intervention.
> > > > > > > > >
> > > > > > > > >   2) Some mechanism reduces link speed to 2.5 GT/s.  This probably
> > > > > > > > >      requires driver intervention or at least some ACPI method.
> > > > > > > >
> > > > > > > > there is no driver intervention and Nouveau doesn't care at all. It's
> > > > > > > > all done on the GPU. We just upload a script and some firmware on to
> > > > > > > > the GPU. The script runs then on the PMU inside the GPU and this
> > > > > > > > script also causes changing the PCIe link settings. But from a Nouveau
> > > > > > > > point of view we don't care about the link before or after that script
> > > > > > > > was invoked. Also there is no ACPI method involved.
> > > > > > > >
> > > > > > > > But if there is something we should notify pci core about, maybe
> > > > > > > > that's something we have to do then?
> > > > > > >
> > > > > > > I don't think there's anything the PCI core could do with that
> > > > > > > information anyway.  The PCI core doesn't care at all about the link
> > > > > > > speed, and it really can't influence it directly.
> > > > > > >
> > > > > > > > >   3) Suspend puts GPU into D3cold (powered off).
> > > > > > > > >
> > > > > > > > >   4) Resume restores GPU to D0, and the Port and GPU hardware again
> > > > > > > > >      negotiate 8.0 GT/s without OS/driver intervention, just like at
> > > > > > > > >      initial boot.
> > > > > > > >
> > > > > > > > No, that negotiation fails apparently as any attempt to read anything
> > > > > > > > from the device just fails inside pci core. Or something goes wrong
> > > > > > > > when resuming the bridge controller.
> > > > > > >
> > > > > > > I'm surprised the negotiation would fail even after a power cycle of
> > > > > > > the device.  But if you can avoid the issue by running another script
> > > > > > > on the PMU before suspend, that's probably what you'll have to do.
> > > > > > >
> > > > > >
> > > > > > there is none as far as we know. Or at least nothing inside the vbios.
> > > > > > We still have to get signed PMU firmware images from Nvidia for full
> > > > > > support, but this still would be a hacky issue as we would depend on
> > > > > > those then (and without having those in  redistributable form, there
> > > > > > isn't much we can do about except fixing it on the kernel side).
> > > > > >
> > > > > > > > >   5) Now the driver thinks the GPU is at 2.5 GT/s but it's actually at
> > > > > > > > >      8.0 GT/s.
> > > > > > > >
> > > > > > > > what is actually meant by "driver" here? The pci subsystem or Nouveau?
> > > > > > >
> > > > > > > I was thinking Nouveau because the PCI core doesn't care about the
> > > > > > > link speed.
> > > > > > >
> > > > > > > > > Without knowing more about the transition to 2.5 GT/s, I can't guess
> > > > > > > > > why the GPU wouldn't work after resume.  From a PCIe point of view,
> > > > > > > > > the link is supposed to work and the device should be reachable
> > > > > > > > > independent of the link speed.  But maybe there's some weird
> > > > > > > > > dependency between the GPU and the driver here.
> > > > > > > >
> > > > > > > > but the device isn't reachable at all, not even from the pci
> > > > > > > > subsystem. All reads fail/return a default error value (0xffffffff).
> > > > > > >
> > > > > > > Are these PCI config reads that return 0xffffffff?  Or MMIO reads?
> > > > > > > "lspci -vvxxxx" of the bridge and the GPU might have a clue about
> > > > > > > whether a PCI error occurred.
> > > > > > >
> > > > > >
> > > > > > that's kind of problematic as it might just lock up my machine... but
> > > > > > let me try that.
> > > > > >
> > > > > > > > > It sounds like things work if you return to 8.0 GT/s before suspend,
> > > > > > > > > things work.  That would make sense to me because then the driver's
> > > > > > > > > idea of the link state after resume would match the actual state.
> > > > > > > >
> > > > > > > > depends on what is meant by the driver here. Inside Nouveau we don't
> > > > > > > > care one bit about the current link speed, so I assume you mean
> > > > > > > > something inside the pci core code?
> > > > > > > >
> > > > > > > > > But I don't see a way to deal with this in the PCI core.  The PCI core
> > > > > > > > > does save and restore most of the architected config space around
> > > > > > > > > suspend/resume, but since this appears to be a device-specific thing,
> > > > > > > > > the PCI core would have no idea how to save/restore it.
> > > > > > > >
> > > > > > > > if we assume that the negotiation on a device level works as intended,
> > > > > > > > then I would expect this to be a pci core issue, which might actually
> > > > > > > > be not fixable there. But if it's not, then we would have to put
> > > > > > > > something like that inside the runpm documentation to tell drivers
> > > > > > > > they have to do something about it.
> > > > > > > >lspci -vvxxxx
> > > > > > > > But again, for me it just sounds like the negotiation on the device
> > > > > > > > level fails or something inside pci core messes it up.
> > > > > > >
> > > > > > > To me it sounds like the PMU script messed something up, and the PCI
> > > > > > > core has no way to know what that was or how to fix it.
> > > > > > >
> > > > > >
> > > > > > sure, I am mainly wondering why it doesn't work after we power cycled
> > > > > > the GPU and the host bridge controller, because no matter what the
> > > > > > state was before, we have to reprobe instead of relying on a known
> > > > > > state, no?
> > > > > >
> > > > > > > > > > > > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > > > > > > > > > > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drm/nouveau/include/nvkm/subdev/pci.h |  5 +++--
> > > > > > > > > > > >  drm/nouveau/nvkm/subdev/pci/base.c    |  9 +++++++--
> > > > > > > > > > > >  drm/nouveau/nvkm/subdev/pci/pcie.c    | 24 ++++++++++++++++++++----
> > > > > > > > > > > >  drm/nouveau/nvkm/subdev/pci/priv.h    |  2 ++
> > > > > > > > > > > >  4 files changed, 32 insertions(+), 8 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drm/nouveau/include/nvkm/subdev/pci.h b/drm/nouveau/include/nvkm/subdev/pci.h
> > > > > > > > > > > > index 1fdf3098..b23793a2 100644
> > > > > > > > > > > > --- a/drm/nouveau/include/nvkm/subdev/pci.h
> > > > > > > > > > > > +++ b/drm/nouveau/include/nvkm/subdev/pci.h
> > > > > > > > > > > > @@ -26,8 +26,9 @@ struct nvkm_pci {
> > > > > > > > > > > >       } agp;
> > > > > > > > > > > >
> > > > > > > > > > > >       struct {
> > > > > > > > > > > > -             enum nvkm_pcie_speed speed;
> > > > > > > > > > > > -             u8 width;
> > > > > > > > > > > > +             enum nvkm_pcie_speed cur_speed;
> > > > > > > > > > > > +             enum nvkm_pcie_speed def_speed;
> > > > > > > > > > > > +             u8 cur_width;
> > > > > > > > > > > >       } pcie;
> > > > > > > > > > > >
> > > > > > > > > > > >       bool msi;
> > > > > > > > > > > > diff --git a/drm/nouveau/nvkm/subdev/pci/base.c b/drm/nouveau/nvkm/subdev/pci/base.c
> > > > > > > > > > > > index ee2431a7..d9fb5a83 100644
> > > > > > > > > > > > --- a/drm/nouveau/nvkm/subdev/pci/base.c
> > > > > > > > > > > > +++ b/drm/nouveau/nvkm/subdev/pci/base.c
> > > > > > > > > > > > @@ -90,6 +90,8 @@ nvkm_pci_fini(struct nvkm_subdev *subdev, bool suspend)
> > > > > > > > > > > >
> > > > > > > > > > > >       if (pci->agp.bridge)
> > > > > > > > > > > >               nvkm_agp_fini(pci);
> > > > > > > > > > > > +     else if (pci_is_pcie(pci->pdev))
> > > > > > > > > > > > +             nvkm_pcie_fini(pci);
> > > > > > > > > > > >
> > > > > > > > > > > >       return 0;
> > > > > > > > > > > >  }
> > > > > > > > > > > > @@ -100,6 +102,8 @@ nvkm_pci_preinit(struct nvkm_subdev *subdev)
> > > > > > > > > > > >       struct nvkm_pci *pci = nvkm_pci(subdev);
> > > > > > > > > > > >       if (pci->agp.bridge)
> > > > > > > > > > > >               nvkm_agp_preinit(pci);
> > > > > > > > > > > > +     else if (pci_is_pcie(pci->pdev))
> > > > > > > > > > > > +             nvkm_pcie_preinit(pci);
> > > > > > > > > > > >       return 0;
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > > @@ -193,8 +197,9 @@ nvkm_pci_new_(const struct nvkm_pci_func *func, struct nvkm_device *device,
> > > > > > > > > > > >       pci->func = func;
> > > > > > > > > > > >       pci->pdev = device->func->pci(device)->pdev;
> > > > > > > > > > > >       pci->irq = -1;
> > > > > > > > > > > > -     pci->pcie.speed = -1;
> > > > > > > > > > > > -     pci->pcie.width = -1;
> > > > > > > > > > > > +     pci->pcie.cur_speed = -1;
> > > > > > > > > > > > +     pci->pcie.def_speed = -1;
> > > > > > > > > > > > +     pci->pcie.cur_width = -1;
> > > > > > > > > > > >
> > > > > > > > > > > >       if (device->type == NVKM_DEVICE_AGP)
> > > > > > > > > > > >               nvkm_agp_ctor(pci);
> > > > > > > > > > > > diff --git a/drm/nouveau/nvkm/subdev/pci/pcie.c b/drm/nouveau/nvkm/subdev/pci/pcie.c
> > > > > > > > > > > > index 70ccbe0d..731dd30e 100644
> > > > > > > > > > > > --- a/drm/nouveau/nvkm/subdev/pci/pcie.c
> > > > > > > > > > > > +++ b/drm/nouveau/nvkm/subdev/pci/pcie.c
> > > > > > > > > > > > @@ -85,6 +85,13 @@ nvkm_pcie_oneinit(struct nvkm_pci *pci)
> > > > > > > > > > > >       return 0;
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > > +int
> > > > > > > > > > > > +nvkm_pcie_preinit(struct nvkm_pci *pci)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +     pci->pcie.def_speed = nvkm_pcie_get_speed(pci);
> > > > > > > > > > > > +     return 0;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  int
> > > > > > > > > > > >  nvkm_pcie_init(struct nvkm_pci *pci)
> > > > > > > > > > > >  {
> > > > > > > > > > > > @@ -105,12 +112,21 @@ nvkm_pcie_init(struct nvkm_pci *pci)
> > > > > > > > > > > >       if (pci->func->pcie.init)
> > > > > > > > > > > >               pci->func->pcie.init(pci);
> > > > > > > > > > > >
> > > > > > > > > > > > -     if (pci->pcie.speed != -1)
> > > > > > > > > > > > -             nvkm_pcie_set_link(pci, pci->pcie.speed, pci->pcie.width);
> > > > > > > > > > > > +     if (pci->pcie.cur_speed != -1)
> > > > > > > > > > > > +             nvkm_pcie_set_link(pci, pci->pcie.cur_speed,
> > > > > > > > > > > > +                                pci->pcie.cur_width);
> > > > > > > > > > > >
> > > > > > > > > > > >       return 0;
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > > +int
> > > > > > > > > > > > +nvkm_pcie_fini(struct nvkm_pci *pci)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +     if (!IS_ERR_VALUE(pci->pcie.def_speed))
> > > > > > > > > > > > +             return nvkm_pcie_set_link(pci, pci->pcie.def_speed, 16);
> > > > > > > > > > > > +     return 0;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  int
> > > > > > > > > > > >  nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
> > > > > > > > > > > >  {
> > > > > > > > > > > > @@ -146,8 +162,8 @@ nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
> > > > > > > > > > > >               speed = max_speed;
> > > > > > > > > > > >       }
> > > > > > > > > > > >
> > > > > > > > > > > > -     pci->pcie.speed = speed;
> > > > > > > > > > > > -     pci->pcie.width = width;
> > > > > > > > > > > > +     pci->pcie.cur_speed = speed;
> > > > > > > > > > > > +     pci->pcie.cur_width = width;
> > > > > > > > > > > >
> > > > > > > > > > > >       if (speed == cur_speed) {
> > > > > > > > > > > >               nvkm_debug(subdev, "requested matches current speed\n");
> > > > > > > > > > > > diff --git a/drm/nouveau/nvkm/subdev/pci/priv.h b/drm/nouveau/nvkm/subdev/pci/priv.h
> > > > > > > > > > > > index a0d4c007..e7744671 100644
> > > > > > > > > > > > --- a/drm/nouveau/nvkm/subdev/pci/priv.h
> > > > > > > > > > > > +++ b/drm/nouveau/nvkm/subdev/pci/priv.h
> > > > > > > > > > > > @@ -60,5 +60,7 @@ enum nvkm_pcie_speed gk104_pcie_max_speed(struct nvkm_pci *);
> > > > > > > > > > > >  int gk104_pcie_version_supported(struct nvkm_pci *);
> > > > > > > > > > > >
> > > > > > > > > > > >  int nvkm_pcie_oneinit(struct nvkm_pci *);
> > > > > > > > > > > > +int nvkm_pcie_preinit(struct nvkm_pci *);
> > > > > > > > > > > >  int nvkm_pcie_init(struct nvkm_pci *);
> > > > > > > > > > > > +int nvkm_pcie_fini(struct nvkm_pci *);
> > > > > > > > > > > >  #endif
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.21.0
> > > > > > > > > > > >
