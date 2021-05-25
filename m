Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583F1390805
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 19:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhEYRo2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 13:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhEYRo2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 13:44:28 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22302C061574;
        Tue, 25 May 2021 10:42:58 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g38so44152124ybi.12;
        Tue, 25 May 2021 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9x7B+vgGXU7k9ni1QP6w21nHktNbN3Pdx+py8RJnfEA=;
        b=nEW4I/C1CNLiEAKX0WvFcyaPgOBGEDKCRSd8ZeQtwgtXFKgCUmnr0UZ+MzHgkRP5jn
         ZtRHDw2t+HM0pTO4X6FzPEH7Vf8bmOXLRnDsA8pdlJqcSIkL0cQmkWqoc1VIlBc3qj6R
         sCBX1TJgL0topJp+eI+oAiN27I5AHW/wE4rxzOthaj5r0Mp/WwpG+UIoSvVUX87H0N9B
         yZ57lIRoXTJ0awLUYpvJB1tpHy7jJInGPKrDLcj1VWwH96nihTHXkxl3RgYYMm1QlKp7
         YlhlwTGMWrxtbhn6Ro9K36TByLa+hdujeF2ss0ncRzk907dd1Uy8K9z1NSVtdF9lvbSQ
         FXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9x7B+vgGXU7k9ni1QP6w21nHktNbN3Pdx+py8RJnfEA=;
        b=KwbhuT+3deTUrzu5UJmSWtS7KLcLEQ2fmAd3Ke4Crhr+fUXs2oii6RfZfulj4eLout
         x+deulrqB6B8h0FQgjMGMrf8aHzQ5gwvOHxDjJnAw8ViSOUqbtDwzlaAJoP20CDMH0n4
         oR3MppMFlajESiudVtH4EKp6S/hzqD4VFegb9eI1NrPikOlhiP7OmRDF+sCgi6dBVfBU
         RVmbdLrvAWlxY9bT12gNda15PpUGE+OCV8Pb/tXdM9eLmhW7gWfubSvgvkKnkWb69dtY
         BXbuXkol+XRqg2QRgEHTeUlfAi8iVmAr/du5E79ME5erJEDRsV4iyHfOAyDGsawG8pDx
         qfQw==
X-Gm-Message-State: AOAM533o34wpbAK0QwaOxjSQuArqO53WUfcUIGjaybPts52oGodMYzZf
        KGij/b8je5TXtC7douC4ZzajuXihKcbPscDeWcmeEkoCSvdc1EpQ
X-Google-Smtp-Source: ABdhPJwryfbJiVyR7MbuJzP8cGWFJgxXf2XaN81gHB+4hh+dA4OvdoIRxmQWAeIgnDta9Ki8GuZwGwPhspxmhJ4msh8=
X-Received: by 2002:a5b:303:: with SMTP id j3mr41458979ybp.433.1621964577316;
 Tue, 25 May 2021 10:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com> <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com>
 <87eedxbtkn.fsf@stealth> <CAMj1kXE3U+16A6bO0UHG8=sx45DE6u0FtdSnoLDvfGnFJYTDrg@mail.gmail.com>
 <877djnaq11.fsf@stealth> <CAMj1kXFk2u=tbTYpa6Vqz5ihATFq61pCDiEbfRgXL_Rw+q_9Fg@mail.gmail.com>
 <CANAwSgQEti7=dsYbqYMxrcP9KPFc-s0e4xHPPwOC=gP+scpP3w@mail.gmail.com> <4292e929-779f-9c83-f75c-7d8121a1c6c8@arm.com>
