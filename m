Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 002E410D60A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 14:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfK2NXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 08:23:02 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19963 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfK2NXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2019 08:23:01 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de11bb20000>; Fri, 29 Nov 2019 05:22:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 29 Nov 2019 05:22:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 29 Nov 2019 05:22:54 -0800
Received: from [10.25.75.74] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Nov
 2019 13:22:50 +0000
Subject: Re: [PATCH 3/6] PCI: tegra: Add support for PCIe endpoint mode in
 Tegra194
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <andrew.murray@arm.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191126213718.GA185422@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <7298f15d-1745-e5c9-2d08-1235a27244ae@nvidia.com>
Date:   Fri, 29 Nov 2019 18:52:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126213718.GA185422@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575033778; bh=7gO/CXj0wvWwogWev3Z+fNC4tNy+uDv47vsz0nrrl5w=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Q1QlqQj9jsPpnd6pf7C27/BelCW4RWZRzBi2KaiDdVgmQRtcmInnvBKkDE6Iq/jDa
         3eEtcoGbjwFqH0XNmV+7oElfREV+vkp/uQUYaFN8MjIiVD/X1ZjwDEQWOShO+R+Krd
         s0ELF/Yf578H0G6uMulK4hnMAXda5t1DwKz4j+AyJA5/sbYgIY6KVH82ppVtNN3ybN
         MfmKAM5lE7RX5Q85hZMaus6bD4MIEM+bTbL5jSUereIJm5FxCXk9FLvlqSi6B8mzHc
         KblxQObo77nRmb3bfFCnDhQUKusMgt67Q1Qdqvaia3kHhyOEpzmxYR5NVWzR0n67XT
         YH7xjnMHHJ/JA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/27/2019 3:07 AM, Bjorn Helgaas wrote:
> On Fri, Nov 22, 2019 at 04:15:02PM +0530, Vidya Sagar wrote:
>> Add support for the endpoint mode of Synopsys DesignWare core based
>> dual mode PCIe controllers present in Tegra194 SoC.
> 
>> +static irqreturn_t tegra_pcie_ep_irq_handler(struct tegra_pcie_dw *pcie)
>> +{
>> +	struct dw_pcie_ep *ep = &pcie->pci.ep;
>> +	u32 val, tmp;
>> +
>> +	val = appl_readl(pcie, APPL_INTR_STATUS_L0);
>> +	if (val & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
>> +		val = appl_readl(pcie, APPL_INTR_STATUS_L1_0_0);
>> +		appl_writel(pcie, val, APPL_INTR_STATUS_L1_0_0);
>> +		if (val & APPL_INTR_STATUS_L1_0_0_HOT_RESET_DONE) {
>> +			/* clear any stale PEX_RST interrupt */
>> +			if (!kfifo_put(&pcie->event_fifo, EP_HOT_RST_DONE)) {
>> +				dev_err(pcie->dev, "EVENT FIFO is full\n");
>> +				return IRQ_HANDLED;
>> +			}
>> +			wake_up(&pcie->wq);
>> +		}
>> +		if (val & APPL_INTR_STATUS_L1_0_0_RDLH_LINK_UP_CHGED) {
>> +			tmp = appl_readl(pcie, APPL_LINK_STATUS);
>> +			if (tmp & APPL_LINK_STATUS_RDLH_LINK_UP) {
>> +				dev_info(pcie->dev, "Link is up with Host\n");
>> +				dw_pcie_ep_linkup(ep);
>> +			}
>> +		}
>> +	} else if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {
> 
> Is it really the case that only one of
> APPL_INTR_STATUS_L0_LINK_STATE_INT and
> APPL_INTR_STATUS_L0_PCI_CMD_EN_INT can be set?
Not really.

> 
> If it's possible that both could be set, maybe this should be
> something like this?
> 
>    int spurious = 1;
> 
>    if (val & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
>      ...
>      spurious = 0;
>    }
>    if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {
>      ...
>      spurious = 0;
>    }
> 
>    if (spurious) {
>      dev_warn(...)
>    }
I'll take care of this in the next patch series.

> 
>> +		val = appl_readl(pcie, APPL_INTR_STATUS_L1_15);
>> +		appl_writel(pcie, val, APPL_INTR_STATUS_L1_15);
>> +		if (val & APPL_INTR_STATUS_L1_15_CFG_BME_CHGED) {
>> +			if (!kfifo_put(&pcie->event_fifo, EP_BME_CHANGE)) {
>> +				dev_err(pcie->dev, "EVENT FIFO is full\n");
>> +				return IRQ_HANDLED;
>> +			}
>> +			wake_up(&pcie->wq);
>> +		}
>> +	} else {
>> +		dev_warn(pcie->dev, "Random interrupt (STATUS = 0x%08X)\n",
>> +			 val);
>> +		appl_writel(pcie, val, APPL_INTR_STATUS_L0);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
>> +static int tegra_pcie_ep_work_thread(void *p)
>> +{
>> +	struct tegra_pcie_dw *pcie = (struct tegra_pcie_dw *)p;
>> +	u32 event;
>> +
>> +	while (true) {
>> +		wait_event_interruptible(pcie->wq,
>> +					 !kfifo_is_empty(&pcie->event_fifo));
>> +
>> +		if (kthread_should_stop())
>> +			break;
>> +
>> +		if (!kfifo_get(&pcie->event_fifo, &event)) {
>> +			dev_warn(pcie->dev, "EVENT FIFO is empty\n");
>> +			continue;
>> +		}
>> +
>> +		switch (event) {
>> +		case EP_PEX_RST_DEASSERT:
>> +			dev_info(pcie->dev, "EVENT: EP_PEX_RST_DEASSERT\n");
>> +			pex_ep_event_pex_rst_deassert(pcie);
>> +			break;
>> +
>> +		case EP_PEX_RST_ASSERT:
>> +			dev_info(pcie->dev, "EVENT: EP_PEX_RST_ASSERT\n");
>> +			pex_ep_event_pex_rst_assert(pcie);
>> +			break;
>> +
>> +		case EP_HOT_RST_DONE:
>> +			dev_info(pcie->dev, "EVENT: EP_HOT_RST_DONE\n");
>> +			pex_ep_event_hot_rst_done(pcie);
>> +			break;
>> +
>> +		case EP_BME_CHANGE:
>> +			dev_info(pcie->dev, "EVENT: EP_BME_CHANGE\n");
>> +			pex_ep_event_bme_change(pcie);
>> +			break;
>> +
>> +		case EP_EVENT_EXIT:
>> +			dev_info(pcie->dev, "EVENT: EP_EVENT_EXIT\n");
>> +			return 0;
>> +
>> +		default:
>> +			dev_warn(pcie->dev, "Invalid PCIe EP event\n");
> 
> Maybe include the invalid event value in the message?
I'll take care of this in the next patch series

> 
>> +			break;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}

