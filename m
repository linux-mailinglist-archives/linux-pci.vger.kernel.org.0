Return-Path: <linux-pci+bounces-7448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1D88C5313
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 13:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3C71C21C5D
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 11:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1EA13A242;
	Tue, 14 May 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghjH8XA/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44331139D1D;
	Tue, 14 May 2024 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686297; cv=none; b=cDt6r8NQ92+0hbSV4iCbUYtzleoxECLbUGbSrC+0uqAauwJcYSazz7X8rd2htusz6I8zOVtam9GI9gyn5CimbmV/+m/mowEBf7xY+EjdM4tByUV+0EwbnAsMbEpy7PF/X2hwk3g6j6FSX9DGuW02iGKOF5QspPUVUWr8VXfIs4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686297; c=relaxed/simple;
	bh=8lcN3GvS4xT+weTctxWkQ4vlzKc0rZNrscZi4UP5ads=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4NKRXYJagRp30ipyEEUer2u9Q66+7cC9fDCZ1opTYh4qecyH8lNNECTuh4FJ48/0BAAgEynUI8xLk62FNb/qi8sT35O4MJQPneVN2A0FSwsxJqbdowY3VJoc3LO/fmJn/gZmzN2VbXsTmt2qSLtHVuM44YyjOPfqFnxMm6dnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghjH8XA/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715686295; x=1747222295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8lcN3GvS4xT+weTctxWkQ4vlzKc0rZNrscZi4UP5ads=;
  b=ghjH8XA/DirVTI/JO0O0HEVr69tRvi/PD4On+BwZRcCkZ/NFdWwej43D
   uAW2ZxDGh2FxFTLdYLt9KDGb35BJ05QjiF3AOkYcv667VeDcQfb77hIoM
   A2NiCNTaErt4nmHcAqKtmWS7PyfxVnD39+dJHvyQYspJ43edhP8qg7uZf
   vl1CzP/c2w47EJJ0KtSj5ovkr8eo//QinTzVj3zFCdx69XBHkvAjs7Zm7
   aYBLMrhvQB2lNKhxExkhvG6oneS96vKPdLACW/rj6gdg9aBH8LbAnNf9Q
   NACa1ZlPskQoaE8tWMxX6LyBaf0l5/5a58liZkJ7Jg+/+ujrOUyPB8uge
   Q==;
X-CSE-ConnectionGUID: i0XkS730QLCpIWfTuJWlfA==
X-CSE-MsgGUID: QeEVo/A1SJ+W0mgnKoDYzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11532837"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11532837"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:31:34 -0700
X-CSE-ConnectionGUID: JiaICyhjSFeSR+iLgSEnBQ==
X-CSE-MsgGUID: CMV6tNX1TLm1mOr8TkQNkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35179635"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.94])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:31:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 2/7] PCI: Move TLP Log handling to own file
Date: Tue, 14 May 2024 14:31:04 +0300
Message-Id: <20240514113109.6690-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240514113109.6690-1-ilpo.jarvinen@linux.intel.com>
References: <20240514113109.6690-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TLP Log is PCIe feature and is processed only by AER and DPC.
Configwise, DPC depends AER being enabled. In lack of better place, the
TLP Log handling code was initially placed into pci.c but it can be
easily placed in a separate file.

Move TLP Log handling code to own file under pcie/ subdirectory and
include it only when AER is enabled.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c         | 27 ---------------------------
 drivers/pci/pci.h         |  2 +-
 drivers/pci/pcie/Makefile |  2 +-
 drivers/pci/pcie/tlp.c    | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 29 deletions(-)
 create mode 100644 drivers/pci/pcie/tlp.c

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 54ab1d6b8e53..2cc875f60fef 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1066,33 +1066,6 @@ static void pci_enable_acs(struct pci_dev *dev)
 	pci_disable_acs_redir(dev);
 }
 
-/**
- * pcie_read_tlp_log - read TLP Header Log
- * @dev: PCIe device
- * @where: PCI Config offset of TLP Header Log
- * @tlp_log: TLP Log structure to fill
- *
- * Fill @tlp_log from TLP Header Log registers, e.g., AER or DPC.
- *
- * Return: 0 on success and filled TLP Log structure, <0 on error.
- */
-int pcie_read_tlp_log(struct pci_dev *dev, int where,
-		      struct pcie_tlp_log *tlp_log)
-{
-	int i, ret;
-
-	memset(tlp_log, 0, sizeof(*tlp_log));
-
-	for (i = 0; i < 4; i++) {
-		ret = pci_read_config_dword(dev, where + i * 4,
-					    &tlp_log->dw[i]);
-		if (ret)
-			return pcibios_err_to_errno(ret);
-	}
-
-	return 0;
-}
-
 /**
  * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
  * @dev: PCI device to have its BARs restored
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9c968df86a92..0e9917f8bf3f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -419,9 +419,9 @@ struct aer_err_info {
 
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
-#endif	/* CONFIG_PCIEAER */
 
 int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_log *log);
+#endif	/* CONFIG_PCIEAER */
 
 #ifdef CONFIG_PCIEPORTBUS
 /* Cached RCEC Endpoint Association */
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 6461aa93fe76..591ef3177777 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -7,7 +7,7 @@ pcieportdrv-y			:= portdrv.o rcec.o
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
 obj-y				+= aspm.o
-obj-$(CONFIG_PCIEAER)		+= aer.o err.o
+obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
new file mode 100644
index 000000000000..3f053cc62290
--- /dev/null
+++ b/drivers/pci/pcie/tlp.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe TLP Log handling
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+
+#include <linux/aer.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+
+#include "../pci.h"
+
+/**
+ * pcie_read_tlp_log - read TLP Header Log
+ * @dev: PCIe device
+ * @where: PCI Config offset of TLP Header Log
+ * @tlp_log: TLP Log structure to fill
+ *
+ * Fill @tlp_log from TLP Header Log registers, e.g., AER or DPC.
+ *
+ * Return: 0 on success and filled TLP Log structure, <0 on error.
+ */
+int pcie_read_tlp_log(struct pci_dev *dev, int where,
+		      struct pcie_tlp_log *tlp_log)
+{
+	int i, ret;
+
+	memset(tlp_log, 0, sizeof(*tlp_log));
+
+	for (i = 0; i < 4; i++) {
+		ret = pci_read_config_dword(dev, where + i * 4,
+					    &tlp_log->dw[i]);
+		if (ret)
+			return pcibios_err_to_errno(ret);
+	}
+
+	return 0;
+}
-- 
2.39.2


