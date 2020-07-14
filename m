Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A3621EF93
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgGNLmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 07:42:39 -0400
Received: from foss.arm.com ([217.140.110.172]:43930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgGNLmi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 07:42:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C87D630E;
        Tue, 14 Jul 2020 04:42:37 -0700 (PDT)
Received: from [10.57.32.45] (unknown [10.57.32.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79D163F7BB;
        Tue, 14 Jul 2020 04:42:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/dma: Avoid SAC address trick for PCIe devices
To:     Joerg Roedel <joro@8bytes.org>
Cc:     hch@lst.de, iommu@lists.linux-foundation.org,
        jonathan.lemon@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
References: <e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com>
 <d412c292d222eb36469effd338e985f9d9e24cd6.1594207679.git.robin.murphy@arm.com>
 <20200713131426.GQ27672@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ad3f66c8-7772-731d-cd0a-c5d6d46297cb@arm.com>
Date:   Tue, 14 Jul 2020 12:42:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713131426.GQ27672@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-07-13 14:14, Joerg Roedel wrote:
> On Wed, Jul 08, 2020 at 12:32:42PM +0100, Robin Murphy wrote:
>> As for the intel-iommu implementation, relegate the opportunistic
>> attempt to allocate a SAC address to the domain of conventional PCI
>> devices only, to avoid it increasingly causing far more performance
>> issues than possible benefits on modern PCI Express systems.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 4959f5df21bd..0ff124f16ad4 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -426,7 +426,8 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>>   		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
>>   
>>   	/* Try to get PCI devices a SAC address */
>> -	if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
>> +	if (dma_limit > DMA_BIT_MASK(32) &&
>> +	    dev_is_pci(dev) && !pci_is_pcie(to_pci_dev(dev)))
>>   		iova = alloc_iova_fast(iovad, iova_len,
>>   				       DMA_BIT_MASK(32) >> shift, false);
>>   
> 
> Unfortunatly this patch causes XHCI initialization failures on my AMD
> Ryzen system. I will remove both from the IOMMU tree for now.
> 
> I guess the XHCI chip in my system does not support full 64bit dma
> addresses and needs a quirk or something like that. But until this is
> resolved its better to not change the IOVA allocation behavior.

Oh bother - yes, this could have been masking all manner of bugs. That 
system will presumably also break if you managed to exhaust the 32-bit 
IOVA space such that the allocator moved up to the higher range anyway, 
or if you passed the XHCI through to a VM with a sufficiently wacky GPA 
layout, but I guess those are cases that simply nobody's run into yet.

Does the firmware actually report any upper address constraint such that 
Sebastian's IVRS aperture patches might help?

Robin.
