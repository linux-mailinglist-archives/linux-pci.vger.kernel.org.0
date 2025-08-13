Return-Path: <linux-pci+bounces-33946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B07F8B24C5D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 16:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EDE1AA0C2A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A6D2F291A;
	Wed, 13 Aug 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="exswT6AS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A02ED159;
	Wed, 13 Aug 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096371; cv=none; b=BObjIKrm0rg8B5J1hbSMCm121799tKOL0LqwE4DX04C5KXpXz9RpUDy4spVcBI/pY5iVZVJqvtU08FAHm9Yd9KfOsH+NrZt35G25X63L7YUmYab23ivE9kZrNcuVsJh8pC8p00RSNxlZv1lV754p+5N0YE3Xmmb5fVi+jVDC8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096371; c=relaxed/simple;
	bh=Bx5xy4rdha8UlSfBmLumG1DN9a5yTYhdvdocUGB6vMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cTu2qAaoWQGyyoqte2/+BqSAMIhSzNWHKWV+PCnT04Jvq80jZQF6hHH2dnrtGhLkSbHo7mhCfrJ8t5RrhlTAoQwexXsg2Kpjtf56mppI5Ckh3Ma0EuYhz1ylme938IVt9aCltWuh1ndZWOrbRjrCDtx1niYJGEDWGC5cK0lUi78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=exswT6AS; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1K
	2a590HEkP5ndEewvEUaYjFyB72wbqA06B8THOwEGM=; b=exswT6AStcYfHwliEv
	kBeG4cqDfFpwqhN0jk26teMz3KsSE5+ShXcs3fFpJfIxStY3EADE/pKAV+Zk7oAA
	XGKPZPrPnXcPUZp7EdE6g19n1AgIDfzx1IXuyru7zxGyO4iL3r+e5M+NL5oAHGEN
	+6fhXT6VK/0+VNbyBB+0MBPrI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHYosMpZxo4mzXAw--.28032S3;
	Wed, 13 Aug 2025 22:45:34 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	schnelle@linux.ibm.com,
	gbayer@linux.ibm.com,
	lukas@wunner.de,
	arnd@kernel.org,
	geert@linux-m68k.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v15 1/6] PCI: Clean up __pci_find_next_cap_ttl() readability
Date: Wed, 13 Aug 2025 22:45:24 +0800
Message-Id: <20250813144529.303548-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250813144529.303548-1-18255117159@163.com>
References: <20250813144529.303548-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDHYosMpZxo4mzXAw--.28032S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyUuF4UZw1fZr48tF1fZwb_yoW8ZrWkpF
	98CFyxArW8JF47Cw4v93WUAF13Xa4qy3y8GrW2gwn8uFy2yw18XwsI9Fy3tF12qrZ29F13
	X3sIvryFgas0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR_Ma5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxaoo2icmQX5igAAsF

Refactor the __pci_find_next_cap_ttl() to improve code clarity:
- Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
- Use ALIGN_DOWN() for position alignment instead of manual bitmask.
- Extract PCI capability fields via FIELD_GET() with standardized masks.
- Add necessary headers (linux/align.h).

No functional changes intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/pci.c             | 9 +++++----
 include/uapi/linux/pci_regs.h | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cd..40a5c87d9a6b 100644
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
index f5b17745de60..1bba99b46227 100644
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


