Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B3B388087
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 21:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351854AbhERTcV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 15:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhERTcU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 May 2021 15:32:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D89766112F;
        Tue, 18 May 2021 19:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621366262;
        bh=qy3dri+EEdFWcNhF1NsI/oEWt0469pxCFejX2pAgwPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uml5If0LH6RWhlKMQeQi+vm6236bmCIcgI7i5h1FhvCr4HUc6Eg8jCpHd3VwMOMi/
         DHDHf0ppzaNE66urbCp8u3RpSlLXaCUwUawC8w5xBGYnXvTcLBAYFRxIylPTLu6yB5
         GA99rcumLUi3BGtoZ7e9rJJ56oouqGR4/Sw8zO8xLmNdZiUWofHyyYIF6uLk/jynw2
         yPopMvoKALWbRE6Ze8j8NU/Zxgj5y8TrEyXiYhMYh2V5r5ZW+TY9+5fKBIaFCvcSHA
         e28O0/49XQ4YrxU8CNhXvZZ5WwrWib8E9Tt3BLml6T3dkMvL+hL3j6gwa3fSvqbxXF
         ds7aM5s6EkmjA==
Date:   Tue, 18 May 2021 14:31:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     suijingfeng <suijingfeng@loongson.cn>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 5/5] PCI: Support ASpeed VGA cards behind a misbehaving
 bridge
Message-ID: <20210518193100.GA148462@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ebc8c3d-f5dd-55fb-22a3-15fd0449d149@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 18, 2021 at 05:30:38PM +0800, suijingfeng wrote:
> On 2021/5/18 上午11:09, Bjorn Helgaas wrote:
> 
> > If VGA Enable is 0 and cannot be set to 1, the bridge should *never*
> > forward VGA accesses to its secondary bus.  The generic VGA driver
> > that uses the legacy [mem 0xa0000-0xbffff] range should not work with
> > the VGA device at 05:00.0, and that device cannot participate in the
> > VGA arbitration scheme, which relies on the VGA Enable bit.
> > 
> > If you have a driver for 05:00.0 that doesn't need the legacy memory
> > range, it's possible that it may work.  But VGA arbitration will be
> > broken, and if 05:00.0 needs to be initialized by an option ROM, that
> > probably won't work either.
> 
> We are not using a "generic VGA driver", in user space, we are using the
> modesetting driver come with X server, and it seems work normally. The real
> problems is VGA arbitration will not set 05:00.0 as the default VGA which
> means that when X server read
> /sys/devices/pci0000:00/0000:00:0c.0/0000:04:00.0/0000:05:00.0/boot_vga will
> get a "0". This break Xorg auto-detection. We want the boot_vga sysfs file
> be "1".

I don't think it's true; I think VGA arbitration *will* set 05:00.0 as
the default VGA, as long as 05:00.0 has been enumerated before
vga_arb_device_init().

As far as I can tell, the problem is not that the bridge is broken or
that vga_arb_device_init() is broken.  The problem is that on your
system, vga_arb_device_init() runs before 05:00.0 has been enumerated,
so it *can't* set 05:00.0 as the default VGA because it doesn't know
about 05:00.0 at all.

> > If the 04:00.0 bridge *always* forwards VGA accesses, even though its
> > VGA Enable bit is always zero, then the bridge is broken.  In that
> > case, the generic VGA driver should work with the 05:00.0 device, but
> > VGA arbitration will be limited.  I'm not sure, but the arbiter
> > *might* be able to use the VGA Enable bit in the 00:0c.0 bridge to
> > control VGA access to 05:00.0.  You wouldn't be able to have more than
> > one VGA device below 00:0c.0, and you may not be able have more than
> > one in the entire system.
> 
> We have only one VGA device(05:00.0) below 00:0c.0, but we do able to have
> more than one in the entire system. We could even mount a AMDGPU
> on this server. But in reality, there is a render only GPU and a
> self-designed display controller integrated in LS7A1000 bridge. Both the
> render only GPU and the display controller is PCI device, they are located
> at PCI root bus directly without a PCI-to-PCI bridge in the middle. The
> display controller is blocked by the firmware if ASPEED BMC card is present,
> it can't be accessed under linux kernel. Let me show you a updated version
> of the PCI topology of our server(machine):
> 
>        /sys/devices/pci0000:00
>        |-- 0000:00:06.0
>        |   | -- class (0x040000)
>        |   | -- vendor (0x0014)
>        |   | -- device (0x7a15)
>        |   | -- drm
>        |   | -- ...
>        |-- 0000:00:0c.0
>        |   |-- class (0x060400)
>        |   |-- vendor (0x0014)
>        |   |-- device (0x7a09)
>        |   |-- ...
>        |   |-- 0000:04:00.0
>        |   |   | -- class (0x060400)
>        |   |   | -- device (0x1150)
>        |   |   | -- vendor (0x1a03)
>        |   |   | -- revision (0x04)
>        |   |   | -- ...
>        |   |   | -- 0000:05:00.0
>        |   |   |    | -- class  (0x030000)
>        |   |   |    | -- device (0x2000)
>        |   |   |    | -- vendor (0x1a03)
>        |   |   |    | -- boot_vga
>        |   |   |    | -- i2c-6
>        |   |   |    | -- drm
>        |   |   |    | -- graphics
>        |   |   |    | -- ...
>        |   `-- uevent
>        `-- ...
> 
> Even through the render only GPU(00:06.0) is not a VGA device, it still can
> disturb X server choose a primary device to use. But the root cause is the
> kernel side does not set 05:00.0 as default VGA. In this case X server will
> fallback to the first device found to use. and 00:06.0 is always found
> before 05:00.0. If kernel side set 05:00.0 as default VGA,
> all other problems is secondary.

The fact that X selects 00:06.0 is a user-level thing and I don't know
what's involved.  Its class code (0x0400) looks like
PCI_CLASS_MULTIMEDIA_VIDEO, so vga_arb_device_init() should completely
ignore it.

vga_arb_device_init() should set 05:00.0 as the *kernel's* default
device as long as 05:00.0 has already been enumerated.

Even if vga_arb_device_init() runs before 05:00.0 has been enumerated,
it looks like vga_arbiter_add_pci_device() should notice when 05:00.0
is enumerated, and you should see the "VGA device added:" message for
it.

vga_arbiter_add_pci_device() looks like it *would* set 05:00.0 as the
default device in that case, except for the fact that 04:00.0 doesn't
support PCI_BRIDGE_CTL_VGA.  That's probably a bug in a37c0f48950b
("vgaarb: Select a default VGA device even if there's no legacy VGA").
I think the logic added by a37c0f48950b probably should be shared
between the vga_arb_device_init() initcall path and the
vga_arbiter_add_pci_device() device-add path.

Can you collect your dmesg output, so we can see the enumeration order
and what vgaarb does with it?

Bjorn
