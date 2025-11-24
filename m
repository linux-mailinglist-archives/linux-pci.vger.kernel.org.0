Return-Path: <linux-pci+bounces-41961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C266C81890
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 17:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39623A695F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7F43168E1;
	Mon, 24 Nov 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX4AFWpI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA93164CE;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001265; cv=none; b=mjzxuBguVS3sLYMZIFGDQWtTpFehBY39d4Kc/KWAQmep+O0PxYQkoAcJmjJr07qauDNN+OIdOlRPnrrH9topYPFyiE+t1fYMs9Dg6ava579x6h5b45iE/N2OZxwypdVHs4c2QuG8ThZ3Q9wZq2S63c2zEpr5MbfsPJsSdLw4Kts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001265; c=relaxed/simple;
	bh=zco2/BCviUfYxQpIBiOf3uIUke+Ln/UupZMf14cmwU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dzNY/IhteYH3b1+Vs98qzbc4diCLP2keo0EEwudHZAqtIPZu1viacPa6qN250e8ZHodGiwYPMFpzz4CTW2BX6FmWUG7KllRft2a5JpXAqbZyn9y9ZJHo5qRN0x53hWoAsr3NGlqpwbJu2FIJ6dB0KA4T0Mc52nS0nt/xGrBHRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tX4AFWpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16375C2BC9E;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764001264;
	bh=zco2/BCviUfYxQpIBiOf3uIUke+Ln/UupZMf14cmwU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tX4AFWpI+CXU4SRPf0DAt9f7TVgF1FSZXjXwxbcwV+3vaV93QOAzv3Qu2HGQLX4Ed
	 m6w1J2W6SdVlXQ2i59MVB4aAQ3SR3kIqehaLeHgY9jt/66J0tzuCVYiICmdqqNSdvE
	 GG100GfK6C6uiRn3dazTxwb8NZz7PG0xpwGGpqLh32zitq8gEJ+46r2E9Vteyn1PKh
	 ZbByLWxUO8ldnMRNq4Hgv7/3XzaNe9K5SwinuSHHn53qs7Sd3s7ra2gX1wRqKZ7bWx
	 MvvN0taObU71dGfCmNRNn3Td6e3BtBSoXIPorkZZjUhkB5sY5oL/LxsDvi16zBDYW3
	 vXQvBxK+awPFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F61CFD340;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 24 Nov 2025 21:50:46 +0530
Subject: [PATCH 3/5] PCI/pwrctrl: Add APIs for explicitly creating and
 destroying pwrctrl devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-pci-pwrctrl-rework-v1-3-78a72627683d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6941;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=/6Zt/61i3oECj3Xro/3od290T1IlBj1jROy08O6jXW0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJIXsL9zARIZVQxKtfxwg02B6fFzC0iVDfYUnq
 jGgerdkXYuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSSF7AAKCRBVnxHm/pHO
 9Q/NB/4n0J8WQEPs8xDJLfR+Aau9u8lhR55Y2gEhf6uhKpyRpZVQKC14U2+KSAWTLu96V6SCiUd
 nS5P3qha4D49yPFBWTbvoV0YJmlqVwOp1e24J51X+qroPmMl7uRRI9+7aCg9+aSXT1coTTQC0cT
 ZrUG7eU/rrPMVF9ZOEsZCS+x0C41O0j/c2qfiKKQViebMfEYCH9Eq61DLQz+c5JeCdvtOoyhHlN
 /fNTuYDXN7lRNUlTuDasE/1FsmEce2malKF9ZxxoQhmb4h4xIM+z+8UXsFyWoY4Qj8e/6fyQQWm
 SWobMaJAE+iV5nOxNIaiLqxnATDrMnIeg+9MsP6a0SbJwida
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Previously, the PCI core created pwrctrl devices during pci_scan_device()
on its own and then skipped enumeration of those devices, hoping the
pwrctrl driver would power them on and trigger a bus rescan.

This approach works for endpoint devices directly connected to Root Ports,
but it fails for PCIe switches acting as bus extenders. When the switch
requires pwrctrl support, and the pwrctrl driver is not available during
the pwrctrl device creation, it's enumeration will be skipped during the
initial PCI bus scan.

This premature scan leads the PCI core to allocate resources (bridge
windows, bus numbers) for the upstream bridge based on available downstream
buses at scan time. For non-hotplug capable bridges, PCI core typically
allocates resources based on the number of buses available during the
initial bus scan, which happens to be just one if the switch is not powered
on and enumerated at that time. When the switch gets enumerated later on,
it will fail due to the lack of upstream resources.

As a result, a PCIe switch powered on by the pwrctrl driver cannot be
reliably enumerated currently. Either the switch has to be enabled in the
bootloader or the switch pwrctrl driver has to be loaded during the pwrctrl
device creation time to workaround these issues.

