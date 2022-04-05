Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A224F419E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 23:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiDEMoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 08:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381994AbiDEMAS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 08:00:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099093BFBD
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649157507; x=1680693507;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cEEPsMWRHOEMrXyWAhOg965q8qtp7y7IkVxjJ5SnLeI=;
  b=IT4FWw0EKawJz8X8ALMcXF7TZIhu+e+P281vP0NsrnxW8eRhGu9KTsNr
   Govz0/EDjWaTxfL+gWejjrwcSD/C5s1U8YPS9hf/CA5q9+dmWictb2be2
   2QwS+0kImJzESXoSHgdsHCRAUwJzQt4eg4jKKIN67eXHYaVtPOZgQJhGH
   9/xhxZuhGuRHpIVhyJA74MHo4AyNS0jE6rjiehSWBuv9ZGbq1UVUOonjF
   IE76524k8HjN1TlEl0ILFwJDDASqpOjsH3trzXFrP2YmViAeDiHsB5ZXP
   Iwqjfjc8sA1LL+CIq9Th/frZfqhlvLTYt8EqHYt/phaA+vHyaI/l3rrJ1
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,236,1643698800"; 
   d="scan'208";a="154420982"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2022 04:18:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Apr 2022 04:18:01 -0700
Received: from daire-X570.school.villiers.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 5 Apr 2022 04:17:59 -0700
From:   <daire.mcnamara@microchip.com>
To:     <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <conor.dooley@microchip.com>,
        <cyril.jean@microchip.com>, <maz@kernel.org>,
        <daire.mcnamara@microchip.com>, <david.abdurachmanov@gmail.com>,
        <linux-pci@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>
Subject: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in interrupt handling
Date:   Tue, 5 Apr 2022 12:17:51 +0100
Message-ID: <20220405111751.166427-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Clear MSI bit in ISTATUS register after reading it before
handling individual MSI bits

This fixes a potential race condition pointed out by Bjorn Helgaas:
https://lore.kernel.org/linux-pci/20220127202000.GA126335@bhelgaas/

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
Adding linux-pci mailing list
 drivers/pci/controller/pcie-microchip-host.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 29d8e81e4181..da8e3fdc97b3 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -416,6 +416,7 @@ static void mc_handle_msi(struct irq_desc *desc)
 
 	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
 	if (status & PM_MSI_INT_MSI_MASK) {
+		writel_relaxed(status & PM_MSI_INT_MSI_MASK, bridge_base_addr + ISTATUS_LOCAL);
 		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
 		for_each_set_bit(bit, &status, msi->num_vectors) {
 			ret = generic_handle_domain_irq(msi->dev_domain, bit);
@@ -432,13 +433,8 @@ static void mc_msi_bottom_irq_ack(struct irq_data *data)
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	u32 bitpos = data->hwirq;
-	unsigned long status;
 
 	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
-	status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
-	if (!status)
-		writel_relaxed(BIT(PM_MSI_INT_MSI_SHIFT),
-			       bridge_base_addr + ISTATUS_LOCAL);
 }
 
 static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
-- 
2.25.1

