Return-Path: <linux-pci+bounces-27176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04E4AA992A
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 18:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B265178A0B
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0ED26A1BB;
	Mon,  5 May 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V1LJaYpm"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6EC26F453;
	Mon,  5 May 2025 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462918; cv=none; b=j9N1e70SkDDZBaVfP9u8mnk1f7tc4oqX/TwieJu0ZHgNeawMnVyjx91IiutvDTbvYND0LRrV28XmvyaCEPkE28dWTu7ya83LG12boum0BT4k22gctMhG2EYY9NK+ZoVfEuQ3whBTMoG5qHE1Cdpu5feT8KXywIlPMiCZO97iU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462918; c=relaxed/simple;
	bh=xE5ZwG6HJWOYW19Pk/RiVY/11HHeSqrSFUFmFbhKYUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAQvC3wGAOz7ufkQuVrOKJUCorMF2Nmxi0oMb2nApSxRQ98p+6oscBbLYhSS9LgfzpB3W6L/CUrCzB5Px6L/3HLMGh2zZC/+cEVyn7pYIW+ROGkGP4dwsPmm2MJhtyJlGyNUVTOrsc16G2Pq7GdfFvVFHwcWQEcEvqKltY2T6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V1LJaYpm; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3+Dnk
	gM+rDrq50pXijjpcrpwU3+yZR27K1MxMsabuPU=; b=V1LJaYpmG4JJI0M3CV7GI
	aPM2dA0lYthBxyJ8p9jKvMU9l+uXZgodfmwzo/kgj4DCnoWZhpxmeW4Lp/KSdVKY
	ZMzIG7yUSQDDugHKhO2+/jrja529ZmC/Wk0fu6ZIOIaFhg7BjXYYQY+HkpRgNRn/
	eOAz+KAM32g7Q3mUyhrK8A=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDn+lmO6BhoumvGBw--.3540S5;
	Tue, 06 May 2025 00:34:25 +0800 (CST)
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
Subject: [PATCH v11 3/6] PCI: Refactor capability search into common macros
Date: Tue,  6 May 2025 00:34:17 +0800
Message-Id: <20250505163420.198012-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505163420.198012-1-18255117159@163.com>
References: <20250505163420.198012-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDn+lmO6BhoumvGBw--.3540S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrW7ZF1fZF1ftFyxZFWkWFg_yoW3AFW7pr
	y3A3WayrW8J3W2qwsIva1UtF1a9an7Jay29rWxGwn8XFyqkas5trySy3WaqFy7KrZ7uF13
	Xan0qFWrC3ZIyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRBpB9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwhEo2gY3b-06wAAs5

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
infinite loops in corrupted config space.  However, the
PCI_FIND_NEXT_CAP_TTL macro already enforces a TTL limit internally.
Removing redundant ttl handling simplifies the interface while maintaining
the safety guarantee. This aligns with the macro's design intent of
encapsulating TTL management.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v10:
- Remove #include <uapi/linux/pci_regs.h>.
- The patch commit message were modified.

Changes since v9:
- None

Changes since v8:
- The patch commit message were modified.
---
 drivers/pci/pci.c | 69 +++++---------------------------------
 drivers/pci/pci.h | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 27d2adb18a30..271d922abdcc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/align.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -425,35 +424,16 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 }
 
 static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
-				  u8 pos, int cap, int *ttl)
+				  u8 pos, int cap)
 {
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
+	return PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos, cap, bus,
+				     devfn);
 }
 
 static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
 			      u8 pos, int cap)
 {
-	int ttl = PCI_FIND_CAP_TTL;
-
-	return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
+	return __pci_find_next_cap_ttl(bus, devfn, pos, cap);
 }
 
 u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
@@ -554,42 +534,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
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
 
@@ -649,7 +598,7 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
 
 static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 {
-	int rc, ttl = PCI_FIND_CAP_TTL;
+	int rc;
 	u8 cap, mask;
 
 	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
@@ -658,7 +607,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 		mask = HT_5BIT_CAP_MASK;
 
 	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
-				      PCI_CAP_ID_HT, &ttl);
+				      PCI_CAP_ID_HT);
 	while (pos) {
 		rc = pci_read_config_byte(dev, pos + 3, &cap);
 		if (rc != PCIBIOS_SUCCESSFUL)
@@ -669,7 +618,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 
 		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
 					      pos + PCI_CAP_LIST_NEXT,
-					      PCI_CAP_ID_HT, &ttl);
+					      PCI_CAP_ID_HT);
 	}
 
 	return 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5e1477d6e254..9d512d37301b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -2,6 +2,7 @@
 #ifndef DRIVERS_PCI_H
 #define DRIVERS_PCI_H
 
+#include <linux/align.h>
 #include <linux/pci.h>
 
 struct pcie_tlp_log;
@@ -91,6 +92,90 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
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
+ * the specified capability. Implements TTL (time-to-live) protection
+ * against infinite loops.
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
+ * for the specified capability. Implements TTL protection against
+ * infinite loops using a calculated maximum search count.
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


