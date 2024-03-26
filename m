Return-Path: <linux-pci+bounces-5169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D388BFDE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 11:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8631F632EF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 10:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386979DF;
	Tue, 26 Mar 2024 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vymFVDka"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BB5C99
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450148; cv=none; b=gI+U3dPjeF/2FZ+1plvlkpTXd2St8VfSwfaOpOMha4iNZTtQuDP5nIbD3OAlFx8M2iMCmyfo8+Ei/vM+53UYuLTmjrvH6IhvE0lNnrxbvA9zGWdbNJkqt3aKdLHmHVUa2rCH5rnd6RaPlKqtw2Mf2MCee/MFSBnjLIGB8/4G+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450148; c=relaxed/simple;
	bh=2C+v6Wm3sjfQZlJTnA10pqcNYIb7iWI0WDKQl60uU8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YHQEh8/Eh+Za+j2e/At9sIZ2+GdUymob7iYUlTYAKL1fFfxQuILrTUZDYkuKQerh5CPN7mbyQdBxLYZKNRv8t+agHH+9CMl9o3WjMSfxY3y4MKPP21DGtk1j9A3l76Bu4Cy6oXsqc7Xcrs3DnCxgRWp5XwDVdeNJZdfXUIHaVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vymFVDka; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso3800011a12.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 03:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711450145; x=1712054945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0SMBhJid5kSy8nYHMJnAIAjjlVqaxbVM8G3mLgiceQ=;
        b=vymFVDkawMA31cBV5rEmOmgRs1NwMVdtPdU0ufsGnE0z5TEowtixUnfIA9Bo+FzHjU
         mslrROMng4wlwIUgsTjbNz/64CYMs33sDfFnY4OG+CDszQkQo6AT8YMfliPYipFBcO0H
         sO0/rcw8fG75LKkh1Gqxh4nR/UY2bQX1Hm6AMYQond5OCbXWOInG+vgsn+J/5tMYfwxE
         OB+2vGwfWhAPucmNC4qYmRYjY5lb6yyp/uoU8wY86ECuU6xjwtP4sbgfviZ2TSK5AM9C
         ER3NeYYPiZAM6ip4cbY7L1987UrqMrX5BKd/dR45K00iOQ4MNwyvZ8KCrHqRUY1WRKDW
         /prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711450145; x=1712054945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0SMBhJid5kSy8nYHMJnAIAjjlVqaxbVM8G3mLgiceQ=;
        b=PSiJMsINsUMV/UiMxCP8hgYpiXDMhMcn680AZwP3ncKZvzbl3oUPo6qmikKcfXrhFn
         UQU4sCnBMtP/I1WsFQOBEHbi18DToEsUkodQQ7FM98z82S6o+JDjE82x39UwjURmglvy
         yeweBpSlxbSNnZSZf+FVNAhlW5GQy3ogm9M1gJwPaC4OnhmHsBr+PUAMTk9nLgNkfMJw
         3AIDjSn/UaCY84mIWeNXD751l3BgU92VI/3hPVM7i8YP+LMSjimMU3Xs9pUTBZS8+Nvh
         Xl2MS2SpplP/DHR2MLYj/EUrf6mOYidXTikvq0EOmvx8VOU3dIvrksPRMjUmednNSE5f
         3kAA==
X-Gm-Message-State: AOJu0YxycprZ0nq1yuNkQJ8P8ZX2ZflYqi6qUdWcbvl4hTAuLYQGv0NJ
	y0n0hlRAkfEoHQKhN7ciLO9FCtn48nk4HZXozIG4CWiEk9zAZl34FhzJij7eVQ==
X-Google-Smtp-Source: AGHT+IHAftgjEZWHlDTh3ETzNXkoUDSq1fobXK/j1pHm/3OYwfeTvWUyP6CBV1UN3R769tCbCiu7WA==
X-Received: by 2002:a17:90a:d517:b0:29e:d30:5b2c with SMTP id t23-20020a17090ad51700b0029e0d305b2cmr8699221pju.18.1711450145228;
        Tue, 26 Mar 2024 03:49:05 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090a059600b0029fc196159bsm8777218pji.30.2024.03.26.03.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:49:04 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 26 Mar 2024 16:18:18 +0530
