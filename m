Return-Path: <linux-pci+bounces-24034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D78A67161
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 11:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC573BA0B4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08B6207DF1;
	Tue, 18 Mar 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlApfd5N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED9202997
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294083; cv=none; b=Hc+Cccj2cOo1VEsvCIyISF/RuydlpvwM020Y3LsQnkYtW7e9wJMZ0mR5gn9ZL0Vp+euGkpjX90OVQR0Ef4UDwXFIXvXweFYLHscshubWXmByfA2DszlUXHaSPpMYijZ9uzJmZseAg0rUykYFD9i5kWlQfmlOgmt+RlfN/P+SDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294083; c=relaxed/simple;
	bh=3voIixtwLTFprMVAMuattwaiVxrglfzHdTdJ4WNeJTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjwvsctuTFebJmWqklW/INIs1ihai+l0cMi985eZvE01iGVrhgpL5owkoQRzfl9FCe5B5fGwZxtEJBpYdnHV1lkjkfMbDM5ocuSHzuy2cNm9G2dXuKr/JQ5Zebe/5+T9fiW6PdaXlPXrwkV71PxxoihGJ+eigtv84MtQAzYjBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlApfd5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB16DC4CEE3;
	Tue, 18 Mar 2025 10:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294083;
	bh=3voIixtwLTFprMVAMuattwaiVxrglfzHdTdJ4WNeJTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlApfd5NJQU2aa5510/raBMqsLiX4hWAgdGYkXNP20oEgyuRpHDlsPC91KWlMXdTQ
	 hbhJP+2gOMajRJ85CQI2AmhQ3NKgb92DBT/uaEuzYIqeUyh7DuYi/2ewOEyAKV4pgF
	 Cmu8LFzgIqCb89OnhLIv/hE0Y5YuHoRT/pJ9iXnmuIYJfmkZu/lDq2TUgHVGB/42tz
	 Z5W367QgcQMoWVwx+0WdaWRsj358AnzjR/tFo5g7haItO4xPFg+sSTGOKyxOqubiyj
	 cVBNGufsr9/7iU5inWf9ODkxCIGWInDhWufFzNG3woTzFg/dNaUNyAtTvp05/g8G3b
	 pd1UdJe6dxvNQ==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/4] Revert "misc: pci_endpoint_test: Add support for PCITEST_IRQ_TYPE_AUTO"
Date: Tue, 18 Mar 2025 11:33:32 +0100
Message-ID: <20250318103330.1840678-7-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318103330.1840678-6-cassel@kernel.org>
References: <20250318103330.1840678-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4703; i=cassel@kernel.org; h=from:subject; bh=3voIixtwLTFprMVAMuattwaiVxrglfzHdTdJ4WNeJTw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJvev97MGON55sn29M4Hmd7L/t+k5VfYafGXG6+n9Z2h V8KfU2XdpSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiSV0M/1O1px1IPTXn2rJ1 +1lviZ5jFXzw+LvcMpOmjY+zQud3XEli+O/D0HydubHF9vuy0FLBmzMiPlotvZW0vd5Dcf5S7/N xLZwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This reverts commit c4aaa6b5b5ac14ea9b0abf1e0f4bf24c332a9b34.

The PCI endpoint maintainer did not like PCITEST_IRQ_TYPE_AUTO,
so let's remove this IRQ type and rework the implementation.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Hello PCI maintainers,
feel free to squash / drop the original commit from the branch.

 drivers/misc/pci_endpoint_test.c              | 25 ++++---------------
 include/uapi/linux/pcitest.h                  |  1 -
 .../pci_endpoint/pci_endpoint_test.c          | 12 ++++-----
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d294850a35a12..849d730ba14dd 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -66,9 +66,6 @@
 
 #define PCI_ENDPOINT_TEST_CAPS			0x30
 #define CAP_UNALIGNED_ACCESS			BIT(0)
-#define CAP_MSI					BIT(1)
-#define CAP_MSIX				BIT(2)
-#define CAP_INTX				BIT(3)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
@@ -115,7 +112,6 @@ struct pci_endpoint_test {
 	struct miscdevice miscdev;
 	enum pci_barno test_reg_bar;
 	size_t alignment;
-	u32 ep_caps;
 	const char *name;
 };
 
@@ -806,23 +802,11 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	int ret;
 
 	if (req_irq_type < PCITEST_IRQ_TYPE_INTX ||
-	    req_irq_type > PCITEST_IRQ_TYPE_AUTO) {
+	    req_irq_type > PCITEST_IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		return -EINVAL;
 	}
 
-	if (req_irq_type == PCITEST_IRQ_TYPE_AUTO) {
-		if (test->ep_caps & CAP_MSI)
-			req_irq_type = PCITEST_IRQ_TYPE_MSI;
-		else if (test->ep_caps & CAP_MSIX)
-			req_irq_type = PCITEST_IRQ_TYPE_MSIX;
-		else if (test->ep_caps & CAP_INTX)
-			req_irq_type = PCITEST_IRQ_TYPE_INTX;
-		else
-			/* fallback to MSI if no caps defined */
-			req_irq_type = PCITEST_IRQ_TYPE_MSI;
-	}
-
 	if (test->irq_type == req_irq_type)
 		return 0;
 
@@ -908,12 +892,13 @@ static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
 {
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
+	u32 caps;
 
-	test->ep_caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
-	dev_dbg(dev, "PCI_ENDPOINT_TEST_CAPS: %#x\n", test->ep_caps);
+	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
+	dev_dbg(dev, "PCI_ENDPOINT_TEST_CAPS: %#x\n", caps);
 
 	/* CAP_UNALIGNED_ACCESS is set if the EP can do unaligned access */
-	if (test->ep_caps & CAP_UNALIGNED_ACCESS)
+	if (caps & CAP_UNALIGNED_ACCESS)
 		test->alignment = 0;
 }
 
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index d3aa8715a525e..304bf9be0f9a0 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -27,7 +27,6 @@
 #define PCITEST_IRQ_TYPE_INTX		0
 #define PCITEST_IRQ_TYPE_MSI		1
 #define PCITEST_IRQ_TYPE_MSIX		2
-#define PCITEST_IRQ_TYPE_AUTO		3
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001
 
diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index ac26481d29d9d..fdf4bc6aa9d2a 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -181,8 +181,8 @@ TEST_F(pci_ep_data_transfer, READ_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
-	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
 
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
 		param.size = test_size[i];
@@ -200,8 +200,8 @@ TEST_F(pci_ep_data_transfer, WRITE_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
-	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
 
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
 		param.size = test_size[i];
@@ -219,8 +219,8 @@ TEST_F(pci_ep_data_transfer, COPY_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
-	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
 
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
 		param.size = test_size[i];
-- 
2.48.1


