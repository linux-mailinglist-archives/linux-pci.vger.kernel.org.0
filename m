Return-Path: <linux-pci+bounces-44906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 933E0D22D68
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EEF0301F328
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B3532BF51;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfC49AxW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F732ABFD;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462152; cv=none; b=iwXWYnpjjAvl0cNU+nVeNVmxo4UaZp/kqmUVHLi7PUe9y6je8jFu6n6+gc9+2Op2P6eDhwCLS34/BdDmKsCEY0uvnTfB7MKhHwxPUkboA5zRc+MCWJ6w6mgjklXfCZp2CImTVdkvLSjtPhEnMIdBSxi5+Lbbuh7OCffaIL/5kbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462152; c=relaxed/simple;
	bh=xpv4TT1tGO//ZKvetO1F+ECh4/9TaRWFkSjHPk94aBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EU/2UaOw1ncECwxK5glih/yuu9grjDijO1kOYKLUrXLXjH4Z/e+IPHYS3O5vgUr82uPmlFXUYeD7f2D49wMFflfIXbx9bQztMsQvrUsae/X9syzvmTPqmWS+wZ8fWV1+ttm1nj69v2yisJfqa5WhpIa74CRQh8uwdj8dOKXJ9YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfC49AxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01A9FC19423;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462152;
	bh=xpv4TT1tGO//ZKvetO1F+ECh4/9TaRWFkSjHPk94aBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QfC49AxWhSTZ02zb++XZOndyttUlOoXs2e3QkGFf7mUGeNdaksj33s35z0ejm2k+n
	 G2D1dd6dwLKUSAMvL2WEwW6R0Rn7kpyfLx2mzT3za6Xah63nj/InlGhRhYpyQrBPbr
	 VSNwccYV9+HfbWvoWbwljhm24zG2n+qqn4+r37rhMYHbm8hyswAfV105FB7qklXvEm
	 NZM0Ty3glBkJ5kcVpWAzJhtuZiHB3w2fZdP1JX739pVJZCXep5BAvVn9xRo84lny4l
	 iz2+GmaVsoQZLt8V1Su9ANWT8+MMIFtPUyPHmjOAb8sVgIPNhtF+d0Cq4H1OB20NrN
	 OOlIX+J09XMuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6F7D3CCBB;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:59:04 +0530
Subject: [PATCH v5 12/15] PCI/pwrctrl: Switch to pwrctrl create, power
 on/off, destroy APIs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-12-9d26da3ce903@oss.qualcomm.com>
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12890;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=oRG+qd+uiz4zbP0UfX+/pmdCGtBAYhsTub4b6+6BBL4=;
 b=kA0DAAoBVZ8R5v6RzvUByyZiAGlol0KiFLFIcEvu2T4dAul7nOZn+chMtgKl+nDhJ9zQUHFVF
 YkBMwQAAQoAHRYhBGelQyqBSMvYpFgnl1WfEeb+kc71BQJpaJdCAAoJEFWfEeb+kc71jagIAJ+C
 GY12d+DrY8fNCWCWevNFV3sVSz03CIRcds4ufFa8AkD54dg10M64IXGGkzTkNRxHcjoloOdNJpf
 otyzOq0Diwkra5DoOToGhm6onZjIMxzv+P5e4VsCYUeo69+as1x5+ZothJsRiUn9hUbAS3iSIF8
 ju9kVZDQ58fK13RR/ks5N/UX+pw80TwGCs8ncraWMYGupTI3EQotMSQz23TisCZP4TZy/xpmTYV
 /sfH/R1Casjqhsddzirrqn3rk4CVJ0rwzjhY5MIxtsBn3eagBOCCpE5TWscMeV2uNuzRc9JvQXG
 R4iKUGXIjlWJBVFt+4ua+3rFL/qEPrTdEMzVFEg=
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Adopt pwrctrl APIs to create, power on/off, and destroy pwrctrl devices.

In qcom_pcie_host_init(), call pci_pwrctrl_create_devices() to create
devices, then pci_pwrctrl_power_on_devices() to power them on, both after
controller resource initialization. Once successful, deassert PERST# for
all devices.

