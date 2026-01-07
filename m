Return-Path: <linux-pci+bounces-44193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51222CFE495
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 15:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B4E0300DA43
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA30333424;
	Wed,  7 Jan 2026 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPzz7upi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD906331A46;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795086; cv=none; b=Z4j0Tynk6wPb5MOEDjdpkn65R76hY7R2ETySdNkIMOEmggICORVoQ3Jw45j+jvJz4qYk4ziqfqaMAoL5KZanBW1RR9wwARQ4v8uAaf1TtVWxARDNuOLBlR/hv7DT+w3DbgUs4Ybp8dl9JIL/qkPfxIiVIEmVvoydSK2kec1STds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795086; c=relaxed/simple;
	bh=XwVyKvloCickKIupGifF7yuIjrVZYEDak/SyKG5qnog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFwnQ83rGzzkrunz7umQL4leYpIC3e+KegElF6ioRuM61unKChBApFzEqRchDcGDMhNgC5M8Dapi2Fol9U6s98gdJQH89jjZZ2kOA5Gp1+DMPToe0lwwxpSRRBkaMU8ogYvHQWO79xcFwFPxKwfNrzI03AwRhD4fKxCPfT/LewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPzz7upi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A124C2BC9E;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795086;
	bh=XwVyKvloCickKIupGifF7yuIjrVZYEDak/SyKG5qnog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XPzz7upi6wknkQZun8ZNiHm1ANCzjoOj+i0yX6AKzSVM1f4E3uSXclLvAyMBgBXk3
	 yPXbxud9WAwO4n0RxOKXLQLzxRTWF9pkPL5ZLCQs0G1ax1PAqPOe4o9TcLTrtwmbQ0
	 lsIaKIFzWbVuvtfRM/oNmd4nRPmtOdB8Lfl52Ppz+EtoLIGHurYdMA5tFs8/zL+kH2
	 xErHyz5DplNX/u72rN697/kaC/ktmPbctElorhT/JYlkbBOg7qZMVBiIVB7ax6idwZ
	 lt2V9USUD0aKtAvx3MqmP4nbuA1jfKayZCpZUUDRgf6VR9oRGUfho8nSwXDm0HucrH
	 VpuKm0krHzIAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109DFCFD647;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 07 Jan 2026 19:41:27 +0530
Subject: [PATCH v5 5/5] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-pci-m2-v5-5-8173d8a72641@oss.qualcomm.com>
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
In-Reply-To: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, linux-ide@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7839;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ozwbSbXg0129q31uwPEZPEFupIS0sT29S7CybwHBuR4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpXmmMOKotm7Invr6pw7wYUmqpa9qZHY6R8kuiM
 ulDavXHnAiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaV5pjAAKCRBVnxHm/pHO
 9RL+B/44vHuZPYOwFq3QIVtLc7E3gvXBbgTII/xat+kENiTaxYW8FEA88uclERV9DgCEX+zdZNy
 IWP3wRVTnE6PnIW8mFtbiHBlBOYTstVy8X6PK66Pepv50/q/EB1AzMzk4/fFXP6xCsCwLcR8fsg
 cjY7/cdjQ2HtETW5JRLnFQE6B3amVv9ItkxCs4G7CyEd+UQPtE+4GTYTc2095KSn6qpMKzDrHbR
 Y3ZWivfppB15ss9DoN5E0zLW55IkV72ZUs1Cd2D1eb8m2emjy1rmvMuqECCWlKeZwoH1WZ5YURM
 g//ZwzmwXLuoZcJFGa1/R9e+bHfBaLjbDF6/P2JesHumLoNF
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

This driver is used to control the PCIe M.2 connectors of different
Mechanical Keys attached to the host machines and supporting different
interfaces like PCIe/SATA, USB/UART etc...

Currently, this driver supports only the Mechanical Key M connectors with
PCIe interface. The driver also only supports driving the mandatory 3.3v
and optional 1.8v power supplies. The optional signals of the Key M
connectors are not currently supported.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 MAINTAINERS                               |   7 ++
 drivers/power/sequencing/Kconfig          |   8 ++
 drivers/power/sequencing/Makefile         |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c | 169 ++++++++++++++++++++++++++++++
 4 files changed, 185 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..2eb7b6d26573 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20791,6 +20791,13 @@ F:	Documentation/driver-api/pwrseq.rst
 F:	drivers/power/sequencing/
 F:	include/linux/pwrseq/
 
+PCIE M.2 POWER SEQUENCING
+M:	Manivannan Sadhasivam <mani@kernel.org>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
+F:	drivers/power/sequencing/pwrseq-pcie-m2.c
+
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index 280f92beb5d0..f5fff84566ba 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -35,4 +35,12 @@ config POWER_SEQUENCING_TH1520_GPU
 	  GPU. This driver handles the complex clock and reset sequence
 	  required to power on the Imagination BXM GPU on this platform.
 
