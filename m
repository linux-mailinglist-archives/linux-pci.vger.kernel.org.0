Return-Path: <linux-pci+bounces-43591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C89CD96C2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 14:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BD01300FFB0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D197B334C1F;
	Tue, 23 Dec 2025 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="erXLKrKN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3288.qiye.163.com (mail-m3288.qiye.163.com [220.197.32.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685151DF985
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766496129; cv=none; b=VrdVqYR49Wx0Zlby+QRVGfvO+0dDau+KybggOMj0Z8coGlNoEhnyOKhwHmh6IrUZGtGde2rCUiLnEw1yRm1xKniBaPOlyYBe663ZQ06qHgPJopNyFKTT0ATo49NcVqLr8JBIzgmPPnBXSWzpSnF2WtIAlOUL3kV8lpMqjqfrYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766496129; c=relaxed/simple;
	bh=cq0aW9+/xU9SAefqfuHrfV1baNMETCO092Nk8pe+GLM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ejJFzCXZbr/Id1mchIDUkxGcCza8I/bRnNEuOgqh4N99qqVUInKMXvfzFa8prqe+Xr/tk4+HdulZ20Uxx7S8+QXnXsFuUiEYHi3B0c+ur+zetYqpA/0OGQ5Cdo4JsaayvCsWdfPRiQAfICIg+8wtrnd5oot5WcH1XKR703UgDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=erXLKrKN; arc=none smtp.client-ip=220.197.32.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e4ac3eac;
	Tue, 23 Dec 2025 21:16:47 +0800 (GMT+08:00)
Message-ID: <7eb9773d-1d94-4443-a3eb-80ef3ccc60f9@rock-chips.com>
Date: Tue, 23 Dec 2025 21:16:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Ajay Agarwal <ajayagarwal@google.com>,
 Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH] PCI: dwc: Use cfg0_base as iMSI-RX target address to
 support 32-bit MSI devices
To: Manivannan Sadhasivam <mani@kernel.org>
References: <1764727630-129853-1-git-send-email-shawn.lin@rock-chips.com>
 <wc5s43s2aprtrxfyvjk7ebcutqse54kj4w452hqitqq3as5bj3@bg3ohzcbljy4>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <wc5s43s2aprtrxfyvjk7ebcutqse54kj4w452hqitqq3as5bj3@bg3ohzcbljy4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b4b5ae76c09cckunm324ab9c8337715
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU4eTFYZQxoeT0pJHktMSR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVU
	pLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=erXLKrKN8x2mEvpI0ApFf9bNIAn/vCxF1KXUu/pznUVF6EP+Tyy21dNaPJjlK8IsAXz+qrY2QNGVFstV5Xom5ozPvOepfo2EsmhmfA+QUSF+vFoL2363MmQVOCmT4XRacydleczWPfcTbNFnlpUHpa62mZhLvcKg4bJa6hQxmjc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=PQA7wimVUKUHeY4Y5Nyqc1jRlgQVkkmaOqaZpVHbepY=;
	h=date:mime-version:subject:message-id:from;

