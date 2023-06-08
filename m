Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E06727F36
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjFHLoA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 07:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbjFHLns (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 07:43:48 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DF75E6C;
        Thu,  8 Jun 2023 04:43:43 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:48916.660287130
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 7246D1002AF;
        Thu,  8 Jun 2023 19:43:38 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xwndj with ESMTP id be5be8aede204d31a3c846f914d94a56 for alexander.deucher@amd.com;
        Thu, 08 Jun 2023 19:43:42 CST
X-Transaction-ID: be5be8aede204d31a3c846f914d94a56
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Li Yi <liyi@loongson.cn>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Abhishek Sahu <abhsahu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 4/4] PCI/VGA: introduce is_boot_device function callback to vga_client_register
Date:   Thu,  8 Jun 2023 19:43:22 +0800
Message-Id: <20230608114322.604887-5-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608114322.604887-1-15330273260@189.cn>
References: <20230608114322.604887-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

The vga_is_firmware_default() function is arch-dependent, which doesn't
sound right. At least, it also works on the Mips and LoongArch platforms.
Tested with the drm/amdgpu and drm/radeon drivers. However, it's difficult
to enumerate all arch-driver combinations. I'm wrong if there is only one
exception.

With the observation that device drivers typically have better knowledge
about which PCI bar contains the firmware framebuffer, which could avoid
the need to iterate all of the PCI BARs.

But as a PCI function at pci/vgaarb.c, vga_is_firmware_default() is
probably not suitable to make such an optimization for a specific device.

There are PCI display controllers that don't have a dedicated VRAM bar,
this function will lose its effectiveness in such a case. Luckily, the
device driver can provide an accurate workaround.

Therefore, this patch introduces a callback that allows the device driver
to tell the VGAARB if the device is the default boot device. This patch
only intends to introduce the mechanism, while the implementation is left
to the device driver authors. Also honor the comment: "Clients have two
callback mechanisms they can use"

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/i915/display/intel_vga.c   |  3 +--
 drivers/gpu/drm/nouveau/nouveau_vga.c      |  2 +-
 drivers/gpu/drm/radeon/radeon_device.c     |  2 +-
 drivers/pci/vgaarb.c                       | 22 ++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_core.c           |  2 +-
 include/linux/vgaarb.h                     |  8 +++++---
 7 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c7d40873ee2..7a096f2d5c16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3960,7 +3960,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* this will fail for cards that aren't VGA class devices, just
 	 * ignore it */
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
-		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
+		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode, NULL);
 
 	px = amdgpu_device_supports_px(ddev);
 
diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i915/display/intel_vga.c
index 286a0bdd28c6..98d7d4dffe9f 100644
--- a/drivers/gpu/drm/i915/display/intel_vga.c
+++ b/drivers/gpu/drm/i915/display/intel_vga.c
@@ -115,7 +115,6 @@ intel_vga_set_decode(struct pci_dev *pdev, bool enable_decode)
 
 int intel_vga_register(struct drm_i915_private *i915)
 {
-
 	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 	int ret;
 
@@ -127,7 +126,7 @@ int intel_vga_register(struct drm_i915_private *i915)
 	 * then we do not take part in VGA arbitration and the
 	 * vga_client_register() fails with -ENODEV.
 	 */
-	ret = vga_client_register(pdev, intel_vga_set_decode);
+	ret = vga_client_register(pdev, intel_vga_set_decode, NULL);
 	if (ret && ret != -ENODEV)
 		return ret;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
index f8bf0ec26844..162b4f4676c7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_vga.c
+++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
@@ -92,7 +92,7 @@ nouveau_vga_init(struct nouveau_drm *drm)
 		return;
 	pdev = to_pci_dev(dev->dev);
 
-	vga_client_register(pdev, nouveau_vga_set_decode);
+	vga_client_register(pdev, nouveau_vga_set_decode, NULL);
 
 	/* don't register Thunderbolt eGPU with vga_switcheroo */
 	if (pci_is_thunderbolt_attached(pdev))
diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index afbb3a80c0c6..71f2ff39d6a1 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1425,7 +1425,7 @@ int radeon_device_init(struct radeon_device *rdev,
 	/* if we have > 1 VGA cards, then disable the radeon VGA resources */
 	/* this will fail for cards that aren't VGA class devices, just
 	 * ignore it */
-	vga_client_register(rdev->pdev, radeon_vga_set_decode);
+	vga_client_register(rdev->pdev, radeon_vga_set_decode, NULL);
 
 	if (rdev->flags & RADEON_IS_PX)
 		runtime = true;
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index b0bf4952a95d..d3dab61e0ef2 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -53,6 +53,7 @@ struct vga_device {
 	bool bridge_has_one_vga;
 	bool is_firmware_default;	/* device selected by firmware */
 	unsigned int (*set_decode)(struct pci_dev *pdev, bool decode);
+	bool (*is_boot_device)(struct pci_dev *pdev);
 };
 
 static LIST_HEAD(vga_list);
@@ -614,10 +615,17 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 	if (boot_vga && boot_vga->is_firmware_default)
 		return false;
 
-	if (vga_is_firmware_default(pdev)) {
-		vgadev->is_firmware_default = true;
+	/*
+	 * Ask the device driver first, if registered. Fallback to the
+	 * default implement if the callback is non-exist.
+	 */
+	if (vgadev->is_boot_device)
+		vgadev->is_firmware_default = vgadev->is_boot_device(pdev);
+	else
+		vgadev->is_firmware_default = vga_is_firmware_default(pdev);
+
+	if (vgadev->is_firmware_default)
 		return true;
-	}
 
 	/*
 	 * A legacy VGA device has MEM and IO enabled and any bridges
@@ -954,6 +962,10 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
  * @set_decode callback: If a client can disable its GPU VGA resource, it
  * will get a callback from this to set the encode/decode state.
  *
+ * @is_boot_device: callback to the device driver, query if a client is the
+ * default boot device, as the device driver typically has better knowledge
+ * if specific device is the boot device. But this callback is optional.
+ *
  * Rationale: we cannot disable VGA decode resources unconditionally, some
  * single GPU laptops seem to require ACPI or BIOS access to the VGA registers
  * to control things like backlights etc. Hopefully newer multi-GPU laptops do
@@ -969,7 +981,8 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
  * Returns: 0 on success, -1 on failure
  */
 int vga_client_register(struct pci_dev *pdev,
-		unsigned int (*set_decode)(struct pci_dev *pdev, bool decode))
+		unsigned int (*set_decode)(struct pci_dev *pdev, bool decode),
+		bool (*is_boot_device)(struct pci_dev *pdev))
 {
 	int ret = -ENODEV;
 	struct vga_device *vgadev;
@@ -981,6 +994,7 @@ int vga_client_register(struct pci_dev *pdev,
 		goto bail;
 
 	vgadev->set_decode = set_decode;
+	vgadev->is_boot_device = is_boot_device;
 	ret = 0;
 
 bail:
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a5ab416cf476..2a8873a330ba 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2067,7 +2067,7 @@ static int vfio_pci_vga_init(struct vfio_pci_core_device *vdev)
 	if (ret)
 		return ret;
 
-	ret = vga_client_register(pdev, vfio_pci_set_decode);
+	ret = vga_client_register(pdev, vfio_pci_set_decode, NULL);
 	if (ret)
 		return ret;
 	vga_set_legacy_decoding(pdev, vfio_pci_set_decode(pdev, false));
diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index d36225c582ee..66fe80ffad76 100644
--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -50,7 +50,8 @@ struct pci_dev *vga_default_device(void);
 void vga_set_default_device(struct pci_dev *pdev);
 int vga_remove_vgacon(struct pci_dev *pdev);
 int vga_client_register(struct pci_dev *pdev,
-		unsigned int (*set_decode)(struct pci_dev *pdev, bool state));
+		unsigned int (*set_decode)(struct pci_dev *pdev, bool state),
+		bool (*is_boot_device)(struct pci_dev *pdev));
 #else /* CONFIG_VGA_ARB */
 static inline void vga_set_legacy_decoding(struct pci_dev *pdev,
 		unsigned int decodes)
@@ -76,7 +77,8 @@ static inline int vga_remove_vgacon(struct pci_dev *pdev)
 	return 0;
 }
 static inline int vga_client_register(struct pci_dev *pdev,
-		unsigned int (*set_decode)(struct pci_dev *pdev, bool state))
+		unsigned int (*set_decode)(struct pci_dev *pdev, bool state),
+		bool (*is_boot_device)(struct pci_dev *pdev))
 {
 	return 0;
 }
@@ -114,7 +116,7 @@ static inline int vga_get_uninterruptible(struct pci_dev *pdev,
 
 static inline void vga_client_unregister(struct pci_dev *pdev)
 {
-	vga_client_register(pdev, NULL);
+	vga_client_register(pdev, NULL, NULL);
 }
 
 #endif /* LINUX_VGA_H */
-- 
2.25.1

