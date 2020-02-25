Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B13516BCFE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 10:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgBYJH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 04:07:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54924 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbgBYJH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 04:07:28 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P97K8S069057;
        Tue, 25 Feb 2020 03:07:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582621640;
        bh=2hjND1deYWq3ajV8ZakOoqLQXl+slE0s02toOqNb+4o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TGkMs6a3+9BttUmw8QZsK/5AsiSoNxBujxATODDFRLtJnzyS4dLEwcrU02gV7kRXV
         qjaX/ddob5Ln1dCq7wAv5ETHQiOL9AF2jzmyCNEBn2uPOYdOKvhbtDteRS65Ye/Q0b
         xx38uRNVOI5gB23/4BDsW0RfeFx63TYLOa4J3emw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P97KNo038537
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Feb 2020 03:07:20 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 03:07:20 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 03:07:20 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P973Ps052643;
        Tue, 25 Feb 2020 03:07:17 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] tools: PCI: Add 'd' command line option to support DMA
Date:   Tue, 25 Feb 2020 14:41:29 +0530
Message-ID: <20200225091130.29467-5-kishon@ti.com>
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

Add a new command line option 'd' to use DMA for data transfers.
It should be used with read, write or copy commands.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/uapi/linux/pcitest.h |  5 +++++
 tools/pci/pcitest.c          | 20 ++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index cbf422e56696..1a63999e3deb 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -20,4 +20,9 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 
+struct pci_endpoint_test_xfer_param {
+	unsigned long size;
+	bool use_dma;
+};
+
 #endif /* __UAPI_LINUX_PCITEST_H */
diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 32b7c6f9043d..be79ec10cefc 100644
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
 
@@ -102,7 +104,9 @@ static int run_test(struct pci_test *test)
 	}
 
 	if (test->write) {
-		ret = ioctl(fd, PCITEST_WRITE, test->size);
+		param.size = test->size;
+		param.use_dma = test->use_dma;
+		ret = ioctl(fd, PCITEST_WRITE, &param);
 		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
@@ -111,7 +115,9 @@ static int run_test(struct pci_test *test)
 	}
 
 	if (test->read) {
-		ret = ioctl(fd, PCITEST_READ, test->size);
+		param.size = test->size;
+		param.use_dma = test->use_dma;
+		ret = ioctl(fd, PCITEST_READ, &param);
 		fprintf(stdout, "READ (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
@@ -120,7 +126,9 @@ static int run_test(struct pci_test *test)
 	}
 
 	if (test->copy) {
-		ret = ioctl(fd, PCITEST_COPY, test->size);
+		param.size = test->size;
+		param.use_dma = test->use_dma;
+		ret = ioctl(fd, PCITEST_COPY, &param);
 		fprintf(stdout, "COPY (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
 			fprintf(stdout, "TEST FAILED\n");
@@ -153,7 +161,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:Ilhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:dIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -197,6 +205,9 @@ int main(int argc, char **argv)
 	case 's':
 		test->size = strtoul(optarg, NULL, 0);
 		continue;
+	case 'd':
+		test->use_dma = true;
+		continue;
 	case 'h':
 	default:
 usage:
@@ -209,6 +220,7 @@ int main(int argc, char **argv)
 			"\t-x <msix num>	\tMSI-X test (msix number between 1..2048)\n"
 			"\t-i <irq type>	\tSet IRQ type (0 - Legacy, 1 - MSI, 2 - MSI-X)\n"
 			"\t-I			Get current IRQ type configured\n"
+			"\t-d			Use DMA\n"
 			"\t-l			Legacy IRQ test\n"
 			"\t-r			Read buffer test\n"
 			"\t-w			Write buffer test\n"
-- 
2.17.1

