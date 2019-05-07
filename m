Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC5E616C03
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 22:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfEGUMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 16:12:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40867 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfEGUMy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 16:12:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so170409wmb.5
        for <linux-pci@vger.kernel.org>; Tue, 07 May 2019 13:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7vQgzwv4uXlKby5Paph4wAB3fX2oc2PrYOm1U17jks=;
        b=eR68EHYsMTJiiuqG25TiAedi3NPOZXyJ0NQ/syYTuFA7LuP9oxl1m0jBwZMi8UrBdI
         omU8EoUiMXtpT7ktt82/hS2iraZQ21359tfdEey0zWL8YaBrv4DJNMUC7HUVz8mwXIoU
         MhoHEeuePJnCVg+qsIDvhfe7jL8cRBYJSoExJZGLi7P5JPibt6XmrBFJo4/A1A8h5whp
         o7xX4I7IPJsGa8FSk3pWNTyD8pIgi6hSTD/acXpxzvmsLMaM+8jSv8HlOh4hrzAtzL23
         GGpiZehX683AIoOSKTxVi3qY7JYWm6p6Dr9s7vqawZXl9ipT3yT2SDqeQu682dtPQGJo
         2EdA==
X-Gm-Message-State: APjAAAVBHVnk7gKnzQRZJcLXQWL7iHvH/lqUiZqugeoD7SNTdFzkvxyH
        MUwPKxytAUQ1LOF3n0Tm+NlGjQ==
X-Google-Smtp-Source: APXvYqxTZrgYn7okJTfZqenmFLflUZFE0xEygyJX/FFiyeqoxsIYqRAvn9iCeKQ3gyTxcPKGb+EYsA==
X-Received: by 2002:a05:600c:2051:: with SMTP id p17mr133037wmg.125.1557259972238;
        Tue, 07 May 2019 13:12:52 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:ac7d:46be:871b:a956])
        by smtp.gmail.com with ESMTPSA id c10sm31816882wrd.69.2019.05.07.13.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 13:12:51 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Lyude Paul <lyude@redhat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v2 1/4] drm: don't set the pci power state if the pci subsystem handles the ACPI bits
Date:   Tue,  7 May 2019 22:12:42 +0200
Message-Id: <20190507201245.9295-2-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507201245.9295-1-kherbst@redhat.com>
References: <20190507201245.9295-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v2: rework detection of if Nouveau calling a DSM method or not

Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drm/nouveau/nouveau_acpi.c |  7 ++++++-
 drm/nouveau/nouveau_acpi.h |  2 ++
 drm/nouveau/nouveau_drm.c  | 14 +++++++++++---
 drm/nouveau/nouveau_drv.h  |  2 ++
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drm/nouveau/nouveau_acpi.c b/drm/nouveau/nouveau_acpi.c
index ffb19585..92dfc900 100644
--- a/drm/nouveau/nouveau_acpi.c
+++ b/drm/nouveau/nouveau_acpi.c
@@ -358,6 +358,12 @@ void nouveau_register_dsm_handler(void)
 	vga_switcheroo_register_handler(&nouveau_dsm_handler, 0);
 }
 
+bool nouveau_runpm_calls_dsm(void)
+{
+	return nouveau_dsm_priv.optimus_detected &&
+		!nouveau_dsm_priv.optimus_skip_dsm;
+}
+
 /* Must be called for Optimus models before the card can be turned off */
 void nouveau_switcheroo_optimus_dsm(void)
 {
@@ -371,7 +377,6 @@ void nouveau_switcheroo_optimus_dsm(void)
 
 	nouveau_optimus_dsm(nouveau_dsm_priv.dhandle, NOUVEAU_DSM_OPTIMUS_CAPS,
 		NOUVEAU_DSM_OPTIMUS_SET_POWERDOWN, &result);
-
 }
 
 void nouveau_unregister_dsm_handler(void)
