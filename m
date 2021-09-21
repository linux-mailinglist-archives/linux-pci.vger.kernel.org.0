Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB3B4136FD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 18:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhIUQJq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 12:09:46 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:47061 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhIUQJq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 12:09:46 -0400
Received: by mail-ua1-f47.google.com with SMTP id 109so13775753uag.13;
        Tue, 21 Sep 2021 09:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNO6ssjXrnY/e099ObdcEs+/BoC0LRJgdCH9+IhNva8=;
        b=K70LIVAnMH8NKl64B6ZPmGVas9N+ozBs8zaGubbuOnzuDX4ASMbuYhjQJRZe3Ug8R/
         hmyGtGBS0EO8+6fyUGU5QY4ZfUd1ldcT1FNcN9lzwtedKyqkdOeDxIeDnEKyGyR+YNQZ
         v+XoYtr6oRYSQEYzwIBn8DZNYXPpwEStrkSq23fMxKRgNDszp0RFzkXWvl15LC/4jQwD
         ziFLJZD7lhPpCgfHI41yvbl5l5xdAVpKb2Z2HoyJ0zu3bYRgG+EvT5WtwZb53P35hriB
         vI70V7VgNiHT8G76w3zPcsJCXh5sFhZnscAlGLzmwkQVx2606+xrcjzRvsGgY4MjZhlQ
         8+cA==
X-Gm-Message-State: AOAM533+LMy67A1K2fAC+U1cpqHAJ9yHXBsKuz1D6ixrW7JofENuxvij
        /7JxmCNs9JnPR0yClvpubyPaA8a41/gFyfqV+54=
X-Google-Smtp-Source: ABdhPJzvQXdA5I9PIbuTi4Q94wHOEUciaCvb1+fLtIt2SfQQL95KjqtrpOIe7wQMyhgd+qNc+jLuzfp60ve/5308bGQ=
X-Received: by 2002:ab0:6ec9:: with SMTP id c9mr18540642uav.114.1632240497284;
 Tue, 21 Sep 2021 09:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210907144512.5238-1-marek.vasut@gmail.com>
In-Reply-To: <20210907144512.5238-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Sep 2021 18:08:06 +0200
Message-ID: <CAMuHMdU+QteYhw6xuhuPrX5DVfmPnBgM8JfQoTk-KOP7+fSCWQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Add missing COMMON_CLK dependency
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

Thanks for your patch!

On Tue, Sep 7, 2021 at 4:45 PM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Add COMMON_CLK dependency, otherwise the following build error occurs:
>   arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
>   pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'

This is a link failure for the host driver...

> This should be OK, since all platforms shipping this controller also
> need COMMON_CLK enabled for their clock driver.
>
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> +CC Stephen, please double-check whether this is the right approach or
>     whether there is some better option
> ---
>  drivers/pci/controller/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 326f7d13024f..ee6f5e525d3a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -66,6 +66,7 @@ config PCI_RCAR_GEN2
>  config PCIE_RCAR_HOST
>         bool "Renesas R-Car PCIe host controller"
>         depends on ARCH_RENESAS || COMPILE_TEST
> +       depends on COMMON_CLK

This part is OK.

>         depends on PCI_MSI_IRQ_DOMAIN
>         help
>           Say Y here if you want PCIe controller support on R-Car SoCs in host
> @@ -74,6 +75,7 @@ config PCIE_RCAR_HOST
>  config PCIE_RCAR_EP
>         bool "Renesas R-Car PCIe endpoint controller"
>         depends on ARCH_RENESAS || COMPILE_TEST
> +       depends on COMMON_CLK

... so why did you add a dependency to the endpoint driver, too?

>         depends on PCI_ENDPOINT
>         help
>           Say Y here if you want PCIe controller support on R-Car SoCs in

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
