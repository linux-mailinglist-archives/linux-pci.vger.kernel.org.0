Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8A772D7E6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jun 2023 05:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbjFMDEx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 23:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbjFMDEG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 23:04:06 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 232511FFD;
        Mon, 12 Jun 2023 20:03:04 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:47948.1267835893
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 07D72100312;
        Tue, 13 Jun 2023 11:02:10 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-7vx9t with ESMTP id cc3a4c0ad4584704b36637bc3ff8007e for bhelgaas@google.com;
        Tue, 13 Jun 2023 11:02:13 CST
X-Transaction-ID: cc3a4c0ad4584704b36637bc3ff8007e
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>
Subject: [PATCH v7 5/8] video/aperture: Add a helper to detect if an aperture contains firmware FB
Date:   Tue, 13 Jun 2023 11:01:48 +0800
Message-Id: <20230613030151.216625-6-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613030151.216625-1-15330273260@189.cn>
References: <20230613030151.216625-1-15330273260@189.cn>
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

This patch adds the aperture_contain_firmware_fb() function to do the
determination. Unfortunately due to the fact that apertures list will be
freed dynamically, the location and size information of the firmware fb
will be lost after dedicated drivers call
aperture_remove_conflicting_devices(),
aperture_remove_conflicting_pci_devices() or
aperture_remove_all_conflicting_devices() functions

We handle this problem by introducing two static variables which record the
firmware framebuffer's start addrness and end addrness. It assumes that the
system has only one active firmware framebuffer driver at a time.

We don't use the global structure screen_info here, because PCI resource
may get reallocated(the VRAM BAR could be moved) at kernel boot stage.

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/drm_aperture.c | 16 ++++++++++++++++
 drivers/video/aperture.c       | 29 +++++++++++++++++++++++++++++
 include/drm/drm_aperture.h     |  2 ++
 include/linux/aperture.h       |  7 +++++++
 4 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/drm_aperture.c b/drivers/gpu/drm/drm_aperture.c
index 5729f3bb4398..6e5d8a08683c 100644
--- a/drivers/gpu/drm/drm_aperture.c
+++ b/drivers/gpu/drm/drm_aperture.c
@@ -190,3 +190,19 @@ int drm_aperture_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
 	return aperture_remove_conflicting_pci_devices(pdev, req_driver->name);
 }
 EXPORT_SYMBOL(drm_aperture_remove_conflicting_pci_framebuffers);
+
+/**
+ * drm_aperture_contain_firmware_fb - Determine if a aperture contains firmware framebuffer
+ *
+ * @base: the aperture's base address in physical memory
+ * @size: aperture size in bytes
+ *
+ * Returns:
+ * true on if there is a firmware framebuffer belong to the aperture passed in,
+ * or false otherwise.
+ */
+bool drm_aperture_contain_firmware_fb(resource_size_t base, resource_size_t size)
+{
+	return aperture_contain_firmware_fb(base, base + size);
+}
+EXPORT_SYMBOL(drm_aperture_contain_firmware_fb);
diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 561be8feca96..5a5422cec669 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -141,6 +141,9 @@ struct aperture_range {
 static LIST_HEAD(apertures);
 static DEFINE_MUTEX(apertures_lock);
 
+static resource_size_t firm_fb_start;
+static resource_size_t firm_fb_end;
+
 static bool overlap(resource_size_t base1, resource_size_t end1,
 		    resource_size_t base2, resource_size_t end2)
 {
@@ -170,6 +173,9 @@ static int devm_aperture_acquire(struct device *dev,
 
 	mutex_lock(&apertures_lock);
 
+	firm_fb_start = base;
+	firm_fb_end = end;
+
 	list_for_each(pos, &apertures) {
 		ap = container_of(pos, struct aperture_range, lh);
 		if (overlap(base, end, ap->base, ap->base + ap->size)) {
@@ -377,3 +383,26 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 
 }
 EXPORT_SYMBOL(aperture_remove_conflicting_pci_devices);
+
+/**
+ * aperture_contain_firmware_fb - Detect if the firmware framebuffer belong to
+ *                                a aperture.
+ * @ap_start: the aperture's start address in physical memory
+ * @ap_end: the aperture's end address in physical memory
+ *
+ * Returns:
+ * true on if there is a firmware framebuffer belong to the aperture passed in,
+ * or false otherwise.
+ */
+bool aperture_contain_firmware_fb(resource_size_t ap_start, resource_size_t ap_end)
+{
+	/* No firmware framebuffer support */
+	if (!firm_fb_start || !firm_fb_end)
+		return false;
+
+	if (firm_fb_start >= ap_start && firm_fb_end <= ap_end)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL(aperture_contain_firmware_fb);
diff --git a/include/drm/drm_aperture.h b/include/drm/drm_aperture.h
index cbe33b49fd5d..6a0b9bacb081 100644
--- a/include/drm/drm_aperture.h
+++ b/include/drm/drm_aperture.h
@@ -35,4 +35,6 @@ drm_aperture_remove_framebuffers(const struct drm_driver *req_driver)
 							    req_driver);
 }
 
+bool drm_aperture_contain_firmware_fb(resource_size_t base, resource_size_t size);
+
 #endif
diff --git a/include/linux/aperture.h b/include/linux/aperture.h
index 1a9a88b11584..d4dc5917c49b 100644
--- a/include/linux/aperture.h
+++ b/include/linux/aperture.h
@@ -19,6 +19,8 @@ int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t si
 int __aperture_remove_legacy_vga_devices(struct pci_dev *pdev);
 
 int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *name);
+
+bool aperture_contain_firmware_fb(resource_size_t ap_start, resource_size_t ap_end);
 #else
 static inline int devm_aperture_acquire_for_platform_device(struct platform_device *pdev,
 							    resource_size_t base,
@@ -42,6 +44,11 @@ static inline int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev,
 {
 	return 0;
 }
+
+static inline bool aperture_contain_firmware_fb(resource_size_t ap_start, resource_size_t ap_end)
+{
+	return false;
+}
 #endif
 
 /**
-- 
2.25.1

