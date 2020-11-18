Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCA12B7FBE
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 15:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKROqt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 09:46:49 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5362 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgKROqt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 09:46:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb533cf0002>; Wed, 18 Nov 2020 06:46:39 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 14:46:44 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Nov 2020 14:46:40 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 2/2] PCI: dwc: Add support to program ATU for >4GB memory
Date:   Wed, 18 Nov 2020 20:16:26 +0530
Message-ID: <20201118144626.32189-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201118144626.32189-1-vidyas@nvidia.com>
References: <20201118144626.32189-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605710799; bh=rSXbDpuOWjEQHv80DVTDi8A2/+Bh99CifSSN70Mfna0=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=nDxYDjgrFA1hcURPPXLub8CuYRupvgLeBNMRCkO9ytYtTIALOPt+ABIvye3wjksUR
         o+78P/H/bEzCNADn2njBJlVf7LfJhllA8/yUIkDReDjGUbwq5M5ubT5FGCQ8UUvF/i
         WKum8ab3g4Nb8hJGrNAdr6p4Xsy64QRlgrsk8gQPoXx+fqRX/tkpNzAglc7XO9VpMI
         AQJfCf0hsqD8GzhmNuXsPZZVSrrAXzJtSvdCpk9uFFpVnpceGZ0lkJpTaS8hGFA63G
         QNnBFmhRkVXekBA3JYc0ZuW/qD+kX4E0KG1d1a9qI6t1FMeqEea8j+duZOZOKKRY5r
         NuFTtH3r96kMw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to program the ATU to enable translations for >4GB sizes of
the prefetchable memory apertures.

Tested-by: Thierry Reding <treding@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Jingoo <jingoohan1@gmail.com>
---
V2:
* Added 'Tested-by', 'Reviewed-by' and 'Acked-by'

 drivers/pci/controller/dwc/pcie-designware.c | 12 +++++++-----
 drivers/pci/controller/dwc/pcie-designware.h |  3 ++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c2dea8fc97c8..b5e438b70cd5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -228,7 +228,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 					     int index, int type,
 					     u64 cpu_addr, u64 pci_addr,
-					     u32 size)
+					     u64 size)
 {
 	u32 retries, val;
 	u64 limit_addr = cpu_addr + size - 1;
@@ -245,8 +245,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 				 lower_32_bits(pci_addr));
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
 				 upper_32_bits(pci_addr));
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
-				 type | PCIE_ATU_FUNC_NUM(func_no));
+	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	val = upper_32_bits(size - 1) ?
+		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
 				 PCIE_ATU_ENABLE);
 
@@ -267,7 +269,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 
 static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 					int index, int type, u64 cpu_addr,
-					u64 pci_addr, u32 size)
+					u64 pci_addr, u64 size)
 {
 	u32 retries, val;
 
@@ -311,7 +313,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 }
 
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			       u64 cpu_addr, u64 pci_addr, u32 size)
+			       u64 cpu_addr, u64 pci_addr, u64 size)
 {
 	__dw_pcie_prog_outbound_atu(pci, 0, index, type,
 				    cpu_addr, pci_addr, size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ed19c34dd0fe..f9a20ce9ab9a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -81,6 +81,7 @@
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
 #define PCIE_ATU_CR1			0x904
+#define PCIE_ATU_INCREASE_REGION_SIZE	BIT(13)
 #define PCIE_ATU_TYPE_MEM		0x0
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
@@ -293,7 +294,7 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 			       int type, u64 cpu_addr, u64 pci_addr,
-			       u32 size);
+			       u64 size);
 void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				  int type, u64 cpu_addr, u64 pci_addr,
 				  u32 size);
-- 
2.17.1

