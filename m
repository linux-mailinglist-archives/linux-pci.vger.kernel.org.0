Return-Path: <linux-pci+bounces-12634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B76968EF4
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 22:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B951C22098
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 20:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF1D176FD2;
	Mon,  2 Sep 2024 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr8+R4LK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536211A4E7E;
	Mon,  2 Sep 2024 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310501; cv=none; b=Q460ZNIAMFkEDSFyrF9m3poOXGpbAC+lpZ4lvl2YgdoA1tPwG+EUpwnIun/JYj+hoUYMeFKuzdoPaFlVWQGsZ/F7LUxiCPTB9jfU/c94iHfwJH3Uj3huQ5ZIo4CcRGlZFzvvqAZJuFHsEa3RLXLI8DgrS4/uAwenRyvOxkgV2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310501; c=relaxed/simple;
	bh=FGHKapTIenGnlnPA+DpU84gT8/KM2p7zRNiALDGngyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O/INEbblKXpQNSVDqintQpBCax39ETMkFFgnPubPjBUuMcdLH8xwUv6ZZXSG61HhRrLi9faGSGa4JxWqZ9o5ocUt/wR+XYZcIgj+J3powdwDUnbgmxdanwAY7gpQhvAyY7Vm+L4mZMqX0P8krxOX+WnT1lGKtyj6ha4M1xiPFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr8+R4LK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F25EC4CEC2;
	Mon,  2 Sep 2024 20:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725310500;
	bh=FGHKapTIenGnlnPA+DpU84gT8/KM2p7zRNiALDGngyg=;
	h=From:To:Cc:Subject:Date:From;
	b=Dr8+R4LKpqGgyCr1SSh67dRIa0Fb+bjfWOH+/9sddxZHvuBFF4lRWPqNxnJ/tnoJv
	 QpYwgZBCOiL0pj3Le88zL2ksCs+r52qZaIUS7EFfsqNqGFYXqH5lJQf9uxX44py5Dp
	 fcYorokBO6obVlvflvTF1WWiw/lguXBpeOS0J3vqufxIEWDaUdPQHZovyQN+XNXSMS
	 X4lLPOCu86K758f/v6IQCAKCEYkJ+EdbC3A8shKnDQM9SsHOZ2yRCxrXaTQZS/7kRq
	 Xup5K3CCIw18OvS9qtZfAqSMzURx3rg5MlinNZHYRqyjCYsBQ2sxdpKTRlGr2foxk6
	 Kd79vJwLMKY1Q==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	jim2101024@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: brcmstb: Sort enums, pcie_offsets[], pcie_cfg_data, .compatible strings
Date: Mon,  2 Sep 2024 15:54:56 -0500
Message-Id: <20240902205456.227409-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Sort enum pcie_soc_base values.

Rename pcie_offsets_bmips_7425[] to pcie_offsets_bcm7425[] to match BCM7425
pcie_soc_base enum, bcm7425_cfg, and "brcm,bcm7425-pcie" .compatible
string.

Rename pcie_offset_bcm7278[] to pcie_offsets_bcm7278[] to match other
"pcie_offsets" names.

Rename pcie_offset_bcm7712[] to pcie_offsets_bcm7712[] to match other
"pcie_offsets" names.

Sort pcie_offsets_*[] by SoC name, move them all together, indent values
for easy reading.

Sort pcie_cfg_data structs by SoC name.

Sort .compatible strings by SoC name.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
This is based on Jim's v6 series at
https://lore.kernel.org/r/20240815225731.40276-1-james.quinlan@broadcom.com
as applied at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ae791a877e7

 drivers/pci/controller/pcie-brcmstb.c | 114 +++++++++++++-------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 21e692a57882..07b415fa04ea 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -220,11 +220,11 @@ enum {
 
 enum pcie_soc_base {
 	GENERIC,
-	BCM7425,
-	BCM7435,
+	BCM2711,
 	BCM4908,
 	BCM7278,
-	BCM2711,
+	BCM7425,
+	BCM7435,
 	BCM7712,
 };
 
@@ -1663,26 +1663,34 @@ static void brcm_pcie_remove(struct platform_device *pdev)
 }
 
 static const int pcie_offsets[] = {
-	[RGR1_SW_INIT_1] = 0x9210,
-	[EXT_CFG_INDEX]  = 0x9000,
-	[EXT_CFG_DATA]   = 0x9004,
-	[PCIE_HARD_DEBUG] = 0x4204,
-	[PCIE_INTR2_CPU_BASE] = 0x4300,
+	[RGR1_SW_INIT_1]	= 0x9210,
+	[EXT_CFG_INDEX]		= 0x9000,
+	[EXT_CFG_DATA]		= 0x9004,
+	[PCIE_HARD_DEBUG]	= 0x4204,
+	[PCIE_INTR2_CPU_BASE]	= 0x4300,
 };
 
