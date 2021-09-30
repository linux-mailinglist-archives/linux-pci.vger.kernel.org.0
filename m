Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2F641E136
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbhI3Sdj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 14:33:39 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:34718 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343936AbhI3Sdi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 14:33:38 -0400
Received: by mail-vs1-f53.google.com with SMTP id z22so6865313vsp.1;
        Thu, 30 Sep 2021 11:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uSMHJOUvBAKYYR0VTNnH4FL7RyASHXjCxf6YLbmWnU=;
        b=0JdkRrQT3Ksxu6OpYKAzFU1ZmHmPQxUmJBtG3tMnJdkXVa2VKswizAfuWxN94iP8bh
         9pMn9gNtEIViwOO2UT+0RyVSNiPD57R9wE6ngJPjX1/hrjE/FfkGS14I/x4KVbaHLTe/
         sMAvHddAAY7AaDiwvECO+iAskJZvgoI4C6OWC5+JyIETPrH7ntsiAY4G2QRyi1VJeQzC
         YzswPxmo3g+W3tXz3OeOf3i0gsBA8hRkBtPb3Tj36Ui+AESfWLmt83YhW27vNbXZmsYV
         if2QOmxqOyPW16ZPf5JJ0NUUOyx+5PaYZBYy/M98hqfEHcQKMGeCwaTtPCfOupMuyP7s
         qV/Q==
X-Gm-Message-State: AOAM53027aQe5CoUZw0ZLrD2058YWTVju6HgEYkM53j3ghJQDFijR6s/
        P2Wj6EDxHky93u/YsUAoQRByVJQxPzJnyQ7+9QE=
X-Google-Smtp-Source: ABdhPJzPOqFubo/0aUhp7ohFtUSpBt2HTLpWxwh4z0zpjVJpCQlZ0g62S2+KGaytL3q/tQEMHQtyiSxeuGG+rT+p72k=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr926121vsl.9.1633026715195;
 Thu, 30 Sep 2021 11:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210907144512.5238-1-marek.vasut@gmail.com> <163297980091.358640.10064724088378840378@swboyd.mtv.corp.google.com>
 <CAMuHMdV8Xu-Pgda9ZrgaXFqXdzBrSRWwiSQFLjzxqRGNWkO3wQ@mail.gmail.com> <163302576552.358640.2337603190171807403@swboyd.mtv.corp.google.com>
In-Reply-To: <163302576552.358640.2337603190171807403@swboyd.mtv.corp.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Sep 2021 20:31:43 +0200
Message-ID: <CAMuHMdVQ7r6-H8kBiNYXdqHQRGJxc4eE4hYthFw+XJZx86g6eA@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Add missing COMMON_CLK dependency
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stephen,

On Thu, Sep 30, 2021 at 8:16 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2021-09-30 01:01:24)
> > On Thu, Sep 30, 2021 at 7:30 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > > +linux-clk as I don't regularly read my inbox :/
> > >
> > > Quoting marek.vasut@gmail.com (2021-09-07 07:45:12)
> > > > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > >
> > > > Add COMMON_CLK dependency, otherwise the following build error occurs:
> > > >   arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
> > > >   pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'
> > > > This should be OK, since all platforms shipping this controller also
> > > > need COMMON_CLK enabled for their clock driver.
> > > >
> > > > Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > > Cc: Wolfram Sang <wsa@the-dreams.de>
> > > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > Cc: linux-renesas-soc@vger.kernel.org
> > > > ---
> > > > +CC Stephen, please double-check whether this is the right approach or
> > > >     whether there is some better option
> > >
> > > Stop using __clk_is_enabled()? I don't quite understand what's going on in
> > > the code but __clk_is_enabled() should really go away. I thought we were
> > > close to doing that but now I see a handful of calls have come up. The
> > > API should be replaced by clk_hw_is_enabled() and then removed. We move
> > > it to clk_hw API so that only clk providers can look at it.
> >
> > But this is not a clk provider...
> >
> > > Sigh!
> >
> > ;-)
>
> Exactly!
>
> >
> > > Anyway, fixing the dependency is "ok" but really the long term fix would
> > > be to not use a "is this clk enabled" sort of API. If I'm reading the
> > > code correctly, this is some sort of fault handler that's trying to
> > > avoid hanging the bus while handling the fault so it tries to make sure
> > > the clk is enabled first? Is it a problem if the clk is not actually
> > > enabled here? Would runtime PM enable state of the device work just as
> > > well?
> >
> > Thanks, checking Runtime PM state is a good suggestion. Doing so
> > would require caching a pointer to the PCIe struct device instead of
> > the struct clk.
> > However, pcie_bus_clk is not the module clock, which is managed by
> > Runtime PM, but the PCIe bus clock, which is managed explicitly by
> > the driver.
> > However, I believe that we are checking the wrong clock, as register
> > access needs the module clock to be enabled, not the PCIe bus clock?
> > As the driver just calls pm_runtime_get_sync() and clk_prepare_enable()
> > in .probe(), and never touches Runtime PM status or the PCIe bus clock
> > during the further lifetime of the driver (it cannot be unloaded), both
> > the module clock and the PCIe bus clock should always[*] be enabled
> > when the static copy of the remapped PCIe controller address is valid.
> > [*] Modulo system-wide power transitions like s2ram. Does
> >     pm_runtime_suspended() reflect that state, too?
> >
>
> Great! If that's all correct then simply removing the call to
> __clk_is_enabled() should work. Can we do that?

We first have to double-check that pm_runtime_suspended() reflects
the state, as the reason behind the fault handler is to fix lock-ups
during system-wide power transitions.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
