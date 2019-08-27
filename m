Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3D9EF29
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 17:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfH0Pkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 11:40:37 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14658 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfH0Pkh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 11:40:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d654ef40000>; Tue, 27 Aug 2019 08:40:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Aug 2019 08:40:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Aug 2019 08:40:36 -0700
Received: from [10.25.73.29] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 15:40:31 +0000
Subject: Re: [PATCH 3/6] PCI: tegra: Add support to configure sideband pins
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
 <20190826073143.4582-4-vidyas@nvidia.com>
 <20190827153029.GO14582@e119886-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <9fe2fc1b-8fdf-e8cf-e5fd-36b536b28889@nvidia.com>
Date:   Tue, 27 Aug 2019 21:10:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827153029.GO14582@e119886-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566920436; bh=RALnJDAwbfk7yCMD7+TxIj1eEVtiHxWVO6vHKCUuBi8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mvMWZvETEIcF0IIS5rVUnIAxOSb5My1zfvk5h7A3mQQRyRJA4Mdtbv6b9G5zO32lA
         j4AUZpoFq6IL2McN7KJ1T10QB5rfNho12CWdDXbE7EbjkJLkNThxJc/k5twNPxFUJr
         WBNOTYWNTx5XwLJGgGxHVPJBPv0M8YgyeunmlqJXhHNvYGLNp5keRL6c5m7GuLG0sx
         /KiNJ69Q9Kp2WpBjHCNHcteKBDy48ilm9DxtyKep3np4Oq26DMi7/E7pMhZ9pV03yV
         wE4YjC5voMooSW8OPx6ScwI/mkncEJ/0FcUyFU7wPjj/XM/TFmvt/IuZe/YJPzX8+4
         dPeKc4wmiaIHw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/27/2019 9:00 PM, Andrew Murray wrote:
> On Mon, Aug 26, 2019 at 01:01:40PM +0530, Vidya Sagar wrote:
>> Add support to configure sideband signal pins when information is present
>> in respective controller's device-tree node.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index fc0dbeb31d78..8a27b25893c9 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1308,6 +1308,12 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>>   		return ret;
>>   	}
>>   
>> +	ret = pinctrl_pm_select_default_state(pcie->dev);
>> +	if (ret < 0) {
>> +		dev_err(pcie->dev, "Failed to configure sideband pins\n");
> 
> I think you can just use dev instead of pcie->dev here.
Yup. I can use just 'dev' here.

> 
>> +		return ret;
> 
> Don't you need to pm_runtime_put_sync and pm_runtime_disable here?
Yup. Thanks for catching it. I'll address it in next patch series.

> 
> Thanks,
> 
> Andrew Murray
> 
>> +	}
>> +
>>   	tegra_pcie_init_controller(pcie);
>>   
>>   	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
>> -- 
>> 2.17.1
>>

