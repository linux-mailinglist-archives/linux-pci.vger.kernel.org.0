Return-Path: <linux-pci+bounces-25164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5BA78EB8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 14:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBB71894AB0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172823BCFC;
	Wed,  2 Apr 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eEV3Z8Fc"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C19523A99C;
	Wed,  2 Apr 2025 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743597503; cv=none; b=OhwhgltdM5lJz0zTCeDaZbIWDp0Z9gtXjZ6xB3WCL38adunLU0rVtZw7xctOmxEd5mNZm1nTR2mmLMmumYCDfqcqohX33QC6yTz/geCkoRsJ1jNDi2KjNROOJUkZihUTaSoe/KlWqJSpEDY9LCsjtpOkvvP5GdBEnx/OCclH51E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743597503; c=relaxed/simple;
	bh=ddtnqBOd2ODSD+XyZv/73r6EEZeGjBoXxpInKC6Gw3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBkyMKUGHnCvJREZ+ub8f68Ur2iaNmVuyOK8vLOlmCoKi555lUoTfWPKBTfX7WjspMov1UJcFNv3qYbUTuCoswpslRcmRX1daDptbXxkG/fmBb0G+YVWiGa4vuhIt0WpeqZXSLizk4da2LT52murIW1XKr4/yz7Z2Y44lDVIVHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eEV3Z8Fc; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=av1Pb
	jZeH5TlBaSDhEWPUDcgL43N17wauAZ7YJSio9Y=; b=eEV3Z8FcQYWcOssaNZ+xc
	mDEvpF/Sv9iWnJbmLctSznzKfcgunn7UwncGiA9B0mu/Jrdyh/88l7uRclIMDSOE
	gjvfO5Dl7Rp6IhKtGqnBrM9wxvQLxWErn5PiNiqCEOTrzypoPVW3UH+ocbLbbMwW
	RoQFlRFIUyOjYHT+Hbaxr8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCXrkiUL+1nL3+IAA--.22499S4;
	Wed, 02 Apr 2025 20:37:46 +0800 (CST)
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
Subject: [v8 2/5] PCI: Refactor capability search functions to eliminate code duplication
Date: Wed,  2 Apr 2025 20:37:33 +0800
Message-Id: <20250402123736.55995-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402123736.55995-1-18255117159@163.com>
References: <20250402123736.55995-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCXrkiUL+1nL3+IAA--.22499S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryxCw4UuryUJw4DJr1fJFb_yoWrKF18pF
	W3Aa43Ary8G3W7tw4q9ayjyw13WF9rJrWxZrWxC3sYvF12yryvyFy2ka4aqFy2grZ7WF1f
	X39xtan5C3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zROzVbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDx8jo2ftJx3gQwAAsD

Refactor the PCI capability and extended capability search functions
by consolidating common code patterns into reusable macros
(PCI_FIND_NEXT_CAP_TTL and PCI_FIND_NEXT_EXT_CAPABILITY). The main
changes include:

1. Introducing a unified config space read helper (__pci_bus_read_config).
2. Removing duplicate search logic from __pci_find_next_cap_ttl and
   pci_find_next_ext_capability.
3. Implementing consistent capability discovery using the new macros.
4. Simplifying HyperTransport capability lookup by leveraging the
   refactored code.

The refactoring maintains existing functionality while reducing code
duplication and improving maintainability. By centralizing the search
logic, we achieve better code consistency and make future updates easier.

This change has been verified to maintain backward compatibility with
existing capability discovery patterns through thorough testing of PCI
device enumeration and capability probing.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v7:
https://lore.kernel.org/linux-pci/20250402042020.48681-3-18255117159@163.com

- Resolve compilation errors.
---
 drivers/pci/pci.c | 80 ++++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 57 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..f5a97f8882a6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -423,36 +423,33 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 	return 1;
 }
 
-static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
-				  u8 pos, int cap, int *ttl)
+static int __pci_bus_read_config(void *priv, unsigned int devfn, int where,
+				 u32 size, u32 *val)
 {
-	u8 id;
-	u16 ent;
+	struct pci_bus *bus = priv;
+	int ret;
 
-	pci_bus_read_config_byte(bus, devfn, pos, &pos);
+	if (size == 1)
+		ret = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
+	else if (size == 2)
+		ret = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
+	else
+		ret = pci_bus_read_config_dword(bus, devfn, where, val);
 
-	while ((*ttl)--) {
-		if (pos < 0x40)
-			break;
-		pos &= ~3;
-		pci_bus_read_config_word(bus, devfn, pos, &ent);
+	return ret;
+}
 
-		id = ent & 0xff;
-		if (id == 0xff)
-			break;
-		if (id == cap)
-			return pos;
-		pos = (ent >> 8);
-	}
-	return 0;
+static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
+				  u8 pos, int cap)
+{
+	return PCI_FIND_NEXT_CAP_TTL(__pci_bus_read_config, pos, cap, bus,
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
@@ -553,42 +550,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
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
+	return PCI_FIND_NEXT_EXT_CAPABILITY(__pci_bus_read_config, start, cap,
+					    dev->bus, dev->devfn);
 }
 EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
 
@@ -648,7 +614,7 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
 
 static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 {
-	int rc, ttl = PCI_FIND_CAP_TTL;
+	int rc;
 	u8 cap, mask;
 
 	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
@@ -657,7 +623,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 		mask = HT_5BIT_CAP_MASK;
 
 	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
-				      PCI_CAP_ID_HT, &ttl);
+				      PCI_CAP_ID_HT);
 	while (pos) {
 		rc = pci_read_config_byte(dev, pos + 3, &cap);
 		if (rc != PCIBIOS_SUCCESSFUL)
@@ -668,7 +634,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 
 		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
 					      pos + PCI_CAP_LIST_NEXT,
-					      PCI_CAP_ID_HT, &ttl);
+					      PCI_CAP_ID_HT);
 	}
 
 	return 0;
-- 
2.25.1


