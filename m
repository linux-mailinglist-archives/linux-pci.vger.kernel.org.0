Return-Path: <linux-pci+bounces-44905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B9ED22D53
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CF5F3018C8E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBB232BF32;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkTx22L1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5757632ABCA;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462152; cv=none; b=iop2IhXW7NWX3jXJzuv9aL3rjXGWw3yAo1LAlkDRrsYzB6jbPY56DDjCx1da1sxI2RFV4LmVzsmPE9pFsgKJKAwYqEyka2lUo43nH6aS8xW7gAq7+aow3vEMro9rr/h+RwylOcKpxa8zuSdZwepvnVr2lAfCOrPn5dKSZxy3xTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462152; c=relaxed/simple;
	bh=1J+JGwor0OpfhIeIG6sQY1IstZStAANGlk6jSMi2Smk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aa4hZenmAp+TZXv+3w8bJr8mBFlIIc7Z30uOvjAvOYy3g4HfMFPPFzuq8yozg/OKZTs5YnkNJpowbCDrMIw5j/VsqmDWptL5XQ3bKJWNo1a9bflTO1t1L+rqqZnCkWwT72CUMz+wpEtLt8rToI/GUQuvwvkeF5knZ+PYb4P2/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkTx22L1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4D27C19425;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462152;
	bh=1J+JGwor0OpfhIeIG6sQY1IstZStAANGlk6jSMi2Smk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WkTx22L1lvdemXtJzyBcoP2MkVitoi19DrWXt9rx390NPnifZ2F1zjFtez8Km3IyO
	 YjZz2s95rX+QJ1CSdZHQ7vXw6OAHJnUtg/lzwuK9cfPEY5wS+tfpqT/0VOG2lHoNOt
	 gsHdpTGuVhihzIPJe6B4c/96xMlZ4RpzgA1l+TypKGxIdyrl2VxjNIe98eS4hwsVWs
	 rrtDyEBqrZT/r1YJeCeYzBXnoWD8/VmzhzqtVbamnsPqGc31o2KdBEWhC+ZF66KGYs
	 BYgADNpEfh2pmCtCCDRjYLaKgX+KLMvNhS6zR9U9Sj1wHTHrpKY7p9Vi5KmBssrudc
	 hVnL2aRFLHzLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9BCD3CCBD;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:59:03 +0530
Subject: [PATCH v5 11/15] PCI/pwrctrl: Add APIs to power on/off pwrctrl
 devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-11-9d26da3ce903@oss.qualcomm.com>
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
 Chen-Yu Tsai <wenst@chromium.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6536;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=iUHY/BG9RFPUYk6k/gBm6wb7TkrbPDRIaVInGnjCGao=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdCOLzhDWjQprO8YEH+i0fHqG047B2d1mtHG
 qPE4unrBxGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQgAKCRBVnxHm/pHO
 9fG/B/sFrE1fjVZG5B1e9eu2iXh4So3R57nzWdYB3UcQ2KnfrX9vfl4pXOgMnW6spaZ5VtTLdmU
 9KmQsDVJIjU6OTdnif403hL7NS12juZFCZjUWOVMO9yNhXeZUpRPI4qgkUeglZFse5CAZGVXOYA
 mbeam85jrozTHMUZ5ICOM9k/cXXX9reAyEn0DeZf6RKj4JfTuYfjvBJUbB9V3T3SMnMkm72Vpfc
 1HFhn8NVs5BI39KFp8NwsYYrScsM7PyZl0UM5ZeTR+GvqYlEm9/gvaBV5ZEc/HdWiW1kYuYplLc
 KSVke+0PP9GucWIKIpDJGqjcYukoc2NBpP8FRjq5Hlhy5e4w
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

To fix bridge resource allocation issues when powering PCI bridges with the
pwrctrl driver, introduce APIs to explicitly power on and off all related
devices simultaneously.

Previously, the individual pwrctrl drivers powered on/off the PCI devices
autonomously, without any control from the controller drivers. But to
enforce ordering with respect to powering on the devices, these APIs will
power on/off all the devices at the same time.

The pci_pwrctrl_power_on_devices() API recursively scans the PCI child
nodes, makes sure that pwrctrl drivers are bound to devices, and calls
their power_on() callbacks. If any pwrctrl driver is not bound, it will
return -EPROBE_DEFER.

Similarly, pci_pwrctrl_power_off_devices() API powers off devices
recursively via their power_off() callbacks.

These APIs are expected to be called during the controller probe and
suspend/resume time to power on/off the devices. But before calling these
APIs, the pwrctrl devices should be created using the
pci_pwrctrl_{create/destroy}_devices() APIs.

Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
[bhelgaas: return early when !pdev and unindent, move ctx.power_on/off here]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctrl/core.c  | 130 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-pwrctrl.h |   4 ++
 2 files changed, 134 insertions(+)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index b423768cc477..fef5243d9445 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -65,6 +65,7 @@ void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
 {
 	pwrctrl->dev = dev;
 	INIT_WORK(&pwrctrl->work, rescan_work_func);
+	dev_set_drvdata(dev, pwrctrl);
 }
 EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
 
@@ -152,6 +153,135 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
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
+	if (!pdev)
+		return;
+
+	if (device_is_bound(&pdev->dev)) {
+		ret = __pci_pwrctrl_power_off_device(&pdev->dev);
+		if (ret)
+			dev_err(&pdev->dev, "Failed to power off device: %d", ret);
+	}
+
+	platform_device_put(pdev);
+}
+
+/**
+ * pci_pwrctrl_power_off_devices - Power off pwrctrl devices
+ *
+ * @parent: PCI host controller device
+ *
+ * Recursively traverse all pwrctrl devices for the devicetree hierarchy
+ * below the specified PCI host controller and power them off in a depth
+ * first manner.
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
+	if (!pdev)
+		return 0;
+
+	if (device_is_bound(&pdev->dev)) {
+		ret = __pci_pwrctrl_power_on_device(&pdev->dev);
+	} else {
+		/* FIXME: Use blocking wait instead of probe deferral */
+		dev_dbg(&pdev->dev, "driver is not bound\n");
+		ret = -EPROBE_DEFER;
+	}
+
+	platform_device_put(pdev);
+
+	return ret;
+}
+
+/**
+ * pci_pwrctrl_power_on_devices - Power on pwrctrl devices
+ *
+ * @parent: PCI host controller device
+ *
+ * Recursively traverse all pwrctrl devices for the devicetree hierarchy
+ * below the specified PCI host controller and power them on in a depth
+ * first manner. On error, all powered on devices will be powered off.
+ *
+ * Return: 0 on success, -EPROBE_DEFER if any pwrctrl driver is not bound, an
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
 static int pci_pwrctrl_create_device(struct device_node *np,
 				     struct device *parent)
 {
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



