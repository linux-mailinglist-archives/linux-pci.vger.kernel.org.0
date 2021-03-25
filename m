Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568103488D7
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 07:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCYGPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 02:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCYGPI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 02:15:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF87C06174A;
        Wed, 24 Mar 2021 23:15:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so1080064wrd.1;
        Wed, 24 Mar 2021 23:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8BSD/afGA/kpgKnNinYwMRTAIzVNw5acL8XlvM8Wyo=;
        b=UUFVOp7rGulHdaJ0fgqvcUrOQ0MUedjZ67xO6JWZftE1dgAVc9RXkf2sP6r53/lZKm
         3wTSn/pT9BI+lw9j8AaqOcJkxyaATO6cR6DsDBbRotiSS1hyf31rj+LRauzfVTYsV6sN
         WPCk2pP6eR7tdQZ3oHBtbTXGH59qIT4EgrA9+oYx8BKpJunJUBSvp66OzgSC5Mme4byv
         s2xiEev6nbEXAzZuLidCN5WkOiv0blMkW1185fSp3A6z0nPK5TTe8x181jw3Y/aI806u
         RWv005FzYcW8ZqSTFSoRioeJ1zZrOmAfE+ZGNb9lgQy2SM2UwKybwVXSMVQ/WJkY3jxy
         uCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8BSD/afGA/kpgKnNinYwMRTAIzVNw5acL8XlvM8Wyo=;
        b=rUGAcTxEHCUr+lGsyoT/umrsEgd10uU5W8m/leZB9u+bWsfslRuuuzlnLNAb/PBFoD
         m/M13/LBbVh5Zg43SRU96Aj8dFSRmLEgT3Dv9JcmCsSiWgqmn6iomMlBwSZ6zioaYzHa
         yDssfRxI7vRXBHd91VLTlAP6MLhzvmSpz/31KhWuEDuBqVsLbfDnmLT/5bu8gkbbpmh6
         +wyf0j0/+dTMrpU6eJTm2r1+gMctYxa83kjqWZicHk3AJmYs+Vu/6jbQbi9jIKm7oepC
         PVTNGu6A1wO9ipFPe5RisLCzNntetz30hP/ERhfFxI0Kvik4ChPg3W2P3gg6fXnv6oLK
         tTzg==
X-Gm-Message-State: AOAM5308RvZgMqAE57fzqA+PSQ8sWoVwWSCdLYFbleScNJpEB3QgHshc
        wZj02gPM1Nnn4Ee/H14K7/Il9SCDb9udrysuB3c=
X-Google-Smtp-Source: ABdhPJwhM+qgh2+iSGIm8lURrwAzV7sZID4SM1OwUowf6Cefou61q28KmgoIaTw/CDWBqhrBJv+xVWdGL2bis/h+FQA=
X-Received: by 2002:adf:de91:: with SMTP id w17mr7104133wrl.268.1616652906353;
 Wed, 24 Mar 2021 23:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210322091831.662279-3-zhang.lyra@gmail.com> <20210323203032.GA599704@bjorn-Precision-5520>
In-Reply-To: <20210323203032.GA599704@bjorn-Precision-5520>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 25 Mar 2021 14:14:29 +0800
Message-ID: <CAAfSe-uYr1UPYn2TNh7xh5O3nhdMLFHF1nBN-goUMZ=L7gFxrw@mail.gmail.com>
Subject: Re: [RESEND PATCH V6 2/2] PCI: sprd: Add support for Unisoc SoCs'
 PCIe controller
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>, Hongtao Wu <wuht06@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, 24 Mar 2021 at 04:30, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Mar 22, 2021 at 05:18:31PM +0800, Chunyan Zhang wrote:
> > From: Hongtao Wu <billows.wu@unisoc.com>
> >
> > This series adds PCIe controller driver for Unisoc SoCs.
> > This controller is based on DesignWare PCIe IP.
> >
> > Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> > Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig     |  12 +
> >  drivers/pci/controller/dwc/Makefile    |   1 +
> >  drivers/pci/controller/dwc/pcie-sprd.c | 292 +++++++++++++++++++++++++
> >  3 files changed, 305 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 22c5529e9a65..61f0b79f963d 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -318,4 +318,16 @@ config PCIE_AL
> >         required only for DT-based platforms. ACPI platforms with the
> >         Annapurna Labs PCIe controller don't need to enable this.
> >
> > +config PCIE_SPRD
>
> Maybe you want PCIE_SPRD_HOST for this one so there's room for a
> PCIE_SPRD_EP someday?

