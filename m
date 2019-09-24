Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAFBDBD483
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 23:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbfIXVqr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 17:46:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41538 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395520AbfIXVqq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 17:46:46 -0400
Received: by mail-oi1-f193.google.com with SMTP id w17so3057693oiw.8
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 14:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KRER0q+mlfhxTDAY0c1+VI59pLZZnQ9VLJY13cVFl4Y=;
        b=ufUySC78f2+FEjkqy/AeP7YGhlFv2bRrZ+VvA4Ihpc7761r672JTV2cpDt7b020IsT
         OeJXb0RD2LvQnkxsqBvq+IN6NXaPoQ/21DGeE9JJpSOvn69yZF6R805wsYYIrmIcacLW
         /fKdApFp58yhR53gg44V79aobbbgnsMay/liDk4hD8wQfiZ8WtCRicLsIEWVOlfMhhoR
         Mo4lBREp0MQ4qBTGe3ZNsITv0C4s5DdgN5ol+rhKQ2GBLi97Gw1N3o+92oYIYkSz0DgL
         9ID1HS7e49KTVA5CmnQXntWgOrqmv1m/OrV4nTxJei2xVIqwWB/AdZN5RZQJL/LlahW0
         UDDw==
X-Gm-Message-State: APjAAAV8uYPUPj33EZSvFJ2Ga3Mdg9kKSJAo2Pu4R8KviUUz9DtRevMV
        4jzaNgyiFQTTO7GLTkI0dxDx6HA=
X-Google-Smtp-Source: APXvYqwgBp3XW5k0bjqWkMtbPmB+OzYYsn1F2SbpReTHH0zYcIqCKZJ2yQ8jgdcCRG2eP6rhB+Z3YQ==
X-Received: by 2002:aca:df88:: with SMTP id w130mr2172805oig.0.1569361605620;
        Tue, 24 Sep 2019 14:46:45 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s66sm976787otb.65.2019.09.24.14.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:46:45 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms@verge.net.au>
Subject: [PATCH 11/11] PCI: rcar: Use inbound resources for setup
Date:   Tue, 24 Sep 2019 16:46:30 -0500
Message-Id: <20190924214630.12817-12-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924214630.12817-1-robh@kernel.org>
References: <20190924214630.12817-1-robh@kernel.org>
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

