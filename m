Return-Path: <linux-pci+bounces-19143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A67139FF444
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jan 2025 16:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF561615EF
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jan 2025 15:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CB61773A;
	Wed,  1 Jan 2025 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NJ0j+ZRb"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFE61E0DFD;
	Wed,  1 Jan 2025 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735744781; cv=none; b=ILKKNUmJu+X+9ujzvpTnjuVescbOaoutbKD01OHUlRwqmvFqgdU1xQw3UIzOh8RGHgJzlhq3Av+axPIy/rJvnGH4+y0BeyiuaiTKTrXz9m0/+j1iJToSILy0rfXNENpwfDcPC6pdS5H5sIft/P2OZTlbV9FTxprpABrGlNWHFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735744781; c=relaxed/simple;
	bh=RwW9lwug5Bkq89kHYqUbKENZ0hVYOvaqjZHIYcBqZ9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OzwNFeODA5xsOvYEHKGrSSc+fMTYUX4rxzsQLSCsK2c+Th8n7Zi1xjml6qxdOXRZQNE8GJUQGbs7kCVeKuGgg+vxe71prST7ZU4Zigtu+wBYLmkph2aSCkh0/KRq8wUnnkwj1nU9sOoHxtIKBBGOzIt+1y2P4cEkXibTvaU+l/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NJ0j+ZRb; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0CjaI
	DWfYKYopj+3wALnJtlNzjsryyg4k610S6DKkbE=; b=NJ0j+ZRbwWVBm+ZtEI1//
	BjwzKm7XcvdDd1rUSmtGFpD3KS7jYhxiS4pmNdAjPza0aKEWn2M8qmMUVTdf6kPY
	XTGLhhAQ6r9fW+tJoN851mUgqaVd6FcQdwteUMmluiC1uPnWovdNc4DV6oDaVWMw
	ROl5oKe4Rrfp7Dc5N3CzGU=
Received: from localhost.localdomain (unknown [124.79.128.52])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCntTDcXHVnNQquHg--.40563S2;
	Wed, 01 Jan 2025 23:18:53 +0800 (CST)
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
Subject: [v5] misc: pci_endpoint_test: Fix overflow of bar_size
Date: Wed,  1 Jan 2025 23:15:09 +0800
Message-Id: <20250101151509.570341-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCntTDcXHVnNQquHg--.40563S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw18Gw1ruw4DJrWxAF43Jrb_yoW8uFWrpF
	Wakw10qF4jqryxGFs7G3ZrCFWkKa9rJry2gFZ8Cw1SvF13ZF1ktF10grWYgrnFkFsF9a42
	y3ZIy3Wvgw1jyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcJ5wUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDw-Ho2d1PphKtAABsv

With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".

The return value of the `pci_resource_len` interface is not an integer.
Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
overflow.
Change the data type of bar_size from integer to resource_size_t, to fix
the above issue.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501011917.ugP1ywJV-lkp@intel.com/
Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

---
Changes since v4:
https://lore.kernel.org/linux-pci/20241231065500.168799-1-18255117159@163.com/

- add base-commit.

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
 drivers/misc/pci_endpoint_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee..414c4e55fb0a 100644
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

base-commit: ccb98ccef0e543c2bd4ef1a72270461957f3d8d0
-- 
2.25.1


