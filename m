Return-Path: <linux-pci+bounces-13915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2E8992367
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63F41F22948
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88854879B;
	Mon,  7 Oct 2024 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaiS/9zF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D543C2F;
	Mon,  7 Oct 2024 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274353; cv=none; b=njsEyHWegZExheoi7PJcH7HRpskQ427T9cZUqg9yW4GaMbMmaoQ6DTdWH6iZlNKr9/R84zw+5dwhDo9Rnghbgx6XRvbZiZqhJGy68d7S6T5e5wLVjErUg4KtCMIOx2XYjx1m17m6K3y7iBMWXV3ZCW/iXzf5Xmy9KSI0mSXgb6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274353; c=relaxed/simple;
	bh=YXwtDpZsLghWFwsXwrt/8ym6U04F+m9T5KgQswcLSak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ+KnVnZQQ22FUC4yUnVYsaO8bPldlkkX2hAfIqKUHi1mCAiTKJYB9AJUfV7hQA8cWbr7qbCWbI6O/pdEPSidxCZdxl2JDduiw1LhrN8x5XSynFJx0hq7TwEE2tJj9B2C/EqixX02jc2rAJQ6lZl/ijRUtKv/IEaXwc93dG2Z40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaiS/9zF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56954C4CECF;
	Mon,  7 Oct 2024 04:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728274353;
	bh=YXwtDpZsLghWFwsXwrt/8ym6U04F+m9T5KgQswcLSak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KaiS/9zFWcajSpjM1UIR2W0ZBSPohaZao0TtxNEi1BhHGQmD+EXCeBkGZPZ+fcFYz
	 +lMP1bCbHIUY/i8/X3gGFDW7X/jRED2ROZklflbCo72h9FlO4djkvUGBoeir+kLcvp
	 9kHXN9LLttgYpH4RMcg+sLbjBKaz/OfB4dK099j0EpSqi5SdDm2vLtaXEKTajhtgKJ
	 PrZ54IU6V370VHlzuPKoEapaNCmHUptgs1K44SAHNJ/rOS56EGKVhDYW819eZb82/K
	 3D1CMSD0QOOwl+teb3WKJj/w0VuXFdcogUjBbHmdOGuyauHQsMlmkVQbnUHbilGUw4
	 ygGejOZsGFMVw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 05/12] PCI: rockchip-ep: Implement the .map_align() controller operation
Date: Mon,  7 Oct 2024 13:12:11 +0900
Message-ID: <20241007041218.157516-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007041218.157516-1-dlemoal@kernel.org>
References: <20241007041218.157516-1-dlemoal@kernel.org>
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

Implement the ->map_align() endpoint controller operation to allow the
mapping alignment to be transparently handled by endpoint function
drivers through the function pci_epc_map_align().

Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 22 ++++++++++++++++++++++
 drivers/pci/controller/pcie-rockchip.h    |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index edb84fb1ba39..a9b319d4e507 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -235,6 +235,27 @@ static inline u32 rockchip_ob_region(phys_addr_t addr)
 	return (addr >> ilog2(SZ_1M)) & 0x1f;
 }
 
+static int rockchip_pcie_ep_map_align(struct pci_epc *epc, u8 fn, u8 vfn,
+				      struct pci_epc_map *map)
+{
+	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
+	int num_bits;
+
+	num_bits = rockchip_pcie_ep_ob_atu_num_bits(&ep->rockchip,
+						map->pci_addr, map->pci_size);
+
+	map->map_pci_addr = map->pci_addr & ~((1ULL << num_bits) - 1);
+	map->map_ofst = map->pci_addr - map->map_pci_addr;
+
+	if (map->map_ofst + map->pci_size > SZ_1M)
+		map->pci_size = SZ_1M - map->map_ofst;
+
+	map->map_size = ALIGN(map->map_ofst + map->pci_size,
+			      ROCKCHIP_PCIE_AT_SIZE_ALIGN);
+
+	return 0;
+}
+
 static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 				     phys_addr_t addr, u64 pci_addr,
 				     size_t size)
@@ -458,6 +479,7 @@ static const struct pci_epc_ops rockchip_pcie_epc_ops = {
 	.write_header	= rockchip_pcie_ep_write_header,
 	.set_bar	= rockchip_pcie_ep_set_bar,
 	.clear_bar	= rockchip_pcie_ep_clear_bar,
+	.map_align	= rockchip_pcie_ep_map_align,
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
2.46.2


