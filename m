Return-Path: <linux-pci+bounces-5114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD59688A988
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7021C63016
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340E80030;
	Mon, 25 Mar 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDldw1pq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1B12F56;
	Mon, 25 Mar 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377712; cv=none; b=GJnQoymePnW0yFpehQktLYd1PEhXRH03Sxdap3P3vjKPwaDF73DVPEoOzOKD1D0QrSoYZ2JbefBGDXYFTI4yJ19vZYicai8yJijtDBHjMX2y2b3AcDEAIIjvS/vOXZaefoyXz93SVlI11z6TtETn4yxgtX9dCJOphenM4uLRiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377712; c=relaxed/simple;
	bh=j9NwLowIWSYXRI35sgGnXd8ywTxXOvOBVs6xYZrY6Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z91A3kfQqKPGk6J4HbYX5qj/gIjbKTLP95i+X+viw25JfxZeCCGRBuTpusnmuYJr34AtR99C4YgESas0/g2+fpTyu9CgZ8l0eyy/hKi40+99/OXrcox3TF7gTTMQS78xmTk53PRTvwg4bJ0ADeAYPRI+iGbwTDvP/NdI8A0hB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDldw1pq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57536C433F1;
	Mon, 25 Mar 2024 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711377711;
	bh=j9NwLowIWSYXRI35sgGnXd8ywTxXOvOBVs6xYZrY6Vc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kDldw1pqzNM33IlDFNQhRjNbCultKp4HAmVxTYhP+bmcEdrKNq4THK/cd8YdYRix5
	 0bBqeGATVIRSYP1YRnEJwZ4cBhczswdQBATSmwWGR6fOaLAhwswrfXIIc2baWZnVKH
	 SsGlnWz5BLsKQ2C1vpVB3vWtfcGhBlocxpE44lv39JMOvmwpRycH0Cj4G5pdRS6vEd
	 smh06yMmJLqCDb0XZiLIjVNmFUDx1yCiuoCQo1OMFVZnwBfKLfC6ZtnlHOG9PTNK6u
	 PW5onCxvqi1O9WCC7ZZ14ixXZAgtJvl3DLdI4ONDFNyjcAQ7hucv5ce5TzF5goAjYE
	 boAr151b13ZBg==
Date: Mon, 25 Mar 2024 09:41:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, edmund.raile@proton.me
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <20240325144149.GA1432902@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325012135.36861-1-o-takashi@sakamocchi.jp>

On Mon, Mar 25, 2024 at 10:21:35AM +0900, Takashi Sakamoto wrote:
> Hi Bjorn Helgaas,
> 
> (C.C.ed to linux1394-devel@lists.sourceforge.net)
> 
> I have an objection to applying the change.

