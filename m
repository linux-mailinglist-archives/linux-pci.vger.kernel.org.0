Return-Path: <linux-pci+bounces-15760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60E09B8620
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 23:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7AB281CA5
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 22:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50151957E7;
	Thu, 31 Oct 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dejEHyY6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE51E481
	for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414214; cv=none; b=u1T/RjV/g7ukzvx2s070tB8V87UiGaAJi3MaA5yT+28qGdUeBDz7Ak1T9AJ46HFf54/AX96EM6/0dYI2vXvaykX7N2eUis0e9brOG19ZDnnSqDXR5Eo0ha2XzikfWCRZ2O2WuL/V8OiXTBbIKbq1O3kEDyL1TQ4lNG/qx1h1Zbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414214; c=relaxed/simple;
	bh=lYt9NpvrHObsB/PZD9LC3arxhEdvOhbnU4iHtWBwdss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1L3+nzWJ6olVN0o5LH8wStYn91pGTPhQIGq01PcaS1r3w/+CQLk8eUfWzYE4iSI0ecVu5Huoib3nYXsYLEo7S7ZMSGhZmXULEok4YulqeDdwXHBDOw+KZ7ac3p+smTVu/Mz9toangeLs2fhHZZkuz0JPkQYGKVmWt63O38eBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dejEHyY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5088C4CEC3;
	Thu, 31 Oct 2024 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730414214;
	bh=lYt9NpvrHObsB/PZD9LC3arxhEdvOhbnU4iHtWBwdss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dejEHyY69fV4IOYikH0lDUEjmvb72tkOPCznqpit9EfDsqq7cONCCDPmLdhCnI/YC
	 gObFWdUHxLh/VhrFamlh/IrJr0YPM6ONlc54hMfxmAcds2I1hTLbKLxRrnHX9cA3Ex
	 vY5jBn5cwa4HKOR1kCqoS4qzESSUusbE4MAYso7lcyqYOizT0c6HsD2S1yy9JtZ92B
	 0RUI763lxyBCLq1VmMnPoQ7B1PAV2Xv+6IonBPyi3ld2crBdoJdlopahY9TJp5raz5
	 hYZ0DwkQ8Cg7sq3f5YnUUgoPp7RS4mWCnawKwsF4gL4zPS+us95ocwNkx+oqRLYssH
	 dYq8aFYsp76wA==
Message-ID: <7c30ed21-5d48-414a-a943-68ff74b4f23e@kernel.org>
Date: Fri, 1 Nov 2024 07:36:51 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: dwc: ep: Use align addr function for
 dw_pcie_ep_raise_{msi,msix}_irq()
To: Bjorn Helgaas <helgaas@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
References: <20241031202849.GA1266008@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241031202849.GA1266008@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 05:28, Bjorn Helgaas wrote:
> On Thu, Oct 17, 2024 at 03:20:55PM +0200, Niklas Cassel wrote:
>> Use the dw_pcie_ep_align_addr() function to calculate the alignment in
>> dw_pcie_ep_raise_{msi,msix}_irq() instead of open coding the same.
>>
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>> ---
>>  .../pci/controller/dwc/pcie-designware-ep.c    | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index 20f67fd85e83..9bafa62bed1d 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -503,7 +503,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>>  	u32 msg_addr_lower, msg_addr_upper, reg;
>>  	struct dw_pcie_ep_func *ep_func;
>>  	struct pci_epc *epc = ep->epc;
>> -	unsigned int aligned_offset;
>> +	size_t msi_mem_size = epc->mem->window.page_size;
>> +	size_t offset;
>>  	u16 msg_ctrl, msg_data;
>>  	bool has_upper;
>>  	u64 msg_addr;
>> @@ -531,14 +532,13 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>>  	}
>>  	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
>>  
>> -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
>> -	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
>> +	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
>>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>> -				  epc->mem->window.page_size);
>> +				  msi_mem_size);
> 
> I haven't worked through this; just double checking that this is
> correct.  Previously we did ALIGN_DOWN() here, but
> dw_pcie_ep_align_addr() uses ALIGN() (not ALIGN_DOWN()).  Similar
> below in dw_pcie_ep_raise_msix_irq().

The ALIGN() in dw_pcie_ep_align_addr() is for the mapping size. The address is
aligned down manually:

	return pci_addr & ~mask;

So it is the same. We could change dw_pcie_ep_align_addr() to do:

	return ALIGN_DOWN(pci_addr, epc->mem->window.page_size);

But given that the offset calculation needs the alignment mask anyway, using
the mask variable directly seems natural.

So this is functionnally identical for the PCI address being mapped, and it is
even better for the mapping size since this was passing
epc->mem->window.page_size before but if the PCI address range crosses over a
page_size boundary, we actually need 2 x page_size as the mapping size...

Which makes me realized that there is something still wrong: the memory being
mapped (ep->msi_mem) is at most one page:

	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
					     epc->mem->window.page_size);
	if (!ep->msi_mem) {
		ret = -ENOMEM;
		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
		goto err_exit_epc_mem;
	}

But we may need up to 2 pages depending on the PCI address we get for the
MSI/MSIX. So we need to fix that as well I think.

Niklas, thoughts ?


-- 
Damien Le Moal
Western Digital Research

