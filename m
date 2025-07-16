Return-Path: <linux-pci+bounces-32294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C2DB07AD1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D641894C87
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4082A2F532D;
	Wed, 16 Jul 2025 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y0pFeMZO"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC251A2541;
	Wed, 16 Jul 2025 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682360; cv=none; b=pYaXMAT/BjMS//++xjv+Z2gyLeeRcmnAp63N1doVnOXsTEG1uMGEeHMbjisPo93x/5Me76T72p/mlYDePGB/NpgfC8njXSqZ6HpbWW7db1ncfUoeP4lq8a5MfkaCYUNPea7NF5GySaBtEoPqAJhRCmIyuSV3wOSObZJheyXSfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682360; c=relaxed/simple;
	bh=i0U1QoZbUHprU/1Nv3qGW39aq37fpJdJY8SqLfGBog0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I9eafiMyMOPNWHtkf4IVGVRXOlPfFcG10lI9JFZ7Qp0vCR+5WzBeDYezZoKMqdb899BL+u7TuwiP2MFJqVw5vXivGKv75T77aeDhRxNI9E6KY/Wq4kos39vNoKtUtlIni9+g0PLJONSNZTanTs1T6Q6Nq6Y5k6zmQ8dfeiD+RwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y0pFeMZO; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GV
	Q0323Nn1M9IDYH7NXWemN+paiqm2b9W8SsF4nbxjI=; b=Y0pFeMZO/vCLCq+8eS
	vBi2gA2ga3zG5tvHR0YDd+t72QG6nweLLeXu/WqZ25F7UggpVIoLP4RH7qU2CNQt
	VCoufUFUm1wn37qKVPgx31L9tJuVVrNeppDboUV3QLI2a+k3Q4Ql4qyWZCRZGKR5
	z5uVe/k9W8xLfvIzFBt39x5b4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnMkhWz3doF6jWAw--.24466S8;
	Thu, 17 Jul 2025 00:12:13 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v14 6/7] PCI: cadence: Use common PCI host bridge APIs for finding the capabilities
Date: Thu, 17 Jul 2025 00:12:02 +0800
Message-Id: <20250716161203.83823-7-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716161203.83823-1-18255117159@163.com>
References: <20250716161203.83823-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnMkhWz3doF6jWAw--.24466S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxury7Ww48Ar17Cw4Duw13CFg_yoW5Kw17pF
	WDCFyfCF1rJFW3uFn3A3W5Xr13tFnak342ya92kw17ZF17ur1UGFnFgFy3Kr9xKrsrWr17
	X3yDJFykKr1YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEwvtiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhmMo2h3yLuC+AAAsa

Use the PCI core is now exposing generic macros for the host bridges to
search for the PCIe capabilities, make use of them in the CDNS driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
Changes since v13:
- Use simplified macro definitions: PCI_FIND_NEXT_CAP(), PCI_FIND_NEXT_EXT_CAP().

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
index 70a19573440e..7b2955e4fafb 100644
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
+	return PCI_FIND_NEXT_CAP(cdns_pcie_read_cfg, PCI_CAPABILITY_LIST,
+				 cap, pcie);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_find_capability);
+
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return PCI_FIND_NEXT_EXT_CAP(cdns_pcie_read_cfg, 0, cap, pcie);
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


