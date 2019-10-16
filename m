Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB1CED9B04
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 22:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbfJPUHf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 16:07:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46021 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387601AbfJPUHf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:07:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id o205so90471oib.12;
        Wed, 16 Oct 2019 13:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KRER0q+mlfhxTDAY0c1+VI59pLZZnQ9VLJY13cVFl4Y=;
        b=hq+5MH7BtqAV9JLLGCabkbaS2NnPSk3oiYn1HWtHalWW1WO8DJLFnw1Gsn65f+unhz
         lyTmXT3u3cLCaGYM2FZePsjS6MshfnUJFSfnlKEYtHYKaLPjkQ2fFOl9qb9YesmVu344
         9AWcN24s0gVYQ1WVoFtv764pQVnNL2ubiMHSmCOPXw0ODJCQNdCsDaYUDP+PYT033Xol
         05bsdi51UsnETIJ0+UJipT4jmaIAZfIYovYfa9onqxg5F6jD8h+xNXC6TWvEkGHqz4qE
         N8i9iZ3L8rPGKyrMZH/gapKBV5CJGOa2je7YevXtVokxqsPThC400rsS+hzg+BQuegBT
         38IQ==
X-Gm-Message-State: APjAAAU5geXQNapn6ObF3l2sRZTM/ksoLm7WYB81s1rEe23QnfU+VEMZ
        JToYrZPbAuWdmJlz3DiPQQ==
X-Google-Smtp-Source: APXvYqwB7x7oWBQDKgn1sW1tVYlaQQL0HwcwqR5xSDkvWm67oaAPXyQW0pFAzE6rmaJuDXoA06Prww==
X-Received: by 2002:aca:1719:: with SMTP id j25mr110848oii.132.1571256454419;
        Wed, 16 Oct 2019 13:07:34 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:07:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
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
Subject: [PATCH v2 24/25] PCI: rcar: Use inbound resources for setup
Date:   Wed, 16 Oct 2019 15:06:46 -0500
Message-Id: <20191016200647.32050-25-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the helpers provide the inbound resources in the host bridge
'dma_ranges' resource list, convert Renesas R-Car PCIe host bridge to
use the resource list to setup the inbound addresses.

Cc: Simon Horman <horms@verge.net.au>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-rcar.c | 45 +++++++++++-------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index b8d6e86a5539..453c931aaf77 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1014,16 +1014,16 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
 }
 
 static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
-				    struct of_pci_range *range,
+				    struct resource_entry *entry,
 				    int *index)
 {
-	u64 restype = range->flags;
-	u64 cpu_addr = range->cpu_addr;
-	u64 cpu_end = range->cpu_addr + range->size;
-	u64 pci_addr = range->pci_addr;
+	u64 restype = entry->res->flags;
+	u64 cpu_addr = entry->res->start;
+	u64 cpu_end = entry->res->end;
+	u64 pci_addr = entry->res->start - entry->offset;
 	u32 flags = LAM_64BIT | LAR_ENABLE;
 	u64 mask;
-	u64 size;
+	u64 size = resource_size(entry->res);
 	int idx = *index;
 
 	if (restype & IORESOURCE_PREFETCH)
@@ -1037,9 +1037,7 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 		unsigned long nr_zeros = __ffs64(cpu_addr);
 		u64 alignment = 1ULL << nr_zeros;
 
-		size = min(range->size, alignment);
-	} else {
-		size = range->size;
+		size = min(size, alignment);
 	}
 	/* Hardware supports max 4GiB inbound region */
 	size = min(size, 1ULL << 32);
@@ -1078,30 +1076,19 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 	return 0;
 }
 
-static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
-					  struct device_node *np)
+static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie)
 {
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
-	int index = 0;
-	int err;
-
-	if (of_pci_dma_range_parser_init(&parser, np))
-		return -EINVAL;
-
-	/* Get the dma-ranges from DT */
-	for_each_of_pci_range(&parser, &range) {
-		u64 end = range.cpu_addr + range.size - 1;
-
-		dev_dbg(pcie->dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
-			range.flags, range.cpu_addr, end, range.pci_addr);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	struct resource_entry *entry;
+	int index = 0, err = 0;
 
-		err = rcar_pcie_inbound_ranges(pcie, &range, &index);
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
+		err = rcar_pcie_inbound_ranges(pcie, entry, &index);
 		if (err)
-			return err;
+			break;
 	}
 
-	return 0;
+	return err;
 }
 
 static const struct of_device_id rcar_pcie_of_match[] = {
@@ -1162,7 +1149,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		goto err_unmap_msi_irqs;
 	}
 
-	err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
+	err = rcar_pcie_parse_map_dma_ranges(pcie);
 	if (err)
 		goto err_clk_disable;
 
-- 
2.20.1

