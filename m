Return-Path: <linux-pci+bounces-33943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1630EB24C51
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F946188801D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58DB1CEEBE;
	Wed, 13 Aug 2025 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TYq2u/nK"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9F194C96;
	Wed, 13 Aug 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096365; cv=none; b=JLUEIy9GFk7gsNv8uz6nslsDeiGSLJqbhdKbz6DMpl6dkeyPQbIqiIhGbEYL2nILtZimao4y9uVMdutlMbvgR6uZB3A/RUiSrxa43WiWfpKEhUn0ErbpS/3ViFdT1xXEDfO7S1ovahvoQP3H6FSAxLnje+Qp75SXyh+ZeBIJEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096365; c=relaxed/simple;
	bh=l2gadloVvDqcJ4qf17xS2gL04ZAoTDWXMLL+lnncYEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l3gXGcicCEj0vTqyNaXc52F1Jn8Zmi2mdoNx02nPtUCEMTEBa9BUBJTLMmlmJvZJS5NV2v20wkTEUW0iUO8o4XP36wBOzi2MUP7IKuvskWfmkdBelBQzhu1k2Hv225lUEIHwhGcyByYvKzYOBXaQnV9c6CQGBQpxPb7ja7cioUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TYq2u/nK; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Aa
	J7ZYraUwva+Y2MbvzC03H7C9O4Dlcvf44pgcVRoCs=; b=TYq2u/nKJAjDO20rLc
	yNZ6q7BxfpmGHgXFQkcp7uwk50oJ55wtoQhjZzos11D3NQh8TvlY2tuPFYRf/DPL
	NJEKky2vJY26kQYZ1BAFSft/h4O8v9xd3huMXK7Tb9ZYTsmCLUiU5qo6JGPvLBHC
	cMPoxROKoWUewotpgrovAMJ4A=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHYosMpZxo4mzXAw--.28032S7;
	Wed, 13 Aug 2025 22:45:37 +0800 (CST)
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
Subject: [PATCH v15 5/6] PCI: cadence: Use PCI core APIs to find capabilities
Date: Wed, 13 Aug 2025 22:45:28 +0800
Message-Id: <20250813144529.303548-6-18255117159@163.com>
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
X-CM-TRANSID:PigvCgDHYosMpZxo4mzXAw--.28032S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryrtFy3WF47Zr47Ww1fXrb_yoW5CryrpF
	WDGFyfG3WrJFW3uFn3Za45Xr13tFnaka47ta92k34xZF17Cr4UGF1agFy3KF9xKrs7Xr17
	X3yDtFyDGr13tFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pil4EiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhOoo2icmifhggAAsI

The PCI core now provides generic PCI_FIND_NEXT_CAP() and
PCI_FIND_NEXT_EXT_CAP() macros to search for PCI capabilities, using a
config accessor we supply; use them in the CDNS driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence.c | 14 ++++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 34 +++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 70a19573440e..c45585ae1746 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -8,6 +8,20 @@
 #include <linux/of.h>
 
 #include "pcie-cadence.h"
+#include "../../pci.h"
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
index 1d81c4bf6c6d..71e203de1087 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -367,6 +367,37 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
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
+static inline int cdns_pcie_read_cfg_byte(struct cdns_pcie *pcie, int where,
+					  u8 *val)
+{
+	*val = cdns_pcie_readb(pcie, where);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static inline int cdns_pcie_read_cfg_word(struct cdns_pcie *pcie, int where,
+					  u16 *val)
+{
+	*val = cdns_pcie_readw(pcie, where);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static inline int cdns_pcie_read_cfg_dword(struct cdns_pcie *pcie, int where,
+					   u32 *val)
+{
+	*val = cdns_pcie_readl(pcie, where);
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
 {
 	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
@@ -536,6 +567,9 @@ static inline void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
 }
 #endif
 
+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
 
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
-- 
2.25.1


