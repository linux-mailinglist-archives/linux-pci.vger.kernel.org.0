Return-Path: <linux-pci+bounces-44524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89316D14018
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32FE2301AE16
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B836655A;
	Mon, 12 Jan 2026 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0iD7YdF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E3536829E;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235314; cv=none; b=nh2HQ4uLWMY6H7PMn6WR/f7g67sKTZC6VtCIAff04GzQTM88mHZwj/eD/RXkANXQJy2K4xq2pYdT/WebHj4T7bT8xU5qQjPEG1QjgLkfr+U36BukGQysxOilS23fv/03k1ZE3yPksdWDbLaPrOqIZI0hJ3xcHNugemCCnvi0GsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235314; c=relaxed/simple;
	bh=grrBzUog12+WE5FP8RC1t7J6n4Xk4iWQti4S7q8UyIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Da932bBoNQgqaYa5F6/9RIot34cHYz26rLIkzYgSOBQ12fMiXK70fRT/T5p7wyORfDvcWEfDGixqdhgUWKkg/KYp0e6+MTaXSKwl45v9cGmTK5QhHVIHQmXm16XJbmtfVO2U5zVTNA9LA74p5oypcek4/txkEGwFLcJBuDfhroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0iD7YdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C86F4C19422;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768235313;
	bh=grrBzUog12+WE5FP8RC1t7J6n4Xk4iWQti4S7q8UyIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o0iD7YdFw8q6ThQ29JHAro4ZvVy2rVBNTTRMICyoAKU4mV/CkxFRp4PcViVdcZF0g
	 f+uKrxgMnTH9Ds0npL8+70FXhqh+9hbTPaa+u8Srz+GthSbN8F+rwvprC6yh5hOlVV
	 YKp/5/ibeefHpW7rsFHDND6TTzOrLJak1XZzL8SvlAH7Xu62pRpZAaX32Ooge3g1al
	 uVCeEGlc0FytsxRz7As5+dUUmkvb8E7mvNmC2rT62J+VczvtaP/ZUYKmL/llcSQlFQ
	 OcVdTvuXTIS2+iEgZg1yK35dvZXbdjHfct1t/a9mloLTW1ynSqnXQTGv3jpg61Rpgc
	 0G+lZzezNWVJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB78D25041;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 12 Jan 2026 21:56:06 +0530
Subject: [PATCH v4 7/9] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pci-m2-e-v4-7-eff84d2c6d26@oss.qualcomm.com>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
In-Reply-To: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=0KqheeXO4Oi8QyG11TDbNEO023eYG3+bTSLkuoPEKb8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpZSEuKYIUhamgQf6AalMOWO7Rfl2Il8MaGaoj+
 gm0X0978nWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWUhLgAKCRBVnxHm/pHO
 9YI/B/4so8DL0igNTt5laHHShN9QY9BShj9qsVmgCmZZizALVLOpQtpgvprKHQpF3hI4Xt6L2FJ
 FJbZryxF13pMx3goH+YdgkzPmFyfUAjqbXyhaeaii/ouFz9bey7NQL7oV1PjGrJRNBIqH7iwQ+C
 wQc69799eXgaoRJvvfu2Gg/zX2Y/JrmVlEdxdDT1Tk0LBE9jUw5+OClD/6jj24ovQFQSUcCiN2A
 5WojYECWh4+gWPWcuH3TfnCwn4IYD432qmpihCDTqXkaNjit1v5i4rp9+6DxeWD8ZCGNBcnL8uy
 +Zz3zxBGrAWSjRVDzEzuK1UjzbqdV1v5hBVrQmHs/YhRJWCg
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support for
getting the pwrseq device if the OF graph link is present. Once obtained,
the existing pwrseq APIs can be used to control the power supplies of the
M.2 card.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 888176b0faa9..4d562596ebf9 100644
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
@@ -2384,6 +2385,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

-- 
2.48.1



