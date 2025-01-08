Return-Path: <linux-pci+bounces-19513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E65F0A05507
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB6B1887F18
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CB91B21BF;
	Wed,  8 Jan 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oAE5bP0k"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167021E131A;
	Wed,  8 Jan 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323902; cv=none; b=dTTCu9964aTxcwFQj9iZKNOIsBmqB0bWxTjC2e6/a3M1wDc7GfG+f9+ZObrUt6TbuhfB9xvlh7l1oNF2Pn4CPLA+TTSABDGOxD6Ygf/Bph3MjzoYJ/GoPD0nh2HZkAqunido1qVt92ZkioywHIGGPkDymoNsoE1Z6N2HJmjwANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323902; c=relaxed/simple;
	bh=q9iRDQVQ78G1hGB1JPBL1qLU8lZPLaQJrJJ/dGPagIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pI7a/SD+ab4ISeJHJ35tlKBlXLvcagPv8p4TKi40vzxxM3KyUQKM/bYnTD+iNBLHQX1LGVIofqx4dF0E1blNe4MhRLQbL33tE/KXGptMV1Sy//RiBxa69l2gEsHfZJkq+R5/Atr9BSJ7FtGC5OYzhhHNTSWfjpUFUbhIy///Pj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oAE5bP0k; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZptBK
	0K04q8zYSaMPbBz5I6UurDi65fUBNkXQbP03Wk=; b=oAE5bP0k77gaHiYWwuGoY
	0n3KvucbSe0OctJBpSimONQ/Pl7CU0dgdMjs8I06m6WAV9TVirL1+53hnH+icWR7
	hQ32chHN1oYlr2eLqAU8SKWf8GDxoQNiBUxzWBDcSWeTw2Yr08YjnwdgJHYsdg5K
	ZlwEfmeILdda1Y4rjjAeyk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBH9z0ZM35ntarHEg--.53777S4;
	Wed, 08 Jan 2025 16:11:10 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: manivannan.sadhasivam@linaro.org
Cc: kw@linux.com,
	kishon@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [v10 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Date: Wed,  8 Jan 2025 16:09:51 +0800
Message-Id: <20250108080951.1700230-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108080951.1700230-1-18255117159@163.com>
References: <20250108080951.1700230-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH9z0ZM35ntarHEg--.53777S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw18Gw1ruw4DJrWxZFyDAwb_yoW8KrWkpF
	Z0kr1vvF4Ut348Gan7G3ZrCFyYya9rJry7WFW5Aw1FvFnxZFn5t3W0grWYgrnruFsF9F18
	A3ZIya1vgw12kFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4oGQUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxDOo2d+KwjgNgAAse

With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".

The return value of the `pci_resource_len` interface is not an integer.
Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
overflow.

Change the data type of bar_size from integer to u64, to fix the above
issue.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v8-v9:
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
index f78c7540c52c..812508308187 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
-	int j, bar_size, buf_size, iters;
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


