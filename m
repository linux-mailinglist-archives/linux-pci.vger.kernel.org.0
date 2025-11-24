Return-Path: <linux-pci+bounces-41956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B671C81860
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 17:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C8514E1DBC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C523314B84;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdWWtbSB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EECC3148BB;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001264; cv=none; b=m+bWKSJrU88br/WYairvkbxEfzQr7e+yzorDQgq76wUqCO4Eroov3OoXUkG96nzd1tGlVw6EZSduTVgaZh+6AGedrrxVzG3wPf16sNRViKW3uVExOJAmBE0SogPwLYKo/ES09m3/A1CmPz+63M57hLwIDXytIRB3nvDtugqYKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001264; c=relaxed/simple;
	bh=2/wSjlYlmesfAG0/zAvXE+XbKKwCVNRs5QkoifeUpB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=siierCoVZANOAgsUjxNcCf8g5L0H/ZGReI20a1+wg3O4SDtCW6xNZ++vBNhzgezR6+p36p0a7pPc+N6Kw/SJJ+yqxZPA0Y7isriyvVHkkNUkKJkytXs8u2Q1bxq2j/lmcvide+F+1oBQIuNZcn3ayU3+s5aFr57O0kAYOSsZTms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdWWtbSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2408FC2BCB3;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764001264;
	bh=2/wSjlYlmesfAG0/zAvXE+XbKKwCVNRs5QkoifeUpB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kdWWtbSBrAJVZ5V4n/3cPF7R60EDNjhTCVwolPQAaR+jL+F+bEZm+dPq40mAUo5UR
	 JqUprs/4D9ABmetu9DV2pxVqW5lm21a8IYRIU6962f+XSt3kIwKqEup2nOCAJMcuCS
	 Ofia37m8ZziaNoGBRFKMAU9P+utyjEjWL5o/RMe5X9R1QQbn6bP2+gc6Rax+BeLKjM
	 f4TpAgIE5/rPgoAAR/exiP2dIZHuL6TbHIMeWhY4lkb+DsK1cc9qDyT8BGYBya14V8
	 ht3jaSQvKMOKmZ2CS5YP0n49EegSiN94slHO/NZ///IWr99AJqd3dGndTB3x6AXb/U
	 svrYULLRJtGtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB57CFD318;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 24 Nov 2025 21:50:47 +0530
Subject: [PATCH 4/5] PCI/pwrctrl: Add APIs to power on/off the pwrctrl
 devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-pci-pwrctrl-rework-v1-4-78a72627683d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6010;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=cTf/zTyNct49tnAIkI8rXW+P63X5Y4jjQ+JhAwnxQfc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJIXsO9rD/aqEW0RypVmV8irmgBjyoBahPFk8m
 tpgvqsSyHyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSSF7AAKCRBVnxHm/pHO
 9bpcB/4ziIXp+vpYF7OTtY8KxDXddG3PWy+86Gdi24L4BV/3N7YXekjVocK2ZxBfvnpa9wS/5J/
 pR001gLV4LGV8zzZj0iedAt/MKEno91JVxZ90a64ViJcZJsREG4meNY3MXh4sJMzvvbHA7t4JDH
 wFLLGZ1ZF4+CD8Lq5IaPqZxvCjMUXA2S7D5IFiY9Ed2vvuyZxbT6jBuu/1mYEmuAPzZ/TxA5S3z
 rb5IKvMpBcQX7m3RbhuR2nmA8ZVw5veX7IRofrfwNyZgoRSjPjvm5qH5FGekPy/fk2jSUGPvtAX
 91KzEafzULFaisrqcpQYuX8XOhVoPqVCMPUDlKHsPhOKbmb6
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
power_on() callbacks.

Similarly, pci_pwrctrl_power_off_devices() API powers off devices
recursively via their power_off() callbacks.

These APIs are expected to be called during the controller probe and
suspend/resume time to power on/off the devices. But before calling these
APIs, the pwrctrl devices should've been created beforehand using the
pci_pwrctrl_{create/destroy}_devices() APIs.

Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c  | 121 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-pwrctrl.h |   4 ++
 2 files changed, 125 insertions(+)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 6eca54e0d540..e0a0cf015bd0 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -65,6 +65,7 @@ void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
 {
 	pwrctrl->dev = dev;
 	INIT_WORK(&pwrctrl->work, rescan_work_func);
+	dev_set_drvdata(dev, pwrctrl);
 }
 EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
 
@@ -152,6 +153,126 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
 
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
+			dev_err(&pdev->dev, "driver is not bound\n");
+			ret = -EPROBE_DEFER;
+		} else {
+			ret = __pci_pwrctrl_power_on_device(&pdev->dev);
+		}
+		put_device(&pdev->dev);
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
+ * manner.
+ *
+ * Returns: 0 on success, negative error number on error.
+ */
+int pci_pwrctrl_power_on_devices(struct device *parent)
+{
+	struct device_node *np = parent->of_node;
+	int ret;
+
+	for_each_available_child_of_node_scoped(np, child) {
+		ret = pci_pwrctrl_power_on_device(child);
+		if (ret) {
+			pci_pwrctrl_power_off_devices(parent);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
+
+static void __pci_pwrctrl_power_off_device(struct device *dev)
+{
+	struct pci_pwrctrl *pwrctrl = dev_get_drvdata(dev);
+
+	if (!pwrctrl)
+		return;
+
+	return pwrctrl->power_off(pwrctrl);
+}
+
+static int pci_pwrctrl_power_off_device(struct device_node *np)
+{
+	struct platform_device *pdev;
+
+	for_each_available_child_of_node_scoped(np, child)
+		pci_pwrctrl_power_off_device(child);
+
+	pdev = of_find_device_by_node(np);
+	if (pdev) {
+		if (device_is_bound(&pdev->dev))
+			__pci_pwrctrl_power_off_device(&pdev->dev);
+
+		put_device(&pdev->dev);
+	}
+
+	return 0;
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
+ *
+ * Returns: 0 on success, negative error number on error.
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
 static int pci_pwrctrl_create_device(struct device_node *np, struct device *parent)
 {
 	struct platform_device *pdev;
diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
index 5590ffec0bea..1b77769eebbe 100644
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



