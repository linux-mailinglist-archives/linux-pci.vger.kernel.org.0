Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E835B1869EB
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 12:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgCPLUQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 07:20:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59830 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbgCPLUQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 07:20:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02GBK0C9072887;
        Mon, 16 Mar 2020 06:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584357600;
        bh=+kGa8JsM9BJ9yRHWGEHY+vmdaSQ8X1ysT5HEr2Zucps=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Gnvv6PAwJWEeYkaozKylBzOleuZ9BTQUfDUuYXZ/XTrlzQcaQzE20M251m5aeYk8I
         SRvPL9fhHicFT5EGOkwqzijhlNEWjowt6VNnrqdyBFevfWvtJtnZLmqlMd23YBj3jB
         s4mkrz59iH+BTU1uwy+1Ejsjf4phhpETseuTDAVY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02GBK0Ps017246
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Mar 2020 06:20:00 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Mar 2020 06:20:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Mar 2020 06:20:00 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02GBJiU1049775;
        Mon, 16 Mar 2020 06:19:57 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 4/5] tools: PCI: Add 'd' command line option to support DMA
Date:   Mon, 16 Mar 2020 16:54:23 +0530
Message-ID: <20200316112424.25295-5-kishon@ti.com>
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

Add a new command line option 'd' to use DMA for data transfers.
It should be used with read, write or copy commands.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 include/uapi/linux/pcitest.h |  7 +++++++
 tools/pci/pcitest.c          | 23 +++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index cbf422e56696..8b868761f8b4 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -20,4 +20,11 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 
+#define PCITEST_FLAGS_USE_DMA	0x00000001
+
+struct pci_endpoint_test_xfer_param {
+	unsigned long size;
+	unsigned char flags;
+};
+
 #endif /* __UAPI_LINUX_PCITEST_H */
diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 32b7c6f9043d..5e3b6368c5e0 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -34,10 +34,12 @@ struct pci_test {
 	bool		write;
 	bool		copy;
 	unsigned long	size;
+	bool		use_dma;
 };
 
 static int run_test(struct pci_test *test)
 {
+	struct pci_endpoint_test_xfer_param param;
 	int ret = -EINVAL;
 	int fd;
 
@@ -102,7 +104,10 @@ static int run_test(struct pci_test *test)
 	}
 
 	if (test->write) {
-		ret = ioctl(fd, PCITEST_WRITE, test->size);
+		param.size = test->size;
+		if (test->use_dma)
+			param.flags = PCITEST_FLAGS_USE_DMA;
+		ret = ioctl(fd, PCITEST_WRITE, &param);
 		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
@@ -111,7 +116,10 @@ static int run_test(struct pci_test *test)
 	}
 
 	if (test->read) {
-		ret = ioctl(fd, PCITEST_READ, test->size);
+		param.size = test->size;
+		if (test->use_dma)
+			param.flags = PCITEST_FLAGS_USE_DMA;
+		ret = ioctl(fd, PCITEST_READ, &param);
 		fprintf(stdout, "READ (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
@@ -120,7 +128,10 @@ static int run_test(struct pci_test *test)
 	}
 
 	if (test->copy) {
-		ret = ioctl(fd, PCITEST_COPY, test->size);
+		param.size = test->size;
+		if (test->use_dma)
+			param.flags = PCITEST_FLAGS_USE_DMA;
+		ret = ioctl(fd, PCITEST_COPY, &param);
 		fprintf(stdout, "COPY (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
@@ -153,7 +164,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:Ilhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:dIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -197,6 +208,9 @@ int main(int argc, char **argv)
 	case 's':
 		test->size = strtoul(optarg, NULL, 0);
 		continue;
+	case 'd':
+		test->use_dma = true;
+		continue;
 	case 'h':
 	default:
 usage:
@@ -209,6 +223,7 @@ int main(int argc, char **argv)
 			"\t-x <msix num>	\tMSI-X test (msix number between 1..2048)\n"
 			"\t-i <irq type>	\tSet IRQ type (0 - Legacy, 1 - MSI, 2 - MSI-X)\n"
 			"\t-I			Get current IRQ type configured\n"
+			"\t-d			Use DMA\n"
 			"\t-l			Legacy IRQ test\n"
 			"\t-r			Read buffer test\n"
 			"\t-w			Write buffer test\n"
-- 
2.17.1

