Return-Path: <linux-pci+bounces-44030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20618CF3F9B
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 14:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09F7F3008709
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EFB330D2F;
	Mon,  5 Jan 2026 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqhTJLd+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D55C32AACD;
	Mon,  5 Jan 2026 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621366; cv=none; b=MgquNtEACbfcXk9eJGu1n3nqCUmTKPjjyhWqt4DAGkYa/COPhROh0CeXbvJgny/UPkaCyGfdf45kKI+3pVqpRq3glonvIu7LkKBufEeUWdFLV+qRTS6PwuKQ3uX4KoFt9+XI9yC6j7BeHSR7ebIgyie3gLn6kvsJGxqW75tWiwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621366; c=relaxed/simple;
	bh=78AwoVgGJLpZCepw3lYMpBT1DvYIDg6344iilWRS5Gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GmWQ8SdsEEDYK7izXMVyVAJa0l4N4pV0NUDut6uABnIdQ+D8WCTzuGbrQYo4DSunruAxn2+Mz/L/YXFsHpVZHWF6Sw6fBzTC13tqJ5UalGSXzHGyi6dwUTOOd4A2a018QOnmVxE0+YbbcD1Xn88Gz9ZloEikzt4QKkNqpwVByjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqhTJLd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99C76C2BCB4;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767621365;
	bh=78AwoVgGJLpZCepw3lYMpBT1DvYIDg6344iilWRS5Gw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dqhTJLd+6mIVLFghjoHO9DfWZ0emLog5pB4BSVY2bP4svjaSDvwWp5I+dGFjMxwFz
	 Gn1eV9IFfj9pLtDoOrUqYQ3TuftzlSS1RskNgqed8yePMXCFY8jTnuBwUy8hyYOgSE
	 axJslhJ92vjbiUmTb58HOEkvH2TcxQbtqwbIMxUw8PEAvBMNmChB5tOkeirFtiV5aV
	 KAZlci22uDCfWB9p2IPSQcjw2MxnV3RSF8Z1S/iPx+xA2UauAVULkm2YfQtdAA8hcq
	 44dAjGZwDsTGoOPJUZcsM+rjT8g6cH540iTaARifdcE+Zk7p3sdnr/8C/B1PXnBgR8
	 U17HzOgUZBDCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E5CC79F90;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 05 Jan 2026 19:25:45 +0530
Subject: [PATCH v4 5/8] PCI/pwrctrl: Switch to the new pwrctrl APIs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-pci-pwrctrl-rework-v4-5-6d41a7a49789@oss.qualcomm.com>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
In-Reply-To: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12782;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=JSl8b0Y6K6Fa53yBIlFpgxg3UwsEOtJI3rV1U2lzGb8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpW8LyGZZXythC+MkcQkSIcTHsAo+VGb5yISbqu
 2OYeaZUK9aJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVvC8gAKCRBVnxHm/pHO
 9RDtCACrBHLUrbGAykmOKvqaVZcrf+5iX6T+6RQrb0/c940MLuTyP3d1RPZ5LqVoIKvm4NT/zdI
 QKlgEqHWKVjscIrr0zevNhO4McDytwwE4DL4T463+D2kL2VVhYKlTdLVBbBq9hH5lkNv+7+4w7j
 Q6lvlkbnY/RD6wQuAemLnhOwfi+w6qUkmjVSUq+CgLHmlCQ1KTNMHuM8DdS/Qb+GQ5S6/PjAE0G
 9WW136uWMhnG6fBiOhSD3cQjty862pDZgOAJB/vT11BIl5LVDbiW6+v35NNLs9qK0bd3Y5ri/Xk
 gpzE+cZL0MDsMKPs9FOoeYxmPUfE232/y/LHkDxcVk8kI2uE
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
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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
index cb7947e347d3..5973a83fe0d0 100644
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
index 7e7093cbff3c..42b87d480fe8 100644
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
index 616d3caedb34..66132d437ddb 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -515,8 +515,6 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 
 static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 {
-	struct pci_host_bridge *bridge = to_pci_host_bridge(pdev->dev.parent);
-	struct pci_bus *bus = bridge->bus;
 	struct device *dev = &pdev->dev;
 	enum tc9563_pwrctrl_ports port;
 	struct tc9563_pwrctrl_ctx *ctx;
@@ -592,22 +590,6 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
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
 
@@ -615,8 +597,6 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	if (ret)
 		goto power_off;
 
-	platform_set_drvdata(pdev, ctx);
-
 	return 0;
 
 power_off:
@@ -629,7 +609,9 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 
 static void tc9563_pwrctrl_remove(struct platform_device *pdev)
 {
-	struct tc9563_pwrctrl_ctx *ctx = platform_get_drvdata(pdev);
+	struct pci_pwrctrl *pwrctrl = dev_get_drvdata(&pdev->dev);
+	struct tc9563_pwrctrl_ctx *ctx = container_of(pwrctrl,
+					struct tc9563_pwrctrl_ctx, pwrctrl);
 
 	tc9563_pwrctrl_power_off(&ctx->pwrctrl);
 	i2c_unregister_device(ctx->client);
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 9f91f04b4ae0..dcd6ab79ca82 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -81,8 +81,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
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



