Return-Path: <linux-pci+bounces-3401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC608534AE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 16:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937A31C20A3C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5FF224D5;
	Tue, 13 Feb 2024 15:32:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112165EE60
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838340; cv=none; b=mIjUZp5aJuSZAKSDspKnnu+dEjkGKqAT19r+ofDTjMC8clQKE5YVLOj+xZyMEKTnBKdFItlgxMfq4fn5+w9Zs/6GdgU3+ojbD8SGxU3OfO2IMXID91dbzzQx6CqIRdp1IvIgOfVYBp56JGMQj1oDAQ3JvmoiCkokO82m9Fkmazg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838340; c=relaxed/simple;
	bh=7f+UzjJlQp3JZ1paIMasVE22kErzgQ9MtQb/9dWOgko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyT0NVKZSzFXDycsR9JyiYetrHratZicL677tSR7C2261g6/Nt7XmfSeaMSrsrR+0CbRaXSsrYp7oFhTq2qI/LWlptA5/gxHZNmW4C+7nvuMXzYCIKpfLPOvOSzkJn9cZj4C5tIp4XbRLjds/eugCDy+XI4auk+YeGS6D9acr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF581DA7;
	Tue, 13 Feb 2024 07:32:58 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0D443F7B4;
	Tue, 13 Feb 2024 07:32:15 -0800 (PST)
Message-ID: <7cd42851-37cc-49d6-b9ad-74a256a73904@arm.com>
Date: Tue, 13 Feb 2024 15:32:14 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: dwc: Strengthen the MSI address allocation logic
Content-Language: en-GB
To: Ajay Agarwal <ajayagarwal@google.com>,
 Serge Semin <fancer.lancer@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
 Sajid Dalvi <sdalvi@google.com>, William McVicker <willmcvicker@google.com>,
 linux-pci@vger.kernel.org
References: <20240204112425.125627-1-ajayagarwal@google.com>
 <2kvgqhaitacl7atqf775vr2z3ty5qeqxuv5g3wflkmhgj4yk76@fsmrosfwobfx>
 <ZcJhhHK6eQOUfVKf@google.com>
 <rjhceek7fjr6qglqewzrojc2nooewmhxq5ifzpqhpzuvc5deqa@l4u7kgzn2vo7>
 <ZcrZdhay6YvBzvWt@google.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZcrZdhay6YvBzvWt@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2024 2:52 am, Ajay Agarwal wrote:
