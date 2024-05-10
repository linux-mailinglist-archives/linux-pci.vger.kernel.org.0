Return-Path: <linux-pci+bounces-7331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63258C21A2
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 12:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E6B1C22071
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC1F168AE0;
	Fri, 10 May 2024 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYNlnFvy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884621635A9;
	Fri, 10 May 2024 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335681; cv=none; b=CuiVkg4nHAJHVTgOLemMNRhJjxvW2YLR5i8iiRQY/YI8x2V5hGrO5GQ7MCLM327EbfVGD3GsYMWJ9rxOfsA30s4oFw4MrSTj9Pgcu5wHdJQQBRjUsiosA1xuwmWl/P4PdnQLCGkogWHXUemMEVs/YrdUWuwLYLsBQnqKLe/6Qsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335681; c=relaxed/simple;
	bh=8lcN3GvS4xT+weTctxWkQ4vlzKc0rZNrscZi4UP5ads=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pi1mImfguPzzerXKtZEz4kFCSvAAzZ01ELHI+ElT8UtwI21t4jibZ2PN/7CphI9cOU6euJ6dYTlFoYwAvrIQDF+48HhLUE7tdeEJaZmIHO3sZWUr6B6odnaaxDtpDqm9q/4DS2MlaTzudebcu3Mt+K0E+vkD206PsarlrYEDrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYNlnFvy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715335680; x=1746871680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8lcN3GvS4xT+weTctxWkQ4vlzKc0rZNrscZi4UP5ads=;
  b=AYNlnFvyrNPO3JBPDOynmuPpaJfEjx295/lkqqNGcCikTHqJSOCD6/OI
   S4BnHoNZl5ZHgyYGjfWJK63KteF6D+EH926IZns1jHSu7P/VVsiLIpue0
   QltkBBr+MM997q+0JYgsQpujC1eSvn3Iy4Eo3LmM5K7DPB/PeoLw7cqBU
   dYlh/SbMRkKoVCaeZ055SRYOMIA1sBy/DW67Q/p/CUOqVkclBDaxAMyZX
   QT7EX+5gb2yo2l2G1eD9eh5XUgkhTIo9Z0wIG43YcjguxgdfT3NtC35Gr
   7wO/sud21kFz74+1huz0KvDWUOTZThPQGYEjnFP9zo3M5bbsyKCLk6mhw
   Q==;
X-CSE-ConnectionGUID: hA53SGAPRBSrkNqcTMXv5w==
X-CSE-MsgGUID: /3rkEyyETzeAgtGvFOupvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11144848"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11144848"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:07:59 -0700
X-CSE-ConnectionGUID: y5H58zCzR4euTLi5HtuVjA==
X-CSE-MsgGUID: TUNcp/VlQFSLPdoCTvFmDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29588305"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:07:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 2/7] PCI: Move TLP Log handling to own file
Date: Fri, 10 May 2024 13:07:25 +0300
Message-Id: <20240510100730.18805-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510100730.18805-1-ilpo.jarvinen@linux.intel.com>
References: <20240510100730.18805-1-ilpo.jarvinen@linux.intel.com>
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


