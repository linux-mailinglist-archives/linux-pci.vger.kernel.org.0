Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1D682CCC
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 13:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjAaMnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 07:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjAaMnJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 07:43:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D34A29173;
        Tue, 31 Jan 2023 04:43:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 088342F4;
        Tue, 31 Jan 2023 04:43:50 -0800 (PST)
Received: from [10.57.88.157] (unknown [10.57.88.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D84443F71E;
        Tue, 31 Jan 2023 04:43:05 -0800 (PST)
Message-ID: <c014b074-6d7f-773b-533a-c0500e239ab8@arm.com>
Date:   Tue, 31 Jan 2023 12:42:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 0/2] PCI: dwc: Add support for 64-bit MSI target
 addresses
Content-Language: en-GB
To:     Evgenii Shatokhin <e.shatokhin@yadro.com>,
        Will McVicker <willmcvicker@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux@yadro.com
References: <20220825235404.4132818-1-willmcvicker@google.com>
 <decae9e4-3446-2384-4fc5-4982b747ac03@yadro.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <decae9e4-3446-2384-4fc5-4982b747ac03@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-01-31 12:29, Evgenii Shatokhin wrote:
> Hi,
> 
> On 26.08.2022 02:54, Will McVicker wrote:
>> Hi All,
>>
>> I've update patch 2/2 to address Robin's suggestions. This includes:
>>
>>   * Dropping the while-loop for retrying with a 64-bit mask in favor of
>>     retrying within the error if-statement.
>>   * Using an int for the DMA mask instead of a bool and ternary 
>> operation.
>>
>> Thanks again for the reviews and sorry for the extra revision today!
>> Hopefully this is the last one :) If not, I'd be fine to submit patch 1/2
>> without 2/2 to avoid resending patch 1/2 for future revisions of patch 
>> 2/2
>> (unless I don't need to do that anyway).
> 
> The first patch of the series made it into the mainline kernel, but, it 
> seems, the second one ("PCI: dwc: Add support for 64-bit MSI target 
> address") did not. As of 6.2-rc6, it is still missing.
> 
> Was it intentionally dropped because of some issues or, perhaps, just by 
> accident? If it was by accident, could you please queue it for inclusion 
> into mainline again?

Yes, it was dropped due to the PCI_MSI_FLAGS_64BIT usage apparently 
being incorrect, and some other open debate (which all happened on the 
v5 thread):

https://lore.kernel.org/linux-pci/YzVTmy9MWh+AjshC@lpieralisi/

The DMA mask issues have now been sorted out, so you, or Will, or anyone 
else interested should be free to rework this on top of linux-next 
(although at this point, more realistically on top of 6.3-rc1 in a few 
weeks).

Thanks,
Robin.

> Support for 64-bit MSI target addresses is needed for some of our SoCs. 
> I ran into a situation when there was no available RAM in ZONE_DMA32 
> during initialization of PCIe host. Hence, dmam_alloc_coherent() failed 
> in dw_pcie_msi_host_init() and initialization failed with -ENOMEM:
> 
> [    0.374834] dw-pcie 4000000.pcie0: host bridge /soc/pcie0@4000000 
> ranges:
> [    0.375813] dw-pcie 4000000.pcie0:      MEM 
> 0x0041000000..0x004fffffff -> 0x0041000000
> [    0.376171] dw-pcie 4000000.pcie0:   IB MEM 
> 0x0400000000..0x07ffffffff -> 0x0400000000
> [    0.377914] dw-pcie 4000000.pcie0: Failed to alloc and map MSI data
> [    0.378191] dw-pcie 4000000.pcie0: Failed to initialize host
> [    0.378255] dw-pcie: probe of 4000000.pcie0 failed with error -12
> 
> Mainline kernel 6.2-rc6 was used in that test.
> 
> The hardware supports 64-bit target addresses, so the patch "PCI: dwc: 
> Add support for 64-bit MSI target address" should help with this 
> particular failure.
> 
> 
>>
>> Thanks,
>> Will
>>
>> Will McVicker (2):
>>    PCI: dwc: Drop dependency on ZONE_DMA32
>>
>> v6:
>>   * Retrying DMA allocation with 64-bit mask within the error 
>> if-statement.
>>   * Use an int for the DMA mask instead of a bool and ternary operation.
>>
>> v5:
>>   * Updated patch 2/2 to first try with a 32-bit DMA mask. On failure,
>>     retry with a 64-bit mask if supported.
>>
>> v4:
>>   * Updated commit descriptions.
>>   * Renamed msi_64b -> msi_64bit.
>>   * Dropped msi_64bit ternary use.
>>   * Dropped export of dw_pcie_msi_capabilities.
>>
>> v3:
>>    * Switched to a managed DMA allocation.
>>    * Simplified the DMA allocation cleanup.
>>    * Dropped msi_page from struct dw_pcie_rp.
>>    * Allocating a u64 instead of a full page.
>>
>> v2:
>>    * Fixed build error caught by kernel test robot
>>    * Fixed error handling reported by Isaac Manjarres
>>   PCI: dwc: Add support for 64-bit MSI target address
>>
>>   .../pci/controller/dwc/pcie-designware-host.c | 43 +++++++++----------
>>   drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++
>>   drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>>   3 files changed, 30 insertions(+), 23 deletions(-)
>>
>>
>> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> 
> Thank you in advance.
> 
> Regards,
> Evgenii
> 
> 
> 
