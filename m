Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A90C1D98A2
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 15:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgESNzK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 09:55:10 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15738 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgESNzK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 09:55:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec3e5310002>; Tue, 19 May 2020 06:54:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 May 2020 06:55:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 May 2020 06:55:09 -0700
Received: from [10.25.75.192] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 May
 2020 13:55:06 +0000
Subject: Re: [PATCH] PCI: dwc: Warn only for non-prefetchable memory resource
 size >4GB
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>,
        "Alan Mikhak" <alan.mikhak@sifive.com>
References: <20200513190855.23318-1-vidyas@nvidia.com>
 <20200513223508.GA352288@bjorn-Precision-5520>
 <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
Date:   Tue, 19 May 2020 19:25:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589896497; bh=6vHGEj/TpmJyM9WFsoC2S9lYbY2NhVfAh120Hs1ELGY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OlXn2hASmaE4CevgDwu0v1G3RrE5I2TjKYMyOLgP7k68AL8XfgtCoxmGdxdTD9X7F
         UGx0fDakgUdMFEvTzpx4ut11dAur/i4lA+GqSbhA0xAmvpSqv3baLlFwNPbKYD9Y75
         1n1rO537E5sIOIXaQB+XdKew0XlFZ0SVA7hF6oXho5PaNTsIg3t9wqhGrUtNYKr9Iq
         hXbECmVgzsG7tUnjilpxm36mmpP+5z9pnCZUcaS2A0k+lpIR5eblhIlgBLzhTgRaAs
         zdNmN2x9mOPJgRtJ7aqOBj6pzw7NE7urqDcalef0/PS9lFOD2d+jGdNqeggdMFKwCp
         ZRjMkKWd3SXbQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 18-May-20 9:24 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, May 13, 2020 at 05:35:08PM -0500, Bjorn Helgaas wrote:
>> [+cc Alan; please cc authors of relevant commits,
>> updated Andrew's email address]
>>
>> On Thu, May 14, 2020 at 12:38:55AM +0530, Vidya Sagar wrote:
>>> commit 9e73fa02aa009 ("PCI: dwc: Warn if MEM resource size exceeds max for
>>> 32-bits") enables warning for MEM resources of size >4GB but prefetchable
>>>   memory resources also come under this category where sizes can go beyond
>>> 4GB. Avoid logging a warning for prefetchable memory resources.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index 42fbfe2a1b8f..a29396529ea4 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>>                      pp->mem = win->res;
>>>                      pp->mem->name = "MEM";
>>>                      mem_size = resource_size(pp->mem);
>>> -                   if (upper_32_bits(mem_size))
>>> +                   if (upper_32_bits(mem_size) &&
>>> +                       !(win->res->flags & IORESOURCE_PREFETCH))
>>>                              dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
>>>                      pp->mem_size = mem_size;
>>>                      pp->mem_bus_addr = pp->mem->start - win->offset;
> 
> That warning was added for a reason - why should not we log legitimate
> warnings ? AFAIU having resources larger than 4GB can lead to undefined
> behaviour given the current ATU programming API.
Yeah. I'm all for a warning if the size is larger than 4GB in case of
non-prefetchable window as one of the ATU outbound translation channels 
is being used, but, we are not employing any ATU outbound translation 
channel for prefetchable window and they can be greater than 4GB in size 
for all right reasons. So, logging a warning for prefetchable region 
doesn't seem correct to me. Please let me know if my understanding is wrong.

- Vidya Sagar
> 
> Alan ? I want to understand what's the best course of action before
> merging these patches.
> 
> Lorenzo
> 
