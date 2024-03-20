Return-Path: <linux-pci+bounces-4942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F077880E2F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 10:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DC01F2300E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 09:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2120138DE5;
	Wed, 20 Mar 2024 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSiAgMkh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141838394
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925285; cv=none; b=oT0CMQaNlASfVZONOI1nwJvlNIw22ZHIRBSCGvSZpPFUMwimXotytRmHwTx2JzezN4icCGAehpQD/rb/o3xCT9D82MSxWDvNn8rm8RNFjrZZl+gliRLaPGBURqNaYBSTMckT0ihKxRxxydIhxelDjglwGJPNJYZfmRp+byXcxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925285; c=relaxed/simple;
	bh=GGRHa2ZDKHast5MQoiI9RTIADikjC7ZkjWNahRG+uP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAVnYe1wutkkbejjzhsmMOcFhsKzrcugIm2Upkt/ebGqc8lJclR7hLHLBFUMZXfpNVOAf2M3i1HMhfE6epx8UwT6p6aHrAPtDjI81FaNlUgZ5Tw+b+gOkv6TngX1AzwOYYO501yXXcIgzCEEhxcJQ4ATfL0vpFP0TfjfU95pKyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSiAgMkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7758DC433C7;
	Wed, 20 Mar 2024 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710925284;
	bh=GGRHa2ZDKHast5MQoiI9RTIADikjC7ZkjWNahRG+uP4=;
	h=From:To:Cc:Subject:Date:From;
	b=ZSiAgMkh1wqx/6n2cHX7xiWtFfrNyX+pgvOw0++iCsrdy1BNZZ0h0ElGxWxmIqEXx
	 7zRSZxwCNp/JmaOyx7Lgh6/vlu6m6xQ9znXpqIm0uynR3Wiai/favX5ghxG/LpNUMF
	 ej7L6Ofq8K81q5ktIJsQXeHbW+Jk+F10jFh7PEtn0yt+Pg2lEU4F0l974ky0ca4+t7
	 vRT8M81J6vWMkKJkl0xI3QHlIpsZAA0oGkomk42jgeDSXZFz4dK1/xL5+XodYIP8n4
	 IBhNDN3vYAG+yqMwpR64XRsKuJRRIyODIrEuzaOoa9rpcpZUAQNFZ52A7HVHwZv0qL
	 km7KUwoqGvUTw==
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
Subject: [PATCH v3] misc: pci_endpoint_test: Use memcpy_toio()/memcpy_fromio() for BAR tests
Date: Wed, 20 Mar 2024 10:01:05 +0100
Message-ID: <20240320090106.310955-1-cassel@kernel.org>
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
Changes since v2:
-Actually free the allocated memory... (thank you Kuppuswamy)

 drivers/misc/pci_endpoint_test.c | 68 ++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 705029ad8eb5..1d361589fb61 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -272,33 +272,75 @@ static const u32 bar_test_pattern[] = {
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
+	bool ret;
 
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
-			return false;
+	write_buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!write_buf)
+		return false;
+
+	read_buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!read_buf) {
+		ret = false;
+		goto err;
 	}
 
-	return true;
+	iters = bar_size / buf_size;
+	for (j = 0; j < iters; j++) {
+		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
+						 write_buf, read_buf,
+						 buf_size)) {
+			ret = false;
+			goto err;
+		}
+	}
+
+	remain = bar_size % buf_size;
+	if (remain) {
+		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
+						 write_buf, read_buf,
+						 remain)) {
+			ret = false;
+			goto err;
+		}
+	}
+
+	ret = true;
+
+err:
+	kfree(write_buf);
+	kfree(read_buf);
+
+	return ret;
 }
 
 static bool pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
-- 
2.44.0


