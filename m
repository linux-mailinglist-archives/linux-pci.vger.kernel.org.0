Return-Path: <linux-pci+bounces-25138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF7A78A6C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 10:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF7B1893E29
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AE6236446;
	Wed,  2 Apr 2025 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbVbxpQb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C18E236441
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584231; cv=none; b=O1dE71hctBQaDMaUjz3XiupxZzMwbpaN2JZCi4yKbnojcKS1x4L8NzDSaBko+Vs+NXzugqI9Cj5zCAZvlCAgy4sL364hKlqz+456rQTo38AEEgLNcFofJPl4BX+87ZUntvP2CsQobsBxxEEPKqGT+/JnDi9rh6Od0K0ASVLLDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584231; c=relaxed/simple;
	bh=VvJId/bHJAZ0RBu3uwHXKqN6HbYGvuBS7FB//yIo3WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8ZjVD7FvUO3I9xEA3oSUVvs02t/NHJ0uen5jrcI31sPVuwOTQZb+RCQYs8OJIomD6phDnHiqWu54PkFgP7QNCghbgFjZvz4UgY0g+A5hzBcCRR8azjTULFo/M1Nn9OwlvLQT6E3imwNMv0/hFHA/c8LWkVc0OkHgwoz2doGk+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbVbxpQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4291C4CEEF;
	Wed,  2 Apr 2025 08:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743584229;
	bh=VvJId/bHJAZ0RBu3uwHXKqN6HbYGvuBS7FB//yIo3WQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EbVbxpQbanNxzXrjLYUTNKqBHW5Vpn4mBuGUvBzjGLcuoup3CNT2aOJJcPsNGROpJ
	 by5wO2E2nB2l0RcfSLM/wsVN/6hMJnZfoyJ/JTpDwxAm/f/5Ui3sDMwhFyDSQlmw6m
	 oWhu4a+QGozRsvsoHv7JxSBCkdCuiBmMRJ02Nlc00kxNFkbzFSKjdkarmqzGh6tMGt
	 /XAqAxUz1QVcp2n3Ps5eToWGwjAfXY3R1IMv13yNTvj1i2F0WQqNi7UDgLnzK0Agr6
	 wXtEVK+rMKtQ7xmUEhipVUWyPWHSldx9OL0+M3OMx9sWsVPpgpf3FCI1Dr7v2Ru4m4
	 /QNHn59qBhvbQ==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] misc: pci_endpoint_test: Defer IRQ allocation until ioctl(PCITEST_SET_IRQTYPE)
Date: Wed,  2 Apr 2025 10:57:00 +0200
Message-ID: <20250402085659.4033434-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4642; i=cassel@kernel.org; h=from:subject; bh=VvJId/bHJAZ0RBu3uwHXKqN6HbYGvuBS7FB//yIo3WQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLf/L5temZDZnL/aq076QkvfDazy12e/cfeLWl2fujxG t6UC8qPOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjAR7kxGhi8PHfLSd3gIMiWI eOYxHHSyl3+625XnY8G0GdvEuR+VnGFkmCP+mv//S+vPupUML9bMqD101/VMsoG+odikjktKCfz 72AE=
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

Considering that the pci endpoint selftests and the old pcitest always
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


