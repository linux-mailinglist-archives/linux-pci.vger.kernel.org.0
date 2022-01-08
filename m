Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B277F488114
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jan 2022 04:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiAHD0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 22:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiAHD0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 22:26:45 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4275BC061574;
        Fri,  7 Jan 2022 19:26:45 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id c36so13582891uae.13;
        Fri, 07 Jan 2022 19:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7nJBAN+/cn5qfpWk0NOHHqyla4qQf4mJjTbq7ER8vY=;
        b=Vthr3oxs6/VFx1JmMo90V37g81MHiSon7+Pw+HQUJIS0BS5WxwWvPntiEdWhgA/Zk0
         W5yy8+HQ0zeLuSGqa6t3dxjqzWRjGSQGhqVJ7IiDw0QtYhFWdufi1PZiZgWnbIbf3Q2h
         Jk1pZP9Q3lqBv4mRzfDiug3GFI65VVd5JZHDQ24vh51kaRwrVrhWeSB5KpkfmJJOxMoz
         02KfBV+kaoRYu7OT9UDUOkuEkqc1PG6faGzy2nLzMYOY5tW5lhaZfHNwqupo5h9Gg83N
         Q85vFA5xPCwHNNNzDwtXfRNsu3VMtYMO2G9ZG59gOnr1RwaEMTnEUMiC4RdWYWr4xL0y
         CMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7nJBAN+/cn5qfpWk0NOHHqyla4qQf4mJjTbq7ER8vY=;
        b=PegoHBoAbjCNIbS3GfMQHNYyGrxo5EtgyXWGW30uZIg4RcAjRvLyKxosy88GDuNGrE
         5xroClLJ0S0RLnjCyLVTBcPJTnbdKi5sdabAO10A8D9rMIWbQprMiGwcqWpG6vx8WiRJ
         dR9/i5mtH6mfUJ3CWsDfOmTnPkBoZ4l39X0I/KJMTbNJh0mDiveZv11BTxD0GUsgglC+
         zTQT+ayQpr362Uu4Yb0Vw0mdV7WmR5WaVnqr0SmNFQX6llHtIoW3I5+KEihegKDTY/yo
         6OwaYgaI1FTDE8rKDU6cuQMFVZ2j76MDlrtQud/IoK/DaON2rIN34I4rnSquHPKp7v8H
         EF5A==
X-Gm-Message-State: AOAM531RdepEDmKdY5U8yLqGLZMkrp/H8IpnTCDioCuqKuslJtBc9oCD
        JFM3tRMQp4DKfdhDQzQfprn61SGNILSPlxYIpZg=
X-Google-Smtp-Source: ABdhPJxp5daUskrG8M75oyns0o+q4QGhp/kZKOM5gZQoscaTpTpAcP/QEasfwQ40qIj4RxU3EjLFaXSSXmaHiHbcBjw=
X-Received: by 2002:a67:b807:: with SMTP id i7mr20030054vsf.52.1641612404012;
 Fri, 07 Jan 2022 19:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20220106000658.243509-1-helgaas@kernel.org> <20220106163035.GA292309@bhelgaas>
In-Reply-To: <20220106163035.GA292309@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 8 Jan 2022 11:26:44 +0800
Message-ID: <CAAhV-H63JN5YTz_hu1XviMy0sp+U1VTMG6frDt7vL6qxKMmASA@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] vgaarb: Rework default VGA device selection
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For the whole series:
Tested-by: Huacai Chen <chenhuacai@loongson.cn>

