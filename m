Return-Path: <linux-pci+bounces-39975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFC3C270AF
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 22:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8A93B0ECA
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D43161AA;
	Fri, 31 Oct 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQkiDzdT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECF326D4A
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946149; cv=none; b=dSjw/zR5oIlleoKCHr7CBesEQQKeArA6slfVlLz3OlWDN5OeZnANRxxBuVMYWGi9BKJfmpKwYvBQHcGTTusCHFG9TnOcJMHJ8BxRRo/sVejGT2fhOF/QQCFpZGn1M/5TBIbv22kINzY3YctNJb8TaSFtJ6Rhk0+gsHoRNtYJ24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946149; c=relaxed/simple;
	bh=Nc00ECAe8pJbmq3QiX29toPeFHSCsQmdKoNKoHS6hSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZ7aJakO4dcY65zAXlv7qtcH0F5TNRnXacnb71REhSuJBF7sVVt13I1q2sO+jcp9RycGgaPCfrQ9UTIMxONpomdTRQedICLMImRTSz9FLQmlPC5DsQk9B3IB3UHolIV/Zt1jXwnSFOL6Cniv7wf/95oUiwOzNY8zAKlCuagIgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQkiDzdT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761946148; x=1793482148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nc00ECAe8pJbmq3QiX29toPeFHSCsQmdKoNKoHS6hSQ=;
  b=cQkiDzdTLDP/pigJ3IpNuPJeFSDKq8sz3uw62exVUQIJ6Kv8ns2VuJY3
   C/SLYsDlEHDLfpyyhi/xNYLiWg/r+d0xWtI+P2ZTFxkgVyTI77Lp518YN
   QsE1jFnIlAUgO//5A9QMPCcve3/9R5PV5lc4XWNOdDKxxwe4ZaBA3nzwj
   PAxbDLA8k6wX31CnMaZshEnqg7Yab4Ipx+wtsG00xaZLZSve/caBjqbBz
   VzOnpiqWcynbareSj2upgG2hI2iQ/411HYuSCxtN7KGHAbG2Lwgm9qneQ
   VyAvkHRCIaDzRZ4YmiwNsZaMLMiqK60CEyRDDtR3xD6yq7s++hJjBx8yx
   Q==;
X-CSE-ConnectionGUID: Rb8nJAUQTWewY8I0CqCXOg==
X-CSE-MsgGUID: arHpXskoR6+W5ykrVRgxfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64002420"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="64002420"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 14:29:00 -0700
X-CSE-ConnectionGUID: LvrUEoeaTYyVcFB0j7N7jA==
X-CSE-MsgGUID: Y3OEjkqSSkGK4Vhio1mE5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="216986680"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa002.jf.intel.com with ESMTP; 31 Oct 2025 14:29:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	gregkh@linuxfoundation.org,
	aik@amd.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v8 9/9] PCI/TSM: Report active IDE streams
Date: Fri, 31 Oct 2025 14:29:01 -0700
Message-ID: <20251031212902.2256310-10-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031212902.2256310-1-dan.j.williams@intel.com>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
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
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm | 10 ++++++++
 include/linux/pci-ide.h                   |  2 ++
 include/linux/tsm.h                       |  3 +++
 drivers/pci/ide.c                         |  4 ++++
 drivers/virt/coco/tsm-core.c              | 28 +++++++++++++++++++++++
 5 files changed, 47 insertions(+)

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
index 22e05b2aac69..a3b7ab668eff 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -123,4 +123,7 @@ int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
+struct pci_ide;
+int tsm_ide_stream_register(struct pci_ide *ide);
+void tsm_ide_stream_unregister(struct pci_ide *ide);
 #endif /* __TSM_H */
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 4ae3872589fc..da5b1acccbb4 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -11,6 +11,7 @@
 #include <linux/pci_regs.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/tsm.h>
 
 #include "pci.h"
 
@@ -261,6 +262,9 @@ void pci_ide_stream_release(struct pci_ide *ide)
 	if (ide->partner[PCI_IDE_EP].enable)
 		pci_ide_stream_disable(pdev, ide);
 
+	if (ide->tsm_dev)
+		tsm_ide_stream_unregister(ide);
+
 	if (ide->partner[PCI_IDE_RP].setup)
 		pci_ide_stream_teardown(rp, ide);
 
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index 0e705f3067a1..f027876a2f19 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -4,11 +4,13 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/tsm.h>
+#include <linux/pci.h>
 #include <linux/rwsem.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 
 static struct class *tsm_class;
 static DECLARE_RWSEM(tsm_rwsem);
@@ -106,6 +108,32 @@ void tsm_unregister(struct tsm_dev *tsm_dev)
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
+	ide->tsm_dev = NULL;
+	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
-- 
2.51.0


