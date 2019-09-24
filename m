Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52357BD482
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 23:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395534AbfIXVqq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 17:46:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46659 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbfIXVqq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 17:46:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id f21so2876510otl.13
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 14:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyYVfHwqMpUb0dG8xhH3D2wwe8Um8pFX3NIc2wpZXzU=;
        b=C4LaYiapB+gGYlHY8zndnFvU0UTfw+W6GZdT4C5FIv6jTzEIxxdtOGpQaORmeQKNzQ
         fPYSRNEgIBZZGS28rAEiLANNR8BQrlwGf51+Oi+vqStpGtBosSlM4CW28ozD3/7zXsnp
         WsfTKS+Tfy7TcB/Q0AfMYBXtyIK5ewwv3T8Owlc3B8Hp6GfMvyqjVtUDXqPUdR1q/Hqm
         76ZJRb6FzWOeZI7V4cM65NSwAm76pkaWeS022W3trNy9asoA1T1lgeETQfiON5er3OaF
         mWTVUFuSomRjgObkXH4bW1e/jJModCgHHqUjFFKNhQZIatrgYZXhfy9HXwCubHmalHPe
         YVog==
X-Gm-Message-State: APjAAAXSIWh3OdSvQ2Tvufhmvi/DMU8oaVziD/fkPkDOePWw9zS+aUvJ
        d/xFn6sjTypTBYiuXaMC8ZxeQcI=
X-Google-Smtp-Source: APXvYqz17HkSTxsTCEmLThqlQYmUwW3cV2NmGnqT2qALFG4fCCZzK7gcnD0K52XoGWX8p1bNTZ/oyw==
X-Received: by 2002:a9d:6084:: with SMTP id m4mr3643597otj.6.1569361604751;
        Tue, 24 Sep 2019 14:46:44 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s66sm976787otb.65.2019.09.24.14.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:46:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 10/11] PCI: iproc: Use inbound resources for setup
Date:   Tue, 24 Sep 2019 16:46:29 -0500
Message-Id: <20190924214630.12817-11-robh@kernel.org>
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
'dma_ranges' resource list, convert Broadcom iProc host bridge to use
the resource list to setup the inbound addresses.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-iproc.c | 63 ++++-------------------------
 1 file changed, 8 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 2d457bfdaf66..9ed181050308 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1122,15 +1122,15 @@ static int iproc_pcie_ib_write(struct iproc_pcie *pcie, int region_idx,
 }
 
 static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
-			       struct of_pci_range *range,
+			       struct resource_entry *entry,
 			       enum iproc_pcie_ib_map_type type)
 {
 	struct device *dev = pcie->dev;
 	struct iproc_pcie_ib *ib = &pcie->ib;
 	int ret;
 	unsigned int region_idx, size_idx;
-	u64 axi_addr = range->cpu_addr, pci_addr = range->pci_addr;
-	resource_size_t size = range->size;
+	u64 axi_addr = entry->res->start, pci_addr = entry->res->start - entry->offset;
+	resource_size_t size = resource_size(entry->res);
 
 	/* iterate through all IARR mapping regions */
 	for (region_idx = 0; region_idx < ib->nr_regions; region_idx++) {
@@ -1182,66 +1182,19 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
 	return ret;
 }
 
-static int iproc_pcie_add_dma_range(struct device *dev,
-				    struct list_head *resources,
-				    struct of_pci_range *range)
-{
-	struct resource *res;
-	struct resource_entry *entry, *tmp;
-	struct list_head *head = resources;
-
-	res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
-	if (!res)
-		return -ENOMEM;
-
-	resource_list_for_each_entry(tmp, resources) {
-		if (tmp->res->start < range->cpu_addr)
-			head = &tmp->node;
-	}
-
-	res->start = range->cpu_addr;
-	res->end = res->start + range->size - 1;
-
-	entry = resource_list_create_entry(res, 0);
-	if (!entry)
-		return -ENOMEM;
-
-	entry->offset = res->start - range->cpu_addr;
-	resource_list_add(entry, head);
-
-	return 0;
-}
-
 static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 {
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
-	int ret;
-	LIST_HEAD(resources);
+	struct resource_entry *entry;
+	int ret = 0;
 
-	/* Get the dma-ranges from DT */
-	ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
-	if (ret)
-		return ret;
-
-	for_each_of_pci_range(&parser, &range) {
-		ret = iproc_pcie_add_dma_range(pcie->dev,
-					       &resources,
-					       &range);
-		if (ret)
-			goto out;
+	resource_list_for_each_entry(entry, &host->dma_ranges) {
 		/* Each range entry corresponds to an inbound mapping region */
-		ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
+		ret = iproc_pcie_setup_ib(pcie, entry, IPROC_PCIE_IB_MAP_MEM);
 		if (ret)
-			goto out;
+			break;
 	}
 
-	list_splice_init(&resources, &host->dma_ranges);
-
-	return 0;
-out:
-	pci_free_resource_list(&resources);
 	return ret;
 }
 
-- 
2.20.1

