Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94D6C531B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 18:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCVR5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 13:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCVR5S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 13:57:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D2461520;
        Wed, 22 Mar 2023 10:57:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h25so12813819lfv.6;
        Wed, 22 Mar 2023 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679507835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOCeteZ2FmsPkbz+Rs7eQAr8E7kEN6rzGpQ6WztVG7M=;
        b=oNZniqmXHWgLTMcmZbz5puUKOENVw0dY34xIgFCVgvlheswji2s5QF2exmwAtHwTtP
         8rv/6Eo4rzGg5vZkI2erDzMgJP+soST8nl5Fs6U2bARdBrHeujlCfO3+h4TTm1Ija8as
         wKCpdDx+X3hfpbRNZHQgoQ4c93nsh3oPnTGGU0A7mcSerJi+WQ7jnS2GBkwRMiDt/Awp
         ocmM97wJnb5WUStknLXhCJSHbuUJ/m1X9If9/FSvY4wMFtPQZxdZpkEAAw5t1TpYMsDW
         7OWSXyzDvitlTs7WkGJ/QaEB+3cpU4pScGsR35jqQVxSYavjTKehb+gdwVWSS0Ojmpb7
         TXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679507835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOCeteZ2FmsPkbz+Rs7eQAr8E7kEN6rzGpQ6WztVG7M=;
        b=Rvu2I4YYrueCLOxd9JTIid83OCYnVjei6+NUl+Rsvh6HFCE9MEAG4lUPDcFsPdX8Dj
         ilhYaglRBEjC4vFOVz7OOd8h0v+DZhOG1zqg/SFh1RTgIWK5rP+gK5iWmEKu+XS99I9U
         4YX/M1vGt3HEf5wKF0Xo/3ypZtlNIZQ8oTj60SSDV+xCM0sqCYXIwsnwGANW8Wtqu1+n
         0SUv9KBTYlF5Askwpnq8Jk6ZZaqM8s03+9XEQxzmhCRdFoHaAMFZTcbRvJRHZuYmzac7
         /HF+NWX4s8qEy8wZRE9Expo5uyF7sJBR2DTduBHqkMzPYftbXvw7/rgIFkzyLRzxNfyw
         spxg==
X-Gm-Message-State: AO0yUKVxWkRLe5Ae4SZxnVrzTJLe98xTciPyXcxVvsd7Bk8HkYehk9w5
        m+OMKofTCnhggtOwHBoQUZs=
X-Google-Smtp-Source: AK7set+IoTZJZGrQ96VW/Hd3XsgGcHrivjFBF9aZ77Ov+Q3y291PrNLXTq93X+BM0Ys9yyrwgrY7Vw==
X-Received: by 2002:ac2:5de1:0:b0:4e9:ad85:aa09 with SMTP id z1-20020ac25de1000000b004e9ad85aa09mr2287483lfq.68.1679507835101;
        Wed, 22 Mar 2023 10:57:15 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id e4-20020ac25464000000b004d58e782886sm2622991lfn.303.2023.03.22.10.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:57:14 -0700 (PDT)
Date:   Wed, 22 Mar 2023 20:57:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, Sergey.Semin@baikalelectronics.ru,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v11 11/13] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe
 Endpoint support
