Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1911C6640
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 05:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgEFDWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 23:22:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47710 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgEFDWZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 23:22:25 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0463MGLY018236;
        Tue, 5 May 2020 22:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588735336;
        bh=+l9g+vvaMAa3ISpy32FUOkycsSQuNXMcAXMcDkFvLlQ=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=xag0cpQd3UUbSz3qG8U8KD8r1CvzgCC3AihLmD8oUQKtakPJIS/y2AyH+roXovQfj
         2S0b8rqZed79s8HhfFXkrEV+rgkKo4FJiN4bx09j+UJzE+zooUZdMudGJ8GQSfrJxf
         aqOADqTPqKE9phOW7RYkgJ+EeiQ2AKurUbVuUdS8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0463MGp5069015
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 May 2020 22:22:16 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 5 May
 2020 22:22:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 5 May 2020 22:22:16 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0463MD5R076978;
        Tue, 5 May 2020 22:22:14 -0500
Subject: Re: [PATCH v2 2/4] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <da933b0d-ee17-5bca-3763-1d73c7ed6bfc@ti.com>
Date:   Wed, 6 May 2020 08:52:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cf9c2dcc-57e8-cfa0-e3b4-55ff5113341f@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robin,

On 5/4/2020 6:23 PM, Kishon Vijay Abraham I wrote:
> Hi Robin,
> 
> On 5/4/2020 4:24 PM, Robin Murphy wrote:
>> On 2020-05-04 9:44 am, Kishon Vijay Abraham I wrote:
>>> Hi Robin,
>>>
>>> On 5/1/2020 9:24 PM, Robin Murphy wrote:
>>>> On 2020-05-01 3:46 pm, Lorenzo Pieralisi wrote:
>>>>> [+Robin - to check on dma-ranges intepretation]
>>>>>
>>>>> I would need RobH and Robin to review this.
>>>>>
>>>>> Also, An ACK from Tom is required - for the whole series.
>>>>>
>>>>> On Fri, Apr 17, 2020 at 05:13:20PM +0530, Kishon Vijay Abraham I wrote:
>>>>>> Cadence PCIe core driver (host mode) uses "cdns,no-bar-match-nbits"
>>>>>> property to configure the number of bits passed through from PCIe
>>>>>> address to internal address in Inbound Address Translation register.
>>>>>>
>>>>>> However standard PCI dt-binding already defines "dma-ranges" to
>>>>>> describe the address range accessible by PCIe controller. Parse
>>>>>> "dma-ranges" property to configure the number of bits passed
>>>>>> through from PCIe address to internal address in Inbound Address
>>>>>> Translation register.
>>>>>>
>>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>>> ---
>>>>>>    drivers/pci/controller/cadence/pcie-cadence-host.c | 13 +++++++++++--
>>>>>>    1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>>>> b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>>>> index 9b1c3966414b..60f912a657b9 100644
>>>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>>>> @@ -206,8 +206,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>>>>>        struct device *dev = rc->pcie.dev;
>>>>>>        struct platform_device *pdev = to_platform_device(dev);
>>>>>>        struct device_node *np = dev->of_node;
>>>>>> +    struct of_pci_range_parser parser;
>>>>>>        struct pci_host_bridge *bridge;
>>>>>>        struct list_head resources;
>>>>>> +    struct of_pci_range range;
>>>>>>        struct cdns_pcie *pcie;
>>>>>>        struct resource *res;
>>>>>>        int ret;
>>>>>> @@ -222,8 +224,15 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>>>>>        rc->max_regions = 32;
>>>>>>        of_property_read_u32(np, "cdns,max-outbound-regions",
>>>>>> &rc->max_regions);
>>>>>>    -    rc->no_bar_nbits = 32;
>>>>>> -    of_property_read_u32(np, "cdns,no-bar-match-nbits", &rc->no_bar_nbits);
>>>>>> +    if (!of_pci_dma_range_parser_init(&parser, np))
>>>>>> +        if (of_pci_range_parser_one(&parser, &range))
>>>>>> +            rc->no_bar_nbits = ilog2(range.size);
>>>>
>>>> You probably want "range.pci_addr + range.size" here just in case the bottom of
>>>> the window is ever non-zero. Is there definitely only ever a single inbound
>>>> window to consider?
>>>
>>> Cadence IP has 3 inbound address translation registers, however we use only 1
>>> inbound address translation register to map the entire 32 bit or 64 bit address
>>> region.
>>
>> OK, if anything that further strengthens the argument for deprecating a single
>> "number of bits" property in favour of ranges that accurately describe the
>> window(s). However it also suggests that other users in future might have some
>> expectation that specifying "dma-ranges" with up to 3 entries should work to
>> allow a more restrictive inbound configuration. Thus it would be desirable to
>> make the code a little more robust here - even if we don't support multiple
>> windows straight off, it would still be better to implement it in a way that
>> can be cleanly extended later, and at least say something if more ranges are
>> specified rather than just silently ignoring them.
> 
> I looked at this further in the Cadence user doc. The three inbound ATU entries
> are for BAR0, BAR1 in RC configuration space and the third one is for NO MATCH
> BAR when there is no matching found in RC BARs. Right now we always configure
> the NO MATCH BAR. Would it be possible describe at BAR granularity in dma-ranges?

I was thinking if I could use something like
dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x00000 0x0>, //For BAR0 IB mapping
	     <0x02000000 0x0 0x0 0x0 0x0 0x00000 0x0>, //For BAR1 IB mapping
	     <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>; //NO MATCH BAR

This way the driver can tell the 1st tuple is for BAR0, 2nd is for BAR1 and
last is for NO MATCH. In the above case both BAR0 and BAR1 is just empty and
doesn't have valid values as we use only the NO MATCH BAR.

However I'm not able to use for_each_of_pci_range() in Cadence driver to get
the configuration for each BAR, since the for loop gets invoked only once since
of_pci_range_parser_one() merges contiguous addresses.

Do you think I should extend the flags cell to differentiate between BAR0, BAR1
and NO MATCH BAR? Can you suggest any other alternatives?

Thanks
Kishon

>>
>>>> I believe that pci_parse_request_of_pci_ranges() could do the actual parsing
>>>> for you, but I suppose plumbing that in plus processing the resulting
>>>> dma_ranges resource probably ends up a bit messier than the concise open-coding
>>>> here.
>>>
>>> right, pci_parse_request_of_pci_ranges() parses "ranges" property and is used
>>> for outbound configuration, whereas here we parse "dma-ranges" property and is
>>> used for inbound configuration.
>>
>> If you give it a valid third argument it *also* parses "dma-ranges" into a list
>> of inbound regions. This is already used by various other drivers for
>> equivalent inbound window setup, which is what I was hinting at before, but
>> given the extensibility argument above I'm now going to actively suggest
>> following that pattern for consistency.
> yeah, just got to know about this.
> 
> Thanks
> Kishon
> 
