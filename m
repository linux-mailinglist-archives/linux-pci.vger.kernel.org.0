Return-Path: <linux-pci+bounces-27735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7816AAB70EE
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 18:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BCB188A0EB
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0981E9B1A;
	Wed, 14 May 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bJA6LoHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C214900B;
	Wed, 14 May 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239231; cv=none; b=CMxNS+PHv6SEZytWBFoGLKuzVazeUaBgX/OgcYQnvSbmjX1GKXDj4vxqSPUIZ9enSI9FzP10xCC9kQyDBu38v3boVvyFwnaSsBthEmRIwSocE6A5hkokfUzETIjYcaVb6C2Ud/3c+3J5rErdYrhYu3WwRM5p+iLFPVEgQtY9xWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239231; c=relaxed/simple;
	bh=wFwQeyX3UzcyLRreHcn0/L70EXFFVb+3SeDb0oXMq88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p1WFrGd104Xmetzn9jwb9kozolj+LOSVgHEQAPI2Upwi8ETFRn8FE+v5r/BXNt9KO2Tm025iMN6syd2rMKeNtJImA8t/W9ZRSMovlt8EpArZlzjF1vpBNbyEgF4QeRHlC5V8dz2WIufuAAoDQepGrrG0IupRWj2U0mDvIXWNOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bJA6LoHs; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=L8
	jrWZzE23L1dkQ7R9r76qgtfq+E/JkOCD8Sti47jSk=; b=bJA6LoHslDNdcIU4cY
	XUdQClkyeMs+nG0Vfzu1j0LZe7gQYtfZpCvwCGzYPtQMBlXbXCpahebIVWT9L6ij
	qjde+6H1NvUimyL//mw42EICsao2tAolQ5cpTfZSZRKq0NjVLycAc1wjmL4X5Wap
	mO/nb2ZhV7OUQfNWADw7U2oPA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3VU0LwSRo5cN_BQ--.35962S4;
	Thu, 15 May 2025 00:13:01 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	kw@linux.com
Cc: cassel@kernel.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v12 2/6] PCI: Clean up __pci_find_next_cap_ttl() readability
Date: Thu, 15 May 2025 00:12:54 +0800
Message-Id: <20250514161258.93844-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250514161258.93844-1-18255117159@163.com>
References: <20250514161258.93844-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3VU0LwSRo5cN_BQ--.35962S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyUuF4Uur15Ar17AFW5Wrg_yoW8tr1kpF
	98Ca47Ar48JF17Cws293W2yr13Xa4DCrW8G3yagwn8uFy2yF18twsIkF13tF17JrZ293W5
	XrWqv395uF90yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pisa9-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxpNo2gkvuBv6wABss

Refactor the __pci_find_next_cap_ttl() to improve code clarity:
- Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
- Use ALIGN_DOWN() for position alignment instead of manual bitmask.
- Extract PCI capability fields via FIELD_GET() with standardized masks.
- Add necessary headers (linux/align.h).

The changes are purely non-functional cleanups, ensuring behavior remains
identical to the original implementation.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
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
 include/uapi/linux/pci_regs.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e77d5b53c0ce..27d2adb18a30 100644
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
index ba326710f9c8..35051f9ac16a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -206,6 +206,8 @@
 /* 0x48-0x7f reserved */
 
 /* Capability lists */
+#define PCI_CAP_ID_MASK		0x00ff	/* Capability ID mask */
+#define PCI_CAP_LIST_NEXT_MASK	0xff00	/* Next Capability Pointer mask */
 
 #define PCI_CAP_LIST_ID		0	/* Capability ID */
 #define  PCI_CAP_ID_PM		0x01	/* Power Management */
-- 
2.25.1


