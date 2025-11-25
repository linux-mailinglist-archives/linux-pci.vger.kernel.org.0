Return-Path: <linux-pci+bounces-42050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB726C857BD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D6FF4E71FD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDDC326D5C;
	Tue, 25 Nov 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn5iRIx8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF0D325721;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081911; cv=none; b=AVSMFykgHbSjyuHcPt4ZBhUt/ylu00A4nusYxheK/S3vBnGpwvP++bfAeTXhCZtN809LAgCgzIGIgyCi6o993LO/moKXFG27uURM2PR9ZCSIkN0VYOwfLsbMsvH4fFEJKB4tm/HaaOHFOHEcMrdCIb/h1KNTK+U4eNkAyd4LP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081911; c=relaxed/simple;
	bh=kKARAoBJmY4phhOwZPINSi5aSNIyhfDpVVPNRI/AEs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFlgOPRfy52I7WnPsWFDJQbu/r1s32wAKNGt/KFxTZFLR2mlSe6tz+kDwCHMkbxJ/F1Jv7e7f1tqZQ8jXSPhzccf2LpoYaFWoMqLTw6/XkI6kB1M0F2D4UcxZAL8LqRLdAZJ1JnQmV6ZRp10Ib1pDKlFDyP9P//EwzLTFeD3OI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn5iRIx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F360C19425;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764081911;
	bh=kKARAoBJmY4phhOwZPINSi5aSNIyhfDpVVPNRI/AEs0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Pn5iRIx8vDyOD5SlIEDBi6xumlEV8OYGqPZToivt8YgI6ftUC75qJD0StzwMFYJxm
	 0WRzlFJoi6nPEeUOkDIFTJKHF0u4rjtFEjdUUXUvqtoykssB1pMZTmD/iA6tzGXOGW
	 YAnsmyH8UDApYYPJ2OaiprmZ1FrDfw+sVucMGaprbyDxooT7IfgU6A8b5VZC/ok71A
	 ujF8tU+oaK/cRSVJ11QOK925OmJFKdsLhC+1gxnHmanFTJcnvm8tfQRs5pwNZJO7em
	 DvqcSjzarzk+ZAtC0rkSRJW1wyiJjV46cvkhurYj9E0lBwFgi5rGcZ9y4odWJXohBa
	 u3E8EEuzQIcEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208C2D0E6F5;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 25 Nov 2025 20:15:07 +0530
Subject: [PATCH v2 03/10] serdev: Allow passing the serdev device name to
 serdev_device_add()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251125-pci-m2-e-v2-3-32826de07cc5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5029;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=VqkKP0yMqzEc5rXPyc78ivknxMIMS47hfAgM0VO8Rbw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJcDy7vd1/KZr9C7oGm/gzrCR04STvMPHHuXUZ
 aaaG5hA0PCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSXA8gAKCRBVnxHm/pHO
 9Yf6B/9yg5K8Hh6/zfrVWzHZ/tO261mIR/zaJBhfeHmKfx8Brkh3+0ps7W7KJPQPQzcqe8QrrKv
 Ef32jaW4PUlRXYIL94R3sJOm8zvK/iLi7aV6SgpLWttA4udxdbUgdzt6BEodUic4hDv4WIIsUnL
 PE62AkskezaVo4FWrIDWAhurhnQzOusJ693h+HvQklcAOwxHAv2G2u4um5Pgmqy1LeRVpXpAUXl
 MsNXZYogUgSovKLFN3xTW+BW7dxYmdbZqH7XH97k6t38j9FvgFQmxH8Kf2tcd1GZUcHp1FDAqRC
 NUOUtFdzsmzOSCkWxvq2wV4bslKJoanEJkH3Kx8GO3O3rf5y
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Instead of always setting the serdev device name from 'struct device' name,
allow the callers to pass an optional name and set it as the serdev device
name.

