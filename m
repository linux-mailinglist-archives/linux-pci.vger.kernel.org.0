Return-Path: <linux-pci+bounces-25106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE31CA78731
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 06:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F92F1891BE3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 04:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C53231A3F;
	Wed,  2 Apr 2025 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Et+lI8xd"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1EE231A23;
	Wed,  2 Apr 2025 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743567691; cv=none; b=GX9/80RVLoRrAHUNIMGPSxTvN+zbn2gVdUmjX3bRai1xSFcVn+QfQbbtiweLmcvh3qxw6diurBpN2qD8mmbMET8cqUT5M8Bw3Mfz0R8OU8zyr29gscez3etWVbL+vaH2yhvuBXrIiY+XRx3YPsfXpENtK1nsySuN2DLSX6cqNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743567691; c=relaxed/simple;
	bh=Yuqvp68rdEEpleUzC6uc5JIop0Sh8kw0dPFfNujvun8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dk8zNW+Bftv84+m+iRwj28WpC8kT3+1cklmbeRMFrRYbtyGAwWI6Kf5kbNtwDHlnd6D9GB3oNa3DEQRDpoJ52MgOKxzwOdz1GLiMLTrKWKeST3qNWQyacWX/hm7QgpsUY+w8ZOCaanJ6/1chT9EducijOiH51636mG8Op2l3mW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Et+lI8xd; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mVR7d
	PI1RpCG5sh48f+87uNK1JGB6AwPUiNiO+gfKo0=; b=Et+lI8xdRbPITf6JdTCN6
	zidFDm2F2tSxK/HJGKHC9ON7IYcYoCWYiBrVMn6C2MUycnfkb1Ktak2DTzmS5SIb
	EufHdfmzRnEGrerwO1JxId/vRBHONlYg32F8rwsK0JjvjW7AhL7bjYxJS7upLNii
	hwgDs31leyiZsyAEvI6CdA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXJtQIu+xn1HfgDQ--.39888S3;
	Wed, 02 Apr 2025 12:20:26 +0800 (CST)
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
Subject: [v7 1/5] PCI: Refactor capability search into common macros
Date: Wed,  2 Apr 2025 12:20:16 +0800
Message-Id: <20250402042020.48681-2-18255117159@163.com>
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
X-CM-TRANSID:_____wBXJtQIu+xn1HfgDQ--.39888S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryxuFW7WFW3ZF4rCF4xXrb_yoWrAF1kpr
	95WF1Sy395Ja129wnxZa18Krya9a97Aay29rWxGw15XFyDC3WxGF4FkFy2gFy7trZrAF13
	Xw1qvFyru3ZIyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zReBT5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgIjo2fsusgILwAAsm

Introduce PCI_FIND_NEXT_CAP_TTL and PCI_FIND_NEXT_EXT_CAPABILITY macros
to consolidate duplicate PCI capability search logic found throughout the
driver tree. This refactoring:

  1. Eliminates code duplication in capability scanning routines
  2. Provides a standardized, maintainable implementation
  3. Reduces error-prone copy-paste implementations
  4. Maintains identical functionality to existing code

The macros abstract the low-level capability register scanning while
preserving the existing PCI configuration space access patterns. They will
enable future conversions of multiple capability search implementations
across various drivers (e.g., PCI core, controller drivers) to use
this centralized logic.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.h             | 81 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |  2 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e9cf26a9ee9..f705b8bd3084 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -89,6 +89,87 @@ bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
 
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
+	u8 __pos = (start);						\
+	int __ttl = PCI_FIND_CAP_TTL;					\
+	u16 __ent;							\
+	u8 __found_pos = 0;						\
+	u8 __id;							\
+									\
+	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
+									\
+	while (__ttl--) {						\
+		if (__pos < PCI_STD_HEADER_SIZEOF)			\
+			break;						\
+		__pos = ALIGN_DOWN(__pos, 4);				\
+		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
+		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
+		if (__id == 0xff)					\
+			break;						\
+		if (__id == (cap)) {					\
+			__found_pos = __pos;				\
+			break;						\
+		}							\
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
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..a11ebbab99fc 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -206,6 +206,8 @@
 /* 0x48-0x7f reserved */
 
 /* Capability lists */
+#define PCI_CAP_ID_MASK		0x00ff
+#define PCI_CAP_LIST_NEXT_MASK	0xff00
 
 #define PCI_CAP_LIST_ID		0	/* Capability ID */
 #define  PCI_CAP_ID_PM		0x01	/* Power Management */
-- 
2.25.1


