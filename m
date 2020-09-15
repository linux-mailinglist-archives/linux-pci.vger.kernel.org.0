Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCF326AC67
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 20:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgIORbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 13:31:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46779 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgIORbI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 13:31:08 -0400
Received: by mail-io1-f66.google.com with SMTP id g7so4942291iov.13;
        Tue, 15 Sep 2020 10:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2me8Sk20DKG9OBMVJhmDkF6GKPWBfCEhKi/ChgbtDhA=;
        b=P5e02evvs+CdjbgH8KUTrVDVzaNnanNZmjSemZSAWQU1Ez1gQqCOYw5EFDxZAZImYC
         dd3unybCyIPIbCLCHR0cKTxTA2kUH1vdU1UA+0VFs78AswPq1LZGnRzlYjqqS+JZRN2B
         2+4h3LG3LrJJlF8frSjRre7mhBsUu3RnFGsl6OE7gHFBhWmw2GxJPPzCAWF2hmekqLU4
         1b3SQDY/f6eQwP8GdOKi+dCn6RwywEk87X9361f/A6Svp6J5EUHIrQDZMM+8DWfDgGeo
         S4o59gM2cVqth+01ZVEQWVApjsopwbP5M8ejrYz4ki22zq/O71d5taqrNO9oJQmqyrbv
         bF9g==
X-Gm-Message-State: AOAM53048PIOXHUlABQopDkwbd7TVPryvy3kHTE4JPe+nZcWJX+vQhET
        nx1P4UzUtdWv3vj1CF6z/A==
X-Google-Smtp-Source: ABdhPJz+kEke6dlOHEDrD8eDVwsMil2jdFSu8qRnpU4nlE1pv9/RepGSKH9WcVMCuvSmtzk77+JCfw==
X-Received: by 2002:a05:6638:ec5:: with SMTP id q5mr18815399jas.13.1600191066394;
        Tue, 15 Sep 2020 10:31:06 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s1sm3334523iln.22.2020.09.15.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:31:03 -0700 (PDT)
Received: (nullmailer pid 2172175 invoked by uid 1000);
        Tue, 15 Sep 2020 17:31:01 -0000
Date:   Tue, 15 Sep 2020 11:31:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hongtao Wu <wuht06@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: Re: [PATCH v3 2/2] PCI: sprd: Add support for Unisoc SoCs' PCIe
 controller
Message-ID: <20200915173101.GB2146778@bogus>
References: <1599644912-29245-1-git-send-email-wuht06@gmail.com>
 <1599644912-29245-3-git-send-email-wuht06@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599644912-29245-3-git-send-email-wuht06@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 09, 2020 at 05:48:32PM +0800, Hongtao Wu wrote:
