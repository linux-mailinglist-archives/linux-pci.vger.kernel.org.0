Return-Path: <linux-pci+bounces-42879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 648ACCB2285
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 08:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D18A73027D3E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 07:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6F426E6FA;
	Wed, 10 Dec 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+3Rez9F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190063A8F7
	for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765350848; cv=none; b=mY/w43BUGwbzqjWMv/SX2Omg+ziMIYq5mJCvtbW9S7HCBr7S0zkX/ec6J4Nt+20PovG+mhzylmPfB2UXN9OzGNWNQMfjqJruNH4zer62lrdmyhWqLd05kvJhELxlAbQ+p7RrXqgOvqlYBAfyqzhLJ1vXpAtK4wn98LoFtYLSCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765350848; c=relaxed/simple;
	bh=Tv6EE1pV2IOCUiwwbELKrA2P0AJjepLF5d06nKpNWzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbD+Uek4ACyI+amuzL52VF+qR1gq/5nPtFtW+jAFQSCHUIw5coYUq4hFpAyZgVAbTW/Ppn5foeXMaTXRuZ07fpw1ll8JmrkMk1lB+Ki+9dJ+TXySgUUXpdeZsfvmALfOWEsvssSBiRdu9h6hdoDrtGZNVYpa7PIJnjAqqpbcMPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+3Rez9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E480EC4CEF1;
	Wed, 10 Dec 2025 07:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765350845;
	bh=Tv6EE1pV2IOCUiwwbELKrA2P0AJjepLF5d06nKpNWzc=;
	h=From:To:Cc:Subject:Date:From;
	b=S+3Rez9FPjkJQmLj4vJWc1z8lWPkStpjX1UBttRkGryEgI6eQItQERViTcKyGJ1cv
	 FZlMwe7mydeFmebpAwV6mplynCkMhgzztX1caf4KaNnSWTVHtZE5Jmqxus4cLwSM5N
	 e4c819hoKvABSR4C6XLDsYcpp3vHpYe6R5OYjh2CKWqJIQCk0IbaWTaSMO+Jk7j/xn
	 fZIuDAUsqbVvMKyBK1PukALUIshg2kHPUjTFyJBXVhJ3UihA4HNyAmLfHpV/vztUgg
	 pTn2MaQ0njP6nqPeqwGyhE6jhzcn6o2WOfyrUAyV+oXevR8oIOf+wwx6Z0MKDWYtrA
	 PR4huo0tR/XSA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
Date: Wed, 10 Dec 2025 08:13:58 +0100
Message-ID: <20251210071358.2267494-2-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7643; i=cassel@kernel.org; h=from:subject; bh=vTkBA/sKvOAwAYCy1z8+kBOefhQLNTvbLF+JqOEuf9Y=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDItZbeJ17BY35+ZW2JWyui7ZlXtqkmh0n9r7z906zkuz qYoPM29o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABPZpsnIsGajosTqPdtOPKr7 oXhCXrxh063Gz8n7P3qqRb+7dmWJainDP6PZwivT5HwlLt64mXbG/GJCV3zPg4c+YWwVdUqy2x7 2swAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Koichiro Den <den@valinux.co.jp>

dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
for the MSI target address on every interrupt and tears it down again
via dw_pcie_ep_unmap_addr().

On systems that heavily use the AXI bridge interface (for example when
the integrated eDMA engine is active), this means the outbound iATU
registers are updated while traffic is in flight. The DesignWare
endpoint databook 5.40a - "3.10.6.1 iATU Outbound Programming Overview"
warns that updating iATU registers in this situation is not supported,
and the behavior is undefined.

Under high MSI and eDMA load this pattern results in occasional bogus
outbound transactions and IOMMU faults, on the RC side, such as:

  ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000

followed by the system becoming unresponsive. This is the actual output
observed on Renesas R-Car S4, with its ipmmu_hc used with PCIe ch0.

There is no need to reprogram the iATU region used for MSI on every
interrupt. The host-provided MSI address is stable while MSI is enabled,
and the endpoint driver already dedicates a scratch buffer for MSI
generation.

Cache the aligned MSI address and map size, program the outbound iATU
once, and keep the window enabled. Subsequent interrupts only perform a
write to the MSI scratch buffer, avoiding dynamic iATU reprogramming in
the hot path and fixing the lockups seen under load.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
[cassel: do same change for dw_pcie_ep_raise_msix_irq()]
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Notes: Without this patch, I also see IOMMU errors on the host side,
when running drivers/nvme/target/pci-epf.c with a large queue depth.

