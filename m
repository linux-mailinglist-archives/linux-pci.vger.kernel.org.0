Return-Path: <linux-pci+bounces-29149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 890EFAD0E76
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5627216AF93
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1093620A5F2;
	Sat,  7 Jun 2025 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="THVcPHUL"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A341FBE9E;
	Sat,  7 Jun 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312877; cv=none; b=a7xwZq//ztXAfThH4cFe0Srv5lNjtf1z60XrpjsB7IeXdnxm4JntKxC6XhdvC8wlfqurU/OK3whnaL5AHzJ7EqmXiqug5HAX8wegcsPQRByTw+nxbEbZTOtLpE8UOm0HLq4vOfmPEYrOa61Lpl/7kt5jSdxr2m6Chov+T8UvQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312877; c=relaxed/simple;
	bh=WiqnOiqH/UvsMfcGHZfXvzDTL0ZCFJd2jgibd02fwv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8ad1MaytgxY9fp+aQQKgDOnLlYpk1ckTWDp2AXKPnzwQdzP4KKBUmuB5iF18wQTR7kbqqSVAdbRf1CvfFuGRN7KWq08tN9czR9NJYcqbcpmcF67guVK5xRAPSvPK3BS+rdSCo3nJYqcBh3g1ibEZczWL9ONYhbcdtg+SUuC3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=THVcPHUL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pH
	QVRjTcreqv3ghY3CpFHRvjenXJb5fqYwRuvBNfx/o=; b=THVcPHUL4CQEbQl1fK
	3Xjmd9moRyGlyZwR2wYHE2oCkwYIVMqDg9Zm8noFqXrFvDCcp5QEetGcnyoqzDDa
	bpsAyYfgFVo9csW/tn71mv5ZpxAOcy2YKHeuPK3zBTBpKuQFLDtVEq27iuh6R0GA
	R/1FRrd4WaX9FndjZ0qaAKln8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHuXJPZURoL9paGw--.4161S4;
	Sun, 08 Jun 2025 00:14:09 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v13 2/6] PCI: Clean up __pci_find_next_cap_ttl() readability
Date: Sun,  8 Jun 2025 00:14:01 +0800
Message-Id: <20250607161405.808585-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250607161405.808585-1-18255117159@163.com>
References: <20250607161405.808585-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHuXJPZURoL9paGw--.4161S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyUuF4UZw1fCrW3Gw45Jrb_yoW8trykpF
	98Aa4xAr4rJF47Cw4vk3W2yry3XayDCrW8WrWagwn8uFy7J3W0qwsI9F1ayFnrXrZ293W5
	XFyqv3s8GF90yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piO6p9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwJlo2hEXgmruwAAs0

Refactor the __pci_find_next_cap_ttl() to improve code clarity:
- Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
- Use ALIGN_DOWN() for position alignment instead of manual bitmask.
- Extract PCI capability fields via FIELD_GET() with standardized masks.
- Add necessary headers (linux/align.h).

No functional changes intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v12:
- Modify the commit message and the code format issue.

Changes since v11:
- None

Changes since v10:
- Remove #include <uapi/linux/pci_regs.h> and add macro definition comments.

Changes since v9:
- None

Changes since v8:
- Split into patch 1/6, patch 2/6.
- The
---
 drivers/pci/pci.c             | 9 +++++----
 include/uapi/linux/pci_regs.h | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113b..1d1d147d007a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/align.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -432,17 +433,17 @@ static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
 	pci_bus_read_config_byte(bus, devfn, pos, &pos);
 
 	while ((*ttl)--) {
-		if (pos < 0x40)
+		if (pos < PCI_STD_HEADER_SIZEOF)
 			break;
-		pos &= ~3;
+		pos = ALIGN_DOWN(pos, 4);
 		pci_bus_read_config_word(bus, devfn, pos, &ent);
 
-		id = ent & 0xff;
+		id = FIELD_GET(PCI_CAP_ID_MASK, ent);
 		if (id == 0xff)
 			break;
 		if (id == cap)
 			return pos;
-		pos = (ent >> 8);
+		pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
 	}
 	return 0;
 }
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a3a3e942dedf..5f9e7633e6e0 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -207,6 +207,9 @@
 
 /* Capability lists */
 
+#define PCI_CAP_ID_MASK		0x00ff	/* Capability ID mask */
+#define PCI_CAP_LIST_NEXT_MASK	0xff00	/* Next Capability Pointer mask */
+
 #define PCI_CAP_LIST_ID		0	/* Capability ID */
 #define  PCI_CAP_ID_PM		0x01	/* Power Management */
 #define  PCI_CAP_ID_AGP		0x02	/* Accelerated Graphics Port */
-- 
2.25.1


