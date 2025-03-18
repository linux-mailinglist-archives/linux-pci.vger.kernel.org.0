Return-Path: <linux-pci+bounces-24036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA01A6715F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 11:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42AB1899F6F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ACC20469A;
	Tue, 18 Mar 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irY7L6qz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0E202997
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294087; cv=none; b=JfqymMo8Nbhj/zmMWkSH1o32LZ56dWRpCUyfsCqxBNOIoj+ip8BGIudaqM9SovjG/9WtCSyDyJNaGWagcBUFCDnj/DLz94nHbTK/zLfIPic3uPXmL2v1BWgQnGASfAzu/YDxxEBxf7MwVp4MJaWYdh6tSvTrLh+A071+nw1xEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294087; c=relaxed/simple;
	bh=Wi/+WPCv9YnzjLMK4r8AZm+W8OVyqzF5D4rGYKI6VwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbVSgmE/A14zSe7y5NupPjX8qm9L0LBTgxUqJ3CZBbEJGRu1LLmPXnPfFm++sZeDJHzg0QcySqg2kWjqu9uFGfVx0Qz42wgP9ooGwkQU6GsnuwBoXbqSH/WvaPK22PAj5QDnGY4ghBLbFPyaYfT1rWbYd1ok7wfN2UihUS88KHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irY7L6qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB36C4CEEF;
	Tue, 18 Mar 2025 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294087;
	bh=Wi/+WPCv9YnzjLMK4r8AZm+W8OVyqzF5D4rGYKI6VwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irY7L6qzzwuRilvJaKNtoxdl7NoBSXkGZA2GvsCwnxDtpup8rJFVU34WG/6m8puAq
	 RLv4I8wPhpjmGDISbAz01vnZfNsR+NCznOb+7XiyezdP8TTon341RAz+l8qbjKtctG
	 HnZvXQHaJKy2DVYeDoJL1KpmwSetyEp7AVGXeYWHDaGFJDbxmr6v5lNuFsrzpy7k5a
	 eTBtdNh4x3slb6FA+3Ad0gbo1OlDA1tj+QFvyVry0P3tJEgEd6ySeh4sLjr1l5unDh
	 WGmuV7ICXx0lTzEUXM54D/squGFNuVq3r1vfxI43lib8nw4hNb7lWtygsukBAvQYCE
	 bNezlA2/mDkew==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 3/4] misc: pci_endpoint_test: Let PCITEST_{READ,WRITE,COPY} set IRQ type automatically
Date: Tue, 18 Mar 2025 11:33:34 +0100
Message-ID: <20250318103330.1840678-9-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318103330.1840678-6-cassel@kernel.org>
References: <20250318103330.1840678-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6120; i=cassel@kernel.org; h=from:subject; bh=Wi/+WPCv9YnzjLMK4r8AZm+W8OVyqzF5D4rGYKI6VwQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJvev9r+jgtIGXecpOeCQvz1Ux1vBz6Zh57EVf6+u+hy jeRoVqsHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjInXaGf9reW+bxpSytjP7l HK/AWLZKSSemOk1D3Z9z/1VZ5bNrChkZ5i4s/fbzZPVmG6Hu6P2Rr9k798Vde9/BUrBx1i8RZpU 33AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The test cases for read/write/copy currently do:
1) ioctl(PCITEST_SET_IRQTYPE, MSI)
2) ioctl(PCITEST_{READ,WRITE,COPY})

This design is quite bad for a few reasons:
-It assumes that all PCI EPCs support MSI.
-One ioctl should be sufficient for these test cases.

Modify the PCITEST_{READ,WRITE,COPY} ioctls to set IRQ type automatically,
overwriting the currently configured IRQ type. It there are no IRQ types
supported in the CAPS register, fall back to MSI IRQs. This way the
implementation is no worse than before this commit.

Any test case that requires a specific IRQ type, e.g. MSIX_TEST, will do
an explicit PCITEST_SET_IRQTYPE ioctl at the start of the test case, thus
it is safe to always overwrite the configured IRQ type.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 126 +++++++++++++++++--------------
 1 file changed, 68 insertions(+), 58 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3c04121d24733..cfaeeea7642ac 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -464,6 +464,62 @@ static int pci_endpoint_test_validate_xfer_params(struct device *dev,
 	return 0;
 }
 