In-Reply-To: <4292e929-779f-9c83-f75c-7d8121a1c6c8@arm.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 25 May 2021 13:42:46 -0400
Message-ID: <CAMdYzYqBw0pFBNX2Y2t8ifN3KCCkhkpGXUHRsrg9unVYFG2cvQ@mail.gmail.com>
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Rob Herring <robh@kernel.org>, PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 25, 2021 at 1:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-05-25 17:59, Anand Moon wrote:
> > Hi Ard,
> >
> > On Tue, 25 May 2021 at 19:27, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> On Tue, 25 May 2021 at 15:42, Punit Agrawal <punitagrawal@gmail.com> wrote:
> >>>
> >>> Hi Ard,
> >>>
> >>> Ard Biesheuvel <ardb@kernel.org> writes:
> >>>
> >>>> On Sun, 23 May 2021 at 13:06, Punit Agrawal <punitagrawal@gmail.com> wrote:
> >>>>>
> >>>>> Robin Murphy <robin.murphy@arm.com> writes:
> >>>>>
> >>>>>> [ +linux-pci for visibility ]
> >>>>>>
> >>>>>> On 2021-05-18 10:09, Alexandru Elisei wrote:
> >>>>>>> After doing a git bisect I was able to trace the following error when booting my
> >>>>>>> rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:
> >>>>>>> [..]
> >>>>>>> [    0.305183] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> >>>>>>> [    0.305248] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff ->
> >>>>>>> 0x00fa000000
> >>>>>>> [    0.305285] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff ->
> >>>>>>> 0x00fbe00000
> >>>>>>> [    0.306201] rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using dummy
> >>>>>>> regulator
> >>>>>>> [    0.306334] rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using dummy
> >>>>>>> regulator
> >>>>>>> [    0.373705] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
> >>>>>>> [    0.373730] pci_bus 0000:00: root bus resource [bus 00-1f]
> >>>>>>> [    0.373751] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
> >>>>>>> [    0.373777] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus
> >>>>>>> address [0xfbe00000-0xfbefffff])
> >>>>>>> [    0.373839] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
> >>>>>>> [    0.373973] pci 0000:00:00.0: supports D1
> >>>>>>> [    0.373992] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> >>>>>>> [    0.378518] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
> >>>>>>> reconfiguring
> >>>>>>> [    0.378765] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
> >>>>>>> [    0.378869] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> >>>>>>> [    0.379051] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
> >>>>>>> [    0.379661] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by
> >>>>>>> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe
> >>>>>>> x4 link)
> >>>>>>> [    0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
> >>>>>>> [    0.393311] pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
> >>>>>>> [    0.393333] pci 0000:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
> >>>>>>> [    0.393356] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> >>>>>>> [    0.393375] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> >>>>>>> [    0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
> >>>>>>> [    0.393839] pcieport 0000:00:00.0: PME: Signaling with IRQ 78
> >>>>>>> [    0.394165] pcieport 0000:00:00.0: AER: enabled with IRQ 78
> >>>>>>> [..]
> >>>>>>> to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to
> >>>>>>> resource flags for
> >>>>>>> 64-bit memory addresses").
> >>>>>>
> >>>>>> FWFW, my hunch is that the host bridge advertising no 32-bit memory
> >>>>>> resource, only only a single 64-bit non-prefetchable one (even though
> >>>>>> it's entirely below 4GB) might be a bit weird and tripping something
> >>>>>> up in the resource assignment code. It certainly seems like the thing
> >>>>>> most directly related to the offending commit.
> >>>>>>
> >>>>>> I'd be tempted to try fiddling with that in the DT (i.e. changing
> >>>>>> 0x83000000 to 0x82000000 in the PCIe node's "ranges" property) to see
> >>>>>> if it makes any difference. Note that even if it helps, though, I
> >>>>>> don't know whether that's the correct fix or just a bodge around a
> >>>>>> corner-case bug somewhere in the resource code.
> >>>>>
> >>>>>  From digging into this further the failure seems to be due to a mismatch
> >>>>> of flags when allocating resources in pci_bus_alloc_from_region() -
> >>>>>
> >>>>>      if ((res->flags ^ r->flags) & type_mask)
> >>>>>              continue;
> >>>>>
> >>>>> Though I am also not sure why the failure is only being reported on
> >>>>> RK3399 - does a single 64-bit window have anything to do with it?
> >>>>>
> >>>>
> >>>> The NVMe in the example exposes a single 64-bit non-prefetchable BAR.
> >>>> Such BARs can not be allocated in a prefetchable host bridge window
> >>>> (unlike the converse, i.e., allocating a prefetchable BAR in a
> >>>> non-prefetchable host bridge window is fine)
> >>>>
> >>>> 64-bit non-prefetchable host bridge windows cannot be forwarded by PCI
> >>>> to PCI bridges, they simply lack the BAR registers to describe them.
> >>>> Therefore, non-prefetchable endpoint BARs (even 64-bit ones) need to
> >>>> be carved out of a host bridge's non-prefetchable 32-bit window if
> >>>> they need to pass through a bridge.
> >>>
> >>> Thank you for the explanation. I also looked at the PCI-to-PCI Bridge
> >>> spec to understand where some of the limitations are coming from.
> >>>
> >>>> So the error seems to be here that the host bridge's 32-bit
> >>>> non-prefetchable window has the 64-bit attribute set, even though it
> >>>> resides below 4 GB entirely. I suppose that the resource allocation
> >>>> could be made more forgiving (and it was in the past, before commit
> >>>> 9d57e61bf723 was applied). However, I would strongly recommend not
> >>>> deviating from common practice, and just describe the 32-bit
> >>>> addressable non-prefetchable resource window as such.
> >>>
> >>> IIUC, the host bridge's configuration (64-bit on non-prefetchable
> >>> window) is based on what the hardware advertises.
> >>>
> >>
> >> What do you mean by 'what the hardware advertises'? The host bridge is
> >> apparently configured to decode a 32-bit addressable window as MMIO,
> >> and the question is why this window has the 64-bit attribute set in
> >> the DT description.
> >>
> >>> Can you elaborate on what you have in mind to correct the
> >>> non-prefetchable resource window? Are you thinking of adding a quirk
> >>> somewhere to address this?
> >>>
> >>
> >> No. Just fix the DT.
> >
> > Yes DTS changes are needed as well as some more core driver changes.
> >
> > As per the Rk3399 TRM (Rockchip RK3399 TRM V1.3 Part2.pdf)
> > [0] https://rockchip.fr/Rockchip%20RK3399%20TRM%20V1.3%20Part2.pdf
> >
> > I had made the following dts changes relates to ranges as per PCI below.
> >
> > *17.6.1 Internal Register Address Mapping
> >     Table 17-23 Global Address Map for Core Local Management*
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > index 634a91af8e83..796b44e07be1 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > @@ -199,7 +199,7 @@ xin24m: xin24m {
> >
> >          pcie0: pcie@f8000000 {
> >                  compatible = "rockchip,rk3399-pcie";
> > -               reg = <0x0 0xf8000000 0x0 0x2000000>,
> > +               reg = <0x0 0xf8000000 0x0 0x6000000>,
> >                        <0x0 0xfd000000 0x0 0x1000000>;
> >                  reg-names = "axi-base", "apb-base";
> >                  device_type = "pci";
> > @@ -227,8 +227,8 @@ pcie0: pcie@f8000000 {
> >                         <&pcie_phy 2>, <&pcie_phy 3>;
> >                  phy-names = "pcie-phy-0", "pcie-phy-1",
> >                              "pcie-phy-2", "pcie-phy-3";
> > -               ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0
> > 0x1e00000>,
> > -                        <0x81000000 0x0 0xfbe00000 0x0 0xfbe00000 0x0
> > 0x100000>;
> > +               ranges = <0x83000000 0x0 0xfd800000 0x0 0xfd810000 0x0
> > 0x100000>,
> > +                        <0x81000000 0x0 0xfd800000 0x0 0xfda00000 0x0
> > 0x100000>;
> >                  resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
> >                           <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>,
> >                           <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>,
> > @@ -2040,6 +2040,21 @@ pcfg_pull_up_2ma: pcfg-pull-up-2ma {
> >                          drive-strength = <2>;
> >
> > Also, the BAR configuration is missing some tuning bits missing,
> > *   17.6.7.1.45 Root Complex BAR Configuration Register.*
> >
> > Earlier I had to face this issue on my Rk3399 board (Odroid n1), but I
> > could not resolve the issue.
> >
> > [1] https://patchwork.kernel.org/project/linux-rockchip/patch/1590023130-137406-1-git-send-email-shawn.lin@rock-chips.com/
> >
> > How can I debug the PCIe handshake messages to explore further?
> >
> > [alarm@alarm ~]$ dmesg | grep pci
> > [    1.399919] ehci-pci: EHCI PCI platform driver
> > [    1.538434] ohci-pci: OHCI PCI platform driver
> > [    7.112556] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> > [    7.120583] rockchip-pcie f8000000.pcie: Parsing ranges property...
> > [    7.134628] rockchip-pcie f8000000.pcie:      MEM
> > 0x00fd810000..0x00fd90ffff -> 0x00fd800000
> > [    7.144148] rockchip-pcie f8000000.pcie:       IO
> > 0x00fda00000..0x00fdafffff -> 0x00fd800000
> > [    7.165435] rockchip-pcie f8000000.pcie: can't request region for
> > resource [mem 0xf8000000-0xfdffffff]
> > [    7.182904] rockchip-pcie: probe of f8000000.pcie failed with error -16
>
> Sorry, you've changed your DT for unknown reasons to put the memory and
> I/O windows at the same bus address, and now you want help debugging why
> trying to put two things at the same address gives -EBUSY?
>
> :/
>
> Is it Friday already?

I wish, I don't know where they pulled those values from but they
could never work.

Anand Moon:
The apb registers are fine, please don't try to increase them.
By doing so you have now reserved that memory space to the driver and
it cannot be assigned to the bridge.

The rk3399 has a single 32MB memory space and 32 1MB memory spaces.
Only the single large coherent memory space is supported, since using
the other 32 spaces would involve a complicated memory dance that the
driver doesn't support.

The recommendation was changing the PCIe memory space from 64-bit to
32-bit, by changing 0x83000000 to 0x82000000.

>
> Robin.
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
