Return-Path: <linux-pci+bounces-43560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B2FCD885F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 10:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56071300A1CC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 09:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD91322A3E;
	Tue, 23 Dec 2025 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBSKzo7j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0ED2D0C89;
	Tue, 23 Dec 2025 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481153; cv=none; b=TubSzqbc30CHFwvt2g/4uffPvRb7m1reZuE17jgsNlN9KGxigiJIccrGHjf51sSmP2VzOspdkt10VHZmkruo/Pfs+T4vQyk0I1dGSiDEr3FZ0Zhlk+RRZUG3iox16TRNfHpSypA/+htFadahcd+XfVqFu2msyaRATPI/Wso3krQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481153; c=relaxed/simple;
	bh=inTDxtXjGFl/D/c3TX5Y2XLvCaEYKsUWEVG1TtNqRtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PkEYs+l1dy70J7rRJwnDLYa9NDzvS/I21XRHAed3sX81+8bN/ZDBrL8gae97K6PLg96VCO1neiniFjLOxrfzA6Ii96qqBsNlytfdVw3hhK3h+eux3hz4ZO8XK+rYJYMqmXPsC6eiKZIvrk/gPTaY4Sb2mx9AtDqOi8onYLQHAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBSKzo7j; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766481151; x=1798017151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=inTDxtXjGFl/D/c3TX5Y2XLvCaEYKsUWEVG1TtNqRtM=;
  b=QBSKzo7jhHK6U4MEnehGliqOJ7mfy2GRBKeTvfwCqgPyduhxaJIUbqlH
   2lNY0QS2CBPqPIq5MqebPtXnxVE5YZrhOfjnHCVdxk3O4YK+Y0M5dkQi1
   ABsDDmTGo8cT/DxEo3Ibe4RwhxTUufrO8QKoi85BNsIzjvmK59/cV4z80
   ++dwTY2GLqx157FpG8oEN5pSNEFfS6xWJ5ODEG+CxJV73dBYyxr0DwHdn
   kaHGqr3iwiFVxCmfXXHvHqxiClvEj8BCuVCrexgfCe9PMlZtVDyhsQiIo
   lFVXswt6y+k2mXr1S+ZS41rVdyxdyppqc9++hZNQGgpHYdhedUQsghtEs
   g==;
X-CSE-ConnectionGUID: xNlQjxCyTimBw6nx5wR7sw==
X-CSE-MsgGUID: ASIYz5jPSd6WFL8G8Ve7Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="79447992"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="79447992"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 01:12:30 -0800
X-CSE-ConnectionGUID: oWPKldhFSJKF1lVk73aqEg==
X-CSE-MsgGUID: IFIJ5Z0cSIuTDoSosRs3TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="200646597"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 23 Dec 2025 01:12:27 -0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dan.j.williams@intel.com
Cc: yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: [PATCH] PCI/IDE: Fix duplicate stream symlink names for TSM class devices
Date: Tue, 23 Dec 2025 16:56:01 +0800
Message-Id: <20251223085601.2607455-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The symlink name streamH.R.E is unique within a specific host bridge but
not across the system. Error occurs e.g. when creating the first stream
on a second host bridge:

[ 1244.034755] sysfs: cannot create duplicate filename '/devices/faux/tdx_host/tsm/tsm0/stream0.0.0'

Fix this by adding host bridge name into symlink name for TSM class
devices. It should be OK to change the uAPI to
/sys/class/tsm/tsmN/pciDDDD:BB:streamH.R.E since it's new and has few
users.

Internally in the IDE library, store the full name in struct pci_ide
so TSM symlinks can use it directly, while PCI host bridge symlinks
can skip the host bridge name to keep concise.

Fixes: a4438f06b1db ("PCI/TSM: Report active IDE streams")
Reported-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm |  2 +-
 drivers/pci/ide.c                         | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
index 6fc1a5ac6da1..eff71e42c60e 100644
--- a/Documentation/ABI/testing/sysfs-class-tsm
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -8,7 +8,7 @@ Description:
 		link encryption and other device-security features coordinated
 		through a platform tsm.
 
-What:		/sys/class/tsm/tsmN/streamH.R.E
+What:		/sys/class/tsm/tsmN/pciDDDD:BB:streamH.R.E
 Contact:	linux-pci@vger.kernel.org
 Description:
 		(RO) When a host bridge has established a secure connection via
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index f0ef474e1a0d..db1c7423bf39 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -425,6 +425,7 @@ int pci_ide_stream_register(struct pci_ide *ide)
 	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
 	struct pci_ide_stream_id __sid;
 	u8 ep_stream, rp_stream;
+	const char *short_name;
 	int rc;
 
 	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
@@ -441,13 +442,16 @@ int pci_ide_stream_register(struct pci_ide *ide)
 
 	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
 	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
-	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
+	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "%s:stream%d.%d.%d",
+						   dev_name(&hb->dev),
 						   ide->host_bridge_stream,
 						   rp_stream, ep_stream);
 	if (!name)
 		return -ENOMEM;
 
-	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
+	/* Skip host bridge name in the host bridge context */
+	short_name = name + strlen(dev_name(&hb->dev)) + 1;
+	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, short_name);
 	if (rc)
 		return rc;
 
@@ -471,8 +475,10 @@ void pci_ide_stream_unregister(struct pci_ide *ide)
 {
 	struct pci_dev *pdev = ide->pdev;
 	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+	const char *short_name;
 
-	sysfs_remove_link(&hb->dev.kobj, ide->name);
+	short_name = ide->name + strlen(dev_name(&hb->dev)) + 1;
+	sysfs_remove_link(&hb->dev.kobj, short_name);
 	kfree(ide->name);
 	ida_free(&hb->ide_stream_ids_ida, ide->stream_id);
 	ide->name = NULL;

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.25.1


