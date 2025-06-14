Return-Path: <linux-pci+bounces-29806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46882AD9A3B
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 07:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F8E17FB81
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 05:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A21C84D2;
	Sat, 14 Jun 2025 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB5kLAzf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A82E11DB;
	Sat, 14 Jun 2025 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749878828; cv=none; b=s4hgo/3tBLdHxi8YGi/5ny3LXrN3yxND9sf+B2DzdZ5zLljdML56BpiMFAY//eVSYMV4EEWaXbLJAyUrXooV28JksN83CbPJmIBCS+RAaeuWLMenGaL4idVR1k1u2gCusOR3Rh+BrPUNn9SXT/n5cU5zrM/y2GR/GfdaBkxYN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749878828; c=relaxed/simple;
	bh=KQ9gl4HHifEzzybP2sXHvFgn2l0SIZZLHOuI9RstanI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qoSDfLAHmgAyraFUhG3ydJdNVFQqBgNa71GR3qqUn2+iLWriaX/J1yqjUA0R/rgZcmMtU2y1cdr+nqvOfmR48A+Iq3UlDia/o00o8WWwnqkwytKmJql3w8xVYdi8fXja/eo/v4Yf9p/p4kRVuC9CZ7GbNYn8BF6j7CRrQLLAYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB5kLAzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B93C4CEEB;
	Sat, 14 Jun 2025 05:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749878827;
	bh=KQ9gl4HHifEzzybP2sXHvFgn2l0SIZZLHOuI9RstanI=;
	h=From:To:Cc:Subject:Date:From;
	b=MB5kLAzf5fDoNGCppBMEslgoKWLN8W46lEHTL4vKSnCIhCBSVmyXGs870X2kGMfDZ
	 9UGuHH6gLOTTAHS3qburFLwjR6mo55LccRroAPKqHSwSADvemPfJdVyINqtxoKU0Kp
	 IIjW2Vapq3+eEejK0U1JokVxOgOoOUs3Q7mD1uu7KrV7S1tx4qROmNeyly1qN+0qxq
	 jgFOuQ0sQx9vW5YobQXexDgZjqUCpRUyKkaD5YEMo1xQRefAtWJF2O9L1DwEJWO+mX
	 +KKJrGDoPIkkl4GMcDxyu1uaTD8bpdNj1SSXwGCX57RE0x6lX2s0R/7LrbPX1T+M70
	 DqLRI0YSx9lfg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com,
	brgl@bgdev.pl
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] PCI/pwrctrl: Move pci_pwrctrl_create_device() definition to drivers/pci/pwrctrl/
Date: Sat, 14 Jun 2025 10:56:51 +0530
Message-ID: <20250614052651.15055-1-mani@kernel.org>
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
 drivers/pci/pci.h          |  8 ++++++++
 drivers/pci/probe.c        | 30 ------------------------------
 drivers/pci/pwrctrl/core.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..c5efd8b9c96a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1159,4 +1159,12 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
 	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
 	 PCI_CONF1_EXT_REG(reg))
 
+#ifdef CONFIG_PCI_PWRCTRL
+struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus,
+						  int devfn);
+#else
+static inline struct platform_device *
+pci_pwrctrl_create_device(struct pci_bus *bus, int devfn) { return NULL; }
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..d857e21d6911 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2508,36 +2508,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
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


