Return-Path: <linux-pci+bounces-5170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E701388BFE2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 11:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE2D294FBB
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F35F54735;
	Tue, 26 Mar 2024 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtE7Jz7X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42BDF49
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450151; cv=none; b=hcAS/heIDBTh/hm7vVYBBZcsn+YrJmS516cDy9pZLzHxm+FDhjoFKsOd//Dvuaz1ZuCcrg+09XAX/CodcnweDQROJtMeffP7KuuUaGaTF2Bapw7vbFxMcbHVJW8uKvLo5SEqc4LMv31IT3izl+7TJFMkrby6knrM+cR0TockmkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450151; c=relaxed/simple;
	bh=bF/HcvO7foa6FK6PVUQ7xHq4JKqGIBDDGhSwfre7E3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5hFF5rHMJJrchMOyC/CP7Y71dSuPR/DaW9C3A12tnYIavqXU1/jqONQPYfJnUb6WELW4dYi/egRALXtKyh/+wrRHH1M69S4Rqy/oAFdcUAe+eav8ffRQWRZuoGwJ7Qhfa4UVLAFAb6kmP1UNitFo9lrl+XffrUEX4Yy68/fv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dtE7Jz7X; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2523365a12.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 03:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711450148; x=1712054948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+4mr/LaSu8VrSg/TvK0Tq+DsBpYP0fJ/Xusk8aMb0Y=;
        b=dtE7Jz7X06rlmocHqnJUvUC9k9kfJZpb0bnRdfRuT1089WL6c49pk+uQiL8DHKK8Po
         Sau8D/9W784UiBOzcb/l/RIhu0LLpjgEiX0EREE4gbbMtb2p/4teW7yBMeeMHxDz6tyu
         dKkRSpYmGXvj3dxIeJu0PQ2SclU8uqsTqh6DiO0Y4wnnJD6TdOsQlNsn+9bGFbBIrPo6
         HQCLiK2CGNUR1Z5Xg2U1i2tM9NEjivBfbGIWGunvvHIBW9NF+gJjXz63+77JNuppeHZO
         H0iuMySTwO8DlZ00aEKzePoLgvg6eExYbTOEw8oHAMca50tmFFm+XtpaXAOLCD+zVmQE
         clSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711450148; x=1712054948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+4mr/LaSu8VrSg/TvK0Tq+DsBpYP0fJ/Xusk8aMb0Y=;
        b=WLQHIAE9GEYKkxcJJFTtSSkQOyJyKKSN0bk8FiqgapfEOzkwhJPYY2aeD7PjTahmsy
         AjNGcVatGG9YcEQRI4EMo47R6/wGyKAWXFS6nq4VdWNq4zTgDatGTtGPMVOXNNrtiXId
         ulVX3CMeaDdZxKhqFDso00kKkIgMs12wV3wA2nc2SEEJDPPnZvU5USP6ol/tghPudI7z
         DtuD5iTYq2yQG9S5ZvU2m8sBDUOcuco2mckSVOIV4UlmTsoG5X3EVSqxpXyYy1lIu52V
         eMfADMpYIWpSy5sjPQYGbA4y7chfMOm1ScB2+BmKF7QwFpN6ZaA/sbk8pBQ3JDmPxzyE
         PKiw==
X-Gm-Message-State: AOJu0Yzyp0LeSe3bLfBGHu0NwwXQs+UKSHujNkGgQdBdI8CXkEMyTEC4
	RYy4KvVIEIeDCDuMjTGQmeFZmLr4HG+fQyXyv5SaKJf5YXJN3K4Fipf+buaAaQ==
X-Google-Smtp-Source: AGHT+IGFgqH9fW74hni3EIrs9KNn0YtpEuU8cHXDKX0Z6LTgKUu33Et6V4oRxLUUlNpE9+VZBH2Pow==
X-Received: by 2002:a17:90a:bd81:b0:29c:1eb6:7347 with SMTP id z1-20020a17090abd8100b0029c1eb67347mr7269546pjr.6.1711450148467;
        Tue, 26 Mar 2024 03:49:08 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090a059600b0029fc196159bsm8777218pji.30.2024.03.26.03.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:49:08 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 26 Mar 2024 16:18:19 +0530
