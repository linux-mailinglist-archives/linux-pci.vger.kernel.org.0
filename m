Return-Path: <linux-pci+bounces-23307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F79A59253
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 12:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74B616BA58
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF71226D12;
	Mon, 10 Mar 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="se0j7C0p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669BA226CF3
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605057; cv=none; b=u6KMhHXZrPuXnxDmhbXxI3gqcwqMkWiJztUcz2hbwLcGrzz7Co8e7C26dRa2nY1KAVN19bWh8zZn8BvYFD5vsiADRjYuxKJFKBVD9WL5ozn70Yhpn/0ZSWdEZZfINmTgPw5FDNY/jRlWzYNWcYThhUdfUEs+wkB9YIzyP8PX4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605057; c=relaxed/simple;
	bh=juce22VaNhSYxWpsQQ0/fJzfS3VarwxZrVt+ZJyTAFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BK5qQddNN/gresp2gQlPmEyJsTHVKGnCxw/z8hTRvjM+zwG4doyzY86PlTUidnM5mMV7RU2zYzPIGRagxNTdK8dKalDxii743NWEQ52YXQDLHaj+k+Qc0fC4jmFirHm3OJL5nh3zG2NCrJkebFlQlree8QvHTCWAxBBT4Rs4QiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=se0j7C0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4C8C4CEEE;
	Mon, 10 Mar 2025 11:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741605056;
	bh=juce22VaNhSYxWpsQQ0/fJzfS3VarwxZrVt+ZJyTAFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=se0j7C0p3YDIEDwgGqphVqYtaGVC/JI1Y8ZJUPjwG6SwBzCxFkKKxZ+byOw+iZBNM
	 9hjZ9w4vmOmeoyER5wiRFJihAi6exCrwA8nAuO12wvXGs0qee7GuXlGlUY828cjwvS
	 Uyj527zeWRDfsMt/hK+tlCWBuG3t4u+K5Jwitrsv0WbpJfQtYtYWfCfnztVP+ms2fu
	 f7eGNjWtUEpBPjPKKNSnjm4hnFA0d9WYEGTf5y8Vz0kC25UVOox/v/uiYK4BLIdBCU
	 d0riyv1tWLdMNqdRo638AxRCw42okSTRYhg7EbFV/+/F/1nCSf6L2ip4ESCrdRHl5Y
	 Vtsq18dBiuqKA==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 3/7] selftests: pci_endpoint: Use IRQ_TYPE_* defines from UAPI header
Date: Mon, 10 Mar 2025 12:10:20 +0100
Message-ID: <20250310111016.859445-12-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310111016.859445-9-cassel@kernel.org>
References: <20250310111016.859445-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3125; i=cassel@kernel.org; h=from:subject; bh=juce22VaNhSYxWpsQQ0/fJzfS3VarwxZrVt+ZJyTAFg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLPnZh3XnI3d7Gs653E1dtKz2aIPo8L7L9iusq9ddFVx fv5M82VO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARazOGv6JVXW1dl3cI3tl1 ++tn8xCbs1sEZ/8qn9wYI+Rc4rn5kwMjw6GL1U2HZ+zosUgLmr7J55+v+5M9vTwFETvOyGqvrRT 15AMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

In order to improve readability, use the IRQ_TYPE_* defines from the UAPI
header rather than using raw values.

No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../selftests/pci_endpoint/pci_endpoint_test.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index d05e107d0698..fdf4bc6aa9d2 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -99,11 +99,11 @@ TEST_F(pci_ep_basic, LEGACY_IRQ_TEST)
 {
 	int ret;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 0);
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_INTX);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set Legacy IRQ type");
 
 	pci_ep_ioctl(PCITEST_GET_IRQTYPE, 0);
-	ASSERT_EQ(0, ret) TH_LOG("Can't get Legacy IRQ type");
+	ASSERT_EQ(PCITEST_IRQ_TYPE_INTX, ret) TH_LOG("Can't get Legacy IRQ type");
 
 	pci_ep_ioctl(PCITEST_LEGACY_IRQ, 0);
 	EXPECT_FALSE(ret) TH_LOG("Test failed for Legacy IRQ");
@@ -113,11 +113,11 @@ TEST_F(pci_ep_basic, MSI_TEST)
 {
 	int ret, i;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
 
 	pci_ep_ioctl(PCITEST_GET_IRQTYPE, 0);
-	ASSERT_EQ(1, ret) TH_LOG("Can't get MSI IRQ type");
+	ASSERT_EQ(PCITEST_IRQ_TYPE_MSI, ret) TH_LOG("Can't get MSI IRQ type");
 
 	for (i = 1; i <= 32; i++) {
 		pci_ep_ioctl(PCITEST_MSI, i);
@@ -129,11 +129,11 @@ TEST_F(pci_ep_basic, MSIX_TEST)
 {
 	int ret, i;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 2);
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSIX);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI-X IRQ type");
 
 	pci_ep_ioctl(PCITEST_GET_IRQTYPE, 0);
-	ASSERT_EQ(2, ret) TH_LOG("Can't get MSI-X IRQ type");
+	ASSERT_EQ(PCITEST_IRQ_TYPE_MSIX, ret) TH_LOG("Can't get MSI-X IRQ type");
 
 	for (i = 1; i <= 2048; i++) {
 		pci_ep_ioctl(PCITEST_MSIX, i);
@@ -181,7 +181,7 @@ TEST_F(pci_ep_data_transfer, READ_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
 
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
@@ -200,7 +200,7 @@ TEST_F(pci_ep_data_transfer, WRITE_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
 
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
@@ -219,7 +219,7 @@ TEST_F(pci_ep_data_transfer, COPY_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
 
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
-- 
2.48.1


