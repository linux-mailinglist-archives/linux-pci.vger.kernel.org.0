Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9515055D1C3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiF1HqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 03:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiF1HqC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 03:46:02 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B50393;
        Tue, 28 Jun 2022 00:46:01 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 59so18887206qvb.3;
        Tue, 28 Jun 2022 00:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLWiFh12gh95e64oYxNRI8b+MQAMezyYlf+qfYtWf4Y=;
        b=Ee3sqL4ujywC+gZRF3RW50O4yu5R7tw7kL0Lfiqwf2ILBO0JnVjkut2c+d/viEAKse
         T7hZrbKohzxKzY8TGF1pJQxGHfK763Row/gGG9dOspvmM/L2gitOAoJq2LgwMGXVmRdO
         M5nu80uJ4JwLMJQi7DfuH+oxvJL0BUZ1UQQU28amBF50P5WjDfXyNp/Sw6tuzEhmdMrX
         m1fcGKvl1fiYcwIL8xQdaX2vU27wdJBcUyUjOYubeWu2T9y+/WzY68GVEVMxWsIbU6J8
         VCQJgUenS2FglfMvBHRZzH4qCIn/um8ZyAbWUWUjLf+64XjY1g2WrWdhZOgbH2GgBbbP
         FwMg==
X-Gm-Message-State: AJIora/qynyq0S+D7zjChdUuwujU6IY9UyE9T8UPlIPXYcaZPA7YVGNH
        pRFclj5O35TP5pvmScaHCAGyIdoigS6mxQ==
X-Google-Smtp-Source: AGRyM1sOsj9lzS4wioxPz4ggmGIZYBawM3JOq7LzIxBt1+879UiVuMmyL4f9vnasOBJN4JtXRjDf6Q==
X-Received: by 2002:ad4:57c6:0:b0:470:2a33:46df with SMTP id y6-20020ad457c6000000b004702a3346dfmr1187526qvx.35.1656402360179;
        Tue, 28 Jun 2022 00:46:00 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006aedbb30947sm1173112qkp.122.2022.06.28.00.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 00:45:58 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id q132so20769754ybg.10;
        Tue, 28 Jun 2022 00:45:58 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr18814093ybb.202.1656402357916; Tue, 28
 Jun 2022 00:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220627122417.809615-1-yoshihiro.shimoda.uh@renesas.com> <20220627122417.809615-10-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220627122417.809615-10-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jun 2022 09:45:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWKzjzRi_TmGAobPXu_Dk8dKaQeeZkssR_uk6jT4Hic5Q@mail.gmail.com>
Message-ID: <CAMuHMdWKzjzRi_TmGAobPXu_Dk8dKaQeeZkssR_uk6jT4Hic5Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] PCI: renesas: Add R-Car Gen4 PCIe Host support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