Subject: [PATCH v4 3/4] PCI: Decouple D3Hot and D3Cold handling for bridges
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-pci-bridge-d3-v4-3-f1dce1d1f648@linaro.org>
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
In-Reply-To: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, lukas@wunner.de, 
 mika.westerberg@linux.intel.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=14019;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=bF/HcvO7foa6FK6PVUQ7xHq4JKqGIBDDGhSwfre7E3U=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmAqgVDUDmtlSozShEyuB/I4ssS2mtzag9TSu7v
 G4Kav+rIDCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgKoFQAKCRBVnxHm/pHO
 9dA0CACPRcceG6iLUeio+34GVIDQMtnyuY8aRYhlHS3tfAE/ra1oh8Ieeeq48378KPDVrUSbVHS
 4eJxeG2tDt7HKGe/dSOfstXYJGzrF0pM8EeSS8lXztccZVE7jWSaGcc+jCTf8mYcIyTgrV4CMHM
 kXLfnkiLS4lzInB68odhwu3hlP788/KDn90RuJmwkMmM4wcAz3GaTAok8rCjb6fdF/jCa6y+D6i
 085iATZHjLjDneCbj86IJy/wYxikrx6aHGBWfF5Y5dn12L/uzVuVl7rRyaPyFCAZs2TVWfj0VwO
 m1jjXFXfvwa1LHrZvonFhMYnYjye/yTCMsaflbEp/yf0DtbE
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Currently, there is no proper distinction between D3Hot and D3Cold while
handling the power management for PCI bridges. For instance,
pci_bridge_d3_allowed() API decides whether it is allowed to put the
bridge in D3, but it doesn't explicitly specify whether D3Hot or D3Cold
is allowed in a scenario. This often leads to confusion and may be prone
to errors.

So let's split the D3Hot and D3Cold handling where possible. The current
pci_bridge_d3_allowed() API is now split into pci_bridge_d3hot_allowed()
and pci_bridge_d3cold_allowed() APIs and used in relevant places.

Also, pci_bridge_d3_update() API is now renamed to
pci_bridge_d3cold_update() since it was only used to check the possibility
of D3Cold.

Note that it is assumed that only D3Hot needs to be checked while
transitioning the bridge during runtime PM and D3Cold in other places. In
the ACPI case, wakeup is now only enabled if both D3Hot and D3Cold are
allowed for the bridge.

Still, there are places where just 'd3' is used opaquely, but those are
hard to distinguish, hence left for future cleanups.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c          |  2 +-
 drivers/pci/pci-acpi.c     |  5 +--
 drivers/pci/pci-sysfs.c    |  2 +-
 drivers/pci/pci.c          | 78 ++++++++++++++++++++++++++++++----------------
 drivers/pci/pci.h          | 12 ++++---
 drivers/pci/pcie/portdrv.c | 16 +++++-----
 drivers/pci/remove.c       |  2 +-
 include/linux/pci.h        |  3 +-
 8 files changed, 75 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..cb1a1aaefa90 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -346,7 +346,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 		of_pci_make_dev_node(dev);
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
-	pci_bridge_d3_update(dev);
+	pci_bridge_d3cold_update(dev);
 
 	dev->match_driver = !dn || of_device_is_available(dn);
 	retval = device_attach(&dev->dev);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0f260cdc4592..aaf5a68e7984 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1434,7 +1434,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 	 * reason is that the bridge may have additional methods such as
 	 * _DSW that need to be called.
 	 */
-	if (pci_dev->bridge_d3_allowed)
+	if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)
 		device_wakeup_enable(dev);
 
 	acpi_pci_wakeup(pci_dev, false);
@@ -1452,7 +1452,8 @@ void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev)
 	pci_acpi_remove_pm_notifier(adev);
 	if (adev->wakeup.flags.valid) {
 		acpi_device_power_remove_dependent(adev, dev);
-		if (pci_dev->bridge_d3_allowed)
+		if (pci_dev->bridge_d3cold_allowed &&
+		    pci_dev->bridge_d3hot_allowed)
 			device_wakeup_disable(dev);
 
 		device_set_wakeup_capable(dev, false);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 40cfa716392f..45628b0dd116 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -529,7 +529,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 		return -EINVAL;
 
 	pdev->d3cold_allowed = !!val;
-	pci_bridge_d3_update(pdev);
+	pci_bridge_d3cold_update(pdev);
 
 	pm_runtime_resume(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0edc4e448c2d..48e2ca0cd8a0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -166,9 +166,9 @@ bool pci_ats_disabled(void)
 }
 EXPORT_SYMBOL_GPL(pci_ats_disabled);
 
-/* Disable bridge_d3 for all PCIe ports */
+/* Disable both D3Hot and D3Cold for all PCIe ports */
 static bool pci_bridge_d3_disable;
-/* Force bridge_d3 for all PCIe ports */
+/* Force both D3Hot and D3Cold for all PCIe ports */
 static bool pci_bridge_d3_force;
 
 static int __init pcie_port_pm_setup(char *str)
@@ -2966,14 +2966,11 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 	{ }
 };
 
-/**
- * pci_bridge_d3_allowed - Is it allowed to put the bridge into D3
- * @bridge: Bridge to check
- *
- * This function checks if the bridge is allowed to move to D3.
- * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
+/*
+ * Helper function to check whether it is allowed to put the bridge into D3
+ * states (D3Hot and D3Cold).
  */
