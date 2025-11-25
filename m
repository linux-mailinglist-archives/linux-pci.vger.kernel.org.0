Return-Path: <linux-pci+bounces-42058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31047C858B6
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61B73B6068
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E752329E7D;
	Tue, 25 Nov 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqQ8izpo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC353271E8;
	Tue, 25 Nov 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081912; cv=none; b=utpVDjNWPohFNHDdcrQ3Z/m4vaIJMT5/KfgdNcZNY9iz/4KhoMpNO+D8orKdt5ocqNeONWXfXLQbnMnaBmnKc8rg34z4EVUkyLnG/PwHvu/7pJFOzD1ZcXG7fn5xBtaN388Il6csQSPmzsyIGcB4ROopD74HUaM46YI9EdTjxXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081912; c=relaxed/simple;
	bh=uVTeK5QXYJAKEXrVJHIu2uAlEF+bu5ja7nlz/3qqyE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GRnmxNJkRAtccyjl4nrbrsSdD8TPJ8GGHtT5crOW615gZw7VdiybISbMxeYak95eJ5or7BWgC6gmGg0CHyXBYx1XtdoD0PtDFpn8Dzj5cL5CHq/UkJXuEdDDUJghNAZ///diUAvO6tcipj7C6PA7ozEusuRs0J50NhjTjKP07bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqQ8izpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B69B5C116B1;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764081911;
	bh=uVTeK5QXYJAKEXrVJHIu2uAlEF+bu5ja7nlz/3qqyE4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fqQ8izpodQMCH+c8ZXRjf2Xmt6GXMylMvl6jYZdOMs2anrq86fp4RQM9uIkMopm5E
	 I9w5V0ke3VqPc5P33DB+LHWOiui4MU1R1AiJmXuLYE6ZMaU/1eI3n9UrMECl8I91u0
	 XQ5CCPp16HljY6Kvp+b7JTKkqIiuKKTYCzK5lEXt3a4f22W1LfH9chF6p4esIoHxQK
	 bPyYNNIfiaWMLorZFH9Le5fbHVRjYBTMNqUydxJkpKsMEAmAfCG9fL4aDm+AGn3u6i
	 iHvx0GGt1XxYtAogIwO2yT1ecH4CmHhi776NguShj0BFkjDuUbbmhPUJ6V+pOwPPam
	 eFLUOqzaBFwaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B30D0E6F4;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 25 Nov 2025 20:15:14 +0530
Subject: [PATCH v2 10/10] power: sequencing: pcie-m2: Add support for PCIe
 M.2 Key E connectors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-pci-m2-e-v2-10-32826de07cc5@oss.qualcomm.com>
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
In-Reply-To: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11211;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=icdy0cEagCCZDZk1SjAL+YixAm1oqa2r7NEVrGE9+pI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJcDzqQgUp84ba4lBRijiZIEuI2jtoWHH5P4lM
 f13O6DkJGiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSXA8wAKCRBVnxHm/pHO
 9YjfCACVhKLtculT1OE7fu9pKGjRV5hGxnTMVHrl+x80lI65ilz4P7vvOYX90oa5ZG8taVBj/kP
 g9p6YagWgCUF9pQ6jHglIcOtyiqH9S9iN0LMRd30hMNcnK3GwCuVjQ2108UG8mUFPqtVtd8MYZv
 7UOTggxKtT2S9T/1hOUPY1FUPbW8T9MnZxEpAe2sf/PPDTd+TAS1pF1aUAbsCqPx/w3eLVldozX
 AOxr6wwtUDiRSdpfc7o8vp0dLr7LnpkxbA6733M4Qo+1/WOqsJgbkvdGZDXORud258ZzO3NtiUr
 VuYb8c4rGhKwNiahaUYuYpBC3T3VyuChRs/ndWB8h3pIfniH
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add support for handling the power sequence of the PCIe M.2 Key E
connectors. These connectors are used to attach the Wireless Connectivity
devices to the host machine including combinations of WiFi, BT, NFC using
interfaces such as PCIe/SDIO for WiFi, USB/UART for BT and I2C for NFC.

Currently, this driver supports only the PCIe interface for WiFi and UART
interface for BT. The driver also only supports driving the 3.3v/1.8v power
supplies and W_DISABLE{1/2}# GPIOs. The optional signals of the Key E
connectors are not currently supported.

