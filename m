Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 628C1177445
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 11:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgCCKdh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 05:33:37 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50066 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbgCCKdg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 05:33:36 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 023AXTBq005401;
        Tue, 3 Mar 2020 04:33:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583231609;
        bh=31ezpbLZ0uXjcOlbwyAh8gIcq9TtU30dUgFMQah//44=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wJNiFFaHcamP5k839fy8yZ51tCxDBumdhz12II+46vnNbBWaAz04mnELFkLnhkbof
         Ro5bbi40B8nW6574xxnIswD4uBnzi5b3J7Bf06QYpsAxC0NctX0+TxyEikGAbR4p2/
         kJeux5I1m6mNh7iz2RX8jkt+Ty+XCKRUhN0CG5vk=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 023AXTR2126973
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Mar 2020 04:33:29 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 04:33:28 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 04:33:28 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 023AXJvd114370;
        Tue, 3 Mar 2020 04:33:26 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 2/5] PCI: endpoint: functions/pci-epf-test: Print throughput information
Date:   Tue, 3 Mar 2020 16:07:49 +0530
Message-ID: <20200303103752.13076-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303103752.13076-1-kishon@ti.com>
References: <20200303103752.13076-1-kishon@ti.com>
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
index d90237f79d5a..8b6efc794d9f 100644
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

