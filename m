Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376C313986A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 19:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgAMSMp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 13:12:45 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4576 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgAMSMp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jan 2020 13:12:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1cb3080000>; Mon, 13 Jan 2020 10:12:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 10:12:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jan 2020 10:12:43 -0800
Received: from [10.24.37.48] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 18:12:39 +0000
Subject: Re: Re: [PATCH V2 3/5] PCI: tegra: Add support for PCIe endpoint mode
 in Tegra194
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <jonathanh@nvidia.com>,
        <andrew.murray@arm.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200103124404.20662-1-vidyas@nvidia.com>
 <20200103124404.20662-4-vidyas@nvidia.com> <20200106130259.GB1955714@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <108bcf03-c11c-c579-821d-e5ec167ee47b@nvidia.com>
Date:   Mon, 13 Jan 2020 23:42:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106130259.GB1955714@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578939144; bh=sIp4Z4GnMKwRgQ7sFUw0bFQLq84ZbPgvUNhydtjGb9I=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=L/iGmts/kG38pHg3U8H7+Lf2H4xcqkHOYSeAY29AX0CHO2Eq1DWnjRBjvEPaJwPjR
         oeaGS3zzQWqA5Tmq2RBX1pWXAS1OkFj69V3RONO5/JR5LHeStHoYxaorQVjjMwRIt/
         KYSbXikM13AC6vn9H3SonqycWADdhkyxlPYPN7Cf4AlHKwwNSoXl3BttBgAESbyrdg
         JgRN5EqOQuAjx1Fe3ripLuVvlMhYg+doZ3Mhl+A33PdKBhkGQCGLkxsd0uoYL4mTvu
         535yZZGDtKCbgnjv+oRx830Nf04Vnioy9gjeAoGZwO8NVopQi/TNVLc2mtvKPFUSOd
         1KuH/jwRkdSeg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/6/20 6:32 PM, Thierry Reding wrote:
