Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E881C1DBBF1
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 19:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETRv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 13:51:57 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14382 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETRv5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 13:51:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec56e300001>; Wed, 20 May 2020 10:51:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 May 2020 10:51:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 May 2020 10:51:57 -0700
Received: from [10.25.75.122] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May
 2020 17:51:53 +0000
Subject: Re: Re: [PATCH] PCI: dwc: Warn only for non-prefetchable memory
 resource size >4GB
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
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
 <20200520110640.GA5300@e121166-lin.cambridge.arm.com>
 <20200520131605.GD2141681@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ca4f4391-8fb1-2f45-1eac-334ba3d2b5dc@nvidia.com>
Date:   Wed, 20 May 2020 23:21:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520131605.GD2141681@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589997104; bh=QxlMINOTWlbAMjOcgNRGgLbQjDrdKdO/3VuJ+nICG84=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bFbFCpyo2q7HgOImZoqAMPpxFwmVGS2lLbJphiZsy0dOn8renkTuckhDgDug0Fs/r
         V0UeWhwjv6/e11WbPHXosKAW1nYp6uzDez7VJ31dNjsldsRFaprPYW9mgug0/8LGt5
         B+MhzmlVXnSyyPsXi2dAhKCCDBkSMNdKruCOySYxBSlYz571WFyvtu5rRfISw1hj73
         EnZTMFQ+kUrmoRUrUFtbbfn6qOzfNb9iknvb7Y1FMOrUmBkXgSvcv8ML62yVBK/xh0
         Bd6v6QIXDZ+VhoLl44ye2TxGn/tabv8y5b6z5vKfKQD0SOAXGevFa8ytTY8CZXONW2
         H1QNaaIjBh6qg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 20-May-20 6:46 PM, Thierry Reding wrote:
> On Wed, May 20, 2020 at 12:06:40PM +0100, Lorenzo Pieralisi wrote:
>> On Tue, May 19, 2020 at 10:08:54PM +0000, Gustavo Pimentel wrote:
>>
>> [...]
>>
>>>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>>> index 42fbfe2a1b8f..a29396529ea4 100644
>>>>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>>>>> @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>>>>>>>                       pp->mem = win->res;
>>>>>>>>                       pp->mem->name = "MEM";
>>>>>>>>                       mem_size = resource_size(pp->mem);
>>>>>>>> -                   if (upper_32_bits(mem_size))
>>>>>>>> +                   if (upper_32_bits(mem_size) &&
>>>>>>>> +                       !(win->res->flags & IORESOURCE_PREFETCH))
>>>>>>>>                               dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
>>>>>>>>                       pp->mem_size = mem_size;
>>>>>>>>                       pp->mem_bus_addr = pp->mem->start - win->offset;
>>>>>>
>>>>>> That warning was added for a reason - why should not we log legitimate
>>>>>> warnings ? AFAIU having resources larger than 4GB can lead to undefined
>>>>>> behaviour given the current ATU programming API.
>>>>> Yeah. I'm all for a warning if the size is larger than 4GB in case of
>>>>> non-prefetchable window as one of the ATU outbound translation
>>>>> channels is being used,
>>>>
>>>> Is it true for all DWC host controllers ? Or there may be another
>>>> exception whereby we would be forced to disable this warning altogether
>>>> ?
>>>>
>>>>> but, we are not employing any ATU outbound translation channel for
>>>>
>>>> What does this mean ? "we are not employing any ATU outbound...", is
>>>> this the tegra driver ? And what guarantees that this warning is not
>>>> legitimate on DWC host controllers that do use the ATU outbound
>>>> translation for prefetchable windows ?
>>>>
>>>> Can DWC maintainers chime in and clarify please ?
>>>
>>> Before this code section, there is the following function call
>>> pci_parse_request_of_pci_ranges(), which performs a simple validation for
>>> the IORESOURCE_MEM resource type.
>>> This validation checks if the resource is marked as prefetchable, if so,
>>> an error message "non-prefetchable memory resource required" is given and
>>> a return code with the -EINVAL value.
>>
>> That code checks if there is *at least* a non-prefetchable resource,
>> that's all it does.
>>
>>> In other words, to reach the code that Vidya is changing, it can be only
>>> if the resource is a non-prefetchable, any prefetchable resource will be
>>> blocked by the previous call, if I'm not mistaken.
>>
>> I think you are mistaken sorry.
>>
>>> Having this in mind, Vidya's change will not make the expected result
>>> aimed by him.
>>
>> I think Vidya's patch does what he expects, the question is whether
>> it is widely applicable to ALL DWC hosts, that's what I want to know.
>>
>>> I don't see any problem by having resources larger than 4GB, from what
>>> I'm seeing in the databook there isn't any restricting related to that as
>>> long they don't consume the maximum space that is addressable by the
>>> system (depending on if they are 32-bit or 64-bit system address).
>>>
>>> To be honest, I'm not seeing a system that could have this resource
>>> larger than 4GB, but it might exist some exception that I don't know of,
>>> that's why I accepted Alan's patch to warn the user that the resource
>>> exceeds the maximum for the 32 bits so that he can be aware that he
>>> *might* be consuming the maximum space addressable.
>>
>> I think it is most certainly a possibility to have > 4GB prefetchable
>> address spaces so we ought to fix this for good. I still have to
>> understand how the DWC host detects the memory region to be programmed
>> into the ATU given that there is more than one but only 1 ATU memory
>> region AFAICS.
> 
> Probably best to wait for Vidya to confirm since I'm not altogether
> familiar with PCI on Tegra194, but looking at the DTS files and the
> Tegra194 TRM, the prefetchable memory regions are set to a range in
> 0x1200000000-0x1fffffffff which is a region of the address map that
> is reserved for "PCIe aperture for > 32-bit OS". Part of that is in
> use for non-prefetchable memory (and ends up being programmed into
> the ATU) whereas a much larger part is used for prefetchable memory
> and is not programmed anywhere, as far as I can tell.Yes. That is true. In case of Tegra194, for 1-to-1 memory translations, 
there is no need to use any ATU regions at all as the HW is capable of 
generating a memory transaction on the bus on its own for any CPU 
generated reads/writes falling in these apertures and are not captured 
by ATU windows for generating other (config/IO) types of transactions. 
Since a part of 64-bit region is used for mapping non-prefetchable BARs 
of endpoints (which are only 32-bit in size), a translation is required 
from 64-bit CPU/AXI address to 32-bit PCIe bus address and ATU region is 
used precisely for this purpose. Since there is no need for ATU 
translation to do 1-to-1 memory mapping, rest of the 64-bit aperture is 
used for mapping prefetchable BARs. I'm not sure if this HW behavior is 
same across DWC implementations. I took a quick look at the 'ranges' 
property of other DWC implementations and none of them have a region 
marked as prefetchable...! I'm not sure how kernel handles mapping an 
endpoint's prefetchable BAR in this case (does it use the 
'non-prefetchable' mapping of 'ranges' property for 'prefetchable' BARs 
as well??)

> 
> But I think given that this is a designated region of the address
> map this is probably automatically redirected to the PCIe controller.
> What I don't know is if that's something Tegra-specific or whether all
> instantiations have something similar set up.
> 
> Thierry
> 
