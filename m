Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB93DF74
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 11:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfD2JaY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Apr 2019 05:30:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14407 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfD2JaY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Apr 2019 05:30:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc6c4110000>; Mon, 29 Apr 2019 02:29:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 29 Apr 2019 02:30:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 29 Apr 2019 02:30:22 -0700
Received: from [10.24.192.53] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Apr
 2019 09:30:19 +0000
Subject: Re: [PATCH V2 18/28] PCI: tegra: Program AFI_CACHE* registers only
 for Tegra20
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-19-mmaddireddy@nvidia.com> <20190426153219.GE19559@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <600692ae-2a0c-766a-1b8f-827a9c73db36@nvidia.com>
Date:   Mon, 29 Apr 2019 15:00:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426153219.GE19559@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556530193; bh=ZGEZE1KHFh43yFFb0G/XLs81RHxc9WF+/CenNWY4DJc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=jXBnd8yoQw9QUCl3JOPuiT1FJBpRO3JC+7i9C5J+oT+SxmOyIRgvqNGbOoEtaOWV2
         5rWRvT/eVpYYgHtAGNKhVyl5dyGuPDrv6TPnX3stVBfxpyYAcnSKVstmJgWkDUCIQh
         9LTjdOi/8H6I6S84Y3itSVOwz6mDEdF6BgMJpqa/Ndt5Jmn1mCxuDn8xOQ3q+ry4jz
         uUKpW6vvHavYVFGROv0/4vCUASUwFSosPV27gpbNdekW4mUSBnWtYExCiCJZ2SWKT3
         dQF8PvAVkmameH8SifNRkNWds9HNz30wpRBQbtnnPrWiy4HWDBfdeCwt3dzMn8fXSl
         +xxu7B3gFkPuA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 26-Apr-19 9:02 PM, Thierry Reding wrote:
> On Tue, Apr 23, 2019 at 02:58:15PM +0530, Manikanta Maddireddy wrote:
>> Cacheable upstream transactions are supported in Tegra20 and Tegra186 only.
>> AFI_CACHE* registers are available in Tegra20 to support cacheable upstream
>> transactions. In Tegra186, AFI_AXCACHE register is defined instead of
>> AFI_CACHE* to be in line with its MSS design. Therefore, program AFI_CACHE*
>> registers only for Tegra20.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> V2: Used soc variable for comparision instead of compatible string.
>>
>>  drivers/pci/controller/pci-tegra.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index f74930654443..9b841b0392ac 100644
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
> You need to squash the below into this patch. If I do that, then
> TrimSlice works again.
>
> Thierry
Thank you Thierry for verifying the series on T20 and T30.
I will take care of this comment in V3.
Please review other patches and provide Ack.

Manikanta
>
> --- >8 ---
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 7071fd026a80..fc61074f6886 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2530,6 +2530,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>   .program_deskew_time = false,
>   .raw_violation_fixup = false,
>   .update_fc_timer = false,
> + .has_cache_bars = true,
>   .ectl.enable = false,
>  };
>
> @@ -2558,6 +2559,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>   .program_deskew_time = false,
>   .raw_violation_fixup = false,
>   .update_fc_timer = false,
> + .has_cache_bars = false,
>   .ectl.enable = false,
>  };
>
> @@ -2581,6 +2583,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>   .program_deskew_time = false,
>   .raw_violation_fixup = true,
>   .update_fc_timer = false,
> + .has_cache_bars = false,
>   .ectl.enable = false,
>  };
>
> @@ -2604,6 +2607,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>   .program_deskew_time = true,
>   .raw_violation_fixup = false,
>   .update_fc_timer = true,
> + .has_cache_bars = false,
>   .ectl = {
>    .regs = {
>     .rp_ectl_2_r1 = 0x0000000f,
> @@ -2645,6 +2649,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>   .program_deskew_time = false,
>   .raw_violation_fixup = false,
>   .update_fc_timer = false,
> + .has_cache_bars = false,
>   .ectl.enable = false,
>  };
>

