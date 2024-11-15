Return-Path: <linux-pci+bounces-16938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CAA9CF93B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 23:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D6E280F0D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 22:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F141E6DCF;
	Fri, 15 Nov 2024 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq66PEso"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30C1E630C;
	Fri, 15 Nov 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707078; cv=none; b=WhPqcsS++aLrDTro+EdfiYXH1lMjIzWqSwFS6wfePdVeWJeeqOVD7c/5eeWeiUTJ1pNaSaHdmmDJkcTZ/EdkCplWiMZEh431TlVlEYZjnXl6h15K6r2Z7jh0QnP1DqLGTI83qMr3P/P/AINKwxiyT8rAMmHqcmS6v/hvbbCaFcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707078; c=relaxed/simple;
	bh=0YbseWvtxysaIN0AmJOx3pHhLf/tcPB55zEQ97BIZWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WAytFOZ5SKsduaa5LuWCvyIGUE8OA4g/qiWU+WNNFYd4Cerx4VlgkDCYVZ73fXPZIMm9e0D8kZ5MlbR+qmfdoxSsg6BmE2oaiqLWo9lpQe6MgE2DCd73W6L9OvT20dJAlV42vGlSjMCnd9tXAegvC0t2KX+371BmAeAhQOh0Jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq66PEso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5B8C4CECF;
	Fri, 15 Nov 2024 21:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731707077;
	bh=0YbseWvtxysaIN0AmJOx3pHhLf/tcPB55zEQ97BIZWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nq66PEsoypBH0KHeQ9NrFF7ZfmhyErbVFksQ1MDQ8G6Ch8U6FJMXuLhPoW6Gf7Bxv
	 CwVaLWuHlLDejzn2qFH9+vk3DueU7sPqhLPbjY00dkF7YFsIsmm9E337X/rHqfUH06
	 /JieTNwyEJn4/g0p2O9ubZKjIPLWbErLvZB/2DjbzitZe4CjqhdWM6tNYl023heox+
	 DQMxuGgck4Wwvf+gCa1JvYXv9pdCQRin6OyVzorbNU6SCihdHriz/0nkgReGkLieJH
	 WSBFCsiXwvauy8LzDx07dENy5kAS+jvAnrrOb/49HzS6Z4e9RtpLnCYLh9J3kbXsW6
	 PODXmYqOshWsA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI/pwrctrl: Rename pwrctrl functions and structures
Date: Fri, 15 Nov 2024 15:44:28 -0600
Message-Id: <20241115214428.2061153-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115214428.2061153-1-helgaas@kernel.org>
References: <20241115214428.2061153-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Rename pwrctrl functions and structures from "pwrctl" to "pwrctrl" to match
the similar file renames.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pwrctrl/core.c               | 86 ++++++++++++------------
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 32 ++++-----
 drivers/pci/remove.c                     |  4 +-
 include/linux/pci-pwrctrl.h              | 22 +++---
 4 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 8a0b4219571d..a8c7f593af79 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -11,13 +11,13 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
