Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D7397DF0
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfHUPBu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 11:01:50 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18390 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfHUPBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 11:01:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5d5cde0000>; Wed, 21 Aug 2019 08:01:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2019 08:01:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Aug 2019 08:01:49 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 15:01:48 +0000
Received: from [10.25.74.119] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 15:01:45 +0000
Subject: Re: [PATCH][next] PCI: tegra: tegra194: fix phy_count less than zero
 check
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Colin King <colin.king@canonical.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190821120123.14223-1-colin.king@canonical.com>
 <20190821140520.GA691@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <b9f4dc94-a3d6-5748-128d-9df6dc990eb8@nvidia.com>
Date:   Wed, 21 Aug 2019 20:31:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821140520.GA691@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566399710; bh=pVlgGlKM4Jh1fIne7Jt+bEk9BU5YPhXW/fJ0EL5D3i0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ieAJQEapTwKUlGo+Q8ZuJRxc3YyGSLmWch2L8LcayRGH5N0ErNoOpMcrvwQHFPZG1
         ufkTAF8FE2/xnJakffaGEHr4XV4cfPpFpV75oQ2TZGd6EbEMNXqXY3RWmwUj5ctkYM
         o6FrcfLw+K0XjJZV7I3R38nNpMyx8SkbPVFBIRZa1lXVAiYT61pI6IhUXjUdDr9Wn0
         6/y6mHm8cCQLQSq+alPn9TFftPTcMCEs/bIlOqN3fI7TpzVS+M5FL+qgz++YxzllEJ
         ka43K4LBbsYZKHcAmQtTckmwY54/ZYkH7VpcLDFvv0U6x0sJuWSfGH4cdmDi21fX8u
         TMThaA3dSQwDw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/21/2019 7:35 PM, Lorenzo Pieralisi wrote:
> On Wed, Aug 21, 2019 at 01:01:23PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The check for pcie->phy_count < 0 is always false because phy_count
>> is an unsigned int and can never be less than zero. Fix this by
>> assigning ret to the return from of_property_count_strings and
>> checking if this is less than zero instead.
>>
>> Addresses-Coverity: ("Dead code")
>> Fixes: 6404441c8e13 ("PCI: tegra: Add Tegra194 PCIe support")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> Squashed in the original commit (it is not merged yet), thanks
> for reporting it.
Thanks Colin for catching it and pushing a fix also.
Thanks Lorenzo for merging it.
Apologies for missing this in my patch series.

> 
> Lorenzo
> 
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index fc0dbeb31d78..b47ea3e68303 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -969,12 +969,13 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>>   		return ret;
>>   	}
>>   
>> -	pcie->phy_count = of_property_count_strings(np, "phy-names");
>> -	if (pcie->phy_count < 0) {
>> +	ret = of_property_count_strings(np, "phy-names");
>> +	if (ret < 0) {
>>   		dev_err(pcie->dev, "Failed to find PHY entries: %d\n",
>> -			pcie->phy_count);
>> -		return pcie->phy_count;
>> +			ret);
>> +		return ret;
>>   	}
>> +	pcie->phy_count = ret;
>>   
>>   	if (of_property_read_bool(np, "nvidia,update-fc-fixup"))
>>   		pcie->update_fc_fixup = true;
>> -- 
>> 2.20.1
>>

