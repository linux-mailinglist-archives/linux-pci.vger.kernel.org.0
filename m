Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7DE7668
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391048AbfJ1Qdx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35288 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbfJ1Qdw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id n16so4147886oig.2;
        Mon, 28 Oct 2019 09:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dn1tmxzjQTI9PAUk6uuXXt7CY5FAAIGihQa/Sw5ORA=;
        b=NvOrcvkHb23eV6h7ZdyRHJY9m7HsvPsutQrd16x0v8kdDpZ4GLC1qVpFcerB4A8fVy
         BOwtiLL0Gxn3Nj9OTsEhnTBJ9XNIgl0qqbfEKsNeDHIgx4bIX8aFO8G7W7w0Wsr5NIq4
         4p510nk6YD7OGqEu+kFKLaGkzghG3dcotRGLx8RnWqS5UkMfVPxupdBUXlcbtKjttXJ5
         arLuOEh8hMS5TBHBuxhwRW3WHo3hvzSqsluCdVuUqk+9fBTYS0n7Lyc7El9nqAaB7jmb
         TUhAPumtA6z7HnGXQQfIrDgCeIam875YP2TG1R1Y2+YWIwzZleUzVFK1o1b+0tS4zEcl
         YdFw==
X-Gm-Message-State: APjAAAX886yglyuuVr14zi8qV2p26LAFc3LiOCavPE6MhOcoWn5wZ76u
        jsJGCx6ClkAiXSPtFAS04g==
X-Google-Smtp-Source: APXvYqy2aOv/BWjh/fOFyROYXfZgl0g1EuXwphc9ldC9o3rRodxdVklAkX2S/p8TYhXvkJEGpP50Kg==
X-Received: by 2002:aca:fdc3:: with SMTP id b186mr156065oii.92.1572280431823;
        Mon, 28 Oct 2019 09:33:51 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:51 -0700 (PDT)
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
Subject: [PATCH v3 21/25] PCI: v3-semi: Use inbound resources for setup
Date:   Mon, 28 Oct 2019 11:32:52 -0500
Message-Id: <20191028163256.8004-22-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the helpers provide the inbound resources in the host bridge
'dma_ranges' resource list, convert the v3-semi host bridge to use
the resource list to setup the inbound addresses.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-v3-semi.c | 38 ++++++++++++----------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 2209c7671115..bd05221f5a22 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -598,28 +598,30 @@ static int v3_pci_setup_resource(struct v3_pci *v3,
 }
 
 static int v3_get_dma_range_config(struct v3_pci *v3,
-				   struct of_pci_range *range,
+				   struct resource_entry *entry,
 				   u32 *pci_base, u32 *pci_map)
 {
 	struct device *dev = v3->dev;
-	u64 cpu_end = range->cpu_addr + range->size - 1;
-	u64 pci_end = range->pci_addr + range->size - 1;
+	u64 cpu_addr = entry->res->start;
+	u64 cpu_end = entry->res->end;
+	u64 pci_end = cpu_end - entry->offset;
+	u64 pci_addr = entry->res->start - entry->offset;
 	u32 val;
 
-	if (range->pci_addr & ~V3_PCI_BASE_M_ADR_BASE) {
+	if (pci_addr & ~V3_PCI_BASE_M_ADR_BASE) {
 		dev_err(dev, "illegal range, only PCI bits 31..20 allowed\n");
 		return -EINVAL;
 	}
-	val = ((u32)range->pci_addr) & V3_PCI_BASE_M_ADR_BASE;
+	val = ((u32)pci_addr) & V3_PCI_BASE_M_ADR_BASE;
 	*pci_base = val;
 
-	if (range->cpu_addr & ~V3_PCI_MAP_M_MAP_ADR) {
+	if (cpu_addr & ~V3_PCI_MAP_M_MAP_ADR) {
 		dev_err(dev, "illegal range, only CPU bits 31..20 allowed\n");
 		return -EINVAL;
 	}
-	val = ((u32)range->cpu_addr) & V3_PCI_MAP_M_MAP_ADR;
+	val = ((u32)cpu_addr) & V3_PCI_MAP_M_MAP_ADR;
 
-	switch (range->size) {
+	switch (resource_size(entry->res)) {
 	case SZ_1M:
 		val |= V3_LB_BASE_ADR_SIZE_1MB;
 		break;
@@ -667,8 +669,8 @@ static int v3_get_dma_range_config(struct v3_pci *v3,
 	dev_dbg(dev,
 		"DMA MEM CPU: 0x%016llx -> 0x%016llx => "
 		"PCI: 0x%016llx -> 0x%016llx base %08x map %08x\n",
-		range->cpu_addr, cpu_end,
-		range->pci_addr, pci_end,
+		cpu_addr, cpu_end,
+		pci_addr, pci_end,
 		*pci_base, *pci_map);
 
 	return 0;
@@ -677,24 +679,16 @@ static int v3_get_dma_range_config(struct v3_pci *v3,
 static int v3_pci_parse_map_dma_ranges(struct v3_pci *v3,
 				       struct device_node *np)
 {
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(v3);
 	struct device *dev = v3->dev;
+	struct resource_entry *entry;
 	int i = 0;
 
-	if (of_pci_dma_range_parser_init(&parser, np)) {
-		dev_err(dev, "missing dma-ranges property\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Get the dma-ranges from the device tree
-	 */
-	for_each_of_pci_range(&parser, &range) {
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
 		int ret;
 		u32 pci_base, pci_map;
 
-		ret = v3_get_dma_range_config(v3, &range, &pci_base, &pci_map);
+		ret = v3_get_dma_range_config(v3, entry, &pci_base, &pci_map);
 		if (ret)
 			return ret;
 
-- 
2.20.1

