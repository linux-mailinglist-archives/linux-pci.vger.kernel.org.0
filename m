Return-Path: <linux-pci+bounces-24037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B503A67162
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 11:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18B63B340A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31AE20767C;
	Tue, 18 Mar 2025 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh9jS0ou"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF166202997
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294089; cv=none; b=pG3W4LVIGLKPxaK6sMUx0j5thPKG+qbmtQLAUr1rrceruwEH1AbTg/YBG4kRSCje2ZtzMNjaaYwDLTsLWl/zCt4pq6K3XQ8ce3YNvudirRsBWMwXiRvdZ7oFesH8+4qdbrj/vI32xPQnJrY+xLc+3Dy9jmC2n2dhaB/dBs2fl1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294089; c=relaxed/simple;
	bh=EKdt3QSmiArJ8pbCm74mjgT16Ha4NGqGMBHjmTz/JvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lz0zq6X1db1ND6HhdLEShF/P18MTpdrlij2lncvWQE6z6q6B/adUI2YuijWSL883SOwCpRSxlF0bjOecIAtsEEXmWauvoDVhnLm7j7ryU0Si6Bel4lTSo/uLbNFjO9aorNTZz+DZ1vwVJ4K0L7+Z0CCzmlQFd9Z3FMqvEqRgrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh9jS0ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2DAC4CEE3;
	Tue, 18 Mar 2025 10:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294089;
	bh=EKdt3QSmiArJ8pbCm74mjgT16Ha4NGqGMBHjmTz/JvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nh9jS0ouxFkwvV2QQqGsVWU7Y+3VCN6CZycXAvirjOLMAXByGvXHOfG8YoUnm+xjw
	 sVmQczKLeWKh2dfIrQi32w8kCOT1qiu4FQuSLjun03SE2o+hr6vIUjzDlsTbrADLPx
	 ESoZMn9+smaERxJSR6oA7IaEc2vFIzdp63HAxsm2UWDoNlkFwo/vA3Tx7viblh2OFW
	 iKBv8Ks9MmLUVkSOss2yAhGc51gLCArYh/eE6iiumxf8wFlJ9WuaSFsRgGKWPR11es
	 JnkZPT6FRqhCKEi2SJ+gnu3cV/ePumS8ajmfh/0qaM1fstPzq+2F1FBMBuQOeRla9i
	 +Z+4aEkBYS0Vg==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 4/4] selftests: pci_endpoint: Remove PCITEST_SET_IRQTYPE ioctls for read/write/copy
Date: Tue, 18 Mar 2025 11:33:35 +0100
Message-ID: <20250318103330.1840678-10-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318103330.1840678-6-cassel@kernel.org>
References: <20250318103330.1840678-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2042; i=cassel@kernel.org; h=from:subject; bh=EKdt3QSmiArJ8pbCm74mjgT16Ha4NGqGMBHjmTz/JvA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJvev//w1V74E5Ngn7S9UWTdr7zv7JCJcY1IlTytLLqc h+l2ydLOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRjCJGhut7Jn2X8DmxK/au a+jvdKk4t8wpzy8Kb3yQtvzYzYu3GLgY/hdF312kY2Xy9Y8OW51A0qGFc/Iv8xb0+m/bcacr1J7 hBQcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The test cases for read/write/copy currently do:
1) ioctl(PCITEST_SET_IRQTYPE)
2) ioctl(PCITEST_{READ,WRITE,COPY})

The PCITEST_{READ,WRITE,COPY} ioctls now configure the IRQ type to use
themselves, ignoring any value configured by the user via
ioctl(PCITEST_SET_IRQTYPE).

Since PCITEST_{READ,WRITE,COPY} ioctls will ignore the IRQ type set by the
user, remove the ioctl(PCITEST_SET_IRQTYPE), as it has no effect on the
result of the test case.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index fdf4bc6aa9d2a..e788ab4eb003e 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -181,9 +181,6 @@ TEST_F(pci_ep_data_transfer, READ_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
-	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
-
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
 		param.size = test_size[i];
 		pci_ep_ioctl(PCITEST_READ, &param);
@@ -200,9 +197,6 @@ TEST_F(pci_ep_data_transfer, WRITE_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
-	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
-
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
 		param.size = test_size[i];
 		pci_ep_ioctl(PCITEST_WRITE, &param);
@@ -219,9 +213,6 @@ TEST_F(pci_ep_data_transfer, COPY_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
-	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
-
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
 		param.size = test_size[i];
 		pci_ep_ioctl(PCITEST_COPY, &param);
-- 
2.48.1


