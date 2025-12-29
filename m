Return-Path: <linux-pci+bounces-43815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C0ECE7BDE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 18:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E6CE30022D8
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B6A331211;
	Mon, 29 Dec 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHjj0yUp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE2330D2F;
	Mon, 29 Dec 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767029226; cv=none; b=GA8tD8GTRRX4kteXA0y2/cpbg92NJl7ztX0r1I94VaDF927YtcXxrrZcfOcoOKCqet0yJWORdxP6dK1d+zy5nQv6iAp1e0FQx6VXd1ht1c11nbQR6Wdof8rMMACSyMIJkUqcOPw6BXSrzsgb3SkrrxMEK+5D/M1XI3L4DUyjgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767029226; c=relaxed/simple;
	bh=tXkhfi5utMbRMIYrOaStMkNlZrNtFfn+DaYP/sSGipk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JP5ieYvgwqR4f0p7DfoVZNCm2rnxdWufA970FMnJo1MtsNhemdqCVWqID8M9vOEfxXufKbLjOt/TZiCk5THMa9D9qOzUYDstABQ3kHiuSW7+0JkKrLU8ayV/6/ptg6KfyXwDbxdTkuLs2/LzHCp4ne5EivsHZss25EJvixuMKBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHjj0yUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E7D3C19423;
	Mon, 29 Dec 2025 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767029226;
	bh=tXkhfi5utMbRMIYrOaStMkNlZrNtFfn+DaYP/sSGipk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eHjj0yUpIGot2sOAK3vvVEqKm1jktNeAR81JOjxhyqVRFgyJkdOUc/XhliZ+YcfUi
	 izS9oMLp5Dv1Y80kto1S2BkzMvBgrO9QQVwSSGhAqMMWX1hEu9UB9XiXEO+NBPBGx8
	 lXpE3/fd67iyx0RWtTTU7rIkFf2+9dsxBrKDzEX5qf/r9kyr32Rvf+glOsAOe4lKm+
	 q3+JvK5gIs8SAAq4GrJe9As/ygQEgUdM9yWuwOPU8I8CY0ZqfBdzimkX0kqeMz7lx7
	 sIs3GNQa1e/dKm1IWQ3rdpprAIaGaeQUNBeE1xIPUorz0BAxOu7/itLBKzLAhLvDpg
	 i8t+mid+MorVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA9FE92FC0;
	Mon, 29 Dec 2025 17:27:06 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 29 Dec 2025 22:56:56 +0530
Subject: [PATCH v3 5/7] PCI/pwrctrl: Switch to the new pwrctrl APIs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-pci-pwrctrl-rework-v3-5-c7d5918cd0db@oss.qualcomm.com>
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
In-Reply-To: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12709;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=xJGlMr8jzfUCOPi0L0xjpmgJlix2wx+41gIV2bS/OwY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpUrnmU+JnoiTTQCJyWOufX4yMnDcPjC7QMXeWJ
 23+y207uzOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVK55gAKCRBVnxHm/pHO
 9bb4B/4+2qFrd7XgCZ1TlvEZuGip+KIJ9IbhNg40JiggzHGTIYPHXwgQJHmcDo6sm364mP89fbC
 +W3MMrAJ+csVbHW+gy1zKvoHFnMrwGvZ/8jSWwq5Ne6lcDr67ybyYwaisGN/pj9FXr9bVVXc6hH
 08D+g3hAAd3MgeDx69nT1tPGiYO4lbmkHCwlmlm2XyXLfj4EBqrVYFoF1V0oM1dfX5lzJvh0aur
 dCojZqoWBduIKwy9SuujNzMtaUWMYIh7K+TZrpy7gpEcYjXBpT5PCXE+G19tD5nbjez7jnNQsDs
 7MW4bxc0DKiC4fZ8+h7eYPgplC6BhHdDt1aMXMUegZjZamqo
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

