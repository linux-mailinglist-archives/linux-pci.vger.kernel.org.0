Return-Path: <linux-pci+bounces-32297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D8B07AD8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6359F7B9622
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6922F7CE3;
	Wed, 16 Jul 2025 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nrJMjv56"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396092F5C4A;
	Wed, 16 Jul 2025 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682362; cv=none; b=u6qT92FxuPMsmt5F0OdLmJy8jRqRTy9iSds43o5GilPdOwg1GJt0bQ4zWmltjFR2aFJ9ew56pgal4S4wq5YSwYBqCGbV/aGbJq98vCqLR3s7VOqO2t3rqj47jb8/H8xqVdfqXX1T38b/FCJLQAlXxlWUi0cgjf/bAjtjCGKKciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682362; c=relaxed/simple;
	bh=lbhNMPZx1aYP7gAMfozxg+bB50npQM1hkFWtVjZkD3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MdqcBEbgR6rL2X7hVythJIq3u6rTFzvWqDbhBNi8a3DiuorTfJBNdhWT9fwhBFZ9aKAfjNjKJgduseq9UM0Ek7A3EAiOh+aynEqWprQ4oQ3wNtQS8BR2H8C3kShYkGcR/2zmHJE8jJbFad9y2TVZt7YROZRs6l5S02SXqNuMeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nrJMjv56; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sh
	RUqCP2zBWrwajTx563Fzrw3poUzwMnZ80zo73Eq0M=; b=nrJMjv56ABJ7IpgFHQ
	NaaojJjG1ZNhL39t+WHUO4i/HBoA4aOGYGTpMmOFLpK1dNBL4wspEcIxtYJn7OZO
	hCWFdrizYdzEd6vru/cItphzOo/3xTxmq+GE/SIkRGPB4fUkxxpLC8lKCefChsVN
	CWOl5+8OrqA6Od7K/132MM3Uk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnMkhWz3doF6jWAw--.24466S5;
	Thu, 17 Jul 2025 00:12:10 +0800 (CST)
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
Subject: [PATCH v14 3/7] PCI: Refactor standard capability search into common macro
Date: Thu, 17 Jul 2025 00:11:59 +0800
Message-Id: <20250716161203.83823-4-18255117159@163.com>
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
X-CM-TRANSID:PigvCgAnMkhWz3doF6jWAw--.24466S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrW7ZF1fZF1ftFyxZFWkWFg_yoWxJr4kpF
	W3A3WayrW8J3W7tanIva10kFyaqan7J3y29rW7Gwn8ZF12ka4vqa4SyF1YqFy2grZ7u3W7
	Xa98tFykG3WYyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRIksPUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhKMo2h3yLuCeAADsS

The PCI Capability search functionality is duplicated across the PCI core
and several controller drivers. The core's current implementation requires
fully initialized PCI device and bus structures, which prevents controller
drivers from using it during early initialization phases before these
structures are available.

Move the Capability search logic into a header-based macro that accepts a
config space accessor function as an argument. This enables controller
drivers to perform Capability discovery using their early access
mechanisms prior to full device initialization while sharing the
Capability search code.

Convert the existing PCI core Capability search implementation to use this
new macro. Controller drivers can later use the same macros with their
early access mechanisms while maintaining the existing protection against
infinite loops through preserved TTL checks.

The ttl parameter was originally an additional safeguard to prevent
infinite loops in corrupted config space. However, the
PCI_FIND_NEXT_CAP() macro already enforces a TTL limit internally.
Removing redundant ttl handling simplifies the interface while maintaining
the safety guarantee. This aligns with the macro's design intent of
encapsulating TTL management.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v13:
- Split patch for searching standard capability.

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
 drivers/pci/pci.c | 42 ++++++++----------------------------------
 drivers/pci/pci.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1d1d147d007a..c590f697c011 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/align.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -424,36 +423,10 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 	return 1;
 }
 