> On Tue, Feb 06, 2024 at 07:53:19PM +0300, Serge Semin wrote:
>> On Tue, Feb 06, 2024 at 10:12:44PM +0530, Ajay Agarwal wrote:
>>> On Mon, Feb 05, 2024 at 12:52:45AM +0300, Serge Semin wrote:
>>>> On Sun, Feb 04, 2024 at 04:54:25PM +0530, Ajay Agarwal wrote:
>>>>> There can be platforms that do not use/have 32-bit DMA addresses
>>>>> but want to enumerate endpoints which support only 32-bit MSI
>>>>> address. The current implementation of 32-bit IOVA allocation can
>>>>> fail for such platforms, eventually leading to the probe failure.
>>>>>
>>>>> If there vendor driver has already setup the MSI address using
>>>>> some mechanism, use the same. This method can be used by the
>>>>> platforms described above to support EPs they wish to.
>>>>>
>>>>> Else, if the memory region is not reserved, try to allocate a
>>>>> 32-bit IOVA. Additionally, if this allocation also fails, attempt
>>>>> a 64-bit allocation for probe to be successful. If the 64-bit MSI
>>>>> address is allocated, then the EPs supporting 32-bit MSI address
>>>>> will not work.
>>>>>
>>>>> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
>>>>> ---
>>>>> Changelog since v2:
>>>>>   - If the vendor driver has setup the msi_data, use the same
>>>>>
>>>>> Changelog since v1:
>>>>>   - Use reserved memory, if it exists, to setup the MSI data
>>>>>   - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
>>>>>
>>>>>   .../pci/controller/dwc/pcie-designware-host.c | 26 ++++++++++++++-----
>>>>>   1 file changed, 20 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> index d5fc31f8345f..512eb2d6591f 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> @@ -374,10 +374,18 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>>>>>   	 * order not to miss MSI TLPs from those devices the MSI target
>>>>>   	 * address has to be within the lowest 4GB.
>>>>>   	 *
>>>>
>>>>> -	 * Note until there is a better alternative found the reservation is
>>>>> -	 * done by allocating from the artificially limited DMA-coherent
>>>>> -	 * memory.
>>>>
>>>> Why do you keep deleting this statement? The driver still uses the
>>>> DMA-coherent memory as a workaround. Your solution doesn't solve the
>>>> problem completely. This is another workaround. One more time: the
>>>> correct solution would be to allocate a 32-bit address or some range
>>>> within the 4GB PCIe bus memory with no _RAM_ or some other IO behind.
>>>> Your solution relies on the platform firmware/glue-driver doing that,
>>>> which isn't universally applicable. So please don't drop the comment.
>>>>
>>> ACK.
>>>
>>>>> +	 * Check if the vendor driver has setup the MSI address already. If yes,
>>>>> +	 * pick up the same.
>>>>
>>>> This is inferred from the code below. So drop it.
>>>>
>>> ACK.
>>>
>>>>> This will be helpful for platforms that do not
>>>>> +	 * use/have 32-bit DMA addresses but want to use endpoints which support
>>>>> +	 * only 32-bit MSI address.
>>>>
>>>> Please merge it into the first part of the comment as like: "Permit
>>>> the platforms to override the MSI target address if they have a free
>>>> PCIe-bus memory specifically reserved for that."
>>>>
>>> ACK.
>>>
>>>>> +	 * Else, if the memory region is not reserved, try to allocate a 32-bit
>>>>> +	 * IOVA. Additionally, if this allocation also fails, attempt a 64-bit
>>>>> +	 * allocation. If the 64-bit MSI address is allocated, then the EPs
>>>>> +	 * supporting 32-bit MSI address will not work.
>>>>
>>>> This is easily inferred from the code below. So drop it.
>>>>
>>> ACK.
>>>
>>>>>   	 */
>>>>
>>>>> +	if (pp->msi_data)
>>>>
>>>> Note this is a physical address for which even zero value might be
>>>> valid. In this case it's the address of the PCIe bus space for which
>>>> AFAICS zero isn't reserved for something special.
>>>>
>>
>>> That is a fair point. What do you suggest we do? Shall we define another
>>> op `set_msi_data` (like init/msi_init/start_link) and if it is defined
>>> by the vendor, then call it? Then vendor has to set the pp->msi_data
>>> there? Let me know.
>>
>> You can define a new capability flag here
>> drivers/pci/controller/dwc/pcie-designware.h (see DW_PCIE_CAP_* macros)
>> , set it in the glue driver by means of the dw_pcie_cap_set() macro
>> function and instead of checking msi_data value test the flag for
>> being set by dw_pcie_cap_is().
>>
> Sure, good suggestion. ACK.
> 
>>>
>>>>> +		return 0;
>>>>> +
>>>>>   	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>>>>>   	if (ret)
>>>>>   		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
>>>>> @@ -385,9 +393,15 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>>>>>   	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>>>>>   					GFP_KERNEL);
>>>>>   	if (!msi_vaddr) {
>>>>> -		dev_err(dev, "Failed to alloc and map MSI data\n");
>>>>> -		dw_pcie_free_msi(pp);
>>>>> -		return -ENOMEM;
>>>>> +		dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
>>>>> +		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
>>>>> +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>>>>> +						GFP_KERNEL);
>>>>> +		if (!msi_vaddr) {
>>>>> +			dev_err(dev, "Failed to alloc and map MSI data\n");
>>>>> +			dw_pcie_free_msi(pp);
>>>>> +			return -ENOMEM;
>>>>> +		}
>>>>
>>>> On Tue, Jan 30, 2024 at 08:40:48PM +0000, Robin Murphy wrote:
>>>>> Yeah, something like that. Personally I'd still be tempted to try some
>>>>> mildly more involved logic to just have a single dev_warn(), but I think
>>>>> that's less important than just having something which clearly works.
>>>>
>>>> I guess this can be done but in a bit clumsy way. Like this:
>>>>
>>>> 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32)) ||
>>>> 	      !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
>>>> 	if (ret) {
>>>> 		dev_warn(dev, "Failed to allocate 32-bit MSI target address\n");
>>>>
>>>> 		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
>>>> 		ret = !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
>>>> 		if (ret) {
>>>> 			dev_err(dev, "Failed to allocate MSI target address\n");
>>>> 			return -ENOMEM;
>>>
>>> As you pointed out already, this looks pretty clumsy. I think we should
>>> stick to the more descriptive and readable code that I suggested.
>>
>> I do not know which solution is better really. Both have pros and
>> cons. Let's wait for Bjorn, Mani or Robin opinion about this.
>>
>> -Serge(y)
>>
> Bjorn/Mani/Robin,
> Can you please provide your comment?

FWIW I had a go at sketching out what I think I'd do, on top of the v3
patch. Apparently I'm not in a too-clever-for-my-own-good mood today,
since what came out seems to have ended up pretty much just simplifying
the pre-existing code. I'll leave the choice up to you.

Thanks,
Robin.

----->8-----
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 512eb2d6591f..7b68c65e5d11 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -328,7 +328,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
  	struct device *dev = pci->dev;
  	struct platform_device *pdev = to_platform_device(dev);
-	u64 *msi_vaddr;
+	u64 *msi_vaddr = NULL;
  	int ret;
  	u32 ctrl, num_ctrls;
  
@@ -387,18 +387,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
  		return 0;
  
  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
-	if (ret)
-		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
-
-	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
-					GFP_KERNEL);
+	if (!ret)
+		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
+						GFP_KERNEL);
  	if (!msi_vaddr) {
-		dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
+		dev_warn(dev, "Failed to configure 32-bit MSI address. Devices with only 32-bit MSI support may not work properly\n");
  		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
  		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
  						GFP_KERNEL);
  		if (!msi_vaddr) {
-			dev_err(dev, "Failed to alloc and map MSI data\n");
+			dev_err(dev, "Failed to configure MSI address\n");
  			dw_pcie_free_msi(pp);
  			return -ENOMEM;
  		}

