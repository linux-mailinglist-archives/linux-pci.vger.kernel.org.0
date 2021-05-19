Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E9A388ECE
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 15:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346691AbhESNSt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 09:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346669AbhESNSs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 09:18:48 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0112C06175F;
        Wed, 19 May 2021 06:17:27 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i4so18067013ybe.2;
        Wed, 19 May 2021 06:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A6Jfch/p94re7yclpHhujTruAgxqnQLQ1mCUzKRd7q4=;
        b=HhG/A45dQa4qIzMfTz89p780PIxvUCDkdamKN59vDz4tkA+G44oUzKWb2+QcYLJbg/
         YXgUbRkWR86EFKC85C1FiB2wZ+SAXAw+B91ZQT6UvbPpWGRVO929S+JWC1apqX4DhMv2
         WmkW4q0/OKhmvgv4cGBBpzmNZT93+9x06jr5K1DrKXNdYOgi9YQcvaI3KqfRJ5K2sp6B
         bDrwFliBuh8SHOmklFnX+0R9CVA4gDNoUG1YR0do25XTGiM/LpAxuPkm8Ygy9tL1h6GC
         Ltapb7DcGuenr+mgI5OPXK7f21C3XFyfNePcfPbFfiHChbQ5YqM2CCvmZDQNhN5nxBr/
         HoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A6Jfch/p94re7yclpHhujTruAgxqnQLQ1mCUzKRd7q4=;
        b=PFSVEqnVvptx+QsMnX1K24M0PyFTxupRLv0jVABV7VfBna1UrOkQwzl9piPwA358fp
         IUr9ckTXHMtHuLb1p1QpniLaPhNVLivBXR9FlGfQ+N99krxGSnzGnx7m/hBbMG+VVlno
         zvGyJdq6H5s4dKk9N8FZe0fxIIcjmEC2odPOcrHDUEh19jCA94T/WJ0bherNY6BaTOlt
         DuDF9DxiOV/Z75wyvO+7pzYQ3O28Wt61JT26QTxPpZER6ESJWOJ/NptdGTIsMkKn44x5
         LH6HXofY2IdQjdV3F8WJ4KwBdmpW3npwnYL1IWFlGl1IM85B1pPGp897gC+/wHcdaZig
         ekeQ==
X-Gm-Message-State: AOAM531Vk3+2ohvdH1OWKJPCnnfZ/SPx1rtQW/N5J0m97saH8p5vBDgT
        kaSAtDoCOotqNCvmYAO0GYzQePHFapuemwen5Zw=
X-Google-Smtp-Source: ABdhPJw8eM94VwtsxsUoGMX8et3EviMo7wG2qk+v7/vGsxDSGV2nDfyBFH2F4v7F6ZUCNeTy/TLZOQAMYVwIibchX0c=
X-Received: by 2002:a5b:303:: with SMTP id j3mr14122782ybp.433.1621430247082;
 Wed, 19 May 2021 06:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com> <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com>
In-Reply-To: <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 19 May 2021 09:17:16 -0400
Message-ID: <CAMdYzYpc4JeGEu6uJt5OnPRBGFzYhZB3UAQf4+TZuDGgA7OaAg@mail.gmail.com>
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        heiko.stuebner@theobroma-systems.com,
        Leonardo Bras <leobras.c@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 19, 2021 at 9:04 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> [ +linux-pci for visibility ]