For supporting Bluetooth over the non-discoverable UART interface, the
driver currently creates the serdev interface after enumerating the PCIe
interface. This is mandatory since the device ID is only known after the
PCIe enumeration and the ID is used for creating the serdev device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/power/sequencing/Kconfig          |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c | 205 +++++++++++++++++++++++++++++-
 2 files changed, 199 insertions(+), 7 deletions(-)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index f5fff84566ba..29bd204319cc 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -38,6 +38,7 @@ config POWER_SEQUENCING_TH1520_GPU
 config POWER_SEQUENCING_PCIE_M2
 	tristate "PCIe M.2 connector power sequencing driver"
 	depends on OF || COMPILE_TEST
+	depends on PCI
 	help
 	  Say Y here to enable the power sequencing driver for PCIe M.2
 	  connectors. This driver handles the power sequencing for the M.2
diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 4835d099d967..c2cc129f6917 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -5,14 +5,17 @@
  */
 
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/of_platform.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/provider.h>
 #include <linux/regulator/consumer.h>
+#include <linux/serdev.h>
 #include <linux/slab.h>
 
 struct pwrseq_pcie_m2_pdata {
@@ -25,17 +28,20 @@ struct pwrseq_pcie_m2_ctx {
 	const struct pwrseq_pcie_m2_pdata *pdata;
 	struct regulator_bulk_data *regs;
 	size_t num_vregs;
+	struct gpio_desc *w_disable1_gpio;
+	struct gpio_desc *w_disable2_gpio;
 	struct notifier_block nb;
+	struct device *dev;
 };
 
-static int pwrseq_pcie_m2_m_vregs_enable(struct pwrseq_device *pwrseq)
+static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 
 	return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
 }
 
-static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
+static int pwrseq_pcie_m2_vregs_disable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 
@@ -44,18 +50,84 @@ static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
 
 static const struct pwrseq_unit_data pwrseq_pcie_m2_vregs_unit_data = {
 	.name = "regulators-enable",
-	.enable = pwrseq_pcie_m2_m_vregs_enable,
-	.disable = pwrseq_pcie_m2_m_vregs_disable,
+	.enable = pwrseq_pcie_m2_vregs_enable,
+	.disable = pwrseq_pcie_m2_vregs_disable,
 };
 
-static const struct pwrseq_unit_data *pwrseq_pcie_m2_m_unit_deps[] = {
+static const struct pwrseq_unit_data *pwrseq_pcie_m2_unit_deps[] = {
 	&pwrseq_pcie_m2_vregs_unit_data,
 	NULL
 };
 
+static int pwrseq_pci_m2_e_uart_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 0);
+}
+
+static int pwrseq_pci_m2_e_uart_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
+}
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data = {
+	.name = "uart-enable",
+	.deps = pwrseq_pcie_m2_unit_deps,
+	.enable = pwrseq_pci_m2_e_uart_enable,
+	.disable = pwrseq_pci_m2_e_uart_disable,
+};
+
+static int pwrseq_pci_m2_e_pcie_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 0);
+}
+
+static int pwrseq_pci_m2_e_pcie_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
+}
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
+	.name = "pcie-enable",
+	.deps = pwrseq_pcie_m2_unit_deps,
+	.enable = pwrseq_pci_m2_e_pcie_enable,
+	.disable = pwrseq_pci_m2_e_pcie_disable,
+};
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
 	.name = "pcie-enable",
-	.deps = pwrseq_pcie_m2_m_unit_deps,
+	.deps = pwrseq_pcie_m2_unit_deps,
+};
+
+static int pwrseq_pcie_m2_e_pwup_delay(struct pwrseq_device *pwrseq)
+{
+	/*
+	 * FIXME: This delay is only required for some Qcom WLAN/BT cards like
+	 * WCN7850 and not for all devices. But currently, there is no way to
+	 * identify the device model before enumeration.
+	 */
+	msleep(50);
+
+	return 0;
+}
+
+static const struct pwrseq_target_data pwrseq_pcie_m2_e_uart_target_data = {
+	.name = "uart",
+	.unit = &pwrseq_pcie_m2_e_uart_unit_data,
+	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+};
+
+static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
+	.name = "pcie",
+	.unit = &pwrseq_pcie_m2_e_pcie_unit_data,
+	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
@@ -63,11 +135,21 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
 	.unit = &pwrseq_pcie_m2_m_pcie_unit_data,
 };
 
+static const struct pwrseq_target_data *pwrseq_pcie_m2_e_targets[] = {
+	&pwrseq_pcie_m2_e_pcie_target_data,
+	&pwrseq_pcie_m2_e_uart_target_data,
+	NULL
+};
+
 static const struct pwrseq_target_data *pwrseq_pcie_m2_m_targets[] = {
 	&pwrseq_pcie_m2_m_pcie_target_data,
 	NULL
 };
 
