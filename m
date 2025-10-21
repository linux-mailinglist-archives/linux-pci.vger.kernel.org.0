Return-Path: <linux-pci+bounces-38908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B6ABF7414
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F39B188285A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387634215A;
	Tue, 21 Oct 2025 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RZT53GyM"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED01341ABD
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059076; cv=none; b=Vw0Elo6CYoEqoi5dqTv4NgHt/2UcTv6YuQAGWLh9D0exupqW1lnH4nEGYq/gAK6mawoPOvydLXWpt5SzdtSQKjlhqc7TPA21PH7JivgRia+9mIFhzJ1kOB2Q9I31BDbtzyQ9Jt2cwsvEZYBAuknB+FnDNPLBOW3Is5B3+KcoZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059076; c=relaxed/simple;
	bh=nuKXTPl5WB7UvXyuLYSVVmsBV2tUvyPE80ckxJD4yFY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fElUoP06Tc/QOk2E1caGWqN/eIuB+11FXceU5FYefG/Maq1uxbBYBfnZpupYMySg5g4bD7fFRdjsIvUhZcqmugx4O9ErWOZrj4t5Ps45ll3//wp40xOxciO5Y0QH4eLoe/Mn9F3qABjwCWedk1wohxYIz10Fg5G+GCHuRbB+Kes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RZT53GyM; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3613d83d-7a35-4b1a-bf0c-8c7e0b03198f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761059068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5AzXLqhHqe6B4fnUe03nj6XO4O94uf8uQ6pvdn3XFE=;
	b=RZT53GyMI9LX9ElPuQ+y8aTwVUKESMpogxsEbmPo9uoYWAdx2Np4icIwLv1HWgzSk38GsM
	TGDtFSRAVwYDEh+fSOjP5qHmrTqbrKTMRJxnYfCGy7qRI7onpM9d5MLkSsm0gG8hOnjr5x
	FXf6Tl6TFW7+9G2sO4thnacLo8Z+/Io=
Date: Tue, 21 Oct 2025 11:04:19 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: pcie-xilinx-dma-pl: Fix off-by-one INTx IRQ handling
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Stefan Roese <stefan.roese@mailbox.org>, linux-pci@vger.kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Ravi Kumar Bandi <ravib@amazon.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Michal Simek <michal.simek@amd.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20251021133958.802464-1-stefan.roese@mailbox.org>
 <c174f938-d1ec-4f5f-a838-e7ebd3c43818@linux.dev>
Content-Language: en-US
In-Reply-To: <c174f938-d1ec-4f5f-a838-e7ebd3c43818@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/21/25 10:59, Sean Anderson wrote:
> On 10/21/25 09:39, Stefan Roese wrote:
>> While testing with NVMe drives connected to the Versal QDMA PL PCIe RP
>> on our platform I noticed that with MSI disabled (e.g. via pci=nomsi)
>> the NVMe interrupts are not delivered to the host CPU resulting in
>> timeouts while probing.
>> 
>> Debugging has shown, that the hwirq numbers passed to this device driver
>> (1...4, 1=INTA etc) need to get adjusted to match the numbers in the
>> controller registers bits (0...3). This patch now correctly matches the
>> hwirq number to the PCIe controller register bits.
>> 
>> Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
>> Cc: Sean Anderson <sean.anderson@linux.dev>
> 
> I assume I'm CC'd because of commit 02a370c4fc0f ("PCI: xilinx-nwl: Fix
> off-by-one in INTx IRQ handler"), which does the exact opposite of this
> patch.
> 
> And I'm rather confused as to how you determined that hwirq is
> one-based, since it seems to come directly from
> 
> 	for_each_set_bit(i, &val, PCI_NUM_INTX)
> 		generic_handle_domain_irq(port->intx_domain, i);
> 
> which is zero-based.

OK, upon re-reading the patch it looks like you also adjusted the above
hunk to be one-based. After this patch the drivers adds one just to
subtract it off again.

So why do the interrupts need to be one-based and not zero-based?

--Sean

> 
>> Cc: Manivannan Sadhasivam <mani@kernel.org>
>> Cc: Ravi Kumar Bandi <ravib@amazon.com>
>> Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  drivers/pci/controller/pcie-xilinx-dma-pl.c | 21 ++++++++++++++++++---
>>  1 file changed, 18 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
>> index 84888eda990b2..5cca9d018bc89 100644
>> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
>> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
>> @@ -331,7 +331,12 @@ static void xilinx_mask_intx_irq(struct irq_data *data)
>>  	unsigned long flags;
>>  	u32 mask, val;
>>  
>> -	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
>> +	/*
>> +	 * INTx hwirq: 1=INTA, 2=INTB, 3=INTC, 4=INTD
>> +	 * In the controller regs this is represented in bits 0...3, so we need
>> +	 * to subtract 1 here
>> +	 */
>> +	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT - 1);
>>  	raw_spin_lock_irqsave(&port->lock, flags);
>>  	val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
>>  	pcie_write(port, (val & (~mask)), XILINX_PCIE_DMA_REG_IDRN_MASK);
>> @@ -344,7 +349,12 @@ static void xilinx_unmask_intx_irq(struct irq_data *data)
>>  	unsigned long flags;
>>  	u32 mask, val;
>>  
>> -	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
>> +	/*
>> +	 * INTx hwirq: 1=INTA, 2=INTB, 3=INTC, 4=INTD
>> +	 * In the controller regs this is represented in bits 0...3, so we need
>> +	 * to subtract 1 here
>> +	 */
>> +	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT - 1);
>>  	raw_spin_lock_irqsave(&port->lock, flags);
>>  	val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
>>  	pcie_write(port, (val | mask), XILINX_PCIE_DMA_REG_IDRN_MASK);
>> @@ -620,8 +630,13 @@ static irqreturn_t xilinx_pl_dma_pcie_intx_flow(int irq, void *args)
>>  	val = FIELD_GET(XILINX_PCIE_DMA_IDRN_MASK,
>>  			pcie_read(port, XILINX_PCIE_DMA_REG_IDRN));
>>  
>> +	/*
>> +	 * INTx hwirq: 1=INTA, 2=INTB, 3=INTC, 4=INTD
>> +	 * In the controller regs this is represented in bits 0...3, so we need
>> +	 * to add 1 here again for the registered handler
>> +	 */
>>  	for_each_set_bit(i, &val, PCI_NUM_INTX)
>> -		generic_handle_domain_irq(port->intx_domain, i);
>> +		generic_handle_domain_irq(port->intx_domain, i + 1);
>>  	return IRQ_HANDLED;
>>  }
>>  

