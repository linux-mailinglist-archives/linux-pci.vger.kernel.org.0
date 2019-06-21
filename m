Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61A864E00F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 07:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfFUFdL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 01:33:11 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3626 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfFUFdL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 01:33:11 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0c6c150000>; Thu, 20 Jun 2019 22:33:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 22:33:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Jun 2019 22:33:10 -0700
Received: from [10.24.47.36] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 05:33:06 +0000
Subject: Re: [PATCH V4 1/2] PCI: dwc: Add API support to de-initialize host
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <Jisheng.Zhang@synaptics.com>,
        <thierry.reding@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <dec5ecb2-863e-a1db-10c9-2d91f860a2c6@nvidia.com>
 <37697830-5a94-0f8e-a5cf-3347bc4850cb@nvidia.com>
 <b560f3c3-b69e-d9b5-2dae-1ede52af0ea6@nvidia.com>
 <011b52b6-9fcd-8930-1313-6b546226c7b9@nvidia.com>
 <8a6696e0-fc53-2e6b-536b-d1d2668e0f21@nvidia.com>
 <07c3dd04-cfd0-2d52-5917-25d0e40ad00b@nvidia.com>
 <20190618093657.GA30711@e121166-lin.cambridge.arm.com>
 <eb0e5b1e-7e91-4dc6-681f-b497f087c62d@nvidia.com>
 <20190618142821.GC9002@e121166-lin.cambridge.arm.com>
 <69e79afa-16c7-a00c-653d-e4155999660f@ti.com>
 <20190620165255.GC18771@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <0c66cbf5-fde2-1cfd-f2b6-5ec04066829a@nvidia.com>
Date:   Fri, 21 Jun 2019 11:03:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620165255.GC18771@e121166-lin.cambridge.arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561095189; bh=hOwCJ5aFJDubwT5VxKfiY8kHFDwZXerXYHD7szGNaU0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RrUeE/eSVzyhOom1sHTum5kmd0HlzuVg/o2H7kxn9HohZtr1QFqNw1+qCy0HWHayQ
         8FFaefVtbsDyYNFNd2zUJUEFsUTEnPW5myRrtbawpauF2SvyCM2UWYLftgjq2YUQl1
         3wJskn98M6gLMEWCtqzJRCe8Ky68sSRDdcGnB+xv2XoKcK/IhzJorC+R3BRbpNV8j1
         Q0k6OXK0ltU+4VFT1+KyTt6OuhhIt93tKhXk33L5crn7w5bfstTLbquf26KoJcZ8qo
         NcPALDKNsIGqTsw8Izrrn+JUWfgZi3yUMKzfCI1o6vW9PMFeig0jyr2/PZHjZUx0Rd
         k2LSmolJZL1uA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/20/2019 10:22 PM, Lorenzo Pieralisi wrote:
> On Wed, Jun 19, 2019 at 10:41:26AM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On 18/06/19 7:58 PM, Lorenzo Pieralisi wrote:
>>> On Tue, Jun 18, 2019 at 04:21:17PM +0530, Vidya Sagar wrote:
>>>
>>> [...]
>>>
>>>>> 2) It is not related to this patch but I fail to see the reasoning
>>>>>      behind the __ in __dw_pci_read_dbi(), there is no no-underscore
>>>>>      equivalent so its definition is somewhat questionable, maybe
>>>>>      we should clean-it up (for dbi2 alike).
>>>> Separate no-underscore versions are present in pcie-designware.h for
>>>> each width (i.e. l/w/b) as inline and are calling __ versions passing
>>>> size as argument.
>>>
>>> I understand - the __ prologue was added in b50b2db266d8 maybe
>>> Kishon can help us understand the __ rationale.
>>>
>>> I am happy to merge it as is, I was just curious about the
>>> __ annotation (not related to this patch).
>>
>> In commit b50b2db266d8a8c303e8d88590 ("PCI: dwc: all: Modify dbi accessors to
>> take dbi_base as argument"), dbi accessors was modified to take dbi_base as
>> argument (since we wanted to write to dbics2 address space). We didn't want to
>> change all the drivers invoking dbi accessors to pass the dbi_base. So we added
>> "__" variant to take dbi_base as argument and the drivers continued to invoke
>> existing dbi accessors which in-turn invoked "__" version with dbi_base as
>> argument.
>>
>> I agree there could be some cleanup since in commit
>> a509d7d9af5ebf86ffbefa98e49761d ("PCI: dwc: all: Modify dbi accessors to access
>> data of 4/2/1 bytes"), we modified __dw_pcie_readl_dbi() to
>> __dw_pcie_write_dbi() when it could have been directly modified to
>> dw_pcie_write_dbi().
> 
> Thanks. Vidya can do it as a preliminary patch, I will merge then
> code to export the symbols.
> 
> Lorenzo
> 
Do you want me to make the change that removes "__" as part of 2/2 patch itself and
then send V5 or as a separate patch?

Vidya Sagar

