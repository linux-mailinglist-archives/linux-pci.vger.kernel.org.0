Return-Path: <linux-pci+bounces-32698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27C8B0D0D5
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 06:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D41F3AA162
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 04:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A128C85B;
	Tue, 22 Jul 2025 04:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buD7Ak1k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C8E287261;
	Tue, 22 Jul 2025 04:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753157459; cv=none; b=sPaOMfdMKN3mkW0xwF+2R0aoLoOZl1rRWIoxxaFKky+BTJVpV2+xMYAEqTp1gspc1rZm9SveFPRjf8Yj2VEZR3r1nOI3baMyGReSLQFfZ4DHGvtIO/myBZNNZT12BOKjbMzwRxpdv7UlrsgN3NNktxpaipiqZ41S53LWZbibCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753157459; c=relaxed/simple;
	bh=5pRINa2Uw1HJ6EfpIJKtL5DXahUnPGMFtESCs6BNIqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sL6EIhDBKb+nzpskXh7CiuwnWalSFcVDs7lHgajf/jp8uJA9+T/agKtvo18DafqcxwSJxX48CUvHnKVIgICEdV8mGC9KRrkGD5aKm+QAJgj3o9gNcsdMU6lHy0X6hoWznIjc3ZCju9uTVonl0HxsQ+M560jrhEpwUbXTqM+PrSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buD7Ak1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58EEC4CEF1;
	Tue, 22 Jul 2025 04:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753157458;
	bh=5pRINa2Uw1HJ6EfpIJKtL5DXahUnPGMFtESCs6BNIqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buD7Ak1k7SYer/ngoEjMz6g9j9J2Lrb6uOlA4vixmgTpJl6hj8FNeY4DCyHovW0Ze
	 8FQkMj/zZw3iVjlBz4gtk32WTb37m7LFfw0ozc8AQDQ34cqUXyBjid1f6/y09lM0Mk
	 I9+GvWDSZ+g7zD7FuLvJftEmXNw/coA2FgWDLMTZKtYGPxJ3F/17pGsRN1z8ov7w37
	 kmT9LEchVbHDohgI50JMCr3OFvxycA9l2NiPmM3oU5eZo9O7bhP46RU4Odn+PPtYuR
	 11SJgYW1wk55SlprO8YYrg61/ytmBwjRuawljxXuKdUQ6UaxQSZTY7Myht1uGc/uPJ
	 5L0mPcG7e74Qw==
From: Mario Limonciello <superm1@kernel.org>
To: David Airlie <airlied@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	Daniel Dadap <ddadap@nvidia.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v5 2/2] PCI: Adjust visibility of boot_display attribute instead of creation
Date: Mon, 21 Jul 2025 23:10:51 -0500
Message-ID: <20250722041051.3354121-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722041051.3354121-1-superm1@kernel.org>
References: <20250722041051.3354121-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

There is a desire to avoid creating new sysfs files late, so instead
of dynamically deciding to create the boot_display attribute, make
it static.

This also fixes a compilation failure when compiled without
CONFIG_VIDEO on sparc.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5
 * Fixups for comma and CONFIG_VIDEO
 * Drop sysfs_update_group() as it's no longer needed
 * Drop pointers in pci_boot_display_visible()
v3:
 * Move to pci_sysfs_init()
v2:
 * Change to sysfs_update_group() instead
---
 drivers/pci/pci-sysfs.c | 58 ++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6b1a0ae254d3a..f5d98795a12fe 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1059,37 +1059,6 @@ void pci_remove_legacy_files(struct pci_bus *b)
 }
 #endif /* HAVE_PCI_LEGACY */
 
-/**
- * pci_create_boot_display_file - create a file in sysfs for @dev
- * @pdev: dev in question
- *
- * Creates a file `boot_display` in sysfs for the PCI device @pdev
- * if it is the boot display device.
- */
-static int pci_create_boot_display_file(struct pci_dev *pdev)
-{
-#ifdef CONFIG_VIDEO
-	if (video_is_primary_device(&pdev->dev))
-		return sysfs_create_file(&pdev->dev.kobj, &dev_attr_boot_display.attr);
-#endif
-	return 0;
-}
-
-/**
- * pci_remove_boot_display_file - remove the boot display file for @dev
- * @pdev: dev in question
- *
- * Removes the file `boot_display` in sysfs for the PCI device @pdev
- * if it is the boot display device.
- */
-static void pci_remove_boot_display_file(struct pci_dev *pdev)
-{
-#ifdef CONFIG_VIDEO
-	if (video_is_primary_device(&pdev->dev))
-		sysfs_remove_file(&pdev->dev.kobj, &dev_attr_boot_display.attr);
-#endif
-}
-
 #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 /**
  * pci_mmap_resource - map a PCI resource into user memory space
@@ -1691,17 +1660,30 @@ static const struct attribute_group pci_dev_resource_resize_group = {
 	.is_visible = resource_resize_is_visible,
 };
 
-int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
+static struct attribute *pci_display_attrs[] = {
+	&dev_attr_boot_display.attr,
+	NULL
+};
+
+static umode_t pci_boot_display_visible(struct kobject *kobj,
+					struct attribute *a, int n)
 {
-	int retval;
+	if (video_is_primary_device(kobj_to_dev(kobj)))
+		return a->mode;
 
+	return 0;
+}
+
+static const struct attribute_group pci_display_attr_group = {
+	.attrs = pci_display_attrs,
+	.is_visible = pci_boot_display_visible,
+};
+
+int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
+{
 	if (!sysfs_initialized)
 		return -EACCES;
 
-	retval = pci_create_boot_display_file(pdev);
-	if (retval)
-		return retval;
-
 	return pci_create_resource_files(pdev);
 }
 
@@ -1716,7 +1698,6 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return;
 
-	pci_remove_boot_display_file(pdev);
 	pci_remove_resource_files(pdev);
 }
 
@@ -1845,6 +1826,7 @@ static const struct attribute_group pcie_dev_attr_group = {
 
 const struct attribute_group *pci_dev_attr_groups[] = {
 	&pci_dev_attr_group,
+	&pci_display_attr_group,
 	&pci_dev_hp_attr_group,
 #ifdef CONFIG_PCI_IOV
 	&sriov_pf_dev_attr_group,
-- 
2.48.1


