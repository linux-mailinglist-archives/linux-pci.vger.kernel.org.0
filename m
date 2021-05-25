Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F5138FFAD
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 13:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhEYLEq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 07:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhEYLEq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 07:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA12A6141C
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621940596;
        bh=Ws+k1wf0tUodjMx7Zs+d1KBnXjPXQXlQd3fl6k/VbJk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W3FbPTBErOrzLofezMNOgHVGZcj6eh7oxrCpcLjQF4h1+AuvIsQfpzIXiUVHWq+/4
         nhwkgB4OUfuZ0jLTAa1/uWhQS8sD/fTvlTX4/1fJkqClY4sUuX1oU8Qo5FTpdTXSKv
         NE/NQNKu8G/OfHdhOev8uLMC4Hu/yAkNYIfGqYolIHZb/ju7VyOYooGLZ+f71FbM49
         ycP3YMrNLN3frmVR+3jD5zttKW9YWJpiKPSjUGJcmOIASfMIL/fd096JWuIOdg1RWi
         PadDL+ALogMK6OLMu2ajUnBRnJcRwJTxt53g7AU+/aWPv690wglKOlarHdYpWrrIKW
         ZTEg19G6xyAUQ==
Received: by mail-il1-f180.google.com with SMTP id c4so10422484iln.7
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 04:03:16 -0700 (PDT)
X-Gm-Message-State: AOAM530f88zHeDa0wiHALAFp3i+jOydehaRpRk8zKU1xnL1UbXkEA3xW
        ogOC1ziAFQ82ct4qeRUjGCaj0UtiUmje4qmrWAs=
X-Google-Smtp-Source: ABdhPJz6geHTeY6G9h33J9HkCEyF7A3um3qBCyTJewhvPR1yMysVNHVpP8DU3iNK35aZQjq5UGn1nYHeltpPq+y00F4=
X-Received: by 2002:a05:6e02:927:: with SMTP id o7mr17906252ilt.35.1621940596091;
 Tue, 25 May 2021 04:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H4pn53XC7qVvwM792ppkQRnjWpPDwmrhBv8twgQu0eabQ@mail.gmail.com>
 <20210519193327.GA248667@bjorn-Precision-5520>
