Return-Path: <linux-pci+bounces-42057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA3BC8588A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4453B26FD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B423329E60;
	Tue, 25 Nov 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6VClFIs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA8F3271E7;
	Tue, 25 Nov 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081912; cv=none; b=dcKDjG8RrTYwgn7PaolmfjSe8xRfD+g2nzgyDohzTqMOoVUmNEvQeGHVXZl5hzphgBBh8tlv3UlVsfTjCSalt7jjK7VPLOjEjaasHiPPUQVQacSi+yiG70FUiYUJe+CMAPaxSOBRJ1PdLbNyaA+EvlUYSeh5VPDiz7FDnP1AF4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081912; c=relaxed/simple;
	bh=fQZr7pUYhOD/jEojYwd8ZDtbZU5QJsTZEvoo6g+VOqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7RQ9FsnpNizpFq9H84PlEj2GVuGQoIX6uGm8OpAAnNhR97jPpoOMLSzw5hPXrM/446YO1FefWT3BaoU4hEm8eclFICumqNFu7z6wq5S6pJIv2D7zUhLv8K9BmwVQxiYy9/ktk2crvpy0YrBYtNoM3n5kdL9WDFLTU703qmkN8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6VClFIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A26FDC19422;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764081911;
	bh=fQZr7pUYhOD/jEojYwd8ZDtbZU5QJsTZEvoo6g+VOqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k6VClFIsVWbv8FvSi9LyVIUAs3350bj5ucgvFUvJqfgj8b9XHvTfjzsEtlyRFahqh
	 qIUxRXjv4F9LFlLgCW7H02/Ax4vSqoZUij3DAsGzmEqGPT591rQ+LngcgrxLnwNTO5
	 OPBAGnCK+vLfQPDKEtKsas7yM/2hw6wg0Vw59oXOnxPHi9TtoWQuQU3ShZdrnpiBGm
	 7XDZmz8wI5LzeP/J8WDOVNcuSJ1mr/RuUNlE1VIRM0thSVK6kbaGW4LILzIreLbYFX
	 nSNLhryg4fexmvAiK+7XM0DWHhiRh1g2AQiOreSj5PAa8vkqeBTkAuaA6o7YDJ/1+7
	 FXmA1KwUU6OSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FABD0E6C6;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 25 Nov 2025 20:15:13 +0530
Subject: [PATCH v2 09/10] Bluetooth: hci_qca: Add support for WCN7850 PCIe
 M.2 card
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-pci-m2-e-v2-9-32826de07cc5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2637;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=zEZ8rEadVzPrGNr8RLnULvokKFhVGX7/QBoqApf/dmI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJcDzqRvhavEAtyIdpgbq7HdybyTkQukIfRcUV
 vXmEyI7PJWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSXA8wAKCRBVnxHm/pHO
 9aQDB/wPxF9hhA7J5V9ZkfTIoBhTIN04bqoZH2i2TrRvvdp+9G18kp/R+SHrCxQtycJZbHPRkx/
 DoBUmhkTkkeK7rwp5WIPR97L0JRCUVp7v3oajBLCtUhzuE07rBX4StDpHyFBscYoV8tdITB8Jup
 OsSCbEScWfaNh7TrL3/7EOqiF5s0sTGMYffGC5+Ta0sJgHYQMz7ApJ/mwtK01nYC9Tt9kUc5+Bo
 P9HcpV6cBQSZ/GcYn9xtG+8l4ZWMV4LEBdCKcRPmK9Oythi2wZy4gAGtLCOS1udXANa8PuP2RY8
 ppz4zSvUZ9mvpGwDs/BCeEPfde5jQtO9OFuO2ns4HZxQNRcf
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The WCN7850 PCIe M.2 card connected to the UART controller exposes the
'WCN7850' serdev device and is controlled using the pwrseq framework.

Hence, add support for it in the driver. It reuses the existing
'qca_soc_data_wcn7850' driver data.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4cff4d9be313..35d08b455e40 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -26,6 +26,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/consumer.h>
@@ -2344,6 +2345,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	qcadev->serdev_hu.serdev = serdev;
 	data = device_get_match_data(&serdev->dev);
+	if (!data && serdev->id)
+		data = (const struct qca_device_data *) serdev->id->driver_data;
+
 	serdev_device_set_drvdata(serdev, qcadev);
 	device_property_read_string_array(&serdev->dev, "firmware-name",
 					 qcadev->firmware_name, ARRAY_SIZE(qcadev->firmware_name));
@@ -2384,6 +2388,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 	case QCA_WCN6750:
+		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
+								   "uart");
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				return PTR_ERR(qcadev->bt_power->pwrseq);
+			break;
+		}
+
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the
@@ -2740,6 +2752,12 @@ static const struct acpi_device_id qca_bluetooth_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, qca_bluetooth_acpi_match);
 #endif
 
+static const struct serdev_device_id qca_bluetooth_serdev_match[] = {
+	{ "WCN7850", (kernel_ulong_t)&qca_soc_data_wcn7850 },
+	{ },
+};
+MODULE_DEVICE_TABLE(serdev, qca_bluetooth_serdev_match);
+
 #ifdef CONFIG_DEV_COREDUMP
 static void hciqca_coredump(struct device *dev)
 {
@@ -2756,6 +2774,7 @@ static void hciqca_coredump(struct device *dev)
 static struct serdev_device_driver qca_serdev_driver = {
 	.probe = qca_serdev_probe,
 	.remove = qca_serdev_remove,
+	.id_table = qca_bluetooth_serdev_match,
 	.driver = {
 		.name = "hci_uart_qca",
 		.of_match_table = of_match_ptr(qca_bluetooth_of_match),

-- 
2.48.1



