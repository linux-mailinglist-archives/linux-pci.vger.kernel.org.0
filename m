Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB553884B3
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 04:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhESCSq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 22:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhESCSq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 22:18:46 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD60C06175F
        for <linux-pci@vger.kernel.org>; Tue, 18 May 2021 19:17:27 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id o10so9924456ilm.13
        for <linux-pci@vger.kernel.org>; Tue, 18 May 2021 19:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RyY/nChTPXB1ZJwkRNspBaO0xxNTlKfDpAuuQM3xE2Q=;
        b=iM3vsuWFWCtdTLsgrGwH9FU1EVJzUl8afeQh5eeoWDxVq9rjXFcmiPLsU+Huzrj93K
         XQht7kQJQM3LnYWV8Ea0pnw6rdq0FUp/zqz4cXxd0v6azevp/jDgz4sWk2c2eN68rh1a
         /Cc80e2iIXHV19Op/xJeFC2RTbJxH+/YZQNAd88Rrk2Ib+VGef8gPYHm5wWmgnXzrb0A
         mOkVhL+D0x6hpAYJMsZet5HTSVIvM/F9zv1tginQyFl5mOou0CZZFoOaYGQBfQQ7DpH5
         GO2mT0gkHinUTOSNdk7fY/gvr5B66R8SqeELgIrJU4+BQo1hXzB0L17hIi8lNZeKSdTU
         //Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyY/nChTPXB1ZJwkRNspBaO0xxNTlKfDpAuuQM3xE2Q=;
        b=kE9nsAwKnkHGvkg5e+bmHEYEW12IhoaokoYd/cAIhHdJAW6yXwXqXYnvl49aXgHnS0
         jixR1GawwHIQmSQ4guAPVqJILtQ3bA4V/OO1rLIju/YNW4sV5p17/mooklI02sxsvwFt
         oDGQldCiVwiEcGKi54DlHrd0hbCtVM6UkmqTdsDtu+TQvJieoxXjhDj5Ckixue5k1uAS
         bb2GPsT+MsXVpSHtwuuBF3o8vWTGJ81ie9+GR9mbz56XGpmL+t45/b959XmlinqnrEkZ
         7g37eHzdZ2tis5WzdIpTl71zdybMydIOZxh8/acfjnWJsRCFlVzXyR1q15JrZanqGZmW
         7j8w==
X-Gm-Message-State: AOAM530UO7UFPsI/ywSGGnD3sFgWoI0CaGB/h8yIbTriihy6yFI/qaeS
        QTxHirLjSavIWCXDPVGy/vnp5xyqrE41mxIgW/E=
X-Google-Smtp-Source: ABdhPJzjdr4d9767Ry/Yl1wNVZMK9ABffv3phks4jagvjCwF+FVJQmniMk77rUOxDLWBJ4WheJus3bVAi2IMuiDmIIY=
X-Received: by 2002:a05:6e02:1e05:: with SMTP id g5mr7879305ila.134.1621390646503;
 Tue, 18 May 2021 19:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6T4+qZktfEZ-6eKO5SBp_o3Okbu+aBnH+h7Hy6L-PaXA@mail.gmail.com>
 <20210518193521.GA145968@bjorn-Precision-5520>
In-Reply-To: <20210518193521.GA145968@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 19 May 2021 10:17:14 +0800
Message-ID: <CAAhV-H4pn53XC7qVvwM792ppkQRnjWpPDwmrhBv8twgQu0eabQ@mail.gmail.com>
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

