Return-Path: <linux-pci+bounces-42541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2FC9D8F8
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 03:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 480E334995A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 02:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0841AA1D2;
	Wed,  3 Dec 2025 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="d5E5kWWR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49217.qiye.163.com (mail-m49217.qiye.163.com [45.254.49.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508B272628
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764727966; cv=none; b=iV/gbHVKR9Q5OGjMv+s0SiPHV3Cl7aXjxXHKQHISV75j7jZ+wVksxDGPQ6x/v/RhpadXb3PCf0xB7svLtMoorOvOSMl4keBPP/A8ss9RDAGGeCVcGWIqoBvpauBNqw15Kq1W4PF01+7zbwiPTydeQJBCPlp0bC0Xg4Mw+HHW3qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764727966; c=relaxed/simple;
	bh=M7d6FLsMIJ7MF09Lkg3Q97GiMSpDhQnJHGQ1teUxMm0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EOAN5pWLgpTGgVp9MIS61VQqPftePts3z8+tKXr7Ldw3rXTKiVaEpI4kPSDQoJMrEe5UF0dE5GzDorteMHIlsbKZIEjojucMOfylQ8zyFjL2tgpCRbkOj+TasFgkY1+DP0SXDV0N/uGWKafjk47KbgCk7fZdm5jLr5E5xFUHllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=d5E5kWWR; arc=none smtp.client-ip=45.254.49.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2bc2ed3da;
	Wed, 3 Dec 2025 10:07:22 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Will McVicker <willmcvicker@google.com>
Subject: [PATCH] PCI: dwc: Use cfg0_base as iMSI-RX target address to support 32-bit MSI devices
Date: Wed,  3 Dec 2025 10:07:10 +0800
Message-Id: <1764727630-129853-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9ae1f6d72f09cckunm154e6bd2280c27
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhJTVZCT0pJH0MYHR9IGU9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=d5E5kWWRVFtHwD7WdvEku/SPzq2UcVDzF+V1AAu1vpQh+FC3uyUdzLFfoYuDZgxbWmjrL/UqyMd9oxj9eh99iZqaPO7UtrGQY9jqR8RzoMRR/cAARnXp4p5X9oWde7xQh/d2wCFC6U1DK7HknsNcAqkC5ZnzkmecOAi/i3A/Ly8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=VPTt7Wr4jVJBMXNg1YaMoxDA0lIhUel+XKjUbBSx33o=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

commit f3a296405b6e ("PCI: dwc: Strengthen the MSI address allocation logic")
strengthened the iMSI-RX target address allocation logic to handle 64-bit
addresses for platforms without 32-bit DMA addresses. However, it still left
32-bit MSI capable endpoints (EPs) non-functional on such platforms.

Since iMSI-RX is a pure virtual address that doesn't require actual system
memory mapping, we can assign any 32-bit address that won't conflict with
system memory allocations. This patch uses cfg0_base as the iMSI-RX target
address, which satisfies this requirement.

[benefit]:

Three scenarios are considered:
1. cfg0_base is 32-bit: 32-bit MSI capable EPs now work correctly (main improvement)
2. cfg0_base is 64-bit: Behavior remains identical to the previous approach
3. Device requires 32-bit DMA addresses for uDMA transfer on platform without
   32-bit addresses: Still incompatible (unchanged behavior)

The primary improvement is for case 1, where 32-bit MSI devices can now function
properly.

[Test]:

Tested on a Rockchip platform lacking 32-bit DMA addresses with an ASM1062 SATA
controller that only supports 32-bit MSI. The device functions correctly using
43-bit DMA addressing via the board_ahci_43bit_dma flag in ahci_configure_dma_masks().

The log looks like below:

rockchip-dw-pcie 22400000.pcie: host bridge /soc/pcie@22400000 ranges:
rockchip-dw-pcie 22400000.pcie:       IO 0x0021100000..0x00211fffff -> 0x0021100000
rockchip-dw-pcie 22400000.pcie:      MEM 0x0021200000..0x0021ffffff -> 0x0021200000
rockchip-dw-pcie 22400000.pcie:      MEM 0x0980000000..0x09ffffffff -> 0x0980000000
rockchip-dw-pcie 22400000.pcie: Use cfg0_base 0x21000000 as iMSI-RX target address
rockchip-dw-pcie 22400000.pcie: iATU: unroll T, 8 ob, 8 ib, align 64K, limit 8G

root@linaro-alip:/# lspci -vvv
03:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 01) (prog-if 01 [AHCI 1.0])
	Subsystem: ASMedia Technology Inc. ASM1061/ASM1062 Serial ATA Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 121
	Region 0: I/O ports at 1020 [size=8]
	Region 1: I/O ports at 1030 [size=4]
	Region 2: I/O ports at 1028 [size=8]
	Region 3: I/O ports at 1034 [size=4]
	Region 4: I/O ports at 1000 [size=32]
	Region 5: Memory at 21210000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at 20200000 [virtual] [disabled] [size=64K]
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: 0x21000000  Data: 0003

root@linaro-alip:/# cat /proc/interrupts | grep PCI-MSI
117:    0      0     0     0      0     0    0     0   PCI-MSI       0 Edge      PCIe PME
121:    90     0     0     0      0     0    0     0   PCI-MSI 1572864 Edge      ahci[0000:03:00.0]

root@linaro-alip:/# dd if=/dev/sda1 of=/dev/null bs=1M count=10
10+0 records in
10+0 records out
10485760 bytes (10 MB, 10 MiB) copied, 0.0227659 s, 461 MB/s

root@linaro-alip:/# cat /proc/interrupts | grep PCI-MSI
117:    0      0     0     0      0     0    0     0   PCI-MSI       0 Edge      PCIe PME
121:   101     0     0     0      0     0    0     0   PCI-MSI 1572864 Edge      ahci[0000:03:00.0]

MSI interrupt counts increase during I/O operations, confirming proper SATA controller
functionality.

cc: Ajay Agarwal <ajayagarwal@google.com>
cc: Will McVicker <willmcvicker@google.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 372207c..faa9681 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -367,9 +367,13 @@ int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	 * order not to miss MSI TLPs from those devices the MSI target
 	 * address has to be within the lowest 4GB.
 	 *
-	 * Note until there is a better alternative found the reservation is
-	 * done by allocating from the artificially limited DMA-coherent
-	 * memory.
+	 * Since iMSI-RX monitors a virtual address space that doesn't require
+	 * physical memory mapping, we simplify the implementation by reusing
+	 * cfg0_base as the target address. This approach guarantees the address
+	 * won't be allocated to endpoint drivers for normal memory operations.
+	 *
+	 * Limitation: 32-bit MSI endpoints cannot be supported when cfg0_base
+	 * is a 64-bit address.
 	 */
 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (!ret)
@@ -377,15 +381,9 @@ int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 						GFP_KERNEL);
 
 	if (!msi_vaddr) {
-		dev_warn(dev, "Failed to allocate 32-bit MSI address\n");
-		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
-		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
-						GFP_KERNEL);
-		if (!msi_vaddr) {
-			dev_err(dev, "Failed to allocate MSI address\n");
-			dw_pcie_free_msi(pp);
-			return -ENOMEM;
-		}
+		pp->msi_data = pp->cfg0_base;
+		dev_info(dev, "Use cfg0_base 0x%llx as iMSI-RX target address\n", pp->cfg0_base);
+		return 0;
 	}
 
 	return 0;
-- 
2.7.4