> On Fri, Jan 03, 2020 at 06:14:02PM +0530, Vidya Sagar wrote:
>> Add support for the endpoint mode of Synopsys DesignWare core based
>> dual mode PCIe controllers present in Tegra194 SoC.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V2:
>> * Addressed Bjorn's review comments
>> * Made changes as part of addressing review comments for other patches
>>
>>   drivers/pci/controller/dwc/Kconfig         |  30 +-
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 782 ++++++++++++++++++++-
>>   2 files changed, 796 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> [...]
>> @@ -411,11 +466,66 @@ static irqreturn_t tegra_pcie_rp_irq_handler(struct tegra_pcie_dw *pcie)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> +static irqreturn_t tegra_pcie_ep_irq_handler(struct tegra_pcie_dw *pcie)
>> +{
>> +	struct dw_pcie_ep *ep = &pcie->pci.ep;
>> +	int spurious = 1;
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
> 
> Overall this patch looks a little cluttered. A few blank lines before
> and after (or between) block statements would help make this more
> readable, in my opinion.
Done.

> 
>> +		if (val & APPL_INTR_STATUS_L1_0_0_RDLH_LINK_UP_CHGED) {
>> +			tmp = appl_readl(pcie, APPL_LINK_STATUS);
>> +			if (tmp & APPL_LINK_STATUS_RDLH_LINK_UP) {
>> +				dev_info(pcie->dev, "Link is up with Host\n");
> 
> Do we want this to be an info message? Looks to me like this is mostly
> useful for debug purposes, as a quick way to check if the link is up.
> For production use, this would perhaps be better to expose as a sysfs
> attribute so that userspace can query it at runtime rather than search
> through kernel logs.
I changed it to dev_dbg message.

> 
>> +				dw_pcie_ep_linkup(ep);
>> +			}
>> +		}
>> +		spurious = 0;
>> +	}
>> +
>> +	if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {
>> +		val = appl_readl(pcie, APPL_INTR_STATUS_L1_15);
>> +		appl_writel(pcie, val, APPL_INTR_STATUS_L1_15);
>> +		if (val & APPL_INTR_STATUS_L1_15_CFG_BME_CHGED) {
>> +			if (!kfifo_put(&pcie->event_fifo, EP_BME_CHANGE)) {
>> +				dev_err(pcie->dev, "EVENT FIFO is full\n");
>> +				return IRQ_HANDLED;
>> +			}
>> +			wake_up(&pcie->wq);
>> +		}
>> +		spurious = 0;
>> +	}
>> +
>> +	if (spurious) {
>> +		dev_warn(pcie->dev, "Random interrupt (STATUS = 0x%08X)\n",
>> +			 val);
>> +		appl_writel(pcie, val, APPL_INTR_STATUS_L0);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>   static irqreturn_t tegra_pcie_irq_handler(int irq, void *arg)
>>   {
>>   	struct tegra_pcie_dw *pcie = arg;
>>   
>> -	return tegra_pcie_rp_irq_handler(pcie);
>> +	if (pcie->mode == DW_PCIE_RC_TYPE)
>> +		return tegra_pcie_rp_irq_handler(pcie);
>> +	else if (pcie->mode == DW_PCIE_EP_TYPE)
>> +		return tegra_pcie_ep_irq_handler(pcie);
>> +
>> +	return IRQ_NONE;
>>   }
> 
> We already know at probe time whether the controller is in root complex
> or endpoint mode, right? Couldn't we just install the correct handler
> rather than multiplex here? It's not a very big deal, but given that
> these are interrupts, avoiding the additional indirection might be a
> good idea.
Done.

> 
> [...]
>> @@ -986,6 +1115,42 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>>   	pcie->enable_cdm_check =
>>   		of_property_read_bool(np, "snps,enable-cdm-check");
>>   
>> +	if (pcie->mode == DW_PCIE_RC_TYPE)
>> +		return 0;
>> +
>> +	/* Endpoint mode specific DT entries */
>> +	name = devm_kasprintf(pcie->dev, GFP_KERNEL,
>> +			      "tegra_pcie_%u_pex_rst_gpio", pcie->cid);
>> +	if (!name) {
>> +		dev_err(pcie->dev, "Failed to create PERST GPIO string\n");
>> +		return -ENOMEM;
>> +	}
>> +	pcie->pex_rst_gpiod = devm_gpiod_get_from_of_node(pcie->dev, np,
> 
> If np == pcie->dev.of_node, you can simply use devm_gpiod_get() here,
> can't you?
Done.

> 
> [...]
>> +static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
>> +{
>> +	u32 val = 0;
> 
> The initialization here seems unnecessary.
Done.

> 
> [...]
>> +static int tegra_pcie_ep_raise_legacy_irq(struct tegra_pcie_dw *pcie, u16 irq)
>> +{
>> +	/* Tegra194 supports only INTA */
>> +	if (irq > 1)
>> +		return -EINVAL;
>> +
>> +	appl_writel(pcie, 1, APPL_LEGACY_INTX);
>> +	mdelay(1);
> 
> Spinning for 1 ms these days is quite a lot. Does this have to be a busy
> loop or could you use something like usleep_range(1000, 2000) to allow
> the CPU to do something else in the meantime?
> 
> Also, does the legacy INTX pulse have to be a whole millisecond wide? Or
> could this be shorter? A one millisecond pulse implies a maximum of 1000
> interrupts per second, which seems a bit low.
1 ms is what all the other implementations also are using and they are 
using mdelay also :( . But, I think this doesn't have to be a busy loop 
and I'll change it to usleep_range(1000, 2000).

> 
>> @@ -1440,6 +2178,12 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>>   	int ret;
>>   	u32 i;
>>   
>> +	match = of_match_device(of_match_ptr(tegra_pcie_dw_of_match), dev);
>> +	if (!match)
>> +		return -EINVAL;
>> +
>> +	data = (struct tegra_pcie_dw_of_data *)match->data;
> 
> of_device_get_match_data()?
Done.

> 
>> +
>>   	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>>   	if (!pcie)
>>   		return -ENOMEM;
>> @@ -1449,6 +2193,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>>   	pci->ops = &tegra_dw_pcie_ops;
>>   	pp = &pci->pp;
>>   	pcie->dev = &pdev->dev;
>> +	pcie->mode = (enum dw_pcie_device_mode)data->mode;
>>   
>>   	ret = tegra_pcie_dw_parse_dt(pcie);
>>   	if (ret < 0) {
>> @@ -1462,6 +2207,9 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>>   		return ret;
>>   	}
>>   
>> +	if (pcie->pex_refclk_sel_gpiod)
>> +		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 1);
>> +
>>   	pcie->pex_ctl_supply = devm_regulator_get(dev, "vddio-pex-ctl");
>>   	if (IS_ERR(pcie->pex_ctl_supply)) {
>>   		ret = PTR_ERR(pcie->pex_ctl_supply);
>> @@ -1570,11 +2318,24 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>>   
>>   	platform_set_drvdata(pdev, pcie);
>>   
>> -	ret = tegra_pcie_config_rp(pcie);
>> -	if (ret && ret != -ENOMEDIUM)
>> -		goto fail;
>> -	else
>> -		return 0;
>> +	switch (pcie->mode) {
>> +	case DW_PCIE_RC_TYPE:
>> +		ret = tegra_pcie_config_rp(pcie);
>> +		if (ret && ret != -ENOMEDIUM)
>> +			goto fail;
>> +		else
>> +			return 0;
>> +		break;
>> +
>> +	case DW_PCIE_EP_TYPE:
>> +		ret = tegra_pcie_config_ep(pcie, pdev);
>> +		if (ret < 0)
>> +			goto fail;
>> +		break;
>> +
>> +	default:
>> +		dev_err(dev, "Invalid PCIe device type %d\n", pcie->mode);
>> +	}
>>   
>>   fail:
>>   	tegra_bpmp_put(pcie->bpmp);
>> @@ -1593,6 +2354,8 @@ static int tegra_pcie_dw_remove(struct platform_device *pdev)
>>   	pm_runtime_put_sync(pcie->dev);
>>   	pm_runtime_disable(pcie->dev);
>>   	tegra_bpmp_put(pcie->bpmp);
>> +	if (pcie->pex_refclk_sel_gpiod)
>> +		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
>>   
>>   	return 0;
>>   }
>> @@ -1697,13 +2460,6 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
>>   	__deinit_controller(pcie);
>>   }
>>   
>> -static const struct of_device_id tegra_pcie_dw_of_match[] = {
>> -	{
>> -		.compatible = "nvidia,tegra194-pcie",
>> -	},
>> -	{},
>> -};
>> -
> 
> No need to move this around if you use of_device_get_match_data().
Yes.

Thanks for the review.
Vidya Sagar
> 
> Thierry
> 
>>   static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
>>   	.suspend_late = tegra_pcie_dw_suspend_late,
>>   	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
>> -- 
>> 2.17.1
>>
