Return-Path: <linux-pci+bounces-5382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E31D8891570
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2221C22521
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F95937165;
	Fri, 29 Mar 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkSsPVdv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03D37714
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703400; cv=none; b=OVDzvZ7bOrHmv+uBzdoZ/unz1A9ir+W8DaZ6W0P65cacGWOzpz34MZaNX3+x8dX46foQa/YfFY/FH+gianFKv33OjVPde6LzAb6kK/aDzTjnJcMvLv7WfLzuJy0taCiQjFBCrpJ4+AOiRY9a+7gb9U/Et1bupTjA/fqTM/CRm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703400; c=relaxed/simple;
	bh=IVFEcbwtCPMVBa8uS2gEdsaKW6gPvOwDrAV6RcR7FCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWMDryKxZ8Fl/n15flQcyPPpbUTgeNKQqlWWmf8DFcSN/UaS3wkDsFVltty7zjOxB4R9EFVAm+wrmhzQRUr31b9V4AxHPePxu9A+y0pHaMkO6x00HY+9XQ6YVE796PPGfv6i5ZUVNFWC0ptArPgHSN0gHw2eUYam1oeitgxM0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkSsPVdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132F1C433F1;
	Fri, 29 Mar 2024 09:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703400;
	bh=IVFEcbwtCPMVBa8uS2gEdsaKW6gPvOwDrAV6RcR7FCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkSsPVdv3AY2jAzqMzwzDMqXtA//ygbgzaL0EAbnQJ7F53gMaBwdtlwVbuD2hpKkW
	 SIa6WSlg4pk1QIRxU506Vwh7PCUQXsip1nygsq6rTss0UFqnGadTXVSRr3cSB4UMmt
	 MPF5IfwXOYGqCJhLbWxPMP/3mAMgh5JzUISqnrY+u1T/RHoW+BouWHRlis80BqYTiG
	 dN3QsanOExFiHviPfH/l9cXrNma/8+tdOVUAYVDi5X8FWu2f+2ZDzQaYnUBAbrIA1Y
	 aapZEdLM5WEgEBYeE3d24uKoUmOJNiUSvIRnk+eplslUkIZkW8c/B+vtR7UwVtmmiO
	 ORJIZWD3610/g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 08/19] PCI: rockchip-ep: Fix address translation unit programming
Date: Fri, 29 Mar 2024 18:09:34 +0900
Message-ID: <20240329090945.1097609-9-dlemoal@kernel.org>
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
mask bits iscalculated depending on both the PCI address and size of the
mapping, and clamped between 8 and 20 using the macros
ROCKCHIP_PCIE_AT_MIN_NUM_BITS and ROCKCHIP_PCIE_AT_MAX_NUM_BITS.

Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 15 +++++++++++----
 drivers/pci/controller/pcie-rockchip.h    |  4 ++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index c9046e97a1d2..786efd918b3f 100644
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
2.44.0


