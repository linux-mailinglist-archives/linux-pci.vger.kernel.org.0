Return-Path: <linux-pci+bounces-19165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0C79FF91E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 13:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2264188059F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 12:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E69D3D68;
	Thu,  2 Jan 2025 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RafcqkvM"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6320015C0;
	Thu,  2 Jan 2025 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819432; cv=none; b=pP3S/y07AWsJrI+o5wjJnkbg3S/iz7BeggzXLOGM95vJ1wq7wc9DGZMzF0RS9W4B6/y5hJyS2lJ0150Yvzi6U0sj+hgEMbeOz4u7Ad+r3bZmhi7X+/PZPzzd1HOSKtk+9rcf5bKA3QFWhxuVpu3AXSLDv6NR1udZNxurpfIcQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819432; c=relaxed/simple;
	bh=/j09JndpvNxr0E0kgFAcnl7GJcZYmIKZBXyL5aKO3dg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PvvTrvcxrUybA4zDHTworaeE8J2+wKM/GttY4VGENWBucXYrIX0qDZxmjq+vpnPe5mtvUhybENxGC2hrmj4w9jDs7PBaEPLCbnO7jowUbd/AsrsXi/QTkXEFV+PIx6A9LUGfFOijYDNE1fC09vJv185gEn/V0w5k/S5REx0LnRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RafcqkvM; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AUYgn
	Ush7xJ+0niNd7/iJmHbvFxz7zJXdtQ8ts0sP+o=; b=RafcqkvM4fIXBwD4iyEQ6
	qL+awln1Cd6Sgjyncc8fDCcOmEx9pQSkdFdUYFRCOcAC55XBLzqo1siJjTDlX/F0
	cZMQ1wZ04m9baOChDsWE2yCaBG6png39+gXClN77sHRgI9Dwx6FC9OcaAB0OLrcw
	ly2nvBmCWq4Wmj2m7LOE4o=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXHAh6gHZn2yABDQ--.57017S2;
	Thu, 02 Jan 2025 20:03:08 +0800 (CST)
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
	kernel test robot <lkp@intel.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [v6] misc: pci_endpoint_test: Fix overflow of bar_size
Date: Thu,  2 Jan 2025 20:02:22 +0800
Message-Id: <20250102120222.1403906-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXHAh6gHZn2yABDQ--.57017S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw1rCF1fKF4fKFy5JF4UCFg_yoW5Xw4kpF
	ZIkw10vF4jqry8Gan7K3ZrCF9Yya9rXry7WFW5Cw1FvFnxZFn5t3W8KrWYgr9ruFsF9F1U
	A3ZxAa1v9w1jyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBKZAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw-Io2d2e1ahzgAAss

With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".

The return value of the `pci_resource_len` interface is not an integer.
Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
overflow.
Change the data type of bar_size from integer to resource_size_t, to fix
the above issue.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501021000.7Cwcopot-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202501011917.ugP1ywJV-lkp@intel.com/
Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

---
Changes since v4-v6:
https://lore.kernel.org/linux-pci/20241231065500.168799-1-18255117159@163.com/

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
 drivers/misc/pci_endpoint_test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee..df34b742f2de 100644
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
@@ -307,13 +308,13 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	if (!read_buf)
 		return false;
 
-	iters = bar_size / buf_size;
+	remain = do_div(bar_size, buf_size);
+	iters = bar_size;
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