+config POWER_SEQUENCING_PCIE_M2
+	tristate "PCIe M.2 connector power sequencing driver"
+	depends on OF || COMPILE_TEST
+	help
+	  Say Y here to enable the power sequencing driver for PCIe M.2
+	  connectors. This driver handles the power sequencing for the M.2
+	  connectors exposing multiple interfaces like PCIe, SATA, UART, etc...
+
 endif
diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
index 96c1cf0a98ac..0911d4618298 100644
--- a/drivers/power/sequencing/Makefile
+++ b/drivers/power/sequencing/Makefile
@@ -5,3 +5,4 @@ pwrseq-core-y				:= core.o
 
 obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)	+= pwrseq-qcom-wcn.o
 obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) += pwrseq-thead-gpu.o
+obj-$(CONFIG_POWER_SEQUENCING_PCIE_M2)	+= pwrseq-pcie-m2.o
diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
new file mode 100644
index 000000000000..e01e19123415
--- /dev/null
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
+ */
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pwrseq/provider.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+struct pwrseq_pcie_m2_pdata {
+	const struct pwrseq_target_data **targets;
+};
+
+struct pwrseq_pcie_m2_ctx {
+	struct pwrseq_device *pwrseq;
+	struct device_node *of_node;
+	const struct pwrseq_pcie_m2_pdata *pdata;
+	struct regulator_bulk_data *regs;
+	size_t num_vregs;
+	struct notifier_block nb;
+};
+
+static int pwrseq_pcie_m2_m_vregs_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
+}
+
+static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return regulator_bulk_disable(ctx->num_vregs, ctx->regs);
+}
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_vregs_unit_data = {
+	.name = "regulators-enable",
+	.enable = pwrseq_pcie_m2_m_vregs_enable,
+	.disable = pwrseq_pcie_m2_m_vregs_disable,
+};
+
+static const struct pwrseq_unit_data *pwrseq_pcie_m2_m_unit_deps[] = {
+	&pwrseq_pcie_m2_vregs_unit_data,
+	NULL
+};
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
+	.name = "pcie-enable",
+	.deps = pwrseq_pcie_m2_m_unit_deps,
+};
+
+static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
+	.name = "pcie",
+	.unit = &pwrseq_pcie_m2_m_pcie_unit_data,
+};
+
+static const struct pwrseq_target_data *pwrseq_pcie_m2_m_targets[] = {
+	&pwrseq_pcie_m2_m_pcie_target_data,
+	NULL
+};
+
+static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_m_of_data = {
+	.targets = pwrseq_pcie_m2_m_targets,
+};
+
+static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
+				 struct device *dev)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	struct device_node *endpoint __free(device_node) = NULL;
+
+	/*
+	 * Traverse the 'remote-endpoint' nodes and check if the remote node's
+	 * parent matches the OF node of 'dev'.
+	 */
+	for_each_endpoint_of_node(ctx->of_node, endpoint) {
+		struct device_node *remote __free(device_node) =
+				of_graph_get_remote_port_parent(endpoint);
+		if (remote && (remote == dev_of_node(dev)))
+			return PWRSEQ_MATCH_OK;
+	}
+
+	return PWRSEQ_NO_MATCH;
+}
+
+static void pwrseq_pcie_free_resources(void *data)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = data;
+
+	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+}
+
+static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwrseq_pcie_m2_ctx *ctx;
+	struct pwrseq_config config = {};
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->of_node = of_node_get(dev->of_node);
+	ctx->pdata = device_get_match_data(dev);
+	if (!ctx->pdata)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to obtain platform data\n");
+
+	/*
+	 * Currently, of_regulator_bulk_get_all() is the only regulator API that
+	 * allows to get all supplies in the devicetree node without manually
+	 * specifying them.
+	 */
+	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev), &ctx->regs);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to get all regulators\n");
+
+	ctx->num_vregs = ret;
+
+	ret = devm_add_action_or_reset(dev, pwrseq_pcie_free_resources, ctx);
+	if (ret)
+		return ret;
+
+	config.parent = dev;
+	config.owner = THIS_MODULE;
+	config.drvdata = ctx;
+	config.match = pwrseq_pcie_m2_match;
+	config.targets = ctx->pdata->targets;
+
+	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
+	if (IS_ERR(ctx->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
+				     "Failed to register the power sequencer\n");
+
+	return 0;
+}
+
+static const struct of_device_id pwrseq_pcie_m2_of_match[] = {
+	{
+		.compatible = "pcie-m2-m-connector",
+		.data = &pwrseq_pcie_m2_m_of_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pwrseq_pcie_m2_of_match);
+
+static struct platform_driver pwrseq_pcie_m2_driver = {
+	.driver = {
+		.name = "pwrseq-pcie-m2",
+		.of_match_table = pwrseq_pcie_m2_of_match,
+	},
+	.probe = pwrseq_pcie_m2_probe,
+};
+module_platform_driver(pwrseq_pcie_m2_driver);
+
+MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>");
+MODULE_DESCRIPTION("Power Sequencing driver for PCIe M.2 connector");
+MODULE_LICENSE("GPL");

-- 
2.48.1



