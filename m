Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E854D1C3744
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 12:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgEDKyg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 06:54:36 -0400
Received: from foss.arm.com ([217.140.110.172]:41690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgEDKy2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 06:54:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 651541FB;
        Mon,  4 May 2020 03:54:27 -0700 (PDT)
Received: from [10.57.39.240] (unknown [10.57.39.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0209B3F71F;
        Mon,  4 May 2020 03:54:25 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200417114322.31111-1-kishon@ti.com>
 <20200417114322.31111-3-kishon@ti.com>
 <20200501144645.GB7398@e121166-lin.cambridge.arm.com>
 <dc581c5b-11de-f4b3-e928-208b9293e391@arm.com>
 <2472c182-834c-d2c1-175e-4d73898aef35@ti.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4f333ceb-2809-c4ae-4ae3-33a83c612cd3@arm.com>
Date:   Mon, 4 May 2020 11:54:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2472c182-834c-d2c1-175e-4d73898aef35@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-05-04 9:44 am, Kishon Vijay Abraham I wrote:
> Hi Robin,
> 
> On 5/1/2020 9:24 PM, Robin Murphy wrote:
>> On 2020-05-01 3:46 pm, Lorenzo Pieralisi wrote:
>>> [+Robin - to check on dma-ranges intepretation]
>>>
>>> I would need RobH and Robin to review this.
>>>
>>> Also, An ACK from Tom is required - for the whole series.
>>>
>>> On Fri, Apr 17, 2020 at 05:13:20PM +0530, Kishon Vijay Abraham I wrote:
>>>> Cadence PCIe core driver (host mode) uses "cdns,no-bar-match-nbits"
>>>> property to configure the number of bits passed through from PCIe
>>>> address to internal address in Inbound Address Translation register.
>>>>
>>>> However standard PCI dt-binding already defines "dma-ranges" to
>>>> describe the address range accessible by PCIe controller. Parse
>>>> "dma-ranges" property to configure the number of bits passed
>>>> through from PCIe address to internal address in Inbound Address
>>>> Translation register.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>    drivers/pci/controller/cadence/pcie-cadence-host.c | 13 +++++++++++--
>>>>    1 file changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>> b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>> index 9b1c3966414b..60f912a657b9 100644
>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>> @@ -206,8 +206,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>>>        struct device *dev = rc->pcie.dev;
>>>>        struct platform_device *pdev = to_platform_device(dev);
>>>>        struct device_node *np = dev->of_node;
>>>> +    struct of_pci_range_parser parser;
>>>>        struct pci_host_bridge *bridge;
>>>>        struct list_head resources;
>>>> +    struct of_pci_range range;
>>>>        struct cdns_pcie *pcie;
>>>>        struct resource *res;
>>>>        int ret;
>>>> @@ -222,8 +224,15 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>>>        rc->max_regions = 32;
>>>>        of_property_read_u32(np, "cdns,max-outbound-regions", &rc->max_regions);
>>>>    -    rc->no_bar_nbits = 32;
>>>> -    of_property_read_u32(np, "cdns,no-bar-match-nbits", &rc->no_bar_nbits);
>>>> +    if (!of_pci_dma_range_parser_init(&parser, np))
>>>> +        if (of_pci_range_parser_one(&parser, &range))
>>>> +            rc->no_bar_nbits = ilog2(range.size);
>>
>> You probably want "range.pci_addr + range.size" here just in case the bottom of
>> the window is ever non-zero. Is there definitely only ever a single inbound
>> window to consider?
> 
> Cadence IP has 3 inbound address translation registers, however we use only 1
> inbound address translation register to map the entire 32 bit or 64 bit address
> region.

OK, if anything that further strengthens the argument for deprecating a 
single "number of bits" property in favour of ranges that accurately 
describe the window(s). However it also suggests that other users in 
future might have some expectation that specifying "dma-ranges" with up 
to 3 entries should work to allow a more restrictive inbound 
configuration. Thus it would be desirable to make the code a little more 
robust here - even if we don't support multiple windows straight off, it 
would still be better to implement it in a way that can be cleanly 
extended later, and at least say something if more ranges are specified 
rather than just silently ignoring them.

>> I believe that pci_parse_request_of_pci_ranges() could do the actual parsing
>> for you, but I suppose plumbing that in plus processing the resulting
>> dma_ranges resource probably ends up a bit messier than the concise open-coding
>> here.
> 
> right, pci_parse_request_of_pci_ranges() parses "ranges" property and is used
> for outbound configuration, whereas here we parse "dma-ranges" property and is
> used for inbound configuration.

If you give it a valid third argument it *also* parses "dma-ranges" into 
a list of inbound regions. This is already used by various other drivers 
for equivalent inbound window setup, which is what I was hinting at 
before, but given the extensibility argument above I'm now going to 
actively suggest following that pattern for consistency.

Robin.
