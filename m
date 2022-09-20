Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6DC5BE8DF
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiITO13 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiITO1W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 10:27:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8130D6173;
        Tue, 20 Sep 2022 07:27:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D9B4B82A56;
        Tue, 20 Sep 2022 14:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C104C433C1;
        Tue, 20 Sep 2022 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663684038;
        bh=QyVcelDXPwbiuFJMdRmaSbabqTaB24EpzwFhUN+SSRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hfq3WsW11el8D2ZZgc97RZtmFmySeyzYZN5wP2M9iwvO1jR4urtZjMr1zvBhwEFmD
         h80mYPgTqSyApyZCWEJDltb10+pTtXJUgPKwdn8amtdSU3AuynuiELIdo2VyxsEWdJ
         i4J8adJw+ORVFMjgBN+dubEmUuUXsSxPhs76HxahmlhywDqJTf0B/p3QPJdtu3lzse
         wy0/IjY0Fkkgy/OmyQC4dXYMAvLqFhzQllSixKXR9yu/JEhBOj/8Qptcaz6snPXknf
         hRXgZOt58hwj1lWBC2EAy05RlX7C3La7qdver6hf/UxwkHKgg4bVubyPcm2rE5ji6w
         EqRFDV+WlSolg==
Date:   Tue, 20 Sep 2022 19:57:06 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20220920142706.GC1621196@thinkpad>
References: <Yyl+PNcbtSwzlgvh@hovoldconsulting.com>
 <20220920133754.GA1102995@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220920133754.GA1102995@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 20, 2022 at 08:37:54AM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 20, 2022 at 10:47:56AM +0200, Johan Hovold wrote:
> > Hi Lorenzo,
> > 
> > On Thu, Jul 21, 2022 at 08:47:20AM +0200, Johan Hovold wrote:
> > > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > > is useful for multi-platform kernels as well as during development.
> > > 
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > > 
> > > Changes in v2
> > >  - rebase on next-20220720 (adjust context)
> > >  - add Rob and Mani's reviewed-by tags
> > 
> > Have you had a change to look at this one since you got back from
> > vacation?
> > 
> > I believe this should be uncontroversial as we already have other
> > modular dwc drivers and there's no mapping of legacy INTx interrupts
> > involved.
> 
> I'm not Lorenzo, but was there a conclusive outcome to the thread at
> [1]?  The last thing I remember was that a buggy endpoint driver that
> failed to unmap all its interrupts could cause crashes if the PCIe
> controller driver was removed.
> 
> Making the driver modular is essential so distros can build all the
> drivers and users can load the one needed by their platform.
> 
> Making the driver removable is useful for developers but not for
> users, so I don't see it as essential.  Developers are in the business
> of developing and can easily carry a trivial out-of-tree patch to add
> removability if needed.
> 
> If removability is actually safe even if endpoint drivers aren't
> perfect, then I don't object to it.  But if it's not always safe, I
> don't think the argument that "other drivers do it" is strong.  I'd
> rather make all the drivers safe even if that means making them
> non-removable.
> 

If the problem is with the endpoint drivers, then those need to be fixed for
properly disposing the IRQ mappings. I don't see any real issue with the
remove() handler of this controller driver.

Thanks,
Mani

> [1] https://lore.kernel.org/r/20220721195433.GA1747571@bhelgaas
> 
> > >  drivers/pci/controller/dwc/Kconfig     |  2 +-
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
> > >  2 files changed, 34 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index 62ce3abf0f19..230f56d1a268 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -168,7 +168,7 @@ config PCI_HISI
> > >  	  Hip05 and Hip06 SoCs
> > >  
> > >  config PCIE_QCOM
> > > -	bool "Qualcomm PCIe controller"
> > > +	tristate "Qualcomm PCIe controller"
> > >  	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> > >  	depends on PCI_MSI_IRQ_DOMAIN
> > >  	select PCIE_DW_HOST
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 5ed164c2afa3..d176c635016b 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -16,7 +16,7 @@
> > >  #include <linux/io.h>
> > >  #include <linux/iopoll.h>
> > >  #include <linux/kernel.h>
> > > -#include <linux/init.h>
> > > +#include <linux/module.h>
> > >  #include <linux/of_device.h>
> > >  #include <linux/of_gpio.h>
> > >  #include <linux/pci.h>
> > > @@ -1518,6 +1518,15 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > >  	return ret;
> > >  }
> > >  
> > > +static void qcom_pcie_host_deinit(struct qcom_pcie *pcie)
> > > +{
> > > +	qcom_ep_reset_assert(pcie);
> > > +	if (pcie->cfg->ops->post_deinit)
> > > +		pcie->cfg->ops->post_deinit(pcie);
> > > +	phy_power_off(pcie->phy);
> > > +	pcie->cfg->ops->deinit(pcie);
> > > +}
> > > +
> > >  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
> > >  	.host_init = qcom_pcie_host_init,
> > >  };
> > > @@ -1752,6 +1761,22 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > >  	return ret;
> > >  }
> > >  
> > > +static int qcom_pcie_remove(struct platform_device *pdev)
> > > +{
> > > +	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
> > > +	struct device *dev = &pdev->dev;
> > > +
> > > +	dw_pcie_host_deinit(&pcie->pci->pp);
> > > +	qcom_pcie_host_deinit(pcie);
> > > +
> > > +	phy_exit(pcie->phy);
> > > +
> > > +	pm_runtime_put_sync(dev);
> > > +	pm_runtime_disable(dev);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static const struct of_device_id qcom_pcie_match[] = {
> > >  	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
> > >  	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> > > @@ -1771,6 +1796,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> > >  	{ .compatible = "qcom,pcie-ipq6018", .data = &ipq6018_cfg },
> > >  	{ }
> > >  };
> > > +MODULE_DEVICE_TABLE(of, qcom_pcie_match);
> > >  
> > >  static void qcom_fixup_class(struct pci_dev *dev)
> > >  {
> > > @@ -1786,10 +1812,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
> > >  
> > >  static struct platform_driver qcom_pcie_driver = {
> > >  	.probe = qcom_pcie_probe,
> > > +	.remove = qcom_pcie_remove,
> > >  	.driver = {
> > >  		.name = "qcom-pcie",
> > > -		.suppress_bind_attrs = true,
> > >  		.of_match_table = qcom_pcie_match,
> > >  	},
> > >  };
> > > -builtin_platform_driver(qcom_pcie_driver);
> > > +module_platform_driver(qcom_pcie_driver);
> > > +
> > > +MODULE_AUTHOR("Stanimir Varbanov <svarbanov@mm-sol.com>");
> > > +MODULE_DESCRIPTION("Qualcomm PCIe root complex driver");
> > > +MODULE_LICENSE("GPL");
> > 
> > Johan

-- 
மணிவண்ணன் சதாசிவம்