-static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
-				  u8 pos, int cap, int *ttl)
-{
-	u8 id;
-	u16 ent;
-
-	pci_bus_read_config_byte(bus, devfn, pos, &pos);
-
-	while ((*ttl)--) {
-		if (pos < PCI_STD_HEADER_SIZEOF)
-			break;
-		pos = ALIGN_DOWN(pos, 4);
-		pci_bus_read_config_word(bus, devfn, pos, &ent);
-
-		id = FIELD_GET(PCI_CAP_ID_MASK, ent);
-		if (id == 0xff)
-			break;
-		if (id == cap)
-			return pos;
-		pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
-	}
-	return 0;
-}
-
 static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
 			      u8 pos, int cap)
 {
-	int ttl = PCI_FIND_CAP_TTL;
-
-	return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
+	return PCI_FIND_NEXT_CAP(pci_bus_read_config, pos, cap, bus, devfn);
 }
 
 u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
@@ -649,7 +622,7 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
 
 static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 {
-	int rc, ttl = PCI_FIND_CAP_TTL;
+	int rc;
 	u8 cap, mask;
 
 	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
@@ -657,8 +630,8 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 	else
 		mask = HT_5BIT_CAP_MASK;
 
-	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
-				      PCI_CAP_ID_HT, &ttl);
+	pos = PCI_FIND_NEXT_CAP(pci_bus_read_config, pos,
+				PCI_CAP_ID_HT, dev->bus, dev->devfn);
 	while (pos) {
 		rc = pci_read_config_byte(dev, pos + 3, &cap);
 		if (rc != PCIBIOS_SUCCESSFUL)
@@ -667,9 +640,10 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 		if ((cap & mask) == ht_cap)
 			return pos;
 
-		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
-					      pos + PCI_CAP_LIST_NEXT,
-					      PCI_CAP_ID_HT, &ttl);
+		pos = PCI_FIND_NEXT_CAP(pci_bus_read_config,
+					pos + PCI_CAP_LIST_NEXT,
+					PCI_CAP_ID_HT, dev->bus,
+					dev->devfn);
 	}
 
 	return 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e7d31ed56731..7465501a21e3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -2,6 +2,8 @@
 #ifndef DRIVERS_PCI_H
 #define DRIVERS_PCI_H
 
+#include <linux/align.h>
+#include <linux/bitfield.h>
 #include <linux/pci.h>
 
 struct pcie_tlp_log;
@@ -93,6 +95,49 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
 int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
 			u32 *val);
 
+/* Standard Capability finder */
+/**
+ * PCI_FIND_NEXT_CAP - Find a PCI standard capability
+ * @read_cfg: Function pointer for reading PCI config space
+ * @start: Starting position to begin search
+ * @cap: Capability ID to find
+ * @args: Arguments to pass to read_cfg function
+ *
+ * Iterates through the capability list in PCI config space to find
+ * @cap. Implements TTL (time-to-live) protection against infinite loops.
+ *
+ * Returns: Position of the capability if found, 0 otherwise.
+ */
+#define PCI_FIND_NEXT_CAP(read_cfg, start, cap, args...)		\
+({									\
+	int __ttl = PCI_FIND_CAP_TTL;					\
+	u8 __id, __found_pos = 0;					\
+	u8 __pos = (start);						\
+	u16 __ent;							\
+									\
+	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
+									\
+	while (__ttl--) {						\
+		if (__pos < PCI_STD_HEADER_SIZEOF)			\
+			break;						\
+									\
+		__pos = ALIGN_DOWN(__pos, 4);				\
+		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
+									\
+		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
+		if (__id == 0xff)					\
+			break;						\
+									\
+		if (__id == (cap)) {					\
+			__found_pos = __pos;				\
+			break;						\
+		}							\
+									\
+		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\
+	}								\
+	__found_pos;							\
+})
+
 /* Functions internal to the PCI core code */
 
 #ifdef CONFIG_DMI
-- 
2.25.1


