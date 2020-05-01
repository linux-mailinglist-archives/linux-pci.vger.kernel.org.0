Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B141C1A1C
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 17:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgEAPyV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 11:54:21 -0400
Received: from foss.arm.com ([217.140.110.172]:43100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEAPyV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 11:54:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECF6630E;
        Fri,  1 May 2020 08:54:20 -0700 (PDT)
Received: from [10.57.39.240] (unknown [10.57.39.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 778A63F68F;
        Fri,  1 May 2020 08:54:19 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200417114322.31111-1-kishon@ti.com>
 <20200417114322.31111-3-kishon@ti.com>
 <20200501144645.GB7398@e121166-lin.cambridge.arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <dc581c5b-11de-f4b3-e928-208b9293e391@arm.com>
Date:   Fri, 1 May 2020 16:54:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501144645.GB7398@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-05-01 3:46 pm, Lorenzo Pieralisi wrote:
> [+Robin - to check on dma-ranges intepretation]
> 
> I would need RobH and Robin to review this.
> 
> Also, An ACK from Tom is required - for the whole series.
> 
> On Fri, Apr 17, 2020 at 05:13:20PM +0530, Kishon Vijay Abraham I wrote:
>> Cadence PCIe core driver (host mode) uses "cdns,no-bar-match-nbits"
>> property to configure the number of bits passed through from PCIe
>> address to internal address in Inbound Address Translation register.
>>
>> However standard PCI dt-binding already defines "dma-ranges" to
>> describe the address range accessible by PCIe controller. Parse
>> "dma-ranges" property to configure the number of bits passed
>> through from PCIe address to internal address in Inbound Address
>> Translation register.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   drivers/pci/controller/cadence/pcie-cadence-host.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 9b1c3966414b..60f912a657b9 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -206,8 +206,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>   	struct device *dev = rc->pcie.dev;
>>   	struct platform_device *pdev = to_platform_device(dev);
>>   	struct device_node *np = dev->of_node;
>> +	struct of_pci_range_parser parser;
>>   	struct pci_host_bridge *bridge;
>>   	struct list_head resources;
>> +	struct of_pci_range range;
>>   	struct cdns_pcie *pcie;
>>   	struct resource *res;
>>   	int ret;
>> @@ -222,8 +224,15 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>   	rc->max_regions = 32;
>>   	of_property_read_u32(np, "cdns,max-outbound-regions", &rc->max_regions);
>>   
>> -	rc->no_bar_nbits = 32;
>> -	of_property_read_u32(np, "cdns,no-bar-match-nbits", &rc->no_bar_nbits);
>> +	if (!of_pci_dma_range_parser_init(&parser, np))
>> +		if (of_pci_range_parser_one(&parser, &range))
>> +			rc->no_bar_nbits = ilog2(range.size);

You probably want "range.pci_addr + range.size" here just in case the 
bottom of the window is ever non-zero. Is there definitely only ever a 
single inbound window to consider?

I believe that pci_parse_request_of_pci_ranges() could do the actual 
parsing for you, but I suppose plumbing that in plus processing the 
resulting dma_ranges resource probably ends up a bit messier than the 
concise open-coding here.

Robin.

>> +
>> +	if (!rc->no_bar_nbits) {
>> +		rc->no_bar_nbits = 32;
>> +		of_property_read_u32(np, "cdns,no-bar-match-nbits",
>> +				     &rc->no_bar_nbits);
>> +	}
>>   
>>   	rc->vendor_id = 0xffff;
>>   	of_property_read_u16(np, "vendor-id", &rc->vendor_id);
>> -- 
>> 2.17.1
>>
