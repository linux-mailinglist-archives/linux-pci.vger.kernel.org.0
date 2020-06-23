Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C34D20497D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 08:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgFWGFc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 02:05:32 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:55850 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbgFWGFc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jun 2020 02:05:32 -0400
Received: from T480.siklu.local (unknown [212.29.212.82])
        by mx.tkos.co.il (Postfix) with ESMTPA id 634A244059D;
        Tue, 23 Jun 2020 09:05:30 +0300 (IDT)
From:   Shmuel Hazan <sh@tkos.co.il>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Shmuel Hazan <sh@tkos.co.il>
Subject: [PATCH v3] PCI: mvebu: Setup BAR0 in order to fix MSI
Date:   Tue, 23 Jun 2020 09:03:35 +0300
Message-Id: <20200623060334.108444-1-sh@tkos.co.il>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to the Armada XP datasheet, section 10.2.6: "in order for
the device to do a write to the MSI doorbell address, it needs to write
to a register in the internal registers space".

As a result of the requirement above, without this patch, MSI won't
function and therefore some devices won't operate properly without
pci=nomsi.

This requirement was not present at the time of writing this driver
since the vendor u-boot always initializes all PCIe controllers
(incl. BAR0 initialization) and for some time, the vendor u-boot was
the only available bootloader for this driver's SoCs (e.g. A38x,A37x,
etc).

Tested on an Armada 385 board on mainline u-boot (2020.4), without
u-boot PCI initialization and the following PCIe devices:
        - Wilocity Wil6200 rev 2 (wil6210)
        - Qualcomm Atheros QCA6174 (ath10k_pci)

Both failed to get a response from the device after loading the
firmware and seem to operate properly with this patch.

Signed-off-by: Shmuel Hazan <sh@tkos.co.il>

---

Changes in v3:
	* Added sign-off. 

---
 drivers/pci/controller/pci-mvebu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 153a64676bc9..101c06602aa1 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -105,6 +105,7 @@ struct mvebu_pcie_port {
 	struct mvebu_pcie_window memwin;
 	struct mvebu_pcie_window iowin;
 	u32 saved_pcie_stat;
+	struct resource regs;
 };
 
 static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
@@ -149,7 +150,9 @@ static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
 
 /*
  * Setup PCIE BARs and Address Decode Wins:
- * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
+ * BAR[0] -> internal registers (needed for MSI)
+ * BAR[1] -> covers all DRAM banks
+ * BAR[2] -> Disabled
  * WIN[0-3] -> DRAM bank[0-3]
  */
 static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
@@ -203,6 +206,12 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(1));
 	mvebu_writel(port, ((size - 1) & 0xffff0000) | 1,
 		     PCIE_BAR_CTRL_OFF(1));
+
+	/*
+	 * Point BAR[0] to the device's internal registers.
+	 */
+	mvebu_writel(port, round_down(port->regs.start, SZ_1M), PCIE_BAR_LO_OFF(0));
+	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(0));
 }
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
@@ -708,14 +717,13 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
 					      struct device_node *np,
 					      struct mvebu_pcie_port *port)
 {
-	struct resource regs;
 	int ret = 0;
 
-	ret = of_address_to_resource(np, 0, &regs);
+	ret = of_address_to_resource(np, 0, &port->regs);
 	if (ret)
 		return (void __iomem *)ERR_PTR(ret);
 
-	return devm_ioremap_resource(&pdev->dev, &regs);
+	return devm_ioremap_resource(&pdev->dev, &port->regs);
 }
 
 #define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
-- 
2.27.0

