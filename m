Return-Path: <linux-pci+bounces-32674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A3B0CAC1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 20:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CC63BB5A3
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 18:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC36221D94;
	Mon, 21 Jul 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqXQJH0t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88143221721;
	Mon, 21 Jul 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124251; cv=none; b=CNHgWbt5XJnixlRJVONbjJUuAGMr3sb1QW+8pPvjNa7Y9mf9//HbJzQilCuX+QrG2SGa/G7uMh4qvtxdipFaOCOrydqeLTXKpqGpDI97kinDYLa2zIa2NNc11iUGUPAVNApWAo8YvSKdndxBhFnWjC7+Fk/9GW7asQaDscdjDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124251; c=relaxed/simple;
	bh=3u19+HJbqZLGOkvO9EOVcJxRBd+pyMHDYhsiKgTxEtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiCb84AiY/uCwoiDYiCW5ZsgBOn2nUSCh5WbC2kFs9A5KMX7vFkpM4GMhczKC+s/BTwz2kQYw2tYXmFeEZfxY1PPQLdDhpa7FA4u4lZmVIOFdph/qVlmvCnXgZxEROCAYcjCOAtXKHIVIPDE6IDda+r+eiHZp2/GOygDuDWkh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqXQJH0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B6EC4CEF4;
	Mon, 21 Jul 2025 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753124251;
	bh=3u19+HJbqZLGOkvO9EOVcJxRBd+pyMHDYhsiKgTxEtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqXQJH0tXgQZIPE5fhuL/ULHSjaem2QXkQJoDZmcqrVweiw3bR2jcKnEHqTWQxWxx
	 0eRATsmQX8XMqP8YY1+YzL+tAx7zYq68IqbQRVzqmhxXa6PCFwVP1SLIJgRAxHvKwB
	 zysbiLIZU2NLn841wk7vl7FFa9BUgpK9NBRfVla/tqqHarTZJ3YkpTYg0qWpqkpgjV
	 pqcqvm0g83ituE+LgGUIrRvdg1gDhDkP0OXXVYj6WCfYlQwQ57fAS34j4Xa5um/Hzl
	 to1nyf9loSMGGjhPSLh7mmMCq8LyZ2WJaazcpInzRvTpAJD00G7KqGZgbngwvYWUUN
	 f8Q5Nc+HTY4Mg==
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
	Manivannan Sadhasivam <mani@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v4 1/1] PCI: Move boot display attribute to DRM
Date: Mon, 21 Jul 2025 13:57:26 -0500
Message-ID: <20250721185726.1264909-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721185726.1264909-1-superm1@kernel.org>
References: <20250721185726.1264909-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The boot_display attribute is currently created by PCI core, but the
main reason it exists is for userspace software that interacts with
drm to make decisions. Move the attribute to DRM.

This also fixes a compilation failure when compiled without
CONFIG_VIDEO on sparc.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-pci   |  9 -----
 Documentation/ABI/testing/sysfs-class-drm |  8 ++++
 drivers/gpu/drm/drm_sysfs.c               | 41 +++++++++++++++++++++
 drivers/pci/pci-sysfs.c                   | 45 -----------------------
 4 files changed, 49 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-drm

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index a2c74d4ebeadd..69f952fffec72 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -612,12 +612,3 @@ Description:
 
 		  # ls doe_features
 		  0001:01        0001:02        doe_discovery
-
-What:		/sys/bus/pci/devices/.../boot_display
-Date:		October 2025
-Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
-Description:
-		This file indicates that displays connected to the device were
-		used to display the boot sequence.  If a display connected to
-		the device was used to display the boot sequence the file will
-		be present and contain "1".
diff --git a/Documentation/ABI/testing/sysfs-class-drm b/Documentation/ABI/testing/sysfs-class-drm
new file mode 100644
index 0000000000000..536820afca05b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-drm
@@ -0,0 +1,8 @@
+What:		/sys/class/drm/.../boot_display
+Date:		October 2025
+Contact:	Linux DRI developers <dri-devel@vger.kernel.org>
+Description:
+		This file indicates that displays connected to the device were
+		used to display the boot sequence.  If a display connected to
+		the device was used to display the boot sequence the file will
+		be present and contain "1".
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 60c1f26edb6fa..1bc2e6abaa1a9 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -18,6 +18,7 @@
 #include <linux/gfp.h>
 #include <linux/i2c.h>
 #include <linux/kdev_t.h>
+#include <linux/pci.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
@@ -30,6 +31,8 @@
 #include <drm/drm_property.h>
 #include <drm/drm_sysfs.h>
 
+#include <asm/video.h>
+
 #include "drm_internal.h"
 #include "drm_crtc_internal.h"
 
@@ -508,6 +511,43 @@ void drm_sysfs_connector_property_event(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_sysfs_connector_property_event);
 
+static ssize_t boot_display_show(struct device *dev, struct device_attribute *attr,
+				 char *buf)
+{
+	return sysfs_emit(buf, "1\n");
+}
+static DEVICE_ATTR_RO(boot_display);
+
+static struct attribute *display_attrs[] = {
+	&dev_attr_boot_display.attr,
+	NULL
+};
+
+static umode_t boot_display_visible(struct kobject *kobj,
+				    struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj)->parent;
+
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		if (video_is_primary_device(&pdev->dev))
+			return a->mode;
+	}
+
+	return 0;
+}
+
+static const struct attribute_group display_attr_group = {
+	.attrs = display_attrs,
+	.is_visible = boot_display_visible,
+};
+
+static const struct attribute_group *card_dev_groups[] = {
+	&display_attr_group,
+	NULL
+};
+
 struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
 {
 	const char *minor_str;
@@ -531,6 +571,7 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
 
 		kdev->devt = MKDEV(DRM_MAJOR, minor->index);
 		kdev->class = drm_class;
+		kdev->groups = card_dev_groups;
 		kdev->type = &drm_sysfs_device_minor;
 	}
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6ccd65f5b1051..b3fb6024e0ba7 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -680,13 +680,6 @@ const struct attribute_group *pcibus_groups[] = {
 	NULL,
 };
 
-static ssize_t boot_display_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "1\n");
-}
-static DEVICE_ATTR_RO(boot_display);
-
 static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -1059,37 +1052,6 @@ void pci_remove_legacy_files(struct pci_bus *b)
 }
 #endif /* HAVE_PCI_LEGACY */
 
-/**
- * pci_create_boot_display_file - create "boot_display"
- * @pdev: dev in question
- *
- * Create "boot_display" in sysfs for the PCI device @pdev if it is the
- * boot display device.
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
- * pci_remove_boot_display_file - remove "boot_display"
- * @pdev: dev in question
- *
- * Remove "boot_display" in sysfs for the PCI device @pdev if it is the
- * boot display device.
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
@@ -1693,15 +1655,9 @@ static const struct attribute_group pci_dev_resource_resize_group = {
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
-	int retval;
-
 	if (!sysfs_initialized)
 		return -EACCES;
 
-	retval = pci_create_boot_display_file(pdev);
-	if (retval)
-		return retval;
-
 	return pci_create_resource_files(pdev);
 }
 
@@ -1716,7 +1672,6 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return;
 
-	pci_remove_boot_display_file(pdev);
 	pci_remove_resource_files(pdev);
 }
 
-- 
2.43.0


