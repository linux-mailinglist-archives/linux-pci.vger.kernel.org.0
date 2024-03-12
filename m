Return-Path: <linux-pci+bounces-4760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAAA87955F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 14:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86241F22CEB
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2A37A15A;
	Tue, 12 Mar 2024 13:52:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E50A939
	for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2024 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251531; cv=none; b=eVzJjxyVkL0g9/zio6mtQC/AMFcrcGV30GTZu8cm3DHS95gMMYokH2Cb3mRzOTh7ODws4IFW6TbJDsZAXUmNWj3sT9TLw5rekcxsURex5hhftAAy7vMFCzROUZoxOfjsuVpiIe2+tl/X1nIVSQpOK9sBTqmje4xe5/gWaOox2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251531; c=relaxed/simple;
	bh=iM/lpWpybnhIlBGD7CiaSx78gPuk3Wd+jKcWltEqxiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZu36kyI7G6SMafyfgOfpek7u1zUv/ifOVs4jsAqeGdQXAdOuj3y6Mm5qeBcMlebo2XHhK1ORygOaKmo/JNMP5cJqkqK0gDLKibVGWPDUd9TVQSyaN1O07UYDBNhPwk2jrJdXRIncQ2yXLzEbMM0tXzJB2ya6QlkR+t5dUPQBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C061D1007;
	Tue, 12 Mar 2024 06:52:45 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94A363F73F;
	Tue, 12 Mar 2024 06:52:06 -0700 (PDT)
Message-ID: <46f1804c-429d-4d2a-8b68-91dbd0cebd00@arm.com>
Date: Tue, 12 Mar 2024 13:52:05 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] PCI: dwc: Strengthen the MSI address allocation logic
Content-Language: en-GB
To: Bjorn Helgaas <helgaas@kernel.org>, Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>,
 William McVicker <willmcvicker@google.com>,
 Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org
References: <20240311165839.GA799766@bhelgaas>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240311165839.GA799766@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/03/2024 4:58 pm, Bjorn Helgaas wrote:
> On Wed, Feb 21, 2024 at 09:08:40PM +0530, Ajay Agarwal wrote:
>> There can be platforms that do not use/have 32-bit DMA addresses.
>> The current implementation of 32-bit IOVA allocation can fail for
>> such platforms, eventually leading to the probe failure.
>>
>> Try to allocate a 32-bit msi_data. If this allocation fails,
>> attempt a 64-bit address allocation. Please note that if the
>> 64-bit MSI address is allocated, then the EPs supporting 32-bit
>> MSI address only will not work.
> 
> What happens when we fail to allocate a 32-bit address, we allocate a
> 64-bit address, we have an endpoint that only supports 32-bit
> addresses, and the driver tries to enable MSI?  Does it fall back to
> INTx?  Fail the MSI enable?  Emit a warning?

In general __pci_write_msi_msg() will write the address, which will then 
be truncated by the device, and when it subsequently tries to signal the 
MSI it will go off into the weeds and not raise an interrupt. We'll have 
already warned about failing to get a 32-bit MSI address when initially 
probing the controller - although apparently now no longer explicitly 
calling out the implication for 32-bit devices :( - which seems to be 
about as much as we can reasonably do.

I suppose pci_write_msg_msi() could additionally scream if it sees 
address_hi being nonzero when the given capability is only 32-bit, but 
it still can't fail. Within the current design, I'm not sure we can 
reasonably tell that a device is incompatible with the MSI domain until 
irq_chip_compose_msi_msg(), by which point it's already way too late...

Thanks,
Robin.

> 
>> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
>> ---
>> Changelog since v5:
>>   - Initialize temp variable 'msi_vaddr' to NULL
>>   - Remove redundant print and check
>>
>> Changelog since v4:
>>   - Remove the 'DW_PCIE_CAP_MSI_DATA_SET' flag
>>   - Refactor the comments and msi_data allocation logic
>>
>> Changelog since v3:
>>   - Add a new controller cap flag 'DW_PCIE_CAP_MSI_DATA_SET'
>>   - Refactor the comments and print statements
>>
>> Changelog since v2:
>>   - If the vendor driver has setup the msi_data, use the same
>>
>> Changelog since v1:
>>   - Use reserved memory, if it exists, to setup the MSI data
>>   - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
>>
>>   .../pci/controller/dwc/pcie-designware-host.c | 21 ++++++++++++-------
>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index d5fc31f8345f..d15a5c2d5b48 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -328,7 +328,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct device *dev = pci->dev;
>>   	struct platform_device *pdev = to_platform_device(dev);
>> -	u64 *msi_vaddr;
>> +	u64 *msi_vaddr = NULL;
>>   	int ret;
>>   	u32 ctrl, num_ctrls;
>>   
>> @@ -379,15 +379,20 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>>   	 * memory.
>>   	 */
>>   	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>> -	if (ret)
>> -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
>> +	if (!ret)
>> +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>> +						GFP_KERNEL);
>>   
>> -	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>> -					GFP_KERNEL);
>>   	if (!msi_vaddr) {
>> -		dev_err(dev, "Failed to alloc and map MSI data\n");
>> -		dw_pcie_free_msi(pp);
>> -		return -ENOMEM;
>> +		dev_warn(dev, "Failed to allocate 32-bit MSI address\n");
>> +		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
>> +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>> +						GFP_KERNEL);
>> +		if (!msi_vaddr) {
>> +			dev_err(dev, "Failed to allocate MSI address\n");
>> +			dw_pcie_free_msi(pp);
>> +			return -ENOMEM;
>> +		}
>>   	}
>>   
>>   	return 0;
>> -- 
>> 2.44.0.rc0.258.g7320e95886-goog
>>

