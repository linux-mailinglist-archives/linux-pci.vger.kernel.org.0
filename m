Return-Path: <linux-pci+bounces-44031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9BBCF3F8F
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 14:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B640D30090D9
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27884330B3B;
	Mon,  5 Jan 2026 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/JwNtoP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D64132B989;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621366; cv=none; b=DOut3pWiahiPwBuIGmaWzuBjLu7uW0guefnvg7AUDMqWZI01Y8XYBrR2yibi1bz7UARm7/khRityIrh2Bobx4kz/gn7DaokBeTfNGQfvAcvtl0FOURDhmaV640CNaJPbzdGoI727nTt6vy6bNeqnkMJNFkwkUY4RhXPsMW7a3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621366; c=relaxed/simple;
	bh=ni+a3dycbmztIS++4kP4aVCZNURFK03aQMtumKHy7jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WegQmLbxb4iQWH6I/IsN3wJDyI4OtMySSd6yh1F+qjfySYg40dlDIIqvIUReFnYIdo2+11S6dZSTE/hHFV2zNTkucvWgnmfm5wuUF53aT3Hf8++6fV1XbnhMuy7eutiEiiFE2juYvnL07z29pI94+l+JNbQarZNXlO/PsC1TIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/JwNtoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F455C2BC87;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767621365;
	bh=ni+a3dycbmztIS++4kP4aVCZNURFK03aQMtumKHy7jU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t/JwNtoPWuYk7Qz9eN+ej4wxIi9lawe5K4es15rlmdku0RoEH+YBIer0ufpiTseiJ
	 tD+s0sM1gY0ZAHrejXO2hBXNNrWzdgzosPaE0FiGVH/VN9IzloELQ3h2h4eKodq3YD
	 PxnkliUIQ5BlVLfMlRv7U2kYZm6fg/fd2BaBzN860vx9NLeVBZYkSRto0CSqntZQ3n
	 wamhZeGnsUcBERM7YJHnigzf0M+JuV9Pv1aV2e1sfSZflZF1ZGtHtrWn4yFI8XORyk
	 G5qs3gMj4EmKQJlK5o3BkaS67eDGT9e9rwPAHOKpZtv5BilIIwG23+5XjFpJaQQBsQ
	 YQZiFvpAx5ewQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811C0C79F9C;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 05 Jan 2026 19:25:44 +0530
Subject: [PATCH v4 4/8] PCI/pwrctrl: Add APIs to power on/off the pwrctrl
 devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-pci-pwrctrl-rework-v4-4-6d41a7a49789@oss.qualcomm.com>
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
 Chen-Yu Tsai <wenst@chromium.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6585;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Fb+bpv69BElyB5En6ECdvbqRV1R+Pqvx0KEJwNE+5ZE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpW8LyiLbA0Tx7bj7A+zXnQQ4WfuZsok9yOGXoM
 A7SrVdn2oaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVvC8gAKCRBVnxHm/pHO
 9QNjB/9KKW5YcELIN6C9t2IIazLjPt+jROwu9xM/sYGBZRp0RzITMx/6Y7ab/f5U0S6+4y35fvZ
 12WIHEz4m5O/DeX0IPmfgP0LN1U2CAfW68aoIrK/jdRNxh26vcmqwPBvY1/MWuLWKCYIgDaV6Xo
 yOWqF95zTI3kuFosEVpVKro4/o0GgaUa6uYeA/OWP1OQ8w/0+E5f+L4rYJSfpTUwy7Frv4mnuiE
 z80ebvHjZvR4EKJ7hZ21SDXr/dn7n2PCbpwEM6l7UJ7M4iOW/bhxCR+46Sjgznj7eAxMQqtq6qF
 gWl6ShrKRFHF7eUDMZ5iP3VUlZ4g3uU0iJG16BQ7aUlQyzzV
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

To fix PCIe bridge resource allocation issues when powering PCIe
switches with the pwrctrl driver, introduce APIs to explicitly power
on and off all related devices simultaneously.

Previously, the individual pwrctrl drivers powered on/off the PCIe devices
autonomously, without any control from the controller drivers. But to
enforce ordering w.r.t powering on the devices, these APIs will power
on/off all the devices at the same time.

The pci_pwrctrl_power_on_devices() API recursively scans the PCI child
nodes, makes sure that pwrctrl drivers are bind to devices, and calls their
power_on() callbacks. If any of the pwrctrl driver is not bound, it will
return -EPROBE_DEFER.

Similarly, pci_pwrctrl_power_off_devices() API powers off devices
recursively via their power_off() callbacks.

These APIs are expected to be called during the controller probe and
suspend/resume time to power on/off the devices. But before calling these
APIs, the pwrctrl devices should've been created beforehand using the
pci_pwrctrl_{create/destroy}_devices() APIs.

Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c  | 132 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-pwrctrl.h |   4 ++
 2 files changed, 136 insertions(+)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 4bd67b688a68..cb7947e347d3 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -65,6 +65,7 @@ void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
 {
 	pwrctrl->dev = dev;
 	INIT_WORK(&pwrctrl->work, rescan_work_func);
+	dev_set_drvdata(dev, pwrctrl);
 }
 EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
 
