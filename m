Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA3F1DF993
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbgEWRaX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 May 2020 13:30:23 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12736 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387665AbgEWRaW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 May 2020 13:30:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec95d5d0000>; Sat, 23 May 2020 10:29:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 23 May 2020 10:30:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 23 May 2020 10:30:22 -0700
Received: from [10.25.72.65] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 23 May
 2020 17:30:16 +0000
Subject: Re: Re: Re: [PATCH] PCI: dwc: Warn only for non-prefetchable memory
 resource size >4GB
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Alan Mikhak <alan.mikhak@sifive.com>
References: <20200513223508.GA352288@bjorn-Precision-5520>
 <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
 <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
 <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
 <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
 <20200520111717.GB2141681@ulmo>
 <b1a72abe-6da0-b782-0269-65388f663e26@nvidia.com>
 <20200520224816.GA739245@bogus> <20200522120655.GC2163848@ulmo>
 <20200522133249.GF11785@e121166-lin.cambridge.arm.com>
 <20200522140640.GA2373406@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <53ad34e3-d58a-d81c-a001-2c1f6e601fb4@nvidia.com>
Date:   Sat, 23 May 2020 23:00:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522140640.GA2373406@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590254941; bh=DrSTj9OaeiI2rXt1QD/u5w0d/6cs410b88d0v85vuEQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=k3Y3YIs8L1nRJO+UihIBYVVOzLdKLiFy8JUWW1841HvXt9mpaePEyghvPzB/wVGho
         J0ZqNAmP2IeSs1TcVYLemxaJRwCPkdobXS3OgLmTRTFq0ENg4gX2dDi508tuhlmaWe
         JYcFjCzoysNtfbh8YJX1buvz3Rv3UaduHka+jh7PC/magvJA48MGpSUgub5fchufwu
         k7Ps/CxfQZgeDMEA+lniuCShLLXOpp5y0yM9USvB739+y+VKQkg3uy/VaJTIjLqSnh
         9TI1ZZ7RLpIWllEGb35lJUC5HYXENXViOODpaEj/G64v/xknebWZDBsoZa/4LFyUNN
         BSqxDOvFZWlTA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 22-May-20 7:36 PM, Thierry Reding wrote:
