Return-Path: <linux-pci+bounces-17281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA589D88CB
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 16:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD14B48258
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B51B0F06;
	Mon, 25 Nov 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ajJXUtdx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022FE1B21B5;
	Mon, 25 Nov 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547175; cv=none; b=EYlRbroPoO27z2tc4IhyQl2Om1yO/vRhyJLQH33LWPg7eGoIXtuQFrK5PrS2FkszHk2W56j/MxJQcsIP7oU1jRA89IlNXceDlJptbz2jNBQ7DFJ72+n/Az6AOBnV8+qQPknKe9/KKjOYaUmfSNs/vVZtKv6yHohMYctxgOn1XLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547175; c=relaxed/simple;
	bh=EKSC53wt6k1TUWC0HHAkCW5R4W3CsvCMLHUyWheBza0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ly/6LE6xe9w2gOxbF1IKjHVViGQcp6XqxSlaVdbynWZz/9Y4gNuxo4OFA3bMze50nKVLYYqOpPPiP6EnI1uqwOl9dCnABEIaKQCVdA926jZtnxtrgX1b4lJqALkVOEuiysleNz4bwWxEvwClkMHYfrxu55E2B9Qe5wY7pe+jgZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ajJXUtdx; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APBlTen017783;
	Mon, 25 Nov 2024 16:05:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	+Q/mRZQeXSx9Hxo42DiMwheV4yYRuNGq7GGm+DxB/9c=; b=ajJXUtdxR/TpZe51
	/TIhSdMxFHtNgVzGu9AatG9nVK8qIAgjQq4nn1QQl6Fd74M5uRe6zhQZD/HffGCT
	xhZ8rX45P9TXo5NMUtlof5lVPVnfxv3DUTW0Kks0ynNlrMxMfuaWPIIb9WB5jdSY
	zm/yxSz/Fisw2Euf3c/Go9UFpGqoo+hAn/YC9Yi8ghqLiLCl5KMZRkH00ZWlB04D
	nZ18BfEJTQxtcEPSgAic49qGNRz4xGY21MKFn7A3toEgikE53S9qAUQT0/gu0OlX
	nHyQIdKbSGNAmWh0V6ahL4GRvyJaeNaCVsd8zYFSDiBCMyNLGN4E+n8gsTOUHO+V
	hGpCvw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 433791r7fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 16:05:14 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2C24B40047;
	Mon, 25 Nov 2024 16:03:48 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 565E129BAFB;
	Mon, 25 Nov 2024 16:01:00 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 25 Nov
 2024 16:00:59 +0100
Message-ID: <9d3bf191-5dcf-4d7d-8311-0ef491cfdf65@foss.st.com>
Date: Mon, 25 Nov 2024 16:00:52 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH 2/5] PCI: stm32: Add PCIe host support for STM32MP25
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <cassel@kernel.org>,
        <quic_schintav@quicinc.com>, <fabrice.gasnier@foss.st.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241112193214.GA1852199@bhelgaas>
Content-Language: en-US
In-Reply-To: <20241112193214.GA1852199@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hello,