In qcom_pcie_host_deinit(), call pci_pwrctrl_power_off_devices() after
asserting PERST#. Note that pci_pwrctrl_destroy_devices() is not called
here, as deinit is only invoked during system suspend where device
destruction is unnecessary. If the driver becomes removable in future,
pci_pwrctrl_destroy_devices() should be called in the remove() handler.

Remove the old pwrctrl framework code from the PCI core (including
devlinks) as the new APIs are now the sole consumer of pwrctrl
functionality. And also do not power on the pwrctrl drivers during probe()
as this is now handled by the APIs.

Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pci/bus.c                        | 19 ----------
 drivers/pci/controller/dwc/pcie-qcom.c   | 24 +++++++++++--
 drivers/pci/probe.c                      | 59 --------------------------------
 drivers/pci/pwrctrl/core.c               | 15 --------
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  5 ---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 24 ++-----------
 drivers/pci/pwrctrl/slot.c               |  2 --
 drivers/pci/remove.c                     | 20 -----------
 8 files changed, 25 insertions(+), 143 deletions(-)

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
index 7b92e7a1c0d9..20b7593b8397 100644
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
@@ -1310,10 +1311,18 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -1328,6 +1337,11 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 
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
@@ -1342,6 +1356,12 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	qcom_ep_reset_assert(pcie);
+
+	/*
+	 * No need to destroy pwrctrl devices as this function only gets called
+	 * during system suspend as of now.
+	 */
+	pci_pwrctrl_power_off_devices(pci->dev);
 	qcom_pcie_phy_power_off(pcie);
 	pcie->cfg->ops->deinit(pcie);
 }
@@ -1961,7 +1981,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
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
index fef5243d9445..1b91375738a0 100644
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
index 2ee02edd55a3..1df0cd73b416 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -101,11 +101,6 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(pwrseq->pwrseq),
 				     "Failed to get the power sequencer\n");
 
-	ret = pci_pwrctrl_pwrseq_power_on(&pwrseq->pwrctrl);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to power-on the device\n");
-
 	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_pwrseq_power_off,
 				       pwrseq);
 	if (ret)
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index a71d7ef2d4b8..38008d03903f 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -533,9 +533,7 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 
 static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 {
-	struct pci_host_bridge *bridge = to_pci_host_bridge(pdev->dev.parent);
 	struct device_node *node = pdev->dev.of_node;
-	struct pci_bus *bus = bridge->bus;
 	struct device *dev = &pdev->dev;
 	enum tc9563_pwrctrl_ports port;
 	struct pci_pwrctrl_tc9563 *tc9563;
@@ -614,22 +612,6 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 		goto remove_i2c;
 	}
 
-	if (bridge->ops->assert_perst) {
-		ret = bridge->ops->assert_perst(bus, true);
-		if (ret)
-			goto remove_i2c;
-	}
-
-	ret = tc9563_pwrctrl_power_on(&tc9563->pwrctrl);
-	if (ret)
-		goto remove_i2c;
-
-	if (bridge->ops->assert_perst) {
-		ret = bridge->ops->assert_perst(bus, false);
-		if (ret)
-			goto power_off;
-	}
-
 	tc9563->pwrctrl.power_on = tc9563_pwrctrl_power_on;
 	tc9563->pwrctrl.power_off = tc9563_pwrctrl_power_off;
 
@@ -637,8 +619,6 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	if (ret)
 		goto power_off;
 
-	platform_set_drvdata(pdev, tc9563);
-
 	return 0;
 
 power_off:
@@ -651,7 +631,9 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 
 static void tc9563_pwrctrl_remove(struct platform_device *pdev)
 {
-	struct pci_pwrctrl_tc9563 *tc9563 = platform_get_drvdata(pdev);
+	struct pci_pwrctrl *pwrctrl = dev_get_drvdata(&pdev->dev);
+	struct pci_pwrctrl_tc9563 *tc9563 = container_of(pwrctrl,
+					struct pci_pwrctrl_tc9563, pwrctrl);
 
 	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
 	i2c_unregister_device(tc9563->client);
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 55828aec2486..a36e5dd42442 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -83,8 +83,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(slot->clk),
 				     "Failed to enable slot clock\n");
 
-	pci_pwrctrl_slot_power_on(&slot->pwrctrl);
-
 	slot->pwrctrl.power_on = pci_pwrctrl_slot_power_on;
 	slot->pwrctrl.power_off = pci_pwrctrl_slot_power_off;
 
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