+static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_e_of_data = {
+	.targets = pwrseq_pcie_m2_e_targets,
+};
+
 static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_m_of_data = {
 	.targets = pwrseq_pcie_m2_m_targets,
 };
@@ -92,6 +174,96 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 	return PWRSEQ_NO_MATCH;
 }
 
+static int pwrseq_m2_pcie_notify(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = container_of(nb, struct pwrseq_pcie_m2_ctx, nb);
+	struct pci_dev *pdev = to_pci_dev(data);
+	struct device_node *pci_remote __free(device_node) = NULL;
+	struct device_node *serdev_remote __free(device_node) = NULL;
+	struct serdev_controller *serdev_ctrl;
+	struct serdev_device *serdev;
+	struct device *dev = ctx->dev;
+	int ret;
+
+	/*
+	 * Check whether the PCI device is associated with this M.2 connector or
+	 * not, by comparing the OF node of the PCI device parent and the Port 0
+	 * (PCIe) remote node parent OF node.
+	 */
+	pci_remote = of_graph_get_remote_node(dev_of_node(ctx->dev), 0, 0);
+	if (!pci_remote || (pci_remote != pdev->dev.parent->of_node))
+		return NOTIFY_DONE;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		/* Create serdev device for WCN7850 */
+		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
+			serdev_remote = of_graph_get_remote_node(dev_of_node(ctx->dev), 1, 1);
+			if (!serdev_remote)
+				return NOTIFY_DONE;
+
+			serdev_ctrl = of_find_serdev_controller_by_node(serdev_remote);
+			if (!serdev_ctrl)
+				return NOTIFY_DONE;
+
+			serdev = serdev_device_alloc(serdev_ctrl);
+			if (!serdev)
+				return NOTIFY_BAD;
+
+			ret = serdev_device_add(serdev, "WCN7850");
+			if (ret) {
+				dev_err(dev, "Failed to add serdev for WCN7850: %d\n", ret);
+				serdev_device_put(serdev);
+				return NOTIFY_BAD;
+			}
+		}
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static bool pwrseq_pcie_m2_check_remote_node(struct device *dev, u8 port, u8 endpoint,
+					     const char *node)
+{
+	struct device_node *remote __free(device_node) = NULL;
+
+	remote = of_graph_get_remote_node(dev_of_node(dev), port, endpoint);
+	if (remote && of_node_name_eq(remote, node))
+		return true;
+
+	return false;
+}
+
+/*
+ * If the connector exposes a non-discoverable bus like UART, the respective
+ * protocol device needs to be created manually with the help of the notifier
+ * of the discoverable bus like PCIe.
+ */
+static int pwrseq_pcie_m2_register_notifier(struct pwrseq_pcie_m2_ctx *ctx, struct device *dev)
+{
+	int ret;
+
+	/*
+	 * Register a PCI notifier for Key E connector that has PCIe as Port
+	 * 0/Endpoint 0 interface and Serial as Port 1/Endpoint 1 interface.
+	 */
+	if (pwrseq_pcie_m2_check_remote_node(dev, 1, 1, "serial")) {
+		if (pwrseq_pcie_m2_check_remote_node(dev, 0, 0, "pcie")) {
+			ctx->dev = dev;
+			ctx->nb.notifier_call = pwrseq_m2_pcie_notify;
+			ret = bus_register_notifier(&pci_bus_type, &ctx->nb);
+			if (ret) {
+				dev_err_probe(dev, ret, "Failed to register notifier for serdev\n");
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -119,6 +291,16 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to get all regulators\n");
 
+	ctx->w_disable1_gpio = devm_gpiod_get_optional(dev, "w-disable1", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->w_disable1_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->w_disable1_gpio),
+				     "Failed to get the W_DISABLE_1# GPIO\n");
+
+	ctx->w_disable2_gpio = devm_gpiod_get_optional(dev, "w-disable2", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->w_disable2_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->w_disable2_gpio),
+				     "Failed to get the W_DISABLE_2# GPIO\n");
+
 	ctx->num_vregs = ret;
 
 	config.parent = dev;
@@ -134,14 +316,23 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 				     "Failed to register the power sequencer\n");
 	}
 
-	return 0;
+	/*
+	 * Register a notifier for creating protocol devices for
+	 * non-discoverable busses like UART.
+	 */
+	return pwrseq_pcie_m2_register_notifier(ctx, dev);
 }
 
+
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {
 	{
 		.compatible = "pcie-m2-m-connector",
 		.data = &pwrseq_pcie_m2_m_of_data,
 	},
+	{
+		.compatible = "pcie-m2-e-connector",
+		.data = &pwrseq_pcie_m2_e_of_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwrseq_pcie_m2_of_match);

-- 
2.48.1