-bool pci_bridge_d3_allowed(struct pci_dev *bridge)
+static bool pci_bridge_d3_allowed(struct pci_dev *bridge, pci_power_t state)
 {
 	if (!pci_is_pcie(bridge))
 		return false;
@@ -3026,6 +3023,32 @@ bool pci_bridge_d3_allowed(struct pci_dev *bridge)
 	return false;
 }
 
+/**
+ * pci_bridge_d3cold_allowed - Is it allowed to put the bridge into D3Cold
+ * @bridge: Bridge to check
+ *
+ * This function checks if the bridge is allowed to move to D3Cold.
+ * Currently we only allow D3Cold for recent enough PCIe ports on ACPI based
+ * platforms and Thunderbolt.
+ */
+bool pci_bridge_d3cold_allowed(struct pci_dev *bridge)
+{
+	return pci_bridge_d3_allowed(bridge, PCI_D3cold);
+}
+
+/**
+ * pci_bridge_d3cold_allowed - Is it allowed to put the bridge into D3Hot
+ * @bridge: Bridge to check
+ *
+ * This function checks if the bridge is allowed to move to D3Hot.
+ * Currently we only allow D3Hot for recent enough PCIe ports on ACPI based
+ * platforms and Thunderbolt.
+ */
+bool pci_bridge_d3hot_allowed(struct pci_dev *bridge)
+{
+	return pci_bridge_d3_allowed(bridge, PCI_D3hot);
+}
+
 static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 {
 	bool *d3cold_ok = data;
@@ -3046,55 +3069,55 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 }
 
 /*
- * pci_bridge_d3_update - Update bridge D3 capabilities
+ * pci_bridge_d3cold_update - Update bridge D3Cold capabilities
  * @dev: PCI device which is changed
  *
  * Update upstream bridge PM capabilities accordingly depending on if the
  * device PM configuration was changed or the device is being removed.  The
  * change is also propagated upstream.
  */
-void pci_bridge_d3_update(struct pci_dev *dev)
+void pci_bridge_d3cold_update(struct pci_dev *dev)
 {
 	bool remove = !device_is_registered(&dev->dev);
 	struct pci_dev *bridge;
 	bool d3cold_ok = true;
 
 	bridge = pci_upstream_bridge(dev);
-	if (!bridge || !pci_bridge_d3_allowed(bridge))
+	if (!bridge || !pci_bridge_d3cold_allowed(bridge))
 		return;
 
 	/*
-	 * If D3 is currently allowed for the bridge, removing one of its
+	 * If D3Cold is currently allowed for the bridge, removing one of its
 	 * children won't change that.
 	 */
-	if (remove && bridge->bridge_d3_allowed)
+	if (remove && bridge->bridge_d3cold_allowed)
 		return;
 
 	/*
-	 * If D3 is currently allowed for the bridge and a child is added or
-	 * changed, disallowance of D3 can only be caused by that child, so
+	 * If D3Cold is currently allowed for the bridge and a child is added or
+	 * changed, disallowance of D3Cold can only be caused by that child, so
 	 * we only need to check that single device, not any of its siblings.
 	 *
-	 * If D3 is currently not allowed for the bridge, checking the device
-	 * first may allow us to skip checking its siblings.
+	 * If D3Cold is currently not allowed for the bridge, checking the
+	 * device first may allow us to skip checking its siblings.
 	 */
 	if (!remove)
 		pci_dev_check_d3cold(dev, &d3cold_ok);
 
 	/*
-	 * If D3 is currently not allowed for the bridge, this may be caused
+	 * If D3Cold is currently not allowed for the bridge, this may be caused
 	 * either by the device being changed/removed or any of its siblings,
 	 * so we need to go through all children to find out if one of them
-	 * continues to block D3.
+	 * continues to block D3Cold.
 	 */
-	if (d3cold_ok && !bridge->bridge_d3_allowed)
+	if (d3cold_ok && !bridge->bridge_d3cold_allowed)
 		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
 			     &d3cold_ok);
 
-	if (bridge->bridge_d3_allowed != d3cold_ok) {
-		bridge->bridge_d3_allowed = d3cold_ok;
+	if (bridge->bridge_d3cold_allowed != d3cold_ok) {
+		bridge->bridge_d3cold_allowed = d3cold_ok;
 		/* Propagate change to upstream bridges */
-		pci_bridge_d3_update(bridge);
+		pci_bridge_d3cold_update(bridge);
 	}
 }
 
