Return-Path: <linux-pci+bounces-44737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A477D1ECA5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 13:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE4753002888
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F7A396B90;
	Wed, 14 Jan 2026 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jxu6ALux"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C751E25F9;
	Wed, 14 Jan 2026 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394065; cv=none; b=r6rmzZx37Jdico1+BK0nOBYfDiDmCHxfQTBi6uEVY6H5EO4O9FELfjhuvo8LnAOoMBeiZ2bgRVUaM6v/YsZ26wMUdYBcatVGFg7IFOGFTrjXnOB9pFS3HH6yq/eaAiuicbAbe8Ki/sIi3WqkQPUKsCAU/QJ2X05DeyXP7iF/lgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394065; c=relaxed/simple;
	bh=nAZvwTcvE/laxBoMa7e4DUE9HFPasAG1RWIxN36k54I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDgoHWWUc/+9CJxJBoXvjS6eg9L9mal7vLqFxtSpu5RH8EyL1WCJeDxYeiCE5tYjuhYxyC5GeyJaPt07rnrxQXDF9BtkOZc0DW/1/3IeJBXkN0wKONrstXF/M9A3edrXmdCvkl83EpLquulxBPN4u/ooxS1ZPNiz7q4T1EDMZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jxu6ALux; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mQ
	FTKbJmOROnetJPdTEjD7x5P28wiTI7ho78GWvBYd0=; b=jxu6ALuxnRDLPlc6Aq
	QVckfXUk2tQl/7Rw5yLgsXkBuLv7qSVz7pwR+vNdXCp6sCwu2hnLN0ygwU8Y+w3I
	ANL6gSa8ZgRSW/gnrtEJ0+ZHG/kNXOX2bNezwwvuitLKWO31tinuVYXR+rFqfjTL
	eeJxyOLxXEt1AQ0XPs3Q/Z0NA=
Received: from emily-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnEXLIjGdp_IcxGQ--.5443S2;
	Wed, 14 Jan 2026 20:32:10 +0800 (CST)
From: huyuye <huyuye812@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Robert Moore <robert.moore@intel.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hu.yuye@zte.com.cn,
	huyuye <huyuye812@163.com>
Subject: [PATCH v3] ACPI: pci_root: Clear the acpi dependencies after PCI root bridge initialization on RISC-V
Date: Wed, 14 Jan 2026 20:32:05 +0800
Message-ID: <20260114123205.4019-1-huyuye812@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260112141630.2869-1-huyuye812@163.com>
References: <20260112141630.2869-1-huyuye812@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnEXLIjGdp_IcxGQ--.5443S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxurykKr1xGF1kKFy3tF1DJrb_yoWrGw1fpF
	Wj9w1fCrWkJw47Kr1DZw1UXFy5JanY9342grZru34q9a1kuryYvF92yFyUAa4UuFWDGa1x
	ZF9rtF1rCF1jvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRrb1bUUUUU=
X-CM-SenderInfo: 5kx135bhyrjqqrwthudrp/xtbC5AqJkWlnjMrhdAAA3r

On RISC-V platforms with multiple PCI root bridges, the enumeration
order varies randomly across reboots due to APLIC driver initialization
occurring after ACPI device scanning. This defers PCI probing to a
unbound workqueue, resulting in non-deterministic device discovery
sequences.

Such random enumeration leads to changes in device naming across each
boot, which disrupts storage configurations, network settings, and
severely impacts the stability of server maintenance.

By adding the acpi_dev_clear_dependencies() call in acpi_pci_root_add(),
this patch enables the firmware to actively control the enumeration order
of multiple PCI root bridges through the ACPI _DEP method, providing the
firmware with the opportunity to initialize devices in the intended order,
thereby ensuring consistent enumeration results across multiple boots.

Signed-off-by: huyuye <huyuye812@163.com>
---
v2 -> v3:
- Added back the missing commit description from v1
- Moved v2 changelog to correct location after "---"

v1 -> v2:
- Removed the redundant #ifdef CONFIG_ACPI and if (!acpi_disabled) guard
- Moved acpi_dev_clear_dependencies to RISC-V specific architecture code 

 drivers/acpi/pci_root.c       |  6 ++++++
 drivers/acpi/riscv/Makefile   |  2 +-
 drivers/acpi/riscv/acpi_pci.c | 11 +++++++++++
 include/acpi/acpi_bus.h       |  1 +
 4 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/acpi_pci.c

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 9d7f85dadc48..a16eb9097cdc 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -30,6 +30,11 @@ static int acpi_pci_root_add(struct acpi_device *device,
 			     const struct acpi_device_id *not_used);
 static void acpi_pci_root_remove(struct acpi_device *device);
 
+
+void __weak arch_acpi_pci_root_add_clear_dep(struct acpi_device *device)
+{
+}
+
 static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
 {
 	acpiphp_check_host_bridge(adev);
@@ -760,6 +765,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	pci_lock_rescan_remove();
 	pci_bus_add_devices(root->bus);
 	pci_unlock_rescan_remove();
+	arch_acpi_pci_root_add_clear_dep(device);
 	return 1;
 
 remove_dmar:
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 1284a076fa88..5b1bd0298fb9 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o init.o irq.o
+obj-y					+= rhct.o init.o irq.o acpi_pci.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
 obj-$(CONFIG_ACPI_RIMT)			+= rimt.o
diff --git a/drivers/acpi/riscv/acpi_pci.c b/drivers/acpi/riscv/acpi_pci.c
new file mode 100644
index 000000000000..368ff113e5c6
--- /dev/null
+++ b/drivers/acpi/riscv/acpi_pci.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026, ZTE Corporation
+ *  Author: Yu Ye Hu <hu.yuye@zte.com.cn>
+ */
+#include <linux/acpi.h>
+
+void arch_acpi_pci_root_add_clear_dep(struct acpi_device *device)
+{
+	acpi_dev_clear_dependencies(device);
+}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index aad1a95e6863..c00b523a6ebd 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -996,6 +996,7 @@ int acpi_wait_for_acpi_ipmi(void);
 
 int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
 u32 arch_acpi_add_auto_dep(acpi_handle handle);
+void arch_acpi_pci_root_add_clear_dep(struct acpi_device *device);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.43.0


