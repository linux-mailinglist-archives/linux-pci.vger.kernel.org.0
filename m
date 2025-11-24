Return-Path: <linux-pci+bounces-41960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83657C8188B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 17:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973B93A459B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0463168E0;
	Mon, 24 Nov 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soMAjU3U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD293164C7;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001265; cv=none; b=XD/LDwq8a2s2ICJ+V5NZmeSEwOCyF6kvowjV9kknD0ueFyEG93P9X261jbjqgWarhfoSuZjNDUnsXGqTdUQ9cm3SjAptJhJkzPqxIQlEl24YExemQrkCG1aTod6QaMAvTfhB0oaFmE3O+PdcQHgoxZtNsP8taQUGfil+4+PfQXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001265; c=relaxed/simple;
	bh=thA6EpEnjrSH7ZNxTMbFIvg+M/dmxUF6+YiplwO094U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5ipdSjf+Wq/rkRk1vLkFUu1xBCAEPZmMuqyWEWkqVbGQ7LoUmtQYHk22BnOOnjmCR9g3JbLF13A9ZQo4qOCYtr/On764rEfXnxjtxFO55LhvKTvgZt65nvD9/kJLOwFY8dKkEjiH7pW6Li8bFdQLTXGjsWdLUeXCo9QUyopWgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soMAjU3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CE58C2BCAF;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764001264;
	bh=thA6EpEnjrSH7ZNxTMbFIvg+M/dmxUF6+YiplwO094U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=soMAjU3U1wAY1x7SsJcEMrAUqf/1HAJALwGF08q5McGkEw8hLjOMi30Sp7t8f2VGu
	 KA/87m393gTRjMqAUDcs5+Hv5wYCrgowTTqZN9dRhkzBt6iry+lPg6kcCNne46eq4s
	 av7GZ4PrSbmkrnVU3p1K6wT/4nVa8Wj87m0DbztU1qzQ734J/tLNdnUolya5C0+Q7t
	 onqAU+u/7jJ4gW7SxyiyZUFXV/YvJZL1Rhv8FK5QckjdfxrboJ9KczjET24ed085H0
	 0vzmcy+p+kXoTSxhjykKehejkc3Tclsfl5lkMQP2wB1SSoKvTq1Msf3C8l+N75w65N
	 gVm0OJLFiT/oQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3368DCFD31F;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 24 Nov 2025 21:50:48 +0530
Subject: [PATCH 5/5] PCI/pwrctrl: Switch to the new pwrctrl APIs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-pci-pwrctrl-rework-v1-5-78a72627683d@oss.qualcomm.com>
References: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
In-Reply-To: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9435;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=mDB7xVX8LQeuezZL74Dh28IYQlR8cBKIJVcKC/1hNZ4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJIXsuhRW0BQsoWAqXI8mAjW/5GwKVcDDKgBng
 rzrf95SHSqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSSF7AAKCRBVnxHm/pHO
 9e30B/99wz7r2n/2zStJ2MN+cr4rCnXIFcs3JJXu2aXW7Pqn4TQWeizI3uJlHOO8JekYzyKf9Fm
 LXkrJcZH5GPw3Rxf0e5RbsaE0fFltZoyHaAPTf/hoiqxIBF20kq5D7oyT1Hvo8B8XPWYnh2fr4g
 5jKbg61hAGSDkZ54/pYW1Pj8ACCG0yJ9iCiZ+pcJUDFZbgiZ4et1F59+Cp4Xc7ZlIuOMPIDpd+6
 YUrM7NeZ4vVwfgYr+cXDWNJZt4m/3e/Gxxvg/3fAf3OI4U7Mfqqa+jFBERAFYtVgYnrwv4he1fL
 Wx2Z818e6zkq2/IxKRfg2fEeyZxqz4bH3sYKlKnFLzS9iU0J
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Adopt the recently introduced pwrctrl APIs to create, power on, destroy,
and power off pwrctrl devices. In qcom_pcie_host_init(), call
pci_pwrctrl_create_devices() to create devices, then
pci_pwrctrl_power_on_devices() to power them on, both after controller
resource initialization. Once successful, deassert PERST# for all devices.

In qcom_pcie_host_deinit(), call pci_pwrctrl_power_off_devices() after
asserting PERST#. Note that pci_pwrctrl_destroy_devices() is not called
here, as deinit is only invoked during system suspend where device
destruction is unnecessary. If the driver becomes removable in future,
pci_pwrctrl_destroy_devices() should be called in the remove() handler.

At last, remove the old pwrctrl framework code from the PCI core, as the
new APIs are now the sole consumer of pwrctrl functionality. And also do
not power on the pwrctrl drivers during probe() as this is now handled by
the APIs.

Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c   | 22 ++++++++++--
 drivers/pci/probe.c                      | 59 --------------------------------
 drivers/pci/pwrctrl/core.c               | 15 --------
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  5 ---
 drivers/pci/pwrctrl/slot.c               |  2 --
 drivers/pci/remove.c                     | 20 -----------
 6 files changed, 20 insertions(+), 103 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7b6f4a391ce4..691ba4243342 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
+#include <linux/pci-pwrctrl.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
@@ -1352,10 +1353,18 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_deinit;
 
+	ret = pci_pwrctrl_create_devices(pci->dev);
+	if (ret)
+		goto err_disable_phy;
+
+	ret = pci_pwrctrl_power_on_devices(pci->dev);
+	if (ret)
+		goto err_pwrctrl_destroy;
+
 	if (pcie->cfg->ops->post_init) {
 		ret = pcie->cfg->ops->post_init(pcie);
 		if (ret)
-			goto err_disable_phy;
+			goto err_pwrctrl_power_off;
 	}
 
 	qcom_ep_reset_deassert(pcie);
