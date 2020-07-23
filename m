Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F8122B277
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 17:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgGWP0O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 11:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbgGWP0O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jul 2020 11:26:14 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E3E822B43;
        Thu, 23 Jul 2020 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595517973;
        bh=LVhZXIdkdKrrk3YqkOpZYcc+YEG1SCDuwu0ZS4IUGgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e0Q5iPvq0aYhQMQ93Nj0StQPvdQC04wLHBe3X1Txb93hQiAyN2gBdhUJnWxSD1Aiy
         2KX/vVFZ/CirNgDYbBgwCQVGolScvRDxEh90ajbGlE82PTVGupyi1qunooX9upUKwZ
         aUXzgixohBJRhgWVYRFrPtwnbl7QTcgOltbXgQL0=
Received: by mail-ot1-f49.google.com with SMTP id t18so4625914otq.5;
        Thu, 23 Jul 2020 08:26:13 -0700 (PDT)
X-Gm-Message-State: AOAM5328sEOhl4Nj03f76bVII3MUeDy91vbUj8Se1dlWZjJMjCfz8/os
        4aHKBKAEnhuCKQ6zFRNsdTSzkmDQ+XfITzTgOA==
X-Google-Smtp-Source: ABdhPJwjqGRmo1UpccJeOoC1JymzSWvGPVrWo+4vb2FMRak7++d6g0GGlvyUxomInzkLdL3VTPFVVOlmvL7TW+o7adM=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr4390973otb.107.1595517972599;
 Thu, 23 Jul 2020 08:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200722022514.1283916-1-robh@kernel.org> <20200722022514.1283916-12-robh@kernel.org>
In-Reply-To: <20200722022514.1283916-12-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 23 Jul 2020 09:26:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+sPaubVERLHaRzjvThk3zDO6zAnRQjGuAMKaVA87Y4HQ@mail.gmail.com>
Message-ID: <CAL_Jsq+sPaubVERLHaRzjvThk3zDO6zAnRQjGuAMKaVA87Y4HQ@mail.gmail.com>
Subject: Re: [PATCH 11/19] PCI: Move setting pci_host_bridge.busnr out of host drivers
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Will Deacon <will@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 21, 2020 at 8:25 PM Rob Herring <robh@kernel.org> wrote:
>
> Most host drivers only parse the DT bus range to set the root bus number
> in pci_host_bridge.busnr. The ones that don't set busnr are buggy in
> that they ignore what's in DT. Let's set busnr in pci_scan_root_bus_bridge()
> where we already check for the bus resource and remove setting it in
> host drivers.
>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ----
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 -
>  drivers/pci/controller/pci-aardvark.c             | 5 ++---
>  drivers/pci/controller/pci-host-common.c          | 1 -
>  drivers/pci/controller/pci-tegra.c                | 4 +---
>  drivers/pci/controller/pci-v3-semi.c              | 2 --
>  drivers/pci/controller/pcie-mediatek.c            | 8 +-------
>  drivers/pci/controller/pcie-rcar-host.c           | 1 -
>  drivers/pci/probe.c                               | 1 +
>  9 files changed, 5 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9e8a9cfc6d3a..fa922cb876a3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -374,9 +374,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                         pp->cfg0_base = pp->cfg->start;
>                         pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
>                         break;
> -               case IORESOURCE_BUS:
> -                       pp->busn = win->res;
> -                       break;
>                 }
>         }
>

> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index fd2146298b58..9fb44290ed43 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -188,7 +188,6 @@ struct pcie_port {
>         struct resource         *cfg;
>         struct resource         *io;
>         struct resource         *mem;
> -       struct resource         *busn;
>         int                     irq;
>         const struct dw_pcie_host_ops *ops;
>         int                     msi_irq;

These 2 hunks should be dropped as they are breaking the Amazon driver.

Lorenzo, do you want to fixup or I can send a fix?

Rob
