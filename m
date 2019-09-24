Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2ABD47F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbfIXVqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 17:46:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37393 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbfIXVqm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 17:46:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id i16so3068348oie.4
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 14:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6NzmoyzjZeLo4J8UGvzKGgfTn+zvwBNbZJNczmh+D4=;
        b=V/wAUiy5JsEnIReOBQgBta+HM5wU7ZQTEeb9iST3kNyFz2XiuL030H7RW5C3t6z3Oi
         nHOfg/ijRJSWkT2lgzf0dlqyLiq0pK9pyDxrlhDcbcjFhUHrqQrX1/puTuQD+vv5DSwF
         atlyZBvcO6jVZnCpueLhFU46EQLbq+1DENn2AOeK2xa1JSU7MsK69txhFPoNo16eT7qe
         b9PqraR/RojMm1AOIrSHkc3As1kSqK5H7LWDuRvjr74n3LjQlNsRbSvsybrKK9769vNQ
         8JIMY+CEfUNpoxHAGpxbqOc/4cpa00PYOXMoeoN8kZ9YltnAvdIJ9tDjDYXx/zWlKjnR
         q4qw==
X-Gm-Message-State: APjAAAU0rXTnWrPAMtQjS4G7px1m+EG4QY0Ly8T4GCCSNY8vlDRynPRw
        50eiEmcmILb93J9L9Rwu6eR+/xI=
X-Google-Smtp-Source: APXvYqxm493Rq9Q/JW6/m50nT3yGQOwZBnFUFyrFNDpiyWem3q6ykJqiXpDHGYmF2uopiFy/5olkYQ==
X-Received: by 2002:aca:a9c3:: with SMTP id s186mr2088694oie.60.1569361601218;
        Tue, 24 Sep 2019 14:46:41 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s66sm976787otb.65.2019.09.24.14.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:46:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/11] PCI: ftpci100: Use inbound resources for setup
Date:   Tue, 24 Sep 2019 16:46:26 -0500
Message-Id: <20190924214630.12817-8-robh@kernel.org>
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
'dma_ranges' resource list, convert Faraday ftpci100 host bridge to use
the resource list to setup the inbound addresses.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-ftpci100.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 3e07a8203736..e37a33ad77d9 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -375,12 +375,11 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
 	return 0;
 }
 
-static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p,
-					    struct device_node *np)
+static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p)
 {
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
 	struct device *dev = p->dev;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(p);
+	struct resource_entry *entry;
 	u32 confreg[3] = {
 		FARADAY_PCI_MEM1_BASE_SIZE,
 		FARADAY_PCI_MEM2_BASE_SIZE,
@@ -389,19 +388,12 @@ static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p,
 	int i = 0;
 	u32 val;
 
-	if (of_pci_dma_range_parser_init(&parser, np)) {
-		dev_err(dev, "missing dma-ranges property\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Get the dma-ranges from the device tree
-	 */
-	for_each_of_pci_range(&parser, &range) {
-		u64 end = range.pci_addr + range.size - 1;
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
+		u64 pci_addr = entry->res->start - entry->offset;
+		u64 end = entry->res->end - entry->offset;
 		int ret;
 
-		ret = faraday_res_to_memcfg(range.pci_addr, range.size, &val);
+		ret = faraday_res_to_memcfg(pci_addr, resource_size(entry->res), &val);
 		if (ret) {
 			dev_err(dev,
 				"DMA range %d: illegal MEM resource size\n", i);
@@ -409,7 +401,7 @@ static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p,
 		}
 
 		dev_info(dev, "DMA MEM%d BASE: 0x%016llx -> 0x%016llx config %08x\n",
-			 i + 1, range.pci_addr, end, val);
+			 i + 1, pci_addr, end, val);
 		if (i <= 2) {
 			faraday_raw_pci_write_config(p, 0, 0, confreg[i],
 						     4, val);
@@ -566,7 +558,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
 			cur_bus_speed = PCI_SPEED_66MHz;
 	}
 
-	ret = faraday_pci_parse_map_dma_ranges(p, dev->of_node);
+	ret = faraday_pci_parse_map_dma_ranges(p);
 	if (ret)
 		return ret;
 
-- 
2.20.1

