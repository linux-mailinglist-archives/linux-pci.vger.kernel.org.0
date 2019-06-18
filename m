Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438D54A93A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 20:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfFRSDQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 14:03:16 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8855 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbfFRSDQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:03:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0927630000>; Tue, 18 Jun 2019 11:03:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:03:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 11:03:15 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:03:15 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:03:14 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:03:12 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 18/27] PCI: tegra: Program AFI_CACHE* registers only for Tegra20
Date:   Tue, 18 Jun 2019 23:31:57 +0530
Message-ID: <20190618180206.4908-19-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880995; bh=CP14yrsgdW3QsPXOVqTz+V1iii8p0fFSDdByhRx1sz4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=e6DZZY49H9HEpjXahQWPWNkjEJjDctyQ84ZurVEt7xRANe1q9cMGOI1fy84CYOh71
         8hPpIVs2YYutcBJCDNYhp01HHtM+wxzWOGDL1zpyjbOoGCoeaNL/0X712lEQPkWs+w
         t4mrQNmrV55d1Ig4nqroRl9zcc2ZKVz1yapFFxMGHC4LDI7oA4b+LuFuqpQWShPT/M
         kQjUknWyvvnF8fMaxDUXpzFvfk4jpN3IAf0UDWP8PQcu1JPcmL9LLgdHK7Ey4qzB23
         m2PxNmKY1U/VrdVKHJmXQrMINBl0H1Uw4ZBvKQYKI+Maz0T7ocTPgag1XZXkvNH1vK
         NoCqVeg9eiVHg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cacheable upstream transactions are supported in Tegra20 and Tegra186 only.
AFI_CACHE* registers are available in Tegra20 to support cacheable upstream
transactions. In Tegra186, AFI_AXCACHE register is defined instead of
AFI_CACHE* to be in line with its MSS design. Therefore, program AFI_CACHE*
registers only for Tegra20.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V6: No change

V5: No change

V4: No change

V3: Initialized has_cache_bars variable for each soc data structure.

V2: Used soc variable for comparision instead of compatible string.

 drivers/pci/controller/pci-tegra.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 3d9028cecc18..a746d963ca36 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -323,6 +323,7 @@ struct tegra_pcie_soc {
 	bool program_deskew_time;
 	bool raw_violation_fixup;
 	bool update_fc_timer;
+	bool has_cache_bars;
 	struct {
 		struct {
 			u32 rp_ectl_2_r1;
@@ -932,11 +933,13 @@ static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
 	afi_writel(pcie, 0, AFI_AXI_BAR5_SZ);
 	afi_writel(pcie, 0, AFI_FPCI_BAR5);
 
-	/* map all upstream transactions as uncached */
-	afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
-	afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
-	afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
-	afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
+	if (pcie->soc->has_cache_bars) {
+		/* map all upstream transactions as uncached */
+		afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
+		afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
+		afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
+		afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
+	}
 
 	/* MSI translations are setup only when needed */
 	afi_writel(pcie, 0, AFI_MSI_FPCI_BAR_ST);
@@ -2441,6 +2444,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
 	.update_fc_timer = false,
+	.has_cache_bars = true,
 	.ectl.enable = false,
 };
 
@@ -2469,6 +2473,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
 	.update_fc_timer = false,
+	.has_cache_bars = false,
 	.ectl.enable = false,
 };
 
@@ -2492,6 +2497,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.program_deskew_time = false,
 	.raw_violation_fixup = true,
 	.update_fc_timer = false,
+	.has_cache_bars = false,
 	.ectl.enable = false,
 };
 
@@ -2515,6 +2521,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.program_deskew_time = true,
 	.raw_violation_fixup = false,
 	.update_fc_timer = true,
+	.has_cache_bars = false,
 	.ectl = {
 		.regs = {
 			.rp_ectl_2_r1 = 0x0000000f,
@@ -2555,6 +2562,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
 	.update_fc_timer = false,
+	.has_cache_bars = false,
 	.ectl.enable = false,
 };
 
-- 
2.17.1

