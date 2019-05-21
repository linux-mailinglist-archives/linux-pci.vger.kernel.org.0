Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736FF25661
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 19:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfEUROO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 13:14:14 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3463 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUROO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 13:14:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce431e40002>; Tue, 21 May 2019 10:14:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 10:14:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 May 2019 10:14:12 -0700
Received: from [10.25.72.115] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 17:14:06 +0000
Subject: Re: [PATCH V7 05/15] PCI: dwc: Add ext config space capability search
 API
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-6-vidyas@nvidia.com> <20190521103629.GE29166@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <d70ac7e8-d04e-5195-3808-fca520ad23f6@nvidia.com>
Date:   Tue, 21 May 2019 22:44:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521103629.GE29166@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558458852; bh=BcyBWuXsiZPLocS6gKpgICDF6NfMYJFTJoNUnlHyJbA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=At4Xdpw0Zrn5NsJ2CRKYABUSOeeEfKMEt9N1cZC7IFh4aB1Xzp5/eiDTcuV0z5mjP
         +Rbrzd8Fajyae9wCzljeqfSzm5JLySCJAff9YBdPaLgv2ZH/aThQlJ/9cnr+rFQnbi
         zNiOaCci50OPFXQ1eukzFALbhyGokGYgBpkANGMkwOuYTK3SpNSszTSDZWWI4ri6oX
         +iCI/vHaoU+/DiFzRcflgqoK+oD4Fnik1RKZzbqptYuA+Keb4XnZ22V/s9bkkTGs8k
         4TyGgUsgh/YnX95Pd9LfGJKmgUAfAZnW0LaisxnZ5WbcGLvIN0Tf0wMI53UXAIPeSK
         McpPwR6MFnj9Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/21/2019 4:06 PM, Thierry Reding wrote:
> On Fri, May 17, 2019 at 06:08:36PM +0530, Vidya Sagar wrote:
>> Add extended configuration space capability search API using struct dw_pcie *
>> pointer
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Changes since [v6]:
>> * None
>>
>> Changes since [v5]:
>> * None
>>
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * None
>>
>> Changes since [v2]:
>> * None
>>
>> Changes since [v1]:
>> * This is a new patch in v2 series
>>
>>   drivers/pci/controller/dwc/pcie-designware.c | 41 ++++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-designware.h |  1 +
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 8f53ce63d17e..3b7d50888caa 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -54,6 +54,47 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>>   }
>>   EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
>>   
>> +static int dw_pcie_find_next_ext_capability(struct dw_pcie *pci, int start,
>> +					    int cap)
> 
> Perhaps make this more consistent with the existing regular
> configuration space capability search API? Something like this perhaps:
> 
> 	static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci,
> 						    u16 start, u8 cap)
> 
> ? I guess your variant above is consistent with the existing generic
> capability search API, so another alternative might be to make the old
> dw_pcie_find_capability() API consistent with everything else. It's
> confusing if we keep having to jump between the two variants.
Ok. I'll change it to the format being followed in this file i.e. using u16 and u8

> 
> Thierry
> 
>> +{
>> +	u32 header;
>> +	int ttl;
>> +	int pos = PCI_CFG_SPACE_SIZE;
>> +
>> +	/* minimum 8 bytes per capability */
>> +	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
>> +
>> +	if (start)
>> +		pos = start;
>> +
>> +	header = dw_pcie_readl_dbi(pci, pos);
>> +	/*
>> +	 * If we have no capabilities, this is indicated by cap ID,
>> +	 * cap version and next pointer all being 0.
>> +	 */
>> +	if (header == 0)
>> +		return 0;
>> +
>> +	while (ttl-- > 0) {
>> +		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
>> +			return pos;
>> +
>> +		pos = PCI_EXT_CAP_NEXT(header);
>> +		if (pos < PCI_CFG_SPACE_SIZE)
>> +			break;
>> +
>> +		header = dw_pcie_readl_dbi(pci, pos);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap)
>> +{
>> +	return dw_pcie_find_next_ext_capability(pci, 0, cap);
>> +}
>> +EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
>> +
>>   int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>>   {
>>   	if (!IS_ALIGNED((uintptr_t)addr, size)) {
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 6cb978132469..fff284098117 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -252,6 +252,7 @@ struct dw_pcie {
>>   		container_of((endpoint), struct dw_pcie, ep)
>>   
>>   u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>> +int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap);
>>   
>>   int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>>   int dw_pcie_write(void __iomem *addr, int size, u32 val);
>> -- 
>> 2.17.1
>>

