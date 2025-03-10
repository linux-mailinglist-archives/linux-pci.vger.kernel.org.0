Return-Path: <linux-pci+bounces-23311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B7FA59256
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 12:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B910516B28C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43C4227E82;
	Mon, 10 Mar 2025 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph8psdF2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B8227E80
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605065; cv=none; b=uGMNhU8jt68/NKIFdAn5AeiCbBwmkc7fQJkKU8YN2D3mBm4tBiQXbbFBqc6zKKPFa58OIkCThmeV+jX04lYbu1f3Q8o1i/AdOVT/GUG+O59KDnt0yEjZee9KZpdNKWCn5GtFxk7Aglm1KQtAPbsJXQ+JfVtIbssoW+rAUnxJ+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605065; c=relaxed/simple;
	bh=XHdl7kLwoXeGBDCBfA/I7mIVLny73tPykcs17tfW1hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYwlYqH+ukS3AD6Wc1lvjQHrPGHU6AcO+VYzQ5UwoySrJJYI7jmKbtewhcv8j4TDhqc0+WX6pD/bO+heKFeqSZ4ROQxqt5ziRisC3yFlO1FXLwPqClfvyeABmpjbD+oz8tqy3ZX4Ztwrjn4QZk89hPfwrDZx2e0UeEqznh6K1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph8psdF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84A0C4CEEE;
	Mon, 10 Mar 2025 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741605065;
	bh=XHdl7kLwoXeGBDCBfA/I7mIVLny73tPykcs17tfW1hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ph8psdF2wSVMxHAlxeDGaSi3ZzTXH3DKxr+bxvCKASHdDAtabpgDOhCMFgFU8KspD
	 8otW5tGkYDo3FsWwQuTcBVOKpzKcjh6QSU44/pVb48JZ/zxiMicmIo0bbzsUfmMFaS
	 Kq2WVw6PBtHsqDYf74kSnC+cl3AYzPHE4U37pz9TBDzisUXEez6YWYxlroFkDO51q0
	 Y4sOOyEpeqNlwERHL1w5zUX1/+OMDyfO5KeKuRELYJYjeG0WpVmq5zh8vMShO5IebA
	 I9oWy/X3sOLW6Q9QZgG9kYr8ezHeungyGMLlOvFNQELM1eWY++V5b4V1tbr5kseszc
	 NQNZFs9QOjCcQ==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 7/7] misc: pci_endpoint_test: Add support for PCITEST_IRQ_TYPE_AUTO
Date: Mon, 10 Mar 2025 12:10:24 +0100
Message-ID: <20250310111016.859445-16-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310111016.859445-9-cassel@kernel.org>
References: <20250310111016.859445-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5544; i=cassel@kernel.org; h=from:subject; bh=XHdl7kLwoXeGBDCBfA/I7mIVLny73tPykcs17tfW1hk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLPnZi3zFDEz8nu22/h5e2B+uvmsU7+OdvoH49L+M5nc 09Ym/4Q7yhlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEzPQYGT7aq5XfDbj7Ko6h Yb6OuqekRuDG3huR06RmfmO7VWh4W5yR4Y3xiUwfk4wixsuey4Qa31WddMh2tghbnp95uv9D0+o z3AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

For PCITEST_MSI we really want to set PCITEST_SET_IRQTYPE explicitly
to PCITEST_IRQ_TYPE_MSI, since we want to test if MSI works.

For PCITEST_MSIX we really want to set PCITEST_SET_IRQTYPE explicitly
to PCITEST_IRQ_TYPE_MSIX, since we want to test if MSI works.

For PCITEST_LEGACY_IRQ we really want to set PCITEST_SET_IRQTYPE explicitly
to PCITEST_IRQ_TYPE_INTX, since we want to test if INTx works.

However, for PCITEST_WRITE, PCITEST_READ, PCITEST_COPY, we really don't
care which IRQ type that is used, we just want to use a IRQ type that is
supported by the EPC.

