Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26E61A2A7
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2019 19:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfEJRu4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 May 2019 13:50:56 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12524 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfEJRu4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 May 2019 13:50:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd5b9d80001>; Fri, 10 May 2019 10:50:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 May 2019 10:50:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 May 2019 10:50:54 -0700
Received: from [10.25.74.39] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 May
 2019 17:50:47 +0000
Subject: Re: [PATCH V5 03/16] PCI: Export pcie_bus_config symbol
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-4-vidyas@nvidia.com> <20190503110732.GC32400@ulmo>
 <80616ff5-d7a5-84a4-a71b-569e340d128c@nvidia.com>
 <20190510164623.GI235064@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <484cd585-d576-e6c3-d222-0b2391b5a7fe@nvidia.com>
Date:   Fri, 10 May 2019 23:20:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510164623.GI235064@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557510617; bh=myxHy02oeX5AFakgSkoBUPpIXZQF5FReGyngp+QG/u0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LMcRy5S166FLGtxfqcO+toaJpYUnD4e+CrVuppvw4S+Dm/q83pCZNYDN80M1mJuEs
         LHP0skMkOUQopt85C1oiICVHMZwQeHZ9+uDI/ofI0VyyfIwK7XJFP4jLQyKQuaeyBT
         12M9svhEKJ1HHd2DtuqN1JkYHK2rwyOEH4ZjUlJU6hecw7kmw9Jl4ELXLQSf1KKfuZ
         XKqocV0TQsFwz23Ygjdnu+AClov70ObYWrGPmnPFcvCM4TGSG3lepgKZ0bGmsNdnIo
         ublwi58Ci9Pv3Iq4f4PSsXm8o+qm6C/xhu2dgNvg5hoecoMQuyaVpf6D6CI953czm5
         cCtwW0U1kKmCg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/10/2019 10:16 PM, Bjorn Helgaas wrote:
> Hi Vidya,
> 
> On Fri, May 10, 2019 at 11:51:24AM +0530, Vidya Sagar wrote:
>>> -----Original Message-----
>>> From: linux-pci-owner@vger.kernel.org <linux-pci-owner@vger.kernel.org> On
>>> Behalf Of Thierry Reding
>>> Sent: Friday, May 3, 2019 4:38 PM
>>> To: Vidya Sagar <vidyas@nvidia.com>
>>> On Wed, Apr 24, 2019 at 10:49:51AM +0530, Vidya Sagar wrote:
>>>> Export pcie_bus_config to enable host controller drivers setting it to
>>>> a specific configuration be able to build as loadable modules
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> 
>>> It doesn't look to me like this is something that host controller drivers are
>>> supposed to change. This is set via the pci kernel command- line parameter,
>>> meaning it's a way of tuning the system configuration.
>>> Drivers should not be allowed to override this after the fact.
>>>
>>> Why do we need to set this?
>> Here is the reason I'm doing it.
>> First things first, Tegra194 supports MPS up to 256 bytes.
>> Assume there are two endpoints with MPS supported up to
>> a) 128 bytes (Ex:- Realtek NIC with 8168 controller)
>> b) 256 bytes (Ex:- Kingston NVMe drive)
>> Now, leaving "pcie_bus_config" untouched in the driver sets it to
>> PCIE_BUS_DEFAULT by default. With this setting, for both (a) and (b),
>> MPS is set to 128, which means, even though Tegra194 supports 256 MPS, it is not
>> set to 256 even in case of (b) thereby not using RP's 256 MPS feature.
>> If I explicitly set pcie_bus_config=PCIE_BUS_PERFORMACE in the code, then 256 MPS is set when
>> (b) is connected, but when (a) is connected, for root port MPS 256 is set and for
>> endpoint MPS 128 is set, because of which root port tries to send packets with 256
>> payload that breaks functionality of Realtek NIC card.
>> The best option I've found out is that when I set 256 in PCI_EXP_DEVCTL of root port
>> explicitly before link up and use pcie_bus_config=PCIE_BUS_SAFE, then, I get the best of both
>> PCIE_BUS_DEFAULT and PCIE_BUS_PERFORMANCE i.e. with (a) connected, MPS is set to 128 in both RP
>> and EP and with (b) connected, MPS is set to 256 in both RP and EP.
>>
>> So, is it like, pcie_bus_config shouldn't be set to anything explicitly in the driver and depending on the
>> platform and what is connected to root port, kernel parameter can be passed with appropriate setting?
> 
> Host controller drivers shouldn't change this unless there's some host
> controller defect that means the generic code can't do the right
> thing.  Even then, I'd prefer that the host controller driver merely
> set a quirk bit that describes the defect, e.g., "mps_*_broken".  Then
> the generic code could pay attention to that and we wouldn't have to
> make "pcie_bus_config" a part of the ABI.
> 
>  From your description, it sounds like there's nothing actually wrong
> with the Tegra194 hardware, but the generic code isn't as smart about
> setting MPS as it possibly could be.  My solution to that would be to
> make the generic code smarter so everybody can benefit.
> 
> Bjorn
Thanks Bjorn for your take on this. I'll drop this patch from the current series
and make a note to optimize PCIE_BUS_DEFAULT to do a better job of setting
MPS in the best possible way.

> 
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index
>>>> f5ff01dc4b13..731f78508601 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -94,6 +94,7 @@ unsigned long pci_hotplug_mem_size =
>>>> DEFAULT_HOTPLUG_MEM_SIZE;  unsigned long pci_hotplug_bus_size =
>>>> DEFAULT_HOTPLUG_BUS_SIZE;
>>>>
>>>>   enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
>>>> +EXPORT_SYMBOL_GPL(pcie_bus_config);
>>>>
>>>>   /*
>>>>    * The default CLS is used if arch didn't set CLS explicitly and not
>>>> --
>>>> 2.17.1
>>>>

