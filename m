Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56184D3DF
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 18:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfFTQgG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 12:36:06 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8158 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTQgG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 12:36:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0bb5f40000>; Thu, 20 Jun 2019 09:36:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 09:36:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Jun 2019 09:36:04 -0700
Received: from [10.24.70.135] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 16:36:00 +0000
Subject: Re: [PATCH V6 18/27] PCI: tegra: Program AFI_CACHE* registers only
 for Tegra20
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190618180206.4908-19-mmaddireddy@nvidia.com>
 <20190620162638.GA18771@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <b90ebb2c-03b2-b7c0-7a70-02dfed00de3a@nvidia.com>
Date:   Thu, 20 Jun 2019 22:05:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620162638.GA18771@e121166-lin.cambridge.arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561048564; bh=NI9/AKwnnR/ZexKWfXN0pUt6xoymGwAgrazJNTj4P4Y=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=B26v4Uo0SfFWQ2zmrzd78q9vpp+4IqwC8Phg9BvgDGJHRtVkBPT/3PuVsGQK7Dk3j
         2N9JvW5eT0ZT934BZIBNfL1rjhW5qzAjdt2CmU/sLglGk9gIzUccU36BY5lwopIc6/
         vLILYQ5MDxx/PTaJ8jGAqbxTeQItRKaf3rQ99zdfhKqaZkBbSTr+hbBWBkhfwKYCN4
         8KNwd34KICd2MCxx3j6bMKuIIymnFXAxgXN7MV9AzuXio/gWaYw0jujLi707yES8WS
         JSIfq9RO+KJR1KrX7hLI8dJTw0MmeWppJBOmGalk0ccsyjRaiPo70/t7x3v5WRVIph
         1UMCHyolpNX2A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 20-Jun-19 9:56 PM, Lorenzo Pieralisi wrote:
> On Tue, Jun 18, 2019 at 11:31:57PM +0530, Manikanta Maddireddy wrote:
>> Cacheable upstream transactions are supported in Tegra20 and Tegra186 only.
>> AFI_CACHE* registers are available in Tegra20 to support cacheable upstream
>> transactions. In Tegra186, AFI_AXCACHE register is defined instead of
>> AFI_CACHE* to be in line with its MSS design. Therefore, program AFI_CACHE*
> What's an MSS ?
>
> Lorenzo

Memory subsystem.
Sorry for using acronym, will you able to update the commit log before applying
the patch?

Manikanta

>
>> registers only for Tegra20.
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
>> V3: Initialized has_cache_bars variable for each soc data structure.
>>
>> V2: Used soc variable for comparision instead of compatible string.
>>
>>  drivers/pci/controller/pci-tegra.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 3d9028cecc18..a746d963ca36 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -323,6 +323,7 @@ struct tegra_pcie_soc {
>>  	bool program_deskew_time;
>>  	bool raw_violation_fixup;
>>  	bool update_fc_timer;
>> +	bool has_cache_bars;
>>  	struct {
>>  		struct {
>>  			u32 rp_ectl_2_r1;
>> @@ -932,11 +933,13 @@ static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
>>  	afi_writel(pcie, 0, AFI_AXI_BAR5_SZ);
>>  	afi_writel(pcie, 0, AFI_FPCI_BAR5);
>>  
>> -	/* map all upstream transactions as uncached */
>> -	afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
>> -	afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
>> -	afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
>> -	afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
>> +	if (pcie->soc->has_cache_bars) {
>> +		/* map all upstream transactions as uncached */
>> +		afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
>> +		afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
>> +		afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
>> +		afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
>> +	}
>>  
>>  	/* MSI translations are setup only when needed */
>>  	afi_writel(pcie, 0, AFI_MSI_FPCI_BAR_ST);
>> @@ -2441,6 +2444,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>>  	.program_deskew_time = false,
>>  	.raw_violation_fixup = false,
>>  	.update_fc_timer = false,
>> +	.has_cache_bars = true,
>>  	.ectl.enable = false,
>>  };
>>  
>> @@ -2469,6 +2473,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>>  	.program_deskew_time = false,
>>  	.raw_violation_fixup = false,
>>  	.update_fc_timer = false,
>> +	.has_cache_bars = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> @@ -2492,6 +2497,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>>  	.program_deskew_time = false,
>>  	.raw_violation_fixup = true,
>>  	.update_fc_timer = false,
>> +	.has_cache_bars = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> @@ -2515,6 +2521,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>>  	.program_deskew_time = true,
>>  	.raw_violation_fixup = false,
>>  	.update_fc_timer = true,
>> +	.has_cache_bars = false,
>>  	.ectl = {
>>  		.regs = {
>>  			.rp_ectl_2_r1 = 0x0000000f,
>> @@ -2555,6 +2562,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>>  	.program_deskew_time = false,
>>  	.raw_violation_fixup = false,
>>  	.update_fc_timer = false,
>> +	.has_cache_bars = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> -- 
>> 2.17.1
>>

