Return-Path: <linux-pci+bounces-5014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE6887113
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 17:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0531C215EA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AF65D72F;
	Fri, 22 Mar 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcIC9pXW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516E5D47A
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125788; cv=none; b=b02WUWsn1crb00dzkzztPNe27VLMtEJptsg0Q5nhsr0/jECZLbd2vhTUlzzLKquFAWA/uOtwIu6/L/TVZnsBcehN0N5QnXNV4n0hKIXFinwDcHFEOdBFmOmxWksmP5JsEh+ot83N5jwoxzw4Dpcmc6IIF08+HUs1u5S67F1/vck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125788; c=relaxed/simple;
	bh=tubpWp4wm7wrlQQQADfzZHewhjqYmvkV7y62XzK5EyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdjCc9U+zVQpXnHxQuTqsT5VgVwI6t9ZvCIuWv82pJRvSFSoFIyYNxMRYIKUFdggMRAL2wCPNyHerTooWUYx7naJqG3Vt1cdc7iMLgM+X6t0ZlhxtWB899ROEcLRUDnzYIaDMgqr4F29NccbMnsK9FRziz/HLLjXzkmVGfc2yOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcIC9pXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCF2C433F1;
	Fri, 22 Mar 2024 16:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711125787;
	bh=tubpWp4wm7wrlQQQADfzZHewhjqYmvkV7y62XzK5EyU=;
	h=From:To:Cc:Subject:Date:From;
	b=UcIC9pXWgWCJYLbGeg+qh3OH4m2fgY1N3dC7AzaFkhGVYTNhOGDZTCdfE7WsC1xK9
	 3fctB1FCK7hEWaxHWJPWmA952CSKK1/x7ecrPOJ8kVkv94bd2Dj8pLQ23w27ky/zpd
	 jKxmFrqepB8RqF6iLoFJyNVc+VBP0gOdfE4ktL1zxeG8LT0oywxBNgzuRtujaArQTK
	 2GKag65Ynu9947eSo4Cu/2zMTqYrfqHamoS0GiVUtYbYqdZ4Q0FnTFp5a2TLn/6Rc1
	 ST5F03+SP58equDOl67OPzdP5vvxgPadr9jd3FIgODNBEql+Wr86S0yOd5KK/f2Ahe
	 SH/lvk9JIXaXg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4] misc: pci_endpoint_test: Use memcpy_toio()/memcpy_fromio() for BAR tests
Date: Fri, 22 Mar 2024 17:41:38 +0100
Message-ID: <20240322164139.678228-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code uses writel()/readl(), which has an implicit memory
barrier for every single readl()/writel().

Additionally, reading 4 bytes at a time over the PCI bus is not really
optimal, considering that this code is running in an ioctl handler.

Use memcpy_toio()/memcpy_fromio() for BAR tests.

Before patch with a 4MB BAR:
$ time /usr/bin/pcitest -b 1
BAR1:           OKAY
real    0m 1.56s

After patch with a 4MB BAR:
$ time /usr/bin/pcitest -b 1
BAR1:           OKAY
real    0m 0.54s

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v3:
-Use scope-based resource management __free attribute from cleanup.h to
 avoid overly verbose gotos and labels for error handling.
-Added a comment related to why we allocate a buffer of max 1MB.
 (kmalloc() default upper limit is usually 4 MB on ARM and x86.)

 drivers/misc/pci_endpoint_test.c | 54 +++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 705029ad8eb5..bf64d3aff7d8 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/crc32.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/io.h>
@@ -272,31 +273,60 @@ static const u32 bar_test_pattern[] = {
 	0xA5A5A5A5,
 };
 
+static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
+					enum pci_barno barno, int offset,
+					void *write_buf, void *read_buf,
+					int size)
+{
+	memset(write_buf, bar_test_pattern[barno], size);
+	memcpy_toio(test->bar[barno] + offset, write_buf, size);
+
+	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
+
+	return memcmp(write_buf, read_buf, size);
+}
+
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
-	int j;
-	u32 val;
-	int size;
+	int j, bar_size, buf_size, iters, remain;
+	void *write_buf __free(kfree) = NULL;
+	void *read_buf __free(kfree) = NULL;
 	struct pci_dev *pdev = test->pdev;
 
 	if (!test->bar[barno])
 		return false;
 
-	size = pci_resource_len(pdev, barno);
+	bar_size = pci_resource_len(pdev, barno);
 
 	if (barno == test->test_reg_bar)
-		size = 0x4;
+		bar_size = 0x4;
 
-	for (j = 0; j < size; j += 4)
-		pci_endpoint_test_bar_writel(test, barno, j,
-					     bar_test_pattern[barno]);
+	/*
+	 * Allocate a buffer of max size 1MB, and reuse that buffer while
+	 * iterating over the whole BAR size (which might be much larger).
+	 */
+	buf_size = min(SZ_1M, bar_size);
 
-	for (j = 0; j < size; j += 4) {
-		val = pci_endpoint_test_bar_readl(test, barno, j);
-		if (val != bar_test_pattern[barno])
+	write_buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!write_buf)
+		return false;
+
+	read_buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!read_buf)
+		return false;
+
+	iters = bar_size / buf_size;
+	for (j = 0; j < iters; j++)
+		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
+						 write_buf, read_buf, buf_size))
+			return false;
+
+	remain = bar_size % buf_size;
+	if (remain)
+		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
+						 write_buf, read_buf, remain))
 			return false;
-	}
 
 	return true;
 }
-- 
2.44.0


