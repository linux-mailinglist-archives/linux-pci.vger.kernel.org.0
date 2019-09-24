Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84646BD481
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 23:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394973AbfIXVqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 17:46:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46656 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbfIXVqo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 17:46:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id f21so2876469otl.13
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 14:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kzT1dQZKS9nlLNEXmzKDWhGBgjG065SiJgY5/7PYzKk=;
        b=S44yKy2/sw1IJpTjtyJytVNMk8jthNtexxrLpSiDLDEXWJYVAVc9mDo0S00/dIx+oU
         dIqEvQUflhsz1R7VUhGN56E7o1m2ZFaoYMEfdoTx+ZxKuBDjxZ2v2vfUIhoFBOzlNNH2
         LSSm6nGgFyBAi+cZJ/gqlAHeNVdm9N7mBcTBuQS5bAcvZQPALI1u1YZlPHe0SULWHHO7
         o5muBrC03SHXXYod4+hL6Yc80Sk60rwzW/jg271TzARkfbVQ8y/FSOvui6luDy8O21Lm
         gbXbgCZGfqnGRlT8ITPPUgrlyIYZBM4o62+vKNSnpgQCgKO22uDAIikrNFxGRnsXee0+
         3Q5w==
X-Gm-Message-State: APjAAAUER180i7HbT3NIYf9mows7oHKlJ0HDEFwBtRai+iDrLP/rZU3N
        YGvWFJOIKETqcGNO69Bq7fWGAtY=
X-Google-Smtp-Source: APXvYqxhl4TZRZyV/C1WBQs2FRtHj7Tr/BevDyc8y4ZafJ5qNeW5H0lpHfwkunz0YbNPf7SswH9New==
X-Received: by 2002:a05:6830:1e31:: with SMTP id t17mr3477636otr.201.1569361603571;
        Tue, 24 Sep 2019 14:46:43 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s66sm976787otb.65.2019.09.24.14.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:46:42 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Toan Le <toan@os.amperecomputing.com>
Subject: [PATCH 09/11] PCI: xgene: Use inbound resources for setup
Date:   Tue, 24 Sep 2019 16:46:28 -0500
Message-Id: <20190924214630.12817-10-robh@kernel.org>
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
'dma_ranges' resource list, convert the Xgene host bridge to use the
resource list to setup the inbound addresses.

Cc: Toan Le <toan@os.amperecomputing.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-xgene.c | 32 ++++++++++--------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 11f27c42c06a..09c913b12ebc 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -485,27 +485,27 @@ static int xgene_pcie_select_ib_reg(u8 *ib_reg_mask, u64 size)
 }
 
 static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
-				    struct of_pci_range *range, u8 *ib_reg_mask)
+				    struct resource_entry *entry, u8 *ib_reg_mask)
 {
 	void __iomem *cfg_base = port->cfg_base;
 	struct device *dev = port->dev;
 	void *bar_addr;
 	u32 pim_reg;
-	u64 cpu_addr = range->cpu_addr;
-	u64 pci_addr = range->pci_addr;
-	u64 size = range->size;
+	u64 cpu_addr = entry->res->start;
+	u64 pci_addr = cpu_addr - entry->offset;
+	u64 size = resource_size(entry->res);
 	u64 mask = ~(size - 1) | EN_REG;
 	u32 flags = PCI_BASE_ADDRESS_MEM_TYPE_64;
 	u32 bar_low;
 	int region;
 
-	region = xgene_pcie_select_ib_reg(ib_reg_mask, range->size);
+	region = xgene_pcie_select_ib_reg(ib_reg_mask, size);
 	if (region < 0) {
 		dev_warn(dev, "invalid pcie dma-range config\n");
 		return;
 	}
 
-	if (range->flags & IORESOURCE_PREFETCH)
+	if (entry->res->flags & IORESOURCE_PREFETCH)
 		flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
 
 	bar_low = pcie_bar_low_val((u32)cpu_addr, flags);
@@ -536,25 +536,13 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
 
 static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
 {
-	struct device_node *np = port->node;
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
-	struct device *dev = port->dev;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
+	struct resource_entry *entry;
 	u8 ib_reg_mask = 0;
 
-	if (of_pci_dma_range_parser_init(&parser, np)) {
-		dev_err(dev, "missing dma-ranges property\n");
-		return -EINVAL;
-	}
-
-	/* Get the dma-ranges from DT */
-	for_each_of_pci_range(&parser, &range) {
-		u64 end = range.cpu_addr + range.size - 1;
+	resource_list_for_each_entry(entry, &bridge->dma_ranges)
+		xgene_pcie_setup_ib_reg(port, entry, &ib_reg_mask);
 
-		dev_dbg(dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
-			range.flags, range.cpu_addr, end, range.pci_addr);
-		xgene_pcie_setup_ib_reg(port, &range, &ib_reg_mask);
-	}
 	return 0;
 }
 
-- 
2.20.1

