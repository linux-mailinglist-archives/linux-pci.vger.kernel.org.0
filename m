Return-Path: <linux-pci+bounces-43624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEDCCDB15B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 02:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 875EA3005259
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 01:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172AB26E175;
	Wed, 24 Dec 2025 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="aNUga5Ta"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49204.qiye.163.com (mail-m49204.qiye.163.com [45.254.49.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED2231A30
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540360; cv=none; b=AnEI9IMCKbAIDChl6NjKaHIS4q/if6wJu10UYj/Wnd1lje8BjR8+06YDu8Gac6ANnERHe1FfUqPqUDenwnGdzCjuxCPmA8oAYHC9xr3+5HcldM/scYAxIIYEyZaw76UE8yeYB5XwRod1LRf41GUauaeerHerDbF7eRCLtToVKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540360; c=relaxed/simple;
	bh=3tqt+uH7mcJzeKVPIdhYWofwx4EpQjr6jbkyY5adOZ0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EYgS6H0Cyz9Aft/bBqq9+op39tyMaCmpFxHFT6Y6sxn/nzG7XGy24S0LmfygRp9kU+OeaJIZTno5gtE1Ia3rRrtOPInBJ/w++2CiHtHrR3eauDi8O9w32yGRduvhf+VOzRT6in5Orf/h5FV+YZ7XLt+KJ960srGQ0xmd22NpdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=aNUga5Ta; arc=none smtp.client-ip=45.254.49.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e580fb76;
	Wed, 24 Dec 2025 09:39:05 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Will McVicker <willmcvicker@google.com>
Subject: [PATCH v2] PCI: dwc: Use cfg0_base as iMSI-RX target address to support 32-bit MSI devices
Date: Wed, 24 Dec 2025 09:38:52 +0800
Message-Id: <1766540332-24235-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9b4e02811e09cckunm43bb1379375c93
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk8eTlZISUxDSBhIGEwZH0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=aNUga5TaZyccPkBMxDpHuTNf+d+6Rxry4dJ1LqtMKB8rBHdtxrD/deJv90AAzyopaSMW+nvQlH8r1AETS3CwHoF5+EqOd3pSn2IXd33zbbZgbNVepQBHBAGf8RT0xBXexErb7Eg6LNbFBMcvsbahCr3yDOmTp8bweOsOKfjA0NI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=kD0778QOdl00l7E/fs3sQg53czUMAH3dgmf7U4Ww8ZU=;
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

Per DWC databook r5.10a, section 3.8.2.2, it states:
"The iMSI-RX is programmed with an address (MSI_CTRL_ADDR_OFF and
MSI_CTRL_UPPER_ADDR_OFF) that is used as the system MSI address. When an
inbound MWr request is passed to the AXI bridge and matches this address
as well as the conditions specified for an MSI memory write request, an
MSI interrupt is detected. When this MWr is about to be driven onto the
AXI bridge master interface1, it is dropped and never appears on the AXI
bus."

It's also confirmed by DWC databook r6.21a, section 3.10.2.3. So this
behaviour should be the same for all DWC based iMSI-RX block. Since iMSI-RX
is a pure virtual address that doesn't require actual system memory mapping,
we can assign any 32-bit address that won't conflict with system memory
allocations. Assign cfg0_base to the iMSI-RX target address as the first
option if it's a 32-bit address, which satisfies this requirement. Otherwise,
we still fallback to the original approach.

Tested on a Rockchip platform lacking 32-bit DMA addresses with an ASM1062 SATA
controller that only supports 32-bit MSI. The device functions correctly using
43-bit DMA addressing via the board_ahci_43bit_dma flag in ahci_configure_dma_masks().
The config space address for this host controller is located on 0x21000000, which
is assigned to EP's MSI target address comfirmed by lspci output.

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
	  Expansion ROM at 21200000 [virtual] [disabled] [size=64K]
	  Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
			Address: 0x21000000  Data: 0003

MSI interrupt counts increase during I/O operations, confirming proper SATA controller
functionality.

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

cc: Ajay Agarwal <ajayagarwal@google.com>
cc: Will McVicker <willmcvicker@google.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- use cfg0_base as first option if it's a 32-bit address(Mani)
- Add reference from databook and rework the code comment and
  commit message

 drivers/pci/controller/dwc/pcie-designware-host.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f116591..c88db99 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -356,10 +356,20 @@ int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	 * order not to miss MSI TLPs from those devices the MSI target
 	 * address has to be within the lowest 4GB.
 	 *
-	 * Note until there is a better alternative found the reservation is
-	 * done by allocating from the artificially limited DMA-coherent
-	 * memory.
+	 * Per DWC databook r6.21a, section 3.10.2.3, the incoming MWr TLP
+	 * targeting the MSI_CTRL_ADDR is terminated by the iMSI-RX and
+	 * never appears on the AXI bus. Since iMSI-RX monitors a virtual
+	 * address space that doesn't require physical memory mapping, and
+	 * most of the platforms provide 32-bit config space address, we
+	 * use cfg0_base as the first option for the MSI target address if
+	 * it's a 32-bit address. Otherwise, try 32-bit and 64-bit coherent
+	 * memory allocation one by one.
 	 */
+	if (!(pp->cfg0_base & GENMASK_ULL(63, 32))) {
+		pp->msi_data = pp->cfg0_base;
+		return 0;
+	}
+
 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (!ret)
 		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
-- 
2.7.4


