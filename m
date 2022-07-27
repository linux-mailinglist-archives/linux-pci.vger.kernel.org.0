Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467BD5833E6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 22:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiG0UDE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 16:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiG0UDD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 16:03:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7343A5A2FF;
        Wed, 27 Jul 2022 13:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CA66B8227B;
        Wed, 27 Jul 2022 20:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F31C433D6;
        Wed, 27 Jul 2022 20:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658952179;
        bh=bhXdU0USntkiB9VeAjJXudqJtJ1Zhml+HGIlkrxNYwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dGnKjVscu3t5TawgOTdxEwwl8LqhsjRowLOYg2qWQJKUbZFLdh5py6vJBEojWemHW
         SVTwUXLNCdTNFHdhlL7KZxoeh711XvpjpOZHQE2wZMuVVKByn+M4xg1RUbWB+YMJMP
         APGh9+toyjXVhTrAlSvLkajsDPFzIew4DBVQXY7yWrrsUlN/8Y1qpsOAO1+eIaP0ii
         5FezdknkEYoY7Vv0rMRodjvJMvgM1mWFzxVxYYq3EqPwgxrQZNNXUeLBVVgSVXr5dy
         5ydAQUp+3KAIj0U9jBlFnnnZRU4np/E6YPAYsgH8OTbaa5O4L+x7H6OQRe2/UnrkOy
         Q4wnU12bL8vkA==
Date:   Wed, 27 Jul 2022 15:02:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2] PCI: qcom: Add support for modular builds
Message-ID: <20220727200257.GA220948@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721193513.GA1747404@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 02:35:13PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 21, 2022 at 08:47:20AM +0200, Johan Hovold wrote:
> > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > is useful for multi-platform kernels as well as during development.
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Applied to pci/ctrl/qcom for v5.20, thanks!

I'm going to drop this one for now, since the module vs remove
discussion [1] is still ongoing.

This patch actually makes it both *modular* and *removable*.  I think
the modular part is uncontroversial and valuable by itself.

If you want to just make it modular and *non*-removable, I think that
would be fine and we can add removability next cycle if we think it's
safe.

[1] https://lore.kernel.org/r/20220721195433.GA1747571@bhelgaas

> > Changes in v2
> >  - rebase on next-20220720 (adjust context)
> >  - add Rob and Mani's reviewed-by tags
> > 
> > 
> >  drivers/pci/controller/dwc/Kconfig     |  2 +-
> >  drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
> >  2 files changed, 34 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 62ce3abf0f19..230f56d1a268 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -168,7 +168,7 @@ config PCI_HISI
> >  	  Hip05 and Hip06 SoCs
> >  
> >  config PCIE_QCOM
> > -	bool "Qualcomm PCIe controller"
> > +	tristate "Qualcomm PCIe controller"
> >  	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> >  	depends on PCI_MSI_IRQ_DOMAIN
> >  	select PCIE_DW_HOST
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 5ed164c2afa3..d176c635016b 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -16,7 +16,7 @@
> >  #include <linux/io.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/kernel.h>
> > -#include <linux/init.h>
> > +#include <linux/module.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_gpio.h>
> >  #include <linux/pci.h>
> > @@ -1518,6 +1518,15 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> >  	return ret;
> >  }
> >  
> > +static void qcom_pcie_host_deinit(struct qcom_pcie *pcie)
> > +{
> > +	qcom_ep_reset_assert(pcie);
> > +	if (pcie->cfg->ops->post_deinit)
> > +		pcie->cfg->ops->post_deinit(pcie);
> > +	phy_power_off(pcie->phy);
> > +	pcie->cfg->ops->deinit(pcie);
> > +}
> > +
> >  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
> >  	.host_init = qcom_pcie_host_init,
> >  };
> > @@ -1752,6 +1761,22 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >  	return ret;
> >  }
> >  
> > +static int qcom_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
> > +	struct device *dev = &pdev->dev;
> > +
> > +	dw_pcie_host_deinit(&pcie->pci->pp);
> > +	qcom_pcie_host_deinit(pcie);
> > +
> > +	phy_exit(pcie->phy);
> > +
> > +	pm_runtime_put_sync(dev);
> > +	pm_runtime_disable(dev);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct of_device_id qcom_pcie_match[] = {
> >  	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
> >  	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> > @@ -1771,6 +1796,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> >  	{ .compatible = "qcom,pcie-ipq6018", .data = &ipq6018_cfg },
> >  	{ }
> >  };
> > +MODULE_DEVICE_TABLE(of, qcom_pcie_match);
> >  
> >  static void qcom_fixup_class(struct pci_dev *dev)
> >  {
> > @@ -1786,10 +1812,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
> >  
> >  static struct platform_driver qcom_pcie_driver = {
> >  	.probe = qcom_pcie_probe,
> > +	.remove = qcom_pcie_remove,
> >  	.driver = {
> >  		.name = "qcom-pcie",
> > -		.suppress_bind_attrs = true,
> >  		.of_match_table = qcom_pcie_match,
> >  	},
> >  };
> > -builtin_platform_driver(qcom_pcie_driver);
> > +module_platform_driver(qcom_pcie_driver);
> > +
> > +MODULE_AUTHOR("Stanimir Varbanov <svarbanov@mm-sol.com>");
> > +MODULE_DESCRIPTION("Qualcomm PCIe root complex driver");
> > +MODULE_LICENSE("GPL");
> > -- 
> > 2.35.1
> > 
