Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFE7785755
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 14:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjHWMCl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 08:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjHWMCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 08:02:40 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0567EE5E;
        Wed, 23 Aug 2023 05:02:36 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff933f9ca8so8517070e87.1;
        Wed, 23 Aug 2023 05:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692792154; x=1693396954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhGWljTEzgGCyqELL090UGU2KeZ59SWR+svG50HgKIc=;
        b=kl3OWjPTPh7fua5n7I12QAHx4oYlyTFqP/CxjKhcRaWb2fJTl6qZ8jjQQteHnHuUj5
         r/2WRMdlVfrhuF3oZSC7t/v/mrl3hss4lH5BtVAFwZBX3GsVrje16Nxq4nc7EZn7qM3T
         3ZhkpLhErWX7mt7oY7W7Dm1HC7Scfds2VziUEHlv7d44G6BLDkHYOCdUEx+/kg8sKKtT
         w6hShHZertGl/ISWLFwRgxjSZSefiXpd2pAoRxtinlM+SrJxrDcQy5JvLDj8kaOcyXvo
         4yWbicn9AmRQqzvORjH9AkAwPGFsJFjQu5YBGr0rh9+H62yhajBnzhexTOSuqEkEk7nW
         syog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692792154; x=1693396954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhGWljTEzgGCyqELL090UGU2KeZ59SWR+svG50HgKIc=;
        b=XOvzXCxHgDUvp7u6FxNF0bqG/W2KqhuTtqR+UbRnwUDBdxvfl8WLPT5LKzgxMcC4Z+
         Ll3fOiVJXdsVZxqmoXOEkeo0nyKbqIabtn5Fxk1B7j+FcfQNOlwM7EQC5dqlwR2ge0qK
         WrBZ8F5qtpxUqbB+3B/UlPagyinrOGePbiDCh27uQreSlVw1By4UR4v6yMddL5igWF2h
         OcxTa/+GntJcPJpSnYADvMSZdtU3n2qJUw25y+pqL74Nn1w3cbB+Y8lvnCnoM6L1TrmW
         UwGXeHx67S2VqR/MxAMhf5eoVEdGqYDv/2dD7A91NUNf3cuJ6f9Esa9Mub6e31YiJaI5
         u0Nw==
X-Gm-Message-State: AOJu0YyYlXXfynZK256RdxM3V+jkdIq2uqZOAgiFZCyFzqhCwFjK0qgz
        33apLWJ63UxjvBtQ5rJW9NY=
X-Google-Smtp-Source: AGHT+IG6CLb2nalmqLGp+x98l4w2xJYzuEuXsqzECvWicW+RR511OYZlcAd+mGAdBk4MKl4jOI0CnQ==
X-Received: by 2002:a19:9157:0:b0:500:7e64:cff1 with SMTP id y23-20020a199157000000b005007e64cff1mr5763373lfj.14.1692792153905;
        Wed, 23 Aug 2023 05:02:33 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q9-20020ac25a09000000b004fe64b0109asm939788lfn.176.2023.08.23.05.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 05:02:33 -0700 (PDT)
Date:   Wed, 23 Aug 2023 15:02:30 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v19 17/19] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe
 Endpoint support
Message-ID: <agtnd477is7pphizfdoyltbak5pdjpvcx34lwvtnch5zbi7rfd@75ndc53djrgv>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
 <20230823091153.2578417-18-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823091153.2578417-18-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 06:11:51PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> Synopsys DesignWare PCIe.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   2 +
>  .../controller/dwc/pcie-rcar-gen4-ep-drv.c    | 178 ++++++++++++++++++
>  3 files changed, 190 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 3884a67e4d56..65a7c56e64bd 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -425,4 +425,14 @@ config PCIE_RCAR_GEN4
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called pcie-rcar-gen4-host.ko. This uses the DesignWare core.
>  
> +config PCIE_RCAR_GEN4_EP
> +	tristate "Renesas R-Car Gen4 PCIe Endpoint controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	help
> +	  Say Y here if you want PCIe endpoint controller support on R-Car Gen4
> +	  SoCs. To compile this driver as a module, choose M here: the module
> +	  will be called pcie-rcar-gen4-ep.ko. This uses the DesignWare core.
> +
>  endmenu
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index ab2c6bc16216..4d53d660e4fe 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -28,6 +28,8 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>  pcie-rcar-gen4-host-objs := pcie-rcar-gen4.o pcie-rcar-gen4-host-drv.o
>  obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4-host.o
> +pcie-rcar-gen4-ep-objs := pcie-rcar-gen4.o pcie-rcar-gen4-ep-drv.o
> +obj-$(CONFIG_PCIE_RCAR_GEN4_EP) += pcie-rcar-gen4-ep.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c
> new file mode 100644
> index 000000000000..71f496ba0eeb
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c
> @@ -0,0 +1,178 @@
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
> +	rcar_gen4_pcie_common_init(rcar);

The same note as to the previous patch. The clk_bulk_prepare_enable()
method invocation can be moved to rcar_gen4_pcie_common_init().

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

> +	rcar_gen4_pcie_common_deinit(rcar);
> +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);

and clk_bulk_disable_unprepare() - to rcar_gen4_pcie_common_deinit().

With the above notes fixed feel free to add:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> +}
> +
> +static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				       unsigned int type, u16 interrupt_num)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_IRQ_LEGACY:
> +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +	case PCI_IRQ_MSI:
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
> +static unsigned int rcar_gen4_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep,
> +						      u8 func_no)
> +{
> +	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET;
> +}
> +
> +static const struct dw_pcie_ep_ops pcie_ep_ops = {
> +	.pre_init = rcar_gen4_pcie_ep_pre_init,
> +	.ep_init = rcar_gen4_pcie_ep_init,
> +	.deinit = rcar_gen4_pcie_ep_deinit,
> +	.raise_irq = rcar_gen4_pcie_ep_raise_irq,
> +	.get_features = rcar_gen4_pcie_ep_get_features,
> +	.func_conf_select = rcar_gen4_pcie_ep_func_conf_select,
> +	.get_dbi2_offset = rcar_gen4_pcie_ep_get_dbi2_offset,
> +};
> +
> +static int rcar_gen4_add_pcie_ep(struct rcar_gen4_pcie *rcar)
> +{
> +	struct dw_pcie_ep *ep = &rcar->dw.ep;
> +
> +	rcar->mode = DW_PCIE_EP_TYPE;
> +	ep->ops = &pcie_ep_ops;
> +
> +	return dw_pcie_ep_init(ep);
> +}
> +
> +static void rcar_gen4_remove_pcie_ep(struct rcar_gen4_pcie *rcar)
> +{
> +	dw_pcie_ep_exit(&rcar->dw.ep);
> +}
> +
> +static int rcar_gen4_pcie_ep_probe(struct platform_device *pdev)
> +{
> +	struct rcar_gen4_pcie *rcar;
> +	int err;
> +
> +	rcar = rcar_gen4_pcie_devm_alloc(pdev);
> +	if (IS_ERR(rcar))
> +		return PTR_ERR(rcar);
> +
> +	err = rcar_gen4_pcie_get_resources(rcar);
> +	if (err)
> +		return err;
> +
> +	err = rcar_gen4_pcie_prepare(rcar);
> +	if (err)
> +		return err;
> +
> +	err = rcar_gen4_add_pcie_ep(rcar);
> +	if (err)
> +		goto err_unprepare;
> +
> +	return 0;
> +
> +err_unprepare:
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
> +MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
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