>
> On 2021-05-18 10:09, Alexandru Elisei wrote:
> > After doing a git bisect I was able to trace the following error when booting my
> > rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:
> >
> > [..]
> > [    0.305183] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> > [    0.305248] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff ->
> > 0x00fa000000
> > [    0.305285] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff ->
> > 0x00fbe00000
> > [    0.306201] rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using dummy
> > regulator
> > [    0.306334] rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using dummy
> > regulator
> > [    0.373705] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
> > [    0.373730] pci_bus 0000:00: root bus resource [bus 00-1f]
> > [    0.373751] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
> > [    0.373777] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus
> > address [0xfbe00000-0xfbefffff])
> > [    0.373839] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
> > [    0.373973] pci 0000:00:00.0: supports D1
> > [    0.373992] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> > [    0.378518] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
> > reconfiguring
> > [    0.378765] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
> > [    0.378869] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> > [    0.379051] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
> > [    0.379661] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by
> > 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe
> > x4 link)
> > [    0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
> > [    0.393311] pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
> > [    0.393333] pci 0000:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
> > [    0.393356] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> > [    0.393375] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> > [    0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
> > [    0.393839] pcieport 0000:00:00.0: PME: Signaling with IRQ 78
> > [    0.394165] pcieport 0000:00:00.0: AER: enabled with IRQ 78
> > [..]
> >
> > to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for
> > 64-bit memory addresses").
>
> FWFW, my hunch is that the host bridge advertising no 32-bit memory
> resource, only only a single 64-bit non-prefetchable one (even though
> it's entirely below 4GB) might be a bit weird and tripping something up
> in the resource assignment code. It certainly seems like the thing most
> directly related to the offending commit.
>
> I'd be tempted to try fiddling with that in the DT (i.e. changing
> 0x83000000 to 0x82000000 in the PCIe node's "ranges" property) to see if
> it makes any difference. Note that even if it helps, though, I don't
> know whether that's the correct fix or just a bodge around a corner-case
> bug somewhere in the resource code.
>
> Robin.

Good Morning Robin,

It seems we meet again for PCIe issues.
I think you might be onto something about the resource assignment code
doing weird things.
I'm doing early bringup on the rk3566, which has a 1GB address space
at 0x3 0x00000000 for the PCIe controller.
I started with the recent linux-next, so this patch was already applied.
Since it has a large enough address space, I decided to try and get a
DGPU to work with it.
I kept hitting strange issues such as it wouldn't allocate 32bit BARs
in the 64bit space randomly.
I tried messing with the ranges to force it as 32bit, but it would
still be flagged as a 64bit space when finally allocated (I thought
this might be due to the location of the memory).

Here are the ranges that I eventually got to allocate correctly (once).

ranges = <0x01000000 0x0 0x00800000 0x3 0x00800000 0x0 0x00100000
  0x02000000 0x0 0x00900000 0x3 0x00900000 0x0 0x30000000
  0x43000000 0x0 0x30900000 0x3 0x30900000 0x0 0x0f700000>;

It did weird things when I'd change that 0x02000000 to a 0x03000000,
even though the final allocation was flagged as 64bit.

Thanks for everything!
Peter

>
> > For reference, here is the dmesg output when BAR
> > reassignment works:
> >
> > [..]
> > [    0.307381] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> > [    0.307445] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff ->
> > 0x00fa000000
> > [    0.307481] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff ->
> > 0x00fbe00000
> > [    0.308406] rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using dummy
> > regulator
> > [    0.308534] rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using dummy
> > regulator
> > [    0.374676] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
> > [    0.374701] pci_bus 0000:00: root bus resource [bus 00-1f]
> > [    0.374723] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
> > [    0.374746] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus
> > address [0xfbe00000-0xfbefffff])
> > [    0.374808] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
> > [    0.374943] pci 0000:00:00.0: supports D1
> > [    0.374961] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> > [    0.379473] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
> > reconfiguring
> > [    0.379712] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
> > [    0.379815] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> > [    0.379997] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
> > [    0.380607] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by
> > 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe
> > x4 link)
> > [    0.394239] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
> > [    0.394285] pci 0000:00:00.0: BAR 14: assigned [mem 0xfa000000-0xfa0fffff]
> > [    0.394312] pci 0000:01:00.0: BAR 0: assigned [mem 0xfa000000-0xfa003fff 64bit]
> > [    0.394374] pci 0000:00:00.0: PCI bridge to [bus 01]
> > [    0.394395] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
> > [    0.394569] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
> > [    0.394845] pcieport 0000:00:00.0: PME: Signaling with IRQ 78
> > [    0.395153] pcieport 0000:00:00.0: AER: enabled with IRQ 78
> > [..]
> >
> > And here is the output of lspci when BAR reassignment works:
> >
> > # lspci -v
> > 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI Express Root
> > Port (prog-if 00 [Normal decode])
> >      Flags: bus master, fast devsel, latency 0, IRQ 78
> >      Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> >      I/O behind bridge: 00000000-00000fff [size=4K]
> >      Memory behind bridge: fa000000-fa0fffff [size=1M]
> >      Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
> >      Capabilities: [80] Power Management version 3
> >      Capabilities: [90] MSI: Enable+ Count=1/1 Maskable+ 64bit+
> >      Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
> >      Capabilities: [c0] Express Root Port (Slot+), MSI 00
> >      Capabilities: [100] Advanced Error Reporting
> >      Capabilities: [274] Transaction Processing Hints
> >      Kernel driver in use: pcieport
> > lspci: Unable to load libkmod resources: error -2
> >
> > 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD
> > Controller SM981/PM981/PM983 (prog-if 02 [NVM Express])
> >      Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> >      Flags: bus master, fast devsel, latency 0, IRQ 77, NUMA node 0
> >      Memory at fa000000 (64-bit, non-prefetchable) [size=16K]
> >      Capabilities: [40] Power Management version 3
> >      Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> >      Capabilities: [70] Express Endpoint, MSI 00
> >      Capabilities: [b0] MSI-X: Enable+ Count=33 Masked-
> >      Capabilities: [100] Advanced Error Reporting
> >      Capabilities: [148] Device Serial Number 00-00-00-00-00-00-00-00
> >      Capabilities: [158] Power Budgeting <?>
> >      Capabilities: [168] Secondary PCI Express
> >      Capabilities: [188] Latency Tolerance Reporting
> >      Capabilities: [190] L1 PM Substates
> >      Kernel driver in use: nvme
> >
> > I can provide more information if needed (the board is sitting on my desk) and I
> > can help with testing the fix.
> >
> > Thanks,
> >
> > Alex
> >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> >
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
