Return-Path: <linux-pci+bounces-2821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E09B842B1F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 18:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322111C259CD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1516960897;
	Tue, 30 Jan 2024 17:40:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BD746A3
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636409; cv=none; b=eRXAibcvVi/E9fe/y5QfG46+8axGwI/k8Q2UkKwn/r5DeD9OlDCkm622xwwfxB3IqfCIiGPhHDS7Mfl8i1khY7p3VXmIfFP4K+qBSdgv7T10hfAIAto+C1czOkpfJ9urUEL2dHwdg+IhSkPVDokMWNOfOWm6Seb8CnPJe9Hrs30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636409; c=relaxed/simple;
	bh=JLlmYJadHwBqZGwyng0GE1rA9axKYd9JXInOvSAErCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCVtDftnEHN/9fY9Uuv9YSzw1dmXOJXT3M+8EOJyYT3xBfuUAqyINKmGk2a9xhKpEGriLumn8GwJWmYLcncvGq+A8qMHFRqI+IowMDJPCs3qy6ZfhN1tv1XzwglZ7fVUbxwl0Jh/7A75reorBC3LDNxAS2RlHeq7wgbsFgtzvxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76365DA7;
	Tue, 30 Jan 2024 09:40:44 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 020A63F5A1;
	Tue, 30 Jan 2024 09:39:57 -0800 (PST)
Message-ID: <7bea3e41-1c41-4a05-aca4-637b1bba4cb5@arm.com>
Date: Tue, 30 Jan 2024 17:39:55 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: dwc: Strengthen the MSI address allocation logic
Content-Language: en-GB
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Sajid Dalvi <sdalvi@google.com>, Jingoo Han <jingoohan1@gmail.com>,
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
 <5ef31b1c-3069-4da7-8124-44efba0ad718@arm.com> <ZaoPmgeVfXeseTfN@google.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZaoPmgeVfXeseTfN@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/01/2024 5:58 am, Ajay Agarwal wrote:
