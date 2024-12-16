Return-Path: <linux-pci+bounces-18487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 194339F2B12
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 08:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6E2163C12
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 07:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF621F755B;
	Mon, 16 Dec 2024 07:41:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C161F7099;
	Mon, 16 Dec 2024 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334868; cv=none; b=OTMdP3UfNet+TnSTp62zKgE4SZA44f2u9EJm2xeamk8PT1+n389WTy5rvKnAv86dHNDRvQMurucnzokQaAJCh2cJkXR5UfPPW6/c7VgXOztHivOCI2weZu3+1i7bbSXiHaLX3dz4PzojuTF8FvRWq3Lnv6QbrL6sk/xltCiUylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334868; c=relaxed/simple;
	bh=f9sYJvUAIlj8t4XEHe6rO2w0rv/v4XA7oTWWjuqWTZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oN1ER9uY40nehx8zukHMRI1dqhsu2ws5F2YK2q3C1X0V5CUsVxEkcdtDOyx51d9U8ptCoF/zi0r1CQCRuFvQGidqNUr5C/zFh2I3rT4y7gboBaYd5uQhLj6wfk6a9fBhx5cdwKmF8DUpvHYxWNS5ckSiDBXQvt70uB/S14YaG/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 16 Dec 2024 16:39:56 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 726FD200907C;
	Mon, 16 Dec 2024 16:39:56 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 16 Dec 2024 16:39:56 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id C486DAB187;
	Mon, 16 Dec 2024 16:39:55 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=8F=AB=CDski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/2] misc: pci_endpoint_test: Set reserved BARs for each SoCs
Date: Mon, 16 Dec 2024 16:39:41 +0900
Message-Id: <20241216073941.2572407-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241216073941.2572407-1-hayashi.kunihiko@socionext.com>
References: <20241216073941.2572407-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are bar numbers that cannot be used on the endpoint.
So instead of SoC-specific conditions, add "reserved_bar" bar number
bitmap to the SoC data.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/misc/pci_endpoint_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 854480921470..e6a1a2916425 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -76,9 +76,6 @@
 #define PCI_DEVICE_ID_LS1088A			0x80c0
 #define PCI_DEVICE_ID_IMX8			0x0808
 
-#define is_am654_pci_dev(pdev)		\
-		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
-
 #define PCI_DEVICE_ID_RENESAS_R8A774A1		0x0028
 #define PCI_DEVICE_ID_RENESAS_R8A774B1		0x002b
 #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
@@ -123,6 +120,7 @@ struct pci_endpoint_test {
 	struct miscdevice miscdev;
 	enum pci_barno test_reg_bar;
 	size_t alignment;
+	u32 reserved_bar;
 	const char *name;
 };
 
@@ -130,6 +128,7 @@ struct pci_endpoint_test_data {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
 	int irq_type;
+	u32 reserved_bar;
 };
 
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
@@ -753,7 +752,6 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	int ret = -EINVAL;
 	enum pci_barno bar;
 	struct pci_endpoint_test *test = to_endpoint_test(file->private_data);
-	struct pci_dev *pdev = test->pdev;
 
 	mutex_lock(&test->mutex);
 
@@ -765,7 +763,7 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 		bar = arg;
 		if (bar > BAR_5)
 			goto ret;
-		if (is_am654_pci_dev(pdev) && bar == BAR_0)
+		if (BIT(bar) & test->reserved_bar)
 			goto ret;
 		ret = pci_endpoint_test_bar(test, bar);
 		break;
@@ -840,6 +838,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		test_reg_bar = data->test_reg_bar;
 		test->test_reg_bar = test_reg_bar;
 		test->alignment = data->alignment;
+		test->reserved_bar = data->reserved_bar;
 		irq_type = data->irq_type;
 	}
 
@@ -991,6 +990,7 @@ static const struct pci_endpoint_test_data am654_data = {
 	.test_reg_bar = BAR_2,
 	.alignment = SZ_64K,
 	.irq_type = IRQ_TYPE_MSI,
+	.reserved_bar = BIT(BAR_0),
 };
 
 static const struct pci_endpoint_test_data j721e_data = {
-- 
2.25.1


