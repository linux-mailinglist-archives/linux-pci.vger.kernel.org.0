Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E673C41D4F5
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 10:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348931AbhI3IF4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 04:05:56 -0400
Received: from mail-vk1-f181.google.com ([209.85.221.181]:40733 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348936AbhI3IDZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 04:03:25 -0400
Received: by mail-vk1-f181.google.com with SMTP id w68so2417790vkd.7;
        Thu, 30 Sep 2021 01:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ms0VqDKZboxk1ut2VKuUbmXC/Os6zYllLTqnL0oRNbQ=;
        b=VnYF7NDchrwmccq/WoK6bb/oudKrq2tzg7uDuJqTRXC6eD1wB3xlX8wYz1ymZ0eu2U
         Q7cNRuwQJpxhYPl+yK+HhiEf8t1LE3xz+FcvWVgZ0nAdGdBmlvFgQJ445tBu2lFv3jYI
         ng9qoFdBFgfqlMlAa0Ldz6Zw/KkqGgoU7nJIO68SGlcKKMe0mk0H0NhjVYhPmjYaniMW
         uySORjIxIxPeaozHZr+ag5CCvH2FbMvXMIqJveNCRwXtry1Uar1XC5IkqVd+dbtSUzrO
         LwtxPmYKb6SrKrSM3DCFcWyrjgi0cEoKh0YstpDgy9E6NGia0I+1XWhs2vK1H+nqVkrH
         +CXA==
X-Gm-Message-State: AOAM530w4GZO/y1CBh1NtWJZU2rOsTJbl0kk4882+E1AUeLh0zogxZx4
        kUMIEG64WMiyYf7Kfb9TZ/X3/KoCtsXTGoXFpqIpetwXczk=
X-Google-Smtp-Source: ABdhPJzM80iDyUPKXMxG4ur1pT73IGxCLDTHfMl3aO1BTD+/HNQJUw87pcAvECmNIYqvDzvLlU9N/pp5MpjFP+1Z3tM=
X-Received: by 2002:a1f:3a4b:: with SMTP id h72mr2098433vka.19.1632988895590;
 Thu, 30 Sep 2021 01:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210907144512.5238-1-marek.vasut@gmail.com> <163297980091.358640.10064724088378840378@swboyd.mtv.corp.google.com>
In-Reply-To: <163297980091.358640.10064724088378840378@swboyd.mtv.corp.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Sep 2021 10:01:24 +0200
Message-ID: <CAMuHMdV8Xu-Pgda9ZrgaXFqXdzBrSRWwiSQFLjzxqRGNWkO3wQ@mail.gmail.com>
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

On Thu, Sep 30, 2021 at 7:30 AM Stephen Boyd <sboyd@kernel.org> wrote:
> +linux-clk as I don't regularly read my inbox :/
>
> Quoting marek.vasut@gmail.com (2021-09-07 07:45:12)
> > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> >
> > Add COMMON_CLK dependency, otherwise the following build error occurs:
> >   arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
> >   pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'
> > This should be OK, since all platforms shipping this controller also
> > need COMMON_CLK enabled for their clock driver.
> >
> > Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> > +CC Stephen, please double-check whether this is the right approach or
> >     whether there is some better option
>
> Stop using __clk_is_enabled()? I don't quite understand what's going on in
> the code but __clk_is_enabled() should really go away. I thought we were
> close to doing that but now I see a handful of calls have come up. The
> API should be replaced by clk_hw_is_enabled() and then removed. We move
> it to clk_hw API so that only clk providers can look at it.

But this is not a clk provider...

> Sigh!

;-)

> Anyway, fixing the dependency is "ok" but really the long term fix would
> be to not use a "is this clk enabled" sort of API. If I'm reading the
> code correctly, this is some sort of fault handler that's trying to
> avoid hanging the bus while handling the fault so it tries to make sure
> the clk is enabled first? Is it a problem if the clk is not actually
> enabled here? Would runtime PM enable state of the device work just as
> well?

Thanks, checking Runtime PM state is a good suggestion. Doing so
would require caching a pointer to the PCIe struct device instead of
the struct clk.
However, pcie_bus_clk is not the module clock, which is managed by
Runtime PM, but the PCIe bus clock, which is managed explicitly by
the driver.
However, I believe that we are checking the wrong clock, as register
access needs the module clock to be enabled, not the PCIe bus clock?
As the driver just calls pm_runtime_get_sync() and clk_prepare_enable()
in .probe(), and never touches Runtime PM status or the PCIe bus clock
during the further lifetime of the driver (it cannot be unloaded), both
the module clock and the PCIe bus clock should always[*] be enabled
when the static copy of the remapped PCIe controller address is valid.
[*] Modulo system-wide power transitions like s2ram. Does
    pm_runtime_suspended() reflect that state, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
