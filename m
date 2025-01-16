Return-Path: <linux-pci+bounces-19969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C89A13BD4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553EA3AABC3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7FF22BAB8;
	Thu, 16 Jan 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUq4w+5w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F722B8C1;
	Thu, 16 Jan 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036560; cv=none; b=XYpPUFeVHPA0AA52hGIm/tqwraH3WV9OvQfTN6nafpZq4o5UAPHhJh5USwow433KzIF0bsmO7FUxNpe8YSBEEB8I9a+CuBT80x64Wxkoy0+NJ7JGoCFVqNZpvm4Yrb48vIw3qexhIyDNClE9iCCm538rigQWvHp+tPIdVCIWaYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036560; c=relaxed/simple;
	bh=AC4CmZODc6zttOyIPBfDblh9cJnGUWWU4vNPYxPmyso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nn+Nyu1k4pIR5AQNg195r4Hpw5vDuuW0HjGbb5cf1WIk5Nh1vT6utDcMqsUSBLItnQEAO7YNvs4M/Z3NSL06GONSTAbAPxo5a610Yn16xf+Czi8Btnh53xzxN0/gp63/Pg140xttrL0RNFyTK+Dt6T6ibCsskPdJjw5wH+xVpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUq4w+5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C178CC4CEEA;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737036559;
	bh=AC4CmZODc6zttOyIPBfDblh9cJnGUWWU4vNPYxPmyso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QUq4w+5wUafwqxq/SxP2IFCy85dwYS/LDHLyjAwzlI53FTTN8PQpJjyi/ojLVmwMe
	 08mnX36kZoMQTex19OPJ7X0hHXR24Fe4rtTaJvB3EczjcHzCPFRvUe+QRDsYFGlPS9
	 JvVYEEDdQqqm2T1XrL2H6bKkPIldRLSiHENkbXBgqBpEg93GMLz+PtqTQ2Zy07duOv
	 Q/VzWFxdk2M51S8vbtfu7W5LApQ2rU9NJi9DPbys1RVFGytjkwbqkqsYYKjs4oPBmh
	 cOyXDD2iyQ/NQ4fnDLf+Y7/ZRmXsp2eh165OH8JXQkMtGxD00xdPI2DMkRN+FgJPB+
	 bv8HYnHRmHo9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76B2C02188;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 16 Jan 2025 19:39:15 +0530
Subject: [PATCH v3 5/5] PCI/pwrctrl: Add pwrctrl driver for PCI Slots
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-pci-pwrctrl-slot-v3-5-827473c8fbf4@linaro.org>
References: <20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org>
In-Reply-To: <20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5046;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=5dX65BdkoJK96uXxbW3egypDqFuEy1NtN49QNZGGNsE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBniRMMWkODI5NUgHn2Ssnt1o4GLSkku/dl94QRo
 TODRrTW4PKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ4kTDAAKCRBVnxHm/pHO
 9Yx3CACMKjxlFIJfTMv23OFQLi+Grgf9xrvD056zzNcWcLdo+lNbQATb1EnuBE5VFVW4BoktQ7H
 z+UAocW4cgJfOnf4ne6Agm/pbwVlp8C2YfnfHsN55qiv5XAPA43aMubE84G6e/mglisNgSq8AkT
 TJ5zKiCk5K3ctQTlTWU4CAMyt02sejbEkcnzHfRYdmLfhm1iflY4D+G+e276tsUKfU4/LyJL0Ex
 QBtafx/65r5C5gQtAL6Ehwo/7MxLmbG41LOsuTpm7UE5awfXwRL89ve0r1Xoqdnmjfeuq/GT0ur
 5dgIV8COa8NFjjL9T+TGJKLXvPE0VrR9l5jCsypVxPlSbzkP
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This driver is used to control the power state of the devices attached to
the PCI slots. Currently, it controls the voltage rails of the PCI slots
defined in the devicetree node of the root port.

The voltage rails for PCI slots are documented in the dt-schema:
https://github.com/devicetree-org/dt-schema/blob/v2024.11/dtschema/schemas/pci/pci-bus-common.yaml#L153

