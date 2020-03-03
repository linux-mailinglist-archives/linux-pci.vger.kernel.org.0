Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E538177447
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 11:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgCCKdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 05:33:47 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38332 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgCCKdr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 05:33:47 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 023AXcTj014751;
        Tue, 3 Mar 2020 04:33:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583231618;
        bh=JRl5ARotx9L0/8W2ZWBpmQ2FofoiaRYaIrBYg+s9K+o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DlkjSTJaFFjx69QBJ2EZ+6qKSe2TY/VydWHkv1rkeQ6mDD8xRgjFpArM087jW39gz
         QW+Pehc+wwNzJ+vPhuwOdR9eXDw5NrPs2qtzXXsRtlPRw1peEoQvQVCuUy7dXAM/Tk
         0yVTGz6Ar9w/mqblBRFGcW7Bf88QuZbRuhiYA8Ro=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 023AXcSW030040
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Mar 2020 04:33:38 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 04:33:38 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 04:33:39 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 023AXJvg114370;
        Tue, 3 Mar 2020 04:33:35 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 5/5] misc: pci_endpoint_test: Add support to get DMA option from userspace
Date:   Tue, 3 Mar 2020 16:07:52 +0530
Message-ID: <20200303103752.13076-6-kishon@ti.com>
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

'pcitest' utility now uses '-d' option to allow the user to test DMA.
Add support to parse option to use DMA from userspace application.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 65 ++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 5998df1c84e9..3f102356b600 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -17,6 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 
@@ -52,6 +53,7 @@
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
 
+#define PCI_ENDPOINT_TEST_STATUS		0x8
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
 
@@ -64,6 +66,9 @@
 #define PCI_ENDPOINT_TEST_IRQ_TYPE		0x24
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
+#define PCI_ENDPOINT_TEST_FLAGS			0x2c
+#define FLAG_USE_DMA				BIT(0)
+
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 
 #define is_am654_pci_dev(pdev)		\
@@ -315,11 +320,16 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
-static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
+static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
+				   unsigned long arg)
 {
+	struct pci_endpoint_test_xfer_param param;
 	bool ret = false;
 	void *src_addr;
 	void *dst_addr;
+	u32 flags = 0;
+	bool use_dma;
+	size_t size;
 	dma_addr_t src_phys_addr;
 	dma_addr_t dst_phys_addr;
 	struct pci_dev *pdev = test->pdev;
@@ -332,10 +342,22 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	size_t alignment = test->alignment;
 	u32 src_crc32;
 	u32 dst_crc32;
+	int err;
+
+	err = copy_from_user(&param, (void *)arg, sizeof(param));
+	if (err) {
+		dev_err(dev, "Failed to get transfer param\n");
+		return false;
+	}
 
+	size = param.size;
 	if (size > SIZE_MAX - alignment)
 		goto err;
 
+	use_dma = param.use_dma;
+	if (use_dma)
+		flags |= FLAG_USE_DMA;
+
 	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		goto err;
@@ -406,6 +428,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE,
 				 size);
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
@@ -434,9 +457,13 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	return ret;
 }
 
-static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
+static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
+				    unsigned long arg)
 {
+	struct pci_endpoint_test_xfer_param param;
 	bool ret = false;
+	u32 flags = 0;
+	bool use_dma;
 	u32 reg;
 	void *addr;
 	dma_addr_t phys_addr;
@@ -446,11 +473,24 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t orig_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
+	size_t size;
 	u32 crc32;
+	int err;
 
+	err = copy_from_user(&param, (void *)arg, sizeof(param));
+	if (err != 0) {
+		dev_err(dev, "Failed to get transfer param\n");
+		return false;
+	}
+
+	size = param.size;
 	if (size > SIZE_MAX - alignment)
 		goto err;
 
+	use_dma = param.use_dma;
+	if (use_dma)
+		flags |= FLAG_USE_DMA;
+
 	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		goto err;
@@ -493,6 +533,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
@@ -514,9 +555,14 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	return ret;
 }
 
-static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
+static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
+				   unsigned long arg)
 {
+	struct pci_endpoint_test_xfer_param param;
 	bool ret = false;
+	u32 flags = 0;
+	bool use_dma;
+	size_t size;
 	void *addr;
 	dma_addr_t phys_addr;
 	struct pci_dev *pdev = test->pdev;
@@ -526,10 +572,22 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	size_t offset;
 	size_t alignment = test->alignment;
 	u32 crc32;
+	int err;
 
+	err = copy_from_user(&param, (void *)arg, sizeof(param));
+	if (err) {
+		dev_err(dev, "Failed to get transfer param\n");
+		return false;
+	}
+
+	size = param.size;
 	if (size > SIZE_MAX - alignment)
 		goto err;
 
+	use_dma = param.use_dma;
+	if (use_dma)
+		flags |= FLAG_USE_DMA;
+
 	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		goto err;
@@ -566,6 +624,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-- 
2.17.1

