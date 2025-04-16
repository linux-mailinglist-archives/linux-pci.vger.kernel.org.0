Return-Path: <linux-pci+bounces-26001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2794A9068C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 16:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC46E3BA705
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595E1C4A10;
	Wed, 16 Apr 2025 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHJL29tL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018041AAA1C
	for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813711; cv=none; b=OB7x+mAsrbHpbGj2EXUMZUTQNME0EMVgx5s2HTQE3E8sVkgwG3FldgxYcnYUH+Ez/z8eRzEnQp1361sBNLSE+ABG6dxQTRUUZqFA0g2TgeRElc/THdk67jZQ05HNYPPnNeMPS7A/7U4R8xdlWdkVBqef+lBysxucquSTDT7qxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813711; c=relaxed/simple;
	bh=ddyj+0QoVnWwPTSXOB25OsEt0lLqybWfpDsgS0PnYUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/XxLmdYT0JD04cehJkP7I3eJmSqbeGXr200W5qY0GDMwTqjw4CGSDRraIpkBP9nN27EQtMxk8hKIjDf9uv+t3c9CuDqis7MKuKHvsZFXB/PUmv5Yzqb3p2tNv99W4zRohptVzAiP/ve/omMO735sOzXe2GcZWPlMMjNIkBUA+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHJL29tL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC619C4CEEC;
	Wed, 16 Apr 2025 14:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813710;
	bh=ddyj+0QoVnWwPTSXOB25OsEt0lLqybWfpDsgS0PnYUc=;
	h=From:To:Cc:Subject:Date:From;
	b=rHJL29tL3ffBeTCMdZu13yQfJGBwKq0kBbDxKO0zwYreqJUIDWJ7ntvuXZV2rqHt3
	 yVZoS8Xvll6dt9zmYz6FJ11iR9xQAPSybqHTlObNCGOZu02bJ4oEsQj4D0po5TWAAN
	 Ze3wuVUEgLqYrJ1j1PVAYj3l/h+VGpZ3kWZdI7ii7d0GoH6B4rsN0eUMPV20QMMiNX
	 9pPK+nruFbmq3JwSIRGrgLI2AiZlqgijHtpoFxnkjx9fB1EcBqmzR6QdofyLFU+Yv6
	 M9mwEMAaBsp8ryELEZTGVHGgkqdOoauS4XpfV5/tTwocPowV0cXxOOLzKlxB1lNlG0
	 M4d1Dd27WA9IA==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH RESEND] misc: pci_endpoint_test: Defer IRQ allocation until ioctl(PCITEST_SET_IRQTYPE)
Date: Wed, 16 Apr 2025 16:28:26 +0200
Message-ID: <20250416142825.336554-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4769; i=cassel@kernel.org; h=from:subject; bh=ddyj+0QoVnWwPTSXOB25OsEt0lLqybWfpDsgS0PnYUc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL/7+ssTPY7vm/3ZGmnRSFl/qeyFaNCLFQeBTTulNi92 +fhtbv2HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiIZwjD/5zF2tdN/Jasex9T rpHf/ckpx6OiROrlj3TXswrdZrmavxkZVkueYLlX+rUnPiXs2VX+S3dYNKZrqViZVbH0WRlMFqn kAQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit a402006d48a9 ("misc: pci_endpoint_test: Remove global 'irq_type'
and 'no_msi'") changed so that the default IRQ vector requested by
pci_endpoint_test_probe() was no longer the module param 'irq_type',
but instead test->irq_type. test->irq_type is by default
IRQ_TYPE_UNDEFINED (until someone calls ioctl(PCITEST_SET_IRQTYPE)).

However, the commit also changed so that after initializing test->irq_type
to IRQ_TYPE_UNDEFINED, it also overrides it with driver_data->irq_type, if
the PCI device and vendor ID provides driver_data.

This causes a regression for PCI device and vendor IDs that do not provide
driver_data, and the driver now fails to probe on such platforms.

Considering that the pci endpoint selftests and the old pcitest.sh always
call ioctl(PCITEST_SET_IRQTYPE) before performing any test that requires
IRQs, simply remove the allocation of IRQs in pci_endpoint_test_probe(),
and defer it until ioctl(PCITEST_SET_IRQTYPE) has been called.

A positive side effect of this is that even if the endpoint controller has
issues with IRQs, the user can do still do all the tests/ioctls() that do
not require working IRQs, e.g. PCITEST_BAR and PCITEST_BARS.

This also means that we can remove the now unused irq_type from
driver_data. The irq_type will always be the one configured by the user
using ioctl(PCITEST_SET_IRQTYPE). (A user that does not know, or care
which irq_type that is used, can use PCITEST_IRQ_TYPE_AUTO. This has
superseded the need for a default irq_type in driver_data.)

Fixes: a402006d48a9c ("misc: pci_endpoint_test: Remove global 'irq_type' and 'no_msi'")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-and-tested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d294850a35a1..c4e5e2c977be 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -122,7 +122,6 @@ struct pci_endpoint_test {
 struct pci_endpoint_test_data {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
-	int irq_type;
 };
 
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
@@ -948,7 +947,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		test_reg_bar = data->test_reg_bar;
 		test->test_reg_bar = test_reg_bar;
 		test->alignment = data->alignment;
-		test->irq_type = data->irq_type;
 	}
 
 	init_completion(&test->irq_raised);
@@ -970,10 +968,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	ret = pci_endpoint_test_alloc_irq_vectors(test, test->irq_type);
-	if (ret)
-		goto err_disable_irq;
-
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
 			base = pci_ioremap_bar(pdev, bar);
@@ -1009,10 +1003,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		goto err_ida_remove;
 	}
 
-	ret = pci_endpoint_test_request_irq(test);
-	if (ret)
-		goto err_kfree_test_name;
-
 	pci_endpoint_test_get_capabilities(test);
 
 	misc_device = &test->miscdev;
@@ -1020,7 +1010,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	misc_device->name = kstrdup(name, GFP_KERNEL);
 	if (!misc_device->name) {
 		ret = -ENOMEM;
-		goto err_release_irq;
+		goto err_kfree_test_name;
 	}
 	misc_device->parent = &pdev->dev;
 	misc_device->fops = &pci_endpoint_test_fops;
@@ -1036,9 +1026,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 err_kfree_name:
 	kfree(misc_device->name);
 
-err_release_irq:
-	pci_endpoint_test_release_irq(test);
-
 err_kfree_test_name:
 	kfree(test->name);
 
@@ -1051,8 +1038,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 
-err_disable_irq:
-	pci_endpoint_test_free_irq_vectors(test);
 	pci_release_regions(pdev);
 
 err_disable_pdev:
@@ -1092,23 +1077,19 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 static const struct pci_endpoint_test_data default_data = {
 	.test_reg_bar = BAR_0,
 	.alignment = SZ_4K,
-	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 static const struct pci_endpoint_test_data am654_data = {
 	.test_reg_bar = BAR_2,
 	.alignment = SZ_64K,
-	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 static const struct pci_endpoint_test_data j721e_data = {
 	.alignment = 256,
-	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 static const struct pci_endpoint_test_data rk3588_data = {
 	.alignment = SZ_64K,
-	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 /*
-- 
2.49.0


