Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CBB28AEE7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 09:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgJLHSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 03:18:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39910 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgJLHS1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 03:18:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id c13so17770439oiy.6;
        Mon, 12 Oct 2020 00:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Uw36YJdqhYxPLM4P24TbEXUo5xRxhqxHP5K8sE65AI=;
        b=kNBeruPPbc2fpNjopo/B9RQgbha8yBPsndBDrNpPxW4D3VW9Xw/NeXA6aRlONzOuEp
         ZB+j+K1J4K9diMi+8oaAHuoqUN/1MgcT7wDvhgRZS/gTHdrlWlM0osunWpPeNNYUf6be
         uBu7b5UtS+v4u17SFhqW8s8m3CAJzYnQ+he7gwxXh5l8dBBKwScB6rV+TiPfAtHPNp2o
         nRnodNS2jYuuJ4owvCTGU2XqoO/E96iucuvzpMKYGSPxvA8Z5DPDz9ZJU+YKefa43Gn7
         XGxgmQCf1aijAxL1TXcNIOeGtAeGU+iXqCr3mxKJkpILP1QPUdkvGaT7jKb18rucOLfY
         SipA==
X-Gm-Message-State: AOAM532jO3kRuI/Oqm5F1pw5Wm/lMtKb9Q0chYqfo8c+5vTELDe5mLQ6
        P3z+WYTKfVfb7m4JR3NkfAGk0K4W3euqAyrH3/l7wN2YyNU=
X-Google-Smtp-Source: ABdhPJwpx9jtrZrQYRutMp6Sn54ZrTTZqeFYRx6Ll5etYXVGOo4HDIhMJG5Gl2srzhiv1evyiIvTl8+rPvXIxzC4xyA=
X-Received: by 2002:aca:f203:: with SMTP id q3mr9406184oih.148.1602487106695;
 Mon, 12 Oct 2020 00:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201011160045.574323-1-marek.vasut@gmail.com>
In-Reply-To: <20201011160045.574323-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Oct 2020 09:18:15 +0200
Message-ID: <CAMuHMdU0xF3rMNMqn54cF7eOS8JuHDh9WFNTJi5ftq4ypHBeHg@mail.gmail.com>
Subject: Re: [PATCH V3] PCI: rcar: Add L1 link state fix into data abort hook
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

On Sun, Oct 11, 2020 at 6:00 PM <marek.vasut@gmail.com> wrote:
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
> If a PCIe access happens inside this window, where the controller
> is between L0 and L1 link states, the access generates a fault and
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

> V3: - Fix commit message according to spellchecker
>     - Use of_find_matching_node() to apply hook only on Gen1 and Gen2 RCar
>       (in case the kernel is multiplatform)

Thanks for the update!

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c

> @@ -1050,4 +1072,58 @@ static struct platform_driver rcar_pcie_driver = {
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
> +       if (!pcie_base || !__clk_is_enabled(pcie_bus_clk))
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
> +               writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
> +               return 0;
> +       }
> +
> +       return 1;
> +}
> +
> +static const struct of_device_id rcar_pcie_abort_handler_of_match[] = {

__initconst (if you intend to keep this, see below).

> +       { .compatible = "renesas,pcie-r8a7779" },
> +       { .compatible = "renesas,pcie-r8a7790" },
> +       { .compatible = "renesas,pcie-r8a7791" },
> +       { .compatible = "renesas,pcie-rcar-gen2" },
> +       {},
> +};
> +
> +static int __init rcar_pcie_init(void)
> +{
> +       if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {

I guess it doesn't really hurt to use the existing rcar_pcie_of_match[]
instead? It just contains two additional entries, which will never match
in the CONFIG_ARM=y case.

> +#ifdef CONFIG_ARM_LPAE
> +               hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> +                               "asynchronous external abort");
> +#else
> +               hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> +                               "imprecise external abort");
> +#endif
> +       }
> +
> +       return platform_driver_register(&rcar_pcie_driver);
> +}
> +device_initcall(rcar_pcie_init);
> +#else
>  builtin_platform_driver(rcar_pcie_driver);
> +#endif

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