Message-ID: <20230322175712.prq532cic2z3dhja@mobilestation>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-12-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310123510.675685-12-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 09:35:08PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> Synopsys DesignWare PCIe.
> 
> This controller requires vender-specific initialization before
> .ep_init(). To use dw->dbi and dw->num-lanes in the initialization
> code, introduce .ep_pre_init() into struct dw_pcie_ep_ops.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   2 +
>  .../pci/controller/dwc/pcie-designware-ep.c   |   3 +
>  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
>  .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 170 ++++++++++++++++++
>  5 files changed, 185 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 94805ec31a8f..f33e403c7b61 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -423,4 +423,13 @@ config PCIE_RCAR_GEN4
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
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 73b3844e8a09..8302053fa2da 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -763,6 +763,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->phys_base = res->start;
>  	ep->addr_size = resource_size(res);
>  
> +	if (ep->ops->ep_pre_init)
> +		ep->ops->ep_pre_init(ep);
> +
>  	dw_pcie_version_detect(pci);
>  
>  	dw_pcie_iatu_detect(pci);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 1be74d2c3729..f2026ac8b02f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -325,6 +325,7 @@ struct dw_pcie_rp {
>  };
>  
>  struct dw_pcie_ep_ops {
> +	void	(*ep_pre_init)(struct dw_pcie_ep *ep);
>  	void	(*ep_init)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>  			     enum pci_epc_irq_type type, u16 interrupt_num);
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> new file mode 100644
> index 000000000000..4c763e5a6793
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> @@ -0,0 +1,170 @@
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
> +/* Configuration */
> +#define PCICONF3		0x000c
> +#define  MULTI_FUNC		BIT(23)
> +
> +static void rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	int val;
> +
> +	rcar_gen4_pcie_set_device_type(rcar, false, dw->num_lanes);
> +
> +	dw_pcie_dbi_ro_wr_en(dw);
> +
> +	/* Single function */

> +	val = dw_pcie_readl_dbi(dw, PCICONF3);

There is a special macro PCI_HEADER_TYPE for the respective 8bit
field. You can use it together with the dw_pcie_readb_dbi() method.

> +	val &= ~MULTI_FUNC;

MULTI_FUNC is defined in the PCIe specification. What about updating
the include/uapi/linux/pci_regs.h file instead of defining a local
macro?

> +	dw_pcie_writel_dbi(dw, PCICONF3, val);
> +

> +	rcar_gen4_pcie_disable_bar(dw, BAR5MASKF);

Generically this can be done by calling dw_pcie_ep_reset_bar(). It also
writes zero to the shadow BARx CSRs. Otherwise please explain what is
mapped at the 0x2000 offset with respect to the DBI base address.

> +
> +	dw_pcie_num_lanes_setup(dw, dw->num_lanes);

* Please see my note to the respective patch.

> +
> +	dw_pcie_dbi_ro_wr_dis(dw);
> +}
> +
> +static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				       enum pci_epc_irq_type type,
> +				       u16 interrupt_num)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_LEGACY:
> +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +	case PCI_EPC_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(dw->dev, "UNKNOWN IRQ type\n");
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
> +	.reserved_bar = 1 << BAR_5,
> +	.align = SZ_1M,
> +};
> +
> +static const struct pci_epc_features*
> +rcar_gen4_pcie_ep_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &rcar_gen4_pcie_epc_features;
> +}
> +
> +static const struct dw_pcie_ep_ops pcie_ep_ops = {
> +	.ep_pre_init = rcar_gen4_pcie_ep_pre_init,
> +	.raise_irq = rcar_gen4_pcie_ep_raise_irq,
> +	.get_features = rcar_gen4_pcie_ep_get_features,
> +};
> +
> +static int rcar_gen4_add_pcie_ep(struct rcar_gen4_pcie *rcar,
> +				 struct platform_device *pdev)
> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +	struct dw_pcie_ep *ep;
> +	int ret;
> +
> +	ep = &dw->ep;
> +	ep->ops = &pcie_ep_ops;
> +
> +	ret = dw_pcie_ep_init(ep);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize endpoint\n");
> +		return ret;
> +	}
> +

> +	writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);

Most likely this needs to be done either in ep_pre_init or in the
ep_init callback.

> +
> +	dw->ops->start_link(dw);

Why do you need to start the link right away thus interfering with the
PCI EP subsystem? It is supposed to be done by the PCIe EP core on
demand from the user-space (see pci_epc_start() usage).

> +
> +	return 0;
> +}
> +
> +static void rcar_gen4_remove_pcie_ep(struct rcar_gen4_pcie *rcar)
> +{

> +	writel(0, rcar->base + PCIEDMAINTSTSEN);

If we had dw_pcie_ep_ops.ep_deinit() this should have been done
there...

-Serge(y)

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
> +};
> +module_platform_driver(rcar_gen4_pcie_ep_driver);
> +
> +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe endpoint controller driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
> 
