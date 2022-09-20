Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD245BE73E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 15:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiITNiB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 09:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiITNh7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 09:37:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4B53AE6C;
        Tue, 20 Sep 2022 06:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55F95629CE;
        Tue, 20 Sep 2022 13:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A746C433D6;
        Tue, 20 Sep 2022 13:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663681076;
        bh=l6QCkQPQmf5xKZt5wdlN3JoV4O1u6fNCXibO2IpmGGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IsAH0TCEATreJJERC7+UKn3/F8/6zO4Q7JqNRE9u7reQ96PZmFwoziYCKD1Ell5UV
         y2dTEXhRpRJ9NWoFnr6pwhEfoSqh1ia8keDlYn3Dz4vCqgsJbh+35qRlVbrmAcVFTw
         tWBdxhxhSHlfxPQ01QBJ2eBGYJtYA25JsRRh2QvwZhiigsp78YifCSiMqSUHc+YAyM
         Uuasx34seUOUJB0zuFfYi4K1kenSsARHTKmUkRCJpvYo57m3F9Hbf1xiURi7c+wHLu
         EGQOukURfLMAhZV39JptoFFS4xE11HvewEzjYoz8hpmM5mdc3HdId51kqJxm8ENDas
         UkIcyhSMU5S1Q==
Date:   Tue, 20 Sep 2022 08:37:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Message-ID: <20220920133754.GA1102995@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyl+PNcbtSwzlgvh@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 20, 2022 at 10:47:56AM +0200, Johan Hovold wrote:
> Hi Lorenzo,
> 
> On Thu, Jul 21, 2022 at 08:47:20AM +0200, Johan Hovold wrote:
> > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > is useful for multi-platform kernels as well as during development.
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> > 
> > Changes in v2
> >  - rebase on next-20220720 (adjust context)
> >  - add Rob and Mani's reviewed-by tags
> 
> Have you had a change to look at this one since you got back from
> vacation?
> 
> I believe this should be uncontroversial as we already have other
> modular dwc drivers and there's no mapping of legacy INTx interrupts
> involved.

I'm not Lorenzo, but was there a conclusive outcome to the thread at
[1]?  The last thing I remember was that a buggy endpoint driver that
failed to unmap all its interrupts could cause crashes if the PCIe
controller driver was removed.

Making the driver modular is essential so distros can build all the
drivers and users can load the one needed by their platform.

Making the driver removable is useful for developers but not for
users, so I don't see it as essential.  Developers are in the business
of developing and can easily carry a trivial out-of-tree patch to add
removability if needed.

If removability is actually safe even if endpoint drivers aren't
perfect, then I don't object to it.  But if it's not always safe, I
don't think the argument that "other drivers do it" is strong.  I'd
rather make all the drivers safe even if that means making them
non-removable.

[1] https://lore.kernel.org/r/20220721195433.GA1747571@bhelgaas

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
> 
> Johan