> From: Hongtao Wu <billows.wu@unisoc.com>
> 
> This series adds PCIe controller driver for Unisoc SoCs.
> This controller is based on DesignWare PCIe IP.
> 
> Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> ---
>  drivers/pci/controller/dwc/Kconfig     |  13 ++
>  drivers/pci/controller/dwc/Makefile    |   1 +
>  drivers/pci/controller/dwc/pcie-sprd.c | 231 +++++++++++++++++++++++++++++++++
>  3 files changed, 245 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 044a376..0553010 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -311,4 +311,17 @@ config PCIE_AL
>  	  required only for DT-based platforms. ACPI platforms with the
>  	  Annapurna Labs PCIe controller don't need to enable this.
> 
> +
> +config PCIE_SPRD
> +	tristate "Unisoc PCIe controller - Host Mode"
> +	depends on ARCH_SPRD || COMPILE_TEST
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	help
> +	  Unisoc PCIe controller uses the DesignWare core. It can be configured
> +	  as an Endpoint (EP) or a Root complex (RC). In order to enable host
> +	  mode (the controller works as RC), PCIE_SPRD must be selected.
> +	  Say Y or M here if you want to PCIe RC controller support on Unisoc
> +	  SoCs.
> +
>  endmenu
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index a751553..eb546e9 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_PCI_MESON) += pci-meson.o
>  obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
> +obj-$(CONFIG_PCIE_SPRD) += pcie-sprd.o
> 
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-sprd.c b/drivers/pci/controller/dwc/pcie-sprd.c
> new file mode 100644
> index 0000000..cec4f34
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-sprd.c
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Unisoc SoCs
> + *
> + * Copyright (C) 2020 Unisoc, Inc.
> + *
> + * Author: Hongtao Wu <Billows.Wu@unisoc.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#include "pcie-designware.h"
> +
> +#define NUM_OF_ARGS 5
> +
> +struct sprd_pcie {
> +	struct dw_pcie pci;
> +};
> +
> +static int sprd_pcie_syscon_setting(struct platform_device *pdev, char *env)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	int i, count, err;
> +	u32 type, delay, reg, mask, val, tmp_val;
> +	struct of_phandle_args out_args;
> +	struct regmap *iomap;
> +	struct device *dev = &pdev->dev;
> +
> +	if (!of_find_property(np, env, NULL)) {
> +		dev_info(dev, "There isn't property %s in dts\n", env);
> +		return 0;
> +	}
> +
> +	count = of_property_count_elems_of_size(np, env,
> +					(NUM_OF_ARGS + 1) * sizeof(u32));
> +	dev_info(dev, "Property (%s) reg count is %d :\n", env, count);
> +
> +	for (i = 0; i < count; i++) {
> +		err = of_parse_phandle_with_fixed_args(np, env, NUM_OF_ARGS,
> +						       i, &out_args);
> +		if (err < 0)
> +			return err;
> +
> +		type = out_args.args[0];
> +		delay = out_args.args[1];
> +		reg = out_args.args[2];
> +		mask = out_args.args[3];
> +		val = out_args.args[4];
> +
> +		iomap = syscon_node_to_regmap(out_args.np);
> +
> +		switch (type) {
> +		case 0:
> +			regmap_update_bits(iomap, reg, mask, val);
> +			break;
> +
> +		case 1:
> +			regmap_read(iomap, reg, &tmp_val);
> +			tmp_val &= (~mask);
> +			tmp_val |= (val & mask);
> +			regmap_write(iomap, reg, tmp_val);
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (delay)
> +			usleep_range(delay, delay + 10);
> +
> +		regmap_read(iomap, reg, &tmp_val);
> +		dev_dbg(dev,
> +			"%2d:reg[0x%8x] mask[0x%8x] val[0x%8x] result[0x%8x]\n",
> +			i, reg, mask, val, tmp_val);
> +	}
> +
> +	return i;
> +}
> +
> +static int sprd_pcie_perst_assert(struct platform_device *pdev)
> +{
> +	return sprd_pcie_syscon_setting(pdev, "sprd,pcie-perst-assert");

Not documented. This should probably use the reset binding.

> +}
> +
> +static int sprd_pcie_perst_deassert(struct platform_device *pdev)
> +{
> +	return sprd_pcie_syscon_setting(pdev, "sprd,pcie-perst-deassert");
> +}
> +
> +static int sprd_pcie_power_on(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device *dev = &pdev->dev;
> +
> +	ret = sprd_pcie_syscon_setting(pdev, "sprd,pcie-poweron-syscons");
> +	if (ret < 0)
> +		dev_err(dev,
> +			"failed to set pcie poweroff syscons, return %d\n",
> +			ret);
> +
> +	sprd_pcie_perst_deassert(pdev);
> +
> +	return ret;
> +}
> +
> +static int sprd_pcie_power_off(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device *dev = &pdev->dev;
> +
> +	sprd_pcie_perst_assert(pdev);
> +
> +	ret = sprd_pcie_syscon_setting(pdev, "sprd,pcie-poweroff-syscons");
> +	if (ret < 0)
> +		dev_err(dev,
> +			"failed to set pcie poweroff syscons, return %d\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +static int sprd_pcie_host_init(struct pcie_port *pp)
> +{
> +	int ret;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	dw_pcie_setup_rc(pp);
> +	dw_pcie_msi_init(pp);
> +
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret)
> +		dev_err(pci->dev, "pcie ep may has not been powered on yet\n");
> +
> +	return ret;
> +}
> +
> +static const struct dw_pcie_host_ops sprd_pcie_host_ops = {
> +	.host_init = sprd_pcie_host_init,
> +};
> +
> +static int sprd_add_pcie_port(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sprd_pcie *ctrl = platform_get_drvdata(pdev);
> +	struct dw_pcie *pci = &ctrl->pci;
> +	struct pcie_port *pp = &pci->pp;
> +
> +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> +	if (IS_ERR(pci->dbi_base)) {
> +		dev_err(dev, "failed to get rc dbi base\n");
> +		return PTR_ERR(pci->dbi_base);
> +	}
> +
> +	pp->ops = &sprd_pcie_host_ops;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {

I don't think this check is needed. The DW core won't setup the MSI if 
not enabled, so doesn't matter if msi_irq is initialized.

> +		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> +		if (pp->msi_irq < 0) {
> +			dev_err(dev, "failed to get msi, return %d\n",
> +				pp->msi_irq);

No need to print an error, the core does this.

> +			return pp->msi_irq;
> +		}
> +	}
> +
> +	return dw_pcie_host_init(pp);
> +}
> +
> +static int sprd_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sprd_pcie *ctrl;
> +	struct dw_pcie *pci;
> +	int ret;
> +
> +	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	pci = &ctrl->pci;
> +	pci->dev = dev;
> +
> +	platform_set_drvdata(pdev, ctrl);
> +
> +	ret = sprd_pcie_power_on(pdev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get pcie poweron syscons, return %d\n",
> +			ret);
> +		goto err_power_off;
> +	}
> +
> +	ret = sprd_add_pcie_port(pdev);
> +	if (ret) {
> +		dev_warn(dev, "failed to initialize RC controller\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +
> +err_power_off:
> +	sprd_pcie_power_off(pdev);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id sprd_pcie_of_match[] = {
> +	{
> +		.compatible = "sprd,pcie-rc",
> +	},
> +	{},
> +};
> +
> +static struct platform_driver sprd_pcie_driver = {
> +	.probe = sprd_pcie_probe,

You need a .remove hook.

> +	.driver = {
> +		.name = "sprd-pcie",
> +		.of_match_table = sprd_pcie_of_match,
> +	},
> +};
> +
> +module_platform_driver(sprd_pcie_driver);
> +
> +MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
> 