On Mon, Jun 27, 2022 at 2:24 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add R-Car Gen4 PCIe Host support. This controller is based on
> Synopsys DesignWare PCIe.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +
> +#include "pcie-rcar-gen4.h"
> +#include "pcie-designware.h"
> +
> +static int rcar_gen4_pcie_host_init(struct pcie_port *pp)
> +{
> +       struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> +       struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +       int ret;
> +       u32 val;
> +
> +       rcar_gen4_pcie_set_device_type(rcar, true, dw->num_lanes);
> +
> +       dw_pcie_dbi_ro_wr_en(dw);
> +
> +       /* Enable L1 Substates */
> +       val = dw_pcie_readl_dbi(dw, L1PSCAP(PCI_L1SS_CTL1));
> +       val &= ~PCI_L1SS_CTL1_L1SS_MASK;
> +       val |= PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_1 |
> +              PCI_L1SS_CTL1_ASPM_L1_2 | PCI_L1SS_CTL1_ASPM_L1_1;
> +       dw_pcie_writel_dbi(dw, L1PSCAP(PCI_L1SS_CTL1), val);
> +
> +       rcar_gen4_pcie_disable_bar(dw, BAR0MASKF);
> +       rcar_gen4_pcie_disable_bar(dw, BAR1MASKF);
> +
> +       /* Set Root Control */
> +       val = dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_RTCTL));
> +       val |= PCI_EXP_RTCTL_SECEE | PCI_EXP_RTCTL_SENFEE |
> +              PCI_EXP_RTCTL_SEFEE | PCI_EXP_RTCTL_PMEIE |
> +              PCI_EXP_RTCTL_CRSSVE;
> +       dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_RTCTL), val);
> +
> +       /* Set Interrupt Disable, SERR# Enable, Parity Error Response */
> +       val = dw_pcie_readl_dbi(dw, PCI_COMMAND);
> +       val |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR |
> +              PCI_COMMAND_INTX_DISABLE;
> +       dw_pcie_writel_dbi(dw, PCI_COMMAND, val);
> +
> +       /* Enable SERR */
> +       val = dw_pcie_readb_dbi(dw, PCI_BRIDGE_CONTROL);
> +       val |= PCI_BRIDGE_CTL_SERR;
> +       dw_pcie_writeb_dbi(dw, PCI_BRIDGE_CONTROL, val);
> +
> +       /* Device control */
> +       val = dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_DEVCTL));
> +       val |= PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE |
> +              PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE;
> +       dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_DEVCTL), val);
> +
> +       dw_pcie_dbi_ro_wr_dis(dw);
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +               /* Enable MSI interrupt signal */
> +               val = rcar_gen4_pcie_readl(rcar, PCIEINTSTS0EN);
> +               val |= MSI_CTRL_INT;
> +               rcar_gen4_pcie_writel(rcar, PCIEINTSTS0EN, val);
> +       }
> +
> +       dw_pcie_setup_rc(pp);
> +
> +       dw_pcie_dbi_ro_wr_en(dw);
> +       rcar_gen4_pcie_set_max_link_width(dw, dw->num_lanes);
> +       dw_pcie_dbi_ro_wr_dis(dw);
> +
> +       if (!dw_pcie_link_up(dw)) {
> +               ret = dw->ops->start_link(dw);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       /* Ignore errors, the link may come up later */
> +       if (dw_pcie_wait_for_link(dw))
> +               dev_info(dw->dev, "PCIe link down\n");
> +
> +       return 0;
> +}
> +
> +static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
> +       .host_init = rcar_gen4_pcie_host_init,
> +};
> +
> +static int rcar_gen4_add_pcie_port(struct rcar_gen4_pcie *rcar,
> +                                  struct platform_device *pdev)
> +{
> +       struct dw_pcie *dw = &rcar->dw;
> +       struct pcie_port *pp = &dw->pp;
> +       int ret;
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +               pp->msi_irq = platform_get_irq_byname(pdev, "others");
> +               if (pp->msi_irq < 0)
> +                       return pp->msi_irq;
> +       }
> +
> +       pp->ops = &rcar_gen4_pcie_host_ops;
> +
> +       ret = dw_pcie_host_init(pp);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to initialize host\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void rcar_gen4_remove_pcie_port(struct rcar_gen4_pcie *rcar)
> +{
> +       dw_pcie_host_deinit(&rcar->dw.pp);
> +}
> +
> +static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> +                                       struct platform_device *pdev)
> +{
> +       struct dw_pcie *dw = &rcar->dw;
> +
> +       /* Renesas-specific registers */
> +       rcar->base = devm_platform_ioremap_resource_byname(pdev, "app");
> +       if (IS_ERR(rcar->base))
> +               return PTR_ERR(rcar->base);
> +
> +       return rcar_gen4_pcie_devm_reset_get(rcar, dw->dev);
> +}
> +
> +static int rcar_gen4_pcie_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct rcar_gen4_pcie *rcar;
> +       int err;
> +
> +       rcar = rcar_gen4_pcie_devm_alloc(dev);
> +       if (!rcar)
> +               return -ENOMEM;
> +
> +       err = rcar_gen4_pcie_pm_runtime_enable(dev);
> +       if (err < 0) {
> +               dev_err(dev, "pm_runtime_get_sync failed\n");
> +               return err;
> +       }
> +
> +       err = rcar_gen4_pcie_get_resources(rcar, pdev);
> +       if (err < 0) {
> +               dev_err(dev, "failed to request resource: %d\n", err);
> +               goto err_pm_put;
> +       }
> +
> +       platform_set_drvdata(pdev, rcar);
> +
> +       err = rcar_gen4_pcie_prepare(rcar);
> +       if (err < 0)
> +               goto err_pm_put;
> +
> +       err = rcar_gen4_add_pcie_port(rcar, pdev);
> +       if (err < 0)
> +               goto err_host_disable;
> +
> +       return 0;
> +
> +err_host_disable:
> +       rcar_gen4_pcie_unprepare(rcar);
> +
> +err_pm_put:
> +       rcar_gen4_pcie_pm_runtime_disable(dev);
> +
> +       return err;
> +}
> +
> +static int rcar_gen4_pcie_remove(struct platform_device *pdev)
> +{
> +       struct rcar_gen4_pcie *rcar = platform_get_drvdata(pdev);
> +
> +       rcar_gen4_remove_pcie_port(rcar);
> +       rcar_gen4_pcie_unprepare(rcar);
> +       rcar_gen4_pcie_pm_runtime_disable(&pdev->dev);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> +       { .compatible = "renesas,rcar-gen4-pcie", },
> +       {},
> +};
> +
> +static struct platform_driver rcar_gen4_pcie_driver = {
> +       .driver = {
> +               .name = "pcie-rcar-gen4",
> +               .of_match_table = rcar_gen4_pcie_of_match,
> +       },
> +       .probe = rcar_gen4_pcie_probe,
> +       .remove = rcar_gen4_pcie_remove,
> +};
> +module_platform_driver(rcar_gen4_pcie_driver);
> +
> +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> new file mode 100644
> index 000000000000..fa9588ed75e0
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series SoCs
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +
> +#include "pcie-rcar-gen4.h"
> +#include "pcie-designware.h"
> +
> +/* Renesas-specific */
> +#define PCIERSTCTRL1           0x0014
> +#define  APP_HOLD_PHY_RST      BIT(16)
> +#define  APP_LTSSM_ENABLE      BIT(0)
> +
> +#define DWC_VERSION            0x520a
> +
> +u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *rcar, u32 reg)
> +{
> +       return readl(rcar->base + reg);
> +}
> +
> +void rcar_gen4_pcie_writel(struct rcar_gen4_pcie *rcar, u32 reg, u32 val)
> +{
> +       writel(val, rcar->base + reg);
> +}

Do you really need helper functions for this? You need to type less
when open-coding.
If you insist, please make them static inline in the header file.

> +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
> +{
> +       return reset_control_deassert(rcar->rst);
> +}
> +
> +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
> +{
> +       reset_control_assert(rcar->rst);
> +}

Static inline in header file?

> +
> +int rcar_gen4_pcie_pm_runtime_enable(struct device *dev)
> +{
> +       pm_runtime_enable(dev);
> +       return pm_runtime_get_sync(dev);

Please use pm_runtime_resume_and_get() in new code.

> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