-static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
-			     void *data)
+static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
+			      void *data)
 {
-	struct pci_pwrctl *pwrctl = container_of(nb, struct pci_pwrctl, nb);
+	struct pci_pwrctrl *pwrctrl = container_of(nb, struct pci_pwrctrl, nb);
 	struct device *dev = data;
 
-	if (dev_fwnode(dev) != dev_fwnode(pwrctl->dev))
+	if (dev_fwnode(dev) != dev_fwnode(pwrctrl->dev))
 		return NOTIFY_DONE;
 
 	switch (action) {
@@ -34,14 +34,14 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
 		dev->of_node_reused = true;
 		break;
 	case BUS_NOTIFY_BOUND_DRIVER:
-		pwrctl->link = device_link_add(dev, pwrctl->dev,
+		pwrctrl->link = device_link_add(dev, pwrctrl->dev,
 					       DL_FLAG_AUTOREMOVE_CONSUMER);
-		if (!pwrctl->link)
-			dev_err(pwrctl->dev, "Failed to add device link\n");
+		if (!pwrctrl->link)
+			dev_err(pwrctrl->dev, "Failed to add device link\n");
 		break;
 	case BUS_NOTIFY_UNBOUND_DRIVER:
-		if (pwrctl->link)
-			device_link_remove(dev, pwrctl->dev);
+		if (pwrctrl->link)
+			device_link_remove(dev, pwrctrl->dev);
 		break;
 	}
 
@@ -50,31 +50,31 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
 
 static void rescan_work_func(struct work_struct *work)
 {
-	struct pci_pwrctl *pwrctl = container_of(work, struct pci_pwrctl, work);
+	struct pci_pwrctrl *pwrctrl = container_of(work, struct pci_pwrctrl, work);
 
 	pci_lock_rescan_remove();
-	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
+	pci_rescan_bus(to_pci_dev(pwrctrl->dev->parent)->bus);
 	pci_unlock_rescan_remove();
 }
 
 /**
- * pci_pwrctl_init() - Initialize the PCI power control context struct
+ * pci_pwrctrl_init() - Initialize the PCI power control context struct
  *
- * @pwrctl: PCI power control data
+ * @pwrctrl: PCI power control data
  * @dev: Parent device
  */
-void pci_pwrctl_init(struct pci_pwrctl *pwrctl, struct device *dev)
+void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
 {
-	pwrctl->dev = dev;
-	INIT_WORK(&pwrctl->work, rescan_work_func);
+	pwrctrl->dev = dev;
+	INIT_WORK(&pwrctrl->work, rescan_work_func);
 }
-EXPORT_SYMBOL_GPL(pci_pwrctl_init);
+EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
 
 /**
- * pci_pwrctl_device_set_ready() - Notify the pwrctl subsystem that the PCI
+ * pci_pwrctrl_device_set_ready() - Notify the pwrctrl subsystem that the PCI
  * device is powered-up and ready to be detected.
  *
- * @pwrctl: PCI power control data.
+ * @pwrctrl: PCI power control data.
  *
  * Returns:
  * 0 on success, negative error number on error.
@@ -84,31 +84,31 @@ EXPORT_SYMBOL_GPL(pci_pwrctl_init);
  * that the bus rescan was successfully started. The device will get bound to
  * its PCI driver asynchronously.
  */
-int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl)
+int pci_pwrctrl_device_set_ready(struct pci_pwrctrl *pwrctrl)
 {
 	int ret;
 
-	if (!pwrctl->dev)
+	if (!pwrctrl->dev)
 		return -ENODEV;
 
-	pwrctl->nb.notifier_call = pci_pwrctl_notify;
-	ret = bus_register_notifier(&pci_bus_type, &pwrctl->nb);
+	pwrctrl->nb.notifier_call = pci_pwrctrl_notify;
+	ret = bus_register_notifier(&pci_bus_type, &pwrctrl->nb);
 	if (ret)
 		return ret;
 
-	schedule_work(&pwrctl->work);
+	schedule_work(&pwrctrl->work);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_pwrctl_device_set_ready);
+EXPORT_SYMBOL_GPL(pci_pwrctrl_device_set_ready);
 
 /**
- * pci_pwrctl_device_unset_ready() - Notify the pwrctl subsystem that the PCI
+ * pci_pwrctrl_device_unset_ready() - Notify the pwrctrl subsystem that the PCI
  * device is about to be powered-down.
  *
- * @pwrctl: PCI power control data.
+ * @pwrctrl: PCI power control data.
  */
-void pci_pwrctl_device_unset_ready(struct pci_pwrctl *pwrctl)
+void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl)
 {
 	/*
 	 * We don't have to delete the link here. Typically, this function
@@ -116,41 +116,41 @@ void pci_pwrctl_device_unset_ready(struct pci_pwrctl *pwrctl)
 	 * it is being detached then the child PCI device must have already
 	 * been unbound too or the device core wouldn't let us unbind.
 	 */
-	bus_unregister_notifier(&pci_bus_type, &pwrctl->nb);
+	bus_unregister_notifier(&pci_bus_type, &pwrctrl->nb);
 }