On Fri, Jan 7, 2022 at 12:30 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+to Maarten, Maxime, Thomas: sorry, I forgot to use
> get_maintainer.pl so I missed you the first time.  Beginning of thread:
> https://lore.kernel.org/all/20220106000658.243509-1-helgaas@kernel.org/#t
> Git branch with this v8 + a couple trivial renames, based on v5.16-rc1:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=0f4caffa1297]
>
> On Wed, Jan 05, 2022 at 06:06:48PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Current default VGA device selection fails in some cases because part of it
> > is done in the vga_arb_device_init() subsys_initcall, and some arches
> > enumerate PCI devices in pcibios_init(), which runs *after* that.
> >
> > For example:
> >
> >   - On BMC system, the AST2500 bridge [1a03:1150] does not implement
> >     PCI_BRIDGE_CTL_VGA.  This is perfectly legal but means the legacy VGA
> >     resources won't reach downstream devices unless they're included in the
> >     usual bridge windows.
> >
> >   - vga_arb_select_default_device() will set a device below such a bridge
> >     as the default VGA device as long as it has PCI_COMMAND_IO and
> >     PCI_COMMAND_MEMORY enabled.
> >
> >   - vga_arbiter_add_pci_device() is called for every VGA device, either at
> >     boot-time or at hot-add time, and it will also set the device as the
> >     default VGA device, but ONLY if all bridges leading to it implement
> >     PCI_BRIDGE_CTL_VGA.
> >
> >   - This difference between vga_arb_select_default_device() and
> >     vga_arbiter_add_pci_device() means that a device below an AST2500 or
> >     similar bridge can only be set as the default if it is enumerated
> >     before vga_arb_device_init().
> >
> >   - On ACPI-based systems, PCI devices are enumerated by acpi_init(), which
> >     runs before vga_arb_device_init().
> >
> >   - On non-ACPI systems, like on MIPS system, they are enumerated by
> >     pcibios_init(), which typically runs *after* vga_arb_device_init().
> >
> > This series consolidates all the default VGA device selection in
> > vga_arbiter_add_pci_device(), which is always called after enumerating a
> > PCI device.
> >
> > Almost all the work here is Huacai's.  I restructured it a little bit and
> > added a few trivial patches on top.
> >
> > I'd like to move vgaarb.c to drivers/pci eventually, but there's another
> > initcall ordering snag that needs to be resolved first, so this leaves
> > it where it is.
> >
> > Bjorn
> >
> > Version history:
> > V0 original implementation as final quirk to set default device.
> > https://lore.kernel.org/r/20210514080025.1828197-6-chenhuacai@loongson.cn
> >
> > V1 rework vgaarb to do all default device selection in
> > vga_arbiter_add_pci_device().
> > https://lore.kernel.org/r/20210705100503.1120643-1-chenhuacai@loongson.cn
> >
> > V2 move arbiter to PCI subsystem, fix nits.
> > https://lore.kernel.org/r/20210722212920.347118-1-helgaas@kernel.org
> >
> > V3 rewrite the commit log of the last patch (which is also summarized
> > by Bjorn).
> > https://lore.kernel.org/r/20210820100832.663931-1-chenhuacai@loongson.cn
> >
> > V4 split the last patch to two steps.
> > https://lore.kernel.org/r/20210827083129.2781420-1-chenhuacai@loongson.cn
> >
> > V5 split Patch-9 again and sort the patches.
> > https://lore.kernel.org/r/20210911093056.1555274-1-chenhuacai@loongson.cn
> >
> > V6 split Patch-5 again and sort the patches again.
> > https://lore.kernel.org/r/20210916082941.3421838-1-chenhuacai@loongson.cn
> >
> > V7 stop moving vgaarb to drivers/pci because of ordering issues with
> > misc_init().
> > https://lore.kernel.org/r/20211015061512.2941859-1-chenhuacai@loongson.cn
> > https://lore.kernel.org/r/CAAhV-H7FhAjM-Ha42Z1dLrE4PvC9frfyeU27KHWcyWKkMftEsA@mail.gmail.com
> >
> >
> > Bjorn Helgaas (8):
> >   vgaarb: Factor out vga_select_framebuffer_device()
> >   vgaarb: Factor out default VGA device selection
> >   vgaarb: Move framebuffer detection to ADD_DEVICE path
> >   vgaarb: Move non-legacy VGA detection to ADD_DEVICE path
> >   vgaarb: Move disabled VGA device detection to ADD_DEVICE path
> >   vgaarb: Remove empty vga_arb_device_card_gone()
> >   vgaarb: Use unsigned format string to print lock counts
> >   vgaarb: Replace full MIT license text with SPDX identifier
> >
> > Huacai Chen (2):
> >   vgaarb: Move vga_arb_integrated_gpu() earlier in file
> >   vgaarb: Log bridge control messages when adding devices
> >
> >  drivers/gpu/vga/vgaarb.c | 311 +++++++++++++++++++--------------------
> >  1 file changed, 154 insertions(+), 157 deletions(-)
> >
> > --
> > 2.25.1
> >
> >
