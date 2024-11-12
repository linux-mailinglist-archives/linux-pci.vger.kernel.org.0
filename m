Return-Path: <linux-pci+bounces-16595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E38A9C62AE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 21:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2DA285A78
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 20:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1709219CB2;
	Tue, 12 Nov 2024 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA0pKXCt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E91FC7F8;
	Tue, 12 Nov 2024 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443928; cv=none; b=EX0i88APVNNrnWQFxJbMeyS7GpiMCExBKLCzU1j5syjrYB+yFHKcDBMkLV4s30CgV+JJCvmeE2W6ph6mfW+EHVpMXf5SQorVYwmXVvPaPV4dVW8/MUc/RbKU0QITmpOpFSYfBNjOWU5o4KTJQnCpgjVM9LW+uQPklxTmp/W+9H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443928; c=relaxed/simple;
	bh=wjtOHj4y8gsqVuXZ+1yV34w0MIivyofWbJzXM/nn8Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M1cqj1jQ6/5S2Xnk9MQlTnHU1tnUvhFv/adtCVG1Xy/Z+JD8EtbD+guaRTPEhpAWCnLOyKG58A6tvfzPoY3T0IBhJXQ187b0YfV1yWdSFiASgpUfrb+kdRcDsHU+iwuNVLKBRF28K4oc0F/UctFKI7lIsKBtlCw1Qu+ulOrauzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA0pKXCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EE4C4CECD;
	Tue, 12 Nov 2024 20:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731443928;
	bh=wjtOHj4y8gsqVuXZ+1yV34w0MIivyofWbJzXM/nn8Sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BA0pKXCtrB6bXbyJc5/bhgCtmP1XSUID+NiHe7zHFrfqvpmWNmF3D2aGum5+nECng
	 ggnZjjkiI/iYLRk/th4/W0JVBEVMULjtkB8St8Kx1uCBHzG34Nx/m99Ef/askGXsDU
	 6xaSAQ2ZBZWMTfP2PWG1zRXCtZQ2myZ6YJJMGK/bP6BOcEHUh2Dzao/hgug/rpXh78
	 KLUfrHT09PAtDVAulD20wOIJkubxpKul2IdQky38pwjhKiGJ0oQS3JWXGFmHGQioue
	 YFVVAXSVCFa/ON+B9KPjFHzyvYvNfUIthQAM40xLCtyFnVY9YYLPhlplKru4Dx7WT1
	 eGv70+SZ+xadA==
Date: Tue, 12 Nov 2024 14:38:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	cassel@kernel.org, quic_schintav@quicinc.com,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI: stm32: Add PCIe endpoint support for STM32MP25
Message-ID: <20241112203846.GA1856246@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112161925.999196-5-christian.bruel@foss.st.com>

On Tue, Nov 12, 2024 at 05:19:24PM +0100, Christian Bruel wrote:
> Add driver to configure the STM32MP25 SoC PCIe Gen2 controller based on the
> DesignWare PCIe core in endpoint mode.
> Uses the common reference clock provided by the host.

> +++ b/drivers/pci/controller/dwc/Kconfig

> +config PCIE_STM32_EP
> +	tristate "STMicroelectronics STM32MP25 PCIe Controller (endpoint mode)"
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	help
> +	  Enables endpoint support for DesignWare core based PCIe controller in found
> +	  in STM32MP25 SoC.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pcie-stm32-ep.

Move as for the host mode entry.

> +++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c

> +static const struct of_device_id stm32_pcie_ep_of_match[] = {
> +	{ .compatible = "st,stm32mp25-pcie-ep" },
> +	{},
> +};

Move next to stm32_pcie_ep_driver.

> +static void stm32_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +	enum pci_barno bar;
> +
> +	for (bar = BAR_0; bar <= PCI_STD_NUM_BARS; bar++)

Most users just use "bar = 0".  BAR_0 is 0, but there's no real
connection with PCI_STD_NUM_BARS, so I think 0 is probably better.

Looks like this should be "bar < PCI_STD_NUM_BARS"?

> +		dw_pcie_ep_reset_bar(pci, bar);
> +
> +	/* Defer Completion Requests until link started */

