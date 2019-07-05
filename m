Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C307603E6
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 12:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfGEKH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 06:07:58 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33384 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbfGEKHs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 06:07:48 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6ECB91A0EAE;
        Fri,  5 Jul 2019 12:07:46 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E57361A077B;
        Fri,  5 Jul 2019 12:07:37 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E3FE2402E5;
        Fri,  5 Jul 2019 18:07:27 +0800 (SGT)
From:   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        l.subrahmanya@mobiveil.co.in, shawnguo@kernel.org,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv6 27/28] PCI: mobiveil: Fix infinite-loop in the INTx process
Date:   Fri,  5 Jul 2019 17:56:55 +0800
Message-Id: <20190705095656.19191-28-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
References: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the loop block, there is not code to update the loop key,
this patch updates the loop key by re-read the INTx status
register.

Note: Need MV to test this fix.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Acked-by: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Tested-by: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
---
V6:
 - Splited from #10 of v5 patches, no functional change.

 drivers/pci/controller/pcie-mobiveil.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index f35d14b..a5549cf 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -359,8 +359,9 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 
 	/* Handle INTx */
 	if (intr_status & PAB_INTP_INTX_MASK) {
-		shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT) >>
-					   PAB_INTX_START;
+		shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
+		shifted_status &= PAB_INTP_INTX_MASK;
+		shifted_status >>= PAB_INTX_START;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
 				virq = irq_find_mapping(pcie->intx_domain,
@@ -376,7 +377,12 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 					   shifted_status << PAB_INTX_START,
 					   PAB_INTP_AMBA_MISC_STAT);
 			}
-		} while ((shifted_status >> PAB_INTX_START) != 0);
+
+			shifted_status = csr_readl(pcie,
+						   PAB_INTP_AMBA_MISC_STAT);
+			shifted_status &= PAB_INTP_INTX_MASK;
+			shifted_status >>= PAB_INTX_START;
+		} while (shifted_status != 0);
 	}
 
 	/* read extra MSI status register */
-- 
1.7.1

