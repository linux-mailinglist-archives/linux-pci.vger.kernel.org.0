Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1972EC043
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 16:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbhAFPSk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 10:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAFPSj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jan 2021 10:18:39 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398C8C06134D;
        Wed,  6 Jan 2021 07:17:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g24so4675539edw.9;
        Wed, 06 Jan 2021 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7ucDQgsYb+XUALcOQxMNfW1nWITQF3JeTH0dCH4M34=;
        b=f7DW9BojkCrHwq32HIzyeXm1FqfVamIKljSnelV+8uptq8fI9iDq+6/XTkMLW35BJ0
         2E5bMKNYcwRMGPUbPHGDoeda49R9y1NbATAZPKxy3vWDWQCZtnhasMzOnh90borkVEp5
         Pyq9eM1aF4QsGHymgblggrakODREFyQ3VTY7ljmpTWqT1bmrGBE1eFci1PpRUQaTMbHZ
         o7RqyFZISQa8+zXkQoaBzOIG7wGs+dY8YGF+AV2P/BmFMOosL2poxE9GGWocmDMZ8NmP
         Zj3y4SNWMkD+ALX8cyEGP8B1EGbULtPw21rD+252v4GAbzduGC+OXJCZY6mhEi1vYgXc
         zeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7ucDQgsYb+XUALcOQxMNfW1nWITQF3JeTH0dCH4M34=;
        b=fa9cQJ+HH/7/08s4l6cDYG0Zp0qWe1ZP00O7bnLlEZYXR3CXs7nH5AATf2urZkQsXC
         +k7k+IUkeSrsnlSiH0UwSgYSI6xR8KIoXB0liduiDkeCvdKkkcW6S50qj+D5VVsr1pdK
         MDaI1Oykbdcqze9HODNAf3Ht6UvuNiQ53BMgy/nCiYW0RwusTUzTVg+pbrcnGPk+UmEc
         mDAJVE40A7/KFgaQmFF0QkStW7PE0c/9wRayu6vHrI6JQssEwzSIjMtPXD/gtDkhiG+Q
         0kILbSxYVC+mukJE2oK7ox6wefzMAfWVT9L+l+soiLhgGXEAMbgF5bhU1ir/QwHBYFNp
         LN/Q==
X-Gm-Message-State: AOAM532zCuZPtQBdSFzGPPoywy1kmMWOAvz9lhnOCnp9ycesA9qMPxD+
        f2YOo6sAUAwcfwaUiwj93S2g5VwnNOpCI46XjJRMsKh10KM=
X-Google-Smtp-Source: ABdhPJwEoX+GE9TNyG6zQHdCSgd0e8rufnX3/nPdrrDVUu8sr3Jc5LcoctiwQrl2Yg7vztRVPUQWxIPjmljgCEJtWFE=
X-Received: by 2002:a50:d80c:: with SMTP id o12mr4124786edj.338.1609946277927;
 Wed, 06 Jan 2021 07:17:57 -0800 (PST)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
 <20201004162908.3216898-4-martin.blumenstingl@googlemail.com>
 <CACRpkdZo-U_cAhbKb4E+d+p+5FenXkGYW0RXxyk4M5uyEPCpzw@mail.gmail.com>
 <CAFBinCCLubmDvxfabQHx2-ucgAsm1NArMUrtPx-UA2nX5xoFFA@mail.gmail.com>
 <CAFBinCAZXJ2=fTQuAUyW1hNeJDHY3_pxo4UhxUaOZC=i1bpFxw@mail.gmail.com> <CACRpkdbKQaT61w6r9Hx40Qvy+7qyLNm-fx-BpL_wdGcB=tmcqQ@mail.gmail.com>
In-Reply-To: <CACRpkdbKQaT61w6r9Hx40Qvy+7qyLNm-fx-BpL_wdGcB=tmcqQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 6 Jan 2021 16:17:47 +0100
Message-ID: <CAFBinCBCYZ3bzvvn==CFZyVh8E7TiGvW9PnqmK-Qd=y4X2HgNw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] gpio: ej1x8: Add GPIO driver for Etron Tech Inc. EJ168/EJ188/EJ198
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

On Tue, Jan 5, 2021 at 11:23 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Dec 21, 2020 at 4:28 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> > On Wed, Oct 7, 2020 at 9:44 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > [...]
> > > > As noted on the earlier patches I think this should be folded into the
> > > > existing XHCI USB driver in drivers/usb/host/xhci-pci.c or, if that
> > > > gets messy, as a separate bolt-on, something like
> > > > xhci-pci-gpio.[c|h] in the drivers/usb/host/* directory.
> > > > You can use a Kconfig symbol for the GPIO portions or not.
> > > OK, I will do that if there are no objections from other developers
> > > I am intending to place the relevant code in xhci-pci-etron.c, similar
> > > to what we already have with xhci-pci-renesas.c
> >
> > I tried this and unfortunately there's a catch.
> > the nice thing about having a separate GPIO driver means that the
> > xhci-pci driver doesn't need to know about it.
>
> Since PCI devices have device-wide power management and things
> like that I think that is a really dangerous idea.
>
> What if the GPIO driver starts poking around in this PCI device
> when the main driver is also probed and has put the device
> into sleep state?
that is asking for trouble, indeed.

[...]
> > I implemented xhci-pci-etron.c and gave it a Kconfig option.
> > xhci-pci is then calling into xhci-pci-etron (through some
> > etron_xhci_pci_probe function).
>
> This sounds about right.
>
> > unfortunately this means that xhci-pci now depends on xhci-pci-etron.
> > for xhci-pci-renesas this is fine (I think) because that part of the
> > code is needed to get the xHCI controller going
> > but for xhci-pci-etron this is a different story: the GPIO controller
> > is entirely optional and only used on few devices
>
> I might be naive but should it not be the other way around?
> That xhci-pci-etron is dependent on xhci-pci? I imagine
> it would be an optional add-on.
the only way to achieve this that I can think of is to basically have
xhci-pci-etron implement it's own pci_driver and then call
xhci_pci_probe, xhci_pci_remove, etc.
but then it depends on the driver load order if the GPIO controller is exposed

what structure did you have in mind to achieve this?

> > my goal is (at some point in the future) to have the GPIO driver in OpenWrt.
> > I am not sure if they would accept a patch where xhci-pci would then
> > pull in the dependencies for that Etron controller, even though most
> > boards don't need it.
>
> Make sure the etron part is an additional module that can be
> loaded after xhci-pci.
my approach from above unfortunately would not achieve this
so if you have an idea how to achieve this (or have any other driver
in mind that I can use as reference, even if not related to
GPIO/USB/PCI then please let me know)

> OpenWrt support optional modules to be compiled per-system.
that I already found out. That's why I think that I need to get the
driver part "right" and then get the OpenWrt part done in just a few
lines of their build-system


Best regards,
Martin
