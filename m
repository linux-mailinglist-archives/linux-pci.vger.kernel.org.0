Return-Path: <linux-pci+bounces-14709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB69A1838
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17AB1C20385
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE392CCB4;
	Thu, 17 Oct 2024 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLXBScuP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A818DF4ED;
	Thu, 17 Oct 2024 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130342; cv=none; b=iEIoV6Q/tub7UEWO5W7C+CHPRGZkQiQaYgcejGKJewm82A3cxKT9Lz/TA5ToziLaw2U+ftHzSvtnL2ZLgw9gdwI30uqvDLiSb+UMC4N27Nea9KPuP73BLw1WveH9VRTygpummojFapNxYYswzt1IoH0LFS78V/XkzbXIn4BI1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130342; c=relaxed/simple;
	bh=/G8QAI8kvEcdWwWRcNBS76LHUxKFVpIiDUO29Vg61NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfI99RScG6dlTz14Ds5pPKjc38Zj5pAr/Q3K4clUEyO8vcHaSM7Ls1D627ciTmHjsWNyiWMBzi4BqxbuvKtKOHbN54A8u2C50iycX/14QLTAIT8EuvGnGV+5yCmePsn0qwWzuHqoXKNIYUFMxX9NfJC5riLuv2PZ0j2gjJaWd/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLXBScuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8749DC4CED0;
	Thu, 17 Oct 2024 01:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130342;
	bh=/G8QAI8kvEcdWwWRcNBS76LHUxKFVpIiDUO29Vg61NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLXBScuP3gCF2DE7VqWery7dd0EIqjLdo2P2DuUDOeyGThrIYu2hM7NJcv3o1dG/6
	 EKAXd82OtZLsIK6SyWvPRc9a7GbaNGYiQu7jT+EsvQ5MnzLpU3i5tvKUJh7lHwpwhH
	 PHs0lOIIpeZsz/zYTDqhiIxvk9Iw13k/ONpT7yoCK6iRIRhFHXjpeeFojvc2hDAmL9
	 p2WcOB849HtG/t3kVeM93HnVT/2pyy+Y9Qt9p3ZpVgS9kLFpeLGXLYkk2QWcy0CAAj
	 uTG/lhcq3kAwmzNG4rmBu+PuFtabb8fFz9X06O0BuXTeo1HqVMPksEhQJPLW+vNQUC
	 G5d7fU8A+3bzA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 05/14] PCI: rockchip-ep: Implement the pci_epc_ops::align_addr() operation
Date: Thu, 17 Oct 2024 10:58:40 +0900
Message-ID: <20241017015849.190271-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017015849.190271-1-dlemoal@kernel.org>
References: <20241017015849.190271-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rockchip PCIe endpoint controller handles PCIe transfers addresses
by masking the lower bits of the programmed PCI address and using the
same number of lower bits from the CPU address space used for the
mapping. For a PCI mapping of size bytes starting from pci_addr, the
number of bits masked is the number of address bits changing in the
address range [pci_addr..pci_addr + size - 1], up to 20 bits, that is,
up to 1MB mappings.

This means that when preparing a PCI address mapping, an endpoint
function driver must use an offset into the allocated controller
memory region that is equal to the mask of the starting PCI address
over rockchip_pcie_ep_ob_atu_num_bits() bits. This offset also
determines the maximum size of the mapping given the starting PCI
address and the fixed 1MB controller memory window size.

Implement the ->align_addr() endpoint controller operation to allow the
mapping alignment to be transparently handled by endpoint function
drivers through the function pci_epc_mem_map().

Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 23 +++++++++++++++++++++++
 drivers/pci/controller/pcie-rockchip.h    |  5 +++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index edb84fb1ba39..f6959f9b94b7 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -235,6 +235,28 @@ static inline u32 rockchip_ob_region(phys_addr_t addr)
 	return (addr >> ilog2(SZ_1M)) & 0x1f;
 }
 
+static u64 rockchip_pcie_ep_align_addr(struct pci_epc *epc, u64 pci_addr,
+				       size_t *pci_size, size_t *offset)
+{
+	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
+	size_t size = *pci_size;
+	u64 ofst, mask;
+	int num_bits;
+
+	num_bits = rockchip_pcie_ep_ob_atu_num_bits(&ep->rockchip,
+						    pci_addr, size);
+	mask = (1ULL << num_bits) - 1;
+
+	ofst = pci_addr & mask;
+	if (size + ofst > SZ_1M)
+		size = SZ_1M - ofst;
+
+	*pci_size = ALIGN(ofst + size, ROCKCHIP_PCIE_AT_SIZE_ALIGN);
+	*offset = ofst;
+
+	return pci_addr & ~mask;
+}
+
 static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 				     phys_addr_t addr, u64 pci_addr,
 				     size_t size)
@@ -458,6 +480,7 @@ static const struct pci_epc_ops rockchip_pcie_epc_ops = {
 	.write_header	= rockchip_pcie_ep_write_header,
 	.set_bar	= rockchip_pcie_ep_set_bar,
 	.clear_bar	= rockchip_pcie_ep_clear_bar,
+	.align_addr	= rockchip_pcie_ep_align_addr,
 	.map_addr	= rockchip_pcie_ep_map_addr,
 	.unmap_addr	= rockchip_pcie_ep_unmap_addr,
 	.set_msi	= rockchip_pcie_ep_set_msi,
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 02368ce9bd54..30398156095f 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -241,6 +241,11 @@
 #define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK		GENMASK(15, 8)
 #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
 #define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR		0x3
+
+#define ROCKCHIP_PCIE_AT_MIN_NUM_BITS	8
+#define ROCKCHIP_PCIE_AT_MAX_NUM_BITS	20
+#define ROCKCHIP_PCIE_AT_SIZE_ALIGN	(1UL << ROCKCHIP_PCIE_AT_MIN_NUM_BITS)
+
 #define ROCKCHIP_PCIE_EP_FUNC_BASE(fn) \
 	(PCIE_EP_PF_CONFIG_REGS_BASE + (((fn) << 12) & GENMASK(19, 12)))
 #define ROCKCHIP_PCIE_EP_VIRT_FUNC_BASE(fn) \
-- 
2.47.0


