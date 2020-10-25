Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306932980AB
	for <lists+linux-pci@lfdr.de>; Sun, 25 Oct 2020 08:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767812AbgJYHbg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Oct 2020 03:31:36 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4358 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1767811AbgJYHbg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Oct 2020 03:31:36 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9529c20001>; Sun, 25 Oct 2020 00:31:14 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 25 Oct
 2020 07:31:32 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Sun, 25 Oct 2020 07:31:29 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 2/2] PCI: dwc: Add support to configure for ECRC
Date:   Sun, 25 Oct 2020 13:01:13 +0530
Message-ID: <20201025073113.31291-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201025073113.31291-1-vidyas@nvidia.com>
References: <20201025073113.31291-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603611074; bh=O036KGB+W4I8DOqlF/uWVYjS/H3GA3LI6UfIhNnJWYs=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=RY9bQ0GpGMzooH0UoiZTlY54yuC0kGsQACVcUWlEPsbKVH6+/viaVs9F3gfjSiEZo
         UR7AnxS5eVa+65iEym6fLR5dzEFnw0+zr3JclmaGEz5TB75xoE5545bAJ3oSEc3WRV
         dK+iQ68JaPPVLBK9IJmSYmE7feptqoVDstY0z/hODZy9vyi5YvY+qjvjHuTI7xWM0p
         9AQQBJAeKkSCosE7eBv88D9xe+vXrb20nbtKpgUaN8E3PRJxQJyA4wYoibzBijAFM7
         1A67hO71TyrKP+2eZSg4ihejuDrtLfww9WKNk4OLVcbhCjNkW82GFnZ5CFNpRwU58P
         X5PJmJIyWfPTg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DesignWare core has a TLP digest (TD) override bit in one of the control
registers of ATU. This bit also needs to be programmed for proper ECRC
functionality. This is currently identified as an issue with DesignWare
IP version 4.90a. This patch does the required programming in ATU upon
querying the system policy for ECRC.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index b5e438b70cd5..810dcbdbe869 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -245,7 +245,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 				 lower_32_bits(pci_addr));
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
 				 upper_32_bits(pci_addr));
-	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	val = type | PCIE_ATU_FUNC_NUM(func_no) | pci->td << PCIE_ATU_TD_SHIFT;
 	val = upper_32_bits(size - 1) ?
 		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
@@ -295,7 +295,8 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
 			   upper_32_bits(pci_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
-			   PCIE_ATU_FUNC_NUM(func_no));
+			   PCIE_ATU_FUNC_NUM(func_no) |
+			   pci->td << PCIE_ATU_TD_SHIFT);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
 
 	/*
@@ -565,6 +566,9 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
 		"enabled" : "disabled");
 
+	if (pci->version == 0x490A)
+		pci->td = pcie_is_ecrc_enabled();
+
 	if (pci->link_gen > 0)
 		dw_pcie_link_set_max_speed(pci, pci->link_gen);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 21dd06831b50..d34723e42e79 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -90,6 +90,7 @@
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
 #define PCIE_ATU_TYPE_CFG1		0x5
+#define PCIE_ATU_TD_SHIFT		8
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_CR2			0x908
 #define PCIE_ATU_ENABLE			BIT(31)
@@ -276,6 +277,7 @@ struct dw_pcie {
 	int			num_lanes;
 	int			link_gen;
 	u8			n_fts[2];
+	bool			td;	/* TLP Digest (for ECRC purpose) */
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.17.1