This will be used by the future callers passing the serdev device ID as the
name.

Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/platform/x86/dell/dell-uart-backlight.c             |  2 +-
 .../platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    |  2 +-
 drivers/platform/x86/x86-android-tablets/core.c             |  2 +-
 drivers/tty/serdev/core.c                                   | 13 +++++++++----
 include/linux/serdev.h                                      |  2 +-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index f323a667dc2d..f076cfac2bc5 100644
--- a/drivers/platform/x86/dell/dell-uart-backlight.c
+++ b/drivers/platform/x86/dell/dell-uart-backlight.c
@@ -354,7 +354,7 @@ static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
 	if (!serdev)
 		return -ENOMEM;
 
-	ret = serdev_device_add(serdev);
+	ret = serdev_device_add(serdev, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "error %d adding serdev\n", ret);
 		serdev_device_put(serdev);
diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
index 8551ab4d2c7d..5e568fe1162d 100644
--- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
+++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
@@ -260,7 +260,7 @@ static int yt2_1380_fc_pdev_probe(struct platform_device *pdev)
 	/* The fwnode is a managed node, so it will be auto-put on serdev_device_put() */
 	fwnode_handle_get(dev_fwnode(&serdev->dev));
 
-	ret = serdev_device_add(serdev);
+	ret = serdev_device_add(serdev, NULL);
 	if (ret) {
 		serdev_device_put(serdev);
 		return dev_err_probe(&pdev->dev, ret, "adding serdev\n");
diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 6588fae30356..96140f5d4f79 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -316,7 +316,7 @@ static __init int x86_instantiate_serdev(const struct x86_dev_info *dev_info, in
 	ACPI_COMPANION_SET(&serdev->dev, serdev_adev);
 	acpi_device_set_enumerated(serdev_adev);
 
-	ret = serdev_device_add(serdev);
+	ret = serdev_device_add(serdev, NULL);
 	if (ret) {
 		dev_err(&serdev->dev, "error %d adding serdev\n", ret);
 		serdev_device_put(serdev);
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 2b5582cd5063..76b89dd0720f 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -121,14 +121,19 @@ static int serdev_device_match(struct device *dev, const struct device_driver *d
 /**
  * serdev_device_add() - add a device previously constructed via serdev_device_alloc()
  * @serdev:	serdev_device to be added
+ * @name:	name of the serdev device (optional)
  */
-int serdev_device_add(struct serdev_device *serdev)
+int serdev_device_add(struct serdev_device *serdev, const char *name)
+
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
 	struct device *parent = serdev->dev.parent;
 	int err;
 
-	dev_set_name(&serdev->dev, "%s-%d", dev_name(parent), serdev->nr);
+	if (name)
+		dev_set_name(&serdev->dev, "%s", name);
+	else
+		dev_set_name(&serdev->dev, "%s-%d", dev_name(parent), serdev->nr);
 
 	/* Only a single slave device is currently supported. */
 	if (ctrl->serdev) {
@@ -544,7 +549,7 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 
 		device_set_node(&serdev->dev, of_fwnode_handle(node));
 
-		err = serdev_device_add(serdev);
+		err = serdev_device_add(serdev, NULL);
 		if (err) {
 			dev_err(&serdev->dev,
 				"failure adding device. status %pe\n",
@@ -692,7 +697,7 @@ static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
 	ACPI_COMPANION_SET(&serdev->dev, adev);
 	acpi_device_set_enumerated(adev);
 
-	err = serdev_device_add(serdev);
+	err = serdev_device_add(serdev, NULL);
 	if (err) {
 		dev_err(&serdev->dev,
 			"failure adding ACPI serdev device. status %pe\n",
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index aca92e0ee6e7..ffc6eb13f44b 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -160,7 +160,7 @@ static inline void serdev_controller_put(struct serdev_controller *ctrl)
 }
 
 struct serdev_device *serdev_device_alloc(struct serdev_controller *);
-int serdev_device_add(struct serdev_device *);
+int serdev_device_add(struct serdev_device *serdev, const char *name);
 void serdev_device_remove(struct serdev_device *);
 
 struct serdev_controller *serdev_controller_alloc(struct device *host,

-- 
2.48.1



