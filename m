Return-Path: <linux-pci+bounces-44503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6699D13121
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 15:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7233300EA09
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E0259CAF;
	Mon, 12 Jan 2026 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EHiK19qo"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B72561AA;
	Mon, 12 Jan 2026 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227501; cv=none; b=PbWWXr+IXWWmCiLTTPb/PAr1O0+D5mI8twWEJwDP/RwHRdb89mrYCF70wfftcSg5hxRE+DTtLIHxx9yer0L7ONluh0viIWCs/de7t6H2QDdOJhNbk+NLAPnmQfI20H4qLHcQF2IpQs0BcgKJY4XToej6reK6UGGy9BAy2vwBYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227501; c=relaxed/simple;
	bh=wlT3FBAPC9NaPUwN7a+iupmJcxj6yFmsVyOWpBHDwrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhHXIq9Qlj11nXSVy/JIOcucaOU1Ybnjwwio1PDJkAg3azPHH5BDG8I4fDyUd55LkWwzLlqPoy872eoEAy/PhCrc6dociRZ+wGa2w65FuE4lCF3ltSFaKXfcHrlG63o2o1ow/VGl3f36pHRU6MFCsF8My3XFBSdI4mfl9e5qjUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EHiK19qo; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=D6
	ibI2l2qeTk6D8zz4v4Fuljr3FpUb+m+bLiWQ2pp4o=; b=EHiK19qo5qPALSScCf
	DTm8yB6e7/6L1nNcj+DXj4Ibynkp4qkGPdNffWEpeCkEy76QForW3up/DfXcMLYi
	QbfdE/Tl6IMsOMzxCl8VFxGo8P2dV62IkR67wgNZrueeVO5R8hjuTxA/7jffoyxa
	CyzeA4re24dq+KbO3LAC73HkY=
Received: from emily-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3X3dKAmVp1HqUGQ--.29256S2;
	Mon, 12 Jan 2026 22:16:45 +0800 (CST)
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
	dai.hualiang@zte.com.cn,
	deng.weixian@zte.com.cn,
	guo.chang2@zte.com.cn,
	liu.qingtao2@zte.com.cn,
	wu.jiabao@zte.com.cn,
	lin.yongchun@zte.com.cn,
	hu.yuye@zte.com.cn,
	zhang.longxiang@zte.com.cn,
	zuo.jiang@zte.com.cn,
	li.kunpeng@zte.com.cn,
	huyuye <huyuye812@163.com>
Subject: [PATCH v2] ACPI: pci_root: Clear the acpi dependencies after PCI root bridge initialization on RISC-V
Date: Mon, 12 Jan 2026 22:16:29 +0800
Message-ID: <20260112141630.2869-1-huyuye812@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203140716.3065-1-huyuye812@163.com>
References: <20251203140716.3065-1-huyuye812@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X3dKAmVp1HqUGQ--.29256S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF4DXF13KFykZryDAF47Arb_yoW5Zw4rpF
	Wj9w1fArZ7Jw47KwnrZw15XFy5Jw4F9342grZru34Dua18uryYvF92yFyUta4UuFWDGa1x
	ZF9rtF15CF1jvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zic18DUUUUU=
X-CM-SenderInfo: 5kx135bhyrjqqrwthudrp/xtbC4w1HT2llAk3SSwAA38

Hi Rafael,
Thank you for your thorough review and valuable comments on v1.
I've updated the patch as follows:
1. Removed the redundant #ifdef CONFIG_ACPI and if (!acpi_disabled) 
guard as you pointed out. The entire code block indeed already depends
on CONFIG_ACPI at a higher level, making the inner guard unnecessary.
2. Moved acpi_dev_clear_dependencies to RISC-V specific architecture 
code (driver/acpi/riscv/acpi_pci.c). This ensures that ACPI dependency
clearing is handled within the appropriate architectural context.

Best regards
Signed-off-by: huyuye <huyuye812@163.com> 
---
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