Not sure what a Completion Request is.  Is this some internal STM or
DWC thing?  Or is this related to Request Retry Status completions for
config requests?

> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +			   STM32MP25_PCIECR_REQ_RETRY_EN,
> +			   STM32MP25_PCIECR_REQ_RETRY_EN);
> +}

> +static int stm32_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				unsigned int type, u16 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_IRQ_INTX:
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
> +	case PCI_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;

Is the compiler not smart enough to notice that this is unreachable?

> +static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +	struct device *dev = pci->dev;
> +	struct dw_pcie_ep *ep = &pci->ep;
> +	int ret;
> +
> +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_ENABLED) {
> +		dev_dbg(pci->dev, "Link is already enabled\n");
> +		return;
> +	}
> +
> +	dev_dbg(dev, "PERST de-asserted by host. Starting link training\n");
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm runtime resume failed: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = stm32_pcie_enable_resources(stm32_pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable resources: %d\n", ret);
> +		pm_runtime_put_sync(dev);
> +		return;
> +	}
> +
> +	ret = dw_pcie_ep_init_registers(ep);
> +	if (ret) {
> +		dev_err(dev, "Failed to complete initialization: %d\n", ret);
> +		stm32_pcie_disable_resources(stm32_pcie);
> +		pm_runtime_put_sync(dev);
> +		return;
> +	}
> +
> +	pci_epc_init_notify(ep->epc);
> +
> +	ret = stm32_pcie_enable_link(pci);
> +	if (ret) {
> +		dev_err(dev, "PCIe Cannot establish link: %d\n", ret);
> +		stm32_pcie_disable_resources(stm32_pcie);
> +		pm_runtime_put_sync(dev);
> +		return;
> +	}
> +
> +	stm32_pcie->link_status = STM32_PCIE_EP_LINK_ENABLED;
> +}

> +static int stm32_add_pcie_ep(struct stm32_pcie *stm32_pcie,
> +			     struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = stm32_pcie->pci;
> +	struct dw_pcie_ep *ep = &pci->ep;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +				 STM32MP25_PCIECR_TYPE_MASK,
> +				 STM32MP25_PCIECR_EP);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm runtime resume failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	reset_control_assert(stm32_pcie->rst);
> +	reset_control_deassert(stm32_pcie->rst);
> +
> +	ep->ops = &stm32_pcie_ep_ops;
> +
> +	ret = dw_pcie_ep_init(ep);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize ep: %d\n", ret);
> +		pm_runtime_put_sync(dev);
> +		return ret;
> +	}
> +
> +	ret = stm32_pcie_enable_resources(stm32_pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to enable resources: %d\n", ret);
> +		dw_pcie_ep_deinit(ep);
> +		pm_runtime_put_sync(dev);
> +		return ret;
> +	}
> +
> +	ret = dw_pcie_ep_init_registers(ep);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
> +		stm32_pcie_disable_resources(stm32_pcie);
> +		dw_pcie_ep_deinit(ep);
> +		pm_runtime_put_sync(dev);
> +		return ret;
> +	}

Consider gotos for the error cases with a cleanup block at the end.
There's a fair bit of repetition there as more things get initialized,
and it's error-prone to extend this in the future.

Same applies in stm32_pcie_perst_deassert().

> +	pci_epc_init_notify(ep->epc);
> +
> +	return 0;
> +}
> +
> +static int stm32_pcie_probe(struct platform_device *pdev)
> +{
> +	struct stm32_pcie *stm32_pcie;
> +	struct dw_pcie *dw;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	stm32_pcie = devm_kzalloc(dev, sizeof(*stm32_pcie), GFP_KERNEL);
> +	if (!stm32_pcie)
> +		return -ENOMEM;
> +
> +	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
> +	if (!dw)
> +		return -ENOMEM;

Add blank line here.

> +	stm32_pcie->pci = dw;

> +static struct platform_driver stm32_pcie_ep_driver = {
> +	.probe = stm32_pcie_probe,
> +	.remove_new = stm32_pcie_remove,

.remove().

> +	.driver = {
> +		.name = "stm32-ep-pcie",
> +		.of_match_table = stm32_pcie_ep_of_match,
> +	},
> +};