-EXPORT_SYMBOL_GPL(pci_pwrctl_device_unset_ready);
+EXPORT_SYMBOL_GPL(pci_pwrctrl_device_unset_ready);
 
-static void devm_pci_pwrctl_device_unset_ready(void *data)
+static void devm_pci_pwrctrl_device_unset_ready(void *data)
 {
-	struct pci_pwrctl *pwrctl = data;
+	struct pci_pwrctrl *pwrctrl = data;
 
-	pci_pwrctl_device_unset_ready(pwrctl);
+	pci_pwrctrl_device_unset_ready(pwrctrl);
 }
 
 /**
- * devm_pci_pwrctl_device_set_ready - Managed variant of
- * pci_pwrctl_device_set_ready().
+ * devm_pci_pwrctrl_device_set_ready - Managed variant of
+ * pci_pwrctrl_device_set_ready().
  *
- * @dev: Device managing this pwrctl provider.
- * @pwrctl: PCI power control data.
+ * @dev: Device managing this pwrctrl provider.
+ * @pwrctrl: PCI power control data.
  *
  * Returns:
  * 0 on success, negative error number on error.
  */
-int devm_pci_pwrctl_device_set_ready(struct device *dev,
-				     struct pci_pwrctl *pwrctl)
+int devm_pci_pwrctrl_device_set_ready(struct device *dev,
+				      struct pci_pwrctrl *pwrctrl)
 {
 	int ret;
 
-	ret = pci_pwrctl_device_set_ready(pwrctl);
+	ret = pci_pwrctrl_device_set_ready(pwrctrl);
 	if (ret)
 		return ret;
 
 	return devm_add_action_or_reset(dev,
-					devm_pci_pwrctl_device_unset_ready,
-					pwrctl);
+					devm_pci_pwrctrl_device_unset_ready,
+					pwrctrl);
 }
-EXPORT_SYMBOL_GPL(devm_pci_pwrctl_device_set_ready);
+EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
 
 MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
 MODULE_DESCRIPTION("PCI Device Power Control core driver");
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index cc19ad61dd6e..e9f89866b7c2 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -13,21 +13,21 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-struct pci_pwrctl_pwrseq_data {
-	struct pci_pwrctl ctx;
+struct pci_pwrctrl_pwrseq_data {
+	struct pci_pwrctrl ctx;
 	struct pwrseq_desc *pwrseq;
 };
 
-static void devm_pci_pwrctl_pwrseq_power_off(void *data)
+static void devm_pci_pwrctrl_pwrseq_power_off(void *data)
 {
 	struct pwrseq_desc *pwrseq = data;
 
 	pwrseq_power_off(pwrseq);
 }
 
-static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
+static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
 {
-	struct pci_pwrctl_pwrseq_data *data;
+	struct pci_pwrctrl_pwrseq_data *data;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -45,22 +45,22 @@ static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to power-on the device\n");
 
-	ret = devm_add_action_or_reset(dev, devm_pci_pwrctl_pwrseq_power_off,
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_pwrseq_power_off,
 				       data->pwrseq);
 	if (ret)
 		return ret;
 
-	pci_pwrctl_init(&data->ctx, dev);
+	pci_pwrctrl_init(&data->ctx, dev);
 
-	ret = devm_pci_pwrctl_device_set_ready(dev, &data->ctx);
+	ret = devm_pci_pwrctrl_device_set_ready(dev, &data->ctx);
 	if (ret)
 		return dev_err_probe(dev, ret,
-				     "Failed to register the pwrctl wrapper\n");
+				     "Failed to register the pwrctrl wrapper\n");
 
 	return 0;
 }
 
