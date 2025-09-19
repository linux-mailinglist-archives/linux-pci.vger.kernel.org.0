Return-Path: <linux-pci+bounces-36491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC51BB89E09
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CEB1B203E6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D373313263;
	Fri, 19 Sep 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwlHt289"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750AF3148A6
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291765; cv=none; b=tkaWMHgb25m2kFF4r5v23Fpzd/59wZgYiok4YU+8NcamX9mYkLQbDyg5YQryAUKuoO2vbeq7OzvNTewS+6MXD4hM9OilArm4BaXVD7HDyN7cbH8nnQrdIqRe+AJ/cvJ1ebfUZVcXR5H8zdAb4g8mYGsMAylbL5ftrsYxnTaOGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291765; c=relaxed/simple;
	bh=20+rjfk+uEbJYZn2Pwz3s+qLBFd5m5rPOVOdRQ/i5Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksKpyBYQhx1xm/R+EsRsISUa3XCTlWoPsfOCikPfQo8vJ9h0sDXc705MsQINKxFMrYnvWkwzHtXDCuUC2ZAOt1lRtegCctUz2E6iyYcF96IIw44wQSNd8B76OxsVYGDsSDjvhjMMyc8A6oGQknfU07FSVHGlpVaZa20dVLpDaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwlHt289; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291763; x=1789827763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=20+rjfk+uEbJYZn2Pwz3s+qLBFd5m5rPOVOdRQ/i5Nk=;
  b=CwlHt289ozGfNX/5IiRlJ6o52J7z6uKquXI+TOUrFqAPTzJ1xYoojoyR
   T0CXmBBxwASrWUliGqHRFb31KMbKws3CjQvoAKlkcfEDVvyv3ffch5wV5
   4atfGF9ApJYMybAWiSBBK41zi+EYuriVqVU82uFZX+AzlQTwUJdpzLofQ
   IkW5XFTtQYrbAkcFyX6Jhhl2lUvhTEVvvbWbXag7J+WvPM5tBsYMTT0y7
   UszXf1jR/aOXWoKdhE0OvlJPoJk8tnhywAIMCxdZutTpnkP19vB7tkWxj
   ep7cTdIzAYj5xOrOlly6wc9BCjYBl17o3FTQR4KM10tH0MMMlJGYUYlR4
   g==;
X-CSE-ConnectionGUID: pPF9Qm8NTiCXcdgGXrlL+g==
X-CSE-MsgGUID: GWQultucT0avZ+T7yVmUOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750534"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750534"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:38 -0700
X-CSE-ConnectionGUID: bJI+d+zqTD2sP9AUaeWqmg==
X-CSE-MsgGUID: sqLRI1aYT4KuQKc1eOhMPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655023"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Dave Jiang <dave.jiang@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 11/27] acpi: Add KEYP Key Configuration Unit parsing
Date: Fri, 19 Sep 2025 07:22:20 -0700
Message-ID: <20250919142237.418648-12-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919142237.418648-1-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

Parse the KEYP Key Configuration Units (KCU), to decide the max IDE
streams supported for each host bridge.

The KEYP table points to a number of KCU structures that each associates
with a list of root ports (RP) via segment, bus, and devfn. Sanity check
the KEYP table, ensure all RPs listed for each KCU are included in one
host bridge. Then extact the max IDE streams supported to
pci_host_bridge via pci_ide_init_nr_streams().

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
[djbw: todo: find a better place for this than common host-bridge init]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/Makefile              |   2 +
 drivers/acpi/pci_root.c            |   2 +
 drivers/acpi/x86/keyp.c            | 118 +++++++++++++++++++++++++++++
 drivers/virt/coco/tdx-host/Kconfig |   1 +
 include/linux/acpi.h               |   3 +
 5 files changed, 126 insertions(+)
 create mode 100644 drivers/acpi/x86/keyp.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d1b0affb844f..fdd68d402aa2 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -134,3 +134,5 @@ obj-$(CONFIG_ACPI_VIOT)		+= viot.o
 
 obj-$(CONFIG_RISCV)		+= riscv/
 obj-$(CONFIG_X86)		+= x86/
+
+obj-$(CONFIG_ACPI_KEYP)		+= x86/keyp.o
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 74ade4160314..633e6a00c62d 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -757,6 +757,8 @@ static int acpi_pci_root_add(struct acpi_device *device,
 		acpi_ioapic_add(root->device->handle);
 	}
 
+	keyp_setup_nr_ide_stream(root->bus);
+
 	pci_lock_rescan_remove();
 	pci_bus_add_devices(root->bus);
 	pci_unlock_rescan_remove();
