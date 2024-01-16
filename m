Return-Path: <linux-pci+bounces-2230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EE382FC79
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 23:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6726FB216C5
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 22:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6093728E28;
	Tue, 16 Jan 2024 21:02:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654828E27
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438979; cv=none; b=c4HCNksA7RcX2lre3fj+KJulyecYQxsywCGrEu8+GazGuoaVZq/ALWVynWEeyCHdqJJytziRAXhjkU1oWEELs0v8ZCap2p1/e07zfN/yZua1OlqS9t9vohbDbfK03eruSc6lIloQeKeQnb9IueOFwEJNWr24+h3jPtdCcFqTcdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438979; c=relaxed/simple;
	bh=dYBaZA4dWUVi5F8/FGK+HnSXkfdfqazY+vj+l52efz0=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=emkg7ETMKvFUH7GQkl8u3QbsPx/M9+g0mYnMzLdumkAAU1B+Bwm2UcnZ/j+t9Mo1rOGbyDOEabWclHS7GSjPKK4sf6shYGWgvCxpxFm5gtRM7u9cW1tL8VWT3I8zVu/Ri5cbbg9sgeSJJWdkpERQpelGOX/EHkXft+Fpw+Ck6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D831A2F4;
	Tue, 16 Jan 2024 13:03:41 -0800 (PST)
Received: from [10.57.46.210] (unknown [10.57.46.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D48A3F73F;
	Tue, 16 Jan 2024 13:02:53 -0800 (PST)
Message-ID: <5ef31b1c-3069-4da7-8124-44efba0ad718@arm.com>
Date: Tue, 16 Jan 2024 21:02:48 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: dwc: Strengthen the MSI address allocation logic
To: Sajid Dalvi <sdalvi@google.com>
Cc: Ajay Agarwal <ajayagarwal@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Manu Gautam <manugautam@google.com>,
 William McVicker <willmcvicker@google.com>,
 Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org
References: <20240111042103.392939-1-ajayagarwal@google.com>
 <b1ef4ad8-99c4-46ba-90fd-d57bd17163b9@arm.com>
 <CAEbtx1=hoDTtpkavk7gp5tmcvdYj6euAuDsQYRPW=EDeVsbUqg@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAEbtx1=hoDTtpkavk7gp5tmcvdYj6euAuDsQYRPW=EDeVsbUqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-01-16 5:18 pm, Sajid Dalvi wrote:
> On Tue, Jan 16, 2024 at 7:30 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2024-01-11 4:21 am, Ajay Agarwal wrote:
>>> There can be platforms that do not use/have 32-bit DMA addresses
>>> but want to enumerate endpoints which support only 32-bit MSI
>>> address. The current implementation of 32-bit IOVA allocation can
>>> fail for such platforms, eventually leading to the probe failure.
>>>
>>> If there is a memory region reserved for the pci->dev, pick up
>>> the MSI data from this region. This can be used by the platforms
>>> described above.
>>>
>>> Else, if the memory region is not reserved, try to allocate a
>>> 32-bit IOVA. Additionally, if this allocation also fails, attempt
>>> a 64-bit allocation for probe to be successful. If the 64-bit MSI
>>> address is allocated, then the EPs supporting 32-bit MSI address
>>> will not work.
>>>
>>> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
>>> ---
>>> Changelog since v1:
>>>    - Use reserved memory, if it exists, to setup the MSI data
>>>    - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
>>>
>>>    .../pci/controller/dwc/pcie-designware-host.c | 50 ++++++++++++++-----
>>>    drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>>>    2 files changed, 39 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index 7991f0e179b2..8c7c77b49ca8 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -331,6 +331,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp
> *pp)
>>>        u64 *msi_vaddr;
>>>        int ret;
>>>        u32 ctrl, num_ctrls;
>>> +     struct device_node *np;
>>> +     struct resource r;
>>>
>>>        for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>>>                pp->irq_mask[ctrl] = ~0;
>>> @@ -374,20 +376,44 @@ static int dw_pcie_msi_host_init(struct
> dw_pcie_rp *pp)
>>>         * order not to miss MSI TLPs from those devices the MSI target
>>>         * address has to be within the lowest 4GB.
>>>         *
>>> -      * Note until there is a better alternative found the reservation
> is
>>> -      * done by allocating from the artificially limited DMA-coherent
>>> -      * memory.
>>> +      * Check if there is memory region reserved for this device. If
> yes,
>>> +      * pick up the msi_data from this region. This will be helpful for
>>> +      * platforms that do not use/have 32-bit DMA addresses but want
> to use
>>> +      * endpoints which support only 32-bit MSI address.
>>> +      * Else, if the memory region is not reserved, try to allocate a
> 32-bit
>>> +      * IOVA. Additionally, if this allocation also fails, attempt a
> 64-bit
>>> +      * allocation. If the 64-bit MSI address is allocated, then the
> EPs
>>> +      * supporting 32-bit MSI address will not work.
>>>         */
>>> -     ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>>> -     if (ret)
>>> -             dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices
> with only 32-bit MSI support may not work properly\n");
>>> +     np = of_parse_phandle(dev->of_node, "memory-region", 0);
>>> +     if (np) {
>>> +             ret = of_address_to_resource(np, 0, &r);
>>
>> This is incorrect in several ways - reserved-memory nodes represent
>> actual system memory, so can't be used to reserve arbitrary PCI memory
>> space (which may be different if DMA offsets are involved); the whole
>> purpose of going through the DMA API is to ensure we get a unique *bus*
>> address. Obviously we don't want to reserve actual memory for something
>> that functionally doesn't need it, but conversely having a
>> reserved-memory region for an address which isn't memory would be
>> nonsensical. And even if this *were* a viable approach, you haven't
>> updated the DWC binding to allow it, nor defined a reserved-memory
>> binding for the node itself.
>>
>> If it was reasonable to put something in DT at all, then the logical
>> thing would be a property expressing an MSI address directly on the
>> controller node itself, but even that would be dictating software policy
>> rather than describing an aspect of the platform itself. Plus this is
>> far from the only driver with this concern, so it wouldn't make much
>> sense to hack just one binding without all the others as well. The rest
>> of the DT already describes everything an OS needs to know in order to
>> decide an MSI address to use, it's just a matter of making this
>> particular OS do a better job of putting it all together.
>>
>> Thanks,
>> Robin.
>>
> 
> Robin,
> Needed some clarification.
> It seems you are implying that the pcie device tree node should define a
> property for the MSI address within the PCIe address space.
> However, you also state that this would not be an ideal solution, and
> would prefer using existing device tree constructs.
> I am not sure what you mean by, " The rest of the DT already describes
> everything."
> Do you mean adding an "msi" reg to reg-names and defining the address
> in the reg list?

No, I'm saying the closest this should come to DT at all is the 
possibility of the low-level driver hard-coding a platform-specific 
value for pp->msi_data based on some platform-specific compatible, as 
Serge pointed to on v1.

Otherwise, based on the system memory layout and dma-ranges of the 
controller node we have enough information to figure out what PCI bus 
address ranges can't collide with any valid DMA mapping of RAM, and thus 
generate a suitable MSI address, but that really wants to be a generic 
PCI-layer helper (which could also generically implement the various DMA 
API tricks as a fallback if necessary).

Thanks,
Robin.

