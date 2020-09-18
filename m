Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E591326EACC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 04:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgIRCAw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 22:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIRCAw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2020 22:00:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E25C06174A;
        Thu, 17 Sep 2020 19:00:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t16so4472211edw.7;
        Thu, 17 Sep 2020 19:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LWuM1zbIfjpHSv/XIhF8NZbMe6yKI2OR77j7oo+l0s=;
        b=Lq4+yzB4WQYtAEytFKFCDiL/3O+xW6C8xPdoYUOWvm+F2sCigudCwW72KoFy0X0clk
         QNkLxKD3ilgfX/BcNvSAG+pqtF6K6Vzigu6yWmLJCkDf1UBENiDRbx+MoowUyHDYd9A8
         NlV/av4C3PptetGGcaV4A5anwWoRhZDZv4hSEGo1zfdDGY3dnAC7By1lOUIjhsxfwXxI
         lWpy7nxPN1R0zcCpcyUMXE2dDvnoOFesdbLu1sq08S+t5nJ/IXAjUrJUpG0yd6hxeoWq
         0jioCSJojx8JuIRuClmrX+sl88FxNKsp7Veipvhswr5sCG+/MhKuHRUgMwW0tyyzh0Rw
         2JNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LWuM1zbIfjpHSv/XIhF8NZbMe6yKI2OR77j7oo+l0s=;
        b=VWHF4XblV+WinSb639CC9nqj/gYW9klGFZyRv2w28oF715s2wt5eyD2Z+ccTLaIyHw
         pEkGiVvsVj5aFS8wMwvZPCoIGUzWDCTJINZSnVfVzJj/6Z2YWbiZPSeQ3Jh+5opdBjfX
         WayO+sCqntULb7QcnYGL1yVvK56nqaEy/tcCTfkNDQYxrbaJgEIH4m0sjmzo5kmedOAN
         ++xFskp8Ybj2lhOCf1Y14V1s8HJCK1eCqLjgdX2wsfN6y47CYCzhTAhd1I+OVI1O5HGk
         3Jdwabc5phIrlw36qbcneo0XFNYJP2k9edicv3lgAOwsXvaLMjNVHRfJXykwKvusQkD5
         PrwA==
X-Gm-Message-State: AOAM531Kbg6Fm+nj1PIGnAm3nyzhjM3LQjVn+jyEDm7BLn4NMMZv3Sx6
        zi/2ULRP8FyctOl3WjSYA9sxwiZKJRjudw/eza8=
X-Google-Smtp-Source: ABdhPJzgiVP5LCgwkWgkGv6DB2/htX5lmgSkiFWK5sJekJkA6cLEyc1kmehFDtNX2d0lPgxFsIsy9hDUqNNxEBZlTu0=
X-Received: by 2002:aa7:cd5a:: with SMTP id v26mr34976400edw.38.1600394450107;
 Thu, 17 Sep 2020 19:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <1599644912-29245-1-git-send-email-wuht06@gmail.com>
 <1599644912-29245-3-git-send-email-wuht06@gmail.com> <20200915173101.GB2146778@bogus>
In-Reply-To: <20200915173101.GB2146778@bogus>
From:   Hongtao Wu <wuht06@gmail.com>
Date:   Fri, 18 Sep 2020 10:00:38 +0800
Message-ID: <CAG_R4_Wuxn_TDHrHxKcyc5xBXshij5q86-zwrO31=gdz6Pse+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: sprd: Add support for Unisoc SoCs' PCIe controller
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bob,
Thanks for the review.

