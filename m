Return-Path: <linux-pci+bounces-19110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3909FEE73
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 10:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A89C3A2B64
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88330193084;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUbfyxUA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980913B7AE;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735638254; cv=none; b=LAGsFR1QaRKXRVp/1KFlxR3IcxcGFL40IXlecH85FGWTIi4xwHuJv1C2Tt3mn6D/QtSeLe9VbUSPe25a8nu5LMiqzKtJn2/u4zF7ezDJpiEQlQeltfft7sKMgHXm2BlSTtqpGspqf0f+e6PMuey8VvhO0g7F9OCdZFfFK5I4JGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735638254; c=relaxed/simple;
	bh=WIQv3KD1TnKJ1FeAsp5Ms4Qm3siNonfJRB+TKoH/FEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVMcANEOGzC/WyDmESGKkzPDxxHw1iGlQjwNqWL0Ov5XpPBvxunKGxAHgfwqkeR3uywz/lSwSL7XYdtWweTr1ecHh5pDmitpNZp9xSgEQZvFZ6YomXDawIOcTyrVmZKm26451/upgP0ADd+bao3VZLjXyoYu1xA8MJB+tkTaHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUbfyxUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE1E2C4CEDC;
	Tue, 31 Dec 2024 09:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735638254;
	bh=WIQv3KD1TnKJ1FeAsp5Ms4Qm3siNonfJRB+TKoH/FEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dUbfyxUA+NglW7iGzI8XkC+z8l6lULCZnKa8ertvZwmeN9oT80i9MfvxgXF4xgFK5
	 pHO97di83BhHWpLSo67xIW7L7I/WAG3ITI2bHNa0NBQ5fGa4aobUocLNeSJR0Mtqiq
	 m4kLfyzSQRoBkqtUMk35omqk/2iJ+RRU/fnOFSh/eBASnKIOmftdsqyfHnqDuITJ50
	 7JPd4yoouD7VYOzMoMlsavdIcfmVjnhB4resKU/tpEZvlmtRvadgrkzsv9yaNOSC7r
	 a5bdx8YjdS5V4OhFptO8kgvoX0K5qVb5D72Dy6i62ZKVBzHMecbN1Nrlo/yX2xk8wm
	 YW6ZQ/1RLgvkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2D7E77197;
	Tue, 31 Dec 2024 09:44:13 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 31 Dec 2024 15:13:43 +0530
Subject: [PATCH v2 2/6] PCI/pwrctrl: Move creation of pwrctrl devices to
 pci_scan_device()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241231-pci-pwrctrl-slot-v2-2-6a15088ba541@linaro.org>
References: <20241231-pci-pwrctrl-slot-v2-0-6a15088ba541@linaro.org>
In-Reply-To: <20241231-pci-pwrctrl-slot-v2-0-6a15088ba541@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Qiang Yu <quic_qianyu@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukas Wunner <lukas@wunner.de>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5697;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=xIyJbEnDR6J92iNeHDHLDUlZlBfz305fAs7wXMTBhwA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnc7zqGVqYCh9zKJ8rTHRjIBT+/jHKlwSn7ef3r
 Kv6bAH2d8CJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ3O86gAKCRBVnxHm/pHO
 9UT0CACfn6kB5rPiWJ/jqdgHu1VMtAl/CKZg5GnkOq89WvfjVpOKJXZmM7AbUsGAvG3BXH9tCQP
 Em5ugKdexFWq/pogVtDpTeFaJkAx86m/cZm1srlA2StMancVgsi+xD5iomWwxhFbY5LsGs8YrBA
 RhptUPi3ZA6QglfCRj/xiz3mFbyHvW9ePk+5oabdhWEyjVbkgGwPlfgx156sENXtzPT7gI+NqwW
 nYE8fmCn8UO1iuaOXIlKbiItWZhI2poz/X+pfKH1po1/Boh/eHdWX5/dHzWu7g5W6QVjWUCh/Rr
 QnlLGBJSXtoSeukh4iUPSQ17JuVDuSf68OS83ow8Z6AVjecF
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Current way of creating pwrctrl devices requires iterating through the
child devicetree nodes of the PCI bridge in pci_pwrctrl_create_devices().
Even though it works, it creates confusion as there is no symmetry between
this and pci_pwrctrl_unregister() function that removes the pwrctrl
devices.

