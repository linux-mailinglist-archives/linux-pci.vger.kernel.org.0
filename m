Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A901CA9FF
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEHLvd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 07:51:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40438 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEHLvc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 07:51:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 048BpNGZ069662;
        Fri, 8 May 2020 06:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588938683;
        bh=McXdmmkKZkIA+vd9j38C0vIj8qtnCV2WghDCz/JhKuE=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=u56ZFWU1p4kOACyWddi2n4bh8BWk9u2Ia99DU9pDOJj7imrrQOEa+YfqO3Q90ZOuU
         00ZyTx3waJ+PUGmFwLpng70nSJVgIqQO+Jrre4Nv8HkoDItiFz5HZXwngx2WxrXWMi
         /O/0fj8NE+T0M/zav1qZC8ZhhyRcOwN85CujUMvw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 048BpNHr071270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 May 2020 06:51:23 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 06:51:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 06:51:22 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 048BpJuf110590;
        Fri, 8 May 2020 06:51:20 -0500
Subject: Re: [PATCH v2 2/4] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200417114322.31111-1-kishon@ti.com>
 <20200417114322.31111-3-kishon@ti.com>
 <20200501144645.GB7398@e121166-lin.cambridge.arm.com>
 <dc581c5b-11de-f4b3-e928-208b9293e391@arm.com>
 <2472c182-834c-d2c1-175e-4d73898aef35@ti.com>
 <4f333ceb-2809-c4ae-4ae3-33a83c612cd3@arm.com>
 <cf9c2dcc-57e8-cfa0-e3b4-55ff5113341f@ti.com>
 <da933b0d-ee17-5bca-3763-1d73c7ed6bfc@ti.com> <20200507202658.GA29938@bogus>
 <f22cca60-40a8-571d-d5fa-50d05281cc3f@ti.com>
Message-ID: <eb1ffcb3-264f-5174-1f25-b5b2d3269840@ti.com>
Date:   Fri, 8 May 2020 17:21:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f22cca60-40a8-571d-d5fa-50d05281cc3f@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob, Robin,

