Return-Path: <linux-pci+bounces-44418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B715D0D134
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 07:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CBAB305BC33
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41623346AEC;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaNRxwaa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546A3385B1;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028226; cv=none; b=NYTCOw7i9dcur0O1dN1ZeLn9kLssFWz63wm78+ZmhXi9ipH5Em12AzNI4HJaVa1J8wJuiAsOn3+c/DpsJJiusPfgQ19WwWZCuI44Pgw+29APXkof6uM5Go7iY6Yy7lCVFZSGCh2Kql9ZFucN5cutA+73oaqeCvF1hdwlcD67lp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028226; c=relaxed/simple;
	bh=VwpIUgJ7TQ6NyHLOeJDcf/38Dl2NWNEcsZHgAexS5KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JqruNggnkdx3t0fEOosNaVWeq/FpUBz0dEtCJQvJYifJFDnQPF73Q0T2++zVBhI6AKTGZE20ZT+E5/+KXWvDlejwUyB1WIegHZvqlJsO5yTEwvYX2krNlxRKqcKT5oKnr5StAtSE4baC0ig0KBxakCmuIuB4Jwr1H9RhQZFl22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaNRxwaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88AE2C19423;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768028225;
	bh=VwpIUgJ7TQ6NyHLOeJDcf/38Dl2NWNEcsZHgAexS5KQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gaNRxwaa1xA53wpR82JRgCJBpVRsFPp4AI1idARPpFuYDLNs5B5Wg1geNQGpPdVuw
	 rvHksekciYtK/BgQj70Yv0LPmJp4OLM7T0czG6OM4HhltsQjvV8JUVQ3lXDRe0rwJU
	 Dxhngxz5wDn2ejCBnDT4qywYL2i8mLl6jKwyz2sbqBW8PAmlioluGYMZyBbxfSYGnB
	 4/tjGh6dsvtSrR3Io6IxIUHGT1wHLYvjInYaLwpmNlycD6ivD8QUEcmsvUCyxJuKOW
	 /Zg/uyoJtZl+5pXmXQtVf0OoHeeU9kDvlUk7s/xmanZu0qkrZ5juDpxqeJckSuFTzT
	 LL+t4SYFiQojQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ED9D277D1;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 10 Jan 2026 12:26:20 +0530
Subject: [PATCH v3 02/14] serdev: Add an API to find the serdev controller
 associated with the devicetree node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-pci-m2-e-v3-2-4faee7d0d5ae@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=J1VmrZOJOQw4R6fDrVVe/0GgAe/UzN5xgoimqww9n5Q=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpYfg9QM8A+1VPvL0rKXJiMoRco+nmRGnRevYTT
 du98tgz4V6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWH4PQAKCRBVnxHm/pHO
 9U4FCACCxwOFdIfnKu6XwNfbf0DiMLVwnYANlCMmV8YvO8SM6DWM4q+V0auY68FxCxuZBxMAe6A
 y0wdrMcHA4K12q9KSo5OSvK/JVNhSpQ/BtaA2R3cXVMUuTHqkUVQ/EcHThO437kVeHdv60pAr8o
 /Die73XV8o5rvAG2v6Xxa6ivG8hZljucsJXIKaelDwWPM2tiBe3Y10ihUScbh/YLO3TeMCrapfZ
 IARiXJ+jEF4w43ZUFpBhI0aVDvpAlzUEtw58HrUdCasviZYFRcEwEnnHjpr4tERJ2K1clRabAha
 KOv17NjtUG3BGUHV4DPQ63wcEkX8Um5PNMffDNYtNlk7owbS
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add of_find_serdev_controller_by_node() API to find the serdev controller
device associated with the devicetree node.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/tty/serdev/core.c | 16 ++++++++++++++++
 include/linux/serdev.h    |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index b33e708cb245..25382c2d63e6 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -504,6 +504,22 @@ struct serdev_controller *serdev_controller_alloc(struct device *host,
 }
 EXPORT_SYMBOL_GPL(serdev_controller_alloc);
 
+/**
+ * of_find_serdev_controller_by_node() - Find the serdev controller associated
+ *					 with the devicetree node
+ * @node:	Devicetree node
+ *
+ * Return: Pointer to the serdev controller associated with the node. NULL if
+ * the controller is not found.
+ */
+struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
+{
+	struct device *dev = bus_find_device_by_of_node(&serdev_bus_type, node);
+
+	return (dev && dev->type == &serdev_ctrl_type) ? to_serdev_controller(dev) : NULL;
+}
+EXPORT_SYMBOL_GPL(of_find_serdev_controller_by_node);
+
 static int of_serdev_register_devices(struct serdev_controller *ctrl)
 {
 	struct device_node *node;
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index ecde0ad3e248..db9bfaba0662 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -333,4 +333,13 @@ static inline bool serdev_acpi_get_uart_resource(struct acpi_resource *ares,
 }
 #endif /* CONFIG_ACPI */
 
+#ifdef CONFIG_OF
+struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node);
+#else
+struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
 #endif /*_LINUX_SERDEV_H */

-- 
2.48.1



