Return-Path: <linux-pci+bounces-32298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B28B07ADA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E0B1885420
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3232F7CED;
	Wed, 16 Jul 2025 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TKSwt4eO"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3952E2F5326;
	Wed, 16 Jul 2025 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682363; cv=none; b=smcUchgndjmstkp5/5hj+qFw40Vt7qCsLwA+DviDNeJCP2Mcpae3dzq/oYnnqDId25+J3WlLopwCzhEOnx8o1PwgErLbFN7SM1Z3xVWDRVOtrZjNBzsyNCM+VyiRytvdsMR0rE8dIKWX2D+p0IVHJNkAoEPwgtVSV4+GtwYJfaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682363; c=relaxed/simple;
	bh=MuAVVOvs+dYPPYaUff6Ssjm8q8yOoAflNmFG0bj6b9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=spRciIlX+m1eUFDX6YLdVAMKoMmC4m95SEmVAfB59pfdR8SXPfCnCIvW7+wdlU0Jj4q8eemAxRufPzmJuuB+ASLWqsaIFNR/hs6ImYT86w3yTZT38Qw9FPyLnI5KS8ioo9bZczDBlZjTrxfJMsaC8/E9ctd92uIG0d4GCpscIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TKSwt4eO; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ns
	bEFsBHAkALfLVj5HKN5mC4pucmKEIRd3rDiDrMAGU=; b=TKSwt4eOjDdNxz7CKU
	LB/WhfERyJPGrPP8SGNnLqzAn5asXQWPwUgm5PJDV42ChUOOKtlEYf0QUypF68Bm
	CaWtnltYcMWdPGe0tUjUr3n1h+ncbX8HTqMuac4M98VfB+mQfKPCwW6PzFoq8mfi
	BwYaqqaSr37YFCWBMq0s2o6+E=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnMkhWz3doF6jWAw--.24466S4;
	Thu, 17 Jul 2025 00:12:09 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v14 2/7] PCI: Clean up __pci_find_next_cap_ttl() readability
Date: Thu, 17 Jul 2025 00:11:58 +0800
Message-Id: <20250716161203.83823-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716161203.83823-1-18255117159@163.com>
References: <20250716161203.83823-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnMkhWz3doF6jWAw--.24466S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyUuF4UZw1fZr45GFWUXFb_yoW8tw43pF
	98Ca47Ar48JF4xCw4vk3W2yry3XayDCrW8GrWagwn8uFy7t3W8twsI9F1ayFnrXrZ293W5
	XFyqv3s0gF90yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pitCztUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwiMo2h3yady6wAAsU

Refactor the __pci_find_next_cap_ttl() to improve code clarity:
- Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
- Use ALIGN_DOWN() for position alignment instead of manual bitmask.
- Extract PCI capability fields via FIELD_GET() with standardized masks.
- Add necessary headers (linux/align.h).

No functional changes intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
Changes since v13:
- None

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


