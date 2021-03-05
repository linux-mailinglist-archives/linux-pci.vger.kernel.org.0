Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6363F32E365
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 09:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhCEIJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 03:09:49 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2646 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCEIJs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Mar 2021 03:09:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6041e74c0003>; Fri, 05 Mar 2021 00:09:48 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 5 Mar
 2021 08:09:39 +0000
Received: from manikanta-pc.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Mar 2021 08:09:34 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <amurray@thegoodpenguin.co.uk>, <bhelgaas@google.com>,
        <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <oop.singh@gmail.com>, "Om Prakash Singh" <omp@nvidia.com>
Subject: [PATCH] PCI: tegra: Disable PTM capabilities for EP mode
Date:   Fri, 5 Mar 2021 13:42:34 +0530
Message-ID: <1614931954-11741-1-git-send-email-omp@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614931788; bh=d4EIMKRedldEKkQ/KZr/xWANUlctCCQOqNOtF0VKLJ8=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Type;
        b=M9BzLutSQk9xsvOQG1z1pZPmqn7yPBj4yS22qjEZXH1ZG/noUU8/x6RUQZFmWt59p
         gtWTfKjV15wRwCUyXt9ZwdUwZOyXGwL1fTqRJDpAhsiAGgs80Tw+grevyNfDUGzpv5
         8FyGTigqs+c3zZmCa7Nr2l3aKoAbc8W/R5hDU4E57YgRe0c1hLvWhlS2J6lVzi16FZ
         zy+wkPXwJNMATTD0nwonK2sM7MmafXIK4xJh9gNGLYmFr5i7UwZd3EkWlZwdr2HOIO
         F17zErC3Fz4XRklQJ2x1h/H0OOLfN4ibw0yqVBJqRS07le/5RBhNdEMcsBKJudsQRI
         puZU6vvmtfLXA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe EP compliance expect PTM capabilities (ROOT_CAPABLE, RES_CAPABLE,
CLK_GRAN) to be disabled.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 17 ++++++++++++++++-
 include/uapi/linux/pci_regs.h              |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 6fa216e..a588312 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1639,7 +1639,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	struct dw_pcie *pci = &pcie->pci;
 	struct dw_pcie_ep *ep = &pci->ep;
 	struct device *dev = pcie->dev;
-	u32 val;
+	u32 val, ptm_cap_base = 0;
 	int ret;
 
 	if (pcie->ep_state == EP_STATE_ENABLED)
@@ -1760,6 +1760,21 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 						      PCI_CAP_ID_EXP);
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
 
+	/* Disable PTM root and responder capability */
+	ptm_cap_base = dw_pcie_find_ext_capability(&pcie->pci,
+						   PCI_EXT_CAP_ID_PTM);
+	if (ptm_cap_base) {
+		dw_pcie_dbi_ro_wr_en(pci);
+		val = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
+		val &= ~PCI_PTM_CAP_ROOT;
+		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, val);
+
+		val = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
+		val &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
+		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, val);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+
 	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
 	val |= MSIX_ADDR_MATCH_LOW_OFF_EN;
 	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_LOW_OFF, val);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e709ae8..9dd6f8d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1050,6 +1050,7 @@
 /* Precision Time Measurement */
 #define PCI_PTM_CAP			0x04	    /* PTM Capability */
 #define  PCI_PTM_CAP_REQ		0x00000001  /* Requester capable */
+#define  PCI_PTM_CAP_RES		0x00000002  /* Responder capable */
 #define  PCI_PTM_CAP_ROOT		0x00000004  /* Root capable */
 #define  PCI_PTM_GRANULARITY_MASK	0x0000FF00  /* Clock granularity */
 #define PCI_PTM_CTRL			0x08	    /* PTM Control */
-- 
2.7.4

