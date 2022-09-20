Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281D85BE0B3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiITIsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 04:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiITIr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 04:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CF22FFE3;
        Tue, 20 Sep 2022 01:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0793C621BB;
        Tue, 20 Sep 2022 08:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FEDC433C1;
        Tue, 20 Sep 2022 08:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663663674;
        bh=pR5dTdl8QcwJ+GvmFZiO2SLRRtJXz8jfmSxpS4Sg5j8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ba4XQtwGAf7J1/pirvwb2QTm7r6VcO9mCBVb/t5ItpDjSPWg1kVAmQvmhRnPlzdWK
         M0M2Xcr72MHjcaKko5h4qXsPF/nlNVJuBIgAzm0yiSHNosgCrZwZm0ktefYa29EH07
         hHdWJdIrz2nwGLVO3fc6DqYANxhX3SE66q3IHezXJkxWAwyxNDl7AFUEjF3wFhLr7H
         JSE4QL8uirmaVME32WbISL1dhvxr9gp+PwL2hPZxij96487EATFMADTr0vU8O4mXXe
         iAl0Wxq/2AX7yAowNJxEu2+thRIR3GhOM6H8VNB8wJ6nu81/71krUOyqR6wzhStEjr
         I0fHgeeWmEL5Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaYv6-0002Db-MC; Tue, 20 Sep 2022 10:47:56 +0200
Date:   Tue, 20 Sep 2022 10:47:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Add support for modular builds
Message-ID: <Yyl+PNcbtSwzlgvh@hovoldconsulting.com>
References: <20220721064720.10762-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721064720.10762-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Thu, Jul 21, 2022 at 08:47:20AM +0200, Johan Hovold wrote:
> Allow the Qualcomm PCIe controller driver to be built as a module, which
> is useful for multi-platform kernels as well as during development.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Changes in v2
>  - rebase on next-20220720 (adjust context)
>  - add Rob and Mani's reviewed-by tags

Have you had a change to look at this one since you got back from
vacation?

I believe this should be uncontroversial as we already have other
modular dwc drivers and there's no mapping of legacy INTx interrupts
involved.

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
> index 5ed164c2afa3..d176c635016b 100644
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
> @@ -1518,6 +1518,15 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
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
> +}
> +
>  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>  	.host_init = qcom_pcie_host_init,
>  };
> @@ -1752,6 +1761,22 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> @@ -1771,6 +1796,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq6018", .data = &ipq6018_cfg },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, qcom_pcie_match);
>  
>  static void qcom_fixup_class(struct pci_dev *dev)
>  {
> @@ -1786,10 +1812,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
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

Johan
