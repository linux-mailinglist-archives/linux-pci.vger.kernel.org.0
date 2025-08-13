Return-Path: <linux-pci+bounces-33944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D46C8B24C55
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 16:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3B41898C63
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1002ECD06;
	Wed, 13 Aug 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hKPUoxre"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BF435977;
	Wed, 13 Aug 2025 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096368; cv=none; b=qcVoBQpPNHrPYb2MCiY5msHrRi7TKJVem5wgf2oorgeY33odiQiAUn86/m45mOdgx+i9MTi80qLVBkob8zbtdap+xaGBK60QKj+4CqqT5wn5SMXkkqnKf23WvC/DZxfQwQw3++HQhBmXf3gPeE9lBwqjWRm3qh8WqqKrW4DyI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096368; c=relaxed/simple;
	bh=jInGGj8Q8MFVLDPrBxPsGOVfUEYEH8RN+A/pP9M0+3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PTFHx5HFdsfGccFwZaASRWs7hjVTR7Psu/EhUAU5PmDTN38K6Q1ZiiXtct0VUcFA+JFwcJg2FMzqZrWkrNGa00rGEZANiNYQd8PDDvH6IdQWsJwouvHc6PoTKfqLZYWQ2yeWZiRvrA6FQwjfSKzsieCetvLkdg7oeW2unq19uRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hKPUoxre; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NE
	5agrO+wh8mVH7mx5ud+4mDgDxVx9AkxXFBHODwjOk=; b=hKPUoxre8Y5mlZY4Y6
	oE8KqNZ+iW8iDADFNBQHElBorv5DIirQvTpyeTxTgN+JbU7qh6OU28zDKmsYWs/W
	D7l5nHUiHqJFWi589z/2wAbRgrTLeg7V/hSQUf6Sm/Slvi6X6I69zwPTocCEyKxy
	mOor5uLu3lU2krPcwxkOMMHR4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHYosMpZxo4mzXAw--.28032S4;
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
Subject: [PATCH v15 2/6] PCI: Refactor capability search into PCI_FIND_NEXT_CAP()
Date: Wed, 13 Aug 2025 22:45:25 +0800
Message-Id: <20250813144529.303548-3-18255117159@163.com>
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
X-CM-TRANSID:PigvCgDHYosMpZxo4mzXAw--.28032S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrW7ZF1fZrWUAw1rCr4fAFb_yoW7XFW3pF
	ZxA3WayrW8G3W2qanIva1jkFyaqa97A3y2krW7Gwn8XFy2ka4vqa4ayF1aqFy2qrZ7CF17
	Xws0qF1kG3WYyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEfHU9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxOoo2icmQX5iwABsA

The PCI Capability search functionality is duplicated across the PCI core
and several controller drivers. The core's current implementation requires
fully initialized PCI device and bus structures, which prevents controller
drivers from using it during early initialization phases before these
structures are available.

Move the Capability search logic into a PCI_FIND_NEXT_CAP() macro that
accepts a config space accessor function as an argument. This enables
controller drivers to perform Capability discovery using their early
access mechanisms prior to full device initialization while sharing the
Capability search code.

Convert the existing PCI core Capability search implementation to use
PCI_FIND_NEXT_CAP().  Controller drivers can later use this with their
early access mechanisms while maintaining the existing protection against
infinite loops through preserved TTL checks.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c | 42 ++++++++----------------------------------
 drivers/pci/pci.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 40a5c87d9a6b..ac2658d946ea 100644
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
index 34f65d69662e..81580987509f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -2,6 +2,8 @@
 #ifndef DRIVERS_PCI_H
 #define DRIVERS_PCI_H
 
+#include <linux/align.h>
+#include <linux/bitfield.h>
 #include <linux/pci.h>
 
 struct pcie_tlp_log;
@@ -88,6 +90,49 @@ bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
 
+/* Standard Capability finder */
+/**
+ * PCI_FIND_NEXT_CAP - Find a PCI standard capability
+ * @read_cfg: Function pointer for reading PCI config space
+ * @start: Starting position to begin search
+ * @cap: Capability ID to find
+ * @args: Arguments to pass to read_cfg function
+ *
+ * Search the capability list in PCI config space to find @cap.
+ * Implements TTL (time-to-live) protection against infinite loops.
+ *
+ * Return: Position of the capability if found, 0 otherwise.
+ */
+#define PCI_FIND_NEXT_CAP(read_cfg, start, cap, args...)		\
+({									\
+	int __ttl = PCI_FIND_CAP_TTL;					\
+	u8 __id, __found_pos = 0;					\
+	u8 __pos = (start);						\
+	u16 __ent;							\
+									\
+	read_cfg##_byte(args, __pos, &__pos);				\
+									\
+	while (__ttl--) {						\
+		if (__pos < PCI_STD_HEADER_SIZEOF)			\
+			break;						\
+									\
+		__pos = ALIGN_DOWN(__pos, 4);				\
+		read_cfg##_word(args, __pos, &__ent);			\
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


