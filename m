Return-Path: <linux-pci+bounces-90-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B57F3DD9
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E392282B90
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D6815AD3;
	Wed, 22 Nov 2023 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkJmwnAX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A7B15AC4
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12EAC433C7;
	Wed, 22 Nov 2023 06:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633058;
	bh=/Gf0WUknW/2z1EK6qtpuC5tiaeE/tVUDT3HnAtPEdNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LkJmwnAXe4iB8j1HBuGccZR7efTUjV4at3J6B1MKegJoyEcBQ6/d7BI27c4bP1BAX
	 P6qR7cNCcqTHhl+feXIgkAeMfgkdjkmBJftKmJjHEm/RZs4Bv/DSBuo7ZkaaYpumqi
	 mqaaZPN/1d4GdSIqE4BpOxhzbZtjTv5RANa5ah7xLME36cIhfWSogzPbyyOLiA7YEc
	 CtiBw2ZI3SuYTu54pFjwNBVirzMpI9NmB6Z3MK31gGnaj6kpQgYzUV8Jiv8nkvDE+/
	 0NJPwhQkU4K1k44VxJXzjnq2urkynsHuJ0V5bOFy3VWEf6BrbiQzKAIaU6i14kyKOZ
	 OJ/6z2m59UEGw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 05/16] misc: pci_endpoint_test: Use INTX instead of LEGACY
Date: Wed, 22 Nov 2023 15:03:55 +0900
Message-ID: <20231122060406.14695-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the root complex pci endpoint test function driver, change macros and
functions names using the term "legacy" to use "intx" instead to
match the term used in the PCI specifications.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 30 +++++++++++++++---------------
 include/uapi/linux/pcitest.h     |  3 ++-
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index af519088732d..2d7822d9dfe9 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -28,14 +28,14 @@
 #define DRV_MODULE_NAME				"pci-endpoint-test"
 
 #define IRQ_TYPE_UNDEFINED			-1
-#define IRQ_TYPE_LEGACY				0
+#define IRQ_TYPE_INTX				0
 #define IRQ_TYPE_MSI				1
 #define IRQ_TYPE_MSIX				2
 
 #define PCI_ENDPOINT_TEST_MAGIC			0x0
 
 #define PCI_ENDPOINT_TEST_COMMAND		0x4
-#define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
+#define COMMAND_RAISE_INTX_IRQ			BIT(0)
 #define COMMAND_RAISE_MSI_IRQ			BIT(1)
 #define COMMAND_RAISE_MSIX_IRQ			BIT(2)
 #define COMMAND_READ				BIT(3)
@@ -183,8 +183,8 @@ static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
 	bool res = true;
 
 	switch (type) {
-	case IRQ_TYPE_LEGACY:
-		irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
+	case IRQ_TYPE_INTX:
+		irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
 		if (irq < 0)
 			dev_err(dev, "Failed to get Legacy interrupt\n");
 		break;
@@ -244,7 +244,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 
 fail:
 	switch (irq_type) {
-	case IRQ_TYPE_LEGACY:
+	case IRQ_TYPE_INTX:
 		dev_err(dev, "Failed to request IRQ %d for Legacy\n",
 			pci_irq_vector(pdev, i));
 		break;
@@ -291,15 +291,15 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	return true;
 }
 
-static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
+static bool pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
 {
 	u32 val;
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
-				 IRQ_TYPE_LEGACY);
+				 IRQ_TYPE_INTX);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 0);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_RAISE_LEGACY_IRQ);
+				 COMMAND_RAISE_INTX_IRQ);
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
@@ -385,7 +385,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
 
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		goto err;
 	}
@@ -521,7 +521,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
 
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		goto err;
 	}
@@ -621,7 +621,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
 
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		goto err;
 	}
@@ -691,7 +691,7 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
 
-	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
+	if (req_irq_type < IRQ_TYPE_INTX || req_irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		return false;
 	}
@@ -737,8 +737,8 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 			goto ret;
 		ret = pci_endpoint_test_bar(test, bar);
 		break;
-	case PCITEST_LEGACY_IRQ:
-		ret = pci_endpoint_test_legacy_irq(test);
+	case PCITEST_INTX_IRQ:
+		ret = pci_endpoint_test_intx_irq(test);
 		break;
 	case PCITEST_MSI:
 	case PCITEST_MSIX:
@@ -801,7 +801,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	test->irq_type = IRQ_TYPE_UNDEFINED;
 
 	if (no_msi)
-		irq_type = IRQ_TYPE_LEGACY;
+		irq_type = IRQ_TYPE_INTX;
 
 	data = (struct pci_endpoint_test_data *)ent->driver_data;
 	if (data) {
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index f9c1af8d141b..94b46b043b53 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -11,7 +11,8 @@
 #define __UAPI_LINUX_PCITEST_H
 
 #define PCITEST_BAR		_IO('P', 0x1)
-#define PCITEST_LEGACY_IRQ	_IO('P', 0x2)
+#define PCITEST_INTX_IRQ	_IO('P', 0x2)
+#define PCITEST_LEGACY_IRQ	PCITEST_INTX_IRQ
 #define PCITEST_MSI		_IOW('P', 0x3, int)
 #define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
 #define PCITEST_READ		_IOW('P', 0x5, unsigned long)
-- 
2.42.0


