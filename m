Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7B75072C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 13:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjGLLxF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjGLLwz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 07:52:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7ED2109;
        Wed, 12 Jul 2023 04:51:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fba74870abso10419251e87.0;
        Wed, 12 Jul 2023 04:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689162607; x=1691754607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLApzjkIllbQ31GLl4rJiuymb9kgLKtq1XrXsg3KCr0=;
        b=Yg7i61f+75xEkAs0ixkVDKZ+Tqop6czxchT6nhCZYd2Q1bl4lEBlDqQ0PwVe1l0wBQ
         /plmtJjr6QZJuAYE4KQDYMbgdp7hCSVS6BRTQx+7MV6KNQCzmWmchVXunBkouEbD1wK6
         53ywAlsLQbk26nLDxhkaRJcCW8A4JM+bvTLG0VTJ3LB37Ya+kQ61Tll4lvV+EcyeLhMb
         FecYSgc/uGy6iDFrFR8G3hkRALU0XIxq9d3vcSG36TrcZseW4pPFxsyVuXEBkWpN9N9c
         cqBidkC5KusXKYU8uCJgR4JJY3/sV7//aVUu3wo20iiUHGtAX90wri5YywAzrMhmgtcV
         aaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162607; x=1691754607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLApzjkIllbQ31GLl4rJiuymb9kgLKtq1XrXsg3KCr0=;
        b=YfStHoEyXLFft/2Q8OAI7nE9oZ9LLczKWqqJDA2vEUhu4PiojAYAUg/vF5rkDC6j1K
         RK8HLx8mVaNcyXrA1eAjBj0fdrhfQa30B6U3zmG2Opr6THEErrwvTXJ7wYm0UtO4x3Mf
         NJ9cKoLig6cNWJlioyAVh/hmYNXMR61O4Gcqu2hN28GtuUrMk6GRDYkPtb4l2v/qOZ34
         D7mzXkXmEUVyBYzElgL8i9cfoXP4JtIoI+5VWAIpXzh0MB4mZn6cGi0ss/7JtUS9+B60
         is+ZwOzjE8YO1k8PSgNLIk/z0rGz3mooJe42nwDk78fmP410D+7rK7oHnQSFY68zrWX+
         lNXA==
X-Gm-Message-State: ABy/qLbOQ7SN96ikEFtRlORUV8VhWs2sn27PY3y/HjdhFIL8a0s1JWDX
        Bll/2ZEiC9V6MgzBfbDSjBo=
X-Google-Smtp-Source: APBJJlFyCMNFwlER1YtIh9E/JkHbJJUmwZ8sSxLnExSIOlob3bEzuEQ3oaM9frG5G+Z2st5MpEKk4A==
X-Received: by 2002:a05:6512:4013:b0:4fb:9497:b2a5 with SMTP id br19-20020a056512401300b004fb9497b2a5mr19636727lfb.21.1689162606833;
        Wed, 12 Jul 2023 04:50:06 -0700 (PDT)
Received: from mobilestation ([85.249.22.88])
        by smtp.gmail.com with ESMTPSA id h3-20020ac25d63000000b004fba4e27abesm674940lft.241.2023.07.12.04.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:50:06 -0700 (PDT)
Date:   Wed, 12 Jul 2023 14:50:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v17 18/20] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe
 Endpoint support
Message-ID: <yzcrldzywq42am2f6wswgnospmp4bxe4uui7jsrr53ivtfj6ac@epajljzbduxl>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-19-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705114206.3585188-19-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 08:42:04PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> Synopsys DesignWare PCIe.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   2 +
>  .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 191 ++++++++++++++++++
>  3 files changed, 202 insertions(+)
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
> index 000000000000..1de33a9529bd
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> @@ -0,0 +1,191 @@
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

I don't see you disabling the clocks. It should be done in a
respective antagonistic method (like ep_deinit()?).
* The same concerns the Rcar Gen4 RP driver submitted in the previous
* patch.

> +	if (ret) {
> +		dev_err(dw->dev, "Failed to enable ref clocks\n");
> +		return;
> +	}
> +

> +	rcar_gen4_pcie_basic_init(rcar);

Please, see my note sent to the previous patch regarding having
rcar_gen4_pcie_basic_deinit().

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
> +	rcar = rcar_gen4_pcie_devm_alloc(dev);
> +	if (!rcar)
> +		return -ENOMEM;
> +
> +	err = rcar_gen4_pcie_get_resources(rcar, pdev);
> +	if (err < 0) {
> +		dev_err(dev, "Failed to request resource: %d\n", err);
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, rcar);
> +
> +	err = rcar_gen4_pcie_prepare(rcar);
> +	if (err < 0)
> +		return err;
> +
> +	err = rcar_gen4_add_pcie_ep(rcar, pdev);
> +	if (err < 0)
> +		goto err_add;
> +
> +	return 0;
> +
> +err_add:
> +	rcar_gen4_pcie_unprepare(rcar);
> +
> +	return err;
> +}
> +

> +static int rcar_gen4_pcie_ep_remove(struct platform_device *pdev)
> +{
> +	struct rcar_gen4_pcie *rcar = platform_get_drvdata(pdev);
> +
> +	rcar_gen4_remove_pcie_ep(rcar);
> +	rcar_gen4_pcie_unprepare(rcar);
> +
> +	return 0;
> +}

Please convert this function to returning void and assign to the
platform_driver.remove_new pointer instead.

> +
> +static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> +	{ .compatible = "renesas,rcar-gen4-pcie-ep", },
> +	{},
> +};
> +
> +static struct platform_driver rcar_gen4_pcie_ep_driver = {
> +	.driver = {
> +		.name = "pcie-rcar-gen4-ep",
> +		.of_match_table = rcar_gen4_pcie_of_match,
> +	},
> +	.probe = rcar_gen4_pcie_ep_probe,

> +	.remove = rcar_gen4_pcie_ep_remove,

ditto

-Serge(y)

> +};
> +module_platform_driver(rcar_gen4_pcie_ep_driver);
> +
> +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe endpoint controller driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
