Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EBC391F1C
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 20:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhEZSbO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 14:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232577AbhEZSbO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 14:31:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26978613BA;
        Wed, 26 May 2021 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622053782;
        bh=didKBIq2P70SS7GvlNuyj3ZEFaCQALxlIaTh/JM6N+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IsmWd2bNpTeJDce8CA7xhaZeEgl3WTqxJ9p+7kV0SJ1kD8/ycLyUHGb8W4+r0eYYj
         YxRHlwVT+DaXo9ng+MwIVBNSEuKqbTXkNMbcaAtLhotE7aw8YGTPdLL4Aggmjv1Nv0
         wgl8kn2toUcEmjS78H9DBTdBY2QFhHdebtPj6fBa37Nvj7b2Gor/MRP4k5BWqzk5SE
         xGlvAvekapJYYU3rc3R5X+O0MVpEOYQ1nE2bJwgY44plgAlSWTNk2jnpwZvWOv8bll
         aj9aVgA4RNlclP9q8PZVv29MWQMj0m3IfMHrrqo4uxWQAMyV1UUe+67gAzRgC7GSt0
         Fo7bioxOooZwQ==
Date:   Wed, 26 May 2021 13:29:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jingfeng Sui <suijingfeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH 5/5] PCI: Support ASpeed VGA cards behind a misbehaving
 bridge
Message-ID: <20210526182940.GA1303599@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tx0kr7xdA8eB2+u6Xg0C7FSMbZEKGVKOTZEkdA7Kay42A@mail.gmail.com>
X-time: 90
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 01:00:33PM +1000, Dave Airlie wrote:
> > > > > I think I would see if it's possible to call
> > > > > vga_arb_select_default_device() from vga_arbiter_add_pci_device()
> > > > > instead of from vga_arb_device_init().
> > > > >
> > > > > I would also (as a separate patch) try to get rid of this loop in
> > > > > vga_arb_device_init():
> > > > >
> > > > >         list_for_each_entry(vgadev, &vga_list, list) {
> > > > >                 struct device *dev = &vgadev->pdev->dev;
> > > > >
> > > > >                 if (vgadev->bridge_has_one_vga)
> > > > >                         vgaarb_info(dev, "bridge control possible\n");
> > > > >                 else
> > > > >                         vgaarb_info(dev, "no bridge control possible\n");
> > > > >         }
> > > > >
> > > > > and do the vgaarb_info() in vga_arbiter_check_bridge_sharing(), where
> > > > > the loop would not be needed.
> > > >
> > > > Any updates?
> > >
> > > Are you waiting for me to do something else?
> > >
> > > I suggested an approach above, but I don't have time to actually do
> > > the work for you.
> >
> > Yes, I am really waiting... but I am also investigating history
> > and thinking.

Well, don't wait for me because this work is not on my to-do list :)

> > If I haven't missed something (correct me if I'm wrong). For the
> > original HiSilicon problem, the first attempt is to modify
> > vga_arbiter_add_pci_device() and remove the VGA_RSRC_LEGACY_MASK
> > check. But vga_arbiter_add_pci_device() is called for each PCI device,
> > so removing that check will cause the first VGA device to be the
> > default VGA device. This breaks some x86 platforms, so after that you
> > don't touch vga_arbiter_add_pci_device(), but add
> > vga_arb_select_default_device() in vga_arb_device_init().
> >
> > If the above history is correct, then we cannot add
> > vga_arb_select_default_device() in vga_arbiter_add_pci_device()
> > directly. So it seems we can only add vga_arb_select_default_device()
> > in pci_notify(). And if we don't care about hotplug, we can simply use
> > subsys_initcall_sync() to wrap vga_arb_device_init().
> >
> > And DRM developers, please let me know what do you think about?
> 
> I'm not 100% following what is going on here.
> 
> Do you need call vga_arb_select_default_device after hotplug for some
> reason, or it this just a race with subsys_init?
> 
> I think just adding subsys_initcall_sync should be fine

Doing subsys_initcall_sync(vga_arb_device_init) is probably "OK".  I
don't think it's *great* because initcalls don't make dependencies
explicit so it won't be obvious *why* it's subsys_initcall_sync, and
it feels a little like a band-aid.

> I don't see why you'd want to care about making a hotplug VGA device
> the default at this point.

I don't think hotplug per se is relevant for this ASpeed case.

But I think the current design is slightly broken in that we set up
the machinery to call vga_arbiter_add_pci_device() for hot-added
devices, but a hot-added device can never be set as the default VGA
device.

Imagine a system with a single VGA device.  If that device is plugged
in before boot, it becomes the default VGA device.  If it is hot-added
after boot, it does not.  That inconsistency feels wrong to me.

If it were possible to set the default VGA device in
vga_arbiter_add_pci_device(), it would fix that inconsistency and
solve the ASpeed case.  But maybe that's not practical.

Bjorn
