Return-Path: <linux-pci+bounces-24299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D24A6B38E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 05:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640FA3B7A2B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 04:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9682A1CF;
	Fri, 21 Mar 2025 04:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZLuJGqvM"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D5F4120B;
	Fri, 21 Mar 2025 04:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529893; cv=none; b=NB3jxI8RvnEAI29NHLI5Sa7Wj1vUKvVNwRTkgtcQNxPt8pNxcB3BAn9XaIlMH8e99X0IZ49PFwZhgeAkl0Nu83T6JfGZXgOaZQDXF+Gvv33AogNj0m1pXubjL9aGkfWek8umWBaijfU+DFM+Jc34Duul9yZMrVXz+W3czpb0zCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529893; c=relaxed/simple;
	bh=kKaeIwqRQTK/Z3a1vplSclrEskxqJxM0XWjs825IJok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iga7xoufVFOQZbv4dl43gQVlGzR+wetDKvllbFECl6qouC4t8b8k1AQK3MSh1aEDLdYCbAfwmUrNHwoqxNEkSZqfD5FIdiDoxOWYqtpX09v/7RedgMjLf1t7VYau/T53moTaLHyVbvrr/p2DrBjHGAK8qc5pXo302TPNCRnTAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZLuJGqvM; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Iu8sw
	yOIw5K+t0r0RVA6DVR/ICbwmaceAEuARoTDftY=; b=ZLuJGqvMuC8a8HIxYAM5+
	uvAZI7Nndbi51CukyDdpmFTBbHZzFQ7zpfmwaXo9BEhI3cDy3LHjLYwzX+TperhW
	NCeMABBWacnJ/teTV4OSExAk66+2cqaFkmDtHWxvZGYs/J6MRxJ/aqDVvTnNyPCT
	NQDw8afxRiYvk27ZlMMCek=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3Hxsw5dxnbYNpAw--.34788S3;
	Fri, 21 Mar 2025 12:04:02 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v3 1/4] PCI: Introduce generic capability search functions
Date: Fri, 21 Mar 2025 12:03:55 +0800
Message-Id: <20250321040358.360755-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321040358.360755-1-18255117159@163.com>
References: <20250321040358.360755-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Hxsw5dxnbYNpAw--.34788S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF4fuFyrCr4fAw1ftw45Awb_yoW7GF1rpF
	Z5AF15A3yrGF47trsIvF4qyr13XrZ2vFWxtFWxC3sYvr12ywn5KryI9345tF12yrs2gF13
	trZrtFZ5Cr1ktaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR7fHUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxUXo2fc32Nz2QACsB

Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
duplicate logic for scanning PCI capability lists. This creates
maintenance burdens and risks inconsistencies.

To resolve this:

1. Add pci_generic_find_capability() and pci_generic_find_ext_capability()
in drivers/pci/pci.c, accepting controller-specific read functions
and device data as parameters.

2. Refactor dwc_pcie_find_capability() and similar functions to utilize
these new generic interfaces.

3. Update out-of-tree drivers to leverage the common implementation,
eliminating code duplication.

This approach:
- Centralizes critical PCI capability scanning logic
- Allows flexible adaptation to varied hardware access methods
- Reduces future maintenance overhead
- Aligns with kernel code reuse best practices

Tested with DWC PCIe controller and CDNS PCIe drivers.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c   | 83 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h | 13 ++++++-
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..d686d89d211e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -612,6 +612,89 @@ u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
 }
 EXPORT_SYMBOL_GPL(pci_find_ext_capability);
 
+/*
+ * These interfaces resemble the pci_find_*capability() interfaces, but these
+ * are for configuring host controllers, which are bridges *to* PCI devices but
+ * are not PCI devices themselves.
+ */
+static u8 __pci_generic_find_next_cap(void *priv, pci_generic_read_cfg read_cfg,
+				      u8 cap_ptr, u8 cap)
+{
+	u8 cap_id, next_cap_ptr;
+	u16 reg;
+
+	if (!cap_ptr)
+		return 0;
+
+	reg = read_cfg(priv, cap_ptr, 2);
+	cap_id = (reg & 0x00ff);
+
+	if (cap_id > PCI_CAP_ID_MAX)
+		return 0;
+
+	if (cap_id == cap)
+		return cap_ptr;
+
+	next_cap_ptr = (reg & 0xff00) >> 8;
+	return __pci_generic_find_next_cap(priv, read_cfg, next_cap_ptr, cap);
+}
+
+u8 pci_generic_find_capability(void *priv, pci_generic_read_cfg read_cfg,
+			       u8 cap)
+{
+	u8 next_cap_ptr;
+	u16 reg;
+
+	reg = read_cfg(priv, PCI_CAPABILITY_LIST, 2);
+	next_cap_ptr = (reg & 0x00ff);
+
+	return __pci_generic_find_next_cap(priv, read_cfg, next_cap_ptr, cap);
+}
+EXPORT_SYMBOL_GPL(pci_generic_find_capability);
+
+static u16 pci_generic_find_next_ext_capability(void *priv,
+						pci_generic_read_cfg read_cfg,
+						u16 start, u8 cap)
+{
+	u32 header;
+	int ttl;
+	int pos = PCI_CFG_SPACE_SIZE;
+
+	/* minimum 8 bytes per capability */
+	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
+
+	if (start)
+		pos = start;
+
+	header = read_cfg(priv, pos, 4);
+	/*
+	 * If we have no capabilities, this is indicated by cap ID,
+	 * cap version and next pointer all being 0.
+	 */
+	if (header == 0)
+		return 0;
+
+	while (ttl-- > 0) {
+		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
+			return pos;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+		if (pos < PCI_CFG_SPACE_SIZE)
+			break;
+
+		header = read_cfg(priv, pos, 4);
+	}
+
+	return 0;
+}
+
+u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg read_cfg,
+				    int cap)
+{
+	return pci_generic_find_next_ext_capability(priv, read_cfg, 0, cap);
+}
+EXPORT_SYMBOL_GPL(pci_generic_find_ext_capability);
+
 /**
  * pci_get_dsn - Read and return the 8-byte Device Serial Number
  * @dev: PCI device to query
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..48c2b45a4d04 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1205,6 +1205,11 @@ u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
 u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
 u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
+typedef u32 (*pci_generic_read_cfg)(void *priv, int where, int size);
+u8 pci_generic_find_capability(void *priv, pci_generic_read_cfg read_cfg,
+			       u8 cap);
+u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg read_cfg,
+				    u8 cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
 u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec);
@@ -2012,7 +2017,13 @@ static inline u8 pci_find_next_capability(struct pci_dev *dev, u8 post, int cap)
 { return 0; }
 static inline u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
 { return 0; }
-
+typedef u32 (*pci_generic_read_cfg)(void *priv, int where, int size);
+u8 pci_generic_find_capability(void *priv, pci_generic_read_cfg read_cfg,
+			       u8 cap)
+{ return 0; }
+u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg read_cfg,
+				    u8 cap)
+{ return 0; }
 static inline u64 pci_get_dsn(struct pci_dev *dev)
 { return 0; }
 
-- 
2.25.1