-static const int pcie_offsets_bmips_7425[] = {
-	[RGR1_SW_INIT_1] = 0x8010,
-	[EXT_CFG_INDEX]  = 0x8300,
-	[EXT_CFG_DATA]   = 0x8304,
-	[PCIE_HARD_DEBUG] = 0x4204,
-	[PCIE_INTR2_CPU_BASE] = 0x4300,
+static const int pcie_offsets_bcm7278[] = {
+	[RGR1_SW_INIT_1]	= 0xc010,
+	[EXT_CFG_INDEX]		= 0x9000,
+	[EXT_CFG_DATA]		= 0x9004,
+	[PCIE_HARD_DEBUG]	= 0x4204,
+	[PCIE_INTR2_CPU_BASE]	= 0x4300,
 };
 
-static const int pcie_offset_bcm7712[] = {
-	[EXT_CFG_INDEX]  = 0x9000,
-	[EXT_CFG_DATA]   = 0x9004,
-	[PCIE_HARD_DEBUG] = 0x4304,
-	[PCIE_INTR2_CPU_BASE] = 0x4400,
+static const int pcie_offsets_bcm7425[] = {
+	[RGR1_SW_INIT_1]	= 0x8010,
+	[EXT_CFG_INDEX]		= 0x8300,
+	[EXT_CFG_DATA]		= 0x8304,
+	[PCIE_HARD_DEBUG]	= 0x4204,
+	[PCIE_INTR2_CPU_BASE]	= 0x4300,
+};
+
+static const int pcie_offsets_bcm7712[] = {
+	[EXT_CFG_INDEX]		= 0x9000,
+	[EXT_CFG_DATA]		= 0x9004,
+	[PCIE_HARD_DEBUG]	= 0x4304,
+	[PCIE_INTR2_CPU_BASE]	= 0x4400,
 };
 
 static const struct pcie_cfg_data generic_cfg = {
@@ -1693,8 +1701,32 @@ static const struct pcie_cfg_data generic_cfg = {
 	.num_inbound_wins = 3,
 };
 
+static const struct pcie_cfg_data bcm2711_cfg = {
+	.offsets	= pcie_offsets,
+	.soc_base	= BCM2711,
+	.perst_set	= brcm_pcie_perst_set_generic,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound_wins = 3,
+};
+
+static const struct pcie_cfg_data bcm4908_cfg = {
+	.offsets	= pcie_offsets,
+	.soc_base	= BCM4908,
+	.perst_set	= brcm_pcie_perst_set_4908,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound_wins = 3,
+};
+
+static const struct pcie_cfg_data bcm7278_cfg = {
+	.offsets	= pcie_offsets_bcm7278,
+	.soc_base	= BCM7278,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+	.num_inbound_wins = 3,
+};
+
 static const struct pcie_cfg_data bcm7425_cfg = {
-	.offsets	= pcie_offsets_bmips_7425,
+	.offsets	= pcie_offsets_bcm7425,
 	.soc_base	= BCM7425,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
@@ -1709,40 +1741,8 @@ static const struct pcie_cfg_data bcm7435_cfg = {
 	.num_inbound_wins = 3,
 };
 
-static const struct pcie_cfg_data bcm4908_cfg = {
-	.offsets	= pcie_offsets,
-	.soc_base	= BCM4908,
-	.perst_set	= brcm_pcie_perst_set_4908,
-	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
-	.num_inbound_wins = 3,
-};
-
-static const int pcie_offset_bcm7278[] = {
-	[RGR1_SW_INIT_1] = 0xc010,
-	[EXT_CFG_INDEX] = 0x9000,
-	[EXT_CFG_DATA] = 0x9004,
-	[PCIE_HARD_DEBUG] = 0x4204,
-	[PCIE_INTR2_CPU_BASE] = 0x4300,
-};
-
-static const struct pcie_cfg_data bcm7278_cfg = {
-	.offsets	= pcie_offset_bcm7278,
-	.soc_base	= BCM7278,
-	.perst_set	= brcm_pcie_perst_set_7278,
-	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
-	.num_inbound_wins = 3,
-};
-
-static const struct pcie_cfg_data bcm2711_cfg = {
-	.offsets	= pcie_offsets,
-	.soc_base	= BCM2711,
-	.perst_set	= brcm_pcie_perst_set_generic,
-	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
-	.num_inbound_wins = 3,
-};
-
 static const struct pcie_cfg_data bcm7216_cfg = {
-	.offsets	= pcie_offset_bcm7278,
+	.offsets	= pcie_offsets_bcm7278,
 	.soc_base	= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
@@ -1751,7 +1751,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 };
 
 static const struct pcie_cfg_data bcm7712_cfg = {
-	.offsets	= pcie_offset_bcm7712,
+	.offsets	= pcie_offsets_bcm7712,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.soc_base	= BCM7712,
@@ -1762,11 +1762,11 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
-	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
 	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
-	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
-	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
+	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
 	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
+	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
+	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7712-pcie", .data = &bcm7712_cfg },
 	{},
 };
-- 
2.34.1