Since this driver has to work with different kind of slots (x{1/4/8/16}
PCIe, Mini PCIe, PCI etc...), the driver is using the
of_regulator_bulk_get_all() API to obtain the voltage regulators defined
in the DT node, instead of hardcoding them. The DT node of the root port
should define the relevant supply properties corresponding to the voltage
rails of the PCI slot.

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pwrctrl/Kconfig  | 11 ++++++
 drivers/pci/pwrctrl/Makefile |  3 ++
 drivers/pci/pwrctrl/slot.c   | 93 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index 54589bb2403b..990cab67d413 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -10,3 +10,14 @@ config PCI_PWRCTL_PWRSEQ
 	tristate
 	select POWER_SEQUENCING
 	select PCI_PWRCTL
+
+config PCI_PWRCTL_SLOT
+	tristate "PCI Power Control driver for PCI slots"
+	select PCI_PWRCTL
+	help
+	  Say Y here to enable the PCI Power Control driver to control the power
+	  state of PCI slots.
+
+	  This is a generic driver that controls the power state of different
+	  PCI slots. The voltage regulators powering the rails of the PCI slots
+	  are expected to be defined in the devicetree node of the PCI bridge.
diff --git a/drivers/pci/pwrctrl/Makefile b/drivers/pci/pwrctrl/Makefile
index 75c7ce531c7e..ddfb12c5aadf 100644
--- a/drivers/pci/pwrctrl/Makefile
+++ b/drivers/pci/pwrctrl/Makefile
@@ -4,3 +4,6 @@ obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctrl-core.o
 pci-pwrctrl-core-y			:= core.o
 
 obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctrl-pwrseq.o
+
+obj-$(CONFIG_PCI_PWRCTL_SLOT)		+= pci-pwrctl-slot.o
+pci-pwrctl-slot-y			:= slot.o
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
new file mode 100644
index 000000000000..18becc144913
--- /dev/null
+++ b/drivers/pci/pwrctrl/slot.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pci-pwrctrl.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+struct pci_pwrctrl_slot_data {
+	struct pci_pwrctrl ctx;
+	struct regulator_bulk_data *supplies;
+	int num_supplies;
+};
+
+static void devm_pci_pwrctrl_slot_power_off(void *data)
+{
+	struct pci_pwrctrl_slot_data *slot = data;
+
+	regulator_bulk_disable(slot->num_supplies, slot->supplies);
+	regulator_bulk_free(slot->num_supplies, slot->supplies);
+}
+
+static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
+{
+	struct pci_pwrctrl_slot_data *slot;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	slot = devm_kzalloc(dev, sizeof(*slot), GFP_KERNEL);
+	if (!slot)
+		return -ENOMEM;
+
+	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
+					&slot->supplies);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "Failed to get slot regulators\n");
+		return ret;
+	}
+
+	slot->num_supplies = ret;
+	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
+		goto err_regulator_free;
+	}
+
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
+				       slot);
+	if (ret)
+		goto err_regulator_disable;
+
+	pci_pwrctrl_init(&slot->ctx, dev);
+
+	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register pwrctrl driver\n");
+
+	return 0;
+
+err_regulator_disable:
+	regulator_bulk_disable(slot->num_supplies, slot->supplies);
+err_regulator_free:
+	regulator_bulk_free(slot->num_supplies, slot->supplies);
+
+	return ret;
+}
+
+static const struct of_device_id pci_pwrctrl_slot_of_match[] = {
+	{
+		.compatible = "pciclass,0604",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pci_pwrctrl_slot_of_match);
+
+static struct platform_driver pci_pwrctrl_slot_driver = {
+	.driver = {
+		.name = "pci-pwrctrl-slot",
+		.of_match_table = pci_pwrctrl_slot_of_match,
+	},
+	.probe = pci_pwrctrl_slot_probe,
+};
+module_platform_driver(pci_pwrctrl_slot_driver);
+
+MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
+MODULE_DESCRIPTION("Generic PCI Power Control driver for PCI Slots");
+MODULE_LICENSE("GPL");

-- 
2.25.1