diff --git a/drivers/acpi/x86/keyp.c b/drivers/acpi/x86/keyp.c
new file mode 100644
index 000000000000..99680f1edff7
--- /dev/null
+++ b/drivers/acpi/x86/keyp.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KEYP ACPI table parsing
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+
+#define KCU_STR_CAP_NUM_STREAMS		GENMASK(8, 0)
+
+/* The bus_end is inclusive */
+struct keyp_hb_info {
+	/* input */
+	u16 segment;
+	u8 bus_start;
+	u8 bus_end;
+	/* output */
+	u8 nr_ide_streams;
+};
+
+static bool keyp_info_match(struct acpi_keyp_rp_info *rp,
+			    struct keyp_hb_info *hb)
+{
+	if (rp->segment != hb->segment)
+		return false;
+
+	if (rp->bus >= hb->bus_start && rp->bus <= hb->bus_end)
+		return true;
+
+	return false;
+}
+
+static int keyp_config_unit_handler(union acpi_subtable_headers *header,
+				    void *arg, const unsigned long end)
+{
+	struct acpi_keyp_config_unit *acpi_cu =
+		(struct acpi_keyp_config_unit *)&header->keyp;
+	struct keyp_hb_info *hb_info = arg;
+	int rp_size, rp_count, i;
+	void __iomem *addr;
+	bool match = false;
+	u32 cap;
+
+	rp_size = acpi_cu->header.length - sizeof(*acpi_cu);
+	if (rp_size % sizeof(struct acpi_keyp_rp_info))
+		return -EINVAL;
+
+	rp_count = rp_size / sizeof(struct acpi_keyp_rp_info);
+	if (!rp_count || rp_count != acpi_cu->root_port_count)
+		return -EINVAL;
+
+	for (i = 0; i < rp_count; i++) {
+		struct acpi_keyp_rp_info *rp_info = &acpi_cu->rp_info[i];
+
+		if (i == 0) {
+			match = keyp_info_match(rp_info, hb_info);
+			/* The host bridge already matches another KCU */
+			if (match && hb_info->nr_ide_streams)
+				return -EINVAL;
+
+			continue;
+		}
+
+		if (match ^ keyp_info_match(rp_info, hb_info))
+			return -EINVAL;
+	}
+
+	if (!match)
+		return 0;
+
+	addr = ioremap(acpi_cu->register_base_address, sizeof(cap));
+	if (!addr)
+		return -ENOMEM;
+	cap = ioread32(addr);
+	iounmap(addr);
+
+	hb_info->nr_ide_streams = FIELD_GET(KCU_STR_CAP_NUM_STREAMS, cap) + 1;
+
+	return 0;
+}
+
+static u8 keyp_find_nr_ide_stream(u16 segment, u8 bus_start, u8 bus_end)
+{
+	struct keyp_hb_info hb_info = {
+		.segment = segment,
+		.bus_start = bus_start,
+		.bus_end = bus_end,
+	};
+	int rc;
+
+	rc = acpi_table_parse_keyp(ACPI_KEYP_TYPE_CONFIG_UNIT,
+				   keyp_config_unit_handler, &hb_info);
+	if (rc < 0)
+		return 0;
+
+	return hb_info.nr_ide_streams;
+}
+
+void keyp_setup_nr_ide_stream(struct pci_bus *bus)
+{
+	struct pci_host_bridge *hb = to_pci_host_bridge(bus->bridge);
+	u8 nr_ide_streams;
+
+	if (hb->nr_ide_streams > 0)
+		return;
+
+	nr_ide_streams = keyp_find_nr_ide_stream(pci_domain_nr(bus),
+						 bus->busn_res.start,
+						 bus->busn_res.end);
+	if (!nr_ide_streams)
+		return;
+
+	pci_ide_init_nr_streams(hb, nr_ide_streams);
+}
+EXPORT_SYMBOL_GPL(keyp_setup_nr_ide_stream);
diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
index 026b7d5ea4fa..c3f779c511e3 100644
--- a/drivers/virt/coco/tdx-host/Kconfig
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -14,3 +14,4 @@ config TDX_CONNECT
 	depends on TDX_HOST_SERVICES
 	depends on PCI_TSM
 	default TDX_HOST_SERVICES
+	select ACPI_KEYP
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 36662c1c7de4..0165f2209d91 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -239,6 +239,7 @@ acpi_table_parse_cedt(enum acpi_cedt_type id,
 int __init_or_acpilib
 acpi_table_parse_keyp(enum acpi_keyp_type id,
 		      acpi_tbl_entry_handler_arg handler_arg, void *arg);
+void __init_or_acpilib keyp_setup_nr_ide_stream(struct pci_bus *bus);
 #else
 static inline int acpi_table_parse_keyp(enum acpi_keyp_type id,
 					acpi_tbl_entry_handler_arg handler_arg,
@@ -246,6 +247,8 @@ static inline int acpi_table_parse_keyp(enum acpi_keyp_type id,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void keyp_setup_nr_ide_stream(struct pci_bus *bus) {}
 #endif
 
 int acpi_parse_mcfg (struct acpi_table_header *header);
-- 
2.51.0