> On Tue, Jan 16, 2024 at 09:02:48PM +0000, Robin Murphy wrote:
>> On 2024-01-16 5:18 pm, Sajid Dalvi wrote:
>>> On Tue, Jan 16, 2024 at 7:30 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> On 2024-01-11 4:21 am, Ajay Agarwal wrote:
>>>>> There can be platforms that do not use/have 32-bit DMA addresses
>>>>> but want to enumerate endpoints which support only 32-bit MSI
>>>>> address. The current implementation of 32-bit IOVA allocation can
>>>>> fail for such platforms, eventually leading to the probe failure.
>>>>>
>>>>> If there is a memory region reserved for the pci->dev, pick up
>>>>> the MSI data from this region. This can be used by the platforms
>>>>> described above.
>>>>>
>>>>> Else, if the memory region is not reserved, try to allocate a
>>>>> 32-bit IOVA. Additionally, if this allocation also fails, attempt
>>>>> a 64-bit allocation for probe to be successful. If the 64-bit MSI
>>>>> address is allocated, then the EPs supporting 32-bit MSI address
>>>>> will not work.
>>>>>
>>>>> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
>>>>> ---
>>>>> Changelog since v1:
>>>>>     - Use reserved memory, if it exists, to setup the MSI data
>>>>>     - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
>>>>>
>>>>>     .../pci/controller/dwc/pcie-designware-host.c | 50 ++++++++++++++-----
>>>>>     drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>>>>>     2 files changed, 39 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> index 7991f0e179b2..8c7c77b49ca8 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> @@ -331,6 +331,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp
>>> *pp)
>>>>>         u64 *msi_vaddr;
>>>>>         int ret;
>>>>>         u32 ctrl, num_ctrls;
>>>>> +     struct device_node *np;
>>>>> +     struct resource r;
>>>>>
>>>>>         for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>>>>>                 pp->irq_mask[ctrl] = ~0;
>>>>> @@ -374,20 +376,44 @@ static int dw_pcie_msi_host_init(struct
>>> dw_pcie_rp *pp)
>>>>>          * order not to miss MSI TLPs from those devices the MSI target
>>>>>          * address has to be within the lowest 4GB.
>>>>>          *
>>>>> -      * Note until there is a better alternative found the reservation
>>> is
>>>>> -      * done by allocating from the artificially limited DMA-coherent
>>>>> -      * memory.
>>>>> +      * Check if there is memory region reserved for this device. If
>>> yes,
>>>>> +      * pick up the msi_data from this region. This will be helpful for
>>>>> +      * platforms that do not use/have 32-bit DMA addresses but want
>>> to use
>>>>> +      * endpoints which support only 32-bit MSI address.
>>>>> +      * Else, if the memory region is not reserved, try to allocate a
>>> 32-bit
>>>>> +      * IOVA. Additionally, if this allocation also fails, attempt a
>>> 64-bit
>>>>> +      * allocation. If the 64-bit MSI address is allocated, then the
>>> EPs
>>>>> +      * supporting 32-bit MSI address will not work.
>>>>>          */
>>>>> -     ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>>>>> -     if (ret)
>>>>> -             dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices
>>> with only 32-bit MSI support may not work properly\n");
>>>>> +     np = of_parse_phandle(dev->of_node, "memory-region", 0);
>>>>> +     if (np) {
>>>>> +             ret = of_address_to_resource(np, 0, &r);
>>>>
>>>> This is incorrect in several ways - reserved-memory nodes represent
>>>> actual system memory, so can't be used to reserve arbitrary PCI memory
>>>> space (which may be different if DMA offsets are involved); the whole
>>>> purpose of going through the DMA API is to ensure we get a unique *bus*
>>>> address. Obviously we don't want to reserve actual memory for something
>>>> that functionally doesn't need it, but conversely having a
>>>> reserved-memory region for an address which isn't memory would be
>>>> nonsensical. And even if this *were* a viable approach, you haven't
>>>> updated the DWC binding to allow it, nor defined a reserved-memory
>>>> binding for the node itself.
>>>>
>>>> If it was reasonable to put something in DT at all, then the logical
>>>> thing would be a property expressing an MSI address directly on the
>>>> controller node itself, but even that would be dictating software policy
>>>> rather than describing an aspect of the platform itself. Plus this is
>>>> far from the only driver with this concern, so it wouldn't make much
>>>> sense to hack just one binding without all the others as well. The rest
>>>> of the DT already describes everything an OS needs to know in order to
>>>> decide an MSI address to use, it's just a matter of making this
>>>> particular OS do a better job of putting it all together.
>>>>
>>>> Thanks,
>>>> Robin.
>>>>
>>>
>>> Robin,
>>> Needed some clarification.
>>> It seems you are implying that the pcie device tree node should define a
>>> property for the MSI address within the PCIe address space.
>>> However, you also state that this would not be an ideal solution, and
>>> would prefer using existing device tree constructs.
>>> I am not sure what you mean by, " The rest of the DT already describes
>>> everything."
>>> Do you mean adding an "msi" reg to reg-names and defining the address
>>> in the reg list?
>>
>> No, I'm saying the closest this should come to DT at all is the possibility
>> of the low-level driver hard-coding a platform-specific value for
> 
> I am assuming that you mean the platform driver (IOW, vendor driver) by
> the "low-level" driver? Please confirm.

Indeed, I mean the vendor/platform driver (sorry if I'm not aware of any 
standard terminology here - I think I picked up "low-level driver" from 
one of the previous threads).

>> pp->msi_data based on some platform-specific compatible, as Serge pointed to
>> on v1.
>>
> Does this look ok to you? The expectation is that the pp->msi_data will
> have to be populated by the platform driver if it wants to ensure the
> support for all kinds of endpoints.
> 
> +       if (pp->msi_data)
> +               return 0;
> +
>          ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>          if (ret)
>                  dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
>   
>          msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>                                          GFP_KERNEL);
> +       if (!msi_vaddr) {
> +               dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
> +               dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> +               msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> +                                               GFP_KERNEL);
> +       }
> +
>          if (!msi_vaddr) {
>                  dev_err(dev, "Failed to alloc and map MSI data\n");
>                  dw_pcie_free_msi(pp);

Yeah, something like that. Personally I'd still be tempted to try some 
mildly more involved logic to just have a single dev_warn(), but I think 
that's less important than just having something which clearly works.

Thanks,
Robin.