> On Fri, May 22, 2020 at 02:32:49PM +0100, Lorenzo Pieralisi wrote:
>> On Fri, May 22, 2020 at 02:06:55PM +0200, Thierry Reding wrote:
>>> On Wed, May 20, 2020 at 04:48:16PM -0600, Rob Herring wrote:
>>>> On Wed, May 20, 2020 at 11:16:32PM +0530, Vidya Sagar wrote:
>>>>>
>>>>>
>>>>> On 20-May-20 4:47 PM, Thierry Reding wrote:
>>>>>> On Tue, May 19, 2020 at 10:08:54PM +0000, Gustavo Pimentel wrote:
>>>>>>> On Tue, May 19, 2020 at 15:58:16, Lorenzo Pieralisi
>>>>>>> <lorenzo.pieralisi@arm.com> wrote:
>>>>>>>
>>>>>>>> On Tue, May 19, 2020 at 07:25:02PM +0530, Vidya Sagar wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 18-May-20 9:24 PM, Lorenzo Pieralisi wrote:
>>>>>>>>>> External email: Use caution opening links or attachments
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On Wed, May 13, 2020 at 05:35:08PM -0500, Bjorn Helgaas wrote:
>>>>>>>>>>> [+cc Alan; please cc authors of relevant commits,
>>>>>>>>>>> updated Andrew's email address]
>>>>>>>>>>>
>>>>>>>>>>> On Thu, May 14, 2020 at 12:38:55AM +0530, Vidya Sagar wrote:
>>>>>>>>>>>> commit 9e73fa02aa009 ("PCI: dwc: Warn if MEM resource size exceeds max for
>>>>>>>>>>>> 32-bits") enables warning for MEM resources of size >4GB but prefetchable
>>>>>>>>>>>>     memory resources also come under this category where sizes can go beyond
>>>>>>>>>>>> 4GB. Avoid logging a warning for prefetchable memory resources.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>     drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>>>>>>>>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>>>>>>> index 42fbfe2a1b8f..a29396529ea4 100644
>>>>>>>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>>>>>>> @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>>>>>>>>>>>                        pp->mem = win->res;
>>>>>>>>>>>>                        pp->mem->name = "MEM";
>>>>>>>>>>>>                        mem_size = resource_size(pp->mem);
>>>>>>>>>>>> -                   if (upper_32_bits(mem_size))
>>>>>>>>>>>> +                   if (upper_32_bits(mem_size) &&
>>>>>>>>>>>> +                       !(win->res->flags & IORESOURCE_PREFETCH))
>>>>>>>>>>>>                                dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
>>>>>>>>>>>>                        pp->mem_size = mem_size;
>>>>>>>>>>>>                        pp->mem_bus_addr = pp->mem->start - win->offset;
>>>>>>>>>>
>>>>>>>>>> That warning was added for a reason - why should not we log legitimate
>>>>>>>>>> warnings ? AFAIU having resources larger than 4GB can lead to undefined
>>>>>>>>>> behaviour given the current ATU programming API.
>>>>>>>>> Yeah. I'm all for a warning if the size is larger than 4GB in case of
>>>>>>>>> non-prefetchable window as one of the ATU outbound translation
>>>>>>>>> channels is being used,
>>>>>>>>
>>>>>>>> Is it true for all DWC host controllers ? Or there may be another
>>>>>>>> exception whereby we would be forced to disable this warning altogether
>>>>>>>> ?
>>>>>>>>
>>>>>>>>> but, we are not employing any ATU outbound translation channel for
>>>>>>>>
>>>>>>>> What does this mean ? "we are not employing any ATU outbound...", is
>>>>>>>> this the tegra driver ? And what guarantees that this warning is not
>>>>>>>> legitimate on DWC host controllers that do use the ATU outbound
>>>>>>>> translation for prefetchable windows ?
>>>>>>>>
>>>>>>>> Can DWC maintainers chime in and clarify please ?
>>>>>>>
>>>>>>> Before this code section, there is the following function call
>>>>>>> pci_parse_request_of_pci_ranges(), which performs a simple validation for
>>>>>>> the IORESOURCE_MEM resource type.
>>>>>>> This validation checks if the resource is marked as prefetchable, if so,
>>>>>>> an error message "non-prefetchable memory resource required" is given and
>>>>>>> a return code with the -EINVAL value.
>>>>>>
>>>>>> That's not what the code is doing. pci_parse_request_of_pci_range() will
>>>>>> traverse over the whole list of resources that it can find for the given
>>>>>> host controller and checks whether one of the resources defines prefetch
>>>>>> memory (note the res_valid |= ...). The error will only be returned if
>>>>>> no prefetchable memory region was found.
>>>>>>
>>>>>> dw_pcie_host_init() will then again traverse the list of resources and
>>>>>> it will typically encounter two resource of type IORESOURCE_MEM, one for
>>>>>> non-prefetchable memory and another for prefetchable memory.
>>>>>>
>>>>>> Vidya's patch is to differentiate between these two resources and allow
>>>>>> prefetchable memory regions to exceed sizes of 4 GiB.
>>>>>>
>>>>>> That said, I wonder if there isn't a bigger problem at hand here. From
>>>>>> looking at the code it doesn't seem like the DWC driver makes any
>>>>>> distinction between prefetchable and non-prefetchable memory. Or at
>>>>>> least it doesn't allow both to be stored in struct pcie_port.
>>>>>>
>>>>>> Am I missing something? Or can anyone explain how we're programming the
>>>>>> apertures for prefetchable vs. non-prefetchable memory? Perhaps this is
>>>>>> what Vidya was referring to when he said: "we are not using an outbound
>>>>>> ATU translation channel for prefetchable memory".
>>>>>>
>>>>>> It looks to me like we're also getting partially lucky, or perhaps that
>>>>>> is by design, in that Tegra194 defines PCI regions in the following
>>>>>> order: I/O, prefetchable memory, non-prefetchable memory. That means
>>>>>> that the DWC core code will overwrite prefetchable memory data with that
>>>>>> of non-prefetchable memory and hence the non-prefetchable region ends up
>>>>>> stored in struct pcie_port and is then used to program the ATU outbound
>>>>>> channel.
>>>>> Well,it is by design. I mean, since the code is not differentiating between
>>>>> prefetchable and non-prefetchable regions, I ordered the entries in 'ranges'
>>>>> property in such a way that 'prefetchable' comes first followed by
>>>>> 'non-prefetchable' entry so that ATU region is used for generating the
>>>>> translation required for 'non-prefetchable' region (which is a non 1-to-1
>>>>> mapping)
>>>>
>>>> You are getting lucky with your 'design'. Relying on order is fragile
>>>> (except of course in the places in DT where order is defined, but ranges
>>>> is not one of them).
>>>
>>> Yeah, I think the DWC core should be improved to differentiate between
>>> the two types of memory resources. There shouldn't be a need to encode
>>> any ordering because the type is already part of the value in the
>>> ranges property.
>>
>> DWC resources handling is broken beyond belief. In practical terms, I
>> think the best thing I can do is dropping:
>>
>> 9e73fa02aa00 ("PCI: dwc: Warn if MEM resource size exceeds max for 32-bits")
>>
>> from my pci/dwc branch. However, the ATU programming API must be fixed
>> and this reliance on DT entries ordering avoided - it is really bad
>> practice (and it prevents us from reworking kernel code in ways that are
>> legitimate but would break owing to DT assumptions).
>>
>> So yes, the DWC host bridge code must be updated asap - this is not
>> acceptable.
> 
> Vidya, would you have any spare cycles to look into this a bit since
> you're already familiar? I think for starters it would be good to add
> a special case to the IORESOURCE_MEM case in dw_pcie_host_init() that
> deals with IORESOURCE_PREFETCH set and then store the result in a
> separate struct resource in struct pcie_port, something roughly along
> the lines of:
> 
> 	struct pcie_port {
> 		...
> 		struct resource *mem;
> 		struct resource *prefetch;
> 		...
> 	};
> 
> 	...
> 
> 	int dw_pcie_host_init(struct pcie_port *pp)
> 	{
> 		...
> 		resource_list_for_each_entry(win, &bridge->windows) {
> 			switch (resource_type(win->res)) {
> 			...
> 			case IORESOURCE_MEM:
> 				if (win->res.flags & IORESOURCE_PREFETCH) {
> 					pp->prefetch = win->res;
> 					...
> 				} else {
> 					pp->mem = win->res;
> 					...
> 				}
> 				break;
> 			...
> 		}
> 		...
> 	}
> 
> I suppose for the non-prefetchable memory we could leave the warning in
> because they can never be larger than 32 bits anyway. Then again, I'm
> not sure the check is actually fully correct. My recollection is that
> non-prefetchable memory needs to be completely within the 4 GiB range,
> rather than just the base and the size. So I think something like the
> base starting at 3 GiB and then spanning 2 GiB would be valid according
> to the current check, but I don't think it's valid according to the
> specification.
> 
> The other interesting datapoint to have would be whether the DWC core
> always has 1:1 mappings for prefetchable memory. If so, I think it might
> be useful to still parse them, even if nothing in the driver is using
> them. But I don't know what would be a good way to find out if that's
> really the case.
> 
> I also saw, like you did, that none of the other, non-Tegra device trees
> specify any prefetchable memory for the DWC, so I don't understand how
> they would work. Perhaps they just don't support prefetchable memory?
> 
> If you don't have the time to do this I could possibly take a stab at it
> but there are a few other things I need to look into, so I probably
> won't get around to this within the next two or so weeks.
Sure. I'll try to come up with a patch set to address this at DWC core 
level.

Thanks,
Vidya Sagar
> 
> Thierry
> 
