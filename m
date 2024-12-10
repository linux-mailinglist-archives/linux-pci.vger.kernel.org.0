Return-Path: <linux-pci+bounces-18021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B6D9EAD41
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 10:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12F728D3D0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687BE215766;
	Tue, 10 Dec 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6nZcE9B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F112153CC;
	Tue, 10 Dec 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824556; cv=none; b=LxBgGvU08K8KkfmNtljuw2cB4Ue3RRKoOiN4Ad9LJJk/7nF4PYMaP4dCutrYOKTlLFh1pP4AveKpocXeTvJIHuxCBJTAgdB3gKCZ1UvOMskqO2VLvDa/QPHa495mYOiscpPYxuAZL+wI2TgR4YHPOkUZup12g+h7IZ1/b7ukpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824556; c=relaxed/simple;
	bh=w7ObcIuKEghsnkCa7wv/ByiULJMUHu3xKFqobOW5nSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDjwOvmDCmgBWZZJQ72oPbs52lnnB3DkMJJiMuCZ5DIogsew7oFSMjSCltgiks49DU3Igmxp7cVyHv77jgwtIbSij/AylW54ccmKNpq7k4GMokAB9tyfQ9XmIWJbNR60cghRvVZ0ZlmDTFmuDm7+M7K0MibJMxolhph/Cc+Ftcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6nZcE9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B916BC4CEE4;
	Tue, 10 Dec 2024 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733824555;
	bh=w7ObcIuKEghsnkCa7wv/ByiULJMUHu3xKFqobOW5nSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U6nZcE9BIBIS9iqrco62bahxjaCNyiFxiclSsp8MAXUrW0hOfvTrN2ZLEkgdyNSZ2
	 KSUGWxGa5/uSBugxjz8U+DZ7JoaPQDVdYKJgHcPZNUO3nHAWONRc3tLBvVHTcczVWG
	 wSD0B30fEyy78sIcnnV/EmwKPGQn+847jCkgV5M7W5d8azmpXGR1myn4PZufWKw6d8
	 xyrhssdlgK5NTh82/cPzeP+LQCmPeSMCbEA2zevsWVHhXAPkEQJIqgeiOxSDT48lM2
	 dgXnbXt/ODYN6NyLFNPbcMInSru7RNs10I6YXaaWh1myLnup1TwRuOl/zKAn6XPC4+
	 4MgdUXqK3Elwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE58FE77182;
	Tue, 10 Dec 2024 09:55:55 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 10 Dec 2024 15:25:27 +0530
Subject: [PATCH 4/4] PCI/pwrctrl: Add pwrctrl driver for PCI Slots
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-pci-pwrctrl-slot-v1-4-eae45e488040@linaro.org>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
In-Reply-To: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Qiang Yu <quic_qianyu@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4981;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=YiO/Xkyr66zpr8ftXrJsgVMQidcdDYAQ3s8kybejH8U=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnWBAoSZbAO7NaYQtUqGwmqySbRc0IDno/0dpQV
 ko9F8LAGXSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ1gQKAAKCRBVnxHm/pHO
 9Q/8B/40OUYeHncAGg4SaeSyebHtqnHyoJPGUElGT6EWialymhoBEGsobAx92+JXAzxpOASf4rE
 c2lxg3v4VY1jcbui5Vdq8sCwn43x2g+ObBVIZe3qoae7GE2cPv5xqfibsLxvAO4e0ozdTx7TiPJ
 mVwhTMlJLC10JlWeNwn/Nim/85nzOrbbhAr+y5RfjwVaBAa+/Gfb3z4C6aqDM9Tg0XXr31OnWAw
 /bldwQX0teFk3ZgPt6o0sLzCAnQfhvJbKnT0nVCBotMsfLVYWtvjkC4atbW7iPPNapGSVzajM9l
 KkBaLkk5QSO88iBcvPSJxZQVbMawc4WiSA1cF72rd/LCXk+t
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



