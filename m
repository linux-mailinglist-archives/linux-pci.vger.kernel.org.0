Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7962F13986D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 19:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgAMSNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 13:13:04 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4593 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgAMSNE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jan 2020 13:13:04 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1cb31b0000>; Mon, 13 Jan 2020 10:12:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 10:13:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jan 2020 10:13:03 -0800
Received: from [10.24.37.48] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 18:12:58 +0000
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
 <20200103124404.20662-4-vidyas@nvidia.com> <20200106131416.GD1955714@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <e4a806f5-6efb-d221-7627-a50a427bea99@nvidia.com>
Date:   Mon, 13 Jan 2020 23:42:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106131416.GD1955714@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578939163; bh=nVROaRvnp+B2JlV9vIKYl44RY+sBl1DYcWo1xIkZvMU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CZeBN5IxJcvyTspS32vk9DBSShHna0nja8hQ3ot8GeuUS7AxUrSC2xuRJ11SDT2p8
         e69CEpHSvcxcNcQqaaGfVgbvf8roQTtxPxeDTKoS9pbbpz1hhAu7m801mL8cPLWnhg
         +zvTWRHw2OufX2C4cmV/pN7jB85RTsSj2ZARQa8Z/MMtO8hA68DBlXqSkPCIM0q2pY
         4wgZUBGGbWGKvWQLD8XyIsHzdFfDhe64R0l4xD2JpKcqW2OzG4PWjpJb6D3PJGu6Bp
         6vD8No5Fyt1dJOB5nPAJAHVBsDOZh5CJkraIHB8Q+cZmmLKxTjcHZ2uz4P1LpY40B4
         +Yno6Ah18fFMw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/6/20 6:44 PM, Thierry Reding wrote:
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
> [...]
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index cbe95f0ea0ca..6621ac79efee 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> [...]
>> @@ -1427,8 +1620,553 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
> [...]
>> +static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
>> +				struct platform_device *pdev)
>> +{
> [...]
>> +	ret = devm_request_irq(dev, pcie->pex_rst_irq,
>> +			       tegra_pcie_ep_pex_rst_irq,
>> +			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> +			       name, (void *)pcie);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to request IRQ for PERST: %d\n", ret);
>> +		return ret;
>> +	}
>> +	disable_irq(pcie->pex_rst_irq);
> 
> I just came across this while reviewing another patch: it looks like a
> better way to handle "disabled by default" interrupts is to do this:
> 
> 	irq_set_status_flags(rtc->irq, IRQ_NOAUTOEN);
> 
> before calling devm_request_irq(). See here for an example:
> 
> 	http://patchwork.ozlabs.org/patch/1217944/
I'll take care of it.

Thanks for the review.
Vidya Sagar

> 
> Thierry
> 
