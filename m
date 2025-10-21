Return-Path: <linux-pci+bounces-38912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA435BF74E9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F797353C8C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09C232ED42;
	Tue, 21 Oct 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TL5SArwi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC1340A6C
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060308; cv=none; b=VmzPjEMlaHe2hBdFQ6woUdLjrPi0feWoZQlLVcEIlCaQoP3Ojx9jCQuYaJj2c8GWVI1DdG1JI4Cd4jmswkQ6DxxU36IrxaF+QpfLzJ+pbi4fwG4m6okamCmH8R/BpzLCfxdDXRiPXtZyFCJ3PvkRzCL1nwavEsekJLgO5bOO+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060308; c=relaxed/simple;
	bh=gXE7GZ7avbvPzFNGzSAX5/XP2dh9meMe1HwgyyKGEJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7S5HiokEMwWkYQvUa9m0En+gCh7kzmhuw4WpibGZmi24g8ZlaKhCBSeTJvtjAakbZxMBDu1r2Dq8vPOtv1zIEdheA1eQOGxXk2QXKs7re+R4/3rT6mWkwnVmpV98C3g+0bIf67MznxQ7/Ai1pd4MZcgG8eiC94dSGLlIvJcBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TL5SArwi; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4crbhF37mdz9tG7;
	Tue, 21 Oct 2025 17:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761060301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MKFLEThqmvrI3XFYEUNngNHXR7vhGAjmAiGfVY65+E=;
	b=TL5SArwivaOIALKvXNaFy3DSZOPvRv3JviJar2SUZmyDAcOtvAXG3Q5n8Cb7aXuLb80/wb
	NwrJkcT3FZkRuJI3vYP1880D4vo+4odQaF2ilPPjzZOJx//ZB6MmEWlu8u1iX7lei4d7si
	TksZ8+j0iolzGwg8s8E/mVZeg+Z7tt8Fv4bLzZHBQeSQMkFQjl3AHtsmSW1Dmh/+QtUMx3
	39rQ8x5jCKI0+Qm8Xl6YTO5gT279WaAf/YaDO1ogXJSw2AeVF2qVnKEiEQlLr6/tT8wDe9
	JJedjepVwWI8jJ1OL5SobVhiCmJluP14ylJ2ek1MP5KRBIulcFCd5fxUK0HlhQ==
Message-ID: <bb4c81ae-4032-433a-89eb-19e6ca475a1e@mailbox.org>
Date: Tue, 21 Oct 2025 17:24:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: pcie-xilinx-dma-pl: Fix off-by-one INTx IRQ handling
To: Sean Anderson <sean.anderson@linux.dev>, linux-pci@vger.kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Ravi Kumar Bandi <ravib@amazon.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Michal Simek <michal.simek@amd.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20251021133958.802464-1-stefan.roese@mailbox.org>
 <c174f938-d1ec-4f5f-a838-e7ebd3c43818@linux.dev>
 <3613d83d-7a35-4b1a-bf0c-8c7e0b03198f@linux.dev>
 <966bcd8f-5742-4888-a57b-92769e76fc43@mailbox.org>
 <2f95faef-b5eb-4c6a-857e-5cf02f5850b8@linux.dev>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <2f95faef-b5eb-4c6a-857e-5cf02f5850b8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dc1ee48094ffc04eb8c
X-MBO-RS-META: kzbfrjsydn48ckh63sjdr6ueam5pmgx5

Hi Sean,

