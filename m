Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896BC4D10F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 16:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfFTO6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 10:58:01 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13866 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTO6B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 10:58:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0b9ef60000>; Thu, 20 Jun 2019 07:57:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 07:57:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 07:57:59 -0700
Received: from [10.24.70.135] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 14:57:53 +0000
Subject: Re: [PATCH V6 06/27] PCI: tegra: Add PCIe Gen2 link speed support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190618180206.4908-7-mmaddireddy@nvidia.com>
 <20190620143251.GB31996@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <d46fbde3-1e42-e7b6-8926-efb599ad335f@nvidia.com>
Date:   Thu, 20 Jun 2019 20:27:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620143251.GB31996@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561042679; bh=2S/ArD3L74xcVrtoGOwf8r/JIu/P3SRHFU4l7stm63M=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=q8smOu5BHToVrsT690tV4CUKDZBTnYS30PXuU3OiKsW3DDb/NsFMHrBD0VXJQiW07
         MygeNAWOoU11gJ+n+ymZInEPozfP7CqNOkQ4qJ829OydHJdLOCGuqQuOj3ghHjB2F0
         2/duAuTiTo3e48c1+6p1moQgh4H2ndlAkgq4u9+yi17nYXP/SI/P9dBp4jOKfhLzYm
         G5wMiryrvAmpXJLGJQxHPNs8SsnN/V51mCba4IzibEcdRhhbWvQ+GRFWpJ3fzS5PIA
         qj4Lj0OyrLmLfM1B8K8BhvXMNMOynZvOt4dOp3juUeGqQX7k8303FUgq4Qlnl2X5+f
         MEujO30z2i6YA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 20-Jun-19 8:02 PM, Lorenzo Pieralisi wrote:
> On Tue, Jun 18, 2019 at 11:31:45PM +0530, Manikanta Maddireddy wrote:
>> Tegra124, Tegra132, Tegra210 and Tegra186 support Gen2 link speed. After
>> PCIe link is up in Gen1, set target link speed as Gen2 and retrain link.
>> Link switches to Gen2 speed if Gen2 capable end point is connected, else
>> link stays in Gen1.
>>
>> Per PCIe 4.0r0.9 sec 7.6.3.7 implementation note, driver need to wait for
>> PCIe LTSSM to come back from recovery before retraining the link.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> ---
>> V6: No change
>>
>> V5: No change
>>
>> V4: No change
>>
>> V3: Added blank line after each while loop.
>>
>> V2: Changed "for loop" to "while", to make it compact and handled coding
>> style comments.
>>
>>  drivers/pci/controller/pci-tegra.c | 64 ++++++++++++++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 5e9fcef5f8eb..5d19067f7193 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -191,6 +191,8 @@
>>  #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
>>  #define  RP_LINK_CONTROL_STATUS_LINKSTAT_MASK	0x3fff0000
>>  
>> +#define RP_LINK_CONTROL_STATUS_2		0x000000b0
>> +
>>  #define PADS_CTL_SEL		0x0000009c
>>  
>>  #define PADS_CTL		0x000000a0
>> @@ -226,6 +228,7 @@
>>  #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
>>  
>>  #define PME_ACK_TIMEOUT 10000
>> +#define LINK_RETRAIN_TIMEOUT 100000 /* in usec */
>>  
>>  struct tegra_msi {
>>  	struct msi_controller chip;
>> @@ -2089,6 +2092,64 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
>>  	return false;
>>  }
>>  
>> +static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie)
>> +{
>> +	struct device *dev = pcie->dev;
>> +	struct tegra_pcie_port *port, *tmp;
>> +	ktime_t deadline;
>> +	u32 value;
>> +
>> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> And the reason to use the _safe version is ?
>
> Lorenzo

This function is called in probe and resume_noirq. list entry is deleted in
remove, I don't see any scenario where it can cause a race condition.
It is fine to drop _safe. I will fix it in next version.

Manikanta

>> +		/*
>> +		 * "Supported Link Speeds Vector" in "Link Capabilities 2"
>> +		 * is not supported by Tegra. tegra_pcie_change_link_speed()
>> +		 * is called only for Tegra chips which support Gen2.
>> +		 * So there no harm if supported link speed is not verified.
>> +		 */
>> +		value = readl(port->base + RP_LINK_CONTROL_STATUS_2);
>> +		value &= ~PCI_EXP_LNKSTA_CLS;
>> +		value |= PCI_EXP_LNKSTA_CLS_5_0GB;
>> +		writel(value, port->base + RP_LINK_CONTROL_STATUS_2);
>> +
>> +		/*
>> +		 * Poll until link comes back from recovery to avoid race
>> +		 * condition.
>> +		 */
>> +		deadline = ktime_add_us(ktime_get(), LINK_RETRAIN_TIMEOUT);
>> +
>> +		while (ktime_before(ktime_get(), deadline)) {
>> +			value = readl(port->base + RP_LINK_CONTROL_STATUS);
>> +			if ((value & PCI_EXP_LNKSTA_LT) == 0)
>> +				break;
>> +
>> +			usleep_range(2000, 3000);
>> +		}
>> +
>> +		if (value & PCI_EXP_LNKSTA_LT)
>> +			dev_warn(dev, "PCIe port %u link is in recovery\n",
>> +				 port->index);
>> +
>> +		/* Retrain the link */
>> +		value = readl(port->base + RP_LINK_CONTROL_STATUS);
>> +		value |= PCI_EXP_LNKCTL_RL;
>> +		writel(value, port->base + RP_LINK_CONTROL_STATUS);
>> +
>> +		deadline = ktime_add_us(ktime_get(), LINK_RETRAIN_TIMEOUT);
>> +
>> +		while (ktime_before(ktime_get(), deadline)) {
>> +			value = readl(port->base + RP_LINK_CONTROL_STATUS);
>> +			if ((value & PCI_EXP_LNKSTA_LT) == 0)
>> +				break;
>> +
>> +			usleep_range(2000, 3000);
>> +		}
>> +
>> +		if (value & PCI_EXP_LNKSTA_LT)
>> +			dev_err(dev, "failed to retrain link of port %u\n",
>> +				port->index);
>> +	}
>> +}
>> +
>>  static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>>  {
>>  	struct device *dev = pcie->dev;
>> @@ -2113,6 +2174,9 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>>  		tegra_pcie_port_disable(port);
>>  		tegra_pcie_port_free(port);
>>  	}
>> +
>> +	if (pcie->soc->has_gen2)
>> +		tegra_pcie_change_link_speed(pcie);
>>  }
>>  
>>  static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
>> -- 
>> 2.17.1
>>

