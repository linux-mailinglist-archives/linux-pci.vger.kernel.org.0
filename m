Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C69A5DD5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 00:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfIBWe5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 18:34:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39530 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfIBWe5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 18:34:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id n7so7425225otk.6
        for <linux-pci@vger.kernel.org>; Mon, 02 Sep 2019 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnCW0J2XOBK/tLwKvIcIGf2/zls8+hCpOfZSqZvsFX0=;
        b=fP3Iq+abfcf5LFT+p2RTGcUbdaQVpyuNEYnjXS09nQ0qvA37oSiLtIiywMOWgsDj+l
         6O5Sovlbx6moWbFPlIFHcbK8hiduwVUBJwcSVbZi+Rf4a3ldgc/az2BrLBbQp4s/HPpf
         zpW6CUpzeyO4mGAR4LkeCvGgcebRFnccZhwAxxkz0uiDX13L2wC4bpVXkKdgybAqQHJV
         qh70YBIGIy/qYuxsG2+TOdc+Cr9vKkbN/bzjW6MYjWYgYMrpPokt10QF9HuSF0vD+PpT
         gGkznkQDMfROOlZH+XQPq4/Wio5oUQn533uoOO6iPVzw+r5dIor9dNElwwsC6LUS4HJn
         RDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnCW0J2XOBK/tLwKvIcIGf2/zls8+hCpOfZSqZvsFX0=;
        b=mFUsC0GAAQajkdknD7HD3QeDp5nqB/ad651JSbqCGfSXrhFhhpa4GbGu5SMFCOIu41
         FxmwcQ1lKoc6nWzbRZW9uuMOYZT/rEWLdDfcH9zSz38WXx/YDG5fcQPhpcmC91kYdfg9
         Gl8dqF6TxKQMzqzr6fh4yYxNyyG1sqWQo7pytDdCV9gjas5QG0dY4s2+/you3FXnwM5Z
         XPnbRLsUKfZyczhigc2iIMLI2iGseIF8+wyIoVMFdO/2B/rg8yb+mGwH5S3b4Yix4Z//
         JH+DOfXlV73xsNmcO1IOQrLqn6rqOw+t2JvKSwxlH/oRpRTpuyVORV4kedn2nEAs/usI
         ksDw==
X-Gm-Message-State: APjAAAXcLVAovPuCZaAuWQfOYtgnyztBaBGm2DKt8tjI+i8NtGdpYwYI
        1LzFVto3Dwj5ePDtFdUv6TjfkAMbWPHY75p023E=
X-Google-Smtp-Source: APXvYqzhQeXuD0GlRHpFtEVr+7niKcLL4gdMAVqUWXuJbKleH4V9qWdb8ISs7vgGNJe6tpfT7tg8U2ox1faePdctWCQ=
X-Received: by 2002:a05:6830:1509:: with SMTP id k9mr12037399otp.42.1567463695878;
 Mon, 02 Sep 2019 15:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190901133915.12899-1-repk@triplefau.lt> <20190902105536.GG9720@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190902105536.GG9720@e119886-lin.cambridge.arm.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 3 Sep 2019 00:34:44 +0200
Message-ID: <CAFBinCAYuww=SCk_=jB1B2f0RJZoXkpY69gaS4RxUk4Qp=zLmA@mail.gmail.com>
Subject: Re: [PATCH] PCI: amlogic: Fix reset assertion via gpio descriptor
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Remi Pommarel <repk@triplefau.lt>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Yue Wang <yue.wang@amlogic.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On Mon, Sep 2, 2019 at 12:55 PM Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Sun, Sep 01, 2019 at 03:39:15PM +0200, Remi Pommarel wrote:
> > Normally asserting reset signal on gpio would be achieved with:
> >       gpiod_set_value_cansleep(reset_gpio, 1);
> >
> > Meson PCI driver set reset value to '0' instead of '1' as it takes into
> > account the PERST# signal polarity. The polarity should be taken care
> > in the device tree instead.
> >
> > This fixes the reset assertion meaning and moves out the polarity
> > configuration in DT (please note that there is no DT currently using
> > this driver).
>
> The device tree bindings for this give an example configuration:
>
>         pcie: pcie@f9800000 {
>                         compatible = "amlogic,axg-pcie", "snps,dw-pcie";
>                         reg = <0x0 0xf9800000 0x0 0x400000
>                                         0x0 0xff646000 0x0 0x2000
>                                         0x0 0xff644000 0x0 0x2000
>                                         0x0 0xf9f00000 0x0 0x100000>;
>                         reg-names = "elbi", "cfg", "phy", "config";
>                         reset-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
>
> Is the 'reset-gpios' line still consistent with this change, or does
> this need to be updated as well?
in my opinion the example is still valid
whether GPIO_ACTIVE_HIGH or GPIO_ACTIVE_LOW is correct depends on the
actual circuit on the board:
- if the GPIO signal is directly connected to the PERST# line of the
PCIe card then above example is correct
- if the GPIO signal is inverted, for example by using a transistor,
then GPIO_ACTIVE_LOW should be used instead

I haven't looked into the schematics of the boards using a G12A or
G12B SoC (I don't have any schematics of a board with an AXG SoC) so I
can't tell what "most boards" use (active LOW or HIGH).
if there's a pattern in those board schematics (which is likely since
most are derived from Amlogics reference design) then we can update
the example based that.


Martin
