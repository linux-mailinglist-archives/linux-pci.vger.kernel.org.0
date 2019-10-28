Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB367E7653
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391016AbfJ1Qdf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41902 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1Qdf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id 94so7158346oty.8;
        Mon, 28 Oct 2019 09:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CisDLS5VrA+U+bZNmYu5E2eTsV9z7wFBG7PuQ0y9mkk=;
        b=rDqZ9iSP8Pw74IhX51q/bDopZbFBlnL9NPwbP12FJGfVnqU6BOQUPWx34YSttkfPNH
         7q/W54RbsHUBb+Rz4rWFk7Hbz0F9ugrGe/EDPtmukl42Sn16XXjNew9zqO1ijW6rd6d7
         6Xok5YpKVrtTVIipdjBGubwbafSUR41pQ0V7oJyLBUGDdxpGL877Fh6sVh2pfxErUzJr
         R2FikklGw/ZVMVJG9iC0+zziCuZBSKzYDbK0G9NuSMi8STm/Pel/DbgrIxw9RECuJZ3m
         YKy1Xc71QEn5EsxY0M2stU7u2IC42Rv7UjzEnS8YmrjhqjwN/Vd/0wa50rmJD1B8naTD
         jDoQ==
X-Gm-Message-State: APjAAAWppNx8J6i4PMEPFIaRV0I8B5cE1Fm3gUktTFgQmskUmfZVC8Sg
        YsTioAoke4KNjReCh9LTVA==
X-Google-Smtp-Source: APXvYqwper22ZlXJg5DpAImWRJ7XDe4KFfYVSvi7Voqzg2ZZ1EXILmDbsGSK9WJ1OuRTtjJ3T24mQQ==
X-Received: by 2002:a9d:6c57:: with SMTP id g23mr463092otq.149.1572280413138;
        Mon, 28 Oct 2019 09:33:33 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:32 -0700 (PDT)
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
Subject: [PATCH v3 13/25] PCI: xgene: Use pci_parse_request_of_pci_ranges()
Date:   Mon, 28 Oct 2019 11:32:44 -0500
Message-Id: <20191028163256.8004-14-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the xgene host bridge to use the common
pci_parse_request_of_pci_ranges().

There's no need to assign the resources to a temporary list first. Just
use bridge->windows directly and remove all the temporary list handling.

Cc: Toan Le <toan@os.amperecomputing.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-xgene.c | 39 +++++++++---------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index ffda3e8b4742..7d0f0395a479 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -405,15 +405,13 @@ static void xgene_pcie_setup_cfg_reg(struct xgene_pcie_port *port)
 	xgene_pcie_writel(port, CFGCTL, EN_REG);
 }
 
-static int xgene_pcie_map_ranges(struct xgene_pcie_port *port,
-				 struct list_head *res,
-				 resource_size_t io_base)
+static int xgene_pcie_map_ranges(struct xgene_pcie_port *port)
 {
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
 	struct resource_entry *window;
 	struct device *dev = port->dev;
-	int ret;
 
-	resource_list_for_each_entry(window, res) {
+	resource_list_for_each_entry(window, &bridge->windows) {
 		struct resource *res = window->res;
 		u64 restype = resource_type(res);
 
@@ -421,11 +419,9 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port,
 
 		switch (restype) {
 		case IORESOURCE_IO:
-			xgene_pcie_setup_ob_reg(port, res, OMR3BARL, io_base,
+			xgene_pcie_setup_ob_reg(port, res, OMR3BARL,
+						pci_pio_to_address(res->start),
 						res->start - window->offset);
-			ret = devm_pci_remap_iospace(dev, res, io_base);
-			if (ret < 0)
-				return ret;
 			break;
 		case IORESOURCE_MEM:
 			if (res->flags & IORESOURCE_PREFETCH)
@@ -567,8 +563,7 @@ static void xgene_pcie_clear_config(struct xgene_pcie_port *port)
 		xgene_pcie_writel(port, i, 0);
 }
 
-static int xgene_pcie_setup(struct xgene_pcie_port *port, struct list_head *res,
-			    resource_size_t io_base)
+static int xgene_pcie_setup(struct xgene_pcie_port *port)
 {
 	struct device *dev = port->dev;
 	u32 val, lanes = 0, speed = 0;
@@ -580,7 +575,7 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port, struct list_head *res,
 	val = (XGENE_PCIE_DEVICEID << 16) | XGENE_PCIE_VENDORID;
 	xgene_pcie_writel(port, BRIDGE_CFG_0, val);
 
-	ret = xgene_pcie_map_ranges(port, res, io_base);
+	ret = xgene_pcie_map_ranges(port);
 	if (ret)
 		return ret;
 
@@ -607,11 +602,9 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node;
 	struct xgene_pcie_port *port;
-	resource_size_t iobase = 0;
 	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
 	int ret;
-	LIST_HEAD(res);
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
 	if (!bridge)
@@ -634,20 +627,14 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
-						    &iobase);
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
 	if (ret)
 		return ret;
 
-	ret = devm_request_pci_bus_resources(dev, &res);
-	if (ret)
-		goto error;
-
-	ret = xgene_pcie_setup(port, &res, iobase);
+	ret = xgene_pcie_setup(port);
 	if (ret)
-		goto error;
+		return ret;
 
-	list_splice_init(&res, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = port;
 	bridge->busnr = 0;
@@ -657,7 +644,7 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret < 0)
-		goto error;
+		return ret;
 
 	bus = bridge->bus;
 
@@ -666,10 +653,6 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 		pcie_bus_configure_settings(child);
 	pci_bus_add_devices(bus);
 	return 0;
-
-error:
-	pci_free_resource_list(&res);
-	return ret;
 }
 
 static const struct of_device_id xgene_pcie_match_table[] = {
-- 
2.20.1

