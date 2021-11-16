Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC055453414
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 15:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbhKPO0x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 09:26:53 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40028 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbhKPO0u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 09:26:50 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AGENkqt065266;
        Tue, 16 Nov 2021 08:23:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637072626;
        bh=kY4CrTITYhZQo3KclPHQ/T1EO2q3iKAUvdwiAQ6O+h4=;
        h=From:To:CC:Subject:Date;
        b=iapUqKBJJQ9AJD8crxpDWQl/UXso2xr39CR5+uXlnAf58ZM3TZHZ68Taox4mtF/9e
         OvOIqZareQUNF/cFT6v1ZSKZPSZdkjO+o46E3auB49ZTx37jZLeyAFKB8uk1+FmVj2
         heq6LWrVUZEV3mv66hYEgxYR983Vi6gREd/WSVxs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AGENk3D073525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Nov 2021 08:23:46 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 16
 Nov 2021 08:23:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 16 Nov 2021 08:23:46 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AGENgJs005673;
        Tue, 16 Nov 2021 08:23:43 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2] PCI: endpoint: Use DMA channel's 'dev' for dma_map_single()
Date:   Tue, 16 Nov 2021 19:53:42 +0530
Message-ID: <20211116142342.21689-1-kishon@ti.com>
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
Changes from v1:
Use dmaengine_get_dma_device() to get dma device from channel
V1: https://lore.kernel.org/r/20211115044944.31103-1-kishon@ti.com
 drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 90d84d3bc868..51f5b0b7b225 100644
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
 
+		dma_dev = dmaengine_get_dma_device(epf_test->dma_chan);
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
 
+		dma_dev = dmaengine_get_dma_device(epf_test->dma_chan);
 		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
 					       DMA_TO_DEVICE);
 		if (dma_mapping_error(dma_dev, src_phys_addr)) {
-- 
2.17.1