This patch appeared in v6.9-rc1 as 29a43dc130ce ("PCI: Mark LSI FW643
to avoid bus reset").

> I've been using the issued 1394 OHCI hardware in my development for recent
> years, while I have never faced the reported trouble. I think there are
> any misunderstanding or misjudge somwhow in the review process to apply it.
> 
> Would I ask your precise advice to regenerate the reported issue in my
> local?

So even without this patch, you are able to pass the FW643 to a VM
with VFIO, and you don't see any issues caused by VFIO resetting the
device?

Can you collect the output of:

  $ find /sys/devices -name reset_method | xargs grep .

You should be able to manually reset the device with something like
this (I don't know your topology, so you might have to replace "1d.6"
with the bridge leading to 06:00.0):

  # sudo echo 1 > # /sys/devices/pci0000:00/0000:00:1d.6/0000:06:00.0/reset

I don't *know* of a reason why a Secondary Bus Reset would work
correctly on your hardware but not on a Mac, but there could be
something weird going on.

Does the patch cause a problem for you?  (Other than the fact that the
device leaks state between VMs?)

> This is my 1394 OHCI hardware.
> 
> ```
> $ sudo lspci -vvvnns 06:00.0
> 06:00.0 FireWire (IEEE 1394) [0c00]: LSI Corporation FW643 [TrueFire] PCIe 1394b Controller [11c1:5901] (rev 06) (prog-if 10 [OHCI])
>         Subsystem: LSI Corporation FW643 [TrueFire] PCIe 1394b Controller [11c1:5900]
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 255
>         IOMMU group: 17
>         Region 0: Memory at fc700000 (64-bit, non-prefetchable) [disabled] [size=4K]
>         Capabilities: [44] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>         Capabilities: [4c] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [60] Express (v1) Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <64us
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Capabilities: [140 v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>                         Status: NegoPending- InProgress-
>                 VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable- ID=1 ArbSelect=Fixed TC/VC=00
>                         Status: NegoPending- InProgress-
>         Capabilities: [170 v1] Device Serial Number 12-34-56-10-12-30-00-86
>         Kernel driver in use: vfio-pci
>         Kernel modules: firewire_ohci
> ```
> 
> I use it in the following environment at present:
> 
> * Host system
>     * AMD Ryzen 5 2400G
>     * TUF GAMING X570-PLUS with BIOS 5003 (AGESA ComboV2PI 1.2.0.B)
>         * SMT enabled
>         * SVM enabled
>         * IOMMU enabled
>         * Secure boot disabled
>     * Ubuntu 24.04 LTS amd64
>         * linux-image-6.8.0-11-generic (6.8.0-11.11)
>             * default kernel cmdline
>         * QEMU 8.2.1 (1:8.2.1+ds-1ubuntu1)
>         * Libvert 10.0.0 (10.0.0-2ubuntu1)
> * Guest system
>     * UEFI using OVMF
>         * Seecure boot enabled
>     * Ubuntu 24.04 LTS amd64 (the same as above)
>         * default kernel cmdline
> 
> > Using LSI / Agere FW643 with vfio-pci will exhaust all
> > pci_reset_fn_methods, the bus reset at the end causes a broken link
> > only recoverable by removing power
> > (power-off / suspend + rescan).
> > Prevent this bus reset.
> > With this change, the device can be assigned to VMs with VFIO.
> > Note that it will not be reset, resulting in leaking state between VMs
> > and host.
> > 
> > Signed-off-by: Edmund Raile <edmund.raile@proton.me>
> > 
> > I sincerely thank you for your patience and explaining
> > the background of pci resets which I lacked.
> > The commit message and comment now describe it correctly.
> > The comment on leaking states was added.
> > 
> > Usefulness:
> > 
> > The LSI FW643 PCIe->FireWire 800 interface may be EOL but it is
> > the only one that does not use a PCIe->PCI bridge.
> > It is reliable and enables FireWire audio interfaces to be used
> > on modern machines.
> > 
> > Virtualization allows for flexible access to professional audio
> > software.
> > 
> > It has been used in at least the following Apple machines:
> > MacBookPro10,1
> > MacBookPro9,2
> > MacBookPro6,2
> > MacBookPro5,1
> > Macmini6,1
> > Macmini3,1
> > iMac12,2
> > iMac9,1
> > iMac8,1
> > 
> > Implementation:
> > 
> > PCI_VENDOR_ID_ATT was reused as they are identical.
> > 
> >  drivers/pci/quirks.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index d797df6e5f3e..e0e4ad9e6d50 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3765,6 +3765,19 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
> >   */
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
> >  
> > +/*
> > + * Using LSI / Agere FW643 with vfio-pci will exhaust all
> > + * pci_reset_fn_methods, the bus reset at the end causes a broken link
> > + * only recoverable by removing power
> > + * (power-off / suspend + rescan).
> > + * Prevent this bus reset.
> > + * With this change, the device can be assigned to VMs with VFIO.
> > + * Note that it will not be reset, resulting in leaking state between VMs
> > + * and host.
> > + */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5900, quirk_no_bus_reset);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5901, quirk_no_bus_reset);
> > +
> >  /*
> >   * Some TI KeyStone C667X devices do not support bus/hot reset.  The PCIESS
> >   * automatically disables LTSSM when Secondary Bus Reset is received and
> 
> 
> Regards
> 
> Takashi Sakamoto

