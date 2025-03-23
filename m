Return-Path: <linux-pci+bounces-24469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A40A6D014
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 17:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27051893047
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F6115886C;
	Sun, 23 Mar 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pMjjEGGd"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25501519BD;
	Sun, 23 Mar 2025 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742748625; cv=none; b=jGJy8J6G1qs2uxjmg6tTcTvqADWuwgQd16Yn5ODbsHOJF2yoPQ+wOxmLS5zspDmgwpy+mzHenxu4sG7kA3zCA1b2jbP+fuSQ2+znzCbdSA4KrOP7w9hNiu+i+WaChWvI4l3991RPFWlpkwA1GCITYu++BzCfKJscJNaC0qQtl38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742748625; c=relaxed/simple;
	bh=jMT+KAGX2sw6R2Dh92dbrmSzCyTEYmf9uIPdgFLH+Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5IX/MsJNAR00mbtX5Pp1b2UTGECd8ciEvkq5tG43ak7nH18gaVQd/pfnb6K92+L4CGsRKF4DhPHgjuKNW1LAMsZn2Qgpi0xV2ESbk/TxkoeUHgNtgUUfVY9TMpNdVDoM83EbrPtuQkAwGa8khxqcndiBwXYOkWXPNZowu1u/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pMjjEGGd; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mYrXD
	O+0xCOAQ8ThlCzCgpLaD9/qD8lHOs3V5CD2quM=; b=pMjjEGGdR7j4w6mGE/gko
	JpsGfhkvZwNPwu6nSm+ZoLpeULBpSDxK/DWGpmoVzz1R9xTT7Tv7HxkDRCDuQPJj
	gdcu4gnHKFbKR2fuT2sidmc+HSQfd34xVb5f4lE8tXuizoEdfTJcfJFyDRHs1Qnw
	19cCp//GncXi0zHOFTVVvg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXX3qlO+Bnk_g8AA--.12082S3;
	Mon, 24 Mar 2025 00:49:42 +0800 (CST)
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
Subject: [v6 1/5] PCI: Introduce generic capability search functions
Date: Mon, 24 Mar 2025 00:48:48 +0800
Message-Id: <20250323164852.430546-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250323164852.430546-1-18255117159@163.com>
References: <20250323164852.430546-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXX3qlO+Bnk_g8AA--.12082S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF45JFyDAw15CFy8CF43Awb_yoWxCry7pF
	ZYv347CF48JF4avw4qv3Wjka43XanrJryUG395GwnxZF47ua1Uu3sFka4rtF1UAr47XF15
	JFW5t3ZYkr1DJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE_OzhUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwwZo2fgMcLw0gAAs7

Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
duplicate logic for scanning PCI capability lists. This creates
maintenance burdens and risks inconsistencies.

To resolve this:

Add pci_host_bridge_find_*capability() in pci-host-helpers.c, accepting
controller-specific read functions and device data as parameters.

This approach:
- Centralizes critical PCI capability scanning logic
- Allows flexible adaptation to varied hardware access methods
- Reduces future maintenance overhead
- Aligns with kernel code reuse best practices

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v5:
https://lore.kernel.org/linux-pci/20250321163803.391056-2-18255117159@163.com

- If you put the helpers in drivers/pci/pci.c, they unnecessarily enlarge
  the kernel's .text section even if it's known already at compile time
  that they're never going to be used (e.g. on x86).

- Move the API for find capabilitys to a new file called
  pci-host-helpers.c.

Changes since v4:
https://lore.kernel.org/linux-pci/20250321101710.371480-2-18255117159@163.com

- Resolved [v4 1/4] compilation warning.
- The patch commit message were modified.
---
 drivers/pci/controller/Kconfig            | 17 ++++
 drivers/pci/controller/Makefile           |  1 +
 drivers/pci/controller/pci-host-helpers.c | 98 +++++++++++++++++++++++
 drivers/pci/pci.h                         |  7 ++
 4 files changed, 123 insertions(+)
 create mode 100644 drivers/pci/controller/pci-host-helpers.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 9800b7681054..0020a892a55b 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -132,6 +132,23 @@ config PCI_HOST_GENERIC
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
 
+config PCI_HOST_HELPERS
+	bool
+	prompt "PCI Host Controller Helper Functions" if EXPERT
+ 	help
+	  This provides common infrastructure for PCI host controller drivers to
+	  handle PCI capability scanning and other shared operations. The helper
+	  functions eliminate code duplication across controller drivers.
+
+	  These functions are used by PCI controller drivers that need to scan
+	  PCI capabilities using controller-specific access methods (e.g. when
+	  the controller is behind a non-standard configuration space).
+
+	  If you are using any PCI host controller drivers that require these
+	  helpers (such as DesignWare, Cadence, etc), this will be
+	  automatically selected. Say N unless you are developing a custom PCI
+	  host controller driver.
+
 config PCIE_HISI_ERR
 	depends on ACPI_APEI_GHES && (ARM64 || COMPILE_TEST)
 	bool "HiSilicon HIP PCIe controller error handling driver"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 038ccbd9e3ba..e80091eb7597 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
 obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
 obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
+obj-$(CONFIG_PCI_HOST_HELPERS) += pci-host-helpers.o
 obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
 obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
diff --git a/drivers/pci/controller/pci-host-helpers.c b/drivers/pci/controller/pci-host-helpers.c
new file mode 100644
index 000000000000..cd261a281c60
--- /dev/null
+++ b/drivers/pci/controller/pci-host-helpers.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Host Controller Helper Functions
+ *
+ * Copyright (C) 2025 Hans Zhang
+ *
+ * Author: Hans Zhang <18255117159@163.com>
+ */
+
+#include <linux/pci.h>
+
+#include "../pci.h"
+
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
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..8d1c919cbfef 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1034,4 +1034,11 @@ void pcim_release_region(struct pci_dev *pdev, int bar);
 	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
 	 PCI_CONF1_EXT_REG(reg))
 
+typedef u32 (*pci_host_bridge_read_cfg)(void *priv, int where, int size);
+u8 pci_host_bridge_find_capability(void *priv,
+				   pci_host_bridge_read_cfg read_cfg, u8 cap);
+u16 pci_host_bridge_find_ext_capability(void *priv,
+					pci_host_bridge_read_cfg read_cfg,
+					u8 cap);
+
 #endif /* DRIVERS_PCI_H */
-- 
2.25.1


