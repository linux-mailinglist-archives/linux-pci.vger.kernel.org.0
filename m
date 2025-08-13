Return-Path: <linux-pci+bounces-33949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BBEB24C76
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CB91776E6
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81782F83BF;
	Wed, 13 Aug 2025 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QseZD5gY"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239FC2F0680;
	Wed, 13 Aug 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096372; cv=none; b=LUVUXHbMPvQWCiF1GAYTxZBIQLNZKrBrRE0ivR8CDjmhaC2o/N8HrQmglWA460T4XT6r4xit/O7TgTDyXc/MwcJ4NyFVaxu7GOL7TcYRAlGjYD/buCofaqqER7x8q0ZiCukm850HqxSLDoJ411qP9ZwB7FHyhMa3j7etbN8uwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096372; c=relaxed/simple;
	bh=i+edq/ldTcMNEw8zyx3cR7PrSZVnkLZXE1x9RMyPmmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EoHPdMrUg6WwjS8F8Ecf8tAiplNk52JbwVmLjeT1sfTTLfVfC1vW1Km/NiMsLCYujIyqwgaHVMCPHzssEW75Niv88UGvuyx5aZkBRLtYsrbLEXvfQ57i2rcX482Z4q8t6pkOxFbm1vnxjxG229eil9H06Ajg5OSUAnlNTne6eBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QseZD5gY; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0+
	nzkjktRLVanoz16moHD5Kd1AcToEBpo22VbFhl3Lc=; b=QseZD5gY9mhHdOMLyI
	52lb6Y+Fb7ImBxgnMLYQNZk1phAmy27TrWgBLnIukOrGF0qbJkMnxqnkrOlmzJjk
	OqrBOk/jRisUfHpUbucT+VtxlMBlDV+Z8EDptZZPoGBR7xCJCj/JIy8ZvKeNWg1n
	Ush2PdsLC0h8EnU4SOI6uWfdQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHYosMpZxo4mzXAw--.28032S5;
	Wed, 13 Aug 2025 22:45:35 +0800 (CST)
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
Subject: [PATCH v15 3/6] PCI: Refactor extended capability search into PCI_FIND_NEXT_EXT_CAP()
Date: Wed, 13 Aug 2025 22:45:26 +0800
Message-Id: <20250813144529.303548-4-18255117159@163.com>
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
X-CM-TRANSID:PigvCgDHYosMpZxo4mzXAw--.28032S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyrtry3Ar48Zr4kCryxGrg_yoW5tr15p3
	y3A3WSyryrJa12qwsIva1jgF1Ygan7CFW7WFWxG34rXFyDCw13Gr1fKaySgFy7trZruF1f
	XFs5AF4rC3ZxAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zikhLnUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOg6oo2icmifhSgABsc

Move the extended Capability search logic into a PCI_FIND_NEXT_EXT_CAP()
macro that accepts a config space accessor function as an argument. This
enables controller drivers to perform Capability discovery using their
early access mechanisms prior to full device initialization while sharing
the Capability search code.

Convert the existing PCI core extended Capability search implementation to
use PCI_FIND_NEXT_EXT_CAP().

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c | 35 ++---------------------------------
 drivers/pci/pci.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ac2658d946ea..e698278229f2 100644
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
index 81580987509f..7fb44faf2c44 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -133,6 +133,46 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
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
+ * Search the extended capability list in PCI config space to find @cap.
+ * Implements TTL protection against infinite loops using a calculated
+ * maximum search count.
+ *
+ * Return: Position of the capability if found, 0 otherwise.
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
+		__ret = read_cfg##_dword(args, __pos, &__header);	\
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


