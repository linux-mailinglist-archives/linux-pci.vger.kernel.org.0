Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45D42AC4EE
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 20:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgKIT0V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 14:26:21 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3514 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKIT0V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 14:26:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa997e30000>; Mon, 09 Nov 2020 11:26:27 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 19:26:20 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 9 Nov 2020 19:26:16 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH] PCI: dwc: Add support to configure for ECRC
Date:   Tue, 10 Nov 2020 00:56:11 +0530
Message-ID: <20201109192611.16104-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604949987; bh=WrdEdrC4gKX9JmfklZp1MKvc1216Jflc7mWH75n2yME=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=buvevUye8JLgge1U9Qh9jaUQW2eOluEogZuy2UhY11cnrrcQ3/hTa7m6yFbYlVG0x
         TK/5lebcwlzcaiObsJdkPu8zJk/S9Bllaugdo3iNMzycpBz0bEr0dEFyBLRcDUY9Bs
         t3TuIzCqJgI+G9VLOUYmacA7S4nD6MlcuRFjP3wi0toAW+xaNdo00SmgnrztJYS3pm
         0QArYlZR5Bs+qfCdkKhtt9gsWUSQ9Up2uYzYOkgc/8ryaV+MrS/DDElHwgWvy9cdxH
         V4LdvRciSUoiHa2R+ORw4h6oMc/HXP+cyclSeRzRxH5DsZXJxAT1Ntw9GqkLLlYRAS
         RQxna6jhK6N9A==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DesignWare core has a TLP digest (TD) override bit in one of the control
registers of ATU. This bit also needs to be programmed for proper ECRC
functionality. This is currently identified as an issue with DesignWare
IP version 4.90a.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 50 ++++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c2dea8fc97c8..ebdc37a58e94 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -225,6 +225,44 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 	dw_pcie_writel_atu(pci, offset + reg, val);
 }
 
+static inline u32 dw_pcie_enable_ecrc(u32 val)
+{
+	/*
+	 *     DesignWare core version 4.90A has this strange design issue
+	 * where the 'TD' bit in the Control register-1 of the ATU outbound
+	 * region acts like an override for the ECRC setting i.e. the presence
+	 * of TLP Digest(ECRC) in the outgoing TLPs is solely determined by
+	 * this bit. This is contrary to the PCIe spec which says that the
+	 * enablement of the ECRC is solely determined by the AER registers.
+	 *     Because of this, even when the ECRC is enabled through AER
+	 * registers, the transactions going through ATU won't have TLP Digest
+	 * as there is no way the AER sub-system could program the TD bit which
+	 * is specific to DsignWare core.
+	 *    The best way to handle this scenario is to program the TD bit
+	 * always. It affects only the traffic from root port to downstream
+	 * devices.
+	 * At this point,
+	 *     When ECRC is enabled in AER registers, everything works
+	 * normally
+	 *     When ECRC is NOT enabled in AER registers, then,
+	 * on Root Port:- TLP Digest (DWord size) gets appended to each packet
+	 *                even through it is not required. Since downstream
+	 *                TLPs are mostly for configuration accesses and BAR
+	 *                accesses, they are not in critical path and won't
+	 *                have much negative effect on the performance.
+	 * on End Point:- TLP Digest is received for some/all the packets coming
+	 *                from the root port. TLP Digest is ignored because,
+	 *                as per the PCIe Spec r5.0 v1.0 section 2.2.3 "TLP Digest Rules",
+	 *                when an endpoint receives TLP Digest when its
+	 *                ECRC check functionality is disabled in AER registers,
+	 *                received TLP Digest is just ignored.
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
@@ -245,8 +283,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
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
 
@@ -292,8 +332,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
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

