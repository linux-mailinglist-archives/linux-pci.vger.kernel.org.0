Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCFC76A66E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 03:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjHABgQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 21:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjHABgO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 21:36:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70B91738;
        Mon, 31 Jul 2023 18:36:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe10f0f4d1so8486686e87.0;
        Mon, 31 Jul 2023 18:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690853770; x=1691458570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=llmH+aVWOVi/3u3BpCgsSvSi5nuRvXtw1L1XqsLeHq4=;
        b=JdF6RLsKcI9VLdr/XK7P6cfTWuYyr6lFdIrgu1AYefMjoSeQTp7Mv00h/GdXSVwAoe
         e/s6hAiiQ3xG4C/eMDZ8bnfIXTBp+VCeoy4fve9zh8wS4WueBvPhwNaCU1XyxhVIHhj2
         pvlNb+434oxtllIz/nf83GPYsJ3FOU7DO1eNX27ofleNEpcD4kjcgXwy7c4Dns159G9t
         w8WijXWjXkop8zTujWw9FeynYFB6ZMngkL/MoQvLFZi0iU24Kq9S1WoN1lN7h4Geb5ng
         iK7iKCWH76XL+/oRHyKbc+wHF3K8/Pq35c3o4qIzO5DW2alSRNRLUPeKkw94+Rwf2Dbr
         J9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690853770; x=1691458570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llmH+aVWOVi/3u3BpCgsSvSi5nuRvXtw1L1XqsLeHq4=;
        b=boy4gqLWq9F1xrsNhJqnAnW+YULQRdKsPixXxQCSpJy4u9tQSV73tHjsLOkItq3x8V
         YtYVGzbSCQNv3TslYc71tdqTmcY3I0x4E4LH5aZbwAvOlnkGkXP82zhDjePloTe7+ndv
         n5GAwahyUirCpaCtSThlbGu7EAM1WcTk2F3mtcXL1McBnFSZcSgZ3pmNaug+pXczpvo8
         1jSIzkwOUoY3jWwo7wAEicAZl72YlQsvcVCMYh/++yp5FGb+KQ9D1keFtoGhEbQuJrPM
         P8J/Uasbecu2RHOZ+Ba5ulnoLDHlrIrdwuva5ymo5H8IVgcWyHmGh0EVB1sFiHM9Mqm/
         /icw==
X-Gm-Message-State: ABy/qLbvuIvUPKT412tELEC4m8l5FHb9tW/QMKJ1v+3CDsyAmRiqZiA9
        hpzPDfxCF0nkxX56MqI7Otc=
X-Google-Smtp-Source: APBJJlFXZB5eoNRRt6CALgCKc4PvrucJlmz9OBggM3UuRjNmlsyoxd1PE1N4oOD7i/BGq45igB1X5g==
X-Received: by 2002:a19:434e:0:b0:4fe:1f27:8856 with SMTP id m14-20020a19434e000000b004fe1f278856mr921004lfj.7.1690853770330;
        Mon, 31 Jul 2023 18:36:10 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id s17-20020ac25fb1000000b004fdb85646f1sm2318833lfe.201.2023.07.31.18.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 18:36:09 -0700 (PDT)
Date:   Tue, 1 Aug 2023 04:36:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 18/20] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe
 Endpoint support
