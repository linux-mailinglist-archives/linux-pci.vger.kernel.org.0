Return-Path: <linux-pci+bounces-23306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB47A59252
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 12:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF8A16B56B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DED226D08;
	Mon, 10 Mar 2025 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFDr5iCB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F728EA
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605055; cv=none; b=t5/Nx4g1nksZiONNOX6FW8hVFXX6Me1JL1qhPplrigHFa2+jnPZ05thUIsMqTL0lbAthdbKyzl24HpCdT/MietmouqY+7QxIQnhb0TkNwCyJsASRwVHGAF+EoUmPBMYrdSGpwdsRjA/T4PFi8OnKfazPJcb36Wvxf+y4VYu7z2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605055; c=relaxed/simple;
	bh=QxYKR2lxbSzV8kEj3MZitH3JX2jgAUVMNNRanilkk4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1rF43DeOHitfqJeVqlI3CakAgsBsPQexx9uzyAmVc/LOLMnq9GpEf5bFSDWknt+TsYTloHAnk3GncQHwXK7TKkuyw6YDGCZjIt+6htfdUpoDCtJ/Qn1PUu2XVPYuoiKienUN/HTwkX+rlPKNPlPgonug81Cv1NcFm5yogS0xx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFDr5iCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87FCC4AF09;
	Mon, 10 Mar 2025 11:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741605054;
	bh=QxYKR2lxbSzV8kEj3MZitH3JX2jgAUVMNNRanilkk4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFDr5iCBQflVlE263e6/6geAcxbku67r/TwyZsZZcwqNCY1Am8yTSjDsfjjp+BpPS
	 VGln///qNfJNNc7hC7npPmTLnUY67l52XYMI0Te0PXxOcInd2klmeupK7cLw8dIYZR
	 PJo6+I0ZNAlkDbyKZ6GfTmcJeErMGGGlPPi79hYkruSAc0oJeEHd5Mf2vIOdwHSCr2
	 diEdgTZcQ56U8MtU7GkHx3boRCW+2+srj1HReOczAABi+6KVuvOk3TnNqbWAADO/WY
	 FsedxlOjqSXHp3EbezEnBMlE0TwMjYih7w5/Ckptftl7c5s6ai0E/YHAT6iGpPmX8+
	 B1ln6CG26uFdg==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/7] misc: pci_endpoint_test: Use IRQ_TYPE_* defines from UAPI header
Date: Mon, 10 Mar 2025 12:10:19 +0100
Message-ID: <20250310111016.859445-11-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310111016.859445-9-cassel@kernel.org>
References: <20250310111016.859445-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6102; i=cassel@kernel.org; h=from:subject; bh=QxYKR2lxbSzV8kEj3MZitH3JX2jgAUVMNNRanilkk4c=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLPnZi35JJlY7izy6Se6LDkJa+4d7dc8eraw6+XM+l+n 9tKRtavHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhIyGGGf3rns18fPL3p9Y5J yVll6V+OK/MWccs7d7FdzJVk9RA4XM/IMHnyyotht2cvellkoTXJfvvRGV/+Xf79T2PhonkRaxc JnuIHAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Use the IRQ_TYPE_* defines from the UAPI header rather than duplicating
these defines in the driver itself.

No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 46 ++++++++++++++++----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index e3d9638b7a1b..849d730ba14d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -28,11 +28,6 @@
 
 #define DRV_MODULE_NAME				"pci-endpoint-test"
 
-#define IRQ_TYPE_UNDEFINED			-1
-#define IRQ_TYPE_INTX				0
-#define IRQ_TYPE_MSI				1
-#define IRQ_TYPE_MSIX				2
-
 #define PCI_ENDPOINT_TEST_MAGIC			0x0
 
 #define PCI_ENDPOINT_TEST_COMMAND		0x4
@@ -157,7 +152,7 @@ static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
 	struct pci_dev *pdev = test->pdev;
 
 	pci_free_irq_vectors(pdev);
-	test->irq_type = IRQ_TYPE_UNDEFINED;
+	test->irq_type = PCITEST_IRQ_TYPE_UNDEFINED;
 }
 
 static int pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
