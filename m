Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9B11C34BB
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 10:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgEDIon (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 04:44:43 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58854 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgEDIon (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 04:44:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0448iaJb095179;
        Mon, 4 May 2020 03:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588581876;
        bh=MJFZeP9Kt0d/U5r8cedlUqKEgzNmU/L56TzLmHNhuwA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rUWaCASbPDM5c8AbQEl/BHEC1S34pGHrrmTIrCEytrpIRC7r43gMhnh2SEwVSoDsQ
         kWbrAWHMXTO5XjofI2djF5EIlUPNUI/1wCAqM17XhbB+4htYTn8vKCVmWIOSpB7OZ7
         xX5ee6Zi4IF739eyV3OvEtRPGfm75XxIttsbnN/M=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0448iafK069176
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 May 2020 03:44:36 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 May
 2020 03:44:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 May 2020 03:44:36 -0500
Received: from [10.250.150.106] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0448iUss019965;
        Mon, 4 May 2020 03:44:31 -0500
Subject: Re: [PATCH v2 2/4] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
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
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2472c182-834c-d2c1-175e-4d73898aef35@ti.com>
Date:   Mon, 4 May 2020 14:14:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dc581c5b-11de-f4b3-e928-208b9293e391@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robin,

On 5/1/2020 9:24 PM, Robin Murphy wrote:
> On 2020-05-01 3:46 pm, Lorenzo Pieralisi wrote:
>> [+Robin - to check on dma-ranges intepretation]
>>
>> I would need RobH and Robin to review this.
>>
>> Also, An ACK from Tom is required - for the whole series.
>>
>> On Fri, Apr 17, 2020 at 05:13:20PM +0530, Kishon Vijay Abraham I wrote:
>>> Cadence PCIe core driver (host mode) uses "cdns,no-bar-match-nbits"
>>> property to configure the number of bits passed through from PCIe
>>> address to internal address in Inbound Address Translation register.
>>>
>>> However standard PCI dt-binding already defines "dma-ranges" to
>>> describe the address range accessible by PCIe controller. Parse
>>> "dma-ranges" property to configure the number of bits passed
>>> through from PCIe address to internal address in Inbound Address
>>> Translation register.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>   drivers/pci/controller/cadence/pcie-cadence-host.c | 13 +++++++++++--
>>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> index 9b1c3966414b..60f912a657b9 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> @@ -206,8 +206,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>>       struct device *dev = rc->pcie.dev;
>>>       struct platform_device *pdev = to_platform_device(dev);
>>>       struct device_node *np = dev->of_node;
>>> +    struct of_pci_range_parser parser;
>>>       struct pci_host_bridge *bridge;
>>>       struct list_head resources;
>>> +    struct of_pci_range range;
>>>       struct cdns_pcie *pcie;
>>>       struct resource *res;
>>>       int ret;
>>> @@ -222,8 +224,15 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>>       rc->max_regions = 32;
>>>       of_property_read_u32(np, "cdns,max-outbound-regions", &rc->max_regions);
>>>   -    rc->no_bar_nbits = 32;
>>> -    of_property_read_u32(np, "cdns,no-bar-match-nbits", &rc->no_bar_nbits);
>>> +    if (!of_pci_dma_range_parser_init(&parser, np))
>>> +        if (of_pci_range_parser_one(&parser, &range))
>>> +            rc->no_bar_nbits = ilog2(range.size);
> 
> You probably want "range.pci_addr + range.size" here just in case the bottom of
> the window is ever non-zero. Is there definitely only ever a single inbound
> window to consider?

Cadence IP has 3 inbound address translation registers, however we use only 1
inbound address translation register to map the entire 32 bit or 64 bit address
region.
> 
> I believe that pci_parse_request_of_pci_ranges() could do the actual parsing
> for you, but I suppose plumbing that in plus processing the resulting
> dma_ranges resource probably ends up a bit messier than the concise open-coding
> here.

right, pci_parse_request_of_pci_ranges() parses "ranges" property and is used
for outbound configuration, whereas here we parse "dma-ranges" property and is
used for inbound configuration.

Thanks
Kishon

> 
> Robin.
> 
>>> +
>>> +    if (!rc->no_bar_nbits) {
>>> +        rc->no_bar_nbits = 32;
>>> +        of_property_read_u32(np, "cdns,no-bar-match-nbits",
>>> +                     &rc->no_bar_nbits);
>>> +    }
>>>         rc->vendor_id = 0xffff;
>>>       of_property_read_u16(np, "vendor-id", &rc->vendor_id);
>>> -- 
>>> 2.17.1
>>>
