Return-Path: <linux-pci+bounces-14705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6549A1831
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E441F271FA
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8427D282FA;
	Thu, 17 Oct 2024 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3MeY6MA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD7FF4ED;
	Thu, 17 Oct 2024 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130334; cv=none; b=ODkIXvvQlHLgbw2Fz1KTWPSIE/12FCX/y0bbYOCQh9vasLuOUlO6SGtfCVyF91e4JrDtCapP5Vb6LkYQlbxq0s5d3N98+HNCi44VioOMYXA6/JSzNpgWp4XB1VB65OQnXntSaJT3mMSpvxE7gWS5tZe2zIx1JwZLYFgbm1Qn9Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130334; c=relaxed/simple;
	bh=5hrJOQYC2viBOT0J3u4iqIZmFH2YCX8M3aVKEAlS5sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv3uPV2Hm1QB9rk83HFPfY10fcaXLgAcsuU+5DoqtD5W6Q0BhpKyMmcME7UeJeO4U4FpduilUgZP6nZQ51/rFgVnURBqPgqfgRdmltALoD1+WRv3YJYAgemOVQio1+uRlvtNUu89PSZPmhbgaRNeT3GZcAh06p1CCfg6Ad5Qem4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3MeY6MA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CB6C4CED3;
	Thu, 17 Oct 2024 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130334;
	bh=5hrJOQYC2viBOT0J3u4iqIZmFH2YCX8M3aVKEAlS5sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3MeY6MAPQKnkOMylFwbPYZiO+919Y7109levfIEGVoKeYdGO1ACtyz3cqstduu4m
	 OzMb1jwoBZvU9gwVTbvIxx7TxFew8Us6OucO1K0wOBTgnGxI3w+SQHqn2KMM1EitxH
	 PvG7devRouLbRghmpjvGQ+aKWZA9ZUwSLrI0il08rF0rfX9VpKco/fedwsAzC7eug+
	 zBJkn7pIwTDI4a8yLpAJtXC2OHoJE9IoKwdPchNZVSXLKWklIjl15g79EPRnKg4Qsp
	 qBiVK3XQG0DcctnBh0S+CURtFc1tdLwCv/EO4pYHG1hsgm5KRC47ZhkOPCNtRG9vuM
	 NHanpOFN4IFdg==
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
Subject: [PATCH v5 01/14] PCI: rockchip-ep: Fix address translation unit programming
Date: Thu, 17 Oct 2024 10:58:36 +0900
Message-ID: <20241017015849.190271-2-dlemoal@kernel.org>
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
same number of lower bits masked from the CPU address space used for the
mapping. For a PCI mapping of <size> bytes starting from <pci_addr>,
the number of bits masked is the number of address bits changing in the
address range [pci_addr..pci_addr + size - 1].

However, rockchip_pcie_prog_ep_ob_atu() calculates num_pass_bits only
using the size of the mapping, resulting in an incorrect number of mask
bits depending on the value of the PCI address to map.

Fix this by introducing the helper function
rockchip_pcie_ep_ob_atu_num_bits() to correctly calculate the number of
mask bits to use to program the address translation unit. The number of
mask bits is calculated depending on both the PCI address and size of
the mapping, and clamped between 8 and 20 using the macros
ROCKCHIP_PCIE_AT_MIN_NUM_BITS and ROCKCHIP_PCIE_AT_MAX_NUM_BITS. As
defined in the Rockchip RK3399 TRM V1.3 Part2, Sections 17.5.5.1.1 and
17.6.8.2.1, this clamping is necessary because:
1) The lower 8 bits of the PCI address to be mapped by the outbound
   region are ignored. So a minimum of 8 address bits are needed and
   imply that the PCI address must be aligned to 256.
2) The outbound memory regions are 1MB in size. So while we can specify
   up to 63-bits for the PCI address (num_bits filed uses bits 0 to 5 of
   the outbound address region 0 register), we must limit the number of
   valid address bits to 20 to match the memory window maximum size (1
   << 20 = 1MB).

Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 15 +++++++++++----
 drivers/pci/controller/pcie-rockchip.h    |  4 ++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 136274533656..27a7febb74e0 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -63,16 +63,23 @@ static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
 			    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(region));
 }
 
+static int rockchip_pcie_ep_ob_atu_num_bits(struct rockchip_pcie *rockchip,
+					    u64 pci_addr, size_t size)
+{
+	int num_pass_bits = fls64(pci_addr ^ (pci_addr + size - 1));
+
+	return clamp(num_pass_bits, ROCKCHIP_PCIE_AT_MIN_NUM_BITS,
+		     ROCKCHIP_PCIE_AT_MAX_NUM_BITS);
+}
+
 static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
 					 u32 r, u64 cpu_addr, u64 pci_addr,
 					 size_t size)
 {
-	int num_pass_bits = fls64(size - 1);
+	int num_pass_bits =
+		rockchip_pcie_ep_ob_atu_num_bits(rockchip, pci_addr, size);
 	u32 addr0, addr1, desc0;
 
-	if (num_pass_bits < 8)
-		num_pass_bits = 8;
-
 	addr0 = ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
 		(lower_32_bits(pci_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
 	addr1 = upper_32_bits(pci_addr);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 6111de35f84c..15ee949f2485 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -245,6 +245,10 @@
 	(PCIE_EP_PF_CONFIG_REGS_BASE + (((fn) << 12) & GENMASK(19, 12)))
 #define ROCKCHIP_PCIE_EP_VIRT_FUNC_BASE(fn) \
 	(PCIE_EP_PF_CONFIG_REGS_BASE + 0x10000 + (((fn) << 12) & GENMASK(19, 12)))
+
+#define ROCKCHIP_PCIE_AT_MIN_NUM_BITS  8
+#define ROCKCHIP_PCIE_AT_MAX_NUM_BITS  20
+
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
 	(PCIE_CORE_AXI_CONF_BASE + 0x0828 + (fn) * 0x0040 + (bar) * 0x0008)
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
-- 
2.47.0