yes, it makes sense, will address.

>
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
> > index a751553fa0db..eb546e97c14a 100644
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
> > index 000000000000..2ccb99eda24f
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-sprd.c
> > @@ -0,0 +1,292 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe host controller driver for Unisoc SoCs
> > + *
> > + * Copyright (C) 2020-2021 Unisoc, Inc.
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
> > +/* aon apb syscon */
> > +#define IPA_ACCESS_CFG               0xcd8
> > +#define  AON_ACCESS_PCIE_EN  BIT(1)
> > +
> > +/* pmu apb syscon */
> > +#define SNPS_PCIE3_SLP_CTRL  0xac
> > +#define  PERST_N_ASSERT              BIT(1)
> > +#define  PERST_N_AUTO_EN     BIT(0)
> > +#define PD_PCIE_CFG_0                0x3e8
> > +#define  PCIE_FORCE_SHUTDOWN BIT(25)
> > +
> > +#define PCIE_SS_REG_BASE             0xE00
>
> Pick uppercase or lowercase for your hex constants and use it
> consistently.
>
> > +#define APB_CLKFREQ_TIMEOUT          0x4
> > +#define  BUSERR_EN                   BIT(12)
> > +#define  APB_TIMER_DIS                       BIT(10)
> > +#define  APB_TIMER_LIMIT             GENMASK(31, 16)
> > +
> > +#define PE0_GEN_CTRL_3                       0x58
> > +#define  LTSSM_EN                    BIT(0)
> > +
> > +struct sprd_pcie_soc_data {
> > +     u32 syscon_offset;
> > +};
> > +
> > +static const struct sprd_pcie_soc_data ums9520_syscon_data = {
> > +     .syscon_offset = 0x1000,        /* The offset of set/clear register */
> > +};
> > +
> > +struct sprd_pcie {
> > +     u32 syscon_offset;
> > +     struct device   *dev;
> > +     struct dw_pcie  *pci;
> > +     struct regmap   *aon_map;
> > +     struct regmap   *pmu_map;
> > +     const struct sprd_pcie_soc_data *socdata;
> > +};
> > +
> > +enum sprd_pcie_syscon_type {
> > +     normal_syscon,          /* it's not a set/clear register */
> > +     set_syscon,             /* set a set/clear register */
> > +     clr_syscon,             /* clear a set/clear register */
> > +};
> > +
> > +static void sprd_pcie_buserr_enable(struct dw_pcie *pci)
> > +{
> > +     u32 val;
> > +
> > +     val = dw_pcie_readl_dbi(pci, PCIE_SS_REG_BASE + APB_CLKFREQ_TIMEOUT);
> > +     val &= ~APB_TIMER_DIS;
> > +     val |= BUSERR_EN;
> > +     val |= APB_TIMER_LIMIT & (0x1f4 << 16);
> > +     dw_pcie_writel_dbi(pci, PCIE_SS_REG_BASE + APB_CLKFREQ_TIMEOUT, val);
> > +}
> > +
> > +static void sprd_pcie_ltssm_enable(struct dw_pcie *pci, bool enable)
> > +{
> > +     u32 val;
> > +
> > +     val = dw_pcie_readl_dbi(pci, PCIE_SS_REG_BASE + PE0_GEN_CTRL_3);
> > +     if (enable)
> > +             dw_pcie_writel_dbi(pci, PCIE_SS_REG_BASE + PE0_GEN_CTRL_3,
> > +                                val | LTSSM_EN);
> > +     else
> > +             dw_pcie_writel_dbi(pci, PCIE_SS_REG_BASE + PE0_GEN_CTRL_3,
> > +                                val & ~LTSSM_EN);
> > +}
> > +
> > +static int sprd_pcie_syscon_set(struct sprd_pcie *ctrl, struct regmap *map,
> > +                             u32 reg, u32 mask, u32 val,
> > +                             enum sprd_pcie_syscon_type type)
> > +{
> > +     int ret = 0;
> > +     u32 read_val;
> > +     u32 offset = ctrl->syscon_offset;
> > +     struct device *dev = ctrl->pci->dev;
> > +
> > +     /*
> > +      * Each set/clear register has three registers:
> > +      * reg:                 base register
> > +      * reg + offset:        set register
> > +      * reg + offset * 2:    clear register
> > +      */
> > +     switch (type) {
> > +     case normal_syscon:
> > +             ret = regmap_read(map, reg, &read_val);
> > +             if (ret) {
> > +                     dev_err(dev, "failed to read register 0x%x\n", reg);
> > +                     return ret;
> > +             }
> > +             read_val &= ~mask;
> > +             read_val |= (val & mask);
> > +             ret = regmap_write(map, reg, read_val);
> > +             break;
> > +     case set_syscon:
> > +             reg = reg + offset;
> > +             ret = regmap_write(map, reg, val);
> > +             break;
> > +     case clr_syscon:
> > +             reg = reg + offset * 2;
> > +             ret = regmap_write(map, reg, val);
> > +             break;
> > +     default:
> > +             break;
>
> Unnecessary default case.

I can remove this, but I have been thinking that we should leave a
default case even if it does nothing to make the switch-case complete.

>
> > +     }
> > +
> > +     if (ret)
> > +             dev_err(dev, "failed to write register 0x%x\n", reg);
> > +
> > +     return ret;
> > +}
> > +
> > +static int sprd_pcie_perst_assert(struct sprd_pcie *ctrl)
> > +{
> > +     return sprd_pcie_syscon_set(ctrl, ctrl->pmu_map, SNPS_PCIE3_SLP_CTRL,
> > +                                 PERST_N_ASSERT, PERST_N_ASSERT, set_syscon);
> > +}
> > +
> > +static int sprd_pcie_perst_deassert(struct sprd_pcie *ctrl)
> > +{
> > +     int ret;
> > +
> > +     ret = sprd_pcie_syscon_set(ctrl, ctrl->pmu_map, SNPS_PCIE3_SLP_CTRL,
> > +                                PERST_N_ASSERT, 0, clr_syscon);
> > +     usleep_range(2000, 3000);
>
> It'd be nice to have a spec reference for this delay.

Ok.

>
> > +     return ret;
> > +}
> > +
> > +static int sprd_pcie_power_on(struct platform_device *pdev)
>
> You could pass in the "struct sprd_pcie *" here since the caller has
> that already.