@@ -152,6 +153,137 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
 
+static int __pci_pwrctrl_power_off_device(struct device *dev)
+{
+	struct pci_pwrctrl *pwrctrl = dev_get_drvdata(dev);
+
+	if (!pwrctrl)
+		return 0;
+
+	return pwrctrl->power_off(pwrctrl);
+}
+
+static void pci_pwrctrl_power_off_device(struct device_node *np)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	for_each_available_child_of_node_scoped(np, child)
+		pci_pwrctrl_power_off_device(child);
+
+	pdev = of_find_device_by_node(np);
+	if (pdev) {
+		if (device_is_bound(&pdev->dev)) {
+			ret = __pci_pwrctrl_power_off_device(&pdev->dev);
+			if (ret)
+				dev_err(&pdev->dev, "Failed to power off device: %d", ret);
+		}
+
+		platform_device_put(pdev);
+	}
+}
+
+/**
+ * pci_pwrctrl_power_off_devices - Power off the pwrctrl devices
+ *
+ * @parent: Parent PCI device for which the pwrctrl devices need to be powered
+ * off.
+ *
+ * This function recursively traverses all pwrctrl devices for the child nodes
+ * of the specified PCI parent device, and powers them off in a depth first
+ * manner.
+ */
+void pci_pwrctrl_power_off_devices(struct device *parent)
+{
+	struct device_node *np = parent->of_node;
+
+	for_each_available_child_of_node_scoped(np, child)
+		pci_pwrctrl_power_off_device(child);
+}
+EXPORT_SYMBOL_GPL(pci_pwrctrl_power_off_devices);
+
+static int __pci_pwrctrl_power_on_device(struct device *dev)
+{
+	struct pci_pwrctrl *pwrctrl = dev_get_drvdata(dev);
+
+	if (!pwrctrl)
+		return 0;
+
+	return pwrctrl->power_on(pwrctrl);
+}
+
+/*
+ * Power on the devices in a depth first manner. Before powering on the device,
+ * make sure its driver is bound.
+ */
+static int pci_pwrctrl_power_on_device(struct device_node *np)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	for_each_available_child_of_node_scoped(np, child) {
+		ret = pci_pwrctrl_power_on_device(child);
+		if (ret)
+			return ret;
+	}
+
+	pdev = of_find_device_by_node(np);
+	if (pdev) {
+		if (!device_is_bound(&pdev->dev)) {
+			/* FIXME: Use blocking wait instead of probe deferral */
+			dev_dbg(&pdev->dev, "driver is not bound\n");
+			ret = -EPROBE_DEFER;
+		} else {
+			ret = __pci_pwrctrl_power_on_device(&pdev->dev);
+		}
+		platform_device_put(pdev);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * pci_pwrctrl_power_on_devices - Power on the pwrctrl devices
+ *
+ * @parent: Parent PCI device for which the pwrctrl devices need to be powered
+ * on.
+ *
+ * This function recursively traverses all pwrctrl devices for the child nodes
+ * of the specified PCI parent device, and powers them on in a depth first
+ * manner. On error, all powered on devices will be powered off.
+ *
+ * Returns: 0 on success, -EPROBE_DEFER if any pwrctrl driver is not bound, an
+ * appropriate error code otherwise.
+ */
+int pci_pwrctrl_power_on_devices(struct device *parent)
+{
+	struct device_node *np = parent->of_node;
+	struct device_node *child = NULL;
+	int ret;
+
+	for_each_available_child_of_node(np, child) {
+		ret = pci_pwrctrl_power_on_device(child);
+		if (ret)
+			goto err_power_off;
+	}
+
+	return 0;
+
+err_power_off:
+	for_each_available_child_of_node_scoped(np, tmp) {
+		if (tmp == child)
+			break;
+		pci_pwrctrl_power_off_device(tmp);
+	}
+	of_node_put(child);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
+
 static int pci_pwrctrl_create_device(struct device_node *np, struct device *parent)
 {
 	struct platform_device *pdev;
diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
index 44f66872d090..1192a2527521 100644
--- a/include/linux/pci-pwrctrl.h
+++ b/include/linux/pci-pwrctrl.h
@@ -57,8 +57,12 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
 #if IS_ENABLED(CONFIG_PCI_PWRCTRL)
 int pci_pwrctrl_create_devices(struct device *parent);
 void pci_pwrctrl_destroy_devices(struct device *parent);
+int pci_pwrctrl_power_on_devices(struct device *parent);
+void pci_pwrctrl_power_off_devices(struct device *parent);
 #else
 static inline int pci_pwrctrl_create_devices(struct device *parent) { return 0; }
 static void pci_pwrctrl_destroy_devices(struct device *parent) { }
+static inline int pci_pwrctrl_power_on_devices(struct device *parent) { return 0; }
+static void pci_pwrctrl_power_off_devices(struct device *parent) { }
 #endif
 #endif /* __PCI_PWRCTRL_H__ */

-- 
2.48.1



