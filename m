Return-Path: <linux-pci+bounces-29628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B0AD817C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 05:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09ED216BA71
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 03:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5788D257458;
	Fri, 13 Jun 2025 03:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thlaY0oS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243F923D2A4
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784368; cv=none; b=tWoObOHdR0e586OLBEYyMHN3IVjnmhONSbgg0qQrtFz/Mz+bjk22IUj4CR4EhHp+Rdaisw/g/ww3CQW4WjSWLwmc6/Dwyx3dU9qwAM8ILe/gCmjN52oi6T1iXG97PPXJ6ZEmOzi289dC67pVKfX/IMjqheEuyqwxKeiOkMYpX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784368; c=relaxed/simple;
	bh=lBDB7ObzOtutcnYZ+ZSuPxjPekEelrLTTsGfWEnUZMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfetunUm+a90mWBd1Q+bXqk51bkk97cx2QRHQ7yii3ULSeSPA7tiWaIRhyzslOBfDY2FCaUSryQi0Mv7PEj/yEDzra1H8M6VGrYq1Jsyw7KK6ZFnrVU+m4cJdGUFC5DJLI1ylh3ZqoS49DnN3ULfydf3hZn57vjI6EcDOjW5G/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thlaY0oS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385B4C4CEEA;
	Fri, 13 Jun 2025 03:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749784367;
	bh=lBDB7ObzOtutcnYZ+ZSuPxjPekEelrLTTsGfWEnUZMY=;
	h=From:To:Cc:Subject:Date:From;
	b=thlaY0oScuC6A8SXXJXBA7TcJgQl8C3ErM1A14rppeIeegCPjcLGF+bVpqcNHctnj
	 ECWMeWFRUJ3V3GsQR/DOZCWASH5OwbFkliBkZ5ttOi36Cy8p2yqF0PZ69VAp07aezc
	 KUc7RJKmtE6T9+GEdlIp7e80F3LGqdGbcTjcxyo39wo4m4iHZVQmEr5dk7alfebM6f
	 2lXwJlgXGdCA9Vk6FoYQocZj5e0AVZkPgXULy1k13MlRVsCbN19VVxp6L515izsZuF
	 mZn2Ue/HWEr2/cO+PLmI/7jTOkCXUCpcy5Te3vtKjiHrTHsle/CnitzKOTcJDZDCWb
	 qQjJVjLod7Klw==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
Date: Thu, 12 Jun 2025 22:12:14 -0500
Message-ID: <20250613031215.615885-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

On an A+N mobile system the APU is not being selected by some desktop
environments for any rendering tasks. This is because the neither GPU
is being treated as "boot_vga" but that is what some environments use
to select a GPU [1].

The VGA arbiter driver only looks at devices that report as PCI display
VGA class devices. Neither GPU on the system is a display VGA class
device:

c5:00.0 3D controller: NVIDIA Corporation Device 2db9 (rev a1)
c6:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Device 150e (rev d1)

So neither device gets the boot_vga sysfs file. The vga_is_boot_device()
function already has some handling for integrated GPUs by looking at the
ACPI HID entries, so if all PCI display class devices are looked at it
actually can detect properly with this device ordering.  However if there
is a different ordering it could flag the wrong device.

Modify the VGA arbiter code and matching sysfs file entries to examine all
PCI display class devices. After every device is added to the arbiter list
make a pass on all devices and explicitly check whether one is integrated.

This will cause all GPUs to gain a `boot_vga` file, but the correct device
(APU in this case) will now show `1` and the incorrect device shows `0`.
Userspace then picks the right device as well.

Link: https://github.com/robherring/libpciaccess/commit/b2838fb61c3542f107014b285cbda097acae1e12 [1]
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC->v1:
 * Add tag
 * Drop unintended whitespace change
 * Use vgaarb_dbg instead of vgaarb_info
---
 drivers/pci/pci-sysfs.c |  2 +-
 drivers/pci/vgaarb.c    | 48 +++++++++++++++++++++++++++--------------
 include/linux/pci.h     | 15 +++++++++++++
 3 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 268c69daa4d57..c314ee1b3f9ac 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1707,7 +1707,7 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
