Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35A3BD480
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 23:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbfIXVqn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 17:46:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34558 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbfIXVqn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 17:46:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id m19so2922749otp.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 14:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R72LtM4E+GnBMU5nTAg71RpvVo88KSBCCvKVk+mAsE4=;
        b=F1vMIh4J5OlfxliJTIZfnyzI04K/1WihC3Dx46z8DSCpBih50LsVteAuLm7izPmW2p
         9WrIhgjfFa4+BkCwq/59UgqUuQjMjTiVgy5nfPaklQI/0H5fiyAxrmrxtWdMQ8XIiR6u
         l4KQw3O7wdhj9QoYXXhY5sUSwBcQsPed6rfNbnCe4pt2B09Alr1x3Gmob/i1jdc2BS+l
         yMC1CCCiNkekUtHM7HQu62AEe+oXMH2A0nqIn/MLlLkxmNuwjM5HcqGkFOB+2q6qN13z
         NPwfuVqqfQ1Bvx+KyY50B8CtTnszbvyuIio74k21AAmjJvBejqwP7l0rnIC63h5hBqGL
         QHMg==
X-Gm-Message-State: APjAAAXvG6THC5RfVQssI2TRtKVMzaPZJeG+4DvHXvMmSiH83lICFS59
        iEwCGIhG5YCmXdv4tSS+VZzsyYM=
X-Google-Smtp-Source: APXvYqyPqqpzNQEFkC2p81nNKbbCveYcrUusLyGhhXWYHdVYOPjcgLX4O1oSMVrbeveb57HBIMCi5g==
X-Received: by 2002:a9d:7d12:: with SMTP id v18mr3837684otn.216.1569361602266;
        Tue, 24 Sep 2019 14:46:42 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s66sm976787otb.65.2019.09.24.14.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:46:41 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/11] PCI: v3-semi: Use inbound resources for setup
Date:   Tue, 24 Sep 2019 16:46:27 -0500
Message-Id: <20190924214630.12817-9-robh@kernel.org>
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
'dma_ranges' resource list, convert the v3-semi host bridge to use
the resource list to setup the inbound addresses.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-v3-semi.c | 38 ++++++++++++----------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 090df766faf9..122b695da591 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -613,28 +613,30 @@ static int v3_pci_setup_resource(struct v3_pci *v3,
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
@@ -682,8 +684,8 @@ static int v3_get_dma_range_config(struct v3_pci *v3,
 	dev_dbg(dev,
 		"DMA MEM CPU: 0x%016llx -> 0x%016llx => "
 		"PCI: 0x%016llx -> 0x%016llx base %08x map %08x\n",
-		range->cpu_addr, cpu_end,
-		range->pci_addr, pci_end,
+		cpu_addr, cpu_end,
+		pci_addr, pci_end,
 		*pci_base, *pci_map);
 
 	return 0;
@@ -692,24 +694,16 @@ static int v3_get_dma_range_config(struct v3_pci *v3,
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

