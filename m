Return-Path: <linux-pci+bounces-32296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E2B07AD2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13E35060C1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD62F6FA8;
	Wed, 16 Jul 2025 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KH1k+y23"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A02F5C48;
	Wed, 16 Jul 2025 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682361; cv=none; b=ultTcFhHQ5ffS3RlVkxFcqmQlijy/abazawUWOnIj3O0Db6/9gGVwxMW0XuRLw495EVmxHskKS+c6LAqrM031urkJckhSt0z5/4Pe1FYeKcOfnLjeeuPYLuMA9tQZwZ5Hxjgunj53vIhgcsukQQ3NFM1UEwleL3jj7KjzxSzdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682361; c=relaxed/simple;
	bh=ynfFaEATL7WgfPAqPdV/qIxMEciE6FSsbl+MwHQEKV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ImfDW6SosApOKX2KTN9hkYjPNfbsrCM26YD+sIT6kRYwGjb9RyBsJZxfeOt7EY5Ff9EwvKCZe8xqHvD9tpkRmM9IRoLDkAQCIuf2ZBLrgWchtcRKy9OW4DLiM50TTe9Tyy9I5+jESfeio7TuUwv9voiNgGzUPsPZTCNyk4wn7ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KH1k+y23; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ro
	JvHk5rWJ2i+4wCDc9OT17SNF6HWD0IX9y4ezkRwgo=; b=KH1k+y239l4CX1VC1c
	CLaQmvzVFjtgaXWiOX3i2zQWcBLc53CMLZn3kw7YDVlxRUqZQPlHmRGESWJle1fw
	KiP0iSrkXWHtQ+9+aswTYnfjEgj039ooHVJ9vNJUVxET3TS1mlu8MLHiCtjzdYfu
	RB0ZOGgtzYh5fSYcmQ/BR0A1U=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnMkhWz3doF6jWAw--.24466S6;
	Thu, 17 Jul 2025 00:12:11 +0800 (CST)
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
Subject: [PATCH v14 4/7] PCI: Refactor extended capability search into common macro
Date: Thu, 17 Jul 2025 00:12:00 +0800
Message-Id: <20250716161203.83823-5-18255117159@163.com>
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
X-CM-TRANSID:PigvCgAnMkhWz3doF6jWAw--.24466S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyrtrW7CrW5XF4xJw43Wrg_yoWrXF15pr
	W3Aw1SyryrJa12qwnIva10gF1Ygan7JayUWFWfG34rZFyDCF1rCrWftayagFy7trZruF1S
	qFs5JFWrC3ZFyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEwvtiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxCMo2h3yP1-SwAAsi

Move the extended Capability search logic into a header-based macro
that accepts a config space accessor function as an argument. This enables
controller drivers to perform Capability discovery using their early access
mechanisms prior to full device initialization while sharing the Capability
search code.

Convert the existing PCI core extended Capability search implementation to
use this new macro.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v13:
- Split patch for searching extended capability.

Changes since v12:
- Delete __pci_find_next_cap, use PCI_FIND_NEXT_CAP_TTL() directly.
- Modify the doc description of the function.

Changes since v11:
- Add #include <linux/bitfield.h>, solve the compilation warnings caused by the subsequent patch calls.

Changes since v10:
- Remove #include <uapi/linux/pci_regs.h>.
- The patch commit message were modified.

Changes since v9:
- None

Changes since v8:
- The patch commit message were modified.
---
 drivers/pci/pci.c | 35 ++---------------------------------
 drivers/pci/pci.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c590f697c011..b72fd950ff92 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -527,42 +527,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
  */
 u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int cap)
 {
-	u32 header;
-	int ttl;
-	u16 pos = PCI_CFG_SPACE_SIZE;
-
-	/* minimum 8 bytes per capability */
-	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
-
 	if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
 		return 0;
 
-	if (start)
-		pos = start;
-
-	if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
-		return 0;
-
-	/*
-	 * If we have no capabilities, this is indicated by cap ID,
-	 * cap version and next pointer all being 0.
-	 */
-	if (header == 0)
-		return 0;
-
-	while (ttl-- > 0) {
-		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
-			return pos;
-
-		pos = PCI_EXT_CAP_NEXT(header);
-		if (pos < PCI_CFG_SPACE_SIZE)
-			break;
-
-		if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
-			break;
-	}
-
-	return 0;
+	return PCI_FIND_NEXT_EXT_CAP(pci_bus_read_config, start, cap,
+				     dev->bus, dev->devfn);
 }
 EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7465501a21e3..17b7db127dad 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -138,6 +138,46 @@ int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
 	__found_pos;							\
 })
 
+/* Extended Capability finder */
+/**
+ * PCI_FIND_NEXT_EXT_CAP - Find a PCI extended capability
+ * @read_cfg: Function pointer for reading PCI config space
+ * @start: Starting position to begin search (0 for initial search)
+ * @cap: Extended capability ID to find
+ * @args: Arguments to pass to read_cfg function
+ *
+ * Searches the extended capability space in PCI config registers
+ * for @cap. Implements TTL protection against infinite loops using
+ * a calculated maximum search count.
+ *
+ * Returns: Position of the capability if found, 0 otherwise.
+ */
+#define PCI_FIND_NEXT_EXT_CAP(read_cfg, start, cap, args...)		\
+({									\
+	u16 __pos = (start) ?: PCI_CFG_SPACE_SIZE;			\
+	u16 __found_pos = 0;						\
+	int __ttl, __ret;						\
+	u32 __header;							\
+									\
+	__ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;	\
+	while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {		\
+		__ret = read_cfg(args, __pos, 4, &__header);		\
+		if (__ret != PCIBIOS_SUCCESSFUL)			\
+			break;						\
+									\
+		if (__header == 0)					\
+			break;						\
+									\
+		if (PCI_EXT_CAP_ID(__header) == (cap) && __pos != start) {\
+			__found_pos = __pos;				\
+			break;						\
+		}							\
+									\
+		__pos = PCI_EXT_CAP_NEXT(__header);			\
+	}								\
+	__found_pos;							\
+})
+
 /* Functions internal to the PCI core code */
 
 #ifdef CONFIG_DMI
-- 
2.25.1