在 2025/12/23 星期二 20:22, Manivannan Sadhasivam 写道:
> On Wed, Dec 03, 2025 at 10:07:10AM +0800, Shawn Lin wrote:
>> commit f3a296405b6e ("PCI: dwc: Strengthen the MSI address allocation logic")
>> strengthened the iMSI-RX target address allocation logic to handle 64-bit
>> addresses for platforms without 32-bit DMA addresses. However, it still left
>> 32-bit MSI capable endpoints (EPs) non-functional on such platforms.
>>
>> Since iMSI-RX is a pure virtual address that doesn't require actual system
>> memory mapping, we can assign any 32-bit address that won't conflict with
>> system memory allocations. This patch uses cfg0_base as the iMSI-RX target
>> address, which satisfies this requirement.
> 
> Excellent finding! For reference, DWC databook r6.21a, sec 3.10.2.3 clarifies
> this behavior by stating that the incoming MWr TLP targeting the MSI_CTRL_ADDR
> is terminated by the iMSI-RX and never appears on the AXI bus. TBH this is how
> every other MSI controller behave I suppose.
> 
>>
>> [benefit]:
>>
>> Three scenarios are considered:
>> 1. cfg0_base is 32-bit: 32-bit MSI capable EPs now work correctly (main improvement)
>> 2. cfg0_base is 64-bit: Behavior remains identical to the previous approach
>> 3. Device requires 32-bit DMA addresses for uDMA transfer on platform without
>>     32-bit addresses: Still incompatible (unchanged behavior)
>>
>> The primary improvement is for case 1, where 32-bit MSI devices can now function
>> properly.
>>
>> [Test]:
>>
>> Tested on a Rockchip platform lacking 32-bit DMA addresses with an ASM1062 SATA
>> controller that only supports 32-bit MSI. The device functions correctly using
>> 43-bit DMA addressing via the board_ahci_43bit_dma flag in ahci_configure_dma_masks().
>>
>> The log looks like below:
>>
>> rockchip-dw-pcie 22400000.pcie: host bridge /soc/pcie@22400000 ranges:
>> rockchip-dw-pcie 22400000.pcie:       IO 0x0021100000..0x00211fffff -> 0x0021100000
>> rockchip-dw-pcie 22400000.pcie:      MEM 0x0021200000..0x0021ffffff -> 0x0021200000
>> rockchip-dw-pcie 22400000.pcie:      MEM 0x0980000000..0x09ffffffff -> 0x0980000000
>> rockchip-dw-pcie 22400000.pcie: Use cfg0_base 0x21000000 as iMSI-RX target address
>> rockchip-dw-pcie 22400000.pcie: iATU: unroll T, 8 ob, 8 ib, align 64K, limit 8G
>>
>> root@linaro-alip:/# lspci -vvv
>> 03:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 01) (prog-if 01 [AHCI 1.0])
>> 	Subsystem: ASMedia Technology Inc. ASM1061/ASM1062 Serial ATA Controller
>> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>> 	Latency: 0
>> 	Interrupt: pin A routed to IRQ 121
>> 	Region 0: I/O ports at 1020 [size=8]
>> 	Region 1: I/O ports at 1030 [size=4]
>> 	Region 2: I/O ports at 1028 [size=8]
>> 	Region 3: I/O ports at 1034 [size=4]
>> 	Region 4: I/O ports at 1000 [size=32]
>> 	Region 5: Memory at 21210000 (32-bit, non-prefetchable) [size=512]
>> 	Expansion ROM at 20200000 [virtual] [disabled] [size=64K]
>> 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
>> 		Address: 0x21000000  Data: 0003
>>
>> root@linaro-alip:/# cat /proc/interrupts | grep PCI-MSI
>> 117:    0      0     0     0      0     0    0     0   PCI-MSI       0 Edge      PCIe PME
>> 121:    90     0     0     0      0     0    0     0   PCI-MSI 1572864 Edge      ahci[0000:03:00.0]
>>
>> root@linaro-alip:/# dd if=/dev/sda1 of=/dev/null bs=1M count=10
>> 10+0 records in
>> 10+0 records out
>> 10485760 bytes (10 MB, 10 MiB) copied, 0.0227659 s, 461 MB/s
>>
>> root@linaro-alip:/# cat /proc/interrupts | grep PCI-MSI
>> 117:    0      0     0     0      0     0    0     0   PCI-MSI       0 Edge      PCIe PME
>> 121:   101     0     0     0      0     0    0     0   PCI-MSI 1572864 Edge      ahci[0000:03:00.0]
>>
>> MSI interrupt counts increase during I/O operations, confirming proper SATA controller
>> functionality.
>>
>> cc: Ajay Agarwal <ajayagarwal@google.com>
>> cc: Will McVicker <willmcvicker@google.com>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++------------
>>   1 file changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 372207c..faa9681 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -367,9 +367,13 @@ int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>>   	 * order not to miss MSI TLPs from those devices the MSI target
>>   	 * address has to be within the lowest 4GB.
>>   	 *
>> -	 * Note until there is a better alternative found the reservation is
>> -	 * done by allocating from the artificially limited DMA-coherent
>> -	 * memory.
>> +	 * Since iMSI-RX monitors a virtual address space that doesn't require
>> +	 * physical memory mapping, we simplify the implementation by reusing
>> +	 * cfg0_base as the target address. This approach guarantees the address
>> +	 * won't be allocated to endpoint drivers for normal memory operations.
>> +	 *
>> +	 * Limitation: 32-bit MSI endpoints cannot be supported when cfg0_base
>> +	 * is a 64-bit address.
>>   	 */
>>   	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>>   	if (!ret)
>> @@ -377,15 +381,9 @@ int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>>   						GFP_KERNEL);
>>   
>>   	if (!msi_vaddr) {
>> -		dev_warn(dev, "Failed to allocate 32-bit MSI address\n");
>> -		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
>> -		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>> -						GFP_KERNEL);
>> -		if (!msi_vaddr) {
>> -			dev_err(dev, "Failed to allocate MSI address\n");
>> -			dw_pcie_free_msi(pp);
>> -			return -ENOMEM;
>> -		}
>> +		pp->msi_data = pp->cfg0_base;
>> +		dev_info(dev, "Use cfg0_base 0x%llx as iMSI-RX target address\n", pp->cfg0_base);
> 
> This just assumes that 'config' space is always a 32bit address, but in
> practice, it is possible for the DWC glue implementation to have 64bit config
> address as well.
> 

I explained it in the commit message:

1. cfg0_base is 32-bit: 32-bit MSI capable EPs now work correctly (main 
improvement)
2. cfg0_base is 64-bit: Behavior remains identical to the previous approach

I think what you suggest is the 2nd case which I wrote. Using 64-bit
cfg0_base makes no differences with allocating 64-bit dma address.

> What we need to do is, if 32bit allocation fails, we should try to use 'config'
> space only if it is a 32bit address, otherwise 64bit allocation should be
> performed as usual:
> 
> 	if (!msi_vaddr) {
> 		/*
> 		 * Since the 32bit DMA-coherent memory allocation has failed,
> 		 * try the 'config' space address. If this is a 32bit address,
> 		 * use it as the MSI_CTRL_ADDR and claim that the iMSI-RX
> 		 * supports 32bit MSI address. Otherwise, try the 64bit coherent
> 		 * memory allocation.
> 		 */
> 		if (!pp->cfg0_base & GENMASK_ULL(63, 32)) {
> 			pp->msi_data = pp->cfg0_base;
> 		} else {
> 			dev_warn(dev, "Failed to allocate 32-bit MSI address\n");
> 			dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> 			msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> 							GFP_KERNEL);
> 			if (!msi_vaddr) {
> 				dev_err(dev, "Failed to allocate MSI address\n");
> 				dw_pcie_free_msi(pp);
> 				return -ENOMEM;
> 			}
> 		}
> 	}
> 
> - Mani
> 


