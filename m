Return-Path: <linux-pci+bounces-43990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5FCF2E0C
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 10:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44097311270E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2DA2D73A3;
	Mon,  5 Jan 2026 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQ9J3SU7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1AD14F9D6;
	Mon,  5 Jan 2026 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606744; cv=none; b=tWbK6CAic+TLLDcc0pvezTOHzbmfX3B2G/ZEXBUAK437UC8ktm/UbMWXN9DgcvCtgZaaV8jDGeKGx/yXVvxn/W1kOr3lBYYzHDj2lftGF/kMVf665K4aEuE4MpbHRkuzi9TWQno63+Fp0BGiHCOIodgFTIOPmFuZCTwn45zCyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606744; c=relaxed/simple;
	bh=rIdwh3i8iJzdkK7g3RzApCbHBIt0WZef3WETv/UpmYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sk3O8arlloU9panf/kQ1yr/hHrdjJbDzj3yvIcTmPy9v/2y7zzF2LAtLCNi9P0jZ5oMZQvJInt64iNW9K9hU7My2T+ZiHDiFJsHm1BMG7KW3LUDdnVoDtGhX/Ucx05canO4Vk3J3Kd0YJ3clqDzchO5F9EwPjc0wdsCRF2BabwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQ9J3SU7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767606743; x=1799142743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rIdwh3i8iJzdkK7g3RzApCbHBIt0WZef3WETv/UpmYY=;
  b=bQ9J3SU7AadVfjBAH80Gm9ST/WtEoL8VfHW9VmIrl34iECid4ZtqlAOe
   yz4QpakQSaUGgPg1oV5PX3rLOmb0flPc1a32R5tuBOu5DlduZwpnLDNbV
   JU1HOPhYlkHjhzyNJxw3n6AsVDkFa9dsYTQDsM8E5nTlxl34isB/JYjvt
   7g/0u1RSKtYe7EIa2wbFcwMlPwVlYkI2tach4OY8lPyxrr6cqsMzc9JcP
   f3/zX+VtR3PVNeD/f1di73lgO1/xeu364A+meocbLqozUGI0ZG7AYh8Qa
   01EegrJz87anl6jRYakWH3cTOQk30g5ADElnDN1Gbvw4i2n7WZ4ILZgli
   g==;
X-CSE-ConnectionGUID: O3rVif6iRSe0vq3urZUsuQ==
X-CSE-MsgGUID: kZy50KleRl+QUaUi1T/kqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="69012922"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="69012922"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 01:52:22 -0800
X-CSE-ConnectionGUID: 3IIatdb6RBGuWQcc4GpoaA==
X-CSE-MsgGUID: bihwDKAuQMSN6Qcw5wRkVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="203326473"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 05 Jan 2026 01:52:20 -0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dan.j.williams@intel.com
Cc: yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	linux-kernel@vger.kernel.org,
	yi1.lai@intel.com,
	helgaas@kernel.org
Subject: [PATCH v2] PCI/IDE: Fix duplicate stream symlink names for TSM class devices
Date: Mon,  5 Jan 2026 17:35:16 +0800
Message-Id: <20260105093516.2645397-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The name streamH.R.E is used for 2 symlinks:

  1. TSM class devices: /sys/class/tsm/tsmN/streamH.R.E
  2. host bridge devices: /sys/devices/pciDDDD:BB/streamH.R.E

The first usage is broken cause streamH.R.E is only unique within a
specific host bridge but not across the system. Error occurs e.g. when
creating the first stream on a second host bridge:

  sysfs: cannot create duplicate filename '/devices/faux/tdx_host/tsm/tsm0/stream0.0.0'

Fix this by adding host bridge name into symlink name for TSM class
devices so they show up as:

  /sys/class/tsm/tsmN/pciDDDD:BB:streamH.R.E

It should be OK to change the uAPI since it's new and has few users.

The symlink name for host bridge devices keeps unchanged. Keep concise
as it is already in host bridge context.

Internally in the IDE library, store the full name in struct pci_ide
so TSM symlinks can use it directly as before, while host bridge
symlinks use only the streamH.R.E portion to preserve the existing name.

Fixes: a4438f06b1db ("PCI/TSM: Report active IDE streams")
Reported-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
v2: Changelog improvements

v1: https://lore.kernel.org/linux-coco/20251223085601.2607455-1-yilun.xu@linux.intel.com/
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
index f0ef474e1a0d..58fbe9cfd68c 100644
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
+	/* Strip host bridge name in the host bridge context */
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


