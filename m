Return-Path: <linux-pci+bounces-19504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604A1A0547B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A82C7A20EB
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 07:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5BC1AA7AE;
	Wed,  8 Jan 2025 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RoDNOS70"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF31AA1FA;
	Wed,  8 Jan 2025 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321186; cv=none; b=rorp6ZIv5RsPbC//gWCbuLpQa6GtZ/po2k+HGp5yrEi+63j9hQO796MyGa4HccQghuA/rvwU+5dtTSFaeHXDLMk0oOD79Sr28RdX1M5i3K/m1SaR7Ez688Ce0V5kFZMfrYLLHmyFBCZzyrLc8ol6V+tZBje/2gGoePq296D7JRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321186; c=relaxed/simple;
	bh=YOdNCNDR6TosjVoqyLuVhH9lQhavAKa98N5wJuwvBNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CDEt2Na6QvXEiHyF0Xf/0rR5oibCRHWqBiI78Nvmy01rz7w7ichvcHR6f8wXFE918LXfxnfHhvhX6GjBkL/jHLORFG2m7bXKrK338lzkQ5DMgwI+4ycSaeY9GiCf47RDjHetAdV2lCSBteaiVcQabgXLxFtdr8brGk6UbexGVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RoDNOS70; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jmfZk
	9dzclV2jKe1vpqC10IY/UoXRyTgK2WMpYpXVnk=; b=RoDNOS70mlEHk7w/zu4c4
	l247Uk1QR6TJsc81cXYdaSXXZQ6CDs+qlgZenbB1HApk+fDKKRiyySXzYZ+InOUu
	zZHHPglVKn34RSY94aTfuuvIysUaqOQjijHnmCDgG3F0IPQtTFh10eLHqIdtqPtg
	GGpRGF57vg4rcW2Fo6WIQE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHk3pWKH5nJeDMEQ--.48179S4;
	Wed, 08 Jan 2025 15:25:15 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: manivannan.sadhasivam@linaro.org
Cc: kw@linux.com,
	kishon@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>
Subject: [v9 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Date: Wed,  8 Jan 2025 15:25:04 +0800
Message-Id: <20250108072504.1696532-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108072504.1696532-1-18255117159@163.com>
References: <20250108072504.1696532-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHk3pWKH5nJeDMEQ--.48179S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw18Gw1ruw4DJrWxZFyDAwb_yoW8Kr1UpF
	Z0kr1vvF4Ut348Gan7W3ZrCFyYya9rJry7WFW5Aw1SvF13ZFn5tF10grWYgrnruFsF9F18
	AasIya1vgw1jkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIE__UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDx7Oo2d+I+KAQwADsk

With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".

The return value of the `pci_resource_len` interface is not an integer.
Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
overflow.

Change the data type of bar_size from integer to u64, to fix the above
issue.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v8:
https://lore.kernel.org/linux-pci/20250104151652.1652181-1-18255117159@163.com/

- Split the patch.

Changes since v4-v7:
https://lore.kernel.org/linux-pci/20250102120222.1403906-1-18255117159@163.com/

- Fix 32-bit OS warnings and errors.
- Fix undefined reference to `__udivmoddi4`

Changes since v3:
https://lore.kernel.org/linux-pci/20241221141009.27317-1-18255117159@163.com/

- The patch subject were modified.

Changes since v2:
https://lore.kernel.org/linux-pci/20241220075253.16791-1-18255117159@163.com/

- Fix "changes" part goes below the --- line
- The patch commit message were modified.

Changes since v1:
https://lore.kernel.org/linux-pci/20241217121220.19676-1-18255117159@163.com/

- The patch subject and commit message were modified.
---
 drivers/misc/pci_endpoint_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 0e68dfa7257a..812508308187 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
-	int j, bar_size, buf_size, iters, remain;
+	int j, buf_size, iters;
 	void *write_buf __free(kfree) = NULL;
 	void *read_buf __free(kfree) = NULL;
 	struct pci_dev *pdev = test->pdev;
+	u64 bar_size;
 
 	if (!test->bar[barno])
 		return false;
@@ -307,7 +308,8 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	if (!read_buf)
 		return false;
 
-	iters = bar_size / buf_size;
+	do_div(bar_size, buf_size);
+	iters = bar_size;
 	for (j = 0; j < iters; j++)
 		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
 						 write_buf, read_buf, buf_size))
-- 
2.25.1


