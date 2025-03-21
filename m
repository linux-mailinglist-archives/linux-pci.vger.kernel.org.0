Return-Path: <linux-pci+bounces-24375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8517AA6C02D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C767E7A3C03
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D301EBA1E;
	Fri, 21 Mar 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RnevxSoX"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B49322D4E2;
	Fri, 21 Mar 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575120; cv=none; b=PowJTGNLG9h8VaQPtuhgKzlwbpQkWZ4RuJCRX8HAuY1UdAbvrI/tMRoiq8fwjjJs3CD/sXsIPFnw9XGT53hlUhHUM4kWM/VIAFFcSs49ZS8sHbGsdGpS08DNoos3lozM6ZFPd80dDYJS1030Q6lM0NJxtEDFIBWVJEoxX8G/SLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575120; c=relaxed/simple;
	bh=xPNYg3cMNd2hepZk+/icfw/kZYS6o4UEMPjYycNaUMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=II0Tku2xV0/GIhokea2jovrm7e38RGE25U6U2v9Kz9WQBUNefMv9x4sjPWGTwlLFkjYlumuSGY3yoBl44kTaYq9SCsdbKWy411IDh7l0EedD5sAeaGO9IWWPyGcMFrC0EGDHA6rzC7FEhGtibnDNRXzJDdy6fCTzvWpBrhT64xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RnevxSoX; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=97101
	Q/idF1/FmnK1pczrU+vUH7afq9gW82c3qeXiAg=; b=RnevxSoXATKcnHrY6XFfF
	M11S3ewmOALXDkW0ayIEw0RGXuxo4YDQk+G7zgaKzO74rfnlL/Ug1wqWSM7suber
	eiyQh901WMbfYVrZLY2xn8NRuzB7HFjISQspf+RrvQjFQrC0jGA9daxBOxw/a2rV
	inunhjv2sDr/ytBcUn+tKg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wC30e7sld1nnmPrAw--.48109S3;
	Sat, 22 Mar 2025 00:38:05 +0800 (CST)
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
Subject: [v5 1/4] PCI: Introduce generic capability search functions
Date: Sat, 22 Mar 2025 00:38:00 +0800
Message-Id: <20250321163803.391056-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321163803.391056-1-18255117159@163.com>
References: <20250321163803.391056-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC30e7sld1nnmPrAw--.48109S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr1rGrWkArWUtF48uFWrAFb_yoW7GFWDpr
	ZYy3W5J3yrGF42qwsFvF4jyr15WrZ2qrWfAFZ7C34Fvw1Iy3WFgas29a45tF17AFsrWF13
	JFW7trZYkr1DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEMa0PUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwwXo2fdjwDOpgAAs+

Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
duplicate logic for scanning PCI capability lists. This creates
maintenance burdens and risks inconsistencies.

To resolve this:

Add pci_host_bridge_find_*capability() in drivers/pci/pci.c, accepting
controller-specific read functions and device data as parameters.

This approach:
- Centralizes critical PCI capability scanning logic
- Allows flexible adaptation to varied hardware access methods
- Reduces future maintenance overhead
- Aligns with kernel code reuse best practices

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v4:
https://lore.kernel.org/linux-pci/20250321101710.371480-2-18255117159@163.com

- Resolved [v4 1/4] compilation warning.
- The patch commit message were modified.
---
 drivers/pci/pci.c   | 86 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h | 16 ++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..5ed31d723a45 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -612,6 +612,92 @@ u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
 }
 EXPORT_SYMBOL_GPL(pci_find_ext_capability);
 
+/*
+ * These interfaces resemble the pci_find_*capability() interfaces, but these
+ * are for configuring host controllers, which are bridges *to* PCI devices but
+ * are not PCI devices themselves.
+ */
+static u8 __pci_host_bridge_find_next_cap(void *priv,
+					  pci_host_bridge_read_cfg read_cfg,
+					  u8 cap_ptr, u8 cap)
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
+	return __pci_host_bridge_find_next_cap(priv, read_cfg, next_cap_ptr,
+					       cap);
+}
+
+u8 pci_host_bridge_find_capability(void *priv,
+				   pci_host_bridge_read_cfg read_cfg, u8 cap)
+{
+	u8 next_cap_ptr;
+	u16 reg;
+
+	reg = read_cfg(priv, PCI_CAPABILITY_LIST, 2);
+	next_cap_ptr = (reg & 0x00ff);
+
+	return __pci_host_bridge_find_next_cap(priv, read_cfg, next_cap_ptr,
+					       cap);
+}
+EXPORT_SYMBOL_GPL(pci_host_bridge_find_capability);
+
+static u16 pci_host_bridge_find_next_ext_capability(
+	void *priv, pci_host_bridge_read_cfg read_cfg, u16 start, u8 cap)
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
+u16 pci_host_bridge_find_ext_capability(void *priv,
+					pci_host_bridge_read_cfg read_cfg,
+					u8 cap)
+{
+	return pci_host_bridge_find_next_ext_capability(priv, read_cfg, 0, cap);
+}
+EXPORT_SYMBOL_GPL(pci_host_bridge_find_ext_capability);
+
 /**
  * pci_get_dsn - Read and return the 8-byte Device Serial Number
  * @dev: PCI device to query
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..e4e8d437a864 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1205,6 +1205,12 @@ u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
 u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
 u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
+typedef u32 (*pci_host_bridge_read_cfg)(void *priv, int where, int size);
+u8 pci_host_bridge_find_capability(void *priv,
+				   pci_host_bridge_read_cfg read_cfg, u8 cap);
+u16 pci_host_bridge_find_ext_capability(void *priv,
+					pci_host_bridge_read_cfg read_cfg,
+					u8 cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
 u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec);
@@ -2012,7 +2018,15 @@ static inline u8 pci_find_next_capability(struct pci_dev *dev, u8 post, int cap)
 { return 0; }
 static inline u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
 { return 0; }
-
+typedef u32 (*pci_host_bridge_read_cfg)(void *priv, int where, int size);
+static inline u8
+pci_host_bridge_find_capability(void *priv, pci_host_bridge_read_cfg read_cfg,
+				u8 cap);
+{ return 0; }
+static inline u16
+pci_host_bridge_find_ext_capability(void *priv,
+				    pci_host_bridge_read_cfg read_cfg, u8 cap);
+{ return 0; }
 static inline u64 pci_get_dsn(struct pci_dev *dev)
 { return 0; }
 
-- 
2.25.1


