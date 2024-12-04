Return-Path: <linux-pci+bounces-17685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4013C9E424A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F3B168FCB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46935234993;
	Wed,  4 Dec 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtPxAq69"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916923498F;
	Wed,  4 Dec 2024 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332391; cv=none; b=LLa8kme9votPsn2jq+DHjROlO+SsClDjK45mQ5SuRqDhRZ3osPKiElng3ww7FxsyXnaXVxs+YWYwtc6EHwa5KCh5Cim7PwVbpjHog0we1cbMCb6NWxcnP9ncdfquX6vGs0jWzo4wsQEcRFt6v1oU5rc6bxwnDVzRnXBlroJ4K0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332391; c=relaxed/simple;
	bh=3WNLnOxjJBL3DWclwkV+TqDYZigHtqH0wReUhpxHHEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6YC1oI2H2lGWBNzd54j+o4RQpyd7kGLN+KSY7CAUnApbE2KOwYi0LKWI+RDUBYDZfNnQYFl+Uti19tBQjmw6AtX+5B8xvlJYkFxa97geYJR30FwWP/Ljf11Og5BMLGx3bH10besoEXKJ8yc15IM0Fc4U1RrcJ2CaNEUAcg1ZO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtPxAq69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61748C4CECD;
	Wed,  4 Dec 2024 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332390;
	bh=3WNLnOxjJBL3DWclwkV+TqDYZigHtqH0wReUhpxHHEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UtPxAq69v6g0zBM4eQRbHb2WluOaPxnJQUn4Q6p/tDwaj0JQSN5z/O1R3s3/6iF9z
	 1k2yLTNi61kTcuE739YgxypTqTt0cBuN9U0YdtBilZyIOmMMAITl7BbveCJBw8VFnk
	 Nb92BCQvV08SvREsnGr/Mc3zEkE85H5+ucB0aB34uBZJbi4Zz2aqguLK0wvCtsU6zm
	 L+tN3LASa0YVdKeH4xKgd87lYNAdmA4BfFUOSxQxLpucFjv+vI0dbcnlELmLCkPDd4
	 Jge64E7xSgaXrWeXtxS9OEN4IQCFJKFG1VLqhQYFpyQte1cy5hBuBcGR3mYKCgNSQx
	 f9PUaT7op/chQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Amey Narkhede <ameynarkhede03@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	mariusz.tkaczyk@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	stuart.w.hayes@gmail.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 4/6] PCI: Add 'reset_subordinate' to reset hierarchy below bridge
Date: Wed,  4 Dec 2024 11:01:36 -0500
Message-ID: <20241204160142.2217017-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160142.2217017-1-sashal@kernel.org>
References: <20241204160142.2217017-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 2fa046449a82a7d0f6d9721dd83e348816038444 ]

The "bus" and "cxl_bus" reset methods reset a device by asserting Secondary
Bus Reset on the bridge leading to the device.  These only work if the
device is the only device below the bridge.

Add a sysfs 'reset_subordinate' attribute on bridges that can assert
Secondary Bus Reset regardless of how many devices are below the bridge.

This resets all the devices below a bridge in a single command, including
the locking and config space save/restore that reset methods normally do.

This may be the only way to reset devices that don't support other reset
methods (ACPI, FLR, PM reset, etc).

Link: https://lore.kernel.org/r/20241025222755.3756162-1-kbusch@meta.com
Signed-off-by: Keith Busch <kbusch@kernel.org>
[bhelgaas: commit log, add capable(CAP_SYS_ADMIN) check]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Amey Narkhede <ameynarkhede03@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci | 11 +++++++++++
 drivers/pci/pci-sysfs.c                 | 26 +++++++++++++++++++++++++
 drivers/pci/pci.c                       |  2 +-
 drivers/pci/pci.h                       |  1 +
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 840727fc75dcf..6c5ca95a94105 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -163,6 +163,17 @@ Description:
 		will be present in sysfs.  Writing 1 to this file
 		will perform reset.
 
+What:		/sys/bus/pci/devices/.../reset_subordinate
+Date:		October 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		This is visible only for bridge devices. If you want to reset
+		all devices attached through the subordinate bus of a specific
+		bridge device, writing 1 to this will try to do it.  This will
+		affect all devices attached to the system through this bridge
+		similiar to writing 1 to their individual "reset" file, so use
+		with caution.
+
 What:		/sys/bus/pci/devices/.../vpd
 Date:		February 2008
 Contact:	Ben Hutchings <bwh@kernel.org>
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index df1c44a5c886c..e1a980179dc14 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -517,6 +517,31 @@ static ssize_t bus_rescan_store(struct device *dev,
 static struct device_attribute dev_attr_bus_rescan = __ATTR(rescan, 0200, NULL,
 							    bus_rescan_store);
 
+static ssize_t reset_subordinate_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_bus *bus = pdev->subordinate;
+	unsigned long val;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val) {
+		int ret = __pci_reset_bus(bus);
+
+		if (ret)
+			return ret;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset_subordinate);
+
 #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
 static ssize_t d3cold_allowed_store(struct device *dev,
 				    struct device_attribute *attr,
@@ -621,6 +646,7 @@ static struct attribute *pci_dev_attrs[] = {
 static struct attribute *pci_bridge_attrs[] = {
 	&dev_attr_subordinate_bus_number.attr,
 	&dev_attr_secondary_bus_number.attr,
+	&dev_attr_reset_subordinate.attr,
 	NULL,
 };
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0baf5c03ef4cb..24c4096f55c0c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5932,7 +5932,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-static int __pci_reset_bus(struct pci_bus *bus)
+int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5d5813aa5b458..38ad75ce52c32 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -37,6 +37,7 @@ bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
+int __pci_reset_bus(struct pci_bus *bus);
 
 struct pci_cap_saved_data {
 	u16		cap_nr;
-- 
2.43.0


