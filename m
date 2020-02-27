Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2EA171646
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 12:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgB0LsY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 06:48:24 -0500
Received: from foss.arm.com ([217.140.110.172]:49094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbgB0LsY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 06:48:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05CAB1FB;
        Thu, 27 Feb 2020 03:48:24 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 025253F73B;
        Thu, 27 Feb 2020 03:48:21 -0800 (PST)
Date:   Thu, 27 Feb 2020 11:48:16 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 5/5] PCI: tegra: Add support for PCIe endpoint mode in
 Tegra194
Message-ID: <20200227114816.GA11443@e121166-lin.cambridge.arm.com>
References: <20200113181411.32743-1-vidyas@nvidia.com>
 <20200113181411.32743-6-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113181411.32743-6-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 13, 2020 at 11:44:11PM +0530, Vidya Sagar wrote:
> Add support for the endpoint mode of Synopsys DesignWare core based
> dual mode PCIe controllers present in Tegra194 SoC.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * Addressed Thierry's review comments

I need his ACK to merge this series.

[...]

> +static int tegra_pcie_ep_work_thread(void *p)
> +{
> +	struct tegra_pcie_dw *pcie = (struct tegra_pcie_dw *)p;
> +	u32 event;
> +
> +	while (true) {
> +		wait_event_interruptible(pcie->wq,
> +					 !kfifo_is_empty(&pcie->event_fifo));
> +
> +		if (kthread_should_stop())
> +			break;
> +
> +		if (!kfifo_get(&pcie->event_fifo, &event)) {
> +			dev_warn(pcie->dev, "EVENT FIFO is empty\n");
> +			continue;
> +		}
> +
> +		switch (event) {
> +		case EP_PEX_RST_DEASSERT:
> +			dev_info(pcie->dev, "EVENT: EP_PEX_RST_DEASSERT\n");
> +			pex_ep_event_pex_rst_deassert(pcie);
> +			break;
> +
> +		case EP_PEX_RST_ASSERT:
> +			dev_info(pcie->dev, "EVENT: EP_PEX_RST_ASSERT\n");
> +			pex_ep_event_pex_rst_assert(pcie);
> +			break;
> +
> +		case EP_HOT_RST_DONE:
> +			dev_info(pcie->dev, "EVENT: EP_HOT_RST_DONE\n");
> +			pex_ep_event_hot_rst_done(pcie);
> +			break;
> +
> +		case EP_BME_CHANGE:
> +			dev_info(pcie->dev, "EVENT: EP_BME_CHANGE\n");
> +			pex_ep_event_bme_change(pcie);
> +			break;
> +
> +		case EP_EVENT_EXIT:
> +			dev_info(pcie->dev, "EVENT: EP_EVENT_EXIT\n");
> +			return 0;
> +
> +		default:
> +			dev_warn(pcie->dev, "Invalid PCIe EP event: %u\n",
> +				 event);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
> +{
> +	struct tegra_pcie_dw *pcie = arg;
> +
> +	if (gpiod_get_value(pcie->pex_rst_gpiod)) {
> +		if (!kfifo_put(&pcie->event_fifo, EP_PEX_RST_ASSERT)) {
> +			dev_err(pcie->dev, "EVENT FIFO is full\n");
> +			return IRQ_HANDLED;
> +		}
> +	} else {
> +		if (!kfifo_put(&pcie->event_fifo, EP_PEX_RST_DEASSERT)) {
> +			dev_err(pcie->dev, "EVENT FIFO is full\n");
> +			return IRQ_HANDLED;
> +		}
> +	}
> +
> +	wake_up(&pcie->wq);
> +
> +	return IRQ_HANDLED;
> +}
> +

[...]

> +static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
> +				struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct device *dev = pcie->dev;
> +	struct dw_pcie_ep *ep;
> +	struct resource *res;
> +	char *name;
> +	int ret;
> +
> +	ep = &pci->ep;
> +	ep->ops = &pcie_ep_ops;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> +	if (!res)
> +		return -EINVAL;
> +
> +	ep->phys_base = res->start;
> +	ep->addr_size = resource_size(res);
> +	ep->page_size = SZ_64K;
> +
> +	ret = gpiod_set_debounce(pcie->pex_rst_gpiod, PERST_DEBOUNCE_TIME);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set PERST GPIO debounce time: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = gpiod_to_irq(pcie->pex_rst_gpiod);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get IRQ for PERST GPIO: %d\n", ret);
> +		return ret;
> +	}
> +	pcie->pex_rst_irq = (unsigned int)ret;
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "tegra_pcie_%u_pex_rst_irq",
> +			      pcie->cid);
> +	if (!name) {
> +		dev_err(dev, "Failed to create PERST IRQ string\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq_set_status_flags(pcie->pex_rst_irq, IRQ_NOAUTOEN);
> +
> +	ret = devm_request_irq(dev, pcie->pex_rst_irq,
> +			       tegra_pcie_ep_pex_rst_irq,
> +			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +			       name, (void *)pcie);

I have the impression that a threaded IRQ is what you need, which
will also remove some boilerplate in the process. Any reason why
you can't use a threaded IRQ instead of a standalone kthread ?

Thanks,
Lorenzo
