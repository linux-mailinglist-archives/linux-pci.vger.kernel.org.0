Return-Path: <linux-pci+bounces-5386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D693D891574
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1402B1C21D20
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8566F2C6AA;
	Fri, 29 Mar 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJM32OjR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6148737152
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703406; cv=none; b=V574UKMr88hoGkpSmdh9TNP6izzRhcd++I7DAkbgojlEL2CYhVfkFBrWA46OKexUIHq00QuxESjtgPSwAXGPZKRpqonmO1Jd+cPwjZfnMaMGmXSaAR9W3y2HFFUi5IrnVihxdYirc6yCNR0dCR0BbXBz+pUrwkZjIJC03QfkSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703406; c=relaxed/simple;
	bh=V/9fC8s68KTcgM87C93vvKDSr1AEhX43ztr6Cblt1Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPNFcQOYr+jEdl7ZSpNgNWi23gdjQyeOmfd7eVH79Izeo6MiBAMYDG9cSgZdrj++Ym9aSc2BEzUyQZk637l6xaDDPt5S518FbNT3xF39RuMVT96Bh1zsgK9tBqcpvbzmTB97NcwWxJJIsMiyXvZNaRycCsiMQFn6/cv+Y1WWrTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJM32OjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A04FC433C7;
	Fri, 29 Mar 2024 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703406;
	bh=V/9fC8s68KTcgM87C93vvKDSr1AEhX43ztr6Cblt1Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJM32OjRFBqas7mhpEPychf3nDO84Ubo2u42bDESbXQuOlxLwUp6RLdI357rKZRNq
	 62iP2luSYr1ipoaMrzC3lk+0lxEMoBiJz2/6X6wUoasK5gJb14ekLOsifRA6QpsW4b
	 OtnSgtbjPSEzcgi8jG9Wi1ZOnS5YTOvMT+ifVnNTLITanqMHw68oOmZSHeVSWNHSw8
	 xzulxAfvh1J/z1xZFM0eOPEBUkwFkUh1lNyPiPPWj12mGsAJzAELj/3T64lLVedAgq
	 fMijtuHto5Ph0Zmn99L5gtBnJECH/W72OB/U0eDotAXddwiLvJrsZ0oPBXKSGcz/1u
	 LaoCHSo/1+WAQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 12/19] PCI: rockchip-ep: Implement the map_info endpoint controller operation
Date: Fri, 29 Mar 2024 18:09:38 +0900
Message-ID: <20240329090945.1097609-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329090945.1097609-1-dlemoal@kernel.org>
References: <20240329090945.1097609-1-dlemoal@kernel.org>
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

Implement the ->map_info() endpoint controller operation to allow this
mapping information to be transparently used by endpoint function
drivers through the function pci_epc_map_info().

Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 22 ++++++++++++++++++++++
 drivers/pci/controller/pcie-rockchip.h    |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index c2ca7878cee3..223132acc787 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -237,6 +237,27 @@ static inline u32 rockchip_ob_region(phys_addr_t addr)
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
@@ -460,6 +481,7 @@ static const struct pci_epc_ops rockchip_pcie_epc_ops = {
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
2.44.0


