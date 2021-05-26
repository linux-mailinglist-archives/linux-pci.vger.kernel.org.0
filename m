Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF08391D21
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 18:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhEZQhI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 12:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234997AbhEZQhH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 12:37:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 146F6613CE;
        Wed, 26 May 2021 16:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622046936;
        bh=9ibza90i0mKwGpI52llCPOTKOeODx3lgg2TH7rBcDQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tu46kJLiOnE+0/qmOoWHynF4w9LvnZ2opcqcNtc2vYBc+lf4v0AMBpBeQHJrBeqgG
         zrrlbKDehxAinRuQk8KTN1f4vdAphO0NjmdXkaIat4v+9jYyouQToAlExZ7qaGWauu
         N04IC9oBCcaY5Yom3431mJuZCvCGKl6BTvzYw9Gv6078K31ayiLJO5jXF6xyxD8Fpx
         veivUBQTfr14Ch8eCgrQwgezaM6Gb4iwovhYuL9+MVftHUbx88VrShxhfbuUjo2izO
         a34FqB+n3YpTtyvrkNesQ15U7Q6m9Kgil25+SzIWqo0jeUIU5fFB7WCUbYxx/pP/Zn
         AIGAj/8TZhmnA==
Received: by mail-ot1-f51.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so1582645otk.5;
        Wed, 26 May 2021 09:35:36 -0700 (PDT)
X-Gm-Message-State: AOAM533Rs+nJ8t+LTNhE7+2HREaXXHwBq2XwfVqSFVqEk/fKTZELl1EM
        zASiKvxwH+MIpkR/kR+7p9zkX9p2tf3kE3BJdPc=
X-Google-Smtp-Source: ABdhPJwgf4NXWcpVZaVWKPi3HmJY4JkM78te5LADdxWyP1BGcyxLkjWb3MJiqEMT2sJFfwvntuEL3sxFvW7T9LPHVZ8=
X-Received: by 2002:a9d:7cd8:: with SMTP id r24mr3103912otn.90.1622046935368;
 Wed, 26 May 2021 09:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com> <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com>
 <87eedxbtkn.fsf@stealth> <CAMj1kXE3U+16A6bO0UHG8=sx45DE6u0FtdSnoLDvfGnFJYTDrg@mail.gmail.com>
 <877djnaq11.fsf@stealth> <CAMj1kXFk2u=tbTYpa6Vqz5ihATFq61pCDiEbfRgXL_Rw+q_9Fg@mail.gmail.com>
 <20210526153757.GA2467427@robh.at.kernel.org>