In-Reply-To: <20210519193327.GA248667@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 25 May 2021 19:03:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7D-drrEaDskQhVx0c8_VAy--n3mbsQN_ijfWrRQGVQ=A@mail.gmail.com>
Message-ID: <CAAhV-H7D-drrEaDskQhVx0c8_VAy--n3mbsQN_ijfWrRQGVQ=A@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: Support ASpeed VGA cards behind a misbehaving bridge
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jingfeng Sui <suijingfeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Thu, May 20, 2021 at 3:33 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, May 19, 2021 at 10:17:14AM +0800, Huacai Chen wrote:
> > On Wed, May 19, 2021 at 3:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, May 18, 2021 at 03:13:43PM +0800, Huacai Chen wrote:
> > > > On Tue, May 18, 2021 at 2:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Mon, May 17, 2021 at 08:53:43PM +0800, Huacai Chen wrote:
> > > > > > On Sat, May 15, 2021 at 5:09 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > > > > On Fri, May 14, 2021 at 11:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > On Fri, May 14, 2021 at 04:00:25PM +0800, Huacai Chen wrote:
> > > > > > > > > According to PCI-to-PCI bridge spec, bit 3 of Bridge Control Register is
> > > > > > > > > VGA Enable bit which modifies the response to VGA compatible addresses.
> > > > > > > >
> > > > > > > > The bridge spec is pretty old, and most of the content has been
> > > > > > > > incorporated into the PCIe spec.  I think you can cite "PCIe r5.0, sec
> > > > > > > > 7.5.1.3.13" here instead.
> > > > > > > >
> > > > > > > > > If the VGA Enable bit is set, the bridge will decode and forward the
> > > > > > > > > following accesses on the primary interface to the secondary interface.
> > > > > > > >
> > > > > > > > *Which* following accesses?  The structure of English requires that if
> > > > > > > > you say "the following accesses," you must continue by *listing* the
> > > > > > > > accesses.
> > > > > > > >
> > > > > > > > > The ASpeed AST2500 hardward does not set the VGA Enable bit on its
> > > > > > > > > bridge control register, which causes vgaarb subsystem don't think the
> > > > > > > > > VGA card behind the bridge as a valid boot vga device.
> > > > > > > >
> > > > > > > > s/hardward/bridge/
> > > > > > > > s/vga/VGA/ (also in code comments and dmesg strings below)
> > > > > > > >
> > > > > > > > From the code, it looks like AST2500 ([1a03:2000]) is a VGA device,
> > > > > > > > since it apparently has a VGA class code.  But here you say the
> > > > > > > > AST2500 has a Bridge Control register, which suggests that it's a
> > > > > > > > bridge.  If AST2500 is some sort of combination that includes both a
> > > > > > > > bridge and a VGA device, please outline that topology.
> > > > > > > >
> > > > > > > > But the hardware defect is that some bridges forward VGA accesses even
> > > > > > > > though their VGA Enable bit is not set?  The quirk should be attached
> > > > > > > > to broken *bridges*, not to VGA devices.
> > > > > > > >
> > > > > > > > If a bridge forwards VGA accesses regardless of how its VGA Enable bit
> > > > > > > > is set, that means VGA arbitration (in vgaarb.c) cannot work
> > > > > > > > correctly, so merely setting the default VGA device once in a quirk is
> > > > > > > > not sufficient.  You would have to somehow disable any future attempts
> > > > > > > > to use other VGA devices.  Only the VGA device below this defective
> > > > > > > > bridge is usable.  Any other VGA devices in the system would be
> > > > > > > > useless.
> > > > > > > >
> > > > > > > > > So we provide a quirk to fix Xorg auto-detection.
> > > > > > > > >
> > > > > > > > > See similar bug:
> > > > > > > > >
> > > > > > > > > https://patchwork.kernel.org/project/linux-pci/patch/20170619023528.11532-1-dja@axtens.net/
> > > > > > > >
> > > > > > > > This patch was never merged.  If we merged a revised version, please
> > > > > > > > cite the SHA1 instead.
> > > > > > >
> > > > > > > This patch has never merged, and I found that it is unnecessary after
> > > > > > > commit a37c0f48950b56f6ef2ee637 ("vgaarb: Select a default VGA device
> > > > > > > even if there's no legacy VGA"). Maybe this ASpeed patch is also
> > > > > > > unnecessary. If it is still needed, I'll investigate the root cause.
> > > > > >
> > > > > > I found that vga_arb_device_init() and pcibios_init() are both wrapped
> > > > > > by subsys_initcall(), which means their sequence is unpredictable. And
> > > > > > unfortunately, in our platform vga_arb_device_init() is called before
> > > > > > pcibios_init(), which makes vga_arb_device_init() fail to set a
> > > > > > default vga device. This is the root cause why we thought that we
> > > > > > still need a quirk for AST2500.
> > > > >
> > > > > Does this mean there is no hardware defect here?  The VGA Enable bit
> > > > > works correctly?
> > > > >
> > > > No, VGA Enable bit still doesn't set, but with commit
> > > > a37c0f48950b56f6ef2ee637 ("vgaarb: Select a default VGA device even if
> > > > there's no legacy VGA") we no longer depend on VGA Enable.
> > >
> > > Correct me if I'm wrong:
> > >
> > >   - On the AST2500 bridge [1a03:1150], the VGA Enable bit is
> > >     read-only 0.
> > >
> > >   - The AST2500 bridge never forwards VGA accesses ([mem
> > >     0xa0000-0xbffff], [io 0x3b0-0x3bb], [io 0x3c0-0x3df]) to its
> > >     secondary bus.
> > >
> > > The VGA Enable bit is optional, and if both the above are true, the
> > > bridge is working correctly per spec, and the quirk below is not the
> > > right solution, and whatever solution we come up with should not
> > > claim that the bridge is misbehaving.
> > Yes, you are right, the bridge is working correctly, which is similar
> > to HiSilicon D05.
> >
> >
> > >
> > > > > > I think the best solution is make vga_arb_device_init() be wrapped by
> > > > > > subsys_initcall_sync(), do you think so?
> > > > >
> > > > > Hmm.  Unfortunately the semantics of subsys_initcall_sync() are not
> > > > > documented, so I'm not sure exactly *why* such a change would work and
> > > > > whether we could rely on it to continue working.
> > > > >
> > > > > pcibios_init() isn't very consistent across arches.  On some,
> > > > > including alpha, microblaze, some MIPS platforms, powerpc, and sh, it
> > > > > enumerates PCI devices.  On others (ia64, parisc, sparc, x86), it does
> > > > > basically nothing.  That makes life a little difficult.
> > > >
> > > > subsys_initcall_sync() is ensured after all subsys_initcall()
> > > > functions, so at least it can solve the problem on platforms which use
> > > > pcibios_init() to enumerate PCI devices (x86 and other ACPI-based
> > > > platforms are also OK, because they use acpi_init()
> > > > -->acpi_scan_init() -->pci_acpi_scan_root() to enumerate devices).
> > >
> > > More details in my response to suijingfeng:
> > > https://lore.kernel.org/r/20210518193100.GA148462@bjorn-Precision-5520
> > >
> > > I'd rather not fiddle with the initcall ordering.  That mechanism is
> > > fragile and I'd prefer something more robust.
> > >
> > > I'm wondering whether it's practical to do something in the normal PCI
> > > enumeration path, e.g., in pci_init_capabilities().  Maybe we can
> > > detect the default VGA device as we enumerate it.  Then we wouldn't
> > > have this weird process of "find all PCI devices first, then scan for
> > > the default VGA device, and oh, by the way, also check for VGA devices
> > > hot-added later."
> >
> > If we don't want to rely on initcall order, and want to solve the
> > hot-added case, then can we add vga_arb_select_default_device() in
> > pci_notify() when (action == BUS_NOTIFY_ADD_DEVICE &&
> > !vga_default_device())?
>
> I think I would see if it's possible to call
> vga_arb_select_default_device() from vga_arbiter_add_pci_device()
> instead of from vga_arb_device_init().
>
> I would also (as a separate patch) try to get rid of this loop in
> vga_arb_device_init():
>
>         list_for_each_entry(vgadev, &vga_list, list) {
>                 struct device *dev = &vgadev->pdev->dev;
>
>                 if (vgadev->bridge_has_one_vga)
>                         vgaarb_info(dev, "bridge control possible\n");
>                 else
>                         vgaarb_info(dev, "no bridge control possible\n");
>         }
>
> and do the vgaarb_info() in vga_arbiter_check_bridge_sharing(), where
> the loop would not be needed.
Any updates?

Huacai
>
> Bjorn
