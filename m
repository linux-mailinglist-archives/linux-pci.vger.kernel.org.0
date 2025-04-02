Return-Path: <linux-pci+bounces-25104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7E0A7872B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 06:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712C93AE6D9
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 04:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A562C230BF7;
	Wed,  2 Apr 2025 04:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WlR6WjiZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF62230BEE;
	Wed,  2 Apr 2025 04:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743567686; cv=none; b=Fz9hymF6ZIaUUtO/ABuqiLhF0tf6sSmsqO0HV1burUvxlbEJsUYADOYLFbx0kzDmRUT8L8S5gQ14ZXH9xzp/64XDhy8XPqjQuwFU78j0NcAy8PQt7H5cTZdawLVbFEB6StnVhgHJX08LP2P+3/TzozVN/odrh/i14YAHWZz5IiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743567686; c=relaxed/simple;
	bh=5YJ+DGr2a8YWmta1Z2PAjUg6L4azxe6UAUJAoQbFhcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzwa95x7PAExk8Q4Wx4Mu3XFBpElRITM/EWhJkk/ZRC2Yb2hyjo3oArl5py6TVV68G9qrtp6kw7EFzM66js9bgUdIkkPLe1/bu+Z/+8H5jujlUlpcK+SYdgai/K0pYJCSGgR9TV/v1Yp8bz7ASWD8puBq27l/NY4zGWTDN7oP4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WlR6WjiZ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CoW96
	e1Gmdd0kpTwykWsVW5WBGKPsLmM7zi76qOXnbA=; b=WlR6WjiZILebP4ieDU5rV
	M1NDJ59oJk4N/1xyaQtrg5ivrMl/lXR+iFMvTvMulRELieB08utvgGy3oIoGTsNG
	VUHXXGMfTGeXGVn7QJmE0hS2ySC3r6pxDoB6ddWxUtufbYs32xmB6dwHNXfb3AhB
	BDhRkpZGvyVF2SmLbXfpak=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXJtQIu+xn1HfgDQ--.39888S6;
	Wed, 02 Apr 2025 12:20:30 +0800 (CST)
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
Subject: [v7 4/5] PCI: cadence: Use common PCI host bridge APIs for finding the capabilities
Date: Wed,  2 Apr 2025 12:20:19 +0800
Message-Id: <20250402042020.48681-5-18255117159@163.com>
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
X-CM-TRANSID:_____wBXJtQIu+xn1HfgDQ--.39888S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryrAr48Cw4rur1kCF4UJwb_yoW5Cw1fpF
	WDGFyfCF1rJFW3uFs3Z3W5Xr13tFnay347ta92k347ZF17Cr1UGFy2gFy3tr9xKrs7Gr13
	X3yDtFykKrn0yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziSfOsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxcjo2fstXLRZAAAs1

Use the PCI core is now exposing generic macros for the host bridges to
search for the PCIe capabilities, make use of them in the CDNS driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v6:
https://lore.kernel.org/linux-pci/20250323164852.430546-4-18255117159@163.com/

- The patch commit message were modified.

Changes since v5:
https://lore.kernel.org/linux-pci/20250321163803.391056-4-18255117159@163.com

- Kconfig add "select PCI_HOST_HELPERS"
---
 drivers/pci/controller/cadence/pcie-cadence.c | 28 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 13 +++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 204e045aed8c..ca4a1a809fcb 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -7,6 +7,34 @@
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
index f5eeff834ec1..dd7cb6b6b291 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -398,6 +398,16 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
 	return readl(pcie->reg_base + reg);
 }
 
+static inline u32 cdns_pcie_readw(struct cdns_pcie *pcie, u32 reg)
+{
+	return readw(pcie->reg_base + reg);
+}
+
+static inline u32 cdns_pcie_readb(struct cdns_pcie *pcie, u32 reg)
+{
+	return readb(pcie->reg_base + reg);
+}
+
 static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
 {
 	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
@@ -557,6 +567,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 }
 #endif
 
+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
 
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
-- 
2.25.1


