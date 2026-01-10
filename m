Return-Path: <linux-pci+bounces-44429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 538FFD0D1B5
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 07:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6BB5302F921
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE8E34D4C2;
	Sat, 10 Jan 2026 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA8pu9GE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1903491F1;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028226; cv=none; b=Pmcit5zs7BAOmfZlwIjLcACIdMskisA5Eutawr9yr3ENGTuENmuhUpnWK048rCJguRWxrNDEuNMnSOlPH6KG9q1ooifDqGYrRgtpkIrPAorKi4496bTp3sEoKLUAhcQz5Qnj5MJY5ZnSxZF8UKIZQmDJONtvWFia0ZrZcjF04dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028226; c=relaxed/simple;
	bh=o3EP7DGVWpmfQ55FfQ7UE+pTx4x/bF5yjqD4JwZyj9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCNyKJRWTwKE6Wv85Yu8Nq5o5t9DUizSTCyjXbM0dY2Pxm4v8IX0yGi4t9QSyE+WHO15jV/xnv2cm7AXetpXN/E+zKiqUo32EwVRTTwQMfIIfsx8JPDvE0s6rJLmGr2jiaJQnaIX3vp82RcsMc7CV8JlN3/Sw/9utkhKxkOZp/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA8pu9GE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55D58C2BCC7;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768028226;
	bh=o3EP7DGVWpmfQ55FfQ7UE+pTx4x/bF5yjqD4JwZyj9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sA8pu9GEIyJPa3QNQI/TS5i2/e/iQAAncpGc9Y3fClHD2IuknBvV7i46TGKFB4tSl
	 cbU8KdkMUedieGWJ4JxZ0aQf6Q2bH2TSTHpKXZqDlyNJOWQq3iZMf2/lA/rRHEFhID
	 Yyvsh8/AjGmS0f/rBux4RwCxNMFtTrc2aIO792KkK8NuaUrtw13rrJOrxoSzwF6kgY
	 UQtTRUaPW11T+0FSl3Rb0idx0T7CShVRI8v9p609m6WT0ug6n6L7cg+k6QBqvGze+B
	 0HgvbehGSxKktGMD2JTvZ2wYrMm2PNoMN/1pX3q3bVkhXihORmZIZPmd+O7GmU4Va3
	 tAfGzEW4Llf9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BDBD277D7;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 10 Jan 2026 12:26:31 +0530
Subject: [PATCH v3 13/14] power: sequencing: pcie-m2: Add support for PCIe
 M.2 Key E connectors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-pci-m2-e-v3-13-4faee7d0d5ae@oss.qualcomm.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
In-Reply-To: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7602;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=L3fLxUcS/ZM0xt0PO5bBvwJwnG6kvAOi0CCQEuHyW0s=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpYfg+BQlwHo9zHpG0NlwLHgSmlY1b6CHVrz8vy
 s0bRj27vU+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWH4PgAKCRBVnxHm/pHO
 9SQYB/0ex3TP2nxHtEyEceU2Th/JH2oer8iesgVLx/UP8np3iySZyYT2OFA1Cbqs/ZR4xErewCS
 2hWvJ721GsWbkUVz26X9dsH2dSme6PnaTAvEGUwiMCBXRPKfwt94lOAuFpjJWgjxtI9R88Tlpix
 dUbDGR04XA2iMPBotQnuxwnTFa7y7aYI0ittOvqoFV7mF23uLRixZD40VAu5KFauATqi6fzvmH4
 Uwr2rBqC60bvwg3m0K2HHAeibGuNA8IVeW3kR8J30k3Ed9So9FH+h+EhmX7hgu9yrVOt9pwHniB
 NQTOqFDk37ZVFvFAlaJ8pWcZriIVFenataSP+ekTCVBBQSvC
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/power/sequencing/Kconfig          |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c | 111 ++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 7 deletions(-)

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
index e01e19123415..ad94090bbdb2 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -4,12 +4,16 @@
  * Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
  */
 
+#include <linux/err.h>
 #include <linux/device.h>
+#include <linux/delay.h>
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
@@ -25,17 +29,20 @@ struct pwrseq_pcie_m2_ctx {
 	const struct pwrseq_pcie_m2_pdata *pdata;
 	struct regulator_bulk_data *regs;
 	size_t num_vregs;
-	struct notifier_block nb;
+	struct gpio_desc *w_disable1_gpio;
+	struct gpio_desc *w_disable2_gpio;
+	struct device *dev;
+
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
 
@@ -44,18 +51,84 @@ static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
 
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
@@ -63,11 +136,21 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
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
@@ -126,6 +209,16 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
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
 
 	ret = devm_add_action_or_reset(dev, pwrseq_pcie_free_resources, ctx);
@@ -151,6 +244,10 @@ static const struct of_device_id pwrseq_pcie_m2_of_match[] = {
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



