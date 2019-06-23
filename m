Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 222014FC11
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2019 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfFWOnU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jun 2019 10:43:20 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3909 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFWOnU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jun 2019 10:43:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0f90050000>; Sun, 23 Jun 2019 07:43:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 23 Jun 2019 07:43:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 23 Jun 2019 07:43:18 -0700
Received: from [10.25.72.175] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 23 Jun
 2019 14:43:14 +0000
Subject: Re: [PATCH V7 2/3] PCI: dwc: Cleanup DBI,ATU read and write APIs
To:     Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20190622165143.11906-1-vidyas@nvidia.com>
 <20190622165143.11906-2-vidyas@nvidia.com>
 <PSXP216MB0662E297AC662E53D515141CAAE10@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <beef4f7f-e6e5-4735-7847-c04e608d54d5@nvidia.com>
Date:   Sun, 23 Jun 2019 20:13:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0662E297AC662E53D515141CAAE10@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561300997; bh=saBXV7wt7gyDAES5PloLCwidpM/IKpfUZ3VhqS4ILcc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XBVVcAg4Is58zuumIkfb7/ye9l0DfSxPCOkFaRMvIRu1v0Uuw4Qbhx/glm3N7r2OR
         Od7B++INQJAMW6lpBZMjW2urlYGLugOfWZT6orhmhoBS9hbEqXpJrxnuvHuyTnfQGF
         x0dlztRddRwrShc3EpH6EeC0JXxB3vZ3IpU5PItrikRDPFYthO3SgVuXBgAysabNfX
         gGx0shBtLhPcK//bW0XZ5d0zmAZRzK7YFUub7k7AuucnDjVmomsqFFnGSdY9XYEFri
         opAtgGtqSa125NLU/ruUnHSpi/xFNR148bp2yhwLg47LMLprOk3KnhwWs1qTjsiY9t
         0SA4tJNxxMd0g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/23/2019 1:17 PM, Jingoo Han wrote:
> On 6/23/19, 1:52 AM, Vidya Sagar wrote:
>>
>> Cleanup DBI read and write APIs by removing "__" (underscore) from their
>> names as there are no no-underscore versions and the underscore versions
>> are already doing what no-underscore versions typically do. It also removes
>> passing dbi/dbi2 base address as one of the arguments as the same can be
>> derived with in read and write APIs. Since dw_pcie_{readl/writel}_dbi()
>> APIs can't be used for ATU read/write as ATU base address could be
>> different from DBI base address, this patch attempts to implement
>> ATU read/write APIs using ATU base address without using
>> dw_pcie_{readl/writel}_dbi() APIs.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes from v6:
>> * Modified ATU read/write APIs to use implementation specific DBI read/write
>>    APIs if present.
>>
>> Changes from v5:
>> * Removed passing base address as one of the arguments as the same can be derived within
>>    the API itself.
>> * Modified ATU read/write APIs to call dw_pcie_{write/read}() API
>>
>> Changes from v4:
>> * This is a new patch in this series
>>
>>   drivers/pci/controller/dwc/pcie-designware.c | 28 +++++------
>>   drivers/pci/controller/dwc/pcie-designware.h | 51 +++++++++++++-------
>>   2 files changed, 45 insertions(+), 34 deletions(-)
> 
> .....
> 
>>   static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
>>   {
>> -	__dw_pcie_write_dbi(pci, pci->atu_base, reg, 0x4, val);
>> +	int ret;
>> +
>> +	if (pci->ops->write_dbi) {
>> +		pci->ops->write_dbi(pci, pci->atu_base, reg, 0x4, val);
>> +		return;
>> +	}
>> +
>> +	ret = dw_pcie_write(pci->atu_base + reg, 0x4, val);
>> +	if (ret)
>> +		dev_err(pci->dev, "Write ATU address failed\n");
>>   }
>>   
>>   static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
>>   {
>> -	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
>> +	int ret;
>> +	u32 val;
>> +
>> +	if (pci->ops->read_dbi)
>> +		return pci->ops->read_dbi(pci, pci->atu_base, reg, 0x4);
>> +
>> +	ret = dw_pcie_read(pci->atu_base + reg, 0x4, &val);
>> +	if (ret)
>> +		dev_err(pci->dev, "Read ATU address failed\n");
>> +
>> +	return val;
>>   }
> 
> Hmm. In cases of dbi and  dbi2, readb/readw/readl and writeb/writew/writel are
> located in pcie-designware.h. These functions just call read/write which are located
> in pcie-designware.c. For readability, would you write the code as below?
> 
> 1. For drivers/pci/controller/dwc/pcie-designware.h,
>      Just call dw_pcie_{write/read}_atu(), instead of implementing functions as below.
> 
> 	static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
> 	{
> 		return  dw_pcie_write_atu(pci, reg, 0x4, val);
> 	}
> 
> 	static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)	
> 	{
> 		return  dw_pcie_read_atu(pci, reg, 0x4);
> 	}
> 
> 2. For drivers/pci/controller/dwc/pcie-designware.c,
>      Please add new dw_pcie_{write/read}_atu() as below.
> 
> 	void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
> 	{
> 		int ret;
> 
> 		if (pci->ops->write_dbi) {
> 			pci->ops->write_dbi(pci, pci->atu_base, reg, size, val);
> 			return;
> 		}
> 
> 		ret = dw_pcie_write(pci->atu_base + reg, size, val);
> 		if (ret)
> 			dev_err(pci->dev, "Write ATU address failed\n");
> 	}
> 
> 	u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size)
> 	{
> 		int ret;
> 		u32 val;
> 
> 		if (pci->ops->read_dbi)
> 			return pci->ops->read_dbi(pci, pci->atu_base, reg, size);
> 
> 		ret = dw_pcie_read(pci->atu_base + reg, size, &val);
> 		if (ret)
> 			dev_err(pci->dev, "Read ATU address failed\n");
> 
> 		return val;
> 	}
> 
> Thank you.
> 
> Best regards,
> Jingoo Han
Ok. I'll take care of it in next patch.

> 
>>   
>>   static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
>> -- 
>> 2.17.1
> 

