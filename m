Return-Path: <linux-pci+bounces-44904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C993AD22D65
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B53D130217A3
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A45A32BF22;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dmu+H+gI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2E32AADB;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462152; cv=none; b=ijbQByOetZeX6ELHGRDLStQOHosbYZf24Vj5AVyZy1qofP2TUjmNRJ/N81zFrf82RDDEKeT0r8nSewTFa9gNkSTiAwePWW/qGUEzkcmyF53WkZPCjoGvDX9KcJbBpbZA543IN/kzdrTY4gDF5WJfHfVv+CaiY2470vMQj5NL8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462152; c=relaxed/simple;
	bh=mOJnKgtNcAObnpi6601dL+oH8Pj+/qmWfKgQlqUjZt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTUC77+Mw0gbti8xnwjBCvuLMykFCJyzLhdOR6vSQhuQPJuHseqUP14OKPPisu0FN7G+ZwEEAky9h4+OZ/5H8yhCMP8iyfBQeb5ndnAeMSG2g9Mz6LY24s1yY8eU6qy3j1jOF1wne6UeM7jbFhw83hdmvAzU5TYOwHPQGTXY6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dmu+H+gI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9417C19424;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462151;
	bh=mOJnKgtNcAObnpi6601dL+oH8Pj+/qmWfKgQlqUjZt0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Dmu+H+gISxb1jkW5rgONHkLEebGLTHRml2iX0Y2aoFR/KYivx9s2C6TYBJE+aqoCO
	 N0yyNFO+IGHgYVoPwtOibzSO+9FoDtDFNQM9OWwj6+Dp3grpK6vecbvh4ACJsqRfhX
	 ZJ8ktiJV66a5Qk5oDl9zJVfFKp7Y+uDzKwmijG0H5xAK7fyTQAJf8PrqjKH/Pxn1FZ
	 R1hYVsVAWKFVftxQse/XP/9HnQqyFoFBwC8Du2x03amfHAj6gG7Sm/V01hbC7N7Knj
	 1AKGdQVFtDNxosWgb136slBee4tPHYUQ1EDKLQmNnEqB5HxMaZCZcpOf3OReVWWOE+
	 NNKSpZ34jxcMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22F9D3CCB9;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:59:02 +0530
Subject: [PATCH v5 10/15] PCI/pwrctrl: Add APIs to create, destroy pwrctrl
 devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-10-9d26da3ce903@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7430;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ivayJzSZMxVd5tA6A14uF0UbVYPc8Eq8PFKm9u9xxik=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdCzEjM8x6qk7TQhEP6PdeQ6HpzVgtunr5ua
 30jubwvfS+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQgAKCRBVnxHm/pHO
 9UfoB/9eUvp1niqiLVXZ3tOhM6jT3Zt23VD67O/A2g9/Auk/1aUI/OYvEiTDqZ7f2HToDL2DHlM
 N4EXEmQfttbUI2+P8BYxllo1hBAbXguS9Vi6QrjJJZ24qweVw5eW4BKrBL4AeRFb4/lx4MTq14W
 GyQpD3dJWVRClfFkIxxKziFu7z+avZ66DdpPNSZo7oUvMAMtHaSOh942CABfxn1i2xpZrp7NqG/
 zj7WzejqHIvGGyxWVdO2F4JDzM9NMssrXJT+Dnj+gX/FEML0r2qieRaFMzr3zqDh3NByyf2U8MU
 QgQ/xmi7qSptRQ9pnR8spi/RrjWbslZYfcVm+Z4FkoB1E0iJ
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
requires pwrctrl support and the pwrctrl driver is not available during
the pwrctrl device creation, its enumeration will be skipped during the
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
device creation time to work around these issues.

Introduce new APIs to explicitly create and destroy pwrctrl devices from
controller drivers by recursively scanning the PCI child nodes of the
controller. These APIs allow creating pwrctrl devices based on the original
criteria and are intended to be called during controller probe and removal.

These APIs, together with the upcoming APIs for power on/off will allow the
controller drivers to power on all the devices before starting the initial
bus scan, thereby solving the resource allocation issue.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
[mani: splitted the patch, cleaned up the code, and rewrote description]
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pci/of.c            |   1 +
 drivers/pci/pwrctrl/core.c  | 114 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-pwrctrl.h |   8 +++-
 3 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..9bb5f258759b 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -867,6 +867,7 @@ bool of_pci_supply_present(struct device_node *np)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(of_pci_supply_present);
 
 #endif /* CONFIG_PCI */
 
diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 6bdbfed584d6..b423768cc477 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -3,14 +3,21 @@
  * Copyright (C) 2024 Linaro Ltd.
  */
 
+#define dev_fmt(fmt) "pwrctrl: " fmt
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
@@ -145,6 +152,113 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
 
+static int pci_pwrctrl_create_device(struct device_node *np,
+				     struct device *parent)
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
+		platform_device_put(pdev);
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
+ * @parent: PCI host controller device
+ *
+ * Recursively create pwrctrl devices for the devicetree hierarchy below
+ * the specified PCI host controller in a depth first manner. On error, all
+ * created devices will be destroyed.
+ *
+ * Return: 0 on success, negative error number on error.
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
+	platform_device_put(pdev);
+
+	of_node_clear_flag(np, OF_POPULATED);
+}
+
+/**
+ * pci_pwrctrl_destroy_devices - Destroy pwrctrl devices
+ *
+ * @parent: PCI host controller device
+ *
+ * Recursively destroy pwrctrl devices for the devicetree hierarchy below
+ * the specified PCI host controller in a depth first manner.
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
index 435b822c841e..44f66872d090 100644
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



