Return-Path: <linux-pci+bounces-44516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738ED13FAC
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4536C30123F6
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986B7366559;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1jlFzrW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C6C365A08;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235313; cv=none; b=CS5Q9rnh5j+23ReRfGY2DQ3p32KdNwgJoygxW7in2xckCL6pqpJRZ1Qq22jwV8lslo0o2kfHzjTOwCHVL0oqrRmPpVBdkAxxpKwuui1j98Vbx+FdXDEtXRTR22oajjKkBHUUJBwwQUqf9LiSftX0v54m6wDDdPfbDV2xp9z8HKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235313; c=relaxed/simple;
	bh=VwpIUgJ7TQ6NyHLOeJDcf/38Dl2NWNEcsZHgAexS5KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rszeTCG8rNTUTv3k74TFsOZKEv9jqQtfG/Gr4KTN18wrn47w4mlCaIymcMk9N11EykfkjebGAj6lUE6IMBlcyQYj3mPjSVCR0J2C0GfZbq8QOQSFMjlJDkdncWaBiOFQaFKc6M9k1RMNHhWAlDgWG4+X5wsyOXnelYTUqao+dUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1jlFzrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ED2DC2BC86;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768235313;
	bh=VwpIUgJ7TQ6NyHLOeJDcf/38Dl2NWNEcsZHgAexS5KQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l1jlFzrWXiR+bPz/tAoas97NLT3Sb/mzv/cNexBpkyN935yKgZXrwyX5hcKRvRWjW
	 /7jdusQk9J3KQGxEtdTLD5ZSske7arq9+Iu5Ch8DZj9lY8up+xxNq1rIUNlri/FgCn
	 3vOXtBLeIfa3f4t8wxrsioZZcaZekECdmbd9t5rJ1/20S/t7yEmc1wtG3xnPqgLKor
	 4y57st7Z9mpvOpEGeY57j6kcJpyP2SRV5sPfInfvcbU/XQPCatGtwMUBAwXKGa7kPm
	 AOSZzGf0ziGPBDfNzg9l346zshWCwOqdx4ULtHAja92RflyzlMgfhNeu7gcUjVvC48
	 OZouoGi8Vld1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11230C9EC9D;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 12 Jan 2026 21:56:01 +0530
Subject: [PATCH v4 2/9] serdev: Add an API to find the serdev controller
 associated with the devicetree node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pci-m2-e-v4-2-eff84d2c6d26@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=J1VmrZOJOQw4R6fDrVVe/0GgAe/UzN5xgoimqww9n5Q=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpZSEtqgiwm1mkQDaD/Wb8/ZXVgx6a+CPfmCw+6
 HFABhElf66JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWUhLQAKCRBVnxHm/pHO
 9eMPCACobFxxteG5pdzS0luxGgzCXNtDCi5oiEXMX32Vb8bWtrZ6t6eXEP/LLe4esV0w1AiTKKk
 6s5b9O2HMWDmQgjJOMSQl1ee7bmPg9QkbGIJnbs4Bhz+jCEGUAt4x3aNRE2Oi9CGeN37cG4HsB8
 UK+Wd4Y2JHpUYg/Pyt85++38RT6kG0/RTLg0apGiKZf0jCGUbAu9+1aw2yReUTLJ5H1HKNYjxHI
 HPuc55LD9SuUMtuAbvxzkxj9XNeO+KgY5yLfxprgHSmvlGkNxbTWmxOPCZ4hMQ9sipJvTCu5yWd
 04yiZzfEKcRICb2XsaVVDdU/yohakOQ8Bjl6pY2KGzqw6lxD
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