Subject: [PATCH v4 2/4] PCI: Rename pci_bridge_d3_possible() to
 pci_bridge_d3_allowed()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-pci-bridge-d3-v4-2-f1dce1d1f648@linaro.org>
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
In-Reply-To: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, lukas@wunner.de, 
 mika.westerberg@linux.intel.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8265;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=2C+v6Wm3sjfQZlJTnA10pqcNYIb7iWI0WDKQl60uU8A=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmAqgUPyirfQ7e4W3oQM7fjbqh0BJDFKv0WBsQT
 r6gQ6En/c+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgKoFAAKCRBVnxHm/pHO
 9dpFCACZIJLlmPE1Lh039AAQKRYeTV75R8+K1zgyIoFMW2CJXZY6/ZQjx4WWg9BEKW1PxAlCQfB
 Mb0G3Oi3zuT+1MzSq7kAoVWfpuNDt6Vp9oBZH5hXdD5VjbmGudBc+b4T1yE/0R1D/soN+lqoFFW
 EmZJZrsSjHdEWcz2GBOl7JVeDi8jkTA/7udDaQxtPx1XFYLnu5sHW761nhONEd3LGMT6vMVA8M+
 eEE0VFAcQYvLw5rGdiQKplXfMT+GmgOyc5fYgSNwOKvizysKBiSgYJHm+pxEJi30wuMwcopXLuN
 b1YIpO5DzTjPZiy+QAwK+kMOgrt0eLIwK1BPGatF20PhDtsq
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

As per the 'PCI Bus Power Management Interface Specification' v1.2, all
devices should support D3 states (both D3Hot and D3Cold). So the term
'possible' doesn't make sense for the bridge devices, since D3 states
should be possible as per the design. But due to various circumstances,
D3 states might not be allowed for the bridges.

In those cases, the API should be called 'pci_bridge_d3_allowed()' to
reflect the actual behavior. So let's rename it.

This also warrants renaming the variable 'bridge_d3' in 'struct pci_dev'
to 'bridge_d3_allowed' for the reason cited above.

No functional change.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20240305175107.GA539676@bhelgaas/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pci-acpi.c     |  8 ++++----
 drivers/pci/pci.c          | 18 +++++++++---------
 drivers/pci/pci.h          |  4 ++--
 drivers/pci/pcie/portdrv.c | 14 +++++++-------
 include/linux/pci.h        |  2 +-
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 004575091596..0f260cdc4592 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1429,12 +1429,12 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 
 	device_set_wakeup_capable(dev, true);
 	/*
-	 * For bridges that can do D3 we enable wake automatically (as
-	 * we do for the power management itself in that case). The
+	 * For bridges that are allowed to do D3, we enable wake automatically
+	 * (as we do for the power management itself in that case). The
 	 * reason is that the bridge may have additional methods such as
 	 * _DSW that need to be called.
 	 */
-	if (pci_dev->bridge_d3)
+	if (pci_dev->bridge_d3_allowed)
 		device_wakeup_enable(dev);
 
 	acpi_pci_wakeup(pci_dev, false);
@@ -1452,7 +1452,7 @@ void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev)
 	pci_acpi_remove_pm_notifier(adev);
 	if (adev->wakeup.flags.valid) {
 		acpi_device_power_remove_dependent(adev, dev);
-		if (pci_dev->bridge_d3)
+		if (pci_dev->bridge_d3_allowed)
 			device_wakeup_disable(dev);
 
 		device_set_wakeup_capable(dev, false);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..0edc4e448c2d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2967,13 +2967,13 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 };
 
 /**
- * pci_bridge_d3_possible - Is it possible to put the bridge into D3
+ * pci_bridge_d3_allowed - Is it allowed to put the bridge into D3
  * @bridge: Bridge to check
  *
- * This function checks if it is possible to move the bridge to D3.
+ * This function checks if the bridge is allowed to move to D3.
  * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
  */
