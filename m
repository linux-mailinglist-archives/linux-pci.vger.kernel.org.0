Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF93C29910C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 16:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783932AbgJZPds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 11:33:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40057 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769833AbgJZPds (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 11:33:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id m128so10869797oig.7;
        Mon, 26 Oct 2020 08:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Npr8JFXnNVuOd5JBeJSU1d/jU6NcSqcvSBeX3MQnMCw=;
        b=sH8yJaENEr9zRQqaDTeQATgawIviJucH7DkUXXsgh8DUOOgsVqXmevMa7ZuxmlFGmy
         1ohrWmb9/tj16yPG2s5pYTUROLtqGX/V10vi7a47Jgx1G2P18lLhl/NRZoc2dtnuTq9V
         iVyOzl5cucanZmyyOk6EuYGtLfig1zg1LplGrstjAUprL4QMyZxP9eeOtIL4T9KcASBy
         dPAqu+c9EVn3dbX04FohmSHSW+og8a7/byFE3+GVynRI9ZrKm5Ptkr7U8K3dpMPA10ky
         4e7T0lFGmuvfJdjGN0eTaDtE7O6PF/pANZLirGwbTY+4ntfDrCUB2bj+Nk2Z+8MEGODV
         J7Aw==
X-Gm-Message-State: AOAM530FuyZkAkAPmr4PIiuMp5gaI7duxLyjIIOJe72FXaJ7sHD2h1pZ
        tIVjAA9nkCzA72riuBn4rTS73gPBeriHdAJbV4Q=
X-Google-Smtp-Source: ABdhPJwLqZF2nUpKrvhcxyI34nr4X7bBy8icWsJGObwdQ8i/5k3Ztdf2PJq2vrTAVMJP3VVhuKLd7HTBbICac/wUeIE=
X-Received: by 2002:aca:c490:: with SMTP id u138mr13399294oif.54.1603726426441;
 Mon, 26 Oct 2020 08:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200916061500.1970090-1-hch@lst.de> <20200916061500.1970090-7-hch@lst.de>
In-Reply-To: <20200916061500.1970090-7-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Oct 2020 16:33:34 +0100
Message-ID: <CAMuHMdX9c0va_EqBw1wfD_JiVPpjiBPLzE88EmLGVLfVhECugw@mail.gmail.com>
Subject: Re: [PATCH 6/6] dma-mapping: introduce DMA range map, supplanting dma_pfn_offset
To:     Christoph Hellwig <hch@lst.de>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Linux IOMMU <iommu@lists.linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph, Jim,

On Wed, Sep 16, 2020 at 8:30 AM Christoph Hellwig <hch@lst.de> wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>
>
> The new field 'dma_range_map' in struct device is used to facilitate the
> use of single or multiple offsets between mapping regions of cpu addrs and
> dma addrs.  It subsumes the role of "dev->dma_pfn_offset" which was only
> capable of holding a single uniform offset and had no region bounds
> checking.
>
> The function of_dma_get_range() has been modified so that it takes a single
> argument -- the device node -- and returns a map, NULL, or an error code.
> The map is an array that holds the information regarding the DMA regions.
> Each range entry contains the address offset, the cpu_start address, the
> dma_start address, and the size of the region.
>
> of_dma_configure() is the typical manner to set range offsets but there are
> a number of ad hoc assignments to "dev->dma_pfn_offset" in the kernel
> driver code.  These cases now invoke the function
> dma_direct_set_offset(dev, cpu_addr, dma_addr, size).
>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> [hch: various interface cleanups]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for your patch, which is now commit e0d072782c734d27
("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset") in
v5.10-rc1, and to which I have bisected a PCIe failure on R-Car M2-W
(r8a7791/koelsch).

The first PCI host bridge, containing USB, probes fine:

 pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
 pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff -> 0x00ee080000
 pci-rcar-gen2 ee090000.pci: PCI: revision 11
 pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
 pci_bus 0000:00: root bus resource [bus 00]
 pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
 pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
 pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
 pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
 pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
 pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
 pci 0000:00:01.0: supports D1 D2
 pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
 pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
 pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
 pci 0000:00:02.0: supports D1 D2
 pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
 PCI: bus0: Fast back to back transfers disabled
 pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
 pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
 pci 0000:00:01.0: enabling device (0140 -> 0142)
 pci 0000:00:02.0: enabling device (0140 -> 0142)

The second PCI host bridge, connected to an (empty) PCIe slot, fails:

 pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ranges:
 pci-rcar-gen2 ee0d0000.pci:      MEM 0x00ee0c0000..0x00ee0cffff -> 0x00ee0c0000
 pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
 pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
 pci_bus 0001:01: root bus resource [bus 01]
 pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
 pci 0001:01:00.0: [1033:0000] type 00 class 0x060000
 pci 0001:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
 pci 0001:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
 pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310
 pci 0001:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
 pci 0001:01:01.0: supports D1 D2
 pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
 pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320
 pci 0001:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
 pci 0001:01:02.0: supports D1 D2
 pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
 PCI: bus1: Fast back to back transfers disabled
 pci 0001:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
 pci 0001:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
 pci 0001:01:01.0: enabling device (0140 -> 0142)
 pci 0001:01:02.0: enabling device (0140 -> 0142)
-rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
-rcar-pcie fe000000.pcie:       IO 0x00fe100000..0x00fe1fffff -> 0x0000000000
-rcar-pcie fe000000.pcie:      MEM 0x00fe200000..0x00fe3fffff -> 0x00fe200000
-rcar-pcie fe000000.pcie:      MEM 0x0030000000..0x0037ffffff -> 0x0030000000
-rcar-pcie fe000000.pcie:      MEM 0x0038000000..0x003fffffff -> 0x0038000000
-rcar-pcie fe000000.pcie:   IB MEM 0x0040000000..0x00bfffffff -> 0x0040000000
-rcar-pcie fe000000.pcie:   IB MEM 0x0200000000..0x02ffffffff -> 0x0200000000
-rcar-pcie fe000000.pcie: PCIe link down
+rcar-pcie fe000000.pcie: Adjusted size 0x0 invalid
+rcar-pcie: probe of fe000000.pcie failed with error -22

I've posted a patch "[PATCH] dma-mapping: Fix 32-bit overflow with
CONFIG_ARM_LPAE=n"
(https://lore.kernel.org/linux-arm-kernel/20201026152755.3738293-1-geert+renesas@glider.be/).

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