+static int pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
+{
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+
+	return 0;
+}
+
+static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
+				      int req_irq_type)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	if (req_irq_type < PCITEST_IRQ_TYPE_INTX ||
+	    req_irq_type > PCITEST_IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return -EINVAL;
+	}
+
+	if (test->irq_type == req_irq_type)
+		return 0;
+
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+
+	ret = pci_endpoint_test_alloc_irq_vectors(test, req_irq_type);
+	if (ret)
+		return ret;
+
+	ret = pci_endpoint_test_request_irq(test);
+	if (ret) {
+		pci_endpoint_test_free_irq_vectors(test);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pci_endpoint_test_set_auto_irq(struct pci_endpoint_test *test,
+					  int *irq_type)
+{
+	if (test->ep_caps & CAP_MSI)
+		*irq_type = PCITEST_IRQ_TYPE_MSI;
+	else if (test->ep_caps & CAP_MSIX)
+		*irq_type = PCITEST_IRQ_TYPE_MSIX;
+	else if (test->ep_caps & CAP_INTX)
+		*irq_type = PCITEST_IRQ_TYPE_INTX;
+	else
+		/* fallback to MSI if no caps defined */
+		*irq_type = PCITEST_IRQ_TYPE_MSI;
+
+	return pci_endpoint_test_set_irq(test, *irq_type);
+}
+
 static int pci_endpoint_test_copy(struct pci_endpoint_test *test,
 				   unsigned long arg)
 {
@@ -483,7 +539,7 @@ static int pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	dma_addr_t orig_dst_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
-	int irq_type = test->irq_type;
+	int irq_type;
 	u32 src_crc32;
 	u32 dst_crc32;
 	int ret;
@@ -504,11 +560,9 @@ static int pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
 
-	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
-	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		return -EINVAL;
-	}
+	ret = pci_endpoint_test_set_auto_irq(test, &irq_type);
+	if (ret)
+		return ret;
 
 	orig_src_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_src_addr) {
@@ -616,7 +670,7 @@ static int pci_endpoint_test_write(struct pci_endpoint_test *test,
 	dma_addr_t orig_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
-	int irq_type = test->irq_type;
+	int irq_type;
 	size_t size;
 	u32 crc32;
 	int ret;
@@ -637,11 +691,9 @@ static int pci_endpoint_test_write(struct pci_endpoint_test *test,
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
 
-	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
-	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		return -EINVAL;
-	}
+	ret = pci_endpoint_test_set_auto_irq(test, &irq_type);
+	if (ret)
+		return ret;
 
 	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_addr) {
@@ -714,7 +766,7 @@ static int pci_endpoint_test_read(struct pci_endpoint_test *test,
 	dma_addr_t orig_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
-	int irq_type = test->irq_type;
+	int irq_type;
 	u32 crc32;
 	int ret;
 
@@ -734,11 +786,9 @@ static int pci_endpoint_test_read(struct pci_endpoint_test *test,
 	if (use_dma)
 		flags |= FLAG_USE_DMA;
 
-	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
-	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		return -EINVAL;
-	}
+	ret = pci_endpoint_test_set_auto_irq(test, &irq_type);
+	if (ret)
+		return ret;
 
 	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_addr) {
@@ -790,46 +840,6 @@ static int pci_endpoint_test_read(struct pci_endpoint_test *test,
 	return ret;
 }
 
-static int pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
-{
-	pci_endpoint_test_release_irq(test);
-	pci_endpoint_test_free_irq_vectors(test);
-
-	return 0;
-}
-
-static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
-				      int req_irq_type)
-{
-	struct pci_dev *pdev = test->pdev;
-	struct device *dev = &pdev->dev;
-	int ret;
-
-	if (req_irq_type < PCITEST_IRQ_TYPE_INTX ||
-	    req_irq_type > PCITEST_IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		return -EINVAL;
-	}
-
-	if (test->irq_type == req_irq_type)
-		return 0;
-
-	pci_endpoint_test_release_irq(test);
-	pci_endpoint_test_free_irq_vectors(test);
-
-	ret = pci_endpoint_test_alloc_irq_vectors(test, req_irq_type);
-	if (ret)
-		return ret;
-
-	ret = pci_endpoint_test_request_irq(test);
-	if (ret) {
-		pci_endpoint_test_free_irq_vectors(test);
-		return ret;
-	}
-
-	return 0;
-}
-
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
-- 
2.48.1


