Return-Path: <linux-pci+bounces-43599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B900CD9D33
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 16:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70C833018917
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7129DB65;
	Tue, 23 Dec 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBFIjRks"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572329B8D9
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766504654; cv=none; b=nMvePjX2Sx0zvtW+cjUn6eeNP3ZWs3cA4vDAnmeLn2otLgJXaSJQ7TQLija4TZN/AschidlvOlbYjV7q+owRUI53VtLxiAt2OD1beaiopA0aZLaZ6tz/FDZpiVuP7WAJLUYsnkIcws5DYbW6BucEFi+Wh+WpsPXK+33GzynVpz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766504654; c=relaxed/simple;
	bh=OsrpBcv4VF9p/kxszbtrHsang6ct6Zw+8JCKWbvk6Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2dxHCfCZqs4WRzHsk+bqFt3p0v/hn9fitNYwRsHfMvI/3VLPyQfvZ7CMV1kTT4+XRAvB6ObuKPDRyCfXgS91qH8B9cEI3fct44BGbZJVy68ba6AS91A/TJ2Rg5zAc6XzmoQtDeTwwPXG+MELP+nNOEnPbhfTLaxq/tQjOBU+WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBFIjRks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ADAC113D0;
	Tue, 23 Dec 2025 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766504653;
	bh=OsrpBcv4VF9p/kxszbtrHsang6ct6Zw+8JCKWbvk6Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vBFIjRks97fLlkRDLYgI5RQ6OJUIaGChTlR5MiW1N9g3pGp3jzRVfzPP0+U4up9bD
	 sqkALFmGoJ+lam0vAkXrRpNtQ4UwEY+Mseav4lc4wSLD040AZidhpb9M2FgpF73GhQ
	 zwMaBElS1/Kvulqg/0kLew1wL3GOmDIDFj+GaQokB0vNJD7CtDVh/ZPaEHFwY/QSXR
	 tHx92jst9+EVsgNREFcPv2qTxRgW1u268rf4VN1V+xBnfwR35uxOVHSSvBOqmCCuqe
	 /Hz4oEx1R/+IDLAHUrtP5/kpjDkkIZzjz/nAb7rrGqFx6k1vxtCWDknRLFGqDg4b9z
	 6vPl6zsqFnfDw==
Date: Tue, 23 Dec 2025 21:14:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>, 
	Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH] PCI: dwc: Use cfg0_base as iMSI-RX target address to
 support 32-bit MSI devices
Message-ID: <t5brjzmsl6bzo2ku7ojjgm72syls2dgbll3wdkla5jzveqj75o@o5l6wg4g7cqg>
References: <1764727630-129853-1-git-send-email-shawn.lin@rock-chips.com>
 <wc5s43s2aprtrxfyvjk7ebcutqse54kj4w452hqitqq3as5bj3@bg3ohzcbljy4>
 <7eb9773d-1d94-4443-a3eb-80ef3ccc60f9@rock-chips.com>
 <vdxwg6x6lx5oumjvxwwejxwwrsttx5uopy6q7lk6pjnplfx6a6@2w4jilfrrpkl>
 <3666010f-334e-412a-8d96-d5c40b40a88c@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3666010f-334e-412a-8d96-d5c40b40a88c@rock-chips.com>

