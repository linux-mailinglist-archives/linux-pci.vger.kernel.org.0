Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984B92AF053
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 13:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgKKMNd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 07:13:33 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5805 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgKKMMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 07:12:33 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fabd5090000>; Wed, 11 Nov 2020 04:11:53 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Nov
 2020 12:11:53 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Nov 2020 12:11:49 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2] PCI: dwc: Add support to configure for ECRC
Date:   Wed, 11 Nov 2020 17:41:45 +0530
Message-ID: <20201111121145.7015-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109192611.16104-1-vidyas@nvidia.com>
References: <20201109192611.16104-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605096713; bh=3PVEtDLordAcntknKXFr6xJm6HXQLS+d+52npBfKPDM=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=eQcWhd+4KvPSn576Ax7dBDW9FsdRJtr+UYcZ5sjs/tzuTc04czC4OSg+0ZYPNICnH
         fQ1Mgcas814zfjbNyXNYNQlREMngDQO5TxpMORx4QhuiHa/wUe/rAgGYmCe9ThCXB/
         9aPHvkp8ZlHyg+FO9z8yTRZUNMV+RwfIHkdGYL39GOSZrW+b43zmeNG09pTBLHuKro
         fhnR6E+ZouluqRd5pXl1JXqUNmJmyqqV2XTgOpetWBwulX/KQNhi36IEW7P2tnY1Ru
         xsLKXT+kCzOTgLQhW5RET7ugixHad+byL3/yxj3deTMeqOXRLOa5ThqaibQgTSCMPu
         k0WXmAqz8Pvhg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DesignWare core has a TLP digest (TD) override bit in one of the control
registers of ATU. This bit also needs to be programmed for proper ECRC
functionality. This is currently identified as an issue with DesignWare
IP version 4.90a.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
V2:
* Addressed Bjorn's comments

 drivers/pci/controller/dwc/pcie-designware.c | 52 ++++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c2dea8fc97c8..ec0d13ab6bad 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -225,6 +225,46 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 	dw_pcie_writel_atu(pci, offset + reg, val);
 }
 
+static inline u32 dw_pcie_enable_ecrc(u32 val)
+{
+	/*
+	 * DesignWare core version 4.90A has this strange design issue
+	 * where the 'TD' bit in the Control register-1 of the ATU outbound
+	 * region acts like an override for the ECRC setting i.e. the presence
+	 * of TLP Digest(ECRC) in the outgoing TLPs is solely determined by
+	 * this bit. This is contrary to the PCIe spec which says that the
+	 * enablement of the ECRC is solely determined by the AER registers.
+	 *
+	 * Because of this, even when the ECRC is enabled through AER
+	 * registers, the transactions going through ATU won't have TLP Digest
+	 * as there is no way the AER sub-system could program the TD bit which
+	 * is specific to DesignWare core.
+	 *
+	 * The best way to handle this scenario is to program the TD bit
+	 * always. It affects only the traffic from root port to downstream
+	 * devices.
+	 *
+	 * At this point,
+	 * When ECRC is enabled in AER registers, everything works normally
+	 * When ECRC is NOT enabled in AER registers, then,
+	 * on Root Port:- TLP Digest (DWord size) gets appended to each packet
+	 *                even through it is not required. Since downstream
+	 *                TLPs are mostly for configuration accesses and BAR
+	 *                accesses, they are not in critical path and won't
+	 *                have much negative effect on the performance.
+	 * on End Point:- TLP Digest is received for some/all the packets coming
+	 *                from the root port. TLP Digest is ignored because,
+	 *                as per the PCIe Spec r5.0 v1.0 section 2.2.3
+	 *                "TLP Digest Rules", when an endpoint receives TLP
+	 *                Digest when its ECRC check functionality is disabled
+	 *                in AER registers, received TLP Digest is just ignored.
+	 * Since there is no issue or error reported either side, best way to
+	 * handle the scenario is to program TD bit by default.
+	 */
+
+	return val | PCIE_ATU_TD;
+}
+
 static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 					     int index, int type,
 					     u64 cpu_addr, u64 pci_addr,
@@ -245,8 +285,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 				 lower_32_bits(pci_addr));
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
 				 upper_32_bits(pci_addr));
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
-				 type | PCIE_ATU_FUNC_NUM(func_no));
+	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	if (pci->version == 0x490A)
+		val = dw_pcie_enable_ecrc(val);
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
 				 PCIE_ATU_ENABLE);
 
@@ -292,8 +334,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 			   lower_32_bits(pci_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
 			   upper_32_bits(pci_addr));
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
-			   PCIE_ATU_FUNC_NUM(func_no));
+	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	if (pci->version == 0x490A)
+		val = dw_pcie_enable_ecrc(val);
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9d2f511f13fa..285c0ae364ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -88,6 +88,7 @@
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
 #define PCIE_ATU_TYPE_CFG1		0x5
+#define PCIE_ATU_TD			BIT(8)
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_CR2			0x908
 #define PCIE_ATU_ENABLE			BIT(31)
-- 
2.17.1

