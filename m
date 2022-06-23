Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08E5557EF5
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 17:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiFWPwW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 11:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiFWPwS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 11:52:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB5A43EEE;
        Thu, 23 Jun 2022 08:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E188B8246B;
        Thu, 23 Jun 2022 15:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B520C3411B;
        Thu, 23 Jun 2022 15:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655999534;
        bh=f1yUMkNQijNCMovgwuypQ/49a7NNjLshwaNNnee92ic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cZA4xdw8NI4eRz/aTRQgagViZw4M68kmeCM2dI0bWgt3PB4+7+eM+Q+PLkU3rq8iu
         B2x5yvp/8+6A8KjY2mtsK9GJ1cV1YXGoR0Yk2pyLRAZGnaXzXaoKBAgpD5hZ1WL20e
         P88/o6ghFWcD23j4nUi1fg2Jf3WiSRofqFq2TazctaRyLHSz4/Dja1v6WBPlVTH9X7
         mvYWPxcOWGiWfAD5QSLTfiIGC1TjlmJdmU4tNY/6xlgkE5DO8I3xwe8EhVsLTlvJ/9
         eENNgA1CSZ88oR0YBm/LbRtJiE8C6TBycpQlC9xpFpJTlbtGdpGdka9eLjYUqPPYzI
         D8ZKzxsjxoMtQ==
Date:   Thu, 23 Jun 2022 10:52:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for modular builds
Message-ID: <20220623155213.GA1450949@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519094646.23009-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 19, 2022 at 11:46:46AM +0200, Johan Hovold wrote:
> Allow the Qualcomm PCIe controller driver to be built as a module, which
> is useful for multi-platform kernels as well as during development.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/controller/dwc/Kconfig     |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 62ce3abf0f19..230f56d1a268 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -168,7 +168,7 @@ config PCI_HISI
>  	  Hip05 and Hip06 SoCs
>  
>  config PCIE_QCOM
> -	bool "Qualcomm PCIe controller"
> +	tristate "Qualcomm PCIe controller"
>  	depends on OF && (ARCH_QCOM || COMPILE_TEST)
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8523b5ef9d16..e25d5c09657c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -16,7 +16,7 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> -#include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
> @@ -1425,6 +1425,15 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	return ret;
>  }
>  
> +static void qcom_pcie_host_deinit(struct qcom_pcie *pcie)
> +{
> +	qcom_ep_reset_assert(pcie);
> +	if (pcie->cfg->ops->post_deinit)
> +		pcie->cfg->ops->post_deinit(pcie);
> +	phy_power_off(pcie->phy);
> +	pcie->cfg->ops->deinit(pcie);

These post_deinit/deinit names look backwards.  Why would we call a
"post_deinit()" method *before* the "deinit()" method?  It would make
sense if we called "pre_deinit()" followed by "deinit()".

>  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>  	.host_init = qcom_pcie_host_init,
>  };
> @@ -1651,6 +1660,22 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int qcom_pcie_remove(struct platform_device *pdev)
> +{
> +	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +
> +	dw_pcie_host_deinit(&pcie->pci->pp);
> +	qcom_pcie_host_deinit(pcie);
> +
> +	phy_exit(pcie->phy);
> +
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);

Why is this not more symmetric with qcom_pcie_probe()?  Maybe struct
dw_pcie_host_ops needs a new .host_deinit() pointer that would be
called from dw_pcie_host_deinit()?

In the probe path, we have this:

  qcom_pcie_probe
    pm_runtime_enable
    pm_runtime_get_sync
    phy_init(pcie->phy)
    dw_pcie_host_init
      pp->ops->host_init
        qcom_pcie_host_init             # .host_init()
          pcie->cfg->ops->init(pcie)
          phy_power_on(pcie->phy)
          pcie->cfg->ops->post_init(pcie)
          qcom_ep_reset_deassert(pcie)

The remove path does do things in the opposite order, which makes
sense, but the call to qcom_pcie_host_deinit() breaks the symmetry:

  qcom_pcie_remove
    dw_pcie_host_deinit
    qcom_pcie_host_deinit
      qcom_ep_reset_assert
      pcie->cfg->ops->post_deinit
      phy_power_off(pcie->phy)
      pcie->cfg->ops->deinit
    phy_exit(pcie->phy)
    pm_runtime_put_sync
    pm_runtime_disable

> +	return 0;
> +}
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> @@ -1669,6 +1694,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, qcom_pcie_match);
>  
>  static void qcom_fixup_class(struct pci_dev *dev)
>  {
> @@ -1684,10 +1710,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
>  
>  static struct platform_driver qcom_pcie_driver = {
>  	.probe = qcom_pcie_probe,
> +	.remove = qcom_pcie_remove,
>  	.driver = {
>  		.name = "qcom-pcie",
> -		.suppress_bind_attrs = true,
>  		.of_match_table = qcom_pcie_match,
>  	},
>  };
> -builtin_platform_driver(qcom_pcie_driver);
> +module_platform_driver(qcom_pcie_driver);
> +
> +MODULE_AUTHOR("Stanimir Varbanov <svarbanov@mm-sol.com>");
> +MODULE_DESCRIPTION("Qualcomm PCIe root complex driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.35.1
> 
