Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1432327AADB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 11:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgI1JgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 05:36:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43907 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgI1JgI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 05:36:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id n61so249417ota.10;
        Mon, 28 Sep 2020 02:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2pLqNE/GkvTOLL5IziRScYgB66fugT6/fX5wcnUU5cQ=;
        b=nVFeKw/Gh5UIY+XbH2C/7g7dYm4ll6t5La01Ww6y8NT8gdbI+XiPg0rRKkMKIdIrAf
         nkomUVtOS7U0kBU1Yvb5Ew1jRdue6txTayNPsODsjplImZq9Rn1FcVD6ThxLxg3PeTXd
         0X64MLJzOVOguKdB/nbmzONvdggFh/PhobnpTaLA3cQDerp2UcATXjA4meUSA0c8E1yX
         Zb95vTqIKRcg1dvvLn4HeLWJhCKpCV22HSoxNAyGGbq34rBC7v8exMoNuIpR+cHq9as5
         hdka1DLJgR1yVbT3Su9OQo6JY4u9U+T5Umh0g3oWQGJOWJYXzouQWt+TDjEPkVZisCzY
         42Ng==
X-Gm-Message-State: AOAM530SCklcEHHjm2LPM+p+pQll7GLs2I/JrTyltz6pA1v0yhEyS9n4
        mFizPk57xoIuOmTWajFSIkE5IlKy7RRAj/4Kg1g=
X-Google-Smtp-Source: ABdhPJxwJDSRFoLIPj8ZHKYIbuw3SGElKsCy3AfB9DmoIx8UIpYTAdNkGvLXdvk54jOROZP0Huqdue7ogX1yE4tVUO4=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr366864otb.250.1601285767328;
 Mon, 28 Sep 2020 02:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200926160934.136182-1-marek.vasut@gmail.com>
In-Reply-To: <20200926160934.136182-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Sep 2020 11:35:56 +0200
Message-ID: <CAMuHMdURuSsYRwi10FT+s-rVjok0f-FgS6G8rmpg46u98scMkQ@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: rcar: Add L1 link state fix into data abort hook
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
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

Hi Marek,

On Sat, Sep 26, 2020 at 6:09 PM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> The R-Car PCIe controller is capable of handling L0s/L1 link states.
> While the controller can enter and exit L0s link state, and exit L1
> link state, without any additional action from the driver, to enter
> L1 link state, the driver must complete the link state transition by
> issuing additional commands to the controller.
>
> The problem is, this transition is not atomic. The controller sets
> PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> the PCIe card, but then the controller enters some sort of inbetween
> state. The driver must detect this condition and complete the link
> state transition, by setting L1IATN bit in PMCTLR and waiting for
> the link state transition to complete.
>
> If a PCIe access happens inside of this window, where the controller
> is inbetween L0 and L1 link states, the access generates a fault and
> the ARM 'imprecise external abort' handler is invoked.
>
> Just like other PCI controller drivers, here we hook the fault handler,
> perform the fixup to help the controller enter L1 link state, and then
> restart the instruction which triggered the fault. Since the controller
> is in L1 link state now, the link can exit from L1 link state to L0 and
> successfully complete the access.
>
> Note that this fixup is applicable only to Aarch32 R-Car controllers,
> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - Update commit message, add link to TFA repository commit
>     - Handle the LPAE case as in ARM fault.c and fsr-{2,3}level.c
>     - Cache clock and check whether they are enabled before register
>       access

Thanks for the update!

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -13,6 +13,7 @@
>
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -42,6 +43,21 @@ struct rcar_msi {
>         int irq2;
>  };
>
> +#ifdef CONFIG_ARM
> +/*
> + * Here we keep a static copy of the remapped PCIe controller address.
> + * This is only used on aarch32 systems, all of which have one single
> + * PCIe controller, to provide quick access to the PCIe controller in
> + * the L1 link state fixup function, called from ARM fault handler.

the ARM fault handler

> + */
> +static void __iomem *pcie_base;
> +/*
> + * Static copy of bus clock pointer, so we can check whether the clock
> + * are enabled or not.

is

> + */
> +static struct clk *pcie_bus_clk;
> +#endif

> @@ -1050,4 +1072,47 @@ static struct platform_driver rcar_pcie_driver = {
>         },
>         .probe = rcar_pcie_probe,
>  };
> +
> +#ifdef CONFIG_ARM
> +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
> +               unsigned int fsr, struct pt_regs *regs)
> +{
> +       u32 pmsr;
> +
> +       if (!pcie_base || !pcie_bus_clk || !__clk_is_enabled(pcie_bus_clk))

As __clk_is_enabled() handles a NULL pointer parameter, the second
test is not needed.

> +               return 1;
> +
> +       pmsr = readl(pcie_base + PMSR);
> +
> +       /*
> +        * Test if the PCIe controller received PM_ENTER_L1 DLLP and
> +        * the PCIe controller is not in L1 link state. If true, apply
> +        * fix, which will put the controller into L1 link state, from
> +        * which it can return to L0s/L0 on its own.
> +        */
> +       if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
> +               writel(L1IATN, pcie_base + PMCTLR);
> +               while (!(readl(pcie_base + PMSR) & L1FAEG))
> +                       ;

To answer my own question from previous review cycle: this takes 7
cycles on r8a7791/koelsch.

> +               writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
> +               return 0;
> +       }
> +
> +       return 1;
> +}
> +
> +static int __init rcar_pcie_init(void)
> +{
> +#ifdef CONFIG_ARM_LPAE
> +       hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> +                       "asynchronous external abort");
> +#else
> +       hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> +                       "imprecise external abort");
> +#endif

As there can be only a single handler, this may interfere with a handler
for another platform in a multi-platform kernel.
Hence I think this should not be done unconditionally, but be moved to
the driver's .probe() callback.

> +       return platform_driver_register(&rcar_pcie_driver);
> +}
> +device_initcall(rcar_pcie_init);
> +#else
>  builtin_platform_driver(rcar_pcie_driver);
> +#endif

As this fixes the crash seen during s2ram with an Intel E1000E card
present and the e1000e driver loaded:
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
