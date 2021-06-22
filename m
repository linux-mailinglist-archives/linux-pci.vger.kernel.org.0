Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C781A3B016A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhFVKfF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 06:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVKfD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 06:35:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05052C061574;
        Tue, 22 Jun 2021 03:32:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v20-20020a05600c2154b02901dcefb16af0so1899307wml.5;
        Tue, 22 Jun 2021 03:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kS4oAUuWaMHVUklwJ1beuNFeJ6l+uz+qLj7A7UcUk9o=;
        b=MZekg6xgVsfuJCgnS4TXfqq4utWz6WSmXU121jMidmadbwOD7qqlL4PZmptVcvi7DC
         adPGScz3tiarJBMvqwwVh/QMF0TGO0AeAdR6ut11Pe0sbQDG9bm98DA4sEIyJbCBuX1E
         2yNbXL2wjNUAGlY3SH797SE5yn2EIGzb/vc+3g8eMdAR1S0I7ylAppXj5oRcKq5kN6vt
         XjJvx4/qlmVva5gYJknTmsaT80gonr/Jn56dIVczyzOdn5cT55UBbd5+/eY5Zsjl+Ntn
         oDS0gpX5sjeJvFCUMNlUL2I+4efKDwWf2AFgat53tghs+ZKD6FrngUlqo7kck6YzLudB
         JUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kS4oAUuWaMHVUklwJ1beuNFeJ6l+uz+qLj7A7UcUk9o=;
        b=qNBrwBA7dQkv611z63myZc0cYso780+XEM83eZ4b+fj6xq+j2dQmd9eTPq6kWBZd3G
         hNMYgFU6Bq1WNQjnlfTOcUe5QfjeQvp2wGt6CY80lvZF30j7tu7e5cBQCbgLdYvFhNyv
         E+MludJOPHyQzdvqG6KGaSrQRN5Mv07RQWYU5mhA6HuLMYZ6MK23S/0bpP86qMfSqygk
         88Mu9/c52MzLC22vLTJv4Ci3HwjIhmoJgTURIa2BhbTijMkOK5JtnI2LyowbN1Tn6mRP
         jXQ2ahyUUKLxu4w5ecFcThbvaTT/ltEE9NMD5c60zIQuKtFXK/YO4euCE5J3Ao/49uhX
         YLOg==
X-Gm-Message-State: AOAM531BhSun860gkOOj66jyqiNsJmDiovtkQsHEKTdQA8fM20T/3/7V
        8k2BYYXT4hxZUKzixEl8NlHB/a9kDRUtMgdj0RM=
X-Google-Smtp-Source: ABdhPJzrVABs2f1bB8saw++I0vpi8xMZQMK7RtV6mWmNHPjc7c8Cnt5wweHzlBBxdzIjswvGMxcUmMIX1G1Mwaq5U/0=
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr2169770wmh.97.1624357964513;
 Tue, 22 Jun 2021 03:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <1610690680-28493-1-git-send-email-wuht06@gmail.com>
 <1610690680-28493-3-git-send-email-wuht06@gmail.com> <20210621142032.GA27516@lpieralisi>
In-Reply-To: <20210621142032.GA27516@lpieralisi>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 22 Jun 2021 18:32:08 +0800
Message-ID: <CAAfSe-uJBce2JbFgiNm-hLcjKZcB3ReBqc-r0NiHqQACT46CyQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] PCI: sprd: Add support for Unisoc SoCs' PCIe controller
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Hongtao Wu <wuht06@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-pci@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hongtao Wu <billows.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Jun 2021 at 22:20, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Jan 15, 2021 at 02:04:40PM +0800, Hongtao Wu wrote:
> > From: Hongtao Wu <billows.wu@unisoc.com>
> >
> > This series adds PCIe controller driver for Unisoc SoCs.
> > This controller is based on DesignWare PCIe IP.
> >
> > Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig     |  12 ++
> >  drivers/pci/controller/dwc/Makefile    |   1 +
> >  drivers/pci/controller/dwc/pcie-sprd.c | 293 +++++++++++++++++++++++++++++++++
> >  3 files changed, 306 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 22c5529..61f0b79 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -318,4 +318,16 @@ config PCIE_AL
> >         required only for DT-based platforms. ACPI platforms with the
> >         Annapurna Labs PCIe controller don't need to enable this.
> >
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
> > index 0000000..03e2064
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-sprd.c
> > @@ -0,0 +1,293 @@
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
>
> I think you should add a comment to explain what this function
> enables - it is unclear.

Yes, I agree, maybe also need to change to a more reasonable name :)
I will think about it.

>
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
> This delay seems arbitrary.

Yes, I guess it came out from some tests result, I need to double
check with my colleagues.

> The PCI specifications require a 100ms
> after issuing PERST before link training is enabled.
>
> Have a look at e.g. drivers/pci/controller/pci-aardvark.c
>
> > +
> > +     return ret;
> > +}
> > +
> > +static int sprd_pcie_power_on(struct platform_device *pdev)
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
>
> This looks a bit weird but I believe that's just a naming convention.
>
> It looks like if we *fail* to power the controller on we power it
> off, which does not make much sense.
>
> I guess the goal in err_power_off is to clean-up what  was done in
> sprd_pcie_power_on() - more below.

Yes, maybe we need to give it a more suitable name as well.

>
> > +     }
> > +
> > +     ret = sprd_add_pcie_port(pdev);
> > +     if (ret) {
> > +             dev_warn(dev, "failed to initialize RC controller\n");
> > +             return ret;
>
> If we go by the same logic, we shouldn't return but rather
>
> goto err_power_off;

Right, I will address this.

Many thanks for your review,
Chunyan

>
> on error here. Am I missing something ?
>
> Lorenzo
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
> > +
> > +module_platform_driver(sprd_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.7.4
> >
