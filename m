Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F19838DB1E
	for <lists+linux-pci@lfdr.de>; Sun, 23 May 2021 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhEWMMX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 May 2021 08:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231735AbhEWMMX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 May 2021 08:12:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0090F61159;
        Sun, 23 May 2021 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621771857;
        bh=5JO2LxhXrOK58oNJTJ20myWP78aa+/40qU7LRR21u1o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t5SuI4C1bEbMv5JvVzfnEYnO4A4hNJmbF6OjzZ0HF70nwmDoSNhIcn1NYWFaKoQa9
         nc333Ar/y/LYf/ZE5IWkO1db4E083oBtG+7UVNY0AObaWHtt5Z/gTeEbmobImYawJt
         15VlMFQKXq1SoTh2c296tNHR71iPN5sC1Gfjue3p5P9yVEy8CsI7/Bj7HmFgFN98Nm
         GQOWeXG74JwAgxegTMoFLd7Z0GICP9PS1NMJOu5ytYAJVSWz50XzU9pM9Lz+LzoJXL
         x+BIbamcJnxb/DDBbnuoGSin19QHuOFUgWGffbKfqWvQf1jDvLYCNDvo2MUkECTq28
         BwNZLj7+DVX6A==
Received: by mail-oi1-f177.google.com with SMTP id y76so15230456oia.6;
        Sun, 23 May 2021 05:10:56 -0700 (PDT)
X-Gm-Message-State: AOAM533BePgDWy1dffVURe8Y0S40oqN7CQE2e1KGMQHlbDC1gJItypZb
        W/L5LRxxcljqFoabt8podYuTAPA67OqYiRDDS2k=
X-Google-Smtp-Source: ABdhPJyfGAivPerflxqvZ8zeNDpNrnjqzjt21e5mLIM4h6jZ0wAmIa8bbwUDuprzQ4LGeui46DP466uXci66TZQNUYw=
X-Received: by 2002:aca:4343:: with SMTP id q64mr7777331oia.33.1621771856367;
 Sun, 23 May 2021 05:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com> <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com>
 <87eedxbtkn.fsf@stealth>
In-Reply-To: <87eedxbtkn.fsf@stealth>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 23 May 2021 14:10:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE3U+16A6bO0UHG8=sx45DE6u0FtdSnoLDvfGnFJYTDrg@mail.gmail.com>
Message-ID: <CAMj1kXE3U+16A6bO0UHG8=sx45DE6u0FtdSnoLDvfGnFJYTDrg@mail.gmail.com>
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        leobras.c@gmail.com, Rob Herring <robh@kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 23 May 2021 at 13:06, Punit Agrawal <punitagrawal@gmail.com> wrote:
>
> Robin Murphy <robin.murphy@arm.com> writes:
>
> > [ +linux-pci for visibility ]
> >
> > On 2021-05-18 10:09, Alexandru Elisei wrote:
> >> After doing a git bisect I was able to trace the following error when booting my
> >> rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:
> >> [..]
> >> [    0.305183] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> >> [    0.305248] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff ->
> >> 0x00fa000000
> >> [    0.305285] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff ->
> >> 0x00fbe00000
> >> [    0.306201] rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using dummy
> >> regulator
> >> [    0.306334] rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using dummy
> >> regulator
> >> [    0.373705] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
> >> [    0.373730] pci_bus 0000:00: root bus resource [bus 00-1f]
> >> [    0.373751] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
> >> [    0.373777] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus
> >> address [0xfbe00000-0xfbefffff])
> >> [    0.373839] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
> >> [    0.373973] pci 0000:00:00.0: supports D1
> >> [    0.373992] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> >> [    0.378518] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
> >> reconfiguring
> >> [    0.378765] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
> >> [    0.378869] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> >> [    0.379051] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
> >> [    0.379661] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by
> >> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe
> >> x4 link)
> >> [    0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
> >> [    0.393311] pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
> >> [    0.393333] pci 0000:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
> >> [    0.393356] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> >> [    0.393375] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> >> [    0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
> >> [    0.393839] pcieport 0000:00:00.0: PME: Signaling with IRQ 78
> >> [    0.394165] pcieport 0000:00:00.0: AER: enabled with IRQ 78
> >> [..]
> >> to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to
> >> resource flags for
> >> 64-bit memory addresses").
> >
> > FWFW, my hunch is that the host bridge advertising no 32-bit memory
> > resource, only only a single 64-bit non-prefetchable one (even though
> > it's entirely below 4GB) might be a bit weird and tripping something
> > up in the resource assignment code. It certainly seems like the thing
> > most directly related to the offending commit.
> >
> > I'd be tempted to try fiddling with that in the DT (i.e. changing
> > 0x83000000 to 0x82000000 in the PCIe node's "ranges" property) to see
> > if it makes any difference. Note that even if it helps, though, I
> > don't know whether that's the correct fix or just a bodge around a
> > corner-case bug somewhere in the resource code.
>
> From digging into this further the failure seems to be due to a mismatch
> of flags when allocating resources in pci_bus_alloc_from_region() -
>
>     if ((res->flags ^ r->flags) & type_mask)
>             continue;
>
> Though I am also not sure why the failure is only being reported on
> RK3399 - does a single 64-bit window have anything to do with it?
>

The NVMe in the example exposes a single 64-bit non-prefetchable BAR.
Such BARs can not be allocated in a prefetchable host bridge window
(unlike the converse, i.e., allocating a prefetchable BAR in a
non-prefetchable host bridge window is fine)

64-bit non-prefetchable host bridge windows cannot be forwarded by PCI
to PCI bridges, they simply lack the BAR registers to describe them.
Therefore, non-prefetchable endpoint BARs (even 64-bit ones) need to
be carved out of a host bridge's non-prefetchable 32-bit window if
they need to pass through a bridge.

So the error seems to be here that the host bridge's 32-bit
non-prefetchable window has the 64-bit attribute set, even though it
resides below 4 GB entirely. I suppose that the resource allocation
could be made more forgiving (and it was in the past, before commit
9d57e61bf723 was applied). However, I would strongly recommend not
deviating from common practice, and just describe the 32-bit
addressable non-prefetchable resource window as such.



> Also, I don't understand the motivation for the original commit. It is
> not clear what problem it is solving and the discussion thread seems to
> suggest that things work fine without it[0].
>
> [0] https://lore.kernel.org/linux-devicetree/CAL_JsqJXKVUFh9KrJjobn-jE-PFKN0w-V_i3qkfBrpTah4g8Xw@mail.gmail.com/
>
> [...]
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