-bool pci_bridge_d3_possible(struct pci_dev *bridge)
+bool pci_bridge_d3_allowed(struct pci_dev *bridge)
 {
 	if (!pci_is_pcie(bridge))
 		return false;
@@ -3060,14 +3060,14 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 	bool d3cold_ok = true;
 
 	bridge = pci_upstream_bridge(dev);
-	if (!bridge || !pci_bridge_d3_possible(bridge))
+	if (!bridge || !pci_bridge_d3_allowed(bridge))
 		return;
 
 	/*
 	 * If D3 is currently allowed for the bridge, removing one of its
 	 * children won't change that.
 	 */
-	if (remove && bridge->bridge_d3)
+	if (remove && bridge->bridge_d3_allowed)
 		return;
 
 	/*
@@ -3087,12 +3087,12 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 	 * so we need to go through all children to find out if one of them
 	 * continues to block D3.
 	 */
-	if (d3cold_ok && !bridge->bridge_d3)
+	if (d3cold_ok && !bridge->bridge_d3_allowed)
 		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
 			     &d3cold_ok);
 
-	if (bridge->bridge_d3 != d3cold_ok) {
-		bridge->bridge_d3 = d3cold_ok;
+	if (bridge->bridge_d3_allowed != d3cold_ok) {
+		bridge->bridge_d3_allowed = d3cold_ok;
 		/* Propagate change to upstream bridges */
 		pci_bridge_d3_update(bridge);
 	}
@@ -3167,7 +3167,7 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->pm_cap = pm;
 	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
-	dev->bridge_d3 = pci_bridge_d3_possible(dev);
+	dev->bridge_d3_allowed = pci_bridge_d3_allowed(dev);
 	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..53ca75639201 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -92,7 +92,7 @@ void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
-bool pci_bridge_d3_possible(struct pci_dev *dev);
+bool pci_bridge_d3_allowed(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
@@ -113,7 +113,7 @@ static inline bool pci_power_manageable(struct pci_dev *pci_dev)
 	 * Currently we allow normal PCI devices and PCI bridges transition
 	 * into D3 if their bridge_d3 is set.
 	 */
-	return !pci_has_subordinate(pci_dev) || pci_dev->bridge_d3;
+	return !pci_has_subordinate(pci_dev) || pci_dev->bridge_d3_allowed;
 }
 
 static inline bool pcie_downstream_port(const struct pci_dev *dev)
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 1f02e5d7b2e9..8401a0f7b394 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -632,7 +632,7 @@ __setup("pcie_ports=", pcie_port_setup);
 #ifdef CONFIG_PM
 static int pcie_port_runtime_suspend(struct device *dev)
 {
-	if (!to_pci_dev(dev)->bridge_d3)
+	if (!to_pci_dev(dev)->bridge_d3_allowed)
 		return -EBUSY;
 
 	return pcie_port_device_runtime_suspend(dev);
@@ -641,11 +641,11 @@ static int pcie_port_runtime_suspend(struct device *dev)
 static int pcie_port_runtime_idle(struct device *dev)
 {
 	/*
-	 * Assume the PCI core has set bridge_d3 whenever it thinks the port
-	 * should be good to go to D3.  Everything else, including moving
+	 * Assume the PCI core has set bridge_d3_allowed whenever it thinks the
+	 * port should be good to go to D3.  Everything else, including moving
 	 * the port to D3, is handled by the PCI core.
 	 */
-	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
+	return to_pci_dev(dev)->bridge_d3_allowed ? 0 : -EBUSY;
 }
 
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
@@ -702,7 +702,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
 					   DPM_FLAG_SMART_SUSPEND);
 
-	if (dev->bridge_d3) {
+	if (dev->bridge_d3_allowed) {
 		/*
 		 * Keep the port resumed 100ms to make sure things like
 		 * config space accesses from userspace (lspci) will not
@@ -720,7 +720,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
-	if (dev->bridge_d3) {
+	if (dev->bridge_d3_allowed) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
@@ -733,7 +733,7 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 
 static void pcie_portdrv_shutdown(struct pci_dev *dev)
 {
-	if (dev->bridge_d3) {
+	if (dev->bridge_d3_allowed) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..2a48c88512e1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -375,7 +375,7 @@ struct pci_dev {
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
-	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
+	unsigned int	bridge_d3_allowed:1;	/* Allow D3 for bridge */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */

-- 
2.25.1


