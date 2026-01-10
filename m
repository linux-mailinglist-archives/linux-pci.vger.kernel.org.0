Return-Path: <linux-pci+bounces-44430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B37DD0D276
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 08:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9722330EABF9
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A090E34D4F9;
	Sat, 10 Jan 2026 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvAbBmRf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9660349AE6;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028226; cv=none; b=j0Vqvts3v1p7X2SY4uYWwGsAOgMb9/7g8vHrmRcDAhR6KFh+5fsSXUWxOTK3nnKbOOAMb8QMYEY0Pmm2vM/Rou/Vjun9RMnck18T8u/TmeBjyqYS/icoTvJXZ/Ykboq7ws0Tm0uovtmVdpzPcOAzojEs06tV5i8n5cUrMO8n5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028226; c=relaxed/simple;
	bh=M63xYuGhzTnw77y0XcBIHpc3qTNOnrlDzshVGfxXGIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eo+uSyBwaKQFO/RlG7o0AJ3CmW7nYFjzBRj/ayNdWhXFesGWQ1hb57HvbZwNsQBR2z7MMQZpecd45VZjYMxxpwnBTFUy1hnjcaDw3eJilspVR1IAp2Gt7NYiJ1L66LdCu/bSaQ0J2xfLWf7ujq+CnIdANkVz1R0no1gLH61u/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvAbBmRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 627C1C19423;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768028226;
	bh=M63xYuGhzTnw77y0XcBIHpc3qTNOnrlDzshVGfxXGIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lvAbBmRfc3NdDNO3EaF5NsjOgZEjNcZhWEmfNeQb0Px/Iml5xA7wczcQeXcllpCYj
	 ZjwF3EZ31za3ZRi8exnQ1NsZvvrAKHXG+CNxG/5xWZMLt+gzZEQMbiEuGzJeKBh31k
	 v4OiIfSs3zLl6clB+HJMnkcqnMUyD/8LlVGW/Y0W6LxPINwqbeyAUVcYXyb+vkvcC1
	 0faiXwo4tR11s4P8+yGM11LOzyblcnB4RO2DaDShTlan0uGQ7EWfE2R+mESuBfxliF
	 Bc93pr2DyDqu25bfdI5EJrS00wdU8v49SH+IxUpKNj3BcZ/CuSml+9PG5ofpxcY2xU
	 k1P7ulPDXN64Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A17DD277CB;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 10 Jan 2026 12:26:32 +0530
Subject: [PATCH v3 14/14] power: sequencing: pcie-m2: Create serdev device
 for WCN7850 bluetooth
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-pci-m2-e-v3-14-4faee7d0d5ae@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5942;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Vp7zYCRu5g++KTpycV6G46GxYVukXvcLdhL4fCvf0XY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpYfg++CojcI/ArwvutjAh/aYmpyIOq9cl2wKAe
 28Y/hBJCleJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWH4PgAKCRBVnxHm/pHO
 9Ql5B/9E1CdAqnK1mNQgswa7wqthDkSc9rCfk/sIks3lGXEgHCzNRoFIxTTAXs8x9BZ7uoUV6Pw
 gsJDjJxoTu1H+qIi7ZWQKMbPIPYZDgD2J+NrccRfcR9T05z8r9T/YESRPMeooyA3LwMoosxgLy0
 EcLU8B+j7nO5KAHKiGGeNt6kP9A2uFZiJlC7G0uZ8NI7n0v+HDXEZ5HY8QSQ5yPCoyI7+rP75ew
 EYlAWhJZzZMfe3fFbCOtEQenFlR+HJARr4s78hWj7XAsKbUTkN0iJNIXXdmAb5EGjsW6d2qArxV
 lterlf/QYVzMwuBnByh/jQ6HHZ8b3ko+MSYmJYmAlNdcDOZh
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

For supporting bluetooth over the non-discoverable UART interface of
WCN7850, create the serdev device after enumerating the PCIe interface.
This is mandatory since the device ID is only known after the PCIe
enumeration and the ID is used for creating the serdev device.

