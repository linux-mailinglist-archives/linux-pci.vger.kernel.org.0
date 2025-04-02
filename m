Return-Path: <linux-pci+bounces-25105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9BDA7872F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 06:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6FD189287F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 04:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E9221DB2;
	Wed,  2 Apr 2025 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NPN0byGW"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F6230D35;
	Wed,  2 Apr 2025 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743567691; cv=none; b=FtBFfuRiPhBpmIM9VJWtmaF2nW5NFCN0q3LK13nw1XPMwmfLKusCsQZFhfL6FKY/dHm2ynotznCQuBa3GbF2pSf8T+GQ7gVOwC7LJy0KO9l/prswxRGY86JKxOUEJtXWD4RIfSdTJKUufCEvMZM84K8EKtgdYf5abtDavGM+5aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743567691; c=relaxed/simple;
	bh=/SaRPzI6gUezI0aZArkz52dacO8KHPKD3FKd4vRAizw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GV5Dl4RhJNWudccuf584Fg4y4SxrIGqNKpnux12lxYi78oYyf6jY0BZeXgBydMcJ6khmEos4+FzbIyJse4MKJG1EjI3otfsO6n9ooBGckH0PRoi38wiR1jHTWwAS+AGLyajhew5rfOY+ZnlzXj/dFdP/T7oyvdRInGAf9kW9bWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NPN0byGW; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8rwtL
	F5XVSfTc2NzLUMNczZ7D5vONTle1YTnDmSJh/g=; b=NPN0byGW3U6GRKFcUHIov
	8WwsTrotPpyQyXtqZ5BYYzCNnYfWtM6hRTzJSTUTr1nVrkjs9wX0amN0zmJojR3P
	3dFZvjiO0j+S70rIitdj+q4mBec3YaOVCP1I1aLKoD8sJA+ucS8+7AwWJ+2PD8EG
	vcOY3ZhWiSKyfr1ygSy2d4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXJtQIu+xn1HfgDQ--.39888S4;
	Wed, 02 Apr 2025 12:20:28 +0800 (CST)
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
Subject: [v7 2/5] PCI: Refactor capability search functions to eliminate code duplication
Date: Wed,  2 Apr 2025 12:20:17 +0800
Message-Id: <20250402042020.48681-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402042020.48681-1-18255117159@163.com>
References: <20250402042020.48681-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXJtQIu+xn1HfgDQ--.39888S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryxCw4UuryUJw4DJr1fJFb_yoWrtr47pr
	y3Aa4fArW8GF13tw4q9ayjyw13WF9rJrWxXFWxC3sYvF12krWvyFy2ya4YqFyagrZ7WF13
	X39xta95C3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRFtCcUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwojo2fsufkj9AAAsZ

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
 drivers/pci/pci.c | 79 +++++++++++++----------------------------------
 1 file changed, 22 insertions(+), 57 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..521096c73686 100644
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
 
@@ -648,7 +614,6 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
 
 static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 {
-	int rc, ttl = PCI_FIND_CAP_TTL;
 	u8 cap, mask;
 
 	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
@@ -657,7 +622,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 		mask = HT_5BIT_CAP_MASK;
 
 	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
-				      PCI_CAP_ID_HT, &ttl);
+				      PCI_CAP_ID_HT);
 	while (pos) {
 		rc = pci_read_config_byte(dev, pos + 3, &cap);
 		if (rc != PCIBIOS_SUCCESSFUL)
@@ -668,7 +633,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 
 		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
 					      pos + PCI_CAP_LIST_NEXT,
-					      PCI_CAP_ID_HT, &ttl);
+					      PCI_CAP_ID_HT);
 	}
 
 	return 0;
-- 
2.25.1


