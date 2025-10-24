Return-Path: <linux-pci+bounces-39221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F664C0413C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144281AA41FB
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8164C2343BE;
	Fri, 24 Oct 2025 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cne0K93w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B7223DDA
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271466; cv=none; b=LUzfu/JdC8BQVoOCeQQNlSIPa0qOGsxuP2NRHYvGMD2Nj0OJGXf6922DWdFWcD/yYdxYYiAvPQUeSf89s0fhgKziYrpATGYqGxXMkkznud5h6BsRDVZ96xKnnQqJt2J5jq9KOHbU3v/tlIbRfmG5XjNCe9HvK6LBX5CcZLjpvuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271466; c=relaxed/simple;
	bh=W4a5IuywnIRGveXaMGuZbkpb6/GSgLF/u5qt9Mpe2A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6fXG/2TKOue0R2NmNks2FJD9/1bCBaTBqNDiSxbVHSAoos3ezWJt92sxnxTBrbPm0XNUED4a5l7mq437nCB/RUgQrC5o347SzpTtiv0rTYN0xZP7w7CxoNF2mVPNY4pNGQEzRyDmOPc8dWmirNjd8ICcGBGUfFcHe0gGftOfiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cne0K93w; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761271465; x=1792807465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W4a5IuywnIRGveXaMGuZbkpb6/GSgLF/u5qt9Mpe2A0=;
  b=cne0K93wnVWnRCnOEySKiURrussAErmZ99cbomABW5dnXSUcYZ0UReza
   1MqakJRGXHHvXQ7+r7i4n6V8JeI+s/CqtDQ/PSqBPfzxCZnYprVkLXprc
   JbjOH0KDNLL6xJtoldxUGCLBHkvwyo9wV9uEar8vYfu+++nBAIrkJh6hW
   N4SRmVu6jYzggioF+cTGCJujo1CL08Ee4duOWb+y4zVxSP/5OSWsTz5ws
   eKwhYS2X7bY7iWiK1Hmuc8XFgd7nlx2DpDyUXS06FTcBLdnAup2hfvI2B
   bBnL8dqrW1PMFuO3PEhFTSfN5+H6A9dsyN1AI7TXMX+2yzXMf8FZ0X3Us
   Q==;
X-CSE-ConnectionGUID: xi1UFPjkQgOtmgG93E2Gxg==
X-CSE-MsgGUID: FESJ320xT7CQlXaPYY/dag==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67319386"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="67319386"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:04:20 -0700
X-CSE-ConnectionGUID: KMBqaALbQFufGhLNQj788g==
X-CSE-MsgGUID: yYrB1s2+Q3qhUJDWj7jaNw==
X-ExtLoop1: 1
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa003.fm.intel.com with ESMTP; 23 Oct 2025 19:04:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: aik@amd.com,
	yilun.xu@linux.intel.com,
	aneesh.kumar@kernel.org,
	bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v7 9/9] PCI/TSM: Report active IDE streams
Date: Thu, 23 Oct 2025 19:04:18 -0700
Message-ID: <20251024020418.1366664-10-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024020418.1366664-1-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given that the platform TSM owns IDE Stream ID allocation, report the
active streams via the TSM class device. Establish a symlink from the
class device to the PCI endpoint device consuming the stream, named by
the Stream ID.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm | 10 ++++++++
 include/linux/pci-ide.h                   |  2 ++
 include/linux/tsm.h                       |  3 +++
 drivers/pci/ide.c                         |  4 ++++
 drivers/virt/coco/tsm-core.c              | 29 +++++++++++++++++++++++
 5 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
index 2949468deaf7..6fc1a5ac6da1 100644
--- a/Documentation/ABI/testing/sysfs-class-tsm
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -7,3 +7,13 @@ Description:
 		signals when the PCI layer is able to support establishment of
 		link encryption and other device-security features coordinated
 		through a platform tsm.
+
+What:		/sys/class/tsm/tsmN/streamH.R.E
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host bridge has established a secure connection via
+		the platform TSM, symlink appears. The primary function of this
+		is have a system global review of TSM resource consumption
+		across host bridges. The link points to the endpoint PCI device
+		and matches the same link published by the host bridge. See
+		Documentation/ABI/testing/sysfs-devices-pci-host-bridge.
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index 85645b0a8620..d0f10f3c89fc 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -50,6 +50,7 @@ struct pci_ide_partner {
  * @host_bridge_stream: allocated from host bridge @ide_stream_ida pool
  * @stream_id: unique Stream ID (within Partner Port pairing)
  * @name: name of the established Selective IDE Stream in sysfs
+ * @tsm_dev: For TSM established IDE, the TSM device context
  *
  * Negative @stream_id values indicate "uninitialized" on the
  * expectation that with TSM established IDE the TSM owns the stream_id
@@ -61,6 +62,7 @@ struct pci_ide {
 	u8 host_bridge_stream;
 	int stream_id;
 	const char *name;
+	struct tsm_dev *tsm_dev;
 };
 
 void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index ee9a54ae3d3c..376139585797 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -120,4 +120,7 @@ int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
+struct pci_ide;
+int tsm_ide_stream_register(struct pci_ide *ide);
+void tsm_ide_stream_unregister(struct pci_ide *ide);
 #endif /* __TSM_H */
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 44f62da5e191..5659f988e524 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -11,6 +11,7 @@
 #include <linux/pci_regs.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/tsm.h>
 
 #include "pci.h"
 
@@ -264,6 +265,9 @@ void pci_ide_stream_release(struct pci_ide *ide)
 	if (ide->partner[PCI_IDE_EP].enable)
 		pci_ide_stream_disable(pdev, ide);
 
+	if (ide->tsm_dev)
+		tsm_ide_stream_unregister(ide);
+
 	if (ide->partner[PCI_IDE_RP].setup)
 		pci_ide_stream_teardown(rp, ide);
 
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index 4499803cf20d..c0dae531b64f 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -2,14 +2,17 @@
 /* Copyright(c) 2024 Intel Corporation. All rights reserved. */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/tsm.h>
 #include <linux/idr.h>
+#include <linux/pci.h>
 #include <linux/rwsem.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 
 static struct class *tsm_class;
 static DECLARE_RWSEM(tsm_rwsem);
@@ -106,6 +109,32 @@ void tsm_unregister(struct tsm_dev *tsm_dev)
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
 
+/* must be invoked between tsm_register / tsm_unregister */
+int tsm_ide_stream_register(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_tsm *tsm = pdev->tsm;
+	struct tsm_dev *tsm_dev = tsm->tsm_dev;
+	int rc;
+
+	rc = sysfs_create_link(&tsm_dev->dev.kobj, &pdev->dev.kobj, ide->name);
+	if (rc)
+		return rc;
+
+	ide->tsm_dev = tsm_dev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
+
+void tsm_ide_stream_unregister(struct pci_ide *ide)
+{
+	struct tsm_dev *tsm_dev = ide->tsm_dev;
+
+	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
+	ide->tsm_dev = NULL;
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
-- 
2.51.0