-static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
+static const struct of_device_id pci_pwrctrl_pwrseq_of_match[] = {
 	{
 		/* ATH11K in QCA6390 package. */
 		.compatible = "pci17cb,1101",
@@ -78,16 +78,16 @@ static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
 	},
 	{ }
 };
-MODULE_DEVICE_TABLE(of, pci_pwrctl_pwrseq_of_match);
+MODULE_DEVICE_TABLE(of, pci_pwrctrl_pwrseq_of_match);
 
-static struct platform_driver pci_pwrctl_pwrseq_driver = {
+static struct platform_driver pci_pwrctrl_pwrseq_driver = {
 	.driver = {
-		.name = "pci-pwrctl-pwrseq",
-		.of_match_table = pci_pwrctl_pwrseq_of_match,
+		.name = "pci-pwrctrl-pwrseq",
+		.of_match_table = pci_pwrctrl_pwrseq_of_match,
 	},
-	.probe = pci_pwrctl_pwrseq_probe,
+	.probe = pci_pwrctrl_pwrseq_probe,
 };
-module_platform_driver(pci_pwrctl_pwrseq_driver);
+module_platform_driver(pci_pwrctrl_pwrseq_driver);
 
 MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
 MODULE_DESCRIPTION("Generic PCI Power Control module for power sequenced devices");
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index e4ce1145aa3e..184ff85d8d4e 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -17,7 +17,7 @@ static void pci_free_resources(struct pci_dev *dev)
 	}
 }
 
-static int pci_pwrctl_unregister(struct device *dev, void *data)
+static int pci_pwrctrl_unregister(struct device *dev, void *data)
 {
 	struct device_node *pci_node = data, *plat_node = dev_of_node(dev);
 
@@ -35,7 +35,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 
 	if (pci_dev_is_added(dev)) {
 		device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
-				      pci_pwrctl_unregister);
+				      pci_pwrctrl_unregister);
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
index 0d23dddf59ec..7d439b0675e9 100644
--- a/include/linux/pci-pwrctrl.h
+++ b/include/linux/pci-pwrctrl.h
@@ -3,8 +3,8 @@
  * Copyright (C) 2024 Linaro Ltd.
  */
 
-#ifndef __PCI_PWRCTL_H__
-#define __PCI_PWRCTL_H__
+#ifndef __PCI_PWRCTRL_H__
+#define __PCI_PWRCTRL_H__
 
 #include <linux/notifier.h>
 #include <linux/workqueue.h>
@@ -29,14 +29,14 @@ struct device_link;
  */
 
 /**
- * struct pci_pwrctl - PCI device power control context.
+ * struct pci_pwrctrl - PCI device power control context.
  * @dev: Address of the power controlling device.
  *
  * An object of this type must be allocated by the PCI power control device and
- * passed to the pwrctl subsystem to trigger a bus rescan and setup a device
+ * passed to the pwrctrl subsystem to trigger a bus rescan and setup a device
  * link with the device once it's up.
  */
-struct pci_pwrctl {
+struct pci_pwrctrl {
 	struct device *dev;
 
 	/* Private: don't use. */
@@ -45,10 +45,10 @@ struct pci_pwrctl {
 	struct work_struct work;
 };
 
-void pci_pwrctl_init(struct pci_pwrctl *pwrctl, struct device *dev);
-int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl);
-void pci_pwrctl_device_unset_ready(struct pci_pwrctl *pwrctl);
-int devm_pci_pwrctl_device_set_ready(struct device *dev,
-				     struct pci_pwrctl *pwrctl);
+void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev);
+int pci_pwrctrl_device_set_ready(struct pci_pwrctrl *pwrctrl);
+void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl);
+int devm_pci_pwrctrl_device_set_ready(struct device *dev,
+				     struct pci_pwrctrl *pwrctrl);
 
-#endif /* __PCI_PWRCTL_H__ */
+#endif /* __PCI_PWRCTRL_H__ */
-- 
2.34.1


