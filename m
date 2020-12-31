Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787992E7D54
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 01:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgLaAQC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 19:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgLaAQB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2020 19:16:01 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B43C061573;
        Wed, 30 Dec 2020 16:15:20 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id x16so23778995ejj.7;
        Wed, 30 Dec 2020 16:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvoSlfKOzR9aXfOXBsJ3GswM+8uOh9HphZSo/bhng8w=;
        b=bvKYG0KdYqYIkJ1r680vMvyx7fx2qEYMXWN0/N9RhRGWeQNhC/O9N5KguxoLJlk8zv
         ZGcV6SfiJ2qw+foQq3MtDJYXKfmNNK/6OdYAnB4r4YkddVSRbDch1R0v6mgBV53KccxZ
         FYOSrd+Ipsaq55fseR2FSmEF8uJ+svXVsW4GZkfwEIfPBmorV0+vjQq2ubveZE3RHVsZ
         L37trk87jql5wejgQUy3mB/KPJZ6V2io2xgWYRvkLw39FtKaXbCb5YxoAKvw6qOtEIPl
         Av3ZjkqFZjTIHlgMN52IBy9QbjCrMjh2+cmmlKZoc2ejnXm6oeoPMVjBMRYs1p4Jax6h
         81ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvoSlfKOzR9aXfOXBsJ3GswM+8uOh9HphZSo/bhng8w=;
        b=sDa/mpE4japMGwQyHvNZ0V1nbaj0dx1gMo2QiOu1XxaHQroKCgyoqRxtJGrSpZqW7D
         nrd8y/ONHxevVaCmhA+tdmf3tS79mTFFlSC9Fd18Ha6WTJU8McaL1tG4J3TupaAct45K
         k0cBeippgHLKW/+S42hALgWTUAImvTzAuN1QxrRgxhZMTrTRgetTQbCQqZJahPfKEmZW
         p6iwnFLk6hTWXplMi3fRdXawqVHw0Oe+UbShv73Fjs85qEbAgwmlI4K8pWili0B/sGJ/
         zv1ILEPPUKgMQFSYjNPUT5mCdI9pznyEl7445DN006c+vQ7sJLzv1Kwah+GpuBWORePG
         Va9Q==
X-Gm-Message-State: AOAM530NaWTBRMoM+Dyqb7oHLCQ2zGc8xJ12aKabqfBwW83dTsohG1qk
        dGxklBSdKNz0ckcg1l67ifDjPaBZYOxgwVpQP1W1uiOtpmQ=
X-Google-Smtp-Source: ABdhPJxb748s3jA7OM4MHs5iwBkFjZbItUx/Lu8HznegChgjdipD9BsFFy2yu4F2Cr4zjR0SwZf8mS7qLieMUFj76ZQ=
X-Received: by 2002:a17:906:4050:: with SMTP id y16mr49846386ejj.537.1609373719461;
 Wed, 30 Dec 2020 16:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
 <20201004162908.3216898-4-martin.blumenstingl@googlemail.com>
 <CACRpkdZo-U_cAhbKb4E+d+p+5FenXkGYW0RXxyk4M5uyEPCpzw@mail.gmail.com>
 <CAFBinCCLubmDvxfabQHx2-ucgAsm1NArMUrtPx-UA2nX5xoFFA@mail.gmail.com> <CAFBinCAZXJ2=fTQuAUyW1hNeJDHY3_pxo4UhxUaOZC=i1bpFxw@mail.gmail.com>
In-Reply-To: <CAFBinCAZXJ2=fTQuAUyW1hNeJDHY3_pxo4UhxUaOZC=i1bpFxw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 31 Dec 2020 01:15:08 +0100
Message-ID: <CAFBinCAYGZC0jXPozScJugsX+8P_BOm1Zj8+f+RE9fMjhbKbJw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] gpio: ej1x8: Add GPIO driver for Etron Tech Inc. EJ168/EJ188/EJ198
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

On Mon, Dec 21, 2020 at 4:28 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Linus,
>
> On Wed, Oct 7, 2020 at 9:44 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> [...]
> > > As noted on the earlier patches I think this should be folded into the
> > > existing XHCI USB driver in drivers/usb/host/xhci-pci.c or, if that
> > > gets messy, as a separate bolt-on, something like
> > > xhci-pci-gpio.[c|h] in the drivers/usb/host/* directory.
> > > You can use a Kconfig symbol for the GPIO portions or not.
> > OK, I will do that if there are no objections from other developers
> > I am intending to place the relevant code in xhci-pci-etron.c, similar
> > to what we already have with xhci-pci-renesas.c
> I tried this and unfortunately there's a catch.
> the nice thing about having a separate GPIO driver means that the
> xhci-pci driver doesn't need to know about it.
>
> I implemented xhci-pci-etron.c and gave it a Kconfig option.
> xhci-pci is then calling into xhci-pci-etron (through some
> etron_xhci_pci_probe function).
> unfortunately this means that xhci-pci now depends on xhci-pci-etron.
> for xhci-pci-renesas this is fine (I think) because that part of the
> code is needed to get the xHCI controller going
> but for xhci-pci-etron this is a different story: the GPIO controller
> is entirely optional and only used on few devices
>
> my goal is (at some point in the future) to have the GPIO driver in OpenWrt.
> I am not sure if they would accept a patch where xhci-pci would then
> pull in the dependencies for that Etron controller, even though most
> boards don't need it.
>
> Please let me know if you have any idea on how to solve this.
next week I have some free time to work on this
I am still interested in any ideas that you have about this


Best regards,
Martin
