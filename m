Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3F69CB03
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 13:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjBTM1v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 07:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjBTM1u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 07:27:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 614741A94E;
        Mon, 20 Feb 2023 04:27:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F1C6C14;
        Mon, 20 Feb 2023 04:26:35 -0800 (PST)
Received: from [192.168.1.102] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 308AF3F881;
        Mon, 20 Feb 2023 04:25:51 -0800 (PST)
Message-ID: <5b3b3017-d9bf-a1dc-4361-f974a5845dbc@arm.com>
Date:   Mon, 20 Feb 2023 12:25:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBQQ0k6IG9mOiBXYXJuIGlmIGJyaWRn?=
 =?UTF-8?Q?e_base/limit_region_overlaps_with_system_ram_region?=
To:     Bjorn Helgaas <helgaas@kernel.org>, guo.ziliang@zte.com.cn
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, chen.lin5@zte.com.cn,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20230216233546.GA3354802@bhelgaas>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230216233546.GA3354802@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-02-16 23:35, Bjorn Helgaas wrote:
> [+cc Joerg, Will, Robin]
> 
> On Mon, Jan 09, 2023 at 04:35:25PM +0800, guo.ziliang@zte.com.cn wrote:
>> bridge base/limit(memory behind in lspci info, outbound pcie address/size)
>> region is used to route outbound mem read/write transaction to ep. This
>> base/limit region also may filter out inbound transactions which will
>> result in inbound(eg: dma) transaction fail.
>>
>> For example, if bridge base/limit is [0x20000000, 0x203fffff], system ram
>> is [0x20000000, 0x27ffffff]. The inbound mapping is usually 1:1 equal
>> mapping. When allocated system ram for inbound tansaction is 0x20004000
>> (any in bridge base/limit), this inbound transactions will be filter out.
>>
>> AER may report 'UnsupReq' on inbound mem read/write transactions if address
>> is in this base/limit region, but not all pcie AER enabled or work well. We
>> warn it also in bridge pci address setting phase.
>>
>> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
> 
> This would need the 0-day warnings cleaned up, of course.
> 
>> ---
>>   drivers/pci/setup-bus.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index b4096598dbcb..1a9f527d2317 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -608,6 +608,24 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
>>   	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, io_upper16);
>>   }
>>
>> +static void check_bridge_region_overlaps_systemram(struct pci_dev *bridge,
>> +							struct pci_bus_region *region)
>> +{
>> +	int is_ram;
>> +
>> +	/*
>> +	 * bridge base/limit(memory behind) region may filter out inbound
>> +	 * transactions which will result in inbound(eg: dma) fail of ep.
>> +	 * AER may report it if enabled, we warn it also.
>> +	 */
>> +	is_ram = region_intersects(region->start, region->end - region->start + 1,
>> +				IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
>> +	if (is_ram == REGION_INTERSECTS) {
>> +		pci_warn(bridge, "%#012llx..%#012llx bridge base/limit region overlaps with system ram, may result in inbound fail\n",
>> +			region->start, region->end);
> 
> This compares PCI bus addresses (from struct pci_bus_region) with CPU
> physical addresses (the struct resources used by region_intersects()).
> 
> But I don't think you can do that directly because an IOMMU might map
> those PCI bus addresses to something different before a DMA gets to
> system RAM.
> 
> I see that you say "The inbound mapping is usually 1:1 equal mapping"
> above, so maybe I'm missing something.  Maybe the IOMMU folks will
> clue me in.

IOMMUs typically wouldn't be reflected here - in fact they would 
typically hide this issue anyway, since inbound DMA would then be to 
virtual addresses anywhere in PCI Mem space (and we try our best to 
carve out the regions used for outbound resources). However there 
certainly exist systems where the PCI host bridge itself makes a static 
non-identity translation between PCI Mem space and system PA space, with 
potentially different mappings for inbound vs. outbound as well. So 
indeed, this code looks wrong - at the very least any consideration of 
region->offset is missing (assuming that's initialised correctly in this 
context), but that still won't account for inbound translation.

In fact this is really the same thing as in the recent discussions of 
the MSI thing in the DWC driver - it's all a matter of whether a bus 
address may overlap a valid DMA address or not. A mechanism for making 
that check properly would go hand-in-hand with the mechanism we need for 
allocating such bus addresses for inline MSI widgets.

Thanks,
Robin.

>> +	}
>> +}
>> +
>>   static void pci_setup_bridge_mmio(struct pci_dev *bridge)
>>   {
>>   	struct resource *res;
>> @@ -621,6 +639,7 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
>>   		l = (region.start >> 16) & 0xfff0;
>>   		l |= region.end & 0xfff00000;
>>   		pci_info(bridge, "  bridge window %pR\n", res);
>> +		check_bridge_region_overlaps_systemram(bridge, &region);
>>   	} else {
>>   		l = 0x0000fff0;
>>   	}
>> @@ -652,6 +671,7 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
>>   			lu = upper_32_bits(region.end);
>>   		}
>>   		pci_info(bridge, "  bridge window %pR\n", res);
>> +		check_bridge_region_overlaps_systemram(bridge, &region);
>>   	} else {
>>   		l = 0x0000fff0;
>>   	}
>> -- 
>> 2.15.2
