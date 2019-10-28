Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2B3E7646
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbfJ1QdR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43694 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1QdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id b19so4818117otq.10;
        Mon, 28 Oct 2019 09:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nW63jMBvuV1jC5LkGgClq/3WYdWidZxNV+2Nh/Z21ew=;
        b=f6XhQb2bSUfm18KtdF56KNSGD+GSK3K1d917LJxutPKxPEdy//xh1lrlFdjw5vlqoa
         6Nf5qxaG/q8fZFHTGaoEjSjTReI+MK/TD0nWDmmnjxlKSN5FxYrALrNjhuwMJg2KG2hG
         bEelCgHDfiNn5OO6+13gl8GanxG2KhIZ9yde9+AhNRZDsFoxCX8dNvuiiOtTdHDU0qbE
         QDlM9tltmudzpG04uWqwgqOINZqXdgWyVuVUzjAgfayw+2yFFCYRB6rESthPKuxjjfIr
         vmVqxNYr8bwR5T/uJBUKh5ORQhWyKIM4mzPe5s3YLBtKedllgJDewO7H2qHSPZtpN/sE
         lzqg==
X-Gm-Message-State: APjAAAXgC33ew7oTd9qQCJglazvYM7yoOJPXxqlgLcmoCwMi3KgYB1/D
        LU2a9GQ2RwpmhJpQP/+05g==
X-Google-Smtp-Source: APXvYqxhr3QGGC8pHRguZ0KGcav4CFccx7LcyeEsqrM8IAog45S1MROIl6X64sUTv9Rs+FE/3FigSg==
X-Received: by 2002:a05:6830:1695:: with SMTP id k21mr11501497otr.339.1572280396672;
        Mon, 28 Oct 2019 09:33:16 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:16 -0700 (PDT)
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
Subject: [PATCH v3 08/25] PCI: mediatek: Use pci_parse_request_of_pci_ranges()
Date:   Mon, 28 Oct 2019 11:32:39 -0500
Message-Id: <20191028163256.8004-9-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert Mediatek host bridge to use the common
pci_parse_request_of_pci_ranges().

Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Use resource_list_get_entry_of_type
---
 drivers/pci/controller/pcie-mediatek.c | 43 ++++++++------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 626a7c352dfd..d9206a3cd56b 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -216,7 +216,6 @@ struct mtk_pcie {
 	void __iomem *base;
 	struct clk *free_ck;
 
-	struct resource mem;
 	struct list_head ports;
 	const struct mtk_pcie_soc *soc;
 	unsigned int busnr;
@@ -661,11 +660,19 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
-	struct resource *mem = &pcie->mem;
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct resource *mem = NULL;
+	struct resource_entry *entry;
 	const struct mtk_pcie_soc *soc = port->pcie->soc;
 	u32 val;
 	int err;
 
+	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
+	if (entry)
+		mem = entry->res;
+	if (!mem)
+		return -EINVAL;
+
 	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
 	if (pcie->base) {
 		val = readl(pcie->base + PCIE_SYS_CFG_V2);
@@ -1023,39 +1030,15 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 	struct mtk_pcie_port *port, *tmp;
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 	struct list_head *windows = &host->windows;
-	struct resource_entry *win, *tmp_win;
-	resource_size_t io_base;
+	struct resource *bus;
 	int err;
 
-	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    windows, &io_base);
+	err = pci_parse_request_of_pci_ranges(dev, windows,
+					      &bus);
 	if (err)
 		return err;
 
-	err = devm_request_pci_bus_resources(dev, windows);
-	if (err < 0)
-		return err;
-
-	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry_safe(win, tmp_win, windows) {
-		switch (resource_type(win->res)) {
-		case IORESOURCE_IO:
-			err = devm_pci_remap_iospace(dev, win->res, io_base);
-			if (err) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
-					 err, win->res);
-				resource_list_destroy_entry(win);
-			}
-			break;
-		case IORESOURCE_MEM:
-			memcpy(&pcie->mem, win->res, sizeof(*win->res));
-			pcie->mem.name = "non-prefetchable";
-			break;
-		case IORESOURCE_BUS:
-			pcie->busnr = win->res->start;
-			break;
-		}
-	}
+	pcie->busnr = bus->start;
 
 	for_each_available_child_of_node(node, child) {
 		int slot;
-- 
2.20.1