At last, remove the old pwrctrl framework code from the PCI core (including
devlinks) as the new APIs are now the sole consumer of pwrctrl
functionality. And also do not power on the pwrctrl drivers during probe()
as this is now handled by the APIs.

Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/bus.c                        | 19 ----------
 drivers/pci/controller/dwc/pcie-qcom.c   | 23 +++++++++++--
 drivers/pci/probe.c                      | 59 --------------------------------
 drivers/pci/pwrctrl/core.c               | 15 --------
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  5 ---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 24 ++-----------
 drivers/pci/pwrctrl/slot.c               |  2 --
 drivers/pci/remove.c                     | 20 -----------
 8 files changed, 24 insertions(+), 143 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 4383a36fd6ca..d60d5f108212 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -344,7 +344,6 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
 void pci_bus_add_device(struct pci_dev *dev)
 {
 	struct device_node *dn = dev->dev.of_node;
-	struct platform_device *pdev;
 
 	/*
 	 * Can not put in pci_device_add yet because resources
@@ -361,24 +360,6 @@ void pci_bus_add_device(struct pci_dev *dev)
 	/* Save config space for error recoverability */
 	pci_save_state(dev);
 
-	/*
-	 * If the PCI device is associated with a pwrctrl device with a
-	 * power supply, create a device link between the PCI device and
-	 * pwrctrl device.  This ensures that pwrctrl drivers are probed
-	 * before PCI client drivers.
-	 */
-	pdev = of_find_device_by_node(dn);
-	if (pdev) {
-		if (of_pci_supply_present(dn)) {
-			if (!device_link_add(&dev->dev, &pdev->dev,
-					     DL_FLAG_AUTOREMOVE_CONSUMER)) {
-				pci_err(dev, "failed to add device link to power control device %s\n",
-					pdev->name);
-			}
-		}
-		put_device(&pdev->dev);
-	}
-
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 1ca58d0264e3..198befb5be2c 100644
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
@@ -1317,10 +1318,18 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
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
 
 	qcom_pcie_clear_aspm_l0s(pcie->pci);
@@ -1337,6 +1346,11 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 
 err_assert_reset:
 	qcom_ep_reset_assert(pcie);
+err_pwrctrl_power_off:
+	pci_pwrctrl_power_off_devices(pci->dev);
+err_pwrctrl_destroy:
+	if (ret != -EPROBE_DEFER)
+		pci_pwrctrl_destroy_devices(pci->dev);
 err_disable_phy:
 	qcom_pcie_phy_power_off(pcie);
 err_deinit:
@@ -1351,6 +1365,11 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
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
@@ -2029,7 +2048,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(dev, "cannot initialize host\n");
+		dev_err_probe(dev, ret, "cannot initialize host\n");
 		goto err_phy_exit;
 	}
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..6e7252404b58 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2563,56 +2563,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
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
@@ -2622,15 +2572,6 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
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
index 0ca448f3bea8..4044edc472b9 100644
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
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 0393af2a099c..df77d408adfa 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -513,8 +513,6 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 
 static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 {
-	struct pci_host_bridge *bridge = to_pci_host_bridge(pdev->dev.parent);
-	struct pci_bus *bus = bridge->bus;
 	struct device *dev = &pdev->dev;
 	enum tc9563_pwrctrl_ports port;
 	struct tc9563_pwrctrl_ctx *ctx;
@@ -590,22 +588,6 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 		goto remove_i2c;
 	}
 
-	if (bridge->ops->assert_perst) {
-		ret = bridge->ops->assert_perst(bus, true);
-		if (ret)
-			goto remove_i2c;
-	}
-
-	ret = tc9563_pwrctrl_power_on(&ctx->pwrctrl);
-	if (ret)
-		goto remove_i2c;
-
-	if (bridge->ops->assert_perst) {
-		ret = bridge->ops->assert_perst(bus, false);
-		if (ret)
-			goto power_off;
-	}
-
 	ctx->pwrctrl.power_on = tc9563_pwrctrl_power_on;
 	ctx->pwrctrl.power_off = tc9563_pwrctrl_power_off;
 
@@ -613,8 +595,6 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	if (ret)
 		goto power_off;
 
-	platform_set_drvdata(pdev, ctx);
-
 	return 0;
 
 power_off:
@@ -627,7 +607,9 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 
 static void tc9563_pwrctrl_remove(struct platform_device *pdev)
 {
-	struct tc9563_pwrctrl_ctx *ctx = platform_get_drvdata(pdev);
+	struct pci_pwrctrl *pwrctrl = dev_get_drvdata(&pdev->dev);
+	struct tc9563_pwrctrl_ctx *ctx = container_of(pwrctrl,
+					struct tc9563_pwrctrl_ctx, pwrctrl);
 
 	tc9563_pwrctrl_power_off(&ctx->pwrctrl);
 	i2c_unregister_device(ctx->client);
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
index 417a9ea59117..e9d519993853 100644
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
@@ -73,7 +54,6 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_ide_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
 	pci_bridge_d3_update(dev);
-	pci_pwrctrl_unregister(&dev->dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }

-- 
2.48.1



