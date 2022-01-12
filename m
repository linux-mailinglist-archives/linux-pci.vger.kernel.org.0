Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1EE48C703
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 16:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354542AbiALPSx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 10:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354499AbiALPSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 10:18:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2236AC061759;
        Wed, 12 Jan 2022 07:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE7EBB81F6A;
        Wed, 12 Jan 2022 15:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3398DC36AE5;
        Wed, 12 Jan 2022 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642000721;
        bh=ruv44ME+jSLkAUMCwvE3mepyvhnL6RdH9qeyYV3y9FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=op+PTECE8qrukvx8iwvFSMneKKSei8sug8FQ7dejYGmEerqgNNcs5DEFPZOT1LhWB
         6FmezBaa2SS/hDyOtimiffD+9W5Mn0dDzhWmW8jP+x0dSS3vblzXCTKDdJSyyPyljU
         MWMnK2KTf5imoZP7uvfQN5UMs/gTxaWE6O8o7uWa2naJZcN/jhA2xGGbr/PBd41iEF
         o+v4fo05yDwOEWwiCLfVDuqoF9r5sfUsQItKRjKRTKZc4bMc3jmdsDOkLVRh4fyvs1
         u27dEKFWiLropa82jE0rmF2v5q26gBtJ3DeMF2A/lm/DYRz8cqfotVr0InlOIOQSYJ
         +a6aKSjbMcwfw==
Received: by pali.im (Postfix)
        id DFE8B768; Wed, 12 Jan 2022 16:18:40 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/11] PCI: mvebu: Use child_ops API
Date:   Wed, 12 Jan 2022 16:18:11 +0100
Message-Id: <20220112151814.24361-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220112151814.24361-1-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Split struct pci_ops between ops and child_ops. Member ops is used for
accessing PCIe Root Ports via pci-bridge-emul.c driver and child_ops for
accessing real PCIe cards.

There is no need to mix these two struct pci_ops into one as PCI core code
already provides separate callbacks via bridge->ops and bridge->child_ops.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 82 ++++++++++++++++--------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 9ea2f6a7c2b0..1e90ab888075 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -294,11 +294,29 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	mvebu_writel(port, mask, PCIE_MASK_OFF);
 }
 
-static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
-				 struct pci_bus *bus,
-				 u32 devfn, int where, int size, u32 *val)
+static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
+						    struct pci_bus *bus,
+						    int devfn);
+
+static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, int where,
+				    int size, u32 *val)
 {
-	void __iomem *conf_data = port->base + PCIE_CONF_DATA_OFF;
+	struct mvebu_pcie *pcie = bus->sysdata;
+	struct mvebu_pcie_port *port;
+	void __iomem *conf_data;
+
+	port = mvebu_pcie_find_port(pcie, bus, devfn);
+	if (!port) {
+		*val = 0xffffffff;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	if (!mvebu_pcie_link_up(port)) {
+		*val = 0xffffffff;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	conf_data = port->base + PCIE_CONF_DATA_OFF;
 
 	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
 		     PCIE_CONF_ADDR_OFF);
@@ -321,11 +339,21 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
-				 struct pci_bus *bus,
-				 u32 devfn, int where, int size, u32 val)
+static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
+				    int where, int size, u32 val)
 {
-	void __iomem *conf_data = port->base + PCIE_CONF_DATA_OFF;
+	struct mvebu_pcie *pcie = bus->sysdata;
+	struct mvebu_pcie_port *port;
+	void __iomem *conf_data;
+
+	port = mvebu_pcie_find_port(pcie, bus, devfn);
+	if (!port)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (!mvebu_pcie_link_up(port))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	conf_data = port->base + PCIE_CONF_DATA_OFF;
 
 	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
 		     PCIE_CONF_ADDR_OFF);
@@ -347,6 +375,11 @@ static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static struct pci_ops mvebu_pcie_child_ops = {
+	.read = mvebu_pcie_child_rd_conf,
+	.write = mvebu_pcie_child_wr_conf,
+};
+
 /*
  * Remove windows, starting from the largest ones to the smallest
  * ones.
@@ -862,25 +895,12 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 {
 	struct mvebu_pcie *pcie = bus->sysdata;
 	struct mvebu_pcie_port *port;
-	int ret;
 
 	port = mvebu_pcie_find_port(pcie, bus, devfn);
 	if (!port)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	/* Access the emulated PCI-to-PCI bridge */
-	if (bus->number == 0)
-		return pci_bridge_emul_conf_write(&port->bridge, where,
-						  size, val);
-
-	if (!mvebu_pcie_link_up(port))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	/* Access the real PCIe interface */
-	ret = mvebu_pcie_hw_wr_conf(port, bus, devfn,
-				    where, size, val);
-
-	return ret;
+	return pci_bridge_emul_conf_write(&port->bridge, where, size, val);
 }
 
 /* PCI configuration space read function */
@@ -889,7 +909,6 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 {
 	struct mvebu_pcie *pcie = bus->sysdata;
 	struct mvebu_pcie_port *port;
-	int ret;
 
 	port = mvebu_pcie_find_port(pcie, bus, devfn);
 	if (!port) {
@@ -897,21 +916,7 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	/* Access the emulated PCI-to-PCI bridge */
-	if (bus->number == 0)
-		return pci_bridge_emul_conf_read(&port->bridge, where,
-						 size, val);
-
-	if (!mvebu_pcie_link_up(port)) {
-		*val = 0xffffffff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
-	/* Access the real PCIe interface */
-	ret = mvebu_pcie_hw_rd_conf(port, bus, devfn,
-				    where, size, val);
-
-	return ret;
+	return pci_bridge_emul_conf_read(&port->bridge, where, size, val);
 }
 
 static struct pci_ops mvebu_pcie_ops = {
@@ -1421,6 +1426,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 	bridge->sysdata = pcie;
 	bridge->ops = &mvebu_pcie_ops;
+	bridge->child_ops = &mvebu_pcie_child_ops;
 	bridge->align_resource = mvebu_pcie_align_resource;
 	bridge->map_irq = mvebu_pcie_map_irq;
 
-- 
2.20.1

