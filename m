Return-Path: <linux-pci+bounces-32606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ADDB0BAD8
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 04:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FAE3B44AD
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 02:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0D84D13;
	Mon, 21 Jul 2025 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcseaKMx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709232E36EE
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753065504; cv=none; b=dHGjNpGwGSHnhklk1KhnMgK2rFJ+qL/0RMNjd2JBoQ8VQDW7AVvWCu5KZUKVj7cHm4JlgmaRUp5Rbt7hIQr1+195cLlN/8K8MqI+N83xf7iYQZzyPY2qoUjeDar8bnGboHZjc2sSVGRRDnx1s6gp/gRGHu1JQqFTokyBpjk3v5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753065504; c=relaxed/simple;
	bh=YTCU5uiigh3wPKvV/cAgXPwImMQKHvzGt6U3g7uHYF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itVvQ5Eetv+kilqjEMQAte6WviKdpGuSoXnXJWUQAY6IC6bo2CGgyydGkLWtudFAej44RYw6eug77/545IntWdTnTSC0BRcQ5Bz+Z8Jy/bGgPY70TPtlZ5LbC3gR1MqBnbUnLQvQp85LeO/gVx75uPmowzcJRT5BSrTPimdNEXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcseaKMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7967AC4CEE7;
	Mon, 21 Jul 2025 02:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753065504;
	bh=YTCU5uiigh3wPKvV/cAgXPwImMQKHvzGt6U3g7uHYF0=;
	h=From:To:Cc:Subject:Date:From;
	b=VcseaKMxT6RJsU7SoYqOj2Z8T0gKZzsSF9k9YkcIiXl6gQpenu/g/Ylntuwh19hvi
	 tBy4NdlPbtSMg9dLXu9HbWXZKfRyvJnedHGRo2rJL2J5ADOUz3MrDKyoRhPKREwvRL
	 F3iS+fwz/DX8C7PIf3NEEeGtxUOjkzCp0H12vMDhwbcZGyYYrFRYpHPOQtixfp74eo
	 P+0Ns0MlG8udVBpZ3CUf/ZsSRjugh//ecRzpnMFtUVt4ZKmzysz7r/oIHiqGwtcKTK
	 y5TSeoXa+Nn1ljXXSbh5RSZ7bxvNg9+GYJf4z84TSUtUJE9d1n+jbTHMkfw7NkzUi+
	 BNK6GCDZbUvZw==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3] PCI: Adjust visibility of boot_display attribute instead of creation
Date: Sun, 20 Jul 2025 21:37:58 -0500
Message-ID: <20250721023818.2410062-1-superm1@kernel.org>
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

This also fixes a compilation failure when compiled without
CONFIG_VIDEO on sparc.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Move to pci_sysfs_init()
v2:
 * Change to sysfs_update_group() instead
---
 drivers/pci/pci-sysfs.c | 67 ++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6b1a0ae254d3a..65ba67af0f6cc 100644
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
@@ -1691,17 +1660,34 @@ static const struct attribute_group pci_dev_resource_resize_group = {
 	.is_visible = resource_resize_is_visible,
 };
 
-int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
+static struct attribute *pci_display_attrs[] = {
+	&dev_attr_boot_display.attr,
+	NULL,
+};
+
+static umode_t pci_boot_display_visible(struct kobject *kobj,
+					struct attribute *a, int n)
 {
-	int retval;
+#ifdef CONFIG_VIDEO
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (a == &dev_attr_boot_display.attr && video_is_primary_device(&pdev->dev))
+		return a->mode;
+#endif
+	return 0;
+}
 
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
 
@@ -1716,7 +1702,6 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return;
 
-	pci_remove_boot_display_file(pdev);
 	pci_remove_resource_files(pdev);
 }
 
@@ -1728,6 +1713,11 @@ static int __init pci_sysfs_init(void)
 
 	sysfs_initialized = 1;
 	for_each_pci_dev(pdev) {
+		retval = sysfs_update_group(&pdev->dev.kobj, &pci_display_attr_group);
+		if (retval) {
+			pci_dev_put(pdev);
+			return retval;
+		}
 		retval = pci_create_sysfs_dev_files(pdev);
 		if (retval) {
 			pci_dev_put(pdev);
@@ -1845,6 +1835,7 @@ static const struct attribute_group pcie_dev_attr_group = {
 
 const struct attribute_group *pci_dev_attr_groups[] = {
 	&pci_dev_attr_group,
+	&pci_display_attr_group,
 	&pci_dev_hp_attr_group,
 #ifdef CONFIG_PCI_IOV
 	&sriov_pf_dev_attr_group,
-- 
2.43.0


