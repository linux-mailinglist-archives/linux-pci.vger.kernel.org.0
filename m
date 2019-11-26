Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6D10A613
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 22:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfKZVhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 16:37:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfKZVhX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 16:37:23 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B0120835;
        Tue, 26 Nov 2019 21:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574804242;
        bh=NiCNn3FuYjr3n6WG4QyUZzhp+ax9LgPmgNljIGhEErI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=drZqipwPeS+niJFsQ0qSF6WD0LHQSIqKXEeHnUMsVLnVc7MNuISEmOaQH+sDLt2g/
         zMyTvJUM46sxgLF7lkaIhja1ULdda7AL64iLWUwrXiH0nczywhEf6oFTFeuLNA5HY6
         hlclqFVo9MpY/gYtPhZbpczXork0in44N12KPgbI=
Date:   Tue, 26 Nov 2019 15:37:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 3/6] PCI: tegra: Add support for PCIe endpoint mode in
 Tegra194
Message-ID: <20191126213718.GA185422@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122104505.8986-4-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 04:15:02PM +0530, Vidya Sagar wrote:
> Add support for the endpoint mode of Synopsys DesignWare core based
> dual mode PCIe controllers present in Tegra194 SoC.

> +static irqreturn_t tegra_pcie_ep_irq_handler(struct tegra_pcie_dw *pcie)
> +{
> +	struct dw_pcie_ep *ep = &pcie->pci.ep;
> +	u32 val, tmp;
> +
> +	val = appl_readl(pcie, APPL_INTR_STATUS_L0);
> +	if (val & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
> +		val = appl_readl(pcie, APPL_INTR_STATUS_L1_0_0);
> +		appl_writel(pcie, val, APPL_INTR_STATUS_L1_0_0);
> +		if (val & APPL_INTR_STATUS_L1_0_0_HOT_RESET_DONE) {
> +			/* clear any stale PEX_RST interrupt */
> +			if (!kfifo_put(&pcie->event_fifo, EP_HOT_RST_DONE)) {
> +				dev_err(pcie->dev, "EVENT FIFO is full\n");
> +				return IRQ_HANDLED;
> +			}
> +			wake_up(&pcie->wq);
> +		}
> +		if (val & APPL_INTR_STATUS_L1_0_0_RDLH_LINK_UP_CHGED) {
> +			tmp = appl_readl(pcie, APPL_LINK_STATUS);
> +			if (tmp & APPL_LINK_STATUS_RDLH_LINK_UP) {
> +				dev_info(pcie->dev, "Link is up with Host\n");
> +				dw_pcie_ep_linkup(ep);
> +			}
> +		}
> +	} else if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {

Is it really the case that only one of
APPL_INTR_STATUS_L0_LINK_STATE_INT and
APPL_INTR_STATUS_L0_PCI_CMD_EN_INT can be set?

If it's possible that both could be set, maybe this should be
something like this?

  int spurious = 1;

  if (val & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
    ...
    spurious = 0;
  }
  if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {
    ...
    spurious = 0;
  }

  if (spurious) {
    dev_warn(...)
  }

> +		val = appl_readl(pcie, APPL_INTR_STATUS_L1_15);
> +		appl_writel(pcie, val, APPL_INTR_STATUS_L1_15);
> +		if (val & APPL_INTR_STATUS_L1_15_CFG_BME_CHGED) {
> +			if (!kfifo_put(&pcie->event_fifo, EP_BME_CHANGE)) {
> +				dev_err(pcie->dev, "EVENT FIFO is full\n");
> +				return IRQ_HANDLED;
> +			}
> +			wake_up(&pcie->wq);
> +		}
> +	} else {
> +		dev_warn(pcie->dev, "Random interrupt (STATUS = 0x%08X)\n",
> +			 val);
> +		appl_writel(pcie, val, APPL_INTR_STATUS_L0);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

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
> +			dev_warn(pcie->dev, "Invalid PCIe EP event\n");

Maybe include the invalid event value in the message?

> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