Ok.

>
> > +{
> > +     int ret;
> > +     struct sprd_pcie *ctrl = platform_get_drvdata(pdev);
> > +     struct dw_pcie *pci = ctrl->pci;
> > +
> > +     ret = sprd_pcie_syscon_set(ctrl, ctrl->aon_map, PD_PCIE_CFG_0,
> > +                                PCIE_FORCE_SHUTDOWN, 0, clr_syscon);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = sprd_pcie_syscon_set(ctrl, ctrl->aon_map, IPA_ACCESS_CFG,
> > +                                AON_ACCESS_PCIE_EN, AON_ACCESS_PCIE_EN,
> > +                                set_syscon);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = sprd_pcie_perst_deassert(ctrl);
> > +     if (ret)
> > +             return ret;
> > +
> > +     sprd_pcie_buserr_enable(pci);
> > +     sprd_pcie_ltssm_enable(pci, true);
> > +
> > +     return ret;
> > +}
> > +
> > +static int sprd_pcie_power_off(struct platform_device *pdev)
>
> And here.  Caller would have to look up platform_get_drvdata(), as is
> done in other drivers.
>
> > +{
> > +     struct sprd_pcie *ctrl = platform_get_drvdata(pdev);
> > +     struct dw_pcie *pci = ctrl->pci;
> > +
> > +     sprd_pcie_ltssm_enable(pci, false);
> > +
> > +     sprd_pcie_perst_assert(ctrl);
> > +     sprd_pcie_syscon_set(ctrl, ctrl->aon_map, PD_PCIE_CFG_0,
> > +                          PCIE_FORCE_SHUTDOWN, PCIE_FORCE_SHUTDOWN,
> > +                          set_syscon);
> > +     sprd_pcie_syscon_set(ctrl, ctrl->aon_map, IPA_ACCESS_CFG,
> > +                          AON_ACCESS_PCIE_EN, 0, clr_syscon);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sprd_add_pcie_port(struct platform_device *pdev)
>
> And here.  Look at the other drivers in drivers/pci/controller/dwc/
> and make yours as much like them as possible.  This is not the place
> for innovation.

Ok, will do.

>
> > +{
> > +     struct sprd_pcie *ctrl = platform_get_drvdata(pdev);
> > +     struct dw_pcie *pci = ctrl->pci;
> > +     struct pcie_port *pp = &pci->pp;
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
> > +     ctrl->socdata =
> > +             (struct sprd_pcie_soc_data *)of_device_get_match_data(dev);
>
> Unnecessary cast.
>
> It doesn't look like you even need to save this pointer in the struct
> sprd_pcie.  You use it below to get syscon_offset, but never reference
> it after this function.
>
> > +     if (!ctrl->socdata) {
> > +             dev_warn(dev,
> > +                      "using the default set/clear register offset address");
> > +             ctrl->syscon_offset = 0x1000;
> > +     }
> > +     ctrl->syscon_offset = ctrl->socdata->syscon_offset;
> > +
> > +     ctrl->aon_map = syscon_regmap_lookup_by_phandle(dev->of_node,
> > +                                                     "sprd, regmap-aon");
> > +     if (IS_ERR(ctrl->aon_map)) {
> > +             dev_err(dev, "failed to get syscon regmap aon\n");
>
> I think it's worth mentioning the exact string ("sprd, regmap-aon")
> you were looking for.  Also below.
>
> > +             ret = PTR_ERR(ctrl->aon_map);
> > +             goto err;
> > +     }
> > +
> > +     ctrl->pmu_map = syscon_regmap_lookup_by_phandle(dev->of_node,
> > +                                                     "sprd, regmap-pmu");
> > +     if (IS_ERR(ctrl->pmu_map)) {
> > +             dev_err(dev, "failed to get syscon regmap pmu\n");
> > +             ret = PTR_ERR(ctrl->pmu_map);
> > +             goto err;
> > +     }
> > +
> > +     pci = ctrl->pci;
> > +     pci->dev = dev;
> > +
> > +     platform_set_drvdata(pdev, ctrl);
> > +
> > +     ret = sprd_pcie_power_on(pdev);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to power on, return %d\n",
> > +                     ret);
> > +             goto err_power_off;
> > +     }
> > +
> > +     ret = sprd_add_pcie_port(pdev);
> > +     if (ret) {
> > +             dev_warn(dev, "failed to initialize RC controller\n");
> > +             return ret;
>
> You power off for the previous error but not this one?

Yes, I will fix this.

Thanks for your review!

Chunyan

>
> > +     }
> > +
> > +     return 0;
> > +
> > +err_power_off:
> > +     sprd_pcie_power_off(pdev);
> > +err:
> > +     return ret;
> > +}
> > +
> > +static int sprd_pcie_remove(struct platform_device *pdev)
> > +{
> > +     sprd_pcie_power_off(pdev);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id sprd_pcie_of_match[] = {
> > +     {
> > +             .compatible = "sprd,ums9520-pcie",
> > +             .data  = &ums9520_syscon_data,
> > +     },
> > +     {},
> > +};
> > +
> > +static struct platform_driver sprd_pcie_driver = {
> > +     .probe = sprd_pcie_probe,
> > +     .remove = sprd_pcie_remove,
> > +     .driver = {
> > +             .name = "sprd-pcie",
> > +             .of_match_table = sprd_pcie_of_match,
> > +     },
> > +};
> > +module_platform_driver(sprd_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