Since there is no OF or ACPI table for the created serdev, a software node
is created with the 'compatible' property. This property will be used to
match the existing OF device id in the bluetooth driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 125 +++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index ad94090bbdb2..7c7bde563341 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pwrseq/provider.h>
 #include <linux/regulator/consumer.h>
+#include <linux/serdev.h>
 #include <linux/slab.h>
 
 struct pwrseq_pcie_m2_pdata {
@@ -26,11 +27,14 @@ struct pwrseq_pcie_m2_pdata {
 struct pwrseq_pcie_m2_ctx {
 	struct pwrseq_device *pwrseq;
 	struct device_node *of_node;
+	struct fwnode_handle *fwnode;
+	struct serdev_device *serdev;
 	const struct pwrseq_pcie_m2_pdata *pdata;
 	struct regulator_bulk_data *regs;
 	size_t num_vregs;
 	struct gpio_desc *w_disable1_gpio;
 	struct gpio_desc *w_disable2_gpio;
+	struct notifier_block nb;
 	struct device *dev;
 
 };
@@ -179,9 +183,124 @@ static void pwrseq_pcie_free_resources(void *data)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = data;
 
+	fwnode_handle_put(ctx->fwnode);
+	serdev_device_put(ctx->serdev);
+	bus_unregister_notifier(&pci_bus_type, &ctx->nb);
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
 }
 
+static const struct property_entry wcn7850_bt_props[] = {
+	PROPERTY_ENTRY_STRING("compatible", "qcom,wcn7850-bt"),
+};
+
+static int pwrseq_m2_pcie_notify(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = container_of(nb, struct pwrseq_pcie_m2_ctx, nb);
+	struct pci_dev *pdev = to_pci_dev(data);
+	struct serdev_controller *serdev_ctrl;
+	struct device *dev = ctx->dev;
+	struct device_node *remote;
+	int ret;
+
+	/*
+	 * Check whether the PCI device is associated with this M.2 connector or
+	 * not, by comparing the OF node of the PCI device parent and the Port 0
+	 * (PCIe) remote node parent OF node.
+	 */
+	remote = of_graph_get_remote_node(dev_of_node(ctx->dev), 0, 0);
+	if (!remote || (remote != pdev->dev.parent->of_node)) {
+		of_node_put(remote);
+		return NOTIFY_DONE;
+	}
+	of_node_put(remote);
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		/* Create serdev device for WCN7850 */
+		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
+			remote = of_graph_get_remote_node(dev_of_node(ctx->dev), 1, 1);
+			if (!remote) {
+				of_node_put(remote);
+				return NOTIFY_DONE;
+			}
+
+			serdev_ctrl = of_find_serdev_controller_by_node(remote);
+			of_node_put(remote);
+			if (!serdev_ctrl)
+				return NOTIFY_DONE;
+
+			ctx->serdev = serdev_device_alloc(serdev_ctrl);
+			if (!ctx->serdev)
+				return NOTIFY_BAD;
+
+			ctx->fwnode = fwnode_create_software_node(wcn7850_bt_props, NULL);
+			if (IS_ERR(ctx->fwnode))
+				return notifier_from_errno(PTR_ERR(ctx->fwnode));
+
+			device_set_node(&ctx->serdev->dev, ctx->fwnode);
+
+			ret = serdev_device_add(ctx->serdev);
+			if (ret) {
+				dev_err(dev, "Failed to add serdev for WCN7850: %d\n", ret);
+				fwnode_handle_put(ctx->fwnode);
+				serdev_device_put(ctx->serdev);
+				return notifier_from_errno(ret);
+			}
+		}
+		break;
+	case BUS_NOTIFY_REMOVED_DEVICE:
+		/* Destroy serdev device for WCN7850 */
+		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
+			fwnode_handle_put(ctx->fwnode);
+			serdev_device_put(ctx->serdev);
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
+	struct device_node *remote __free(device_node) =
+			of_graph_get_remote_node(dev_of_node(dev), port, endpoint);
+
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
@@ -236,7 +355,11 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
 				     "Failed to register the power sequencer\n");
 
-	return 0;
+	/*
+	 * Register a notifier for creating protocol devices for
+	 * non-discoverable busses like UART.
+	 */
+	return pwrseq_pcie_m2_register_notifier(ctx, dev);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

-- 
2.48.1



