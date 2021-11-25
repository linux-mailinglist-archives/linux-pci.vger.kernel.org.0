Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E0745DA57
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352763AbhKYMv7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:51:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353380AbhKYMvo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:51:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8B0761130;
        Thu, 25 Nov 2021 12:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844395;
        bh=kIxbqqnl03bqhcc87mZU1EX4mGZmPj5F3GGmUg4gbBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OOSLIddDQzrES0ip0gB2f3eHw28HqIopb6ULFkYl07tSmyuCZX22Z7kEMCMFlckyw
         /sO4M8wnpL9eszVep/luKUCWo9U+s7ixygTmGPMNhbi0o2pCcQ1H4NnHFWyB743eYH
         k4JMrVWVIRFu+bblJzQSY+qRlUSBW7dhXk3IroRz6t/5qZNLGocsYQvQs+Fe/dsMq+
         SgSTvaP2O9x/N9ssMijCY98ATo02yqDhYkXnruNlGhf/wz50IRvLp2/+xRjoRYcpOi
         PxZCizDaQmLHdOswi4PLKNuTGKNF7tZrDwBLUpNKjqSvdY/WM3eKoT7qf03nNhwJwO
         ThdbnAJMlmm7A==
Received: by pali.im (Postfix)
        id 0D591F3C; Thu, 25 Nov 2021 13:46:32 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] PCI: mvebu: Check for errors from pci_bridge_emul_init() call
Date:   Thu, 25 Nov 2021 13:45:52 +0100
Message-Id: <20211125124605.25915-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Function pci_bridge_emul_init() may fail so correctly check for errors.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 1f08673eef12 ("PCI: mvebu: Convert to PCI emulated bridge config space")
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index d655c887ba1b..6197f7e7c317 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -581,7 +581,7 @@ static struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
  * Initialize the configuration space of the PCI-to-PCI bridge
  * associated with the given PCIe interface.
  */
-static void mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
+static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 {
 	struct pci_bridge_emul *bridge = &port->bridge;
 	u32 pcie_cap = mvebu_readl(port, PCIE_CAP_PCIEXP);
@@ -608,7 +608,7 @@ static void mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	bridge->data = port;
 	bridge->ops = &mvebu_pci_bridge_emul_ops;
 
-	pci_bridge_emul_init(bridge, PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR);
+	return pci_bridge_emul_init(bridge, PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR);
 }
 
 static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
@@ -1094,9 +1094,18 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		ret = mvebu_pci_bridge_emul_init(port);
+		if (ret < 0) {
+			dev_err(dev, "%s: cannot init emulated bridge\n",
+				port->name);
+			devm_iounmap(dev, port->base);
+			port->base = NULL;
+			mvebu_pcie_powerdown(port);
+			continue;
+		}
+
 		mvebu_pcie_setup_hw(port);
 		mvebu_pcie_set_local_dev_nr(port, 1);
-		mvebu_pci_bridge_emul_init(port);
 	}
 
 	bridge->sysdata = pcie;
-- 
2.20.1

