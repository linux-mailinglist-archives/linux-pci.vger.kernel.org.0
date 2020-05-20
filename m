Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F61DBBD9
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETRqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 13:46:40 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14038 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 13:46:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec56cf30000>; Wed, 20 May 2020 10:46:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 20 May 2020 10:46:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 20 May 2020 10:46:39 -0700
Received: from [10.25.75.122] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May
 2020 17:46:35 +0000
Subject: Re: Re: [PATCH] PCI: dwc: Warn only for non-prefetchable memory
 resource size >4GB
To:     Thierry Reding <thierry.reding@gmail.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Andrew Murray" <amurray@thegoodpenguin.co.uk>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        "Alan Mikhak" <alan.mikhak@sifive.com>
References: <20200513190855.23318-1-vidyas@nvidia.com>
 <20200513223508.GA352288@bjorn-Precision-5520>
 <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
 <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
 <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
 <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
 <20200520111717.GB2141681@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <b1a72abe-6da0-b782-0269-65388f663e26@nvidia.com>
Date:   Wed, 20 May 2020 23:16:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520111717.GB2141681@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589996787; bh=cHthH4QXLAI7YiXvZFZG9yRNjIOqQYNiVwOQEH/uJOo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hFgkLgdCqtvGd0uCUirFZRjNJO3dfLXJMWuLq4Cv8h/FmDxPYc563OjeurYCIkOSy
         uVKVGFcf4Qp5A/cW2aw+C+oLYxfQbSBhfvRM0I9MjfJsCRtsfgjzvxoLia8d8G0zfm
         JgQ0yvk2yBE4WDxZU9YnRm6BgfFojT6lnZe+Jar47Gt1W0IE6ueZo2kvbIUuHNd9hQ
         4ZLTzCg8/XU16h4A83oH9hKHRvLRlIk1+Yxz7pQOCmA5oolWldgsRvxi6GvNNWGyC9
         qiy0aaQNev/p4L8CX9Nk2amv4asx4c02ZbPp1o7bDGGuIWVMmfhbhbK15wGtv2OO68
         n0JTxSwgnnj3g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 20-May-20 4:47 PM, Thierry Reding wrote:
