Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C491FF1B
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfEPFyT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:54:19 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8970 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFyT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:54:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfb100000>; Wed, 15 May 2019 22:54:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:54:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:54:18 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:18 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:54:14 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 18/28] PCI: tegra: Program AFI_CACHE* registers only for Tegra20
Date:   Thu, 16 May 2019 11:22:57 +0530
Message-ID: <20190516055307.25737-19-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986065; bh=3QVe05MA6lZ1ghlmbnbsOKIzF6MJxiclluPA8pel6cE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=U31UVR+TkLMEetKNlpHWg9zJ1MaKM6k5nzm59R67AiPUEZxfqRwtN5SrZFmqHF6VY
         PMbVvJbgh7VAkME9BXCPwhwV/nOzUle8laQ5xX/Tfyl4QF+KXc6wDUnjAn3vmtOnK7
         sqIcU9lmgW/cKfqzyXvOJuOL7Bv1l5Lq59c9WIQuF4VIIrPfPuetpWL1yHQKs/Qdu0
         zGbGvvJMSWYtLvAlLa2UAstdMpqNOzJi0e4ED49vv3+yCmU1usT9hj7ld+dJSOpQm9
         rCFC0eE1Ha1JfYK680ksbIJW5EmXoxQfcxvIetN3cUm5A1MJECWWMmEF5mk1PucgUS
         N0LyM+afWc67g==
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
V4: No change

V3: Initialized has_cache_bars variable for each soc data structure.

V2: Used soc variable for comparision instead of compatible string.

 drivers/pci/controller/pci-tegra.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 4767af9f3b88..0f02f54f8a61 100644
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

