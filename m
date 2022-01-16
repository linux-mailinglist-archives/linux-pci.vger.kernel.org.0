Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9A148FC2D
	for <lists+linux-pci@lfdr.de>; Sun, 16 Jan 2022 11:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiAPKja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Jan 2022 05:39:30 -0500
Received: from mail-vk1-f169.google.com ([209.85.221.169]:34783 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiAPKja (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Jan 2022 05:39:30 -0500
Received: by mail-vk1-f169.google.com with SMTP id 191so8605738vkc.1;
        Sun, 16 Jan 2022 02:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7KZoixn/d1IeGe4aQVxYWMngxYypeC0ApJyZMZEG2E=;
        b=r+1Xl5Yrb59Ce+tcAtATDpsj245oj3L9XG+HodcOK4kGqVjMsIHSogBtSkJacO7oQD
         RNYEpbdXoLW3Vs9JI2JDJJmtSRzUIqrehRKO/GHcKqbiFNbzBUlsH0cVia3pbrpTMfnX
         dXO7PX8RclLgOwMCt3eopRCKRXMTQosqye9IBp4kXtvMVWeGbcXmkiHk64QcoIu3sSEu
         TN7a8EOu5xwWo34FNcneegRit0RMf65ZgznFNhv3RvfSBVcb3x/ST1WoR2YGFlrfHXZf
         bWJrHP3e4Z5rOdRvcY8iLnNL47Zkkim91+9PjTpiZvxt9JM1NsJpvy4X7s0EobGZa5ow
         sIDQ==
X-Gm-Message-State: AOAM531ohGD34hs6wchuQFoN86d1Pl9AxPUC/7l7bduJmm1rGAsOaJGD
        hesxJjJCIhMUW0QlUbWiqjR4uUi9dSXeRg==
X-Google-Smtp-Source: ABdhPJxzpslPHuDe7fSO3yMENtzpEJXtWhqeHft+d4D3sLR5j7upUCimeBC5jkTQHnbb0LQ9PvMsyQ==
X-Received: by 2002:ac5:cda4:: with SMTP id l4mr6610630vka.10.1642329569154;
        Sun, 16 Jan 2022 02:39:29 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id q28sm3264973vsl.2.2022.01.16.02.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 02:39:28 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id d189so8598137vkg.3;
        Sun, 16 Jan 2022 02:39:28 -0800 (PST)
X-Received: by 2002:ac5:c967:: with SMTP id t7mr6747505vkm.20.1642329568063;
 Sun, 16 Jan 2022 02:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20220116022549.456486-1-marek.vasut@gmail.com>
In-Reply-To: <20220116022549.456486-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 16 Jan 2022 11:39:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXUteqOinkCNH8L-dC=W82DChQSupAXv_Uhjq5M=T5uxQ@mail.gmail.com>
Message-ID: <CAMuHMdXUteqOinkCNH8L-dC=W82DChQSupAXv_Uhjq5M=T5uxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

On Sun, Jan 16, 2022 at 3:26 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> In case the controller is transitioning to L1 in rcar_pcie_config_access(),
> any read/write access to PCIECDR triggers asynchronous external abort. This
> is because the transition to L1 link state must be manually finished by the
> driver. The PCIe IP can transition back from L1 state to L0 on its own.
>
> Avoid triggering the abort in rcar_pcie_config_access() by checking whether
> the controller is in the transition state, and if so, finish the transition
> right away. This prevents a lot of unnecessary exceptions, although not all
> of them.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -54,6 +54,34 @@ static void __iomem *pcie_base;
>   * device is runtime suspended or not.
>   */
>  static struct device *pcie_dev;
> +
> +static DEFINE_SPINLOCK(pmsr_lock);
> +static int rcar_pcie_wakeup(struct device *pcie_dev, void __iomem *pcie_base)
> +{
> +       u32 pmsr, val;
> +       int ret = 0;
> +
> +       if (!pcie_base || pm_runtime_suspended(pcie_dev))
> +               return 1;

This is not a suitable return code to be propagated in
rcar_pcie_config_access(). But probably this cannot happen anyway
when called from rcar_pcie_config_access()?

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
> +               ret = readl_poll_timeout_atomic(pcie_base + PMSR, val,
> +                                               val & L1FAEG, 10, 1000);
> +               WARN(ret, "Timeout waiting for L1 link state, ret=%d\n", ret);
> +               writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
> +       }
> +
> +       return ret;
> +}
>  #endif
>
>  /* Structure representing the PCIe interface */
> @@ -85,6 +113,15 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
>  {
>         struct rcar_pcie *pcie = &host->pcie;
>         unsigned int dev, func, reg, index;
> +       unsigned long flags;
> +       int ret;
> +
> +       /* Wake the bus up in case it is in L1 state. */
> +       spin_lock_irqsave(&pmsr_lock, flags);
> +       ret = rcar_pcie_wakeup(pcie->dev, pcie->base);
> +       spin_unlock_irqrestore(&pmsr_lock, flags);

Move the spinlock handling in the caller?

> +       if (ret)
> +               return ret;
>
>         dev = PCI_SLOT(devfn);
>         func = PCI_FUNC(devfn);
> @@ -1050,36 +1087,18 @@ static struct platform_driver rcar_pcie_driver = {
>  };
>
>  #ifdef CONFIG_ARM
> -static DEFINE_SPINLOCK(pmsr_lock);
>  static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
>                 unsigned int fsr, struct pt_regs *regs)
>  {
>         unsigned long flags;
> -       u32 pmsr, val;
>         int ret = 0;
>
>         spin_lock_irqsave(&pmsr_lock, flags);
>
> -       if (!pcie_base || pm_runtime_suspended(pcie_dev)) {
> -               ret = 1;
> +       ret = rcar_pcie_wakeup(pcie_dev, pcie_base);
> +       spin_unlock_irqrestore(&pmsr_lock, flags);

Move the spinlock handling in the caller?

> +       if (ret)
>                 goto unlock_exit;
> -       }
> -
> -       pmsr = readl(pcie_base + PMSR);
> -
> -       /*
> -        * Test if the PCIe controller received PM_ENTER_L1 DLLP and
> -        * the PCIe controller is not in L1 link state. If true, apply
> -        * fix, which will put the controller into L1 link state, from
> -        * which it can return to L0s/L0 on its own.
> -        */
> -       if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
> -               writel(L1IATN, pcie_base + PMCTLR);
> -               ret = readl_poll_timeout_atomic(pcie_base + PMSR, val,
> -                                               val & L1FAEG, 10, 1000);
> -               WARN(ret, "Timeout waiting for L1 link state, ret=%d\n", ret);
> -               writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
> -       }
>
>  unlock_exit:
>         spin_unlock_irqrestore(&pmsr_lock, flags);

Whoops, double unlock.

As there's nothing to be done below, the goto and label can be removed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