On Wed, May 19, 2021 at 3:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, May 18, 2021 at 03:13:43PM +0800, Huacai Chen wrote:
> > On Tue, May 18, 2021 at 2:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, May 17, 2021 at 08:53:43PM +0800, Huacai Chen wrote:
> > > > On Sat, May 15, 2021 at 5:09 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > > On Fri, May 14, 2021 at 11:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, May 14, 2021 at 04:00:25PM +0800, Huacai Chen wrote:
> > > > > > > According to PCI-to-PCI bridge spec, bit 3 of Bridge Control Register is
> > > > > > > VGA Enable bit which modifies the response to VGA compatible addresses.
> > > > > >
> > > > > > The bridge spec is pretty old, and most of the content has been
> > > > > > incorporated into the PCIe spec.  I think you can cite "PCIe r5.0, sec
> > > > > > 7.5.1.3.13" here instead.
> > > > > >
> > > > > > > If the VGA Enable bit is set, the bridge will decode and forward the
> > > > > > > following accesses on the primary interface to the secondary interface.
> > > > > >
> > > > > > *Which* following accesses?  The structure of English requires that if
> > > > > > you say "the following accesses," you must continue by *listing* the
> > > > > > accesses.
> > > > > >
> > > > > > > The ASpeed AST2500 hardward does not set the VGA Enable bit on its
> > > > > > > bridge control register, which causes vgaarb subsystem don't think the
> > > > > > > VGA card behind the bridge as a valid boot vga device.
> > > > > >
> > > > > > s/hardward/bridge/
> > > > > > s/vga/VGA/ (also in code comments and dmesg strings below)
> > > > > >
> > > > > > From the code, it looks like AST2500 ([1a03:2000]) is a VGA device,
> > > > > > since it apparently has a VGA class code.  But here you say the
> > > > > > AST2500 has a Bridge Control register, which suggests that it's a
> > > > > > bridge.  If AST2500 is some sort of combination that includes both a
> > > > > > bridge and a VGA device, please outline that topology.
> > > > > >
> > > > > > But the hardware defect is that some bridges forward VGA accesses even
> > > > > > though their VGA Enable bit is not set?  The quirk should be attached
> > > > > > to broken *bridges*, not to VGA devices.
> > > > > >
> > > > > > If a bridge forwards VGA accesses regardless of how its VGA Enable bit
> > > > > > is set, that means VGA arbitration (in vgaarb.c) cannot work
> > > > > > correctly, so merely setting the default VGA device once in a quirk is
> > > > > > not sufficient.  You would have to somehow disable any future attempts
> > > > > > to use other VGA devices.  Only the VGA device below this defective
> > > > > > bridge is usable.  Any other VGA devices in the system would be
> > > > > > useless.
> > > > > >
> > > > > > > So we provide a quirk to fix Xorg auto-detection.
> > > > > > >
> > > > > > > See similar bug:
> > > > > > >
> > > > > > > https://patchwork.kernel.org/project/linux-pci/patch/20170619023528.11532-1-dja@axtens.net/
> > > > > >
> > > > > > This patch was never merged.  If we merged a revised version, please
> > > > > > cite the SHA1 instead.
> > > > >
> > > > > This patch has never merged, and I found that it is unnecessary after
> > > > > commit a37c0f48950b56f6ef2ee637 ("vgaarb: Select a default VGA device
> > > > > even if there's no legacy VGA"). Maybe this ASpeed patch is also
> > > > > unnecessary. If it is still needed, I'll investigate the root cause.
> > > >
> > > > I found that vga_arb_device_init() and pcibios_init() are both wrapped
> > > > by subsys_initcall(), which means their sequence is unpredictable. And
> > > > unfortunately, in our platform vga_arb_device_init() is called before
> > > > pcibios_init(), which makes vga_arb_device_init() fail to set a
> > > > default vga device. This is the root cause why we thought that we
> > > > still need a quirk for AST2500.
> > >
> > > Does this mean there is no hardware defect here?  The VGA Enable bit
> > > works correctly?
> > >
> > No, VGA Enable bit still doesn't set, but with commit
> > a37c0f48950b56f6ef2ee637 ("vgaarb: Select a default VGA device even if
> > there's no legacy VGA") we no longer depend on VGA Enable.
>
> Correct me if I'm wrong:
>
>   - On the AST2500 bridge [1a03:1150], the VGA Enable bit is
>     read-only 0.
>
>   - The AST2500 bridge never forwards VGA accesses ([mem
>     0xa0000-0xbffff], [io 0x3b0-0x3bb], [io 0x3c0-0x3df]) to its
>     secondary bus.
>
> The VGA Enable bit is optional, and if both the above are true, the
> bridge is working correctly per spec, and the quirk below is not the
> right solution, and whatever solution we come up with should not
> claim that the bridge is misbehaving.
Yes, you are right, the bridge is working correctly, which is similar
to HiSilicon D05.


>
> > > > I think the best solution is make vga_arb_device_init() be wrapped by
> > > > subsys_initcall_sync(), do you think so?
> > >
> > > Hmm.  Unfortunately the semantics of subsys_initcall_sync() are not
> > > documented, so I'm not sure exactly *why* such a change would work and
> > > whether we could rely on it to continue working.
> > >
> > > pcibios_init() isn't very consistent across arches.  On some,
> > > including alpha, microblaze, some MIPS platforms, powerpc, and sh, it
> > > enumerates PCI devices.  On others (ia64, parisc, sparc, x86), it does
> > > basically nothing.  That makes life a little difficult.
> >
> > subsys_initcall_sync() is ensured after all subsys_initcall()
> > functions, so at least it can solve the problem on platforms which use
> > pcibios_init() to enumerate PCI devices (x86 and other ACPI-based
> > platforms are also OK, because they use acpi_init()
> > -->acpi_scan_init() -->pci_acpi_scan_root() to enumerate devices).
>
> More details in my response to suijingfeng:
> https://lore.kernel.org/r/20210518193100.GA148462@bjorn-Precision-5520
>
> I'd rather not fiddle with the initcall ordering.  That mechanism is
> fragile and I'd prefer something more robust.
>
> I'm wondering whether it's practical to do something in the normal PCI
> enumeration path, e.g., in pci_init_capabilities().  Maybe we can
> detect the default VGA device as we enumerate it.  Then we wouldn't
> have this weird process of "find all PCI devices first, then scan for
> the default VGA device, and oh, by the way, also check for VGA devices
> hot-added later."
If we don't want to rely on initcall order, and want to solve the
hot-added case, then can we add vga_arb_select_default_device() in
pci_notify() when (action == BUS_NOTIFY_ADD_DEVICE &&
!vga_default_device())?

Huacai
>
> Bjorn