Message-ID: <3gwpjq4dhensrxjhb2cfd6q7c6tcaayfokn3bebnauryzgayhz@ogkp3cf255o4>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-19-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721074452.65545-19-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 04:44:50PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> Synopsys DesignWare PCIe.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   2 +
>  .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 189 ++++++++++++++++++
>  3 files changed, 200 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 64d4d37bc891..4d877cd18374 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -424,4 +424,13 @@ config PCIE_RCAR_GEN4
>  	  Say Y here if you want PCIe host controller support on R-Car Gen4 SoCs.
>  	  This uses the DesignWare core.
>  
> +config PCIE_RCAR_GEN4_EP
> +	tristate "Renesas R-Car Gen4 PCIe Endpoint controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	help
> +	  Say Y here if you want PCIe endpoint controller support on R-Car Gen4
> +	  SoCs. This uses the DesignWare core.
> +
>  endmenu
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 486cf706b53d..0fb0bde26ac4 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -28,6 +28,8 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>  pcie-rcar-gen4-host-drv-objs := pcie-rcar-gen4.o pcie-rcar-gen4-host.o
>  obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4-host-drv.o
> +pcie-rcar-gen4-ep-drv-objs := pcie-rcar-gen4.o pcie-rcar-gen4-ep.o
> +obj-$(CONFIG_PCIE_RCAR_GEN4_EP) += pcie-rcar-gen4-ep-drv.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> new file mode 100644
> index 000000000000..3970a920f3fe
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe Endpoint driver for Renesas R-Car Gen4 Series SoCs
> + * Copyright (C) 2022-2023 Renesas Electronics Corporation
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
> +#define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
> +#define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
> +
> +static void rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
> +	if (ret) {
> +		dev_err(dw->dev, "Failed to enable ref clocks\n");
> +		return;
> +	}
> +
> +	rcar_gen4_pcie_basic_init(rcar);
> +
> +	writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);
> +}
> +
> +static void rcar_gen4_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar;
> +
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +}
> +
> +static void rcar_gen4_pcie_ep_deinit(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +
> +	writel(0, rcar->base + PCIEDMAINTSTSEN);
> +	rcar_gen4_pcie_basic_deinit(rcar);
> +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
> +}
> +
> +static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				       enum pci_epc_irq_type type,
> +				       u16 interrupt_num)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_INTX:
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
> +	case PCI_EPC_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(dw->dev, "Unknown IRQ type\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = false,
> +	.reserved_bar = 1 << BAR_1 | 1 << BAR_3 | 1 << BAR_5,
> +	.align = SZ_1M,
> +};
> +
> +static const struct pci_epc_features*
> +rcar_gen4_pcie_ep_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &rcar_gen4_pcie_epc_features;
> +}
> +
> +static unsigned int rcar_gen4_pcie_ep_func_conf_select(struct dw_pcie_ep *ep,
> +						       u8 func_no)
> +{
> +	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET;
> +}
> +
> +static unsigned int rcar_gen4_pcie_ep_func_conf_select2(struct dw_pcie_ep *ep,
> +							u8 func_no)
> +{
> +	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET;
> +}
> +
> +static const struct dw_pcie_ep_ops pcie_ep_ops = {
> +	.ep_pre_init = rcar_gen4_pcie_ep_pre_init,
> +	.ep_init = rcar_gen4_pcie_ep_init,
> +	.ep_deinit = rcar_gen4_pcie_ep_deinit,
> +	.raise_irq = rcar_gen4_pcie_ep_raise_irq,
> +	.get_features = rcar_gen4_pcie_ep_get_features,
> +	.func_conf_select = rcar_gen4_pcie_ep_func_conf_select,
> +	.func_conf_select2 = rcar_gen4_pcie_ep_func_conf_select2,
> +};
> +
> +static int rcar_gen4_add_pcie_ep(struct rcar_gen4_pcie *rcar,

> +				 struct platform_device *pdev)

Drop this argument. rcar already has the pdev pointer.

> +{
> +	struct dw_pcie_ep *ep = &rcar->dw.ep;
> +	int ret;
> +
> +	rcar->mode = DW_PCIE_EP_TYPE;
> +	ep->ops = &pcie_ep_ops;
> +
> +	ret = dw_pcie_ep_init(ep);
> +	if (ret) {

> +		dev_err(&pdev->dev, "Failed to initialize endpoint\n");

Even though half the DW PCIe EP LLDDs are doing the same I would have
either dropped the error printed here or converted it to
dev_err_probe(). First option is more preferable because thus your RP
and EP adding methods will turn to look similar.

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void rcar_gen4_remove_pcie_ep(struct rcar_gen4_pcie *rcar)
> +{
> +	dw_pcie_ep_exit(&rcar->dw.ep);
> +}
> +
> +static int rcar_gen4_pcie_ep_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rcar_gen4_pcie *rcar;
> +	int err;
> +
> +	rcar = rcar_gen4_pcie_devm_alloc(pdev);
> +	if (!rcar)
> +		return -ENOMEM;
> +
> +	err = rcar_gen4_pcie_get_resources(rcar);

> +	if (err < 0) {

As Mani correctly noticed the checks should be converted to "if (err)...".

> +		dev_err(dev, "Failed to request resource: %d\n", err);

I would have moved this error printed to the
rcar_gen4_pcie_get_resources() method (similar fix should be in the
Root Port patch too). Thus the probe method will turn to look neat and
you'll be able to drop the dev pointer from here.

> +		return err;
> +	}
> +
> +	err = rcar_gen4_pcie_prepare(rcar);

> +	if (err < 0)

if (err) ?

> +		return err;
> +
> +	err = rcar_gen4_add_pcie_ep(rcar, pdev);

> +	if (err < 0)

ditto

> +		goto err_add;
> +
> +	return 0;
> +

> +err_add:

See the comments in the patch 17/20 regarding the label name.

> +	rcar_gen4_pcie_unprepare(rcar);
> +
> +	return err;
> +}
> +
> +static void rcar_gen4_pcie_ep_remove(struct platform_device *pdev)
> +{
> +	struct rcar_gen4_pcie *rcar = platform_get_drvdata(pdev);
> +
> +	rcar_gen4_remove_pcie_ep(rcar);
> +	rcar_gen4_pcie_unprepare(rcar);
> +}
> +
> +static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> +	{ .compatible = "renesas,rcar-gen4-pcie-ep", },
> +	{},
> +};

As Mani noted: missing MODULE_DEVICE_TABLE().

-Serge(y)

> +
> +static struct platform_driver rcar_gen4_pcie_ep_driver = {
> +	.driver = {
> +		.name = "pcie-rcar-gen4-ep",
> +		.of_match_table = rcar_gen4_pcie_of_match,
> +	},
> +	.probe = rcar_gen4_pcie_ep_probe,
> +	.remove_new = rcar_gen4_pcie_ep_remove,
> +};
> +module_platform_driver(rcar_gen4_pcie_ep_driver);
> +
> +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe endpoint controller driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
