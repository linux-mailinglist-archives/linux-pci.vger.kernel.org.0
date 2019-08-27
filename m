Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A73D9F010
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 18:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfH0QY2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 12:24:28 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15202 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfH0QY2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 12:24:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d65593b0000>; Tue, 27 Aug 2019 09:24:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Aug 2019 09:24:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Aug 2019 09:24:26 -0700
Received: from [10.25.73.29] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 16:24:20 +0000
Subject: Re: [PATCH 6/6] PCI: tegra: Add support to enable slot regulators
To:     Andrew Murray <andrew.murray@arm.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190826073143.4582-1-vidyas@nvidia.com>
 <20190826073143.4582-7-vidyas@nvidia.com>
 <20190827154725.GP14582@e119886-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <91f8914a-22a9-8b7c-bc00-c309a21d83db@nvidia.com>
Date:   Tue, 27 Aug 2019 21:54:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827154725.GP14582@e119886-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566923067; bh=2HdnrU28EZ0UoDqd1XHS7RWTxi3+8RJrX0DXDhdTXkQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UOf5q/JTyE7cqbJ2RVqu81ZL65HIP/RvqM8b1wP0H1VXjJebSJDsJvXXdA3VfdA1x
         Jbr3ddj2il6lYfOFxuCYGJNMp6xxACUwmdB6GqACH8qZExBnD7xHVadBilMH29V0te
         uJdU/li30TESP1YmrqDsAKct4j8wbJuXi33QGvUzLVIz5/JxV1ctWzJOQ5fYnBhLJa
         i7DOxUfJkTiiqPq2+SQLT+4jzJXo0VEleuCsTH9fpqvQZ8l2EBajamhY3cFBEHMngJ
         L7QSsuDVebiATbOuUuGU/Ze28NuAV2p2oj/cLWB2uG80hgKBVfkQxVk5Z/q6wmv9QI
         xXMNSMo/Z0bqA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/27/2019 9:17 PM, Andrew Murray wrote:
> On Mon, Aug 26, 2019 at 01:01:43PM +0530, Vidya Sagar wrote:
>> Add support to get regulator information of 3.3V and 12V supplies of a PCIe
>> slot from the respective controller's device-tree node and enable those
>> supplies. This is required in platforms like p2972-0000 where the supplies
>> to x16 slot owned by C5 controller need to be enabled before attempting to
>> enumerate the devices.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 65 ++++++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 8a27b25893c9..97de2151a738 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -278,6 +278,8 @@ struct tegra_pcie_dw {
>>   	u32 aspm_l0s_enter_lat;
>>   
>>   	struct regulator *pex_ctl_supply;
>> +	struct regulator *slot_ctl_3v3;
>> +	struct regulator *slot_ctl_12v;
>>   
>>   	unsigned int phy_count;
>>   	struct phy **phys;
>> @@ -1047,6 +1049,59 @@ static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
>>   	}
>>   }
>>   
>> +static void tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *pcie)
>> +{
>> +	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
>> +	if (IS_ERR(pcie->slot_ctl_3v3))
>> +		pcie->slot_ctl_3v3 = NULL;
>> +
>> +	pcie->slot_ctl_12v = devm_regulator_get_optional(pcie->dev, "vpcie12v");
>> +	if (IS_ERR(pcie->slot_ctl_12v))
>> +		pcie->slot_ctl_12v = NULL;
> 
> Do these need to take into consideration -EPROBE_DEFER?
Since these are devm_* APIs, isn't it taken care of automatically?

> 
> Thanks,
> 
> Andrew Murray
> 
>> +}
>> +
>> +static int tegra_pcie_enable_slot_regulators(struct tegra_pcie_dw *pcie)
>> +{
>> +	int ret;
>> +
>> +	if (pcie->slot_ctl_3v3) {
>> +		ret = regulator_enable(pcie->slot_ctl_3v3);
>> +		if (ret < 0) {
>> +			dev_err(pcie->dev,
>> +				"Failed to enable 3V3 slot supply: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (pcie->slot_ctl_12v) {
>> +		ret = regulator_enable(pcie->slot_ctl_12v);
>> +		if (ret < 0) {
>> +			dev_err(pcie->dev,
>> +				"Failed to enable 12V slot supply: %d\n", ret);
>> +			if (pcie->slot_ctl_3v3)
>> +				regulator_disable(pcie->slot_ctl_3v3);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * According to PCI Express Card Electromechanical Specification
>> +	 * Revision 1.1, Table-2.4, T_PVPERL (Power stable to PERST# inactive)
>> +	 * should be a minimum of 100ms.
>> +	 */
>> +	msleep(100);
>> +
>> +	return 0;
>> +}
>> +
>> +static void tegra_pcie_disable_slot_regulators(struct tegra_pcie_dw *pcie)
>> +{
>> +	if (pcie->slot_ctl_12v)
>> +		regulator_disable(pcie->slot_ctl_12v);
>> +	if (pcie->slot_ctl_3v3)
>> +		regulator_disable(pcie->slot_ctl_3v3);
>> +}
>> +
>>   static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
>>   					bool en_hw_hot_rst)
>>   {
>> @@ -1060,6 +1115,10 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
>>   		return ret;
>>   	}
>>   
>> +	ret = tegra_pcie_enable_slot_regulators(pcie);
>> +	if (ret < 0)
>> +		goto fail_slot_reg_en;
>> +
>>   	ret = regulator_enable(pcie->pex_ctl_supply);
>>   	if (ret < 0) {
>>   		dev_err(pcie->dev, "Failed to enable regulator: %d\n", ret);
>> @@ -1142,6 +1201,8 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
>>   fail_core_clk:
>>   	regulator_disable(pcie->pex_ctl_supply);
>>   fail_reg_en:
>> +	tegra_pcie_disable_slot_regulators(pcie);
>> +fail_slot_reg_en:
>>   	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
>>   
>>   	return ret;
>> @@ -1174,6 +1235,8 @@ static int __deinit_controller(struct tegra_pcie_dw *pcie)
>>   		return ret;
>>   	}
>>   
>> +	tegra_pcie_disable_slot_regulators(pcie);
>> +
>>   	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
>>   	if (ret) {
>>   		dev_err(pcie->dev, "Failed to disable controller %d: %d\n",
>> @@ -1372,6 +1435,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>>   		return ret;
>>   	}
>>   
>> +	tegra_pcie_get_slot_regulators(pcie);
>> +
>>   	pcie->pex_ctl_supply = devm_regulator_get(dev, "vddio-pex-ctl");
>>   	if (IS_ERR(pcie->pex_ctl_supply)) {
>>   		dev_err(dev, "Failed to get regulator: %ld\n",
>> -- 
>> 2.17.1
>>