@@ -1370,6 +1379,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 
 err_assert_reset:
 	qcom_ep_reset_assert(pcie);
+err_pwrctrl_power_off:
+	pci_pwrctrl_power_off_devices(pci->dev);
+err_pwrctrl_destroy:
+	pci_pwrctrl_destroy_devices(pci->dev);
 err_disable_phy:
 	qcom_pcie_phy_power_off(pcie);
 err_deinit:
@@ -1384,6 +1397,11 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	qcom_ep_reset_assert(pcie);
+	/*
+	 * No need to destroy pwrctrl devices as this function only gets called
+	 * during system suspend as of now.
+	 */
+	pci_pwrctrl_power_off_devices(pci->dev);
 	qcom_pcie_phy_power_off(pcie);
 	pcie->cfg->ops->deinit(pcie);
 }
@@ -2035,7 +2053,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(dev, "cannot initialize host\n");
+		dev_err_probe(dev, ret, "cannot initialize host\n");
 		goto err_phy_exit;
 	}
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83e75a0ec12..34033605adf3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2533,56 +2533,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
-#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
-static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
-{
-	struct pci_host_bridge *host = pci_find_host_bridge(bus);
-	struct platform_device *pdev;
-	struct device_node *np;
-
-	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
-	if (!np)
-		return NULL;
-
-	pdev = of_find_device_by_node(np);
-	if (pdev) {
-		put_device(&pdev->dev);
-		goto err_put_of_node;
-	}
-
-	/*
-	 * First check whether the pwrctrl device really needs to be created or
-	 * not. This is decided based on at least one of the power supplies
-	 * being defined in the devicetree node of the device.
-	 */
-	if (!of_pci_supply_present(np)) {
-		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
-		goto err_put_of_node;
-	}
-
-	/* Now create the pwrctrl device */
-	pdev = of_platform_device_create(np, NULL, &host->dev);
-	if (!pdev) {
-		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
-		goto err_put_of_node;
-	}
-
-	of_node_put(np);
-
-	return pdev;
-
-err_put_of_node:
-	of_node_put(np);
-
-	return NULL;
-}
-#else
-static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
-{
-	return NULL;
-}
-#endif
-
 /*
  * Read the config data for a PCI device, sanity-check it,
  * and fill in the dev structure.
@@ -2592,15 +2542,6 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	struct pci_dev *dev;
 	u32 l;
 
-	/*
-	 * Create pwrctrl device (if required) for the PCI device to handle the
-	 * power state. If the pwrctrl device is created, then skip scanning
-	 * further as the pwrctrl core will rescan the bus after powering on
-	 * the device.
-	 */
-	if (pci_pwrctrl_create_device(bus, devfn))
-		return NULL;
-
 	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
 		return NULL;
 
diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index e0a0cf015bd0..69bf2514c420 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -45,16 +45,6 @@ static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_DONE;
 }
 
-static void rescan_work_func(struct work_struct *work)
-{
-	struct pci_pwrctrl *pwrctrl = container_of(work,
-						   struct pci_pwrctrl, work);
-
-	pci_lock_rescan_remove();
-	pci_rescan_bus(to_pci_host_bridge(pwrctrl->dev->parent)->bus);
-	pci_unlock_rescan_remove();
-}
-
 /**
  * pci_pwrctrl_init() - Initialize the PCI power control context struct
  *
@@ -64,7 +54,6 @@ static void rescan_work_func(struct work_struct *work)
 void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
 {
 	pwrctrl->dev = dev;
-	INIT_WORK(&pwrctrl->work, rescan_work_func);
 	dev_set_drvdata(dev, pwrctrl);
 }
 EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
@@ -95,8 +84,6 @@ int pci_pwrctrl_device_set_ready(struct pci_pwrctrl *pwrctrl)
 	if (ret)
 		return ret;
 
-	schedule_work(&pwrctrl->work);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_pwrctrl_device_set_ready);
@@ -109,8 +96,6 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_device_set_ready);
  */
 void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl)
 {
-	cancel_work_sync(&pwrctrl->work);
-
 	/*
 	 * We don't have to delete the link here. Typically, this function
 	 * is only called when the power control device is being detached. If
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index 0fb9038a1d18..7697a8a5cdde 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -101,11 +101,6 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
 				     "Failed to get the power sequencer\n");
 
-	ret = pci_pwrctrl_pwrseq_power_on(&data->ctx);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to power-on the device\n");
-
 	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_pwrseq_power_off,
 				       data);
 	if (ret)
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 14701f65f1f2..888300aeefec 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -79,8 +79,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(slot->clk),
 				     "Failed to enable slot clock\n");
 
-	pci_pwrctrl_slot_power_on(&slot->ctx);
-
 	slot->ctx.power_on = pci_pwrctrl_slot_power_on;
 	slot->ctx.power_off = pci_pwrctrl_slot_power_off;
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index ce5c25adef55..2a22595f38af 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -17,25 +17,6 @@ static void pci_free_resources(struct pci_dev *dev)
 	}
 }
 
-static void pci_pwrctrl_unregister(struct device *dev)
-{
-	struct device_node *np;
-	struct platform_device *pdev;
-
-	np = dev_of_node(dev);
-	if (!np)
-		return;
-
-	pdev = of_find_device_by_node(np);
-	if (!pdev)
-		return;
-
-	of_device_unregister(pdev);
-	put_device(&pdev->dev);
-
-	of_node_clear_flag(np, OF_POPULATED);
-}
-
 static void pci_stop_dev(struct pci_dev *dev)
 {
 	pci_pme_active(dev, false);
@@ -66,7 +47,6 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_doe_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
 	pci_bridge_d3_update(dev);
-	pci_pwrctrl_unregister(&dev->dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }

-- 
2.48.1



