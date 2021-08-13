Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0FD3EBA13
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 18:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhHMQbZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 12:31:25 -0400
Received: from foss.arm.com ([217.140.110.172]:55656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236654AbhHMQbW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 12:31:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D4F41FB;
        Fri, 13 Aug 2021 09:30:55 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C7E23F718;
        Fri, 13 Aug 2021 09:30:53 -0700 (PDT)
Date:   Fri, 13 Aug 2021 17:30:51 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     srikanth.thokala@intel.com
Cc:     robh+dt@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, kw@linux.com, maz@kernel.org
Subject: Re: [PATCH v11 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20210813163051.GD15515@lpieralisi>
References: <20210805211010.29484-1-srikanth.thokala@intel.com>
 <20210805211010.29484-3-srikanth.thokala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805211010.29484-3-srikanth.thokala@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 06, 2021 at 02:40:10AM +0530, srikanth.thokala@intel.com wrote:

[...]

> +static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
> +				      struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	u32 val;
> +	int ret;
> +
> +	pp->ops = &keembay_pcie_host_ops;
> +	pp->msi_irq = -ENODEV;
> +
> +	ret = keembay_pcie_setup_msi_irq(pcie);
> +	if (ret)
> +		return ret;

May I ask you (and DWC maintainers) please why we need to resort to
setting

pp->msi_irq = -ENODEV;

while we *could* (?) just use pp->ops->msi_host_init() (ie which I
believe can be keembay_pcie_setup_msi_irq() revisited ?)

I would like to understand how this choice can be made by a DWC
developer that has to add an incantation specific MSI logic handling
glue.

Other than that we can merge this code but I would like to understand
the rationale behind the question above - it is not obvious to me.

Thanks,
Lorenzo

> +
> +	pcie->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(pcie->reset))
> +		return PTR_ERR(pcie->reset);
> +
> +	ret = keembay_pcie_probe_clocks(pcie);
> +	if (ret)
> +		return ret;
> +
> +	val = readl(pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
> +	val |= PHY0_SRAM_BYPASS;
> +	writel(val, pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
> +
> +	writel(PCIE_DEVICE_TYPE, pcie->apb_base + PCIE_REGS_PCIE_CFG);
> +
> +	ret = keembay_pcie_pll_init(pcie);
> +	if (ret)
> +		return ret;
> +
> +	val = readl(pcie->apb_base + PCIE_REGS_PCIE_CFG);
> +	writel(val | PCIE_RSTN, pcie->apb_base + PCIE_REGS_PCIE_CFG);
> +	keembay_ep_reset_deassert(pcie);
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		keembay_ep_reset_assert(pcie);
> +		dev_err(dev, "Failed to initialize host: %d\n", ret);
> +		return ret;
> +	}
> +
> +	val = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		val |= MSI_CTRL_INT_EN;
> +	writel(val, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> +
> +	return 0;
> +}
> +
> +static int keembay_pcie_probe(struct platform_device *pdev)
> +{
> +	const struct keembay_pcie_of_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct keembay_pcie *pcie;
> +	struct dw_pcie *pci;
> +	enum dw_pcie_device_mode mode;
> +
> +	data = device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	mode = (enum dw_pcie_device_mode)data->mode;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci = &pcie->pci;
> +	pci->dev = dev;
> +	pci->ops = &keembay_pcie_ops;
> +
> +	pcie->mode = mode;
> +
> +	pcie->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
> +	if (IS_ERR(pcie->apb_base))
> +		return PTR_ERR(pcie->apb_base);
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	switch (pcie->mode) {
> +	case DW_PCIE_RC_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_HOST))
> +			return -ENODEV;
> +
> +		return keembay_pcie_add_pcie_port(pcie, pdev);
> +	case DW_PCIE_EP_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_EP))
> +			return -ENODEV;
> +
> +		pci->ep.ops = &keembay_pcie_ep_ops;
> +		return dw_pcie_ep_init(&pci->ep);
> +	default:
> +		dev_err(dev, "Invalid device type %d\n", pcie->mode);
> +		return -ENODEV;
> +	}
> +}
> +
> +static const struct keembay_pcie_of_data keembay_pcie_rc_of_data = {
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static const struct keembay_pcie_of_data keembay_pcie_ep_of_data = {
> +	.mode = DW_PCIE_EP_TYPE,
> +};
> +
> +static const struct of_device_id keembay_pcie_of_match[] = {
> +	{
> +		.compatible = "intel,keembay-pcie",
> +		.data = &keembay_pcie_rc_of_data,
> +	},
> +	{
> +		.compatible = "intel,keembay-pcie-ep",
> +		.data = &keembay_pcie_ep_of_data,
> +	},
> +	{}
> +};
> +
> +static struct platform_driver keembay_pcie_driver = {
> +	.driver = {
> +		.name = "keembay-pcie",
> +		.of_match_table = keembay_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe  = keembay_pcie_probe,
> +};
> +builtin_platform_driver(keembay_pcie_driver);
> -- 
> 2.17.1
> 