@@ -168,7 +163,7 @@ static int pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
 	struct device *dev = &pdev->dev;
 
 	switch (type) {
-	case IRQ_TYPE_INTX:
+	case PCITEST_IRQ_TYPE_INTX:
 		irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
 		if (irq < 0) {
 			dev_err(dev, "Failed to get Legacy interrupt\n");
@@ -176,7 +171,7 @@ static int pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
 		}
 
 		break;
-	case IRQ_TYPE_MSI:
+	case PCITEST_IRQ_TYPE_MSI:
 		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
 		if (irq < 0) {
 			dev_err(dev, "Failed to get MSI interrupts\n");
@@ -184,7 +179,7 @@ static int pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
 		}
 
 		break;
-	case IRQ_TYPE_MSIX:
+	case PCITEST_IRQ_TYPE_MSIX:
 		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
 		if (irq < 0) {
 			dev_err(dev, "Failed to get MSI-X interrupts\n");
@@ -233,16 +228,16 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 
 fail:
 	switch (test->irq_type) {
-	case IRQ_TYPE_INTX:
+	case PCITEST_IRQ_TYPE_INTX:
 		dev_err(dev, "Failed to request IRQ %d for Legacy\n",
 			pci_irq_vector(pdev, i));
 		break;
-	case IRQ_TYPE_MSI:
+	case PCITEST_IRQ_TYPE_MSI:
 		dev_err(dev, "Failed to request IRQ %d for MSI %d\n",
 			pci_irq_vector(pdev, i),
 			i + 1);
 		break;
-	case IRQ_TYPE_MSIX:
+	case PCITEST_IRQ_TYPE_MSIX:
 		dev_err(dev, "Failed to request IRQ %d for MSI-X %d\n",
 			pci_irq_vector(pdev, i),
 			i + 1);
@@ -408,7 +403,7 @@ static int pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
 	u32 val;
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
-				 IRQ_TYPE_INTX);
+				 PCITEST_IRQ_TYPE_INTX);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 0);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
 				 COMMAND_RAISE_INTX_IRQ);
@@ -428,7 +423,8 @@ static int pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	int ret;
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
-				 msix ? IRQ_TYPE_MSIX : IRQ_TYPE_MSI);
+				 msix ? PCITEST_IRQ_TYPE_MSIX :
+				 PCITEST_IRQ_TYPE_MSI);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, msi_num);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
 				 msix ? COMMAND_RAISE_MSIX_IRQ :
@@ -504,7 +500,8 @@ static int pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
 
-	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
+	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
+	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		return -EINVAL;
 	}
@@ -636,7 +633,8 @@ static int pci_endpoint_test_write(struct pci_endpoint_test *test,
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
 
-	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
+	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
+	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		return -EINVAL;
 	}
@@ -732,7 +730,8 @@ static int pci_endpoint_test_read(struct pci_endpoint_test *test,
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
 
-	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
+	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
+	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		return -EINVAL;
 	}
@@ -802,7 +801,8 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	if (req_irq_type < IRQ_TYPE_INTX || req_irq_type > IRQ_TYPE_MSIX) {
+	if (req_irq_type < PCITEST_IRQ_TYPE_INTX ||
+	    req_irq_type > PCITEST_IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		return -EINVAL;
 	}
@@ -926,7 +926,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	test->test_reg_bar = 0;
 	test->alignment = 0;
 	test->pdev = pdev;
-	test->irq_type = IRQ_TYPE_UNDEFINED;
+	test->irq_type = PCITEST_IRQ_TYPE_UNDEFINED;
 
 	data = (struct pci_endpoint_test_data *)ent->driver_data;
 	if (data) {
@@ -1077,23 +1077,23 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 static const struct pci_endpoint_test_data default_data = {
 	.test_reg_bar = BAR_0,
 	.alignment = SZ_4K,
-	.irq_type = IRQ_TYPE_MSI,
+	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 static const struct pci_endpoint_test_data am654_data = {
 	.test_reg_bar = BAR_2,
 	.alignment = SZ_64K,
-	.irq_type = IRQ_TYPE_MSI,
+	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 static const struct pci_endpoint_test_data j721e_data = {
 	.alignment = 256,
-	.irq_type = IRQ_TYPE_MSI,
+	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 static const struct pci_endpoint_test_data rk3588_data = {
 	.alignment = SZ_64K,
-	.irq_type = IRQ_TYPE_MSI,
+	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 /*
-- 
2.48.1


