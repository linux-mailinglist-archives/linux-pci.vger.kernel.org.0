Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D664F67A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfFVPU1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jun 2019 11:20:27 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15570 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVPU1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jun 2019 11:20:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0e473b0000>; Sat, 22 Jun 2019 08:20:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 22 Jun 2019 08:20:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 22 Jun 2019 08:20:26 -0700
Received: from [10.25.72.60] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 22 Jun
 2019 15:01:17 +0000
Subject: Re: [PATCH V6 2/3] PCI: dwc: Cleanup DBI read and write APIs
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
References: <20190621111000.23216-1-vidyas@nvidia.com>
 <20190621111000.23216-2-vidyas@nvidia.com>
 <PSXP216MB0662399C169A6D944E7C6A8FAAE60@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <625ef12e-8986-b935-0b1b-a437c518ac29@nvidia.com>
Date:   Sat, 22 Jun 2019 20:31:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0662399C169A6D944E7C6A8FAAE60@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561216828; bh=Gg6ynwqt5s5qIc9zttRBjajJzrIC+hXVHXW78gtZT6k=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PnBlJaxJsQ2pdKDVSaXmZGLzacmfrdQdr7t8F8ZPGkdCZm/JejAkrFB5QeSG2dYU0
         YsEyn/gy0z7d7uaYZ0TZ+nS95PBixeswFeTgGt5BaCevNhG7nTnNtZcs4mncXqyMU8
         JUspGrgl7+nRB/dnTZbUfi0h3u0lK39N6KlRubcW2UzC3P7WlN8f2qqFHOevUo6jO6
         CCpc51oJXo5LSS7dEsDGjfQP80JOlzX88YkGmcMl9tgFm85pFvlgEXNQfu71492FLW
         sB4+9Va81TiVBA/pP8LSqMAikiblnf6iCKIIr8V+SOBeb5QFR1auzPSFA0fXhmn0D2
         n7wmVXzek6pnA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/22/2019 10:56 AM, Jingoo Han wrote:
> On 6/21/19, 8:10 PM, Vidya Sagar wrote:
>>
>> Cleanup DBI read and write APIs by removing "__" (underscore) from their
>> names as there are no no-underscore versions and the underscore versions
>> are already doing what no-underscore versions typically do. It also removes
>> passing dbi/dbi2 base address as one of the arguments as the same can be
>> derived with in read and write APIs.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes from v5:
>> * Removed passing base address as one of the arguments as the same can be derived within
>>    the API itself.
>> * Modified ATU read/write APIs to call dw_pcie_{write/read}() API
> 
> Unlike previous patches (v1~v5), you modified ATU read/write APIs from v6.
> Why do you change ATU read/write APIs to call dw_pcie_{write/read}() API???
> It is not clean-up, but function change. Please add the reason to the commit message.
> 
> Best regards,
> Jingoo Han
Reason is that, now dbi/dbi2 APIs don't take base address offset as one of the input arguments
instead, those APIs derive that inside the API itself. So, for ATU read/write DBI read/write
APIs can be used directly and hence I called dw_pcie_{write/read}() API directly. But, taking a
second look at it, it may work for Tegra, but, may not for other implementations where accessing
DBI space is not a simple read/write to DBI base + offset. Let me address address that too in
next patch.

Thanks,
Vidya Sagar

> 
>>
>> Changes from v4:
>> * This is a new patch in this series
>>
>>   drivers/pci/controller/dwc/pcie-designware.c | 28 ++++++-------
>>   drivers/pci/controller/dwc/pcie-designware.h | 43 ++++++++++++--------
>>   2 files changed, 37 insertions(+), 34 deletions(-)
> 
> .....
> 
>>   static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
>>   {
>> -	__dw_pcie_write_dbi(pci, pci->atu_base, reg, 0x4, val);
>> +	int ret;
>> +
>> +	ret = dw_pcie_write(pci->atu_base + reg, 0x4, val);
>> +	if (ret)
>> +		dev_err(pci->dev, "write ATU address failed\n");
>>   }
>>   
>>   static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
>>   {
>> -	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
>> +	int ret;
>> +	u32 val;
>> +
>> +	ret = dw_pcie_read(pci->atu_base + reg, 0x4, &val);
>> +	if (ret)
>> +		dev_err(pci->dev, "Read ATU address failed\n");
>> +
>> +	return val;
>>   }
>>   
>>   static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
>> -- 
>> 2.17.1
> 

