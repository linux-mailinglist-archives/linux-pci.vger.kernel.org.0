Return-Path: <linux-pci+bounces-40994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A6FC534BE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 17:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F689503272
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04F034251C;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkar5/a0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688A340293;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958731; cv=none; b=e/58wSYhF7f5lInXxpnd0BQ/UJmSr2TXmaOGnupujCNA9+AqMzJMznaJufAmlRlrvh7vomk8fSeg1Xr1oZLtvI4Lbx9GlZUt/k8uwgU/NFAopZMPQcVut4iQZM6bGRDhEvuoIeR5pl/ktpckXJuqtQqUsC11qqVpCQQbZHf13d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958731; c=relaxed/simple;
	bh=L7iVFg7sZFJXM/ApGg4k66iGAwt68odx4+E9YWY+cnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMo1SEq0cxZCG5W4lWoIfscAANcAC17G0j3XiOpT/btT+NgRGzbTyJf+R0zpEjVsNyKQ8xRQHJkOTBNUSpF+fcst2RHaMbj+BmeJ7gNo6iRDgyOtdIn4ep4QZ2HiXTG59ZgVuif3hw4LDcrxVI7QepUndKC1fV0nEJOjz8rhiD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkar5/a0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11EF9C19423;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762958731;
	bh=L7iVFg7sZFJXM/ApGg4k66iGAwt68odx4+E9YWY+cnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jkar5/a0xV0XfBYLALRxb9FqHLFMf5G0T3DQfiYdsWHlKfuS0cL/XxFbHk5+ObGUd
	 gWBSf9UXqPiR+AoilYJcC7LbEfmwhBRl/lQo9v+ONpG0cD2lbHxLSMQshPTmRH4LC8
	 GIP7Lf4PdsHg6La3kq1zJujMZr13SvyKtyWHfu9HEeUdVt0b8GlsZIbGvhRNKQeTe8
	 xcXBLiFadI1v/lsBhAwXGjoWs/sjMr6x632q0I6REW/RhkXBdYLcbnJHqin13IF1GS
	 +wHGQrsE5/5oBqL3yNyIbuD0ndlnZ0ZxZL76DlWnpYV7WoMicFQm2ELL/c9BQmhEhR
	 yjOrpQsSDW8Sw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A93BCCF9E3;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 12 Nov 2025 20:15:15 +0530
Subject: [PATCH 3/9] serdev: Allow passing the serdev device name to
 serdev_device_add()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-pci-m2-e-v1-3-97413d6bf824@oss.qualcomm.com>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
In-Reply-To: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5251;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=c+ZfFChOiwPXrgBo3Hm41yJ4twgPMWwihL2KydIW2hU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpFJ2GuH9bSE/qLpnlL7qfWYHEJ9kMMpDh2IkZg
 ioAcrCMP6WJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaRSdhgAKCRBVnxHm/pHO
 9V4xCACpKggi0h5EsAbWmO1W3x1wepvdIQr3nk0oqB8ZQCGLntg+/dBH3YvESuNvQx+eHq1ecDy
 cJEs6hUol9p8HzY4e/wBOxnCvBmvD0cUlixShwOQUIpKslW2fiIJhdYuXOu1524VGYS85GWtRk2
 QT1cJ+1IpsxSmCTXiqPCoAICGWgZ4xU3/K3lIvJlXzGoyew4LMK3K6crX/RCr5B2KYcwfNa2A68
 0mP9nGlvNLw+cKNCFfP2jv2rt9HNRAwgdJZYTQoVgn3qbsO/i0Zt5GhuGWqYxd97xkdp78VtW+v
 NOpygSfJ3jQK71/T0iPfQ1Dm5UDNO0u+7B4QBKl41P6CqrMR
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/platform/x86/dell/dell-uart-backlight.c             |  2 +-
 .../platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    |  2 +-
 drivers/platform/x86/x86-android-tablets/core.c             |  2 +-
 drivers/tty/serdev/core.c                                   | 13 +++++++++----
 include/linux/serdev.h                                      |  2 +-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index f323a667dc2d2c7dec9fb284515bc3b6b984b7b9..f076cfac2bc5ec14899d6622d084bae2ffecfa3c 100644
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
index 8551ab4d2c7dbc3a8d0b2f50071d4460a3ee65e9..5e568fe1162d1563183713f8d5c71c59ff7667a1 100644
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
index 6588fae303562b7dc9a1a8d281b167e44f0d3e84..96140f5d4f79240f44cb4530ee63777f783c6aaf 100644
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
index 2b5582cd5063a87c9a6c99f83a8ab071637eae57..76b89dd0720f89dbe34e205b905ef24d9f94d770 100644
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
index ee42e293445d928a311bd3c120e609214f89a5dd..3b87909b199af74d619b4fe548c5c9c994e7bc15 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -163,7 +163,7 @@ static inline void serdev_controller_put(struct serdev_controller *ctrl)
 }
 
 struct serdev_device *serdev_device_alloc(struct serdev_controller *);
-int serdev_device_add(struct serdev_device *);
+int serdev_device_add(struct serdev_device *serdev, const char *name);
 void serdev_device_remove(struct serdev_device *);
 
 struct serdev_controller *serdev_controller_alloc(struct device *host,

-- 
2.48.1



