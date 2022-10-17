Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8C7601578
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 19:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJQRel (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiJQRei (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 13:34:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEBD6575;
        Mon, 17 Oct 2022 10:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9F6EB81331;
        Mon, 17 Oct 2022 17:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515B9C433D6;
        Mon, 17 Oct 2022 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666028064;
        bh=FDw24rOSiOpR/AA8bVEZXihOsH9mEP441rpoEYpcJFQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AslKcmmirEJ+FkEFGQta8P959CSzZlZ4kKPpTVCQw28Tm0uIXNNixmfWnvg43/C++
         NHbUWzMbMXj8Lb58Z+IDCEGTSnc5rcvFLUyBkwQmRTKKdloimm2uce2WGUBpu8vMUr
         RhGDg5namuKA9EOnzkuS8MIgDMZS2f2/AR08+YVD2g8iDwg927T/1dseMdJfhRt1V+
         XI/ILMYbfsdX/vW+nW/tP3xs7gMkBGFLuFMGfpukfrWUsv5I95eZRWUyAcwk/5ElCz
         s37+CkVU0DHwsQkMq6xmxgGq8qRsz80Ecd0l9g2NhnQOQ+EbStiNDpjAPoPydknKwy
         QwULAXUT8jgGw==
Date:   Mon, 17 Oct 2022 12:34:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 2/2] PCI: qcom: Add support for modular builds
Message-ID: <20221017173422.GA3715509@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017114705.8277-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 17, 2022 at 01:47:05PM +0200, Johan Hovold wrote:
> Allow the Qualcomm PCIe controller driver to be built as a module, which
> is useful for multi-platform kernels as well as during development.

There are two different goals here, and there's no real reason to
bundle them together:

  1) Make qcom a loadable module.  This is a hard requirement so
     multi-platform kernels don't need to build in all drivers
     statically.

  2) Make qcom unloadable.  This is a high want, possibly even a
     requirement for developers, but is not really a big issue for
     users.

There are different changes required: 1) requires the Kconfig change;
2) requires .remove() to be implemented.  Since there's no requirement
that these be done together, let's split them into separate patches.

Then we can make sure that at least 1) gets done, and if for any
reason 2) isn't safe or breaks something, we can at least bisect and
if necessary revert it without losing 1).

> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/controller/dwc/Kconfig     |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c | 26 +++++++++++++++++++++++---
>  2 files changed, 24 insertions(+), 4 deletions(-)
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
> index 417be4d225ed..699172c22ed4 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -17,7 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> -#include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
> @@ -1820,6 +1820,21 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int qcom_pcie_remove(struct platform_device *pdev)
> +{
> +	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +
> +	dw_pcie_host_deinit(&pcie->pci->pp);
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
>  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> @@ -1841,6 +1856,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, qcom_pcie_match);
>  
>  static void qcom_fixup_class(struct pci_dev *dev)
>  {
> @@ -1856,10 +1872,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
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
> 2.37.3
> 
