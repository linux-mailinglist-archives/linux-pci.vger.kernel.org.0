Return-Path: <linux-pci+bounces-29148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515DFAD0E72
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86C516AE60
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A73E202960;
	Sat,  7 Jun 2025 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h7jQZ319"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720281F4C9B;
	Sat,  7 Jun 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312877; cv=none; b=YHNX2n7vE641AblHBf3AWUFI+VdbDEK4JKDqSD8y0I38J8axeloA4zE0vFa3vciMahP94ytRxHLl2ZxEjk4LX9lp97H96R4kz1sSivpgYIIpDhBGY18ra5ebKqHiKK9NOjlsL39Fsr0/+gMolcpehrpxUv+rV0ojVbp7LwC3LiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312877; c=relaxed/simple;
	bh=FHVtl6rm7wilY6N76AbTzrxot+2bdZLMTs2wLx0XJng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJ8XQp3DmgmBtvSWQM01HuDqJ99oxn9iuQgmIKVkY8u71mbjMotHEK5G7KV+KkQgf1ogNHCrwpHz526I2gFD51MdmKuyKi/NQO5AsjALjGRf6qjdXn0MA4zF3jscbIeAteHOZ6HTlUzPoXR7zylA57ZyGwfB/O92PYnTfIRvDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h7jQZ319; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ig
	PuFiM6xfKp/ysL/2YwI/1lAfzePmIs4fnaTA+WoDg=; b=h7jQZ319dqot6bx2CA
	66mjoi6EauKpfIsfzPv1uYh9K03rPZDfxGiLEKRiobFLaFaERmf2JHKuKWajWjBp
	0v8a0zcKWk8YW2XsecahhEVmZJigx2SjkpsHYVVK0yX8iEOIS9USpGEybnJbFxS/
	SnB2kPhRlrZBE/q2EAC5iChOA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHuXJPZURoL9paGw--.4161S5;
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
Subject: [PATCH v13 3/6] PCI: Refactor capability search into common macros
Date: Sun,  8 Jun 2025 00:14:02 +0800
Message-Id: <20250607161405.808585-4-18255117159@163.com>
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
X-CM-TRANSID:_____wBHuXJPZURoL9paGw--.4161S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrW7ZF1fZF1ftFyxZFWkWFg_yoW3tF1Upr
	y3A3WSyrW8J3ZFqwsIva18K3Waqan7Jay7uFWxGwn8ZFyqka4ktFySya4agFy7KrZ7uF17
	Xan0qFZ5C3ZIyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRBby_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOg9lo2hEXNrGkgAAsN

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
PCI_FIND_NEXT_CAP_TTL() macro already enforces a TTL limit internally.
Removing redundant ttl handling simplifies the interface while maintaining
the safety guarantee. This aligns with the macro's design intent of
encapsulating TTL management.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
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
 drivers/pci/pci.c | 77 ++++++------------------------------------
 drivers/pci/pci.h | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 67 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1d1d147d007a..b655d8231942 100644
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
+	return PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos, cap, bus, devfn);
 }
 
 u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
@@ -554,42 +527,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
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
+	return PCI_FIND_NEXT_EXT_CAPABILITY(pci_bus_read_config, start, cap,
+					    dev->bus, dev->devfn);
 }
 EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
 
@@ -649,7 +591,7 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
 
 static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 {
-	int rc, ttl = PCI_FIND_CAP_TTL;
+	int rc;
 	u8 cap, mask;
 
 	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
@@ -657,8 +599,8 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 	else
 		mask = HT_5BIT_CAP_MASK;
 
-	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
-				      PCI_CAP_ID_HT, &ttl);
+	pos = PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos,
+				    PCI_CAP_ID_HT, dev->bus, dev->devfn);
 	while (pos) {
 		rc = pci_read_config_byte(dev, pos + 3, &cap);
 		if (rc != PCIBIOS_SUCCESSFUL)
@@ -667,9 +609,10 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 		if ((cap & mask) == ht_cap)
 			return pos;
 
-		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
-					      pos + PCI_CAP_LIST_NEXT,
-					      PCI_CAP_ID_HT, &ttl);
+		pos = PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config,
+					    pos + PCI_CAP_LIST_NEXT,
+					    PCI_CAP_ID_HT, dev->bus,
+					    dev->devfn);
 	}
 
 	return 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e7d31ed56731..46fb6b5a854e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -2,6 +2,8 @@
 #ifndef DRIVERS_PCI_H
 #define DRIVERS_PCI_H
 
+#include <linux/align.h>
+#include <linux/bitfield.h>
 #include <linux/pci.h>
 
 struct pcie_tlp_log;
@@ -93,6 +95,89 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
 int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
 			u32 *val);
 
+/* Standard Capability finder */
+/**
+ * PCI_FIND_NEXT_CAP_TTL - Find a PCI standard capability
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
+#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)		\
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
+/* Extended Capability finder */
+/**
+ * PCI_FIND_NEXT_EXT_CAPABILITY - Find a PCI extended capability
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
+#define PCI_FIND_NEXT_EXT_CAPABILITY(read_cfg, start, cap, args...)		\
+({										\
+	u16 __pos = (start) ?: PCI_CFG_SPACE_SIZE;				\
+	u16 __found_pos = 0;							\
+	int __ttl, __ret;							\
+	u32 __header;								\
+										\
+	__ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;		\
+	while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {			\
+		__ret = read_cfg(args, __pos, 4, &__header);			\
+		if (__ret != PCIBIOS_SUCCESSFUL)				\
+			break;							\
+										\
+		if (__header == 0)						\
+			break;							\
+										\
+		if (PCI_EXT_CAP_ID(__header) == (cap) && __pos != start) {	\
+			__found_pos = __pos;					\
+			break;							\
+		}								\
+										\
+		__pos = PCI_EXT_CAP_NEXT(__header);				\
+	}									\
+	__found_pos;								\
+})
+
 /* Functions internal to the PCI core code */
 
 #ifdef CONFIG_DMI
-- 
2.25.1


