Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A738544FDFB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 05:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhKOEwt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Nov 2021 23:52:49 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53406 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhKOEwt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Nov 2021 23:52:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AF4nnhj031424;
        Sun, 14 Nov 2021 22:49:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636951789;
        bh=kpg+mAnKspgUBTl4O+Oze4nlF/tYfZPZcqPAdSRs9aI=;
        h=From:To:CC:Subject:Date;
        b=svoayQQ/6B/no5rKq3/skS6aAofzGYoGdc/jzEczF0uxJcAZfPAh6Rt4YKkuwUl4O
         0Psel/o+063WPbMuyXn4DHRNgWxsN25U4tNRljw65Z5tlS7to34ySvYtwkE8W6hP6x
         6kGZ//GQxJc6vCoAwM6GT6zBHoEZw9WfStlPu6R4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AF4nnQ8088909
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 14 Nov 2021 22:49:49 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 14
 Nov 2021 22:49:48 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 14 Nov 2021 22:49:49 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AF4njo9073379;
        Sun, 14 Nov 2021 22:49:46 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] PCI: endpoint: Use DMA channel's 'dev' for dma_map_single()
Date:   Mon, 15 Nov 2021 10:19:44 +0530
Message-ID: <20211115044944.31103-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For the case where the pci-epf-test driver uses DMA for transferring
data to the root complex device, dma_map_single() is used to map virtual
address to a physical address (address accessible by DMA controller) and
provided to the DMAengine API for transferring data. Here instead of
using the PCIe endpoint controller's 'dev' for dma_map_single(), provide
DMA channel's 'dev' for dma_map_single() since the data transfer is
actually done by DMA.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 90d84d3bc868..3e353d1f11cb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -314,12 +314,12 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	u32 crc32;
 	bool use_dma;
 	phys_addr_t phys_addr;
+	struct device *dma_dev;
 	phys_addr_t dst_phys_addr;
 	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
-	struct device *dma_dev = epf->epc->dev.parent;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
@@ -353,6 +353,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 			goto err_dma_map;
 		}
 
+		dma_dev = epf_test->dma_chan->device->dev;
 		dst_phys_addr = dma_map_single(dma_dev, buf, reg->size,
 					       DMA_FROM_DEVICE);
 		if (dma_mapping_error(dma_dev, dst_phys_addr)) {
@@ -402,12 +403,12 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	void *buf;
 	bool use_dma;
 	phys_addr_t phys_addr;
+	struct device *dma_dev;
 	phys_addr_t src_phys_addr;
 	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
-	struct device *dma_dev = epf->epc->dev.parent;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
@@ -444,6 +445,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 			goto err_map_addr;
 		}
 
+		dma_dev = epf_test->dma_chan->device->dev;
 		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
 					       DMA_TO_DEVICE);
 		if (dma_mapping_error(dma_dev, src_phys_addr)) {
-- 
2.17.1