> On Tue, May 19, 2020 at 10:08:54PM +0000, Gustavo Pimentel wrote:
>> On Tue, May 19, 2020 at 15:58:16, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>>
>>> On Tue, May 19, 2020 at 07:25:02PM +0530, Vidya Sagar wrote:
>>>>
>>>>
>>>> On 18-May-20 9:24 PM, Lorenzo Pieralisi wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Wed, May 13, 2020 at 05:35:08PM -0500, Bjorn Helgaas wrote:
>>>>>> [+cc Alan; please cc authors of relevant commits,
>>>>>> updated Andrew's email address]
>>>>>>
>>>>>> On Thu, May 14, 2020 at 12:38:55AM +0530, Vidya Sagar wrote:
>>>>>>> commit 9e73fa02aa009 ("PCI: dwc: Warn if MEM resource size exceeds max for
>>>>>>> 32-bits") enables warning for MEM resources of size >4GB but prefetchable
>>>>>>>    memory resources also come under this category where sizes can go beyond
>>>>>>> 4GB. Avoid logging a warning for prefetchable memory resources.
>>>>>>>
>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>>>> ---
>>>>>>>    drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>>>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>> index 42fbfe2a1b8f..a29396529ea4 100644
>>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>> @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>>>>>>                       pp->mem = win->res;
>>>>>>>                       pp->mem->name = "MEM";
>>>>>>>                       mem_size = resource_size(pp->mem);
>>>>>>> -                   if (upper_32_bits(mem_size))
>>>>>>> +                   if (upper_32_bits(mem_size) &&
>>>>>>> +                       !(win->res->flags & IORESOURCE_PREFETCH))
>>>>>>>                               dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
>>>>>>>                       pp->mem_size = mem_size;
>>>>>>>                       pp->mem_bus_addr = pp->mem->start - win->offset;
>>>>>
>>>>> That warning was added for a reason - why should not we log legitimate
>>>>> warnings ? AFAIU having resources larger than 4GB can lead to undefined
>>>>> behaviour given the current ATU programming API.
>>>> Yeah. I'm all for a warning if the size is larger than 4GB in case of
>>>> non-prefetchable window as one of the ATU outbound translation
>>>> channels is being used,
>>>
>>> Is it true for all DWC host controllers ? Or there may be another
>>> exception whereby we would be forced to disable this warning altogether
>>> ?
>>>
>>>> but, we are not employing any ATU outbound translation channel for
>>>
>>> What does this mean ? "we are not employing any ATU outbound...", is
>>> this the tegra driver ? And what guarantees that this warning is not
>>> legitimate on DWC host controllers that do use the ATU outbound
>>> translation for prefetchable windows ?
>>>
>>> Can DWC maintainers chime in and clarify please ?
>>
>> Before this code section, there is the following function call
>> pci_parse_request_of_pci_ranges(), which performs a simple validation for
>> the IORESOURCE_MEM resource type.
>> This validation checks if the resource is marked as prefetchable, if so,
>> an error message "non-prefetchable memory resource required" is given and
>> a return code with the -EINVAL value.
> 
> That's not what the code is doing. pci_parse_request_of_pci_range() will
> traverse over the whole list of resources that it can find for the given
> host controller and checks whether one of the resources defines prefetch
> memory (note the res_valid |= ...). The error will only be returned if
> no prefetchable memory region was found.
> 
> dw_pcie_host_init() will then again traverse the list of resources and
> it will typically encounter two resource of type IORESOURCE_MEM, one for
> non-prefetchable memory and another for prefetchable memory.
> 
> Vidya's patch is to differentiate between these two resources and allow
> prefetchable memory regions to exceed sizes of 4 GiB.
> 
> That said, I wonder if there isn't a bigger problem at hand here. From
> looking at the code it doesn't seem like the DWC driver makes any
> distinction between prefetchable and non-prefetchable memory. Or at
> least it doesn't allow both to be stored in struct pcie_port.
> 
> Am I missing something? Or can anyone explain how we're programming the
> apertures for prefetchable vs. non-prefetchable memory? Perhaps this is
> what Vidya was referring to when he said: "we are not using an outbound
> ATU translation channel for prefetchable memory".
> 
> It looks to me like we're also getting partially lucky, or perhaps that
> is by design, in that Tegra194 defines PCI regions in the following
> order: I/O, prefetchable memory, non-prefetchable memory. That means
> that the DWC core code will overwrite prefetchable memory data with that
> of non-prefetchable memory and hence the non-prefetchable region ends up
> stored in struct pcie_port and is then used to program the ATU outbound
> channel.
Well,it is by design. I mean, since the code is not differentiating 
between prefetchable and non-prefetchable regions, I ordered the entries 
in 'ranges' property in such a way that 'prefetchable' comes first 
followed by 'non-prefetchable' entry so that ATU region is used for 
generating the translation required for 'non-prefetchable' region (which 
is a non 1-to-1 mapping)

> 
>> In other words, to reach the code that Vidya is changing, it can be only
>> if the resource is a non-prefetchable, any prefetchable resource will be
>> blocked by the previous call, if I'm not mistaken.
>>
>> Having this in mind, Vidya's change will not make the expected result
>> aimed by him.
> 
> Given the above I think it does. We've also seen this patch eliminate a
> warning that we were seeing before, so I think it has the intended
> effect.
> 
>> I don't see any problem by having resources larger than 4GB, from what
>> I'm seeing in the databook there isn't any restricting related to that as
>> long they don't consume the maximum space that is addressable by the
>> system (depending on if they are 32-bit or 64-bit system address).
>>
>> To be honest, I'm not seeing a system that could have this resource
>> larger than 4GB, but it might exist some exception that I don't know of,
>> that's why I accepted Alan's patch to warn the user that the resource
>> exceeds the maximum for the 32 bits so that he can be aware that he
>> *might* be consuming the maximum space addressable.
> 
> I think it's pretty common to have this type of prefetchable memory
> region when you connect discrete GPUs to PCIe. It's not unusual for
> high-end GPUs to have 8 GiB or even more dedicated video memory and
> those will typically be mapped to a prefetchable memory region on
> the PCI device.
> 
> Thierry
> 