In-Reply-To: <20210526153757.GA2467427@robh.at.kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 May 2021 18:35:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGF_JmuZ+rRA55-NrTQ6f20fhcHc=62AGJ71eHNU8AoBQ@mail.gmail.com>
Message-ID: <CAMj1kXGF_JmuZ+rRA55-NrTQ6f20fhcHc=62AGJ71eHNU8AoBQ@mail.gmail.com>
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Rob Herring <robh@kernel.org>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        leobras.c@gmail.com, PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 26 May 2021 at 17:38, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 25, 2021 at 03:54:30PM +0200, Ard Biesheuvel wrote:
> > On Tue, 25 May 2021 at 15:42, Punit Agrawal <punitagrawal@gmail.com> wrote:
> > >
> > > Hi Ard,
> > >
> > > Ard Biesheuvel <ardb@kernel.org> writes:
> > >
> > > > On Sun, 23 May 2021 at 13:06, Punit Agrawal <punitagrawal@gmail.com> wrote:
> > > >>
> > > >> Robin Murphy <robin.murphy@arm.com> writes:
> > > >>
> > > >> > [ +linux-pci for visibility ]
> > > >> >
> > > >> > On 2021-05-18 10:09, Alexandru Elisei wrote:
> > > >> >> After doing a git bisect I was able to trace the following error when booting my
> > > >> >> rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:
> > > >> >> [..]
> > > >> >> [    0.305183] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> > > >> >> [    0.305248] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff ->
> > > >> >> 0x00fa000000
> > > >> >> [    0.305285] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff ->
> > > >> >> 0x00fbe00000
> > > >> >> [    0.306201] rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using dummy
> > > >> >> regulator
> > > >> >> [    0.306334] rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using dummy
> > > >> >> regulator
> > > >> >> [    0.373705] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
> > > >> >> [    0.373730] pci_bus 0000:00: root bus resource [bus 00-1f]
> > > >> >> [    0.373751] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
> > > >> >> [    0.373777] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus
> > > >> >> address [0xfbe00000-0xfbefffff])
> > > >> >> [    0.373839] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
> > > >> >> [    0.373973] pci 0000:00:00.0: supports D1
> > > >> >> [    0.373992] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> > > >> >> [    0.378518] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
> > > >> >> reconfiguring
> > > >> >> [    0.378765] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
> > > >> >> [    0.378869] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> > > >> >> [    0.379051] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
> > > >> >> [    0.379661] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by
> > > >> >> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe
> > > >> >> x4 link)
> > > >> >> [    0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
> > > >> >> [    0.393311] pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
> > > >> >> [    0.393333] pci 0000:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
> > > >> >> [    0.393356] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> > > >> >> [    0.393375] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> > > >> >> [    0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
> > > >> >> [    0.393839] pcieport 0000:00:00.0: PME: Signaling with IRQ 78
> > > >> >> [    0.394165] pcieport 0000:00:00.0: AER: enabled with IRQ 78
> > > >> >> [..]
> > > >> >> to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to
> > > >> >> resource flags for
> > > >> >> 64-bit memory addresses").
> > > >> >
> > > >> > FWFW, my hunch is that the host bridge advertising no 32-bit memory
> > > >> > resource, only only a single 64-bit non-prefetchable one (even though
> > > >> > it's entirely below 4GB) might be a bit weird and tripping something
> > > >> > up in the resource assignment code. It certainly seems like the thing
> > > >> > most directly related to the offending commit.
> > > >> >
> > > >> > I'd be tempted to try fiddling with that in the DT (i.e. changing
> > > >> > 0x83000000 to 0x82000000 in the PCIe node's "ranges" property) to see
> > > >> > if it makes any difference. Note that even if it helps, though, I
> > > >> > don't know whether that's the correct fix or just a bodge around a
> > > >> > corner-case bug somewhere in the resource code.
> > > >>
> > > >> From digging into this further the failure seems to be due to a mismatch
> > > >> of flags when allocating resources in pci_bus_alloc_from_region() -
> > > >>
> > > >>     if ((res->flags ^ r->flags) & type_mask)
> > > >>             continue;
> > > >>
> > > >> Though I am also not sure why the failure is only being reported on
> > > >> RK3399 - does a single 64-bit window have anything to do with it?
> > > >>
> > > >
> > > > The NVMe in the example exposes a single 64-bit non-prefetchable BAR.
> > > > Such BARs can not be allocated in a prefetchable host bridge window
> > > > (unlike the converse, i.e., allocating a prefetchable BAR in a
> > > > non-prefetchable host bridge window is fine)
> > > >
> > > > 64-bit non-prefetchable host bridge windows cannot be forwarded by PCI
> > > > to PCI bridges, they simply lack the BAR registers to describe them.
> > > > Therefore, non-prefetchable endpoint BARs (even 64-bit ones) need to
> > > > be carved out of a host bridge's non-prefetchable 32-bit window if
> > > > they need to pass through a bridge.
> > >
> > > Thank you for the explanation. I also looked at the PCI-to-PCI Bridge
> > > spec to understand where some of the limitations are coming from.
> > >
> > > > So the error seems to be here that the host bridge's 32-bit
> > > > non-prefetchable window has the 64-bit attribute set, even though it
> > > > resides below 4 GB entirely. I suppose that the resource allocation
> > > > could be made more forgiving (and it was in the past, before commit
> > > > 9d57e61bf723 was applied). However, I would strongly recommend not
> > > > deviating from common practice, and just describe the 32-bit
> > > > addressable non-prefetchable resource window as such.
> > >
> > > IIUC, the host bridge's configuration (64-bit on non-prefetchable
> > > window) is based on what the hardware advertises.
> > >
> >
> > What do you mean by 'what the hardware advertises'? The host bridge is
> > apparently configured to decode a 32-bit addressable window as MMIO,
> > and the question is why this window has the 64-bit attribute set in
> > the DT description.
> >
> > > Can you elaborate on what you have in mind to correct the
> > > non-prefetchable resource window? Are you thinking of adding a quirk
> > > somewhere to address this?
> > >
> >
> > No. Just fix the DT.
>
> We can't only fix the DT as we shouldn't require a DT update due to a
> kernel change. Especially for RK3399 which is pretty stable and widely
> used.
>
> Do I understand correctly that 64-bit non-prefetchable never correct?

No. It just makes little sense for PCIe, given that root ports are
modeled as PCI bridges, which cannot forward non-prefetchable 64-bit
windows. But a funky root complex with integrated endpoints as well as
root ports might have some use for it, I suppose, so we cannot rule it
out.

The bottom line is really that, given that 64-bit BARs can be
allocated in 32-bit space, and that prefetchable BARs can be allocated
in non-prefetchable space, a 32-bit non-prefetchable window is the
bare minimum if you are after compatibility. However, PCIe only
permits 32-bit BARs for legacy endpoints (which includes most VGA and
SATA controllers, for instance, but not XHCI or NVMe). So it also does
not make a lot of sense to complain about the lack of a 32-bit
non-prefetchable window in the general case, as there are
embedded/integrated scenarios imaginable where you simply never plug
such a legacy endpoint in the first place.

Note that having a 32-bit non-prefetchable and a 32-bit prefetchable
window could also work for PCIe - the prefetchable bridge window does
not *require* any of the upper bits to be set.



> We
> recently gained a warning for this in commit fede8526cc48 ("PCI: of:
> Warn if non-prefetchable memory aperture size is > 32-bit"), but that
> only looks at addresses, not the 64-bit flag. Can't we just not set
> the 64-bit flag if non-prefetchable?
>

No, that may be too restrictive - see the integrated endpoint case above.

But perhaps we could clear the 64-bit flag on the resource window if
the bus addresses are guaranteed to fit into 32 bits? Because that is
actually the culprit here.

> BTW, the DT schema is checking ranges hi cell:
>
>                 - 0x01000000
>                 - 0x02000000
>                 - 0x03000000
>                 - 0x42000000
>                 - 0x43000000
>                 - 0x81000000
>                 - 0x82000000
>                 - 0x83000000
>                 - 0xc2000000
>                 - 0xc3000000
>
> I just went with what I found in dts files. Sounds like 03 and 83 should
> be removed. (Really, bit 31 or relocatable should probably not be set
> either.)
>

I don't think this needs to change.

> There's a number of other cases:
>
> Documentation/devicetree/bindings/numa.txt:             ranges = <0x03000000 0x8010 0x00000000 0x8010 0x00000000 0x70 0x00000000>;
> Documentation/devicetree/bindings/numa.txt:             ranges = <0x03000000 0x9010 0x00000000 0x9010 0x00000000 0x70 0x00000000>;
> Documentation/devicetree/bindings/pci/mediatek-pcie.txt-                          0x83000000 0 0x60000000 0 0x60000000 0 0x10000000>;   /* memory space */
> Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml:                    ranges = <0x03000000 0x0 0x78000000 0x0 0x78000000 0x0 0x04000000>;
> Documentation/devicetree/bindings/pci/mobiveil-pcie.txt:                ranges = < 0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
> Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt:   ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x600000
> arch/arm/boot/dts/mt7623.dtsi-                    0x83000000 0 0x60000000 0 0x60000000 0 0x10000000>;
> arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi:               ranges = <0x83000000 0 0x00000000 0 0x00000000 0 0x20000000>;
> arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi:               ranges = <0x83000000 0 0x00000000 0 0x30000000 0 0x20000000>;
> arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi:               ranges = <0x83000000 0 0x00000000 0 0x60000000 0 0x00c00000>;
> arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi:       ranges = <0x83000000 0 0x10000000 0 0x10000000 0 0x20000000>;
> arch/arm64/boot/dts/rockchip/rk3399.dtsi:               ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000>,
>
> Rob
>
