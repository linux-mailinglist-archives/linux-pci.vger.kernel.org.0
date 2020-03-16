Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2371869E7
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 12:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgCPLUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 07:20:05 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42732 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbgCPLUE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 07:20:04 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02GBJsfd028222;
        Mon, 16 Mar 2020 06:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584357594;
        bh=Dw2S5w/tmyycFEyjt5mSgRddCHa2LcL9gP3RRp2BM3I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J7XbZb5Zf5BgIYLYJ5Datvv5BkuySx1pdlNehI153cF+EEKf9O07xsttLff+qwbf2
         n8F52hLGCl1CUH2NHGsgjMN8AVTZb3LtA52YofbroEcAwjOaUVMiJlk8RM+0cFRGgY
         sw3/6Lar32+7NPusuhkzVTCAze08UBJ6mUwfO4Ps=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02GBJskb001567;
        Mon, 16 Mar 2020 06:19:54 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Mar 2020 06:19:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Mar 2020 06:19:53 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02GBJiTx049775;
        Mon, 16 Mar 2020 06:19:51 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 2/5] PCI: endpoint: functions/pci-epf-test: Print throughput information
Date:   Mon, 16 Mar 2020 16:54:21 +0530
Message-ID: <20200316112424.25295-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200316112424.25295-1-kishon@ti.com>
References: <20200316112424.25295-1-kishon@ti.com>
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
Tested-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index c9d9d1780e66..108e4b40e67a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -190,6 +190,36 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 	epf_test->dma_chan = NULL;
 }
 
+static void pci_epf_test_print_rate(const char *ops, u64 size,
+				    struct timespec64 *start,
+				    struct timespec64 *end, bool dma)
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
+	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
 
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
 
+	pci_epf_test_print_rate("READ", reg->size, &start, &end, use_dma);
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
 
+	pci_epf_test_print_rate("WRITE", reg->size, &start, &end, use_dma);
+
 	/*
 	 * wait 1ms inorder for the write to complete. Without this delay L3
 	 * error in observed in the host system.
-- 
2.17.1