The old behavior was to always use MSI for PCITEST_WRITE, PCITEST_READ,
PCITEST_COPY, was to always set IRQ type to MSI before doing the actual
test, however, there are EPC drivers that do not support MSI.

Add a new PCITEST_IRQ_TYPE_AUTO, that will use the CAPS register to see
which IRQ types the endpoint supports, and use one of the supported IRQ
types.

For backwards compatibility, if the endpoint does not expose any supported
IRQ type in the CAPS register, simply fallback to using MSI, as it was
unconditionally done before.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c              | 25 +++++++++++++++----
 include/uapi/linux/pcitest.h                  |  1 +
 .../pci_endpoint/pci_endpoint_test.c          | 12 ++++-----
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 849d730ba14d..d294850a35a1 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -66,6 +66,9 @@
 
 #define PCI_ENDPOINT_TEST_CAPS			0x30
 #define CAP_UNALIGNED_ACCESS			BIT(0)
+#define CAP_MSI					BIT(1)
+#define CAP_MSIX				BIT(2)
+#define CAP_INTX				BIT(3)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
@@ -112,6 +115,7 @@ struct pci_endpoint_test {
 	struct miscdevice miscdev;
 	enum pci_barno test_reg_bar;
 	size_t alignment;
+	u32 ep_caps;
 	const char *name;
 };
 
@@ -802,11 +806,23 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	int ret;
 
 	if (req_irq_type < PCITEST_IRQ_TYPE_INTX ||
-	    req_irq_type > PCITEST_IRQ_TYPE_MSIX) {
+	    req_irq_type > PCITEST_IRQ_TYPE_AUTO) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		return -EINVAL;
 	}
 
+	if (req_irq_type == PCITEST_IRQ_TYPE_AUTO) {
+		if (test->ep_caps & CAP_MSI)
+			req_irq_type = PCITEST_IRQ_TYPE_MSI;
+		else if (test->ep_caps & CAP_MSIX)
+			req_irq_type = PCITEST_IRQ_TYPE_MSIX;
+		else if (test->ep_caps & CAP_INTX)
+			req_irq_type = PCITEST_IRQ_TYPE_INTX;
+		else
+			/* fallback to MSI if no caps defined */
+			req_irq_type = PCITEST_IRQ_TYPE_MSI;
+	}
+
 	if (test->irq_type == req_irq_type)
 		return 0;
 
@@ -892,13 +908,12 @@ static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
 {
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
-	u32 caps;
 
-	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
-	dev_dbg(dev, "PCI_ENDPOINT_TEST_CAPS: %#x\n", caps);
+	test->ep_caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
+	dev_dbg(dev, "PCI_ENDPOINT_TEST_CAPS: %#x\n", test->ep_caps);
 
 	/* CAP_UNALIGNED_ACCESS is set if the EP can do unaligned access */
-	if (caps & CAP_UNALIGNED_ACCESS)
+	if (test->ep_caps & CAP_UNALIGNED_ACCESS)
 		test->alignment = 0;
 }
 
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 304bf9be0f9a..d3aa8715a525 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -27,6 +27,7 @@
 #define PCITEST_IRQ_TYPE_INTX		0
 #define PCITEST_IRQ_TYPE_MSI		1
 #define PCITEST_IRQ_TYPE_MSIX		2
+#define PCITEST_IRQ_TYPE_AUTO		3
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001
 
diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index fdf4bc6aa9d2..ac26481d29d9 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -181,8 +181,8 @@ TEST_F(pci_ep_data_transfer, READ_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
-	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
 
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
 		param.size = test_size[i];
@@ -200,8 +200,8 @@ TEST_F(pci_ep_data_transfer, WRITE_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
-	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
 
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
 		param.size = test_size[i];
@@ -219,8 +219,8 @@ TEST_F(pci_ep_data_transfer, COPY_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
-	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
 
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
 		param.size = test_size[i];
-- 
2.48.1


