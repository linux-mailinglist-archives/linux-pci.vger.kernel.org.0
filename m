Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC64C187D8D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 10:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgCQJ5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 05:57:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43290 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgCQJ5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 05:57:44 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02H9vVhR108105;
        Tue, 17 Mar 2020 04:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584439051;
        bh=bpItwiRGbgOtzOiS/bfM6aM7INXn/1XJemanJWEH6U8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=V6LxoXwSkgHLiflJw9J67XWwR3AhHl2c2x6yXpj/aF33q+aUhPOl+R4UIPgvnCqsh
         a5T4M5say0XcKLueCeNU8XbKNohpvYw4CzWtLong73wRk8FQNkHdleRnB5g7vm0p7H
         438HhPupqfQUMHIYwRrfybmrr4etPkgJPEsG3YOA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02H9vV7F039957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Mar 2020 04:57:31 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Mar 2020 04:57:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Mar 2020 04:57:31 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02H9vIKU095155;
        Tue, 17 Mar 2020 04:57:28 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 3/5] tools: PCI: Add 'e' to clear IRQ
Date:   Tue, 17 Mar 2020 15:31:56 +0530
Message-ID: <20200317100158.4692-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317100158.4692-1-kishon@ti.com>
References: <20200317100158.4692-1-kishon@ti.com>
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
index 5e3b6368c5e0..0a1344c45213 100644
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
@@ -76,6 +77,15 @@ static int run_test(struct pci_test *test)
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
@@ -164,7 +174,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:dIlhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -205,6 +215,9 @@ int main(int argc, char **argv)
 	case 'c':
 		test->copy = true;
 		continue;
+	case 'e':
+		test->clear_irq = true;
+		continue;
 	case 's':
 		test->size = strtoul(optarg, NULL, 0);
 		continue;
@@ -222,6 +235,7 @@ int main(int argc, char **argv)
 			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
 			"\t-x <msix num>	\tMSI-X test (msix number between 1..2048)\n"
 			"\t-i <irq type>	\tSet IRQ type (0 - Legacy, 1 - MSI, 2 - MSI-X)\n"
+			"\t-e			Clear IRQ\n"
 			"\t-I			Get current IRQ type configured\n"
 			"\t-d			Use DMA\n"
 			"\t-l			Legacy IRQ test\n"
-- 
2.17.1

