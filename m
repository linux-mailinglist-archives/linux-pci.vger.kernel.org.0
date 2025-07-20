Return-Path: <linux-pci+bounces-32600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3337B0B69D
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 17:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1615F17962C
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE10F72601;
	Sun, 20 Jul 2025 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZYo2juj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A271798F
	for <linux-pci@vger.kernel.org>; Sun, 20 Jul 2025 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753024560; cv=none; b=tIu3wCoUtRdr1R0jg8BmvHhFNE1P+GrVqCve7feL+uVEgdJsX9GK/wF7ayXXqVEBf0Qf/Am4I4d2sBPM+PyIGKftW7+/I7qoZMErgulUCbhDKSvtxD7sYrbOKOeqx1Z5pJxi/shZOtUyKkl93mXyNyf/wi0aUUAh1HGT6h9b8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753024560; c=relaxed/simple;
	bh=HLwGVhvogRppL2Zaos1fERsnH4mHvhOOhAYbiCpFhTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mD6wDnN2dB22+Q4aMUYrPRPXpn8jfdN09yRa+jLqyj6sJebUpV1WbFaNU/HtnNbjzcN6NJkVuN70BLwRZc0BlBhKIdca3TML4J/hsUdC8MQ95nLhU6dfHNmEVeEcYXtORj6lYZPOp/TuMt5q/4Aeklv3sOgPqRLD1wvMiCTRShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZYo2juj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C97C4CEE7;
	Sun, 20 Jul 2025 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753024560;
	bh=HLwGVhvogRppL2Zaos1fERsnH4mHvhOOhAYbiCpFhTE=;
	h=From:To:Cc:Subject:Date:From;
	b=gZYo2jujmOOhAivbYfR0vK7MQ/wLtQ/qk+GcW+Q7uqTlGdAMGx2z3whqqKHWN5ngh
	 M08L9oR8MOy7D3UYlGL66gSkz/oGbL1SUUmxAfKl6vlKWpSfJuzW4BlUTKJQNQrSaV
	 Ki1vBESLilG7JnigMZR4mIkzm0PI/ljrAZkq6kas4xsLp+XH2e/o7n2tBCKv2GRH6i
	 2tsI1bnoXGAZdyjHUovXrzSTUFpEhm27W15yhuQonuaFILdvSYD7szuiY2AfoAbEi/
	 AlNKhMutmiC/9/uANou4rvMLSAtEakW+p//4PtxFDe1C6cPlWoNgdSSfHnhUey0/Vw
	 GmlnWeAHVA0vA==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: Adjust visibility of boot_display attribute instead of creation
Date: Sun, 20 Jul 2025 10:15:08 -0500
Message-ID: <20250720151551.735348-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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
it static and use sysfs_update_group() to adjust visibility on the
applicable devices.

This also fixes a compilation warning when compiled without
CONFIG_VIDEO on sparc.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Change to sysfs_update_group() instead
---
 drivers/pci/pci-sysfs.c | 59 +++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6b1a0ae254d3a..462a90d13eb87 100644
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
@@ -1691,6 +1660,29 @@ static const struct attribute_group pci_dev_resource_resize_group = {
 	.is_visible = resource_resize_is_visible,
 };
 
+static struct attribute *pci_display_attrs[] = {
+	&dev_attr_boot_display.attr,
+	NULL,
+};
+
+static umode_t pci_boot_display_visible(struct kobject *kobj,
+					struct attribute *a, int n)
+{
+#ifdef CONFIG_VIDEO
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (a == &dev_attr_boot_display.attr && video_is_primary_device(&pdev->dev))
+		return a->mode;
+#endif
+	return 0;
+}
+
+static const struct attribute_group pci_display_attr_group = {
+	.attrs = pci_display_attrs,
+	.is_visible = pci_boot_display_visible,
+};
+
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	int retval;
@@ -1698,7 +1690,7 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return -EACCES;
 
-	retval = pci_create_boot_display_file(pdev);
+	retval = sysfs_update_group(&pdev->dev.kobj, &pci_display_attr_group);
 	if (retval)
 		return retval;
 
@@ -1716,7 +1708,6 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return;
 
-	pci_remove_boot_display_file(pdev);
 	pci_remove_resource_files(pdev);
 }
 
@@ -1755,7 +1746,6 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 
 	if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
 		return a->mode;
-
 	return 0;
 }
 
@@ -1845,6 +1835,7 @@ static const struct attribute_group pcie_dev_attr_group = {
 
 const struct attribute_group *pci_dev_attr_groups[] = {
 	&pci_dev_attr_group,
+	&pci_display_attr_group,
 	&pci_dev_hp_attr_group,
 #ifdef CONFIG_PCI_IOV
 	&sriov_pf_dev_attr_group,
-- 
2.43.0


