Return-Path: <linux-pci+bounces-4920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78068806D5
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 22:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D911C1C21FEB
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF8E3FB9F;
	Tue, 19 Mar 2024 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkjW3666"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1D3EA77
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884298; cv=none; b=Wli8yNDXLnWKTmY5kPzLfp5uBO5mj7RoGKzaDcLFbrDwb4rfYCiyhy1I/4ICxhQkvpYF81ZzM1aL87lHTYOFwL4pP22nBoZksl2m1Z9AgpJV/QJkKMjv82QWWFhE37Pmu/RGO0iat2dmwqcLY++G+FZi82wvpHAPBKswb1C6++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884298; c=relaxed/simple;
	bh=1UdLhgJZZbMmYtlCDVqpO8fnGNZVT0BSO6VcnMfV+5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVCK4vrYzwJQc/vUrxQGAiQJBlG6fZ6IJ9j+9yGPdVLCLiSP9DgCcOFxTYZ6IXOK6rW8Dq/IF08NVP2/KO0Hvw1D/faJ3rCS7v1lwABG8aSsQNEXygNIaF8rj1Mn/vZ+yueedi6Evq2fLuS5KN4LyNpl0bNg/amf0TYMHTsmpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkjW3666; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9EFC433F1;
	Tue, 19 Mar 2024 21:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710884297;
	bh=1UdLhgJZZbMmYtlCDVqpO8fnGNZVT0BSO6VcnMfV+5s=;
	h=From:To:Cc:Subject:Date:From;
	b=CkjW3666fQF8D3PNerx0uNdtVYqhV2FSP7jjyP14Ih7WUaL4ow2ESI2/scfo4h8iV
	 g96RXpdHBwDsdqHV2TjLFDnBVeb8n43vQA2yT5UdY5Mazgr/yVyLm+XxzNy+aW36lZ
	 eE1FYYyoYskpMxc7zkn1pUzFfB9IREzEzaJsFyUbBeajPLHtAvjwVGqmqPIeolmqbo
	 rtiDrI1Uo5CD8HJ97o86NS2ro+xO6rmApBgjvQrnwx8KNOaJnLox5j+1RrJ68EWVOa
	 a2epNy98yVbWhI2N+hgUuOjmOeA3wCTzQyfC4Ziul78UWeZ6QYSNsNuaZk7cd1bmTH
	 iyf0ZKVxhDJhQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] misc: pci_endpoint_test: Use memcpy_toio()/memcpy_fromio() for BAR tests
Date: Tue, 19 Mar 2024 22:38:06 +0100
Message-ID: <20240319213807.288550-1-cassel@kernel.org>
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
Changes since v1:
-Removed mb() memory barrier.
-Removed variable dev that was set but never used.

 drivers/misc/pci_endpoint_test.c | 49 ++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 705029ad8eb5..c7b1214499ca 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -272,31 +272,56 @@ static const u32 bar_test_pattern[] = {
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
+	void *write_buf;
+	void *read_buf;
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