So to make these two functions symmetric, move the creation of pwrctrl
devices to pci_scan_device(). During the scan of each device in a slot,
the devicetree node (if exists) for the PCI device will be checked. If it
has the supplies populated, then the pwrctrl device will be created.

Since the PCI device scan happens so early, there would be no 'struct
pci_dev' available for the device. So the host bridge is used as the parent
of all pwrctrl devices.

One nice side effect of this move is that, it is now possible to have
pwrctrl devices for PCI bridges as well (to control the supplies of PCI
slots).

Suggested-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c          | 43 -------------------------------------------
 drivers/pci/probe.c        | 34 ++++++++++++++++++++++++++++++++++
 drivers/pci/pwrctrl/core.c |  2 +-
 3 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 98910bc0fcc4..b6851101ac36 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -331,47 +331,6 @@ void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
 
 void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
 
-/*
- * Create pwrctrl devices (if required) for the PCI devices to handle the power
- * state.
- */
-static void pci_pwrctrl_create_devices(struct pci_dev *dev)
-{
-	struct device_node *np = dev_of_node(&dev->dev);
-	struct device *parent = &dev->dev;
-	struct platform_device *pdev;
-
-	/*
-	 * First ensure that we are starting from a PCI bridge and it has a
-	 * corresponding devicetree node.
-	 */
-	if (np && pci_is_bridge(dev)) {
-		/*
-		 * Now look for the child PCI device nodes and create pwrctrl
-		 * devices for them. The pwrctrl device drivers will manage the
-		 * power state of the devices.
-		 */
-		for_each_available_child_of_node_scoped(np, child) {
-			/*
-			 * First check whether the pwrctrl device really
-			 * needs to be created or not. This is decided
-			 * based on at least one of the power supplies
-			 * being defined in the devicetree node of the
-			 * device.
-			 */
-			if (!of_pci_supply_present(child)) {
-				pci_dbg(dev, "skipping OF node: %s\n", child->name);
-				return;
-			}
-
-			/* Now create the pwrctrl device */
-			pdev = of_platform_device_create(child, NULL, parent);
-			if (!pdev)
-				pci_err(dev, "failed to create OF node: %s\n", child->name);
-		}
-	}
-}
-
 /**
  * pci_bus_add_device - start driver for a single device
  * @dev: device to add
@@ -396,8 +355,6 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
 
-	pci_pwrctrl_create_devices(dev);
-
 	/*
 	 * If the PCI device is associated with a pwrctrl device with a
 	 * power supply, create a device link between the PCI device and
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2e81ab0f5a25..91bdb2727c8e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -9,6 +9,8 @@
 #include <linux/pci.h>
 #include <linux/msi.h>
 #include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pci_hotplug.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -2446,6 +2448,36 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
+/*
+ * Create pwrctrl device (if required) for the PCI device to handle the power
+ * state.
+ */
+static void pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(bus);
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
+	if (!np || of_find_device_by_node(np))
+		return;
+
+	/*
+	 * First check whether the pwrctrl device really needs to be created or
+	 * not. This is decided based on at least one of the power supplies
+	 * being defined in the devicetree node of the device.
+	 */
+	if (!of_pci_supply_present(np)) {
+		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
+		return;
+	}
+
+	/* Now create the pwrctrl device */
+	pdev = of_platform_device_create(np, NULL, &host->dev);
+	if (!pdev)
+		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for OF node: %s\n", np->name);
+}
+
 /*
  * Read the config data for a PCI device, sanity-check it,
  * and fill in the dev structure.
@@ -2455,6 +2487,8 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	struct pci_dev *dev;
 	u32 l;
 
+	pci_pwrctrl_create_device(bus, devfn);
+
 	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
 		return NULL;
 
diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 2fb174db91e5..9cc7e2b7f2b5 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -44,7 +44,7 @@ static void rescan_work_func(struct work_struct *work)
 						   struct pci_pwrctrl, work);
 
 	pci_lock_rescan_remove();
-	pci_rescan_bus(to_pci_dev(pwrctrl->dev->parent)->bus);
+	pci_rescan_bus(to_pci_host_bridge(pwrctrl->dev->parent)->bus);
 	pci_unlock_rescan_remove();
 }
 

-- 
2.25.1



