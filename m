Return-Path: <linux-pci+bounces-29151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC309AD0E7B
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F377A799D
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECB0213E94;
	Sat,  7 Jun 2025 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dhAPJ0wE"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BF01990A7;
	Sat,  7 Jun 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312879; cv=none; b=m+rq81b+Njpkm1J17IWEXwvRD75lz4xeqfMLiMJzTLdpxWvBIPve5z0035YM6+FpPiMGE9j3a/2/8ao34m5UFpxk74fnnVhn0P/DxyED8aUyLGpP9MXS+U5YuvfRRrEXQSNXmaKEQyd+fVOnlt40RByrVWE4qNLXwITha5EiY/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312879; c=relaxed/simple;
	bh=m5LVRSiV4O+mgO9aljggdoVFKYIXnhDMrYz6/KNbiDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YfMtMdBsM1Mv0o3pI0cM0nrkF0gDelp4fUX3TxFsUFUeWFhjtaSYibAbGtggDgg8bL4xlTRPoYznzM111qjQVz3bWMN+yTv2SuvMwx5hkALXCzGt8s/Pawr1t9nF8GXsR7SXFDMuSaX27PWllbkclQGP9VNEPfj0rUaRFHDehPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dhAPJ0wE; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=FO
	SHr1PcbnEECb/jKlEUKH21O31HhmWFUyfLGKeAUfU=; b=dhAPJ0wEznyAVsfxXS
	aH1RwqBgiO7Vl8mH2qpHhj7uvJbG9TkXw3PHFSxrd0Vv7b8bGu/jLOs4DlkL3j9k
	snV/vOfMEn35jd0cjidraP1pylzLKC3Qg/9XICYko+ncEp+JWTUgNqESbcD1g9o3
	VGEA31v4vIp9Wya2+c2RpUaDY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHuXJPZURoL9paGw--.4161S7;
	Sun, 08 Jun 2025 00:14:13 +0800 (CST)
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
Subject: [PATCH v13 5/6] PCI: cadence: Use common PCI host bridge APIs for finding the capabilities
Date: Sun,  8 Jun 2025 00:14:04 +0800
Message-Id: <20250607161405.808585-6-18255117159@163.com>
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
X-CM-TRANSID:_____wBHuXJPZURoL9paGw--.4161S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxury7Ww48Ar17Cw4Duw13CFg_yoW5tF4DpF
	WDCFyfCF1rJFW3uFn3A3W5Xr13tFn3C347ta92kw1xZF17Cr1UGFnFgFy3Kr9xKrs7Wr17
	X3yDJF4kGrn0yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pN0PTQUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhZlo2hEXNrG1wABsQ

Use the PCI core is now exposing generic macros for the host bridges to
search for the PCIe capabilities, make use of them in the CDNS driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v12:
- Modify the function's return value.

Changes since v11:
- Modify the return value of cdns_pcie_readw from u32 to u16. 
- Modify the return value of cdns_pcie_readb from u32 to u8. 

Changes since v8 ~ v10:
- None

Changes since v7:
- Resolve compilation errors.

Changes since v6:
https://lore.kernel.org/linux-pci/20250323164852.430546-4-18255117159@163.com/

- The patch commit message were modified.

Changes since v5:
https://lore.kernel.org/linux-pci/20250321163803.391056-4-18255117159@163.com

- Kconfig add "select PCI_HOST_HELPERS"
---
 drivers/pci/controller/cadence/pcie-cadence.c | 30 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 13 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 70a19573440e..c72bc886dbb4 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -8,6 +8,36 @@
 #include <linux/of.h>
 
 #include "pcie-cadence.h"
+#include "../../pci.h"
+
+static int cdns_pcie_read_cfg(void *priv, int where, int size, u32 *val)
+{
+	struct cdns_pcie *pcie = priv;
+
+	if (size == 4)
+		*val = cdns_pcie_readl(pcie, where);
+	else if (size == 2)
+		*val = cdns_pcie_readw(pcie, where);
+	else if (size == 1)
+		*val = cdns_pcie_readb(pcie, where);
+	else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return PCI_FIND_NEXT_CAP_TTL(cdns_pcie_read_cfg, PCI_CAPABILITY_LIST,
+				     cap, pcie);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_find_capability);
+
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return PCI_FIND_NEXT_EXT_CAPABILITY(cdns_pcie_read_cfg, 0, cap, pcie);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_find_ext_capability);
 
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
 {
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index a149845d341a..38f7a8cdf7f1 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -387,6 +387,16 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
 	return readl(pcie->reg_base + reg);
 }
 
+static inline u16 cdns_pcie_readw(struct cdns_pcie *pcie, u32 reg)
+{
+	return readw(pcie->reg_base + reg);
+}
+
+static inline u8 cdns_pcie_readb(struct cdns_pcie *pcie, u32 reg)
+{
+	return readb(pcie->reg_base + reg);
+}
+
 static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
 {
 	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
@@ -556,6 +566,9 @@ static inline void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
 }
 #endif
 
+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
 
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
-- 
2.25.1