On 10/21/25 17:12, Sean Anderson wrote:
> On 10/21/25 11:10, Stefan Roese wrote:
>> Hi Sean,
>>
>> On 10/21/25 17:04, Sean Anderson wrote:
>>> On 10/21/25 10:59, Sean Anderson wrote:
>>>> On 10/21/25 09:39, Stefan Roese wrote:
>>>>> While testing with NVMe drives connected to the Versal QDMA PL PCIe RP
>>>>> on our platform I noticed that with MSI disabled (e.g. via pci=nomsi)
>>>>> the NVMe interrupts are not delivered to the host CPU resulting in
>>>>> timeouts while probing.
>>>>>
>>>>> Debugging has shown, that the hwirq numbers passed to this device driver
>>>>> (1...4, 1=INTA etc) need to get adjusted to match the numbers in the
>>>>> controller registers bits (0...3). This patch now correctly matches the
>>>>> hwirq number to the PCIe controller register bits.
>>>>>
>>>>> Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
>>>>> Cc: Sean Anderson <sean.anderson@linux.dev>
>>>>
>>>> I assume I'm CC'd because of commit 02a370c4fc0f ("PCI: xilinx-nwl: Fix
>>>> off-by-one in INTx IRQ handler"), which does the exact opposite of this
>>>> patch.
>>
>> Correct. PCI legacy interrupts are rarely used as it seems lately.
>>
>>>> And I'm rather confused as to how you determined that hwirq is
>>>> one-based, since it seems to come directly from
>>>>
>>>>      for_each_set_bit(i, &val, PCI_NUM_INTX)
>>>>          generic_handle_domain_irq(port->intx_domain, i);
>>>>
>>>> which is zero-based.
>>>
>>> OK, upon re-reading the patch it looks like you also adjusted the above
>>> hunk to be one-based. After this patch the drivers adds one just to
>>> subtract it off again.
>>>
>>> So why do the interrupts need to be one-based and not zero-based?
>>
>> My testing / debugging showed, that hwirq as an input to these
>> functions is always 1 in my case. My assumption was, that this is
>> because of these defines in include/linux/pci.h:
>>
>> /**
>>   * enum pci_interrupt_pin - PCI INTx interrupt values
>>   * @PCI_INTERRUPT_UNKNOWN: Unknown or unassigned interrupt
>>   * @PCI_INTERRUPT_INTA: PCI INTA pin
>>   * @PCI_INTERRUPT_INTB: PCI INTB pin
>>   * @PCI_INTERRUPT_INTC: PCI INTC pin
>>   * @PCI_INTERRUPT_INTD: PCI INTD pin
>>   *
>>   * Corresponds to values for legacy PCI INTx interrupts, as can be found in the
>>   * PCI_INTERRUPT_PIN register.
>>   */
>> enum pci_interrupt_pin {
>>      PCI_INTERRUPT_UNKNOWN,
>>      PCI_INTERRUPT_INTA,
>>      PCI_INTERRUPT_INTB,
>>      PCI_INTERRUPT_INTC,
>>      PCI_INTERRUPT_INTD,
>> };
>>
>> So 0 is unknown and 1 is INTA.
>>
>> I might have gotten something totally wrong this patch with these
>> changes enables PCIe INTx generation on my Versal platform.
>>
> 
> Maybe you need to set intx_domain_ops.xlate to pci_irqd_intx_xlate?

Ah, much better. I was not aware of this. Will send v2 using this
xlate function instead.

Thanks a lot,
Stefan
> --Sean
> 
>>>
>>>>
>>>>> Cc: Manivannan Sadhasivam <mani@kernel.org>
>>>>> Cc: Ravi Kumar Bandi <ravib@amazon.com>
>>>>> Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
>>>>> Cc: Michal Simek <michal.simek@amd.com>
>>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>>> ---
>>>>>    drivers/pci/controller/pcie-xilinx-dma-pl.c | 21 ++++++++++++++++++---
>>>>>    1 file changed, 18 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
>>>>> index 84888eda990b2..5cca9d018bc89 100644
>>>>> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
>>>>> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
>>>>> @@ -331,7 +331,12 @@ static void xilinx_mask_intx_irq(struct irq_data *data)
>>>>>        unsigned long flags;
>>>>>        u32 mask, val;
>>>>>    -    mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
>>>>> +    /*
>>>>> +     * INTx hwirq: 1=INTA, 2=INTB, 3=INTC, 4=INTD
>>>>> +     * In the controller regs this is represented in bits 0...3, so we need
>>>>> +     * to subtract 1 here
>>>>> +     */
>>>>> +    mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT - 1);
>>>>>        raw_spin_lock_irqsave(&port->lock, flags);
>>>>>        val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
>>>>>        pcie_write(port, (val & (~mask)), XILINX_PCIE_DMA_REG_IDRN_MASK);
>>>>> @@ -344,7 +349,12 @@ static void xilinx_unmask_intx_irq(struct irq_data *data)
>>>>>        unsigned long flags;
>>>>>        u32 mask, val;
>>>>>    -    mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
>>>>> +    /*
>>>>> +     * INTx hwirq: 1=INTA, 2=INTB, 3=INTC, 4=INTD
>>>>> +     * In the controller regs this is represented in bits 0...3, so we need
>>>>> +     * to subtract 1 here
>>>>> +     */
>>>>> +    mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT - 1);
>>>>>        raw_spin_lock_irqsave(&port->lock, flags);
>>>>>        val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
>>>>>        pcie_write(port, (val | mask), XILINX_PCIE_DMA_REG_IDRN_MASK);
>>>>> @@ -620,8 +630,13 @@ static irqreturn_t xilinx_pl_dma_pcie_intx_flow(int irq, void *args)
>>>>>        val = FIELD_GET(XILINX_PCIE_DMA_IDRN_MASK,
>>>>>                pcie_read(port, XILINX_PCIE_DMA_REG_IDRN));
>>>>>    +    /*
>>>>> +     * INTx hwirq: 1=INTA, 2=INTB, 3=INTC, 4=INTD
>>>>> +     * In the controller regs this is represented in bits 0...3, so we need
>>>>> +     * to add 1 here again for the registered handler
>>>>> +     */
>>>>>        for_each_set_bit(i, &val, PCI_NUM_INTX)
>>>>> -        generic_handle_domain_irq(port->intx_domain, i);
>>>>> +        generic_handle_domain_irq(port->intx_domain, i + 1);
>>>>>        return IRQ_HANDLED;
>>>>>    }
>>>>>    
>>
> 
Thanks a