On Tue, Dec 23, 2025 at 10:20:17PM +0800, Shawn Lin wrote:
> 在 2025/12/23 星期二 21:47, Manivannan Sadhasivam 写道:
> > On Tue, Dec 23, 2025 at 09:16:45PM +0800, Shawn Lin wrote:
> > > 在 2025/12/23 星期二 20:22, Manivannan Sadhasivam 写道:
> > > > On Wed, Dec 03, 2025 at 10:07:10AM +0800, Shawn Lin wrote:
> > > > > commit f3a296405b6e ("PCI: dwc: Strengthen the MSI address allocation logic")
> > > > > strengthened the iMSI-RX target address allocation logic to handle 64-bit
> > > > > addresses for platforms without 32-bit DMA addresses. However, it still left
> > > > > 32-bit MSI capable endpoints (EPs) non-functional on such platforms.
> > > > > 
> > > > > Since iMSI-RX is a pure virtual address that doesn't require actual system
> > > > > memory mapping, we can assign any 32-bit address that won't conflict with
> > > > > system memory allocations. This patch uses cfg0_base as the iMSI-RX target
> > > > > address, which satisfies this requirement.
> > > > 
> > > > Excellent finding! For reference, DWC databook r6.21a, sec 3.10.2.3 clarifies
> > > > this behavior by stating that the incoming MWr TLP targeting the MSI_CTRL_ADDR
> > > > is terminated by the iMSI-RX and never appears on the AXI bus. TBH this is how
> > > > every other MSI controller behave I suppose.
> > > > 
> > > > > 
> > > > > [benefit]:
> > > > > 
> > > > > Three scenarios are considered:
> > > > > 1. cfg0_base is 32-bit: 32-bit MSI capable EPs now work correctly (main improvement)
> > > > > 2. cfg0_base is 64-bit: Behavior remains identical to the previous approach
> > > > > 3. Device requires 32-bit DMA addresses for uDMA transfer on platform without
> > > > >      32-bit addresses: Still incompatible (unchanged behavior)
> > > > > 
> > > > > The primary improvement is for case 1, where 32-bit MSI devices can now function
> > > > > properly.
> > > > > 
> > > > > [Test]:
> > > > > 
> > > > > Tested on a Rockchip platform lacking 32-bit DMA addresses with an ASM1062 SATA
> > > > > controller that only supports 32-bit MSI. The device functions correctly using
> > > > > 43-bit DMA addressing via the board_ahci_43bit_dma flag in ahci_configure_dma_masks().
> > > > > 
> > > > > The log looks like below:
> > > > > 
> > > > > rockchip-dw-pcie 22400000.pcie: host bridge /soc/pcie@22400000 ranges:
> > > > > rockchip-dw-pcie 22400000.pcie:       IO 0x0021100000..0x00211fffff -> 0x0021100000
> > > > > rockchip-dw-pcie 22400000.pcie:      MEM 0x0021200000..0x0021ffffff -> 0x0021200000
> > > > > rockchip-dw-pcie 22400000.pcie:      MEM 0x0980000000..0x09ffffffff -> 0x0980000000
> > > > > rockchip-dw-pcie 22400000.pcie: Use cfg0_base 0x21000000 as iMSI-RX target address
> > > > > rockchip-dw-pcie 22400000.pcie: iATU: unroll T, 8 ob, 8 ib, align 64K, limit 8G
> > > > > 
> > > > > root@linaro-alip:/# lspci -vvv
> > > > > 03:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 01) (prog-if 01 [AHCI 1.0])
> > > > > 	Subsystem: ASMedia Technology Inc. ASM1061/ASM1062 Serial ATA Controller
> > > > > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> > > > > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > > > > 	Latency: 0
> > > > > 	Interrupt: pin A routed to IRQ 121
> > > > > 	Region 0: I/O ports at 1020 [size=8]
> > > > > 	Region 1: I/O ports at 1030 [size=4]
> > > > > 	Region 2: I/O ports at 1028 [size=8]
> > > > > 	Region 3: I/O ports at 1034 [size=4]
> > > > > 	Region 4: I/O ports at 1000 [size=32]
> > > > > 	Region 5: Memory at 21210000 (32-bit, non-prefetchable) [size=512]
> > > > > 	Expansion ROM at 20200000 [virtual] [disabled] [size=64K]
> > > > > 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > > > 		Address: 0x21000000  Data: 0003
> > > > > 
> > > > > root@linaro-alip:/# cat /proc/interrupts | grep PCI-MSI
> > > > > 117:    0      0     0     0      0     0    0     0   PCI-MSI       0 Edge      PCIe PME
> > > > > 121:    90     0     0     0      0     0    0     0   PCI-MSI 1572864 Edge      ahci[0000:03:00.0]
> > > > > 
> > > > > root@linaro-alip:/# dd if=/dev/sda1 of=/dev/null bs=1M count=10
> > > > > 10+0 records in
> > > > > 10+0 records out
> > > > > 10485760 bytes (10 MB, 10 MiB) copied, 0.0227659 s, 461 MB/s
> > > > > 
> > > > > root@linaro-alip:/# cat /proc/interrupts | grep PCI-MSI
> > > > > 117:    0      0     0     0      0     0    0     0   PCI-MSI       0 Edge      PCIe PME
> > > > > 121:   101     0     0     0      0     0    0     0   PCI-MSI 1572864 Edge      ahci[0000:03:00.0]
> > > > > 
> > > > > MSI interrupt counts increase during I/O operations, confirming proper SATA controller
> > > > > functionality.
> > > > > 
> > > > > cc: Ajay Agarwal <ajayagarwal@google.com>
> > > > > cc: Will McVicker <willmcvicker@google.com>
> > > > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > > > ---
> > > > > 
> > > > >    drivers/pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++------------
> > > > >    1 file changed, 10 insertions(+), 12 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > index 372207c..faa9681 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > @@ -367,9 +367,13 @@ int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > > >    	 * order not to miss MSI TLPs from those devices the MSI target
> > > > >    	 * address has to be within the lowest 4GB.
> > > > >    	 *
> > > > > -	 * Note until there is a better alternative found the reservation is
> > > > > -	 * done by allocating from the artificially limited DMA-coherent
> > > > > -	 * memory.
> > > > > +	 * Since iMSI-RX monitors a virtual address space that doesn't require
> > > > > +	 * physical memory mapping, we simplify the implementation by reusing
> > > > > +	 * cfg0_base as the target address. This approach guarantees the address
> > > > > +	 * won't be allocated to endpoint drivers for normal memory operations.
> > > > > +	 *
> > > > > +	 * Limitation: 32-bit MSI endpoints cannot be supported when cfg0_base
> > > > > +	 * is a 64-bit address.
> > > > >    	 */
> > > > >    	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > > > >    	if (!ret)
> > > > > @@ -377,15 +381,9 @@ int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > > >    						GFP_KERNEL);
> > > > >    	if (!msi_vaddr) {
> > > > > -		dev_warn(dev, "Failed to allocate 32-bit MSI address\n");
> > > > > -		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > > > > -		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > > > -						GFP_KERNEL);
> > > > > -		if (!msi_vaddr) {
> > > > > -			dev_err(dev, "Failed to allocate MSI address\n");
> > > > > -			dw_pcie_free_msi(pp);
> > > > > -			return -ENOMEM;
> > > > > -		}
> > > > > +		pp->msi_data = pp->cfg0_base;
> > > > > +		dev_info(dev, "Use cfg0_base 0x%llx as iMSI-RX target address\n", pp->cfg0_base);
> > > > 
> > > > This just assumes that 'config' space is always a 32bit address, but in
> > > > practice, it is possible for the DWC glue implementation to have 64bit config
> > > > address as well.
> > > > 
> > > 
> > > I explained it in the commit message:
> > > 
> > > 1. cfg0_base is 32-bit: 32-bit MSI capable EPs now work correctly (main
> > > improvement)
> > > 2. cfg0_base is 64-bit: Behavior remains identical to the previous approach
> > > 
> > > I think what you suggest is the 2nd case which I wrote. Using 64-bit
> > > cfg0_base makes no differences with allocating 64-bit dma address.
> > > 
> > 
> > How can you make sure that the cfg0_base is always 32bit or 64bit and not
> > something else? There is no guarantee that the platform will always allocate
> > 'config' region in either 32bit or 64bit, it can very well allocate something
> > like 36bit, 40bit etc...
> 
> Sure, it could be 36bit for example. I should rephase it like:
> if cfg0_base is more than 32bit, behaviour remains identical to the
> previous approach.
> 
> The fact for 32-bit MSI capable EP is that it cannot provide a Message
> Address[63:32] for RC to set the high MSI target address. This doesn't
> matter if it's 64-bit, 40-bit or 36-bit, etc, because the high address is
> always lost in these cases.
> 
> 
> > 
> > Also, you do not set the coherent mask and just retain 32bit mask, which itself
> > is wrong.
> 
> This is indeed a flaw I overlooked. For the RC drivers, it's useless
> because it's only used for allocating MSI target address once here. The
> only pontential problem is EP function driver attached inherits the DMA
> mask to allocate DMA address for DMA transfer. But EP function driver
> should set dma mask for themselves, becuase no RC drivers guarantee to
> set correct DMA mask for them. For example, EP can only perform 34-bit
> DMA, but it inherits 64-bit DMA mask from RC's dev->dma_mask, it can't
> work at all.
> 

True. Mask needs to be set only by the entity that performs the DMA operation,
so that's the EP client driver. But my concern was that the patch sets 32bit
mask and never changes that later even if the 64bit MSI address is used. It is
currently not serving any purpose, but I don't want to have this corner case for
correctness.

But I think we could flip the assignment. Check if the 'config' space is 32bit
and set 'msi_data' if it is true, otherwise fallback to the coherent DMA
allocation. Most of the platforms provide 32bit 'config' space address, so it
makes sense to use it as the first option. For the rare ones (like some Qcom
SoCs), fallback to allocation logic.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

