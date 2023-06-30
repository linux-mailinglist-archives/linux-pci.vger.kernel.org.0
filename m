Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E0A743F2E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjF3Pta (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 11:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjF3Pta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 11:49:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ECF3A9E
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688140168; x=1719676168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1oCatm2lA3eWUDmZs5GjcKbFyyVaBn4C2DspCHTW8Sc=;
  b=XPV7VOzYd2Q7YqUfQYOwZod1g9JIVh3SyS6F6JWWtk0XZeAOS1A+9lRQ
   U6j7DUsnRIMVadhb9Q+Fl+a3lNUJTUUHUpGbgtRUh7IS1uqgUyHhlkGD3
   Zw/mp+ZGzMKDwsYWZvO52NgEYEMy2f4HXIG1Pklr8NdW2icy0fSqKnTwx
   G9Gn/6ti/ypMmGhaE98WMCZbgM7CYnBZLYeEO/KEUi8AvXHaUc50dVRiV
   aEjy4PMqejogfuO8kYGj5/ElooSTeR80MobZRrqP3GS5L9jOIZP8u8e1M
   tjKTpKOJOFTZqTKkqzthYcG0ERUWK15Y4yofepXqPPbXUTfmRIekQpwb3
   w==;
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="233133675"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2023 08:49:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 30 Jun 2023 08:49:19 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 30 Jun 2023 08:49:17 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 7/8] PCI: microchip: Rename and refactor mc_pcie_enable_msi()
Date:   Fri, 30 Jun 2023 16:48:58 +0100
Message-ID: <20230630154859.2049521-8-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630154859.2049521-1-daire.mcnamara@microchip.com>
References: <20230630154859.2049521-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

After improving driver to get MSI-related information from
configuration registers (set at power on from the Libero FPGA
design), its now clear that mc_pcie_enable_msi() is not a good
name for this function.  The function is better named as
mc_pcie_fixup_ecam() as its purpose is to correct the queue
size of the MSI CAP CTRL.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 28 +++++++++++---------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 20ce21438a7e..5bb467de9cc5 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -383,25 +383,29 @@ static struct {
 
 static char poss_clks[][5] = { "fic0", "fic1", "fic2", "fic3" };
 
-static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *base)
+static void mc_pcie_fixup_ecam(struct mc_pcie *port, void __iomem *ecam)
 {
 	struct mc_msi *msi = &port->msi;
-	u32 cap_offset = MC_MSI_CAP_CTRL_OFFSET;
-	u16 msg_ctrl = readw_relaxed(base + cap_offset + PCI_MSI_FLAGS);
+	u16 reg;
 	u8 queue_size;
 
-	msg_ctrl |= PCI_MSI_FLAGS_ENABLE;
+	/* Fixup MSI enable flag */
+	reg = readw_relaxed(ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_FLAGS);
+	reg |= PCI_MSI_FLAGS_ENABLE;
+	writew_relaxed(reg, ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_FLAGS);
+
 	/* Fixup PCI MSI queue flags */
-	queue_size = msg_ctrl & PCI_MSI_FLAGS_QMASK;
+	queue_size = reg & PCI_MSI_FLAGS_QMASK;
 	queue_size >>= 1;
-	msg_ctrl &= ~PCI_MSI_FLAGS_QSIZE;
-	msg_ctrl |= queue_size << 4;
-	writew_relaxed(msg_ctrl, base + cap_offset + PCI_MSI_FLAGS);
+	reg &= ~PCI_MSI_FLAGS_QSIZE;
+	reg |= queue_size << 4;
+	writew_relaxed(reg, ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_FLAGS);
 
+	/* Fixup MSI addr fields */
 	writel_relaxed(lower_32_bits(msi->vector_phy),
-		       base + cap_offset + PCI_MSI_ADDRESS_LO);
+		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_LO);
 	writel_relaxed(upper_32_bits(msi->vector_phy),
-		       base + cap_offset + PCI_MSI_ADDRESS_HI);
+		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_HI);
 }
 
 static void mc_handle_msi(struct irq_desc *desc)
@@ -1137,8 +1141,8 @@ static int mc_platform_init(struct pci_config_window *cfg)
 
 	port->msi.num_vectors = 1 << val;
 
-	/* Hardware doesn't setup MSI by default */
-	mc_pcie_enable_msi(port, cfg->win);
+	/* Need some fixups for MSI in config space */
+	mc_pcie_fixup_ecam(port, cfg->win);
 
 	/* Pick vector address from design */
 	port->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
-- 
2.25.1