On 5/8/2020 2:19 PM, Kishon Vijay Abraham I wrote:
> Hi Rob,
> 
> On 5/8/2020 1:56 AM, Rob Herring wrote:
>> On Wed, May 06, 2020 at 08:52:13AM +0530, Kishon Vijay Abraham I wrote:
>>> Hi Robin,
>>>
>>> On 5/4/2020 6:23 PM, Kishon Vijay Abraham I wrote:
>>>> Hi Robin,
>>>>
>>>> On 5/4/2020 4:24 PM, Robin Murphy wrote:
>>>>> On 2020-05-04 9:44 am, Kishon Vijay Abraham I wrote:
>>>>>> Hi Robin,
>>>>>>
>>>>>> On 5/1/2020 9:24 PM, Robin Murphy wrote:
>>>>>>> On 2020-05-01 3:46 pm, Lorenzo Pieralisi wrote:
>>>>>>>> [+Robin - to check on dma-ranges intepretation]
>>>>>>>>
>>>>>>>> I would need RobH and Robin to review this.
>>>>>>>>
>>>>>>>> Also, An ACK from Tom is required - for the whole series.
>>>>>>>>
>>>>>>>> On Fri, Apr 17, 2020 at 05:13:20PM +0530, Kishon Vijay Abraham I wrote:
>>>>>>>>> Cadence PCIe core driver (host mode) uses "cdns,no-bar-match-nbits"
>>>>>>>>> property to configure the number of bits passed through from PCIe
>>>>>>>>> address to internal address in Inbound Address Translation register.
>>>>>>>>>
>>>>>>>>> However standard PCI dt-binding already defines "dma-ranges" to
>>>>>>>>> describe the address range accessible by PCIe controller. Parse
>>>>>>>>> "dma-ranges" property to configure the number of bits passed
>>>>>>>>> through from PCIe address to internal address in Inbound Address
>>>>>>>>> Translation register.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>>>>>> ---
>>>>>>>>>    drivers/pci/controller/cadence/pcie-cadence-host.c | 13 +++++++++++--
>>>>>>>>>    1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>>>>>>> b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>>>>>>> index 9b1c3966414b..60f912a657b9 100644
>>>>>>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>>>>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>>>>>>> @@ -206,8 +206,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>>>>>>>>        struct device *dev = rc->pcie.dev;
>>>>>>>>>        struct platform_device *pdev = to_platform_device(dev);
>>>>>>>>>        struct device_node *np = dev->of_node;
>>>>>>>>> +    struct of_pci_range_parser parser;
>>>>>>>>>        struct pci_host_bridge *bridge;
>>>>>>>>>        struct list_head resources;
>>>>>>>>> +    struct of_pci_range range;
>>>>>>>>>        struct cdns_pcie *pcie;
>>>>>>>>>        struct resource *res;
>>>>>>>>>        int ret;
>>>>>>>>> @@ -222,8 +224,15 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>>>>>>>>        rc->max_regions = 32;
>>>>>>>>>        of_property_read_u32(np, "cdns,max-outbound-regions",
>>>>>>>>> &rc->max_regions);
>>>>>>>>>    -    rc->no_bar_nbits = 32;
>>>>>>>>> -    of_property_read_u32(np, "cdns,no-bar-match-nbits", &rc->no_bar_nbits);
>>>>>>>>> +    if (!of_pci_dma_range_parser_init(&parser, np))
>>>>>>>>> +        if (of_pci_range_parser_one(&parser, &range))
>>>>>>>>> +            rc->no_bar_nbits = ilog2(range.size);
>>>>>>>
>>>>>>> You probably want "range.pci_addr + range.size" here just in case the bottom of
>>>>>>> the window is ever non-zero. Is there definitely only ever a single inbound
>>>>>>> window to consider?
>>>>>>
>>>>>> Cadence IP has 3 inbound address translation registers, however we use only 1
>>>>>> inbound address translation register to map the entire 32 bit or 64 bit address
>>>>>> region.
>>>>>
>>>>> OK, if anything that further strengthens the argument for deprecating a single
>>>>> "number of bits" property in favour of ranges that accurately describe the
>>>>> window(s). However it also suggests that other users in future might have some
>>>>> expectation that specifying "dma-ranges" with up to 3 entries should work to
>>>>> allow a more restrictive inbound configuration. Thus it would be desirable to
>>>>> make the code a little more robust here - even if we don't support multiple
>>>>> windows straight off, it would still be better to implement it in a way that
>>>>> can be cleanly extended later, and at least say something if more ranges are
>>>>> specified rather than just silently ignoring them.
>>>>
>>>> I looked at this further in the Cadence user doc. The three inbound ATU entries
>>>> are for BAR0, BAR1 in RC configuration space and the third one is for NO MATCH
>>>> BAR when there is no matching found in RC BARs. Right now we always configure
>>>> the NO MATCH BAR. Would it be possible describe at BAR granularity in dma-ranges?
>>>
>>> I was thinking if I could use something like
>>> dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x00000 0x0>, //For BAR0 IB mapping
>>> 	     <0x02000000 0x0 0x0 0x0 0x0 0x00000 0x0>, //For BAR1 IB mapping
>>> 	     <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>; //NO MATCH BAR
>>>
>>> This way the driver can tell the 1st tuple is for BAR0, 2nd is for BAR1 and
>>> last is for NO MATCH. In the above case both BAR0 and BAR1 is just empty and
>>> doesn't have valid values as we use only the NO MATCH BAR.
>>>
>>> However I'm not able to use for_each_of_pci_range() in Cadence driver to get
>>> the configuration for each BAR, since the for loop gets invoked only once since
>>> of_pci_range_parser_one() merges contiguous addresses.
>>
>> NO_MATCH_BAR could just be the last entry no matter how many? Who cares 
>> if they get merged? Maybe each BAR has max size and dma-ranges could 
>> exceed that, but if so you have to handle that and split them again.
> 
> Each of RP_BAR0, RP_BAR1 and RP_NO_BAR has separate register to be configured.
> If they get merged, we'll loose info on which of the registers to be
> configured. Cadence IP specifies maximum size of BAR0 as 256GB, maximum size of
> BAR1 as 2 GB. However when I specify dma-ranges like below and use
> for_each_of_pci_range(&parser, &range), the first range itself is 258.
> 
> dma-ranges = <0x02000000 0x00 0x0 0x00 0x0 0x40 0x00000000>, /* BAR0 256 GB */
> 	     <0x02000000 0x40 0x0 0x40 0x0 0x00 0x80000000>; /* BAR1 2 GB */
>>
>>> Do you think I should extend the flags cell to differentiate between BAR0, BAR1
>>> and NO MATCH BAR? Can you suggest any other alternatives?
>>
>> If you just have 1 region, then just 1 entry makes sense to me. Why 
>> can't you use BAR0 in that case?
> 
> Well, Cadence has specified a max size for each BAR. I think we could specify a
> single region (48 bits in my case) in dma-ranges and let the driver decide how
> to split it among BAR0, BAR1 and NO_MATCH_BAR?

Okay, I'll add support in driver for parsing multiple dma-ranges (non
consecutive regions) and driver splitting the regions based on maximum size
supported by each BAR.

This means, we will not directly use NO_MATCH_BAR, but wil first fill up BAR0,
BAR1 and then only the remaining space in NO_MATCH_BAR.

Thanks
Kishon
