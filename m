Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B58A4E481
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFUJrJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 05:47:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16578 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfFUJrI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 05:47:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0ca79b0000>; Fri, 21 Jun 2019 02:47:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Jun 2019 02:47:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Jun 2019 02:47:08 -0700
Received: from [10.24.47.36] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 09:47:04 +0000
Subject: Re: [PATCH V5 2/3] PCI: dwc: Cleanup DBI read and write APIs
To:     Kishon Vijay Abraham I <kishon@ti.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <Jisheng.Zhang@synaptics.com>,
        <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190621092127.17930-1-vidyas@nvidia.com>
 <20190621092127.17930-2-vidyas@nvidia.com>
 <63b59d6b-f6d7-fe4f-f319-6459a146ef36@ti.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <e23ef76b-e74a-ee29-05c2-5c09f206ee36@nvidia.com>
Date:   Fri, 21 Jun 2019 15:17:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <63b59d6b-f6d7-fe4f-f319-6459a146ef36@ti.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561110427; bh=zyE6pQSIIRro/h0SV26v4KyjO3eLf6LhmiYNfvQp6zY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Xs4uRZ93IA+XRMGM5tc7qh/euAtpotDKtTGaOFBj6Gtxl2HHkiAcw5Y+rnht1bbty
         jq25xAH0sFZ2/X/rejLDHZSIWgDayWRvJ4ProViuaRTABlBrLXoA1BKQlAQGkCUEJn
         8bllPKu1XZAm/ZgZXOdbN+i8yJZ6HwAOT4yW6sihXUa2iCi7nZ+H68/cKGC4L2ZDXp
         JusfG1Y81y0xHbp7C+CnIqEiqAttA8LKfjCX1Xt2UExkcBJx4FJl/Yq2y9C/mfhVNI
         2ZLL/yO0d8u6XWM3a3TgN7Bgz4oluRi/7apb0GfU9ZzYYUE9DZ32AsBuDM6BMZGmJt
         0ntJg64n9zOkA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/21/2019 2:57 PM, Kishon Vijay Abraham I wrote:
> Hi Vidya,
> 
> On 21/06/19 2:51 PM, Vidya Sagar wrote:
>> Cleanup DBI read and write APIs by removing "__" (underscore) from their
>> names as there are no no-underscore versions and the underscore versions
>> are already doing what no-underscore versions typically do.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes from v4:
>> * This is a new patch in this series
>>
>>   drivers/pci/controller/dwc/pcie-designware.c | 16 ++++-----
>>   drivers/pci/controller/dwc/pcie-designware.h | 36 ++++++++++----------
>>   2 files changed, 26 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 9d7c51c32b3b..5d22028d854e 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -52,8 +52,8 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
>>   	return PCIBIOS_SUCCESSFUL;
>>   }
>>   
>> -u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
>> -		       size_t size)
>> +u32 dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
>> +		     size_t size)
> 
> The "base" here was added when we used the same API for both dbi_base and
> dbi_base2. Now that we have separate APIs, we should be able to remove that.
> 
> Thanks
> Kishon
> 
Got it. Let me address it.