On 11/12/24 20:32, Bjorn Helgaas wrote:
> On Tue, Nov 12, 2024 at 05:19:22PM +0100, Christian Bruel wrote:
>> Add driver for the STM32MP25 SoC PCIe Gen2 controller based on the
>> DesignWare PCIe core.
>> Supports MSI via GICv2m, Single Virtual Channel, Single Function
> 
> Add blank lines between paragraphs.  Also applies to other patches in
> the series.
> 
>> +config PCIE_STM32
>> +	tristate "STMicroelectronics STM32MP25 PCIe Controller (host mode)"
>> +	depends on ARCH_STM32 || COMPILE_TEST
>> +	depends on PCI_MSI
>> +	select PCIE_DW_HOST
>> +	help
>> +	  Enables support for the DesignWare core based PCIe host controller
>> +	  found in STM32MP25 SoC.
>> +
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called pcie-stm32.
> 
> Move this so the drivers stay alphabetized.  There's already a
> "STMicroelectronics SPEAr PCIe controller" entry, and this should go
> right next to it.
> 
>> +++ b/drivers/pci/controller/dwc/pcie-stm32.c
> 
>> +static const struct of_device_id stm32_pcie_of_match[] = {
>> +	{ .compatible = "st,stm32mp25-pcie-rc" },
>> +	{},
>> +};
> 
> Most drivers put this near the platform_driver struct that references
> it.
> 
>> +static int stm32_pcie_set_max_payload(struct dw_pcie *pci, int mps)
>> +{
>> +	int ret;
>> +	struct device *dev = pci->dev;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +	if (mps != 128 && mps != 256) {
>> +		dev_err(dev, "Unexpected payload size %d\n", mps);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = pcie_set_mps(pdev, mps);
>> +	if (ret)
>> +		dev_err(dev, "failed to set mps %d, error %d\n", mps, ret);
> 
> MPS config is normally not device-specific, and it's somewhat fragile
> (see pci_configure_mps() and pcie_bus_config), so I kind of hate to
> see more users.  Maybe there's some hardware issue involved here?

Indeed that fixed a debugging issue with the first designs.
Not necessary anymore, dropping.

> 
>> +static int stm32_pcie_start_link(struct dw_pcie *pci)
>> +{
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +	u32 ret;
>> +
>> +	if (stm32_pcie->reset_gpio) {
>> +		/* Make sure PERST# is asserted. */
>> +		gpiod_set_value(stm32_pcie->reset_gpio, 1);
>> +
>> +		/* Deassert PERST# after 100us */
>> +		usleep_range(100, 200);
> 
> If this is PCIE_T_PERST_CLK_US, use that.  If not, please add a
> relevant #define with a citation to the spec.
> 
>> +		gpiod_set_value(stm32_pcie->reset_gpio, 0);
>> +	}
>> +
>> +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +				 STM32MP25_PCIECR_LTSSM_EN,
>> +				 STM32MP25_PCIECR_LTSSM_EN);
>> +
>> +	/*
>> +	 * PCIe specification states that you should not issue any config
>> +	 * requests until 100ms after asserting reset, so we enforce that here
> 
> I think it says 100ms after *deasserting* reset.  But if you use
> PCIE_T_RRS_READY_MS below, I don't think you even need this comment.

ack thanks

> 
>> +	if (stm32_pcie->reset_gpio)
>> +		msleep(100);
> 
> I think this is PCIE_T_RRS_READY_MS.
> 
>> +static void stm32_pcie_stop_link(struct dw_pcie *pci)
>> +{
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +
>> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
> 
> With a half-dozen exceptions, this file fits nicely in 80 columns.
> Can you wrap this and the similar exceptions?  No need to break printf
> strings or the regmap strings that can't reasonably be wrapped.
> 
>> +	/* Assert PERST# */
>> +	if (stm32_pcie->reset_gpio)
>> +		gpiod_set_value(stm32_pcie->reset_gpio, 1);
> 
> Might be nice to include "perst" in the "reset_gpio" name to identify
> it more specifically.

ok

> 
>> +}
>> +
>> +static int stm32_pcie_suspend(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +
>> +	if (device_may_wakeup(dev) || device_wakeup_path(dev))
>> +		enable_irq_wake(stm32_pcie->wake_irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_pcie_resume(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +
>> +	if (device_may_wakeup(dev) || device_wakeup_path(dev))
>> +		disable_irq_wake(stm32_pcie->wake_irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_pcie_suspend_noirq(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +
>> +	stm32_pcie->link_is_up = dw_pcie_link_up(stm32_pcie->pci);
>> +
>> +	stm32_pcie_stop_link(stm32_pcie->pci);
>> +	clk_disable_unprepare(stm32_pcie->clk);
>> +
>> +	if (!device_may_wakeup(dev) && !device_wakeup_path(dev))
>> +		phy_exit(stm32_pcie->phy);
>> +
>> +	return pinctrl_pm_select_sleep_state(dev);
>> +}
>> +
>> +static int stm32_pcie_resume_noirq(struct device *dev)
>> +{
>> +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
>> +	struct dw_pcie *pci = stm32_pcie->pci;
>> +	struct dw_pcie_rp *pp = &pci->pp;
>> +	int ret;
>> +
>> +	/* init_state was set in pinctrl_bind_pins() before probe */
>> +	if (!IS_ERR(dev->pins->init_state))
>> +		ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
>> +	else
>> +		ret = pinctrl_pm_select_default_state(dev);
>> +
>> +	if (ret) {
>> +		dev_err(dev, "Failed to activate pinctrl pm state: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
>> +		ret = phy_init(stm32_pcie->phy);
>> +		if (ret) {
>> +			pinctrl_pm_select_default_state(dev);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = clk_prepare_enable(stm32_pcie->clk);
>> +	if (ret)
>> +		goto clk_err;
>> +
>> +	ret = stm32_pcie_host_init(pp);
>> +	if (ret)
>> +		goto host_err;
>> +
>> +	ret = dw_pcie_setup_rc(pp);
>> +	if (ret)
>> +		goto pcie_err;
>> +
>> +	if (stm32_pcie->link_is_up) {
>> +		ret = stm32_pcie_start_link(stm32_pcie->pci);
>> +		if (ret)
>> +			goto pcie_err;
>> +
>> +		/* Ignore errors, the link may come up later */
>> +		dw_pcie_wait_for_link(stm32_pcie->pci);
>> +	}
>> +
>> +	pinctrl_pm_select_default_state(dev);
> 
> Interesting that pcie-stm32.c, pci-tegra.c, and pcie-tegra194.c are
> the only PCI controller drivers that use this.  I have no idea what
> this is; it just makes me wonder if these three are just special, or
> if others should be using it?

Here default_state balances with pinctrl_pm_select_sleep_state in 
suspend_noirq. So we should have the same probing sequence:

suspend_noirq()
   pinctrl_pm_select_sleep_state()

resume_noirq()
   pinctrl_select_state(dev->pins->p, dev->pins->init_state);
   ... restart resources and link
   pinctrl_pm_select_default_state()

for the other targets, I have no idea

> 
>> +static int stm32_add_pcie_port(struct stm32_pcie *stm32_pcie,
>> +			       struct platform_device *pdev)
>> +{
>> +	struct dw_pcie *pci = stm32_pcie->pci;
>> +	struct device *dev = pci->dev;
>> +	struct dw_pcie_rp *pp = &pci->pp;
>> +	int ret;
>> +
>> +	ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = phy_init(stm32_pcie->phy);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +				 STM32MP25_PCIECR_TYPE_MASK, STM32MP25_PCIECR_RC);
>> +	if (ret)
>> +		goto phy_disable;
>> +
>> +	reset_control_assert(stm32_pcie->rst);
>> +	reset_control_deassert(stm32_pcie->rst);
> 
> Is there any reset pulse width requirement here?

looking at the timing diagram, I don't think so, the transition looks 
quite fast

At the end we will use the reset_control_deassert API to hide this 
mechanism, when the stm32-reset driver is ready

> 
>> +	ret = clk_prepare_enable(stm32_pcie->clk);
>> +	if (ret) {
>> +		dev_err(dev, "Core clock enable failed %d\n", ret);
>> +		goto phy_disable;
>> +	}
>> +
>> +	pp->ops = &stm32_pcie_host_ops;
>> +	ret = dw_pcie_host_init(pp);
>> +	if (ret) {
>> +		dev_err(dev, "failed to initialize host: %d\n", ret);
> 
> Consider making all the messages consistent in terms of sentence
> structure and capitalization.
> 
>> +static int stm32_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct stm32_pcie *stm32_pcie;
>> +	struct dw_pcie *dw;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = pdev->dev.of_node;
>> +	int ret;
>> +
>> +	stm32_pcie = devm_kzalloc(dev, sizeof(*stm32_pcie), GFP_KERNEL);
>> +	if (!stm32_pcie)
>> +		return -ENOMEM;
>> +
>> +	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
>> +	if (!dw)
>> +		return -ENOMEM;
> 
> Add blank line.
> 
>> +static struct platform_driver stm32_pcie_driver = {
>> +	.probe = stm32_pcie_probe,
>> +	.remove_new = stm32_pcie_remove,
> 
> Use .remove instead of .remove_new; see 0edb555a65d1 ("platform: Make
> platform_driver::remove() return void").
> 
>> +	.driver = {
>> +		.name = "stm32-pcie",
>> +		.of_match_table = stm32_pcie_of_match,
>> +		.pm		= &stm32_pcie_pm_ops,
>> +	},
>> +};
>> +
>> +static bool is_stm32_pcie_driver(struct device *dev)
>> +{
>> +	/* PCI bridge */
>> +	dev = get_device(dev);
>> +
>> +	/* Platform driver */
>> +	dev = get_device(dev->parent);
>> +
>> +	return (dev->driver == &stm32_pcie_driver.driver);
> 
> Ugh.  Some MPS/MRRS magic going on here, evidently related to the STM
> integration of DWC IP? >
>> +static bool apply_mrrs_quirk(struct pci_dev *root_port)
>> +{
>> +	struct dw_pcie_rp *pp;
>> +	struct dw_pcie *dw_pci;
>> +	struct stm32_pcie *stm32_pcie;
>> +
>> +	if (WARN_ON(!root_port) || !is_stm32_pcie_driver(root_port->dev.parent))
>> +		return false;
>> +
>> +	pp = root_port->bus->sysdata;
>> +	dw_pci = to_dw_pcie_from_pp(pp);
>> +	stm32_pcie = to_stm32_pcie(dw_pci);
>> +
>> +	if (!stm32_pcie->limit_downstream_mrrs)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +static void quirk_stm32_pcie_limit_mrrs(struct pci_dev *pci)
>> +{
>> +	struct pci_dev *root_port;
>> +	struct pci_bus *bus = pci->bus;
>> +	int readrq;
>> +	int mps;
>> +
>> +	if (pci_is_root_bus(bus))
>> +		return;
>> +
>> +	root_port = pcie_find_root_port(pci);
>> +
>> +	if (!apply_mrrs_quirk(root_port))
>> +		return;
>> +
>> +	mps = pcie_get_mps(root_port);
>> +
>> +	/*
>> +	 * STM32 PCI controller has a h/w performance limitation on the AXI DDR requests.
>> +	 * Limit the maximum read request size to 256B on all downstream devices.
> 
> I guess this is some kind of platform erratum, since there's no way
> for us to discover a limit on supported MRRS values?

Yes. Those quirk are not necessary anymore. will drop

> 
>> +	readrq = pcie_get_readrq(pci);
>> +	if (readrq > 256) {
>> +		int mrrs = min(mps, 256);
>> +
>> +		pcie_set_readrq(pci, mrrs);
>> +
>> +		pci_info(pci, "Max Read Rq set to %4d (was %4d)\n", mrrs, readrq);
>> +	}
>> +}
>> +
>> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID,
>> +			 quirk_stm32_pcie_limit_mrrs);
>> 
>> +static int stm32_dma_limit(struct pci_dev *pdev, void *data)
>> +{
>> +	dev_dbg(&pdev->dev, "set bus_dma_limit");
>> +
>> +	pdev->dev.bus_dma_limit = DMA_BIT_MASK(32);
> 
> This is quite unusual and deserves some comment about why we need
> it.
> 

32 bus master DMA cannot access the last 2GB in addressing space (out of 
a 6GB addressing space).

Proposing the following comment
"DMA masters can only access the first 4GB of memory space, so setup the 
bus DMA limit accordingly."

Saw a similar quirk in mips/pci/fixup-sb1250.c



>> +	return 0;
>> +}
>> +
>> +static void quirk_stm32_dma_mask(struct pci_dev *pci)
>> +{
>> +	struct pci_dev *root_port;
>> +
>> +	root_port = pcie_find_root_port(pci);
>> +
>> +	if (root_port && (root_port->dev.parent))
>> +		pci_walk_bus(pci->bus, stm32_dma_limit, NULL);
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0x0550, quirk_stm32_dma_mask);
> 
> I guess this applies to [16c3:0550] devices and everything below them?
> It looks like these must be Root Ports?  And they identify as
> PCI_VENDOR_ID_SYNOPSYS instead of PCI_VENDOR_ID_STMICRO (104a)?

Yes we are based on the designware v5.50a PCIe version. The idea here is 
to set bus_dma_limit for all devices on the root_port.
is_stm32_pcie_driver is a sanity double check in case the quirk is 
applied to another target linked at compile time

> 
> Could be added at https://admin.pci-ids.ucw.cz/read/PC/16c3/ if you
> want lspci to name them correctly.
> 
>> +++ b/drivers/pci/controller/dwc/pcie-stm32.h
> 
>> +#define STM32MP25_PCIECR_EP		0
> 
> Ideally would go in the patch that uses it.

This is a bit num. Similar to STM32MP25_PCIECR_RC BIT(10), I preper to 
see the definition close to the GENMASK that uses it, making the bit
checking a little bit easier to follow...

> 
>> +#define SYSCFG_PCIEPMEMSICR		0x6004
>> +#define SYSCFG_PCIEAERRCMSICR		0x6008
>> +#define SYSCFG_PCIESR1			0x6100
>> +#define SYSCFG_PCIESR2			0x6104
>> +
>> +#define PCIE_CAP_MAX_PAYLOAD_SIZE(x)	((x) << 5)
>> +#define PCIE_CAP_MAX_READ_REQ_SIZE(x)	((x) << 12)
> 
> These are all unused, drop them until you need them.

OK, thanks !!

Christian