On Wed, Sep 16, 2020 at 1:31 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 09, 2020 at 05:48:32PM +0800, Hongtao Wu wrote:
> > From: Hongtao Wu <billows.wu@unisoc.com>
> >
> > This series adds PCIe controller driver for Unisoc SoCs.
> > This controller is based on DesignWare PCIe IP.
> >
> > Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig     |  13 ++
> >  drivers/pci/controller/dwc/Makefile    |   1 +
> >  drivers/pci/controller/dwc/pcie-sprd.c | 231 +++++++++++++++++++++++++++++++++
> >  3 files changed, 245 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 044a376..0553010 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -311,4 +311,17 @@ config PCIE_AL
> >         required only for DT-based platforms. ACPI platforms with the
> >         Annapurna Labs PCIe controller don't need to enable this.
> >
> > +
> > +config PCIE_SPRD
> > +     tristate "Unisoc PCIe controller - Host Mode"
> > +     depends on ARCH_SPRD || COMPILE_TEST
> > +     depends on PCI_MSI_IRQ_DOMAIN
> > +     select PCIE_DW_HOST
> > +     help
> > +       Unisoc PCIe controller uses the DesignWare core. It can be configured
> > +       as an Endpoint (EP) or a Root complex (RC). In order to enable host
> > +       mode (the controller works as RC), PCIE_SPRD must be selected.
> > +       Say Y or M here if you want to PCIe RC controller support on Unisoc
> > +       SoCs.
> > +
> >  endmenu
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > index a751553..eb546e9 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -20,6 +20,7 @@ obj-$(CONFIG_PCI_MESON) += pci-meson.o
> >  obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
> >  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
> >  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
> > +obj-$(CONFIG_PCIE_SPRD) += pcie-sprd.o
> >
> >  # The following drivers are for devices that use the generic ACPI
> >  # pci_root.c driver but don't support standard ECAM config access.
> > diff --git a/drivers/pci/controller/dwc/pcie-sprd.c b/drivers/pci/controller/dwc/pcie-sprd.c
> > new file mode 100644
> > index 0000000..cec4f34
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-sprd.c
> > @@ -0,0 +1,231 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe host controller driver for Unisoc SoCs
> > + *
> > + * Copyright (C) 2020 Unisoc, Inc.
> > + *
> > + * Author: Hongtao Wu <Billows.Wu@unisoc.com>
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "pcie-designware.h"
> > +
> > +#define NUM_OF_ARGS 5
> > +
> > +struct sprd_pcie {
> > +     struct dw_pcie pci;
> > +};
> > +
> > +static int sprd_pcie_syscon_setting(struct platform_device *pdev, char *env)
> > +{
> > +     struct device_node *np = pdev->dev.of_node;
> > +     int i, count, err;
> > +     u32 type, delay, reg, mask, val, tmp_val;
> > +     struct of_phandle_args out_args;
> > +     struct regmap *iomap;
> > +     struct device *dev = &pdev->dev;
> > +
> > +     if (!of_find_property(np, env, NULL)) {
> > +             dev_info(dev, "There isn't property %s in dts\n", env);
> > +             return 0;
> > +     }
> > +
> > +     count = of_property_count_elems_of_size(np, env,
> > +                                     (NUM_OF_ARGS + 1) * sizeof(u32));
> > +     dev_info(dev, "Property (%s) reg count is %d :\n", env, count);
> > +
> > +     for (i = 0; i < count; i++) {
> > +             err = of_parse_phandle_with_fixed_args(np, env, NUM_OF_ARGS,
> > +                                                    i, &out_args);
> > +             if (err < 0)
> > +                     return err;
> > +
> > +             type = out_args.args[0];
> > +             delay = out_args.args[1];
> > +             reg = out_args.args[2];
> > +             mask = out_args.args[3];
> > +             val = out_args.args[4];
> > +
> > +             iomap = syscon_node_to_regmap(out_args.np);
> > +
> > +             switch (type) {
> > +             case 0:
> > +                     regmap_update_bits(iomap, reg, mask, val);
> > +                     break;
> > +
> > +             case 1:
> > +                     regmap_read(iomap, reg, &tmp_val);
> > +                     tmp_val &= (~mask);
> > +                     tmp_val |= (val & mask);
> > +                     regmap_write(iomap, reg, tmp_val);
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +
> > +             if (delay)
> > +                     usleep_range(delay, delay + 10);
> > +
> > +             regmap_read(iomap, reg, &tmp_val);
> > +             dev_dbg(dev,
> > +                     "%2d:reg[0x%8x] mask[0x%8x] val[0x%8x] result[0x%8x]\n",
> > +                     i, reg, mask, val, tmp_val);
> > +     }
> > +
> > +     return i;
> > +}
> > +
> > +static int sprd_pcie_perst_assert(struct platform_device *pdev)
> > +{
> > +     return sprd_pcie_syscon_setting(pdev, "sprd,pcie-perst-assert");
>
> Not documented. This should probably use the reset binding.
>

Thanks! I'll Document it in the next version.

> > +}
> > +
> > +static int sprd_pcie_perst_deassert(struct platform_device *pdev)
> > +{
> > +     return sprd_pcie_syscon_setting(pdev, "sprd,pcie-perst-deassert");
> > +}
> > +
> > +static int sprd_pcie_power_on(struct platform_device *pdev)
> > +{
> > +     int ret;
> > +     struct device *dev = &pdev->dev;
> > +
> > +     ret = sprd_pcie_syscon_setting(pdev, "sprd,pcie-poweron-syscons");
> > +     if (ret < 0)
> > +             dev_err(dev,
> > +                     "failed to set pcie poweroff syscons, return %d\n",
> > +                     ret);
> > +
> > +     sprd_pcie_perst_deassert(pdev);
> > +
> > +     return ret;
> > +}
> > +
> > +static int sprd_pcie_power_off(struct platform_device *pdev)
> > +{
> > +     int ret;
> > +     struct device *dev = &pdev->dev;
> > +
> > +     sprd_pcie_perst_assert(pdev);
> > +
> > +     ret = sprd_pcie_syscon_setting(pdev, "sprd,pcie-poweroff-syscons");
> > +     if (ret < 0)
> > +             dev_err(dev,
> > +                     "failed to set pcie poweroff syscons, return %d\n",
> > +                     ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int sprd_pcie_host_init(struct pcie_port *pp)
> > +{
> > +     int ret;
> > +     struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +
> > +     dw_pcie_setup_rc(pp);
> > +     dw_pcie_msi_init(pp);
> > +
> > +     ret = dw_pcie_wait_for_link(pci);
> > +     if (ret)
> > +             dev_err(pci->dev, "pcie ep may has not been powered on yet\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct dw_pcie_host_ops sprd_pcie_host_ops = {
> > +     .host_init = sprd_pcie_host_init,
> > +};
> > +
> > +static int sprd_add_pcie_port(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct sprd_pcie *ctrl = platform_get_drvdata(pdev);
> > +     struct dw_pcie *pci = &ctrl->pci;
> > +     struct pcie_port *pp = &pci->pp;
> > +
> > +     pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> > +     if (IS_ERR(pci->dbi_base)) {
> > +             dev_err(dev, "failed to get rc dbi base\n");
> > +             return PTR_ERR(pci->dbi_base);
> > +     }
> > +
> > +     pp->ops = &sprd_pcie_host_ops;
> > +
> > +     if (IS_ENABLED(CONFIG_PCI_MSI)) {
>
> I don't think this check is needed. The DW core won't setup the MSI if
> not enabled, so doesn't matter if msi_irq is initialized.
>

Thanks!
I'll delete it in the next version.

> > +             pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> > +             if (pp->msi_irq < 0) {
> > +                     dev_err(dev, "failed to get msi, return %d\n",
> > +                             pp->msi_irq);
>
> No need to print an error, the core does this.
>

Thanks!
I'll delete it in the next version.

> > +                     return pp->msi_irq;
> > +             }
> > +     }
> > +
> > +     return dw_pcie_host_init(pp);
> > +}
> > +
> > +static int sprd_pcie_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct sprd_pcie *ctrl;
> > +     struct dw_pcie *pci;
> > +     int ret;
> > +
> > +     ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
> > +     if (!ctrl)
> > +             return -ENOMEM;
> > +
> > +     pci = &ctrl->pci;
> > +     pci->dev = dev;
> > +
> > +     platform_set_drvdata(pdev, ctrl);
> > +
> > +     ret = sprd_pcie_power_on(pdev);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to get pcie poweron syscons, return %d\n",
> > +                     ret);
> > +             goto err_power_off;
> > +     }
> > +
> > +     ret = sprd_add_pcie_port(pdev);
> > +     if (ret) {
> > +             dev_warn(dev, "failed to initialize RC controller\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_power_off:
> > +     sprd_pcie_power_off(pdev);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct of_device_id sprd_pcie_of_match[] = {
> > +     {
> > +             .compatible = "sprd,pcie-rc",
> > +     },
> > +     {},
> > +};
> > +
> > +static struct platform_driver sprd_pcie_driver = {
> > +     .probe = sprd_pcie_probe,
>
> You need a .remove hook.
>

Yes! I'll fix it.

> > +     .driver = {
> > +             .name = "sprd-pcie",
> > +             .of_match_table = sprd_pcie_of_match,
> > +     },
> > +};
> > +
> > +module_platform_driver(sprd_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.7.4
> >
