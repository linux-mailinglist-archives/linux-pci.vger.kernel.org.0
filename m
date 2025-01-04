Return-Path: <linux-pci+bounces-19304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92804A01573
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 16:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767E616384C
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76919146A60;
	Sat,  4 Jan 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gP8Ghjei"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D611CA0;
	Sat,  4 Jan 2025 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736003874; cv=none; b=ivNpBwqVK9+Nw6XgNNFzrZlZdU9KNuC74gEyzb7la93O4YkNklsSyT4aDWsYrq0wsUb43mzX/rStkbjgL0nS0u2I4EuIuz3dF3j+Bv0zr1E/4KzkDb9f3XYh2P9gAH6CsaUOsrQZGl7ggoG+F8ByOJF9WHdZKOqodPVvbyY2YX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736003874; c=relaxed/simple;
	bh=3xrCT5X7m7llcsZqobOOVCHzjhCC9rlF45BZxfuIXEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QKqgbXMBXbadCf1pWf7P5z+2APx3IPXCwV77NBZUMHxEHips4WPc9uM/Z80nyf61F1RK68CO5Q2VUgsADHv5cIqzGxySH9XIs6lbxxGFRPhRGnoqm3y072bjhNfOtfIkILDqnlTrIjfIJUMWLc3REG+rRBcGeTKTv2KLZepF7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gP8Ghjei; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kBq0S
	sqmbL7pG1s9zgssJwuGLA71IuUiWiiZBlIZElI=; b=gP8GhjeiPuDTxEhj4irtF
	fTO7JpznffDt1LE96z1KJUjnsTAKS9af/BBnFnsBBtV7xx+hdPef4dT2pOzLFZzk
	7tc6Z7q1SPx/oJkRAA/dvruyjayZIHzPc7V+qPi8UTBmUFss/rAfBX/bvv6Q/r3a
	zy6I9doksvTon/hzCAhG4U=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCXWy3pUHlnlZwgDw--.24652S2;
	Sat, 04 Jan 2025 23:16:58 +0800 (CST)
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
Subject: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
Date: Sat,  4 Jan 2025 23:16:52 +0800
Message-Id: <20250104151652.1652181-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXWy3pUHlnlZwgDw--.24652S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw1rCF1fKF4fKFy8GF13twb_yoW5WF1UpF
	ZIkr1FvF4jqa4xGan7W3ZrCFyvya9rXry7XFW5Aw1SvFnxZFn5tF18KrW5KrZruFsFvF18
	A3ZxAa1vgw12yFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcNV9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDwHKo2d5SwjRmgAAsx

With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".

The return value of the `pci_resource_len` interface is not an integer.
Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
overflow.

Change the data type of bar_size from integer to resource_size_t, to fix
the above issue.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes since v8:

- Add reviewer.

Changes since v4-v7:
https://lore.kernel.org/linux-pci/20250102120222.1403906-1-18255117159@163.com/
https://lore.kernel.org/linux-pci/20250101151509.570341-1-18255117159@163.com/

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


