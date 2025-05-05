Return-Path: <linux-pci+bounces-27173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE33AA9941
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 18:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC34189EA74
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930F626C3AA;
	Mon,  5 May 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wj/mdwxp"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C98126B2C8;
	Mon,  5 May 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462904; cv=none; b=tPh65+HFfUYPCGctRKN8lW/bvkDyWODrvpyClXDCn8lJOdMqmE9wyYHE1DYCuSTH1R80gEWv2rykOtQ8UhrKB/YKZB7BZaPtXXvhTz0bDsPKO5wRQUL7UNDFqU4xB9QhlkkkHuW5HYbWvtBzZZGZ01cPx1M27FIHJZO6Z2XOsqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462904; c=relaxed/simple;
	bh=f4vkpqwBXeqSLzGWEvG2fMwEzwVnEcBxew60Bm5maG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msT/+TJbl5A3XZT0oNZUPJzEjG/gBiAdoConvMguthZmB1AiQFa4PH50+128gDMPKWXrQMZhnzbkWHipceHM8oFvwSZbAm9srP3LulKreudMSBZYJemIbVIpsVXN9YLpPtgUdYxKFdDNlOXrtxCf5MdbMapCwO4tNH0DnfZqync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wj/mdwxp; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pBVu+
	MtFx0k4qAhJWsazLeIdkIwIpetqt9OudzPJf+4=; b=Wj/mdwxpuGqe8Vdmfb+z+
	6/OL3UcKQe5toqw9oiXUTuF6buNU0NsvcmORvB6ggnZaqyRi5yL3jKtzPALauwQc
	Y4KqjCPkjAygICVES+OFeVR2QdXVhVJ052xZsC8xKTcCdWDIOtw/wRcDa70PVCAn
	G6K2+cuVUeC9JCkA74O5cU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDn+lmO6BhoumvGBw--.3540S7;
	Tue, 06 May 2025 00:34:27 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	kw@linux.com
Cc: cassel@kernel.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v11 5/6] PCI: cadence: Use common PCI host bridge APIs for finding the capabilities
Date: Tue,  6 May 2025 00:34:19 +0800
Message-Id: <20250505163420.198012-6-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505163420.198012-1-18255117159@163.com>
References: <20250505163420.198012-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDn+lmO6BhoumvGBw--.3540S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryrAF45uFWxCr15Jr1rXrb_yoW5ZF45pF
	WDGFyfCa1rJFW3uFs3A3W5Xr15tFnak347ta92kw12vF17Cr1UGF12gFy3Kr9xKrs7Wr13
	X3yDtFykKrn0yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKg4T5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOg9Eo2gY51gZBAAAsA

Use the PCI core is now exposing generic macros for the host bridges to
search for the PCIe capabilities, make use of them in the CDNS driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
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
index 39ee9945c903..56d6a0e73eb7 100644
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


