Return-Path: <linux-pci+bounces-19301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910CAA01538
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 15:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A97160F77
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6C1474B7;
	Sat,  4 Jan 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HKT7pQ59"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E7F42065;
	Sat,  4 Jan 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736000588; cv=none; b=De+3v51utCROep/3rPraFibjshMX/+I4a52GD/ltT83Hr2U68QS2XioLYIk0e9jlxP9Lg8kbRuNowHfEEWpYWtmbE5dB8XV+daoStHDQCTZ4A8qkNBnqNFDlJXB2VNPWRncujpkiq/MBCr+JsPPfMcsM969nqXU7B77TfctfjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736000588; c=relaxed/simple;
	bh=CNFf04/3+CM9qIKxUOfKC1AdGWUGFAoV4pCDRG5DGrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GnlD6xWb8o59QRldQ/YuWNSpKAHHj5MyFBjlsPQcJueRc/+SXxbJiGNDXRAIZLUaKiCgooTZ1sz780XiccRuCNRzw3746go6UPGz+A4/E5PM+RHzEqFILTRdZfWQGGaGx9m6fSOdX8YNo5ldJb6/rzv8p3Qn7Z/bbwbcqhN2fU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HKT7pQ59; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GW1di
	Lbvn6gMahkPRSkVqUdyZvG/m61fC1puhFdjVmE=; b=HKT7pQ59PkkbrdETPiMUj
	i8yDmODtNQjTinvlxpbNzy5pqnStY9Uq2jZ3uEaN4FhxI3ljkfvrAWfcL+gaeayL
	/BZs88Q/xjgmgdsydMApp8DDVu8jd3NgjBtpMNAVg6cB4UGkkvIBYoepHL28uAVE
	RU4zi7mdotyNrPxHlwWuao=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD373jnQ3ln7ohADw--.17493S2;
	Sat, 04 Jan 2025 22:21:28 +0800 (CST)
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
Subject: [v7] misc: pci_endpoint_test: Fix overflow of bar_size
Date: Sat,  4 Jan 2025 22:21:27 +0800
Message-Id: <20250104142127.1613042-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD373jnQ3ln7ohADw--.17493S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw1rCF1fKFyrXr1rWFW3ZFb_yoW5GryxpF
	ZIkr1FvF4jqa48Gan7G3ZrCF90ya9rXry7XFW5Aw1SvFnxZFn5tF18KrW5KrZruFsFvr18
	A3ZxAanY9w12yFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDCzNUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwnKo2d5QKxHeAAAsi

With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".

The return value of the `pci_resource_len` interface is not an integer.
Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
overflow.

Change the data type of bar_size from integer to resource_size_t, to fix
the above issue.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
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
 drivers/misc/pci_endpoint_test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee..50d4616119af 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
-	int j, bar_size, buf_size, iters, remain;
 	void *write_buf __free(kfree) = NULL;
 	void *read_buf __free(kfree) = NULL;
 	struct pci_dev *pdev = test->pdev;
+	int j, buf_size, iters, remain;
+	resource_size_t bar_size;
 
 	if (!test->bar[barno])
 		return false;
@@ -307,13 +308,18 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	if (!read_buf)
 		return false;
 
-	iters = bar_size / buf_size;
+	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT)) {
+		remain = do_div(bar_size, buf_size);
+		iters = bar_size;
+	} else {
+		iters = bar_size / buf_size;
+		remain = bar_size % buf_size;
+	}
 	for (j = 0; j < iters; j++)
 		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
 						 write_buf, read_buf, buf_size))
 			return false;
 
-	remain = bar_size % buf_size;
 	if (remain)
 		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
 						 write_buf, read_buf, remain))

base-commit: ccb98ccef0e543c2bd4ef1a72270461957f3d8d0
-- 
2.25.1


