Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720CA39BDBF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 18:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhFDQ5P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 12:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhFDQ5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 12:57:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44B88613DE;
        Fri,  4 Jun 2021 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622825728;
        bh=koxXFubPHbOiyXDwrCxoO2ZYyQNuCrdp9eQHTS1o5zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNqIXnVF4xOc1Xh0HMDdHEZS6+ZGbaJhat5z2KTcKWOcVvc7JWe9jZUWsvG5FA6jR
         SBcXpBpBYG/uiIkuD0ngNbnAPp2RkqlHYBzlbRzb+LA1v5I3kG+pnId67EBNrjvQjj
         qEwj0Z4nkVlImBEFjXWdkcaRGv2hp68eKO8eEStFD3bvo9bweOTyJc5KMtlPonoXXC
         nsFs6eBHALuZU1ZdqYWAev9mQW/keFnjafIHQiRyY8w5K8+T83wCKjxwEn9Iz3l6Hg
         2ZSY7UpZvwNa2zRCb8V5FeT1Dk6jNjh64jrlMzm+B8LmlNOeL0KQORNKCEQe+f5Ifm
         zpmJbtvgGPItA==
Received: by pali.im (Postfix)
        id 937C7990; Fri,  4 Jun 2021 18:55:25 +0200 (CEST)
Date:   Fri, 4 Jun 2021 18:55:25 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] MIPS: pci: Add driver for MT7621 PCIe controller
Message-ID: <20210604165525.ybgyusazeyzx642v@pali>
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
 <20210515124055.22225-3-sergio.paracuellos@gmail.com>
 <20210531131431.bzsvmefqdyawmeo2@pali>
 <CAMhs-H80=7jctPT70rOmcwcqPw+9iUF84_ZCgGr-TKwJ4eB2Lg@mail.gmail.com>
 <20210531135041.42ovpmbwuc3yfkaw@pali>
 <CAMhs-H_fR5aXJ=diTm-2yhgjjv9S6N6jA-DOZ0K_BnQ4UHHh3Q@mail.gmail.com>
 <CAMhs-H8EwQDvZtzpPn2u_WOWt1wcixOvz5nVZP2miM6j0+P7EA@mail.gmail.com>
 <20210602122337.fxwaikulbawwkc2j@pali>
 <CAMhs-H8Gr=ObgMZAZ9VuNqHX4TaKQPPGNNMY4pzh9o=3EbAgUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMhs-H8Gr=ObgMZAZ9VuNqHX4TaKQPPGNNMY4pzh9o=3EbAgUQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 02 June 2021 14:43:53 Sergio Paracuellos wrote:
