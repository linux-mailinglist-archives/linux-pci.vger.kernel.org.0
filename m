Return-Path: <linux-pci+bounces-25527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CBAA81BA9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 05:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D491BA27DC
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 03:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70731D54D8;
	Wed,  9 Apr 2025 03:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gcCa/vTv"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CAE1D798E;
	Wed,  9 Apr 2025 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744170162; cv=none; b=dZZ/WuESrGY2EZns6nBzBTJBnxvbxI3pE3jaq/uiFTTXExp73LPIFSctfsZvp7Cs10TVUDSM87OiUu0lq3Cg6Hgf6P/RUH4DVJLhU23L3PF+QFDfeeeOGGunoZ3doGMiE0N58FWdMb8sqJtDmQYiivWACmGsOie0MVvH2qSYU6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744170162; c=relaxed/simple;
	bh=8ex4AnGdOCDq4MQLZBhn23NJIS0pgkqRzZMgwrYoQq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+Ip6vfN8ScXtrMkT7nz2R+pH8RjUAj8DB6iOnm8hqEXnR9xpRHvMibj5Fk+H4lr0T/T+gYJFV/4WsSRPKJZ1nIZFGjn9xapJPAo6lpSub2/2PA8KiaSqf8R+bhugS+t9T9xmLsY7bTBMALzML3FM2wg835sTuXHRxdNvgpUin4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gcCa/vTv; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CjjqZ
	qmAXqlpzEVuJvtvF/1/mb5ZZE8GD9uNewK1LIw=; b=gcCa/vTvHFz5kMmU7z4tI
	9wZD2YMoKcKHl7FL6fIXJ3+bQWU5G/Fz3cozkwSgtBwM3En8D5RwyIJB25gmsdxx
	hFuaQWIYPNeaaPTirDkHuwNZ4nYxehkP4nB/M6/3djNawkVYPdEZXS7GSxSC4msz
	eXOh3Sz+KqUb5hpIkK13oI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHD3GH7PVnbwQBFQ--.4446S4;
	Wed, 09 Apr 2025 11:42:04 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	robh@kernel.org,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v9 2/6] PCI: Clean up __pci_find_next_cap_ttl() readability
Date: Wed,  9 Apr 2025 11:41:52 +0800
Message-Id: <20250409034156.92686-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250409034156.92686-1-18255117159@163.com>
References: <20250409034156.92686-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHD3GH7PVnbwQBFQ--.4446S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyUuF4Uur4kJr47AF13Jwb_yoW8tF13pF
	98CFy7ArWrJF1UCws29w12yr13Xa4DCay8G3ySg3s8ZFy2yF1vqws29F1aqF17XrZ293W5
	X3sIv395WFy5ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEq2NLUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwsqo2f17CwQFQAAsO

Refactor the __pci_find_next_cap_ttl() to improve code clarity:
- Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
- Use ALIGN_DOWN() for position alignment instead of manual bitmask.
- Extract PCI capability fields via FIELD_GET() with standardized masks.
- Add necessary headers (linux/align.h, uapi/linux/pci_regs.h).

The changes are purely non-functional cleanups, ensuring behavior remains
identical to the original implementation.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v8:
- Split into patch 1/6, patch 2/6.
- The patch commit message were modified.
---
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


