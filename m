Return-Path: <linux-pci+bounces-27002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7080AA0C26
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 14:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596A04649A3
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 12:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828DA2D1901;
	Tue, 29 Apr 2025 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cf+xLs/Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE12D027F;
	Tue, 29 Apr 2025 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931077; cv=none; b=NZbCqWO20mHnAO466E4RDOYLC9Zd/RivwZ2I+bu/7O4zPAqZy34SKUzOC9KM25plco6I12GPY2M2VdKr0sH9cj9obzTSeyXjo08VEa36jWBr0UUm9XNsnR3kWedVtXndLqOScmD2K/+FLCVz6ebO6V9bNQrXS9/k9GpWTFAgl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931077; c=relaxed/simple;
	bh=GeVo1XDHDWysYKqXEPUFdiJKPWlA1aqifJcZbkM5QLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RcNSjHmZbDBxTlU5QmoLXExXJCT7cp+xvLpIJPretsWKLt6tPwqGXlTeQpRRfnAniFGHME4rzyw66bvTn2bXWukGB6v7RazOQ4Wmncy+WDdZ4YAVtteQ1Ngo1w+izHwGMAr04kWcyddBuSY8mHZybs0cF0CtTgZGON5DcTUAKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cf+xLs/Q; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cBcr/
	3AXCJ2HUs1iKRmGu+NHILyOf7bAb1JgTi8RouA=; b=Cf+xLs/Q5tgc6bry51+SB
	WO7SWg2BDnPMJEEhgS2YkASmqJzMii3IqEu1q1h7UtJI1AUays3HcR+59e8GVg1e
	RYblMXlVjmc5lnM2UPm+70bCAasslaS32B72YuwAOamhRvcDV2XFHOf/SQKLd1Hx
	XGeRoxKjCT5UiHFn3N7nRo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC3DRQeyxBoOlBzDQ--.23007S4;
	Tue, 29 Apr 2025 20:50:41 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	kw@linux.com
Cc: cassel@kernel.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v10 2/6] PCI: Clean up __pci_find_next_cap_ttl() readability
Date: Tue, 29 Apr 2025 20:50:32 +0800
Message-Id: <20250429125036.88060-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250429125036.88060-1-18255117159@163.com>
References: <20250429125036.88060-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3DRQeyxBoOlBzDQ--.23007S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyUuF4Uur4kJr47Cw18uFg_yoW8trW5pF
	98Ca47ArWrJF1UCws293W2yr13Xa4DCay8G3yFg3s8ZFy2yF1vqws29F1aqF17XrZ29F15
	X3sIv395CFy5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKhFxtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxU+o2gQySUykgAAsn

Refactor the __pci_find_next_cap_ttl() to improve code clarity:
- Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
- Use ALIGN_DOWN() for position alignment instead of manual bitmask.
- Extract PCI capability fields via FIELD_GET() with standardized masks.
- Add necessary headers (linux/align.h, uapi/linux/pci_regs.h).

The changes are purely non-functional cleanups, ensuring behavior remains
identical to the original implementation.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v9:
- None

Changes since v8:
- Split into patch 1/6, patch 2/6.
- The
 drivers/pci/pci.c             | 10 ++++++----
 include/uapi/linux/pci_regs.h |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d7c9f64ea24..1c29e8f20cb5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/align.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -30,6 +31,7 @@
 #include <asm/dma.h>
 #include <linux/aer.h>
 #include <linux/bitfield.h>
+#include <uapi/linux/pci_regs.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -432,17 +434,17 @@ static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
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
index ba326710f9c8..b59179e1210a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -206,6 +206,8 @@
 /* 0x48-0x7f reserved */
 
 /* Capability lists */
+#define PCI_CAP_ID_MASK		0x00ff
+#define PCI_CAP_LIST_NEXT_MASK	0xff00
 
 #define PCI_CAP_LIST_ID		0	/* Capability ID */
 #define  PCI_CAP_ID_PM		0x01	/* Power Management */
-- 
2.25.1


