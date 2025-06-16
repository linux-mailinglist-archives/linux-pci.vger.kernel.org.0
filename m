Return-Path: <linux-pci+bounces-29831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2848ADA7B1
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 07:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AE63A0516
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 05:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD21518E025;
	Mon, 16 Jun 2025 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8Su7j7W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429622083;
	Mon, 16 Jun 2025 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750051977; cv=none; b=cYSj81Z6geMH475I5mHYccawe8W1CYNQMt8NAMu+dtpuopzuoDwbtXdP96Q47/iA0zylEdGERwFYla2XjBrr9EXPnZmusly4dxPLC9GXAbZe1nLbgU0/lvBakDvRHGxOeQKXvj4ld9vITBfrgx++T099AdshlUFyLT5oAi5vUps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750051977; c=relaxed/simple;
	bh=kyxmwQC0zJdtJlwb6BnaNS54FyumhmR5nLzZnLljSqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FlgNxi1AbBCZmCijWHAbY37mHbRHoV4dD1NnNS2JsPiyU5mij0KTEcGoWP/cLlhD758/0Eif4bSyNdCqSnMbtuxH0stQOm78ShwH7GiB7GfS8fag+g8Grf1i7W2TLi1yVJKVoOfLYcCllTCuuQ97hEQGRTV/NxaEDyJJw+ocvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8Su7j7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7C8C4CEEA;
	Mon, 16 Jun 2025 05:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750051977;
	bh=kyxmwQC0zJdtJlwb6BnaNS54FyumhmR5nLzZnLljSqk=;
	h=From:To:Cc:Subject:Date:From;
	b=s8Su7j7WtgWVvYVWf+e/pxuIzw4CQCvX3s5gaSx31rmGjNHVY2zT2tkIBNNFCuuP8
	 /tRJcWuodd6bxgkmek4ptFpAiXEiadx41b6dj3TsdRurufh+BrshfXTeTMEWORHKJ7
	 ekmE/8qwMHxca8taIcZQwq9bQNSafhWtMPKOjblfEFNUlDR1qCaZDUyUpZ8cQwTryj
	 mFzORTet/2BaGTA5BwjRM5+yH80990bSh00+61t6lc2if5b35776qEVAuSjpd/tJ3B
	 jGVnuFXVNBJG7/gVTs7IOphmh46Y34OORGT/rPAMOvCSA2JNktMAra1/73OQTVMdBD
	 8d99G4f4GEn9g==
From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com,
	brgl@bgdev.pl
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device() definition to drivers/pci/pwrctrl/
Date: Mon, 16 Jun 2025 11:02:09 +0530
Message-ID: <20250616053209.13045-1-mani@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_pwrctrl_create_device() is a PWRCTRL framework API. So it should be
built only when CONFIG_PWRCTRL is enabled. Currently, it is built
independently of CONFIG_PWRCTRL. This creates enumeration failure on
platforms like brcmstb using out-of-tree devicetree that describes the
power supplies for endpoints in the PCIe child node, but doesn't use
PWRCTRL framework to manage the supplies. The controller driver itself
manages the supplies.

But in any case, the API should be built only when CONFIG_PWRCTRL is
enabled. So move its definition to drivers/pci/pwrctrl/core.c and provide
a stub in drivers/pci/pci.h when CONFIG_PWRCTRL is not enabled. This also
fixes the enumeration issues on the affected platforms.

Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
Closes: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---

Changes in v3:

* Used IS_ENABLED instead of ifdef in drivers/pci/pci.h (Sathyanarayanan)

Changes in v2:

* Dropped the unused headers from probe.c (Lukas)

 drivers/pci/pci.h          |  8 ++++++++
 drivers/pci/probe.c        | 32 --------------------------------
 drivers/pci/pwrctrl/core.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..22df9e2bfda6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1159,4 +1159,12 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
 	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
 	 PCI_CONF1_EXT_REG(reg))
 
+#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
+struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus,
+						  int devfn);
+#else
+static inline struct platform_device *
+pci_pwrctrl_create_device(struct pci_bus *bus, int devfn) { return NULL; }
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..478e217928a6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -9,8 +9,6 @@
 #include <linux/pci.h>
 #include <linux/msi.h>
 #include <linux/of_pci.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
 #include <linux/pci_hotplug.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -2508,36 +2506,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
-static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
-{
-	struct pci_host_bridge *host = pci_find_host_bridge(bus);
-	struct platform_device *pdev;
-	struct device_node *np;
-
-	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
-	if (!np || of_find_device_by_node(np))
-		return NULL;
-
-	/*
-	 * First check whether the pwrctrl device really needs to be created or
-	 * not. This is decided based on at least one of the power supplies
-	 * being defined in the devicetree node of the device.
-	 */
-	if (!of_pci_supply_present(np)) {
-		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
-		return NULL;
-	}
-
-	/* Now create the pwrctrl device */
-	pdev = of_platform_device_create(np, NULL, &host->dev);
-	if (!pdev) {
-		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
-		return NULL;
-	}
-
-	return pdev;
-}
-
 /*
  * Read the config data for a PCI device, sanity-check it,
  * and fill in the dev structure.
diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 6bdbfed584d6..20585b2c3681 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -6,11 +6,47 @@
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/pci-pwrctrl.h>
+#include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
+#include "../pci.h"
+
+struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(bus);
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
+	if (!np || of_find_device_by_node(np))
+		return NULL;
+
+	/*
+	 * First check whether the pwrctrl device really needs to be created or
+	 * not. This is decided based on at least one of the power supplies
+	 * being defined in the devicetree node of the device.
+	 */
+	if (!of_pci_supply_present(np)) {
+		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
+		return NULL;
+	}
+
+	/* Now create the pwrctrl device */
+	pdev = of_platform_device_create(np, NULL, &host->dev);
+	if (!pdev) {
+		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
+		return NULL;
+	}
+
+	return pdev;
+}
+
 static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 			      void *data)
 {
-- 
2.43.0


