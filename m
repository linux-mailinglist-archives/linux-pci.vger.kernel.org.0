Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9C11D9D84
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 19:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgESRIr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 13:08:47 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17145 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgESRIr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 13:08:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec412500000>; Tue, 19 May 2020 10:07:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 May 2020 10:08:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 May 2020 10:08:47 -0700
Received: from [10.25.75.192] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 May
 2020 17:08:42 +0000
Subject: Re: [PATCH] PCI: dwc: Warn only for non-prefetchable memory resource
 size >4GB
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>,
        "Alan Mikhak" <alan.mikhak@sifive.com>
References: <20200513190855.23318-1-vidyas@nvidia.com>
 <20200513223508.GA352288@bjorn-Precision-5520>
 <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
 <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
 <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <59c32bed-3a6a-70ba-0052-65d9466a0790@nvidia.com>
Date:   Tue, 19 May 2020 22:38:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589908048; bh=1rQXPA2oIArWGngeEsdBJMTOxHrSPSleJraforWbcuQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FtKf2DlTg2eG/uj3U/HEi0z+HTvs9Hi0pteXkU9kl9DlFxnV2OezCsGy8yZuGZLQQ
         xgBxpAjR1lXlIupxRsEX5ZsNEaxuKkHO+7c81P+IFQzhZvgqIG98feDXT9a9C3mBkr
         jkfh8gBU9D6eB2sdME3SEZdmQPnwdejLGH2oUvEg1YaeeLbRSfJu0mP9Zj/1uTHi3z
         b7yY0fZ/qplPiV9ZvPRJMisS4NeZsZzpy+6/9zoK7ryMnHkCHsN1V2m4vUDkcIpKzu
         17aaGJ5g6/u3BtJIV18dIQvwD7FTgWlfgEViQ8DJDStewYrgonTfgjxllTbXmpFOWx
         +6Kb+RYAkGtTg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 19-May-20 8:28 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, May 19, 2020 at 07:25:02PM +0530, Vidya Sagar wrote:
>>
>>
>> On 18-May-20 9:24 PM, Lorenzo Pieralisi wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, May 13, 2020 at 05:35:08PM -0500, Bjorn Helgaas wrote:
>>>> [+cc Alan; please cc authors of relevant commits,
>>>> updated Andrew's email address]
>>>>
>>>> On Thu, May 14, 2020 at 12:38:55AM +0530, Vidya Sagar wrote:
>>>>> commit 9e73fa02aa009 ("PCI: dwc: Warn if MEM resource size exceeds max for
>>>>> 32-bits") enables warning for MEM resources of size >4GB but prefetchable
>>>>>    memory resources also come under this category where sizes can go beyond
>>>>> 4GB. Avoid logging a warning for prefetchable memory resources.
>>>>>
>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>> ---
>>>>>    drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> index 42fbfe2a1b8f..a29396529ea4 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>>>>                       pp->mem = win->res;
>>>>>                       pp->mem->name = "MEM";
>>>>>                       mem_size = resource_size(pp->mem);
>>>>> -                   if (upper_32_bits(mem_size))
>>>>> +                   if (upper_32_bits(mem_size) &&
>>>>> +                       !(win->res->flags & IORESOURCE_PREFETCH))
>>>>>                               dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
>>>>>                       pp->mem_size = mem_size;
>>>>>                       pp->mem_bus_addr = pp->mem->start - win->offset;
>>>
>>> That warning was added for a reason - why should not we log legitimate
>>> warnings ? AFAIU having resources larger than 4GB can lead to undefined
>>> behaviour given the current ATU programming API.
>> Yeah. I'm all for a warning if the size is larger than 4GB in case of
>> non-prefetchable window as one of the ATU outbound translation
>> channels is being used,
> 
> Is it true for all DWC host controllers ? Or there may be another
> exception whereby we would be forced to disable this warning altogether
> ?I think so. As I see from the code, ATU's
Region-0 is used for config space translation
Region-1 is used for non-prefetchable memory translation
Region-2 is used for I/O translation
So, there is no region reserved for translating prefetchable memory regions.

> 
>> but, we are not employing any ATU outbound translation channel for
> 
> What does this mean ? "we are not employing any ATU outbound...", is
> this the tegra driver ? And what guarantees that this warning is not
> legitimate on DWC host controllers that do use the ATU outbound
> translation for prefetchable windows ?
Not Tegra driver but Tegra HW. Tegra HW doesn't need any ATU outbound 
translation for prefetchable (for that matter any 1-to-1 mapping to 
generate memory transactions on the PCIe bus).
The Warning is still valid for both Tegra and other DWC based 
controllers for non-prefetchable memory translation.

> 
> Can DWC maintainers chime in and clarify please ?
> 
>> prefetchable window and they can be greater than 4GB in size for all
>> right reasons. So, logging a warning for prefetchable region doesn't
>> seem correct to me. Please let me know if my understanding is wrong.
> 
> I think your patch is wrong and it is applied on top of a patch that
> is wrong too, so I won't apply yours and it is likely I will revert
> Alan's because it seems to solve nothing (and warn spuriously).
> 
> It is time for people who maintain DWC please to speak up because I
> don't have the HW details required to make a judgment.
> 
> Lorenzo
> 
>> - Vidya Sagar
>>>
>>> Alan ? I want to understand what's the best course of action before
>>> merging these patches.
>>>
>>> Lorenzo
>>>
