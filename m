Return-Path: <linux-pci+bounces-19602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77241A0720E
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 10:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AFA3A8891
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8F6218EBD;
	Thu,  9 Jan 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZbNDgBYA"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D8E219A88;
	Thu,  9 Jan 2025 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415995; cv=none; b=hw+Y39T4I1uG7EErb1LBNhLQyK8Kq+Z/yclv5it9tODU4CYdiZN4NuVFFf+bGfHe6V84ak7i3BiLcTjdfJyMTu2ZzMsYoksGtkfuSim6oaB7p5Cq+C/9q48JQ32uvmCdsPGNdo+AXZkRbTIRHsDyXIh+w3rFOLYX3ltW03GgQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415995; c=relaxed/simple;
	bh=ypd63jAWFgGd4MmKm0Z+Xw0QkKUUyoS50twh06kC5xA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJfc7G7AOjTZsaatoWcw/tdBmOKlgLeCj2CHvgi2GA1lPFSqjhxoOzUISDVcH2VpGOcS+kBF0SBvbtlQiT7ifOu4Wy8AFNsgVw4XDsVjOmB05WLpxVxS4jtrrRi/1Kt4oD3XIEGY2RVHfifxkAHrwNNQIcpPpFZuzEgzws2UTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZbNDgBYA; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aNhJQ
	pggggx1i44cb3KmGFJzk7TZjsfL4u/0L0GAGCA=; b=ZbNDgBYAhBO3XMAQmgJu2
	hY7n74H8VNcqQdiGCxZBF2lAZQNgDuTZfyZdVx0INiebqWq1Ga2gJdjoXpePSNjS
	gc9+55xjxjJXfrJer9Cc8eMRAldS6nl4dNUM8xe286/e8lyS35H0Pq+cKFO9biFK
	JecM7dgax4S4hJuu5fsndU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3t7rYmn9nRKzYEw--.38788S4;
	Thu, 09 Jan 2025 17:46:02 +0800 (CST)
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
Subject: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Date: Thu,  9 Jan 2025 17:45:56 +0800
Message-Id: <20250109094556.1724663-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250109094556.1724663-1-18255117159@163.com>
References: <20250109094556.1724663-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t7rYmn9nRKzYEw--.38788S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw1rCF1fKFWUWr18CFWxZwb_yoW5Gry7pF
	Z0kr1vvF4jqry8Gan7G3ZrCFyqya9rJry7WFW5Aw1FvFnxZFn5t3W0grWYgrnruFsF9r18
	A3ZIya1vgw1jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrrcfUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDw7Po2d-kzQzswAGsU

With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".

The return value of the `pci_resource_len` interface is not an integer.
Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
overflow.

Change the data type of bar_size from integer to resource_size_t, to fix
the above issue.

Signed-off-by: Hans Zhang <18255117159@163.com>
Suggested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v10:
https://lore.kernel.org/linux-pci/20250108080951.1700230-3-18255117159@163.com/

- Replace do_div with the div_u64 API.

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
 drivers/misc/pci_endpoint_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index f78c7540c52c..0f6291801078 100644
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
+	resource_size_t bar_size;
 
 	if (!test->bar[barno])
 		return false;
@@ -307,7 +308,7 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	if (!read_buf)
 		return false;
 
-	iters = bar_size / buf_size;
+	iters = div_u64(bar_size, buf_size);
 	for (j = 0; j < iters; j++)
 		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
 						 write_buf, read_buf, buf_size))
-- 
2.25.1