@@ -3110,7 +3133,7 @@ void pci_d3cold_enable(struct pci_dev *dev)
 {
 	if (dev->no_d3cold) {
 		dev->no_d3cold = false;
-		pci_bridge_d3_update(dev);
+		pci_bridge_d3cold_update(dev);
 	}
 }
 EXPORT_SYMBOL_GPL(pci_d3cold_enable);
@@ -3127,7 +3150,7 @@ void pci_d3cold_disable(struct pci_dev *dev)
 {
 	if (!dev->no_d3cold) {
 		dev->no_d3cold = true;
-		pci_bridge_d3_update(dev);
+		pci_bridge_d3cold_update(dev);
 	}
 }
 EXPORT_SYMBOL_GPL(pci_d3cold_disable);
@@ -3167,7 +3190,8 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->pm_cap = pm;
 	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
-	dev->bridge_d3_allowed = pci_bridge_d3_allowed(dev);
+	dev->bridge_d3cold_allowed = pci_bridge_d3cold_allowed(dev);
+	dev->bridge_d3hot_allowed = pci_bridge_d3hot_allowed(dev);
 	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 53ca75639201..f819eab793fc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -92,8 +92,9 @@ void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
-bool pci_bridge_d3_allowed(struct pci_dev *dev);
-void pci_bridge_d3_update(struct pci_dev *dev);
+bool pci_bridge_d3cold_allowed(struct pci_dev *dev);
+bool pci_bridge_d3hot_allowed(struct pci_dev *dev);
+void pci_bridge_d3cold_update(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
@@ -111,9 +112,12 @@ static inline bool pci_power_manageable(struct pci_dev *pci_dev)
 {
 	/*
 	 * Currently we allow normal PCI devices and PCI bridges transition
-	 * into D3 if their bridge_d3 is set.
+	 * into D3 states if both bridge_d3cold_allowed and bridge_d3hot_allowed
+	 * are set.
 	 */
-	return !pci_has_subordinate(pci_dev) || pci_dev->bridge_d3_allowed;
+	return !pci_has_subordinate(pci_dev) ||
+	       (pci_dev->bridge_d3cold_allowed &&
+		pci_dev->bridge_d3hot_allowed);
 }
 
 static inline bool pcie_downstream_port(const struct pci_dev *dev)
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 8401a0f7b394..655754b9f06a 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -632,7 +632,7 @@ __setup("pcie_ports=", pcie_port_setup);
 #ifdef CONFIG_PM
 static int pcie_port_runtime_suspend(struct device *dev)
 {
-	if (!to_pci_dev(dev)->bridge_d3_allowed)
+	if (!to_pci_dev(dev)->bridge_d3hot_allowed)
 		return -EBUSY;
 
 	return pcie_port_device_runtime_suspend(dev);
@@ -641,11 +641,11 @@ static int pcie_port_runtime_suspend(struct device *dev)
 static int pcie_port_runtime_idle(struct device *dev)
 {
 	/*
-	 * Assume the PCI core has set bridge_d3_allowed whenever it thinks the
-	 * port should be good to go to D3.  Everything else, including moving
-	 * the port to D3, is handled by the PCI core.
+	 * Assume the PCI core has set bridge_d3hot_allowed whenever it thinks
+	 * the port should be good to go to D3Hot.  Everything else, including
+	 * moving the port to D3Hot, is handled by the PCI core.
 	 */
-	return to_pci_dev(dev)->bridge_d3_allowed ? 0 : -EBUSY;
+	return to_pci_dev(dev)->bridge_d3hot_allowed ? 0 : -EBUSY;
 }
 
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
@@ -702,7 +702,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
 					   DPM_FLAG_SMART_SUSPEND);
 
-	if (dev->bridge_d3_allowed) {
+	if (dev->bridge_d3hot_allowed) {
 		/*
 		 * Keep the port resumed 100ms to make sure things like
 		 * config space accesses from userspace (lspci) will not
@@ -720,7 +720,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
-	if (dev->bridge_d3_allowed) {
+	if (dev->bridge_d3hot_allowed) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
@@ -733,7 +733,7 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 
 static void pcie_portdrv_shutdown(struct pci_dev *dev)
 {
-	if (dev->bridge_d3_allowed) {
+	if (dev->bridge_d3hot_allowed) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..36d8cb50b582 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -41,7 +41,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 
 	pci_doe_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
-	pci_bridge_d3_update(dev);
+	pci_bridge_d3cold_update(dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2a48c88512e1..d0947f932b9a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -375,7 +375,8 @@ struct pci_dev {
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
-	unsigned int	bridge_d3_allowed:1;	/* Allow D3 for bridge */
+	unsigned int	bridge_d3cold_allowed:1;	/* Allow D3Cold for bridge */
+	unsigned int	bridge_d3hot_allowed:1;		/* Allow D3Hot for bridge */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */

-- 
2.25.1