pci_epc_raise_irq() does take a mutex, so the calls to these functions
are serialized, so it really appears that the DWC controller does not
handle iATU reprogramming while there are outstanding transactions.

Just like Koichiro describes here:
https://lore.kernel.org/linux-pci/ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6/

I also see the iova faulting on the RC side to be the start of "addr_space"
on the EP, so it appears that a transaction has gone through untranslated.
(Most likely because the DWC controller does handle the iATU table being
modified while there are outstanding transactions.)

This patch has been tested using pci-epf-test and nvmet-pci-epf on rock5b.

pci-epf-test does change between MSI and MSI-X without calling
dw_pcie_ep_stop(), however, the msg_addr address written by the host
will be the same address, at least when using a Linux host using a DWC
based controller. If another host ends up using different msg_addr for
MSI and MSI-X, then I think that we will need to modify pci-epf-test to
call a function when changing IRQ type, such that pcie-designware-ep.c
can tear down the MSI/MSI-X mapping.

 .../pci/controller/dwc/pcie-designware-ep.c   | 82 ++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
 2 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7f2112c2fb21..2bbeddaa73d4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -601,6 +601,16 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
+	/*
+	 * Tear down the dedicated outbound window used for MSI
+	 * generation. This avoids leaking an iATU window across
+	 * endpoint stop/start cycles.
+	 */
+	if (ep->msi_iatu_mapped) {
+		dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
+		ep->msi_iatu_mapped = false;
+	}
+
 	dw_pcie_stop_link(pci);
 }
 
@@ -702,14 +712,37 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
 
 	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
-	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
-				  map_size);
-	if (ret)
-		return ret;
 
-	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
+	/*
+	 * Program the outbound iATU once and keep it enabled.
+	 *
+	 * The spec warns that updating iATU registers while there are
+	 * operations in flight on the AXI bridge interface is not
+	 * supported, so we avoid reprogramming the region on every MSI,
+	 * specifically unmapping immediately after writel().
+	 */
+	if (!ep->msi_iatu_mapped) {
+		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
+					  ep->msi_mem_phys, msg_addr,
+					  map_size);
+		if (ret)
+			return ret;
+
+		ep->msi_iatu_mapped = true;
+		ep->msi_msg_addr = msg_addr;
+		ep->msi_map_size = map_size;
+	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
+				ep->msi_map_size != map_size)) {
+		/*
+		 * The host changed the MSI target address or the required
+		 * mapping size changed. Reprogramming the iATU at runtime is
+		 * unsafe on this controller, so bail out instead of trying to
+		 * update the existing region.
+		 */
+		return -EINVAL;
+	}
 
-	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
+	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
 
 	return 0;
 }
@@ -786,14 +819,36 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 
 	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
-	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
-				  map_size);
-	if (ret)
-		return ret;
 
-	writel(msg_data, ep->msi_mem + offset);
+	/*
+	 * Program the outbound iATU once and keep it enabled.
+	 *
+	 * The spec warns that updating iATU registers while there are
+	 * operations in flight on the AXI bridge interface is not
+	 * supported, so we avoid reprogramming the region on every MSI-X,
+	 * specifically unmapping immediately after writel().
+	 */
+	if (!ep->msi_iatu_mapped) {
+		ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
+					  map_size);
+		if (ret)
+			return ret;
+
+		ep->msi_iatu_mapped = true;
+		ep->msi_msg_addr = msg_addr;
+		ep->msi_map_size = map_size;
+	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
+				ep->msi_map_size != map_size)) {
+		/*
+		 * The host changed the MSI-X target address or the required
+		 * mapping size changed. Reprogramming the iATU at runtime is
+		 * unsafe on this controller, so bail out instead of trying to
+		 * update the existing region.
+		 */
+		return -EINVAL;
+	}
 
-	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
+	writel(msg_data, ep->msi_mem + offset);
 
 	return 0;
 }
@@ -1086,6 +1141,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 
 	INIT_LIST_HEAD(&ep->func_list);
+	ep->msi_iatu_mapped = false;
+	ep->msi_msg_addr = 0;
+	ep->msi_map_size = 0;
 
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a31bd93490dc..1093c622826d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -472,6 +472,11 @@ struct dw_pcie_ep {
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
+
+	/* MSI outbound iATU state */
+	bool			msi_iatu_mapped;
+	u64			msi_msg_addr;
+	size_t			msi_map_size;
 };
 
 struct dw_pcie_ops {
-- 
2.52.0


