Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69FA4D7174
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 10:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfJOIsP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 04:48:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38194 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbfJOIsM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 04:48:12 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E791820045E;
        Tue, 15 Oct 2019 10:48:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 171A1200449;
        Tue, 15 Oct 2019 10:48:04 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7436C4030B;
        Tue, 15 Oct 2019 16:47:55 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Zhiqiang.Hou@nxp.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, Minghuan.Lian@nxp.com,
        andrew.murray@arm.com, mingkai.hu@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH v2 4/6] PCI: mobiveil: Add workaround for unsupported request error
Date:   Tue, 15 Oct 2019 16:37:00 +0800
Message-Id: <20191015083702.21792-5-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191015083702.21792-1-xiaowei.bao@nxp.com>
References: <20191015083702.21792-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Errata: unsupported request error on inbound posted write
transaction, PCIe controller reports advisory error instead
of uncorrectable error message to RC.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v3: 
 - Use BIT replce the expression.

 drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c | 13 +++++++++++++
 drivers/pci/controller/mobiveil/pcie-mobiveil.h           |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
index 56603ea..82bb38d 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
@@ -49,6 +49,19 @@ static void ls_pcie_g4_ep_init(struct mobiveil_pcie_ep *ep)
 	struct mobiveil_pcie *mv_pci = to_mobiveil_pcie_from_ep(ep);
 	int win_idx;
 	u8 bar;
+	u32 val;
+
+	/*
+	 * Errata: unsupported request error on inbound posted write
+	 * transaction, PCIe controller reports advisory error instead
+	 * of uncorrectable error message to RC.
+	 * workaround: set the bit20(unsupported_request_Error_severity) with
+	 * value 1 in uncorrectable_Error_Severity_Register, make the
+	 * unsupported request error generate the fatal error.
+	 */
+	val =  csr_readl(mv_pci, CFG_UNCORRECTABLE_ERROR_SEVERITY);
+	val |= BIT(UNSUPPORTED_REQUEST_ERROR_SHIFT);
+	csr_writel(mv_pci, val, CFG_UNCORRECTABLE_ERROR_SEVERITY);
 
 	ep->bar_num = PCIE_LX2_BAR_NUM;
 
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 7308fa4..a40707e 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -123,6 +123,10 @@
 #define GPEX_BAR_SIZE_UDW		0x4DC
 #define GPEX_BAR_SELECT			0x4E0
 
+#define CFG_UNCORRECTABLE_ERROR_SEVERITY	0x10c
+#define UNSUPPORTED_REQUEST_ERROR_SHIFT		20
+#define CFG_UNCORRECTABLE_ERROR_MASK		0x108
+
 /* starting offset of INTX bits in status register */
 #define PAB_INTX_START			5
 
-- 
2.9.5

