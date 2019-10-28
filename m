Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF600E764D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390963AbfJ1Qdb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43711 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1Qdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id b19so4818710otq.10;
        Mon, 28 Oct 2019 09:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYotT8vplUpPAxDBkQ4PaMlGqTylW6sNvKndwgHpCIU=;
        b=OHrOy/A11V6ZOaf4fadHDh57LDaKgD1clilROMrWOPe70OeMgFPqTryvWyDt8upMnL
         5WZSSsvxzLclhHJtdqygenZ3WynSGFkFKMQHGif90kxsI1ICzRqIGFocFLmbojZUUmcN
         0CHWd4CHn/Wwq2lAkLVR/gEU6UOPuf8Vcne3bUGPLRt7A0PwwRi6IHN+0801vkEY48/l
         esd+Ww2gNDin7YzMuW0cdKwtZ3Ou01G8TMZCawCHfGt+2Wg5NEDhDQlaaH+ReR2w2Qz6
         aWBjcJJPouEKbr8J9DTjs4Zloi4kvIT0fprhCzvCS2DLN9FrZZkFS+LL5GFX6jGTnLBe
         49XA==
X-Gm-Message-State: APjAAAW3glbnCEbHtwK7jkhxocN4XIIe0FdXU60xk1dGwLaiQXvQMjEz
        LJwg2iVgBI91qaCB7egnjJNZsuA=
X-Google-Smtp-Source: APXvYqy+uBASJDG3rPdo2O4wCkiHo4NzLsXE1unvcdols14xzwz4puZsL1iBoWYniAt7v02TGXZGNw==
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr8986935otg.98.1572280408846;
        Mon, 28 Oct 2019 09:33:28 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Christoph Hellwig <hch@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v3 11/25] PCI: rockchip: Drop storing driver private outbound resource data
Date:   Mon, 28 Oct 2019 11:32:42 -0500
Message-Id: <20191028163256.8004-12-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Rockchip host bridge driver doesn't need to store outboard resources
in its private struct as they are already stored in struct
pci_host_bridge.

Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 54 +++++++++------------
 drivers/pci/controller/pcie-rockchip.h      |  5 --
 2 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 8d2e6f2e141e..f375e55ea02e 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -806,19 +806,28 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
 static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rockchip);
+	struct resource_entry *entry;
+	u64 pci_addr, size;
 	int offset;
 	int err;
 	int reg_no;
 
 	rockchip_pcie_cfg_configuration_accesses(rockchip,
 						 AXI_WRAPPER_TYPE0_CFG);
+	entry = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
+	if (!entry)
+		return -ENODEV;
+
+	size = resource_size(entry->res);
+	pci_addr = entry->res->start - entry->offset;
+	rockchip->msg_bus_addr = pci_addr;
 
-	for (reg_no = 0; reg_no < (rockchip->mem_size >> 20); reg_no++) {
+	for (reg_no = 0; reg_no < (size >> 20); reg_no++) {
 		err = rockchip_pcie_prog_ob_atu(rockchip, reg_no + 1,
 						AXI_WRAPPER_MEM_WRITE,
 						20 - 1,
-						rockchip->mem_bus_addr +
-						(reg_no << 20),
+						pci_addr + (reg_no << 20),
 						0);
 		if (err) {
 			dev_err(dev, "program RC mem outbound ATU failed\n");
@@ -832,14 +841,20 @@ static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
-	offset = rockchip->mem_size >> 20;
-	for (reg_no = 0; reg_no < (rockchip->io_size >> 20); reg_no++) {
+	entry = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
+	if (!entry)
+		return -ENODEV;
+
+	size = resource_size(entry->res);
+	pci_addr = entry->res->start - entry->offset;
+
+	offset = size >> 20;
+	for (reg_no = 0; reg_no < (size >> 20); reg_no++) {
 		err = rockchip_pcie_prog_ob_atu(rockchip,
 						reg_no + 1 + offset,
 						AXI_WRAPPER_IO_WRITE,
 						20 - 1,
-						rockchip->io_bus_addr +
-						(reg_no << 20),
+						pci_addr + (reg_no << 20),
 						0);
 		if (err) {
 			dev_err(dev, "program RC io outbound ATU failed\n");
@@ -852,8 +867,7 @@ static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
 				  AXI_WRAPPER_NOR_MSG,
 				  20 - 1, 0, 0);
 
-	rockchip->msg_bus_addr = rockchip->mem_bus_addr +
-					((reg_no + offset) << 20);
+	rockchip->msg_bus_addr += ((reg_no + offset) << 20);
 	return err;
 }
 
@@ -951,7 +965,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
 	struct resource *bus_res;
-	struct resource_entry *win;
 	int err;
 
 	if (!dev->of_node)
@@ -997,27 +1010,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	rockchip->root_bus_nr = bus_res->start;
 
-	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry(win, &bridge->windows) {
-		switch (resource_type(win->res)) {
-		case IORESOURCE_IO:
-			io = win->res;
-			io->name = "I/O";
-			rockchip->io_size = resource_size(io);
-			rockchip->io_bus_addr = io->start - win->offset;
-			rockchip->io = io;
-			break;
-		case IORESOURCE_MEM:
-			mem = win->res;
-			mem->name = "MEM";
-			rockchip->mem_size = resource_size(mem);
-			rockchip->mem_bus_addr = mem->start - win->offset;
-			break;
-		default:
-			continue;
-		}
-	}
-
 	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
 		goto err_remove_irq_domain;
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 8e87a059ce73..bef42a803b56 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -304,13 +304,8 @@ struct rockchip_pcie {
 	struct	irq_domain *irq_domain;
 	int     offset;
 	struct pci_bus *root_bus;
-	struct resource *io;
-	phys_addr_t io_bus_addr;
-	u32     io_size;
 	void    __iomem *msg_region;
-	u32     mem_size;
 	phys_addr_t msg_bus_addr;
-	phys_addr_t mem_bus_addr;
 	bool is_rc;
 	struct resource *mem_res;
 };
-- 
2.20.1