diff --git a/drm/nouveau/nouveau_acpi.h b/drm/nouveau/nouveau_acpi.h
index b86294fc..0f5d7aa0 100644
--- a/drm/nouveau/nouveau_acpi.h
+++ b/drm/nouveau/nouveau_acpi.h
@@ -13,6 +13,7 @@ void nouveau_switcheroo_optimus_dsm(void);
 int nouveau_acpi_get_bios_chunk(uint8_t *bios, int offset, int len);
 bool nouveau_acpi_rom_supported(struct device *);
 void *nouveau_acpi_edid(struct drm_device *, struct drm_connector *);
+bool nouveau_runpm_calls_dsm(void);
 #else
 static inline bool nouveau_is_optimus(void) { return false; };
 static inline bool nouveau_is_v1_dsm(void) { return false; };
@@ -22,6 +23,7 @@ static inline void nouveau_switcheroo_optimus_dsm(void) {}
 static inline bool nouveau_acpi_rom_supported(struct device *dev) { return false; }
 static inline int nouveau_acpi_get_bios_chunk(uint8_t *bios, int offset, int len) { return -EINVAL; }
 static inline void *nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector) { return NULL; }
+static inline bool nouveau_runpm_calls_dsm(void) { return false; }
 #endif
 
 #endif
diff --git a/drm/nouveau/nouveau_drm.c b/drm/nouveau/nouveau_drm.c
index 5020265b..09e68e61 100644
--- a/drm/nouveau/nouveau_drm.c
+++ b/drm/nouveau/nouveau_drm.c
@@ -556,6 +556,7 @@ nouveau_drm_device_init(struct drm_device *dev)
 	nouveau_fbcon_init(dev);
 	nouveau_led_init(dev);
 
+	drm->runpm_dsm = nouveau_runpm_calls_dsm();
 	if (nouveau_pmops_runtime()) {
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
@@ -903,6 +904,7 @@ nouveau_pmops_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct nouveau_drm *drm = nouveau_drm(drm_dev);
 	int ret;
 
 	if (!nouveau_pmops_runtime()) {
@@ -910,12 +912,15 @@ nouveau_pmops_runtime_suspend(struct device *dev)
 		return -EBUSY;
 	}
 
+	drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 	nouveau_switcheroo_optimus_dsm();
 	ret = nouveau_do_suspend(drm_dev, true);
 	pci_save_state(pdev);
 	pci_disable_device(pdev);
 	pci_ignore_hotplug(pdev);
-	pci_set_power_state(pdev, PCI_D3cold);
+	if (drm->runpm_dsm)
+		pci_set_power_state(pdev, PCI_D3cold);
+
 	drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
 	return ret;
 }
@@ -925,7 +930,8 @@ nouveau_pmops_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct nvif_device *device = &nouveau_drm(drm_dev)->client.device;
+	struct nouveau_drm *drm = nouveau_drm(drm_dev);
+	struct nvif_device *device = &drm->client.device;
 	int ret;
 
 	if (!nouveau_pmops_runtime()) {
@@ -933,7 +939,9 @@ nouveau_pmops_runtime_resume(struct device *dev)
 		return -EBUSY;
 	}
 
-	pci_set_power_state(pdev, PCI_D0);
+	drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
+	if (drm->runpm_dsm)
+		pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	ret = pci_enable_device(pdev);
 	if (ret)
diff --git a/drm/nouveau/nouveau_drv.h b/drm/nouveau/nouveau_drv.h
index da847244..941600e9 100644
--- a/drm/nouveau/nouveau_drv.h
+++ b/drm/nouveau/nouveau_drv.h
@@ -214,6 +214,8 @@ struct nouveau_drm {
 	struct nouveau_svm *svm;
 
 	struct nouveau_dmem *dmem;
+
+	bool runpm_dsm;
 };
 
 static inline struct nouveau_drm *
-- 
2.21.0