> Hi Pali,
> 
> On Wed, Jun 2, 2021 at 2:23 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Wednesday 02 June 2021 14:16:26 Sergio Paracuellos wrote:
> > > Hi Pali,
> > >
> > > On Mon, May 31, 2021 at 4:19 PM Sergio Paracuellos
> > > <sergio.paracuellos@gmail.com> wrote:
> > > >
> > > > On Mon, May 31, 2021 at 3:50 PM Pali Rohár <pali@kernel.org> wrote:
> > > > >
> > > > > On Monday 31 May 2021 15:39:55 Sergio Paracuellos wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > Thanks for your comments.
> > > > > >
> > > > > > On Mon, May 31, 2021 at 3:14 PM Pali Rohár <pali@kernel.org> wrote:
> > > > > > >
> > > > > > > On Saturday 15 May 2021 14:40:53 Sergio Paracuellos wrote:
> > > > > > > > This patch adds a driver for the PCIe controller of MT7621 SoC.
> > > > > > > >
> > > > > > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > > > > > ---
> > > > > > > >  arch/mips/pci/Makefile     |   1 +
> > > > > > > >  arch/mips/pci/pci-mt7621.c | 624 +++++++++++++++++++++++++++++++++++++
> > > > > > > >  arch/mips/ralink/Kconfig   |   9 +-
> > > > > > > >  3 files changed, 633 insertions(+), 1 deletion(-)
> > > > > > > >  create mode 100644 arch/mips/pci/pci-mt7621.c
> > > > > > > >
> > > > > > > > diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> > > > > > > > index f3eecc065e5c..178c550739c4 100644
> > > > > > > > --- a/arch/mips/pci/Makefile
> > > > > > > > +++ b/arch/mips/pci/Makefile
> > > > > > > > @@ -24,6 +24,7 @@ obj-$(CONFIG_PCI_AR2315)    += pci-ar2315.o
> > > > > > > >  obj-$(CONFIG_SOC_AR71XX)     += pci-ar71xx.o
> > > > > > > >  obj-$(CONFIG_PCI_AR724X)     += pci-ar724x.o
> > > > > > > >  obj-$(CONFIG_PCI_XTALK_BRIDGE)       += pci-xtalk-bridge.o
> > > > > > > > +obj-$(CONFIG_PCI_MT7621)     += pci-mt7621.o
> > > > > > > >  #
> > > > > > > >  # These are still pretty much in the old state, watch, go blind.
> > > > > > > >  #
> > > > > > > > diff --git a/arch/mips/pci/pci-mt7621.c b/arch/mips/pci/pci-mt7621.c
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..fe1945819d25
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/arch/mips/pci/pci-mt7621.c
> > > > > > > ...
> > > > > > > > +static int mt7621_pcie_enable_ports(struct mt7621_pcie *pcie)
> > > > > > > > +{
> > > > > > > > +     struct device *dev = pcie->dev;
> > > > > > > > +     struct mt7621_pcie_port *port;
> > > > > > > > +     u8 num_slots_enabled = 0;
> > > > > > > > +     u32 slot;
> > > > > > > > +     u32 val;
> > > > > > > > +     int err;
> > > > > > > > +
> > > > > > > > +     /* Setup MEMWIN and IOWIN */
> > > > > > > > +     pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE);
> > > > > > > > +     pcie_write(pcie, pcie->io.start, RALINK_PCI_IOBASE);
> > > > > > > > +
> > > > > > > > +     list_for_each_entry(port, &pcie->ports, list) {
> > > > > > > > +             if (port->enabled) {
> > > > > > > > +                     err = clk_prepare_enable(port->clk);
> > > > > > > > +                     if (err) {
> > > > > > > > +                             dev_err(dev, "enabling clk pcie%d\n", slot);
> > > > > > > > +                             return err;
> > > > > > > > +                     }
> > > > > > > > +
> > > > > > > > +                     mt7621_pcie_enable_port(port);
> > > > > > > > +                     dev_info(dev, "PCIE%d enabled\n", port->slot);
> > > > > > > > +                     num_slots_enabled++;
> > > > > > > > +             }
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     for (slot = 0; slot < num_slots_enabled; slot++) {
> > > > > > > > +             val = read_config(pcie, slot, PCI_COMMAND);
> > > > > > > > +             val |= PCI_COMMAND_MASTER;
> > > > > > > > +             write_config(pcie, slot, PCI_COMMAND, val);
> > > > > > >
> > > > > > > Hello! Is this part of code correct? Because it looks strange if PCIe
> > > > > > > controller driver automatically enables PCI bus mastering, prior device
> > > > > > > driver initialize itself.
> > > > > > >
> > > > > > > Moreover kernel has already function pci_set_master() for this purpose
> > > > > > > which is used by device drivers.
> > > > > > >
> > > > > > > So I think this code can confuse some device drivers...
> > > > > >
> > > > > > I agree that we have pci_set_master() to be used in pci device driver
> > > > > > code. Original controller driver set this bit for enabled slots. Since
> > > > > > there is no documentation at all for the PCI in this SoC
> > > > >
> > > > > I see... this is really a big problem to do any driver development...
> > > >
> > > > For sure it is :(.
> > > >
> > > > >
> > > > > > I have
> > > > > > maintained the setting in the driver in a cleaner way. See original
> > > > > > driver code and the setting here [0]. There is no other reason than
> > > > > > that. I am ok with removing this from here and testing with my two
> > > > > > devices that everything is still ok if having this setting in the pci
> > > > > > controller driver is a real problem.
> > > > >
> > > > > You can run lspci -nnvv with and without PCI_COMMAND_MASTER code and
> > > > > then compare outputs.
> > > > >
> > > > > Device drivers for sure enable PCI_COMMAND_MASTER at the time when it is
> > > > > needed, so it is possible that there would be no difference in lspci
> > > > > output.
> > > >
> > > > Thanks. I will take this into account when v2 is submitted after more
> > > > review comments come :).
> > >
> > > I have tested to remove this and check lspci -nnvv output with and
> > > without PCI_COMMAND_MASTER code and, as you pointed out, there is no
> > > difference between them. Also, both boards are working without
> > > regressions at all. So I will remove this code for next version.
> >
> > Perfect!
> >
> > > Thanks,
> > >     Sergio Paracuellos
> > > >
> > > > >
> > > > > > [0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/mt7621-pci/pci-mt7621.c?h=v4.18#n676
> > > > > >
> > > > > > Best regards,
> > > > > >     Sergio Paracuellos
> > > > > > >
> > > > > > > > +             /* configure RC FTS number to 250 when it leaves L0s */
> > > > > > > > +             val = read_config(pcie, slot, PCIE_FTS_NUM);
> > > > > > > > +             val &= ~PCIE_FTS_NUM_MASK;
> > > > > > > > +             val |= PCIE_FTS_NUM_L0(0x50);
> > > > > > > > +             write_config(pcie, slot, PCIE_FTS_NUM, val);
> >
> > Could you look also what is doing this code (PCIE_FTS_NUM)? It is marked
> > as MT specific register. But from this code for me it looks like that it
> > just access config space of some device and therefore it could be some
> > standard PCIe register. Just with hardcoded calculated offset.

So based on your lspci output, there is no PCIe capability register at
address PCIE_FTS_NUM (0x70c), right? It seems strange to trying access
capability register outside of capability list.

> > Could you provide output from lspci -nnvv? So other people could look at
> > it and maybe we decode what is this code doing and if it is needed.
> 
> # lspci -nnvv
> 00:02.0 PCI bridge [0604]: Device [0e8d:0801] (rev 01) (prog-if 00
> [Normal decode])

Hm... Device address is 02. But in your code is:

    u8 num_slots_enabled = 0;
    ...
    list_for_each_entry(port, &pcie->ports, list) {
        if (port->enabled) {
            ...
            num_slots_enabled++;
            ...
        }
    }
    ...
    for (slot = 0; slot < num_slots_enabled; slot++) {
        val = read_config(pcie, slot, ...);
        ...
        write_config(pcie, slot, ...);
    }

Which means that this code writes to config space of wrong device 0
(instead of 2)! In function write_config() can be seen that second
parameter specify device of BDF address for bus=0 and function=0.

>         Device tree node: /sys/firmware/devicetree/base/pcie@1e140000/pcie@2,0
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 255
>         Region 1: Memory at 60200000 (32-bit, non-prefetchable) [size=64K]
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 00000000-00000fff [size=4K]
>         Memory behind bridge: 60000000-600fffff [size=1M]
>         Prefetchable memory behind bridge: 60100000-601fffff [size=1M]
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA
> PME(D0+,D1+,D2-,D3hot+,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0
>                         ExtTag- RBE+
>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq-
> AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
> Exit Latency L0s <512ns, L1 <64us
>                         ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 128 bytes, Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
>                         TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>                 RootCap: CRSVisible-
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> PMEIntEna- CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Not Supported,
> TimeoutDis+ NROPrPrP- LTR-
>                          10BitTagComp- 10BitTagReq- OBFF Not
> Supported, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>                          FRS- LN System CLS Not Supported, TPHComp-
> ExtTPHComp- ARIFwd-
>                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> LTR- OBFF Disabled, ARIFwd-
>                          AtomicOpsCtl: ReqEn- EgressBlck-
>                 LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink-
> Retimer- 2Retimers- DRS-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete- EqualizationPhase1-
>                          EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr+
>                 AERCap: First Error Pointer: 00, ECRCGenCap+
> ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>                 RootCmd: CERptEn- NFERptEn- FERptEn-
>                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>                          FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>         Capabilities: [140 v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>                         Status: NegoPending- InProgress-
> lspci: Unable to load libkmod resources: error -12
> 
> 01:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7612]
>         Subsystem: MEDIATEK Corp. Device [14c3:7612]
>         Device tree node:
> /sys/firmware/devicetree/base/pcie@1e140000/pcie@2,0/wifi@0,0
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 20
>         Region 0: Memory at 60000000 (64-bit, non-prefetchable) [size=1M]
>         Expansion ROM at 60100000 [virtual] [disabled] [size=64K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [70] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset- SlotPowerLimit 0.000W
>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
> Exit Latency L0s <2us, L1 unlimited
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> NROPrPrP- LTR-
>                          10BitTagComp- 10BitTagReq- OBFF Not
> Supported, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>                          FRS- TPHComp- ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> LTR- OBFF Disabled,
>                          AtomicOpsCtl: ReqEn-
>                 LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink-
> Retimer- 2Retimers- DRS-
>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete- EqualizationPhase1-
>                          EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr+
>                 AERCap: First Error Pointer: 00, ECRCGenCap+
> ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
>         Capabilities: [158 v1] Latency Tolerance Reporting
>                 Max snoop latency: 0ns
>                 Max no snoop latency: 0ns
>         Capabilities: [160 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=50us PortTPowerOnTime=10us
>                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                            T_CommonMode=0us LTR1.2_Threshold=0ns
>                 L1SubCtl2: T_PwrOn=10us
>         Kernel driver in use: mt76x2e
> 
> Best regards,
>     Sergio Paracuellos
> 
> >
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     return 0;
> > > > > > > > +}
