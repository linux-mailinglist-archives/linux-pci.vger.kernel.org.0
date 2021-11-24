Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D1945B205
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 03:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhKXC0c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 21:26:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233429AbhKXC0c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 21:26:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 281A260F6B;
        Wed, 24 Nov 2021 02:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637720603;
        bh=RiV50x4kC9wp3F6Wtst3RhBHx2ov4JfcKnL8EMWlx8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IdSf/9t6IrqRIa2YklCbJ/KTbSoKpXR/9hKR74o0GZzNDIg3vkDUJNiDowS3VwYsC
         BvH0MOgHwb0M3wOp89rtMCUZh9j4biNbpDkF9+5XcgSLk/8tPDGtJ5sDhGc/yq6DJ5
         BYY+WJbdN++oJzMU4QMeNQm/8kM21yghhuse5YDDYYqlyMJ4tFJDMfYfOLtNoyVlKN
         f+Cv+vJx6USFEdnmIKNP9nbtNFmFjKYSXJmQvRjDwF1SJxuIPrC/dEcXSLflRvD6/G
         i91/tdvrmv7VJBmGIuz5wQNfHuE4ZssRvzFh7utuLhdOblSMqmQwo5aLMKX+E13a1I
         Lh17h4UXiO0Nw==
Received: by mail-ed1-f50.google.com with SMTP id x15so3393900edv.1;
        Tue, 23 Nov 2021 18:23:23 -0800 (PST)
X-Gm-Message-State: AOAM533oL37N/o5bae2oJBpq5X2N4D2m/MzYe9f6qTdk1Et3cVUc6vRD
        QynTiYj3U41cg5igDRHxyuphHB9uppVMlzcXTw==
X-Google-Smtp-Source: ABdhPJyAD+ppx/K8D/egM+QkKBRr5JZF5rZLyiIfiXIjBkI6QHFgrYehCGSXBl8i7yxWQ7DW341T+fTpUCA23iWiLRY=
X-Received: by 2002:a05:6402:11d2:: with SMTP id j18mr17855438edw.318.1637720601558;
 Tue, 23 Nov 2021 18:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20211122111332.72264-1-marcan@marcan.st>
In-Reply-To: <20211122111332.72264-1-marcan@marcan.st>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 23 Nov 2021 19:23:09 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+vFbFN+WQhi3dRicW+kaP1Oi9JPSmnAFL7XAc0eCvgrA@mail.gmail.com>
Message-ID: <CAL_Jsq+vFbFN+WQhi3dRicW+kaP1Oi9JPSmnAFL7XAc0eCvgrA@mail.gmail.com>
Subject: Re: [PATCH] PCI: apple: Configure link speeds properly
To:     Hector Martin <marcan@marcan.st>
Cc:     Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 22, 2021 at 4:13 AM Hector Martin <marcan@marcan.st> wrote:
>
> This sets the maximum link speed from the devicetree, and also requests
> a link speed change from the controller. Without the request, the link
> always comes up at Gen1 initially, and the core PCIe code complains
> about a bandwidth bottleneck.
>
> It turns out ASPM ends up retraining at a higher speed anyway even
> without this code, but let's not rely on that.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/pci/controller/pcie-apple.c | 53 +++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 03bfe977c579..073cbac49d8b 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -30,6 +30,10 @@
>  #include <linux/of_irq.h>
>  #include <linux/pci-ecam.h>
>
> +#include "../pci.h"
> +/* Apple PCIe is based on DesignWare IP and shares some registers */
> +#include "dwc/pcie-designware.h"

I'm starting to regret this not being part of the DWC driver...

> +
>  #define CORE_RC_PHYIF_CTL              0x00024
>  #define   CORE_RC_PHYIF_CTL_RUN                BIT(0)
>  #define CORE_RC_PHYIF_STAT             0x00028
> @@ -130,9 +134,13 @@
>   */
>  #define DOORBELL_ADDR          CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR
>
> +/* The offset of the PCIe capabilities structure in bridge config space */
> +#define PCIE_CAP_BASE          0x70

This offset is discoverable, so don't hardcode it.

> +
>  struct apple_pcie {
>         struct mutex            lock;
>         struct device           *dev;
> +       struct pci_config_window *cfg;
>         void __iomem            *base;
>         struct irq_domain       *domain;
>         unsigned long           *bitmap;
> @@ -506,6 +514,48 @@ static u32 apple_pcie_rid2sid_write(struct apple_pcie_port *port,
>         return readl_relaxed(port->base + PORT_RID2SID(idx));
>  }
>
> +static inline void __iomem *bridge_reg(struct apple_pcie_port *port,
> +                                                 int where)
> +{
> +       struct pci_config_window *cfg = port->pcie->cfg;
> +
> +       return cfg->win + PCIE_ECAM_OFFSET(0, PCI_DEVFN(port->idx, 0), where);
> +}
> +
> +static void apple_pcie_unlock_dwc_regs(struct apple_pcie_port *port)
> +{
> +       rmw_set(PCIE_DBI_RO_WR_EN, bridge_reg(port, PCIE_MISC_CONTROL_1_OFF));
> +}
> +
> +static void apple_pcie_lock_dwc_regs(struct apple_pcie_port *port)
> +{
> +       rmw_clear(PCIE_DBI_RO_WR_EN, bridge_reg(port, PCIE_MISC_CONTROL_1_OFF));
> +}
> +
> +static int apple_pcie_link_configure_max_speed(struct apple_pcie_port *port)
> +{
> +       int max_gen;
> +       u32 ctrl2;
> +
> +       max_gen = of_pci_get_max_link_speed(port->np);
> +       if (max_gen < 0) {
> +               dev_err(port->pcie->dev, "max link speed not specified\n");

Better to fail than limp along in gen1? Though you don't check the
return value...

Usually, the DT property is there to limit the speed when there's a
board limitation.

> +               return max_gen;
> +       }
> +
> +       ctrl2 = readw_relaxed(bridge_reg(port, PCIE_CAP_BASE + PCI_EXP_LNKCTL2));
> +       ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
> +       ctrl2 |= FIELD_PREP(PCI_EXP_LNKCTL2_TLS, max_gen);
> +       writew_relaxed(ctrl2, bridge_reg(port, PCIE_CAP_BASE + PCI_EXP_LNKCTL2));
> +
> +       apple_pcie_unlock_dwc_regs(port);
> +       rmw_set(PORT_LOGIC_SPEED_CHANGE,
> +               bridge_reg(port, PCIE_LINK_WIDTH_SPEED_CONTROL));
> +       apple_pcie_lock_dwc_regs(port);
> +
> +       return 0;
> +}
> +
>  static int apple_pcie_setup_port(struct apple_pcie *pcie,
>                                  struct device_node *np)
>  {
> @@ -577,6 +627,8 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>         ret = apple_pcie_port_register_irqs(port);
>         WARN_ON(ret);
>
> +       apple_pcie_link_configure_max_speed(port);
> +
>         writel_relaxed(PORT_LTSSMCTL_START, port->base + PORT_LTSSMCTL);
>
>         if (!wait_for_completion_timeout(&pcie->event, HZ / 10))
> @@ -762,6 +814,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>                 return -ENOMEM;
>
>         pcie->dev = dev;
> +       pcie->cfg = cfg;
>
>         mutex_init(&pcie->lock);
>
> --
> 2.33.0
>
