Return-Path: <linux-pci+bounces-25162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C187A78EAE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 14:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46EAC7A4B29
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D5E23A980;
	Wed,  2 Apr 2025 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jwkGt0WP"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EBB1E50B;
	Wed,  2 Apr 2025 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743597499; cv=none; b=F2FeFl1DVo12I4HIdy9DmFeqrAfYkZalF6muvuxvNgcJ77tKWc6yGd8xqVyylTE4MYNZY7G4vbAfwFNdCR7ZLQHqE/diIw2gvLO6NR7tDsx8N8JfFFFRz/sNPFJEy/cuO2vXAbCxGkmjADFSdIVFGEw6N5liSOEjR9AodyoyjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743597499; c=relaxed/simple;
	bh=5YJ+DGr2a8YWmta1Z2PAjUg6L4azxe6UAUJAoQbFhcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VhxkeB+BSDZHlMypGmUMld0P+W4UjiCk3lVJGpwcLEeexGvaME+8pn20mHRfVG5JeeVmiX597sJCUEk96zePTGBP06t//mJp188LITXloUIEtoLZ7GTjyEg74s3sAQPO7EsbC03UiRd3zrXSN9p4+QVYyGekRf3/5TNoltIMKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jwkGt0WP; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CoW96
	e1Gmdd0kpTwykWsVW5WBGKPsLmM7zi76qOXnbA=; b=jwkGt0WPt55zHU5QzhJdP
	TBzkXf2OtItXw580fbx2S0E87U57hNGLts9+icypahA7F4wVWF00k1gcvYJRlHSe
	06D4ll+VoJRotYGCgsqlgNRk45tc2NL6wdfAVIiUB8FNJzl1DvDiIXtEy46p7ztS
	Pg2oiNme9hfVk64o9VyIho=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCXrkiUL+1nL3+IAA--.22499S6;
	Wed, 02 Apr 2025 20:37:50 +0800 (CST)
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
Subject: [v8 4/5] PCI: cadence: Use common PCI host bridge APIs for finding the capabilities
Date: Wed,  2 Apr 2025 20:37:35 +0800
Message-Id: <20250402123736.55995-5-18255117159@163.com>
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
X-CM-TRANSID:PCgvCgCXrkiUL+1nL3+IAA--.22499S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryrAr48Cw4rur1kCF4UJwb_yoW5Cw1fpF
	WDGFyfCF1rJFW3uFs3Z3W5Xr13tFnay347ta92k347ZF17Cr1UGFy2gFy3tr9xKrs7Gr13
	X3yDtFykKrn0yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziID7hUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwsjo2ftJx3gbQABs4

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


