Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495A212D008
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 13:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfL3Mbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 07:31:51 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33396 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfL3Mbu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Dec 2019 07:31:50 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVSAE065574;
        Mon, 30 Dec 2019 06:31:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577709088;
        bh=80xrZROJ/3yIZ/pEEHiKoJKreAUnrlhI7GU6M+DWOWg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=B/k+5Fq78EyAZtqxi3pKbqncyTFw24QBb1DkmZQY/uUCBOmDTyo2mzbToDXMqPjI1
         iyuK6zgWR9u/+jyAaJPXQ5OHsbCPse2ZILhAVD4zK4r9OW3X71SWHZbeAzAC185tvU
         yECywjzrxvZ1zqEh7YOhrTLzhwFie03PpsqejWng=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVSoD112409;
        Mon, 30 Dec 2019 06:31:28 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 06:31:28 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 06:31:28 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVEhQ002491;
        Mon, 30 Dec 2019 06:31:26 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] tools: PCI: Add 'e' to clear IRQ
Date:   Mon, 30 Dec 2019 18:03:12 +0530
Message-ID: <20191230123315.31037-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230123315.31037-1-kishon@ti.com>
References: <20191230123315.31037-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new command line option 'e' to invoke "PCITEST_CLEAR_IRQ"
ioctl. This can be used to clear the irqs set using the 'i' option.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 tools/pci/pcitest.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 32b7c6f9043d..449c2c687797 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -30,6 +30,7 @@ struct pci_test {
 	int		irqtype;
 	bool		set_irqtype;
 	bool		get_irqtype;
+	bool		clear_irq;
 	bool		read;
 	bool		write;
 	bool		copy;
@@ -74,6 +75,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", irq[ret]);
 	}
 
+	if (test->clear_irq) {
+		ret = ioctl(fd, PCITEST_CLEAR_IRQ);
+		fprintf(stdout, "CLEAR IRQ:\t\t");
+		if (ret < 0)
+			fprintf(stdout, "FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	if (test->legacyirq) {
 		ret = ioctl(fd, PCITEST_LEGACY_IRQ, 0);
 		fprintf(stdout, "LEGACY IRQ:\t");
@@ -153,7 +163,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:Ilhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:eIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -194,6 +204,9 @@ int main(int argc, char **argv)
 	case 'c':
 		test->copy = true;
 		continue;
+	case 'e':
+		test->clear_irq = true;
+		continue;
 	case 's':
 		test->size = strtoul(optarg, NULL, 0);
 		continue;
@@ -208,6 +221,7 @@ int main(int argc, char **argv)
 			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
 			"\t-x <msix num>	\tMSI-X test (msix number between 1..2048)\n"
 			"\t-i <irq type>	\tSet IRQ type (0 - Legacy, 1 - MSI, 2 - MSI-X)\n"
+			"\t-e			Clear IRQ\n"
 			"\t-I			Get current IRQ type configured\n"
 			"\t-l			Legacy IRQ test\n"
 			"\t-r			Read buffer test\n"
-- 
2.17.1

