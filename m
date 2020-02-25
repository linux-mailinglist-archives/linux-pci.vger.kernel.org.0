Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3379216BCFA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 10:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgBYJHW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 04:07:22 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57048 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgBYJHV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 04:07:21 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P97Eth115001;
        Tue, 25 Feb 2020 03:07:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582621634;
        bh=Bq3pAD0OdG6ZmZKpUZqs5/tQpPJOIse28CO39y2SDaw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qV56VK/AujqAuPkEJWQz76Bim+hfYiEGW/X3QzgEGduVRbUdAk8qrKqVNNbI2rgkL
         /pZ1m3CHV45vFMbZNS/zwEcVHx4O7KeGIEYSPd2+bw9F4jSBwwgmxve43NBPOMjDdP
         EHOpX3q5cjqtjpG7wvHVhsOWhjpV/zOMb6e/mNgw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P97EDl038406
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Feb 2020 03:07:14 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 03:07:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 03:07:13 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P973Pq052643;
        Tue, 25 Feb 2020 03:07:11 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] PCI: endpoint: functions/pci-epf-test: Print throughput information
Date:   Tue, 25 Feb 2020 14:41:27 +0530
Message-ID: <20200225091130.29467-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225091130.29467-1-kishon@ti.com>
References: <20200225091130.29467-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Print throughput information in KB/s after every completed transfer,
including information on whether DMA is used or not.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 4e5ed37110ed..db15b080519d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -190,6 +190,36 @@ static void pci_epf_clean_dma_chan(struct pci_epf_test *epf_test)
 	epf_test->dma_chan = NULL;
 }
 
+static void pci_epf_print_rate(const char *ops, u64 size,
+			       struct timespec64 *start, struct timespec64 *end,
+			       bool dma)
+{
+	struct timespec64 ts;
+	u64 rate, ns;
+
+	ts = timespec64_sub(*end, *start);
+
+	/* convert both size (stored in 'rate') and time in terms of 'ns' */
+	ns = timespec64_to_ns(&ts);
+	rate = size * NSEC_PER_SEC;
+
+	/* Divide both size (stored in 'rate') and ns by a common factor */
+	while (ns > UINT_MAX) {
+		rate >>= 1;
+		ns >>= 1;
+	}
+
+	if (!ns)
+		return;
+
+	/* calculate the rate */
+	do_div(rate, (uint32_t)ns);
+
+	pr_info("\n%s => Size: %llu bytes\t DMA: %s\t Time: %llu.%09u seconds\t"
+		"Rate: %llu KB/s\n", ops, size, dma ? "YES" : "NO",
+		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
+}
+
 static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 {
 	int ret;
@@ -198,6 +228,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	void __iomem *dst_addr;
 	phys_addr_t src_phys_addr;
 	phys_addr_t dst_phys_addr;
+	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
@@ -236,6 +267,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err_dst_addr;
 	}
 
+	ktime_get_ts64(&start);
 	use_dma = !!(reg->flags & FLAG_USE_DMA);
 	if (use_dma) {
 		if (!epf_test->dma_supported) {
@@ -251,6 +283,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	} else {
 		memcpy(dst_addr, src_addr, reg->size);
 	}
+	ktime_get_ts64(&end);
+	pci_epf_print_rate("COPY", reg->size, &start, &end, use_dma);
 
 err_map_addr:
 	pci_epc_unmap_addr(epc, epf->func_no, dst_phys_addr);
@@ -277,6 +311,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	bool use_dma;
 	phys_addr_t phys_addr;
 	phys_addr_t dst_phys_addr;
+	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
@@ -322,17 +357,23 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 			goto err_dma_map;
 		}
 
+		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
 						 phys_addr, reg->size);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
+		ktime_get_ts64(&end);
 
 		dma_unmap_single(dma_dev, dst_phys_addr, reg->size,
 				 DMA_FROM_DEVICE);
 	} else {
+		ktime_get_ts64(&start);
 		memcpy_fromio(buf, src_addr, reg->size);
+		ktime_get_ts64(&end);
 	}
 
+	pci_epf_print_rate("READ", reg->size, &start, &end, use_dma);
+
 	crc32 = crc32_le(~0, buf, reg->size);
 	if (crc32 != reg->checksum)
 		ret = -EIO;
@@ -358,6 +399,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	bool use_dma;
 	phys_addr_t phys_addr;
 	phys_addr_t src_phys_addr;
+	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
@@ -406,17 +448,23 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 			goto err_dma_map;
 		}
 
+		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
 						 src_phys_addr, reg->size);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
+		ktime_get_ts64(&end);
 
 		dma_unmap_single(dma_dev, src_phys_addr, reg->size,
 				 DMA_TO_DEVICE);
 	} else {
+		ktime_get_ts64(&start);
 		memcpy_toio(dst_addr, buf, reg->size);
+		ktime_get_ts64(&end);
 	}
 
+	pci_epf_print_rate("WRITE", reg->size, &start, &end, use_dma);
+
 	/*
 	 * wait 1ms inorder for the write to complete. Without this delay L3
 	 * error in observed in the host system.
-- 
2.17.1

