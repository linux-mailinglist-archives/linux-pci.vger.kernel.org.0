Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059D6306891
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 01:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhA1AVT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 19:21:19 -0500
Received: from mx.socionext.com ([202.248.49.38]:13384 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhA1AUp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 19:20:45 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Jan 2021 09:19:47 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 95ED62059027;
        Thu, 28 Jan 2021 09:19:47 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 28 Jan 2021 09:19:47 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 67A20B1D40;
        Thu, 28 Jan 2021 09:19:47 +0900 (JST)
Received: from [10.212.22.231] (unknown [10.212.22.231])
        by yuzu.css.socionext.com (Postfix) with ESMTP id B11F412014A;
        Thu, 28 Jan 2021 09:19:46 +0900 (JST)
Subject: Re: [PATCH] PCI: dwc: Move forward the iATU detection process
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>,
        "masami.hiramatsu@linaro.org" <masami.hiramatsu@linaro.org>
References: <20210125044803.4310-1-Zhiqiang.Hou@nxp.com>
 <7d2d8a01-1339-2858-0d6a-5674f1cf2bca@socionext.com>
 <HE1PR0402MB33713DFC517B00EE1D13371784BB0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <8a7121f8-2b5c-82dd-3636-df390ec2b70d@socionext.com>
Date:   Thu, 28 Jan 2021 09:19:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <HE1PR0402MB33713DFC517B00EE1D13371784BB0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/01/27 15:27, Z.q. Hou wrote:
> Hi,
> 
> Yes, they are fix the same issue.
> Rob and other contributors sent so many patches to refine the drivers and make the code brief and more readable, so I don't think we should just focus on the fixes of this issue. I don't think it is a good choice that your patch move some of the software perspective initializations into hardware ones.

Ok, I checked your patch fixed this issue on my board with or without
my patch. I'll follow the maintainers for handling my patch.

Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

> 
> Thanks
> Zhiqiang
> 
>> -----Original Message-----
>> From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> Sent: 2021年1月26日 13:26
>> To: Z.q. Hou <zhiqiang.hou@nxp.com>
>> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
>> lorenzo.pieralisi@arm.com; robh@kernel.org; bhelgaas@google.com;
>> gustavo.pimentel@synopsys.com; jingoohan1@gmail.com;
>> jaswinder.singh@linaro.org; masami.hiramatsu@linaro.org
>> Subject: Re: [PATCH] PCI: dwc: Move forward the iATU detection process
>>
>> Hi,
>>
>> This looks to me the same fix as my posted patch[1].
>> Is this more effective than mine?
>>
>> Thank you,
>>
>> [1]
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww
>> .spinics.net%2Flists%2Flinux-pci%2Fmsg103889.html&amp;data=04%7C01%
>> 7CZhiqiang.Hou%40nxp.com%7Cd9fa58aac4774c9dd61b08d8c1bad128%7C
>> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637472355412202563
>> %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL
>> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Mt3B4jQ1Q1fu%2
>> FAz9s4Y4eieHv7nYorvvT2pKlqFLE9k%3D&amp;reserved=0
>>
>> On 2021/01/25 13:48, Zhiqiang Hou wrote:
>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>>
>>> In the dw_pcie_ep_init(), it depends on the detected iATU region
>>> numbers to allocate the in/outbound window management bit map.
>>> It fails after the commit 281f1f99cf3a ("PCI: dwc: Detect number of
>>> iATU windows").
>>>
>>> So this patch move the iATU region detection into a new function, move
>>> forward the detection to the very beginning of functions
>>> dw_pcie_host_init() and dw_pcie_ep_init(). And also remove it from the
>>> dw_pcie_setup(), since it's more like a software perspective
>>> initialization step than hardware setup.
>>>
>>> Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
>>> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>> ---
>>>    drivers/pci/controller/dwc/pcie-designware-ep.c   |  2 ++
>>>    drivers/pci/controller/dwc/pcie-designware-host.c |  2 ++
>>>    drivers/pci/controller/dwc/pcie-designware.c      | 11 ++++++++---
>>>    drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>>>    4 files changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> index bcd1cd9ba8c8..fcf935bf6f5e 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> @@ -707,6 +707,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>    		}
>>>    	}
>>>
>>> +	dw_pcie_iatu_detect(pci);
>>> +
>>>    	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> "addr_space");
>>>    	if (!res)
>>>    		return -EINVAL;
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index 8a84c005f32b..8eae817c138d 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -316,6 +316,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>>    			return PTR_ERR(pci->dbi_base);
>>>    	}
>>>
>>> +	dw_pcie_iatu_detect(pci);
>>> +
>>>    	bridge = devm_pci_alloc_host_bridge(dev, 0);
>>>    	if (!bridge)
>>>    		return -ENOMEM;
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
>>> b/drivers/pci/controller/dwc/pcie-designware.c
>>> index 5b72a5448d2e..5b9bf02d918b 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>> @@ -654,11 +654,9 @@ static void dw_pcie_iatu_detect_regions(struct
>> dw_pcie *pci)
>>>    	pci->num_ob_windows = ob;
>>>    }
>>>
>>> -void dw_pcie_setup(struct dw_pcie *pci)
>>> +void dw_pcie_iatu_detect(struct dw_pcie *pci)
>>>    {
>>> -	u32 val;
>>>    	struct device *dev = pci->dev;
>>> -	struct device_node *np = dev->of_node;
>>>    	struct platform_device *pdev = to_platform_device(dev);
>>>
>>>    	if (pci->version >= 0x480A || (!pci->version && @@ -687,6 +685,13
>>> @@ void dw_pcie_setup(struct dw_pcie *pci)
>>>
>>>    	dev_info(pci->dev, "Detected iATU regions: %u outbound, %u
>> inbound",
>>>    		 pci->num_ob_windows, pci->num_ib_windows);
>>> +}
>>> +
>>> +void dw_pcie_setup(struct dw_pcie *pci) {
>>> +	u32 val;
>>> +	struct device *dev = pci->dev;
>>> +	struct device_node *np = dev->of_node;
>>>
>>>    	if (pci->link_gen > 0)
>>>    		dw_pcie_link_set_max_speed(pci, pci->link_gen); diff --git
>>> a/drivers/pci/controller/dwc/pcie-designware.h
>>> b/drivers/pci/controller/dwc/pcie-designware.h
>>> index 5d979953800d..867369d4c4f7 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>> @@ -305,6 +305,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie
>> *pci, u8 func_no, int index,
>>>    void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>>>    			 enum dw_pcie_region_type type);
>>>    void dw_pcie_setup(struct dw_pcie *pci);
>>> +void dw_pcie_iatu_detect(struct dw_pcie *pci);
>>>
>>>    static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32
>> val)
>>>    {
>>>
>>
>> ---
>> Best Regards
>> Kunihiko Hayashi

---
Best Regards
Kunihiko Hayashi
