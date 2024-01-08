Return-Path: <linux-pci+bounces-1831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFF88276B0
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 18:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A6D1C21C96
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 17:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15434C3DC;
	Mon,  8 Jan 2024 17:50:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DEA54BC3
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C9E7C15;
	Mon,  8 Jan 2024 09:51:16 -0800 (PST)
Received: from [10.57.42.133] (unknown [10.57.42.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAF553F73F;
	Mon,  8 Jan 2024 09:50:28 -0800 (PST)
Message-ID: <0635ac3c-94d3-4de4-bd56-d76de5d17067@arm.com>
Date: Mon, 8 Jan 2024 17:50:26 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Set DMA mask to 32 only if ZONE_DMA32 is
 enabled
Content-Language: en-GB
To: Serge Semin <fancer.lancer@gmail.com>,
 Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>,
 William McVicker <willmcvicker@google.com>, linux-pci@vger.kernel.org
References: <20231221174051.35420-1-ajayagarwal@google.com>
 <y64obwzmcwo2raskreebfyda4sofncnsedzvnh4xo2zrnchokl@ovv4mtqzl7xb>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <y64obwzmcwo2raskreebfyda4sofncnsedzvnh4xo2zrnchokl@ovv4mtqzl7xb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-21 6:33 pm, Serge Semin wrote:
> Hi Ajay
> 
> On Thu, Dec 21, 2023 at 11:10:51PM +0530, Ajay Agarwal wrote:
>> If CONFIG_ZONE_DMA32 is disabled, then the dmam_alloc_coherent
>> will fail to allocate the memory if there are no 32-bit addresses
>> available. This will lead to the PCIe RC probe failure.
>> Fix this by setting the DMA mask to 32 bits only if the kernel
>> configuration enables DMA32 zone. Else, leave the mask as is.
>>
>> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 7991f0e179b2..163a78c5f9d8 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -377,10 +377,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>>   	 * Note until there is a better alternative found the reservation is
>>   	 * done by allocating from the artificially limited DMA-coherent
>>   	 * memory.
>> +	 *
>> +	 * Set the coherent DMA mask to 32 bits only if the DMA32 zone is
>> +	 * supported. Otherwise, leave the mask as is.
>> +	 * This ensures that the dmam_alloc_coherent is successful in
>> +	 * allocating the memory.
>>   	 */
>> +#ifdef CONFIG_ZONE_DMA32
>>   	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>>   	if (ret)
>>   		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
>> +#endif
> 
> Without setting the mask the allocation below may cause having MSI
> data from above 4GB which in its turn will cause MSI not working for
> peripheral PCI-devices supporting 32-bit MSI only. That's the gist of
> this questionable code above and below.

Right, this change is wrong on several levels, as it would end up hiding 
the warning in cases where it would be most relevant.

> The discussion around it can be found here:
> https://lore.kernel.org/linux-pci/20220825185026.3816331-2-willmcvicker@google.com
> and a problem similar to what you described was reported here:
> https://lore.kernel.org/linux-pci/decae9e4-3446-2384-4fc5-4982b747ac03@yadro.com/
> 
> The easiest solution in this case is to somehow pre-define
> pp->msi_data with a PCI-bus address free from RAM behind and avoid
> allocation below at all. The only question is how to do that. See the
> discussions above for details.

FWIW there's also the potential question of whether failing to obtain a 
32-bit address needs to be entirely fatal to probe at all. Perhaps it 
might be reasonable to just continue without MSI support, or maybe retry 
with a larger mask to attempt limited 64-bit-only MSI support - IIRC the 
latter was proposed originally, but Will's initial use-case didn't 
actually need it so we concluded it was hard to justify the complexity 
at the time. The main thing is not to quietly go ahead and do something 
which we can't guarantee to fully work, without at least letting the 
user know.

Thanks,
Robin.

> 
> -Serge(y)
> 
>>   
>>   	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>>   					GFP_KERNEL);
>> -- 
>> 2.43.0.195.gebba966016-goog
>>
>>