This commit introduces new APIs to explicitly create and destroy pwrctrl
devices from controller drivers by recursively scanning the PCI child nodes
of the controller. These APIs allow creating pwrctrl devices based on the
original criteria and are intended to be called during controller probe and
removal.

These APIs, together with the upcoming APIs for power on/off will allow the
controller drivers to power on all the devices before starting the initial
bus scan, thereby solving the resource allocation issue.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
[mani: splitted the patch, cleaned up the code, and rewrote description]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c  | 112 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-pwrctrl.h |   8 +++-
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 6bdbfed584d6..6eca54e0d540 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -3,14 +3,21 @@
  * Copyright (C) 2024 Linaro Ltd.
  */
 
+#define dev_fmt(fmt) "Pwrctrl: " fmt
+
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/pci-pwrctrl.h>
+#include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
+#include "../pci.h"
+
 static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 			      void *data)
 {
@@ -145,6 +152,111 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
 
+static int pci_pwrctrl_create_device(struct device_node *np, struct device *parent)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	for_each_available_child_of_node_scoped(np, child) {
+		ret = pci_pwrctrl_create_device(child, parent);
+		if (ret)
+			return ret;
+	}
+
+	/* Bail out if the platform device is already available for the node */
+	pdev = of_find_device_by_node(np);
+	if (pdev) {
+		put_device(&pdev->dev);
+		return 0;
+	}
+
+	/*
+	 * Sanity check to make sure that the node has the compatible property
+	 * to allow driver binding.
+	 */
+	if (!of_property_present(np, "compatible"))
+		return 0;
+
+	/*
+	 * Check whether the pwrctrl device really needs to be created or not.
+	 * This is decided based on at least one of the power supplies being
+	 * defined in the devicetree node of the device.
+	 */
+	if (!of_pci_supply_present(np)) {
+		dev_dbg(parent, "Skipping OF node: %s\n", np->name);
+		return 0;
+	}
+
+	/* Now create the pwrctrl device */
+	pdev = of_platform_device_create(np, NULL, parent);
+	if (!pdev) {
+		dev_err(parent, "Failed to create pwrctrl device for node: %s\n", np->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * pci_pwrctrl_create_devices - Create pwrctrl devices
+ *
+ * @parent: Parent PCI device for which the pwrctrl devices need to be created.
+ *
+ * This function recursively creates pwrctrl devices for the child nodes
+ * of the specified PCI parent device in a depth first manner.
+ *
+ * Returns: 0 on success, negative error number on error.
+ */
+int pci_pwrctrl_create_devices(struct device *parent)
+{
+	int ret;
+
+	for_each_available_child_of_node_scoped(parent->of_node, child) {
+		ret = pci_pwrctrl_create_device(child, parent);
+		if (ret) {
+			pci_pwrctrl_destroy_devices(parent);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_pwrctrl_create_devices);
+
+static void pci_pwrctrl_destroy_device(struct device_node *np)
+{
+	struct platform_device *pdev;
+
+	for_each_available_child_of_node_scoped(np, child)
+		pci_pwrctrl_destroy_device(child);
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return;
+
+	of_device_unregister(pdev);
+	put_device(&pdev->dev);
+
+	of_node_clear_flag(np, OF_POPULATED);
+}
+
+/**
+ * pci_pwrctrl_destroy_devices - Destroy pwrctrl devices
+ *
+ * @parent: Parent PCI device for which the pwrctrl devices need to be destroyed.
+ *
+ * This function recursively destroys pwrctrl devices for the child nodes
+ * of the specified PCI parent device in a depth first manner.
+ */
+void pci_pwrctrl_destroy_devices(struct device *parent)
+{
+	struct device_node *np = parent->of_node;
+
+	for_each_available_child_of_node_scoped(np, child)
+		pci_pwrctrl_destroy_device(child);
+}
+EXPORT_SYMBOL_GPL(pci_pwrctrl_destroy_devices);
+
 MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
 MODULE_DESCRIPTION("PCI Device Power Control core driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
index bd0ee9998125..5590ffec0bea 100644
--- a/include/linux/pci-pwrctrl.h
+++ b/include/linux/pci-pwrctrl.h
@@ -54,5 +54,11 @@ int pci_pwrctrl_device_set_ready(struct pci_pwrctrl *pwrctrl);
 void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl);
 int devm_pci_pwrctrl_device_set_ready(struct device *dev,
 				     struct pci_pwrctrl *pwrctrl);
-
+#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
+int pci_pwrctrl_create_devices(struct device *parent);
+void pci_pwrctrl_destroy_devices(struct device *parent);
+#else
+static inline int pci_pwrctrl_create_devices(struct device *parent) { return 0; }
+static void pci_pwrctrl_destroy_devices(struct device *parent) { }
+#endif
 #endif /* __PCI_PWRCTRL_H__ */

-- 
2.48.1



