Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359BA2481FA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 11:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgHRJfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 05:35:11 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33990 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHRJfK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 05:35:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D58391A019F;
        Tue, 18 Aug 2020 11:35:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F2241A1994;
        Tue, 18 Aug 2020 11:35:05 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 07553402AD;
        Tue, 18 Aug 2020 11:34:59 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        amurray@thegoodpenguin.co.uk, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2] PCI: designware-ep: Fix the Header Type check
Date:   Tue, 18 Aug 2020 17:27:46 +0800
Message-Id: <20200818092746.24366-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current check will result in the multiple function device
fails to initialize. So fix the check by masking out the
multiple function bit.

Fixes: 0b24134f7888 ("PCI: dwc: Add validation that PCIe core is set to correct mode")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Add marco PCI_HEADER_TYPE_MASK and print the masked value.

 drivers/pci/controller/dwc/pcie-designware-ep.c | 3 ++-
 include/uapi/linux/pci_regs.h                   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 4680a51c49c0..0634bd3a0b96 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -653,7 +653,8 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	u32 reg;
 	int i;
 
-	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
+	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
+		   PCI_HEADER_TYPE_MASK;
 	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
 		dev_err(pci->dev,
 			"PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f9701410d3b5..57a222014cd2 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -76,6 +76,7 @@
 #define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
 #define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
 #define PCI_HEADER_TYPE		0x0e	/* 8 bits */
+#define  PCI_HEADER_TYPE_MASK		0x7f
 #define  PCI_HEADER_TYPE_NORMAL		0
 #define  PCI_HEADER_TYPE_BRIDGE		1
 #define  PCI_HEADER_TYPE_CARDBUS	2
-- 
2.17.1