+	if (a == &dev_attr_boot_vga.attr && pci_is_display(pdev))
 		return a->mode;
 
 	return 0;
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 78748e8d2dbae..0eb1274d52169 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -140,6 +140,7 @@ void vga_set_default_device(struct pci_dev *pdev)
 	if (vga_default == pdev)
 		return;
 
+	vgaarb_dbg(&pdev->dev, "selecting as VGA boot device\n");
 	pci_dev_put(vga_default);
 	vga_default = pci_dev_get(pdev);
 }
@@ -751,6 +752,31 @@ static void vga_arbiter_check_bridge_sharing(struct vga_device *vgadev)
 		vgaarb_info(&vgadev->pdev->dev, "no bridge control possible\n");
 }
 
+static
+void vga_arbiter_select_default_device(void)
+{
+	struct pci_dev *candidate = vga_default_device();
+	struct vga_device *vgadev;
+
+	list_for_each_entry(vgadev, &vga_list, list) {
+		if (vga_is_boot_device(vgadev)) {
+			/* check if one is an integrated GPU, use that if so */
+			if (candidate) {
+				if (vga_arb_integrated_gpu(&candidate->dev))
+					break;
+				if (vga_arb_integrated_gpu(&vgadev->pdev->dev)) {
+					candidate = vgadev->pdev;
+					break;
+				}
+			} else
+				candidate = vgadev->pdev;
+		}
+	}
+
+	if (candidate)
+		vga_set_default_device(candidate);
+}
+
 /*
  * Currently, we assume that the "initial" setup of the system is not sane,
  * that is, we come up with conflicting devices and let the arbiter's
@@ -816,23 +842,17 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 		bus = bus->parent;
 	}
 
-	if (vga_is_boot_device(vgadev)) {
-		vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
-			    vga_default_device() ?
-			    " (overriding previous)" : "");
-		vga_set_default_device(pdev);
-	}
-
 	vga_arbiter_check_bridge_sharing(vgadev);
 
 	/* Add to the list */
 	list_add_tail(&vgadev->list, &vga_list);
 	vga_count++;
-	vgaarb_info(&pdev->dev, "VGA device added: decodes=%s,owns=%s,locks=%s\n",
+	vgaarb_dbg(&pdev->dev, "VGA device added: decodes=%s,owns=%s,locks=%s\n",
 		vga_iostate_to_str(vgadev->decodes),
 		vga_iostate_to_str(vgadev->owns),
 		vga_iostate_to_str(vgadev->locks));
 
+	vga_arbiter_select_default_device();
 	spin_unlock_irqrestore(&vga_lock, flags);
 	return true;
 fail:
@@ -1499,8 +1519,8 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
 
 	vgaarb_dbg(dev, "%s\n", __func__);
 
-	/* Only deal with VGA class devices */
-	if (!pci_is_vga(pdev))
+	/* Only deal with display devices */
+	if (!pci_is_display(pdev))
 		return 0;
 
 	/*
@@ -1548,12 +1568,8 @@ static int __init vga_arb_device_init(void)
 
 	/* Add all VGA class PCI devices by default */
 	pdev = NULL;
-	while ((pdev =
-		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-			       PCI_ANY_ID, pdev)) != NULL) {
-		if (pci_is_vga(pdev))
-			vga_arbiter_add_pci_device(pdev);
-	}
+	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev)))
+		vga_arbiter_add_pci_device(pdev);
 
 	pr_info("loaded\n");
 	return rc;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f3923..e77754e43c629 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -744,6 +744,21 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
 	return false;
 }
 
+/**
+ * pci_is_display - Check if a PCI device is a display controller
+ * @pdev: Pointer to the PCI device structure
+ *
+ * This function determines whether the given PCI device corresponds
+ * to a display controller. Display controllers are typically used
+ * for graphical output and are identified based on their class code.
+ *
+ * Return: true if the PCI device is a display controller, false otherwise.
+ */
+static inline bool pci_is_display(struct pci_dev *pdev)
+{
+	return (pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY;
+}
+
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
 		if (!pci_is_bridge(dev)) {} else
-- 
2.43.0


