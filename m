Return-Path: <linux-pci+bounces-42052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E2EC857CF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D279534EA0D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DA1327200;
	Tue, 25 Nov 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpQ7VFAd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9A32692E;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081911; cv=none; b=Uwc9newBnxm+BXhrWHDBH+CwxrQYDcXCPT/sRdTbf9gonNfBj/Ztce60QE7ywMd+md4WddmCS4zt9b1Ia3Xfj4cmjF4lx/IclHTss8M7P41d0/kr4hNkG203FGiuoUzgQeF1YgFdQDx5V17rJQ1ihhQXrFNdDLnb9uqk33km4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081911; c=relaxed/simple;
	bh=9wiAneIe4PtRYieKALLniV4NVJC0MpqwxX1iHoF/arI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSreXKZ/yEBRdKMpZB4hbg+6MVxtJaLYJiZvWWyIsUm3MpsCBSHjHdFCUgp3K74/EJuHaEL0YSewKGUfG4GhR6hZW8B6B7fcxufMAYCqDVU4xWyj5E/FOZH0Ez1Y7/Zr7rqmYJ8R38dEszij3x0/hlyGKIFa8QympOQrOmswoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpQ7VFAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EBECC2BCB1;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764081911;
	bh=9wiAneIe4PtRYieKALLniV4NVJC0MpqwxX1iHoF/arI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fpQ7VFAd2pqGR6bj0TlULByIgk+6MsIeIZOBqGCjLPpB5Pw3Dn+NdWfEC6SAfD80Z
	 cXg3GC0vHYxXHI4paDkCDNJ4apBtWqME8QJtwYUkeq4vrwIIT0cPw6WZnKBjP2kl8L
	 Rr24CtHFpfAQnYYOI54SVlWUF/2fZhH9Q4jz3fR9Vd22rKgc8O2HUAMjnhiAiNbLNv
	 40ZsEwlOrp17XPfEwOaIXy3xHLgTaqWe2Gor5dAQ42jiQHdGp2BzhoeKMHHZ57DL0C
	 RIUwV9XQ7yP1wXxNhJgvCYIqYEWu04qhZXt5C9EWZ7E0r4o5FU/oYS7JQkdkzxhX/l
	 VkMSRCQ/RLTDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A83D0E6C6;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 25 Nov 2025 20:15:08 +0530
Subject: [PATCH v2 04/10] serdev: Add an API to find the serdev controller
 associated with the devicetree node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-pci-m2-e-v2-4-32826de07cc5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=V1p0qX3vrz92sD1qV7R72e5ox9rZKasfmlTpIXqG3AM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJcDyF1/pgOLf1aVGEuv44G7i0XrrfAOqmecw2
 mzElUd/v5qJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSXA8gAKCRBVnxHm/pHO
 9bvfB/44AU6EYFmyxS7a2q+VGScl6JakUBZg0CeSHUIPNiLIgltpD0wnO13rOmWVZlBH5iaUmRG
 eHFX+92RGGqNKq+DblVtUN2wujOTz1iv3YvstidexJufqx6AiAnbMXyIk85S5d5joN0yNQYhhdA
 ijzPQU9/cij19LvCo3rnTyK8TtU/mV5na5rwUvbKfs4xs9SVTplFPnAW5mmXY2ZCoKNDR3b40eP
 2ATF6PeHljysxSNEwGLfEmrgyKduSU2C1FiEf+lTOoZZsJqe8f/rw54zZRbYRQr9/gpUhvgS4XZ
 daPSu1Th2xsHK4LKi5Q1g4ADiGWwLY9uL6ImU9bLchSUpN95
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
index 76b89dd0720f..f90095cb778f 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -530,6 +530,22 @@ struct serdev_controller *serdev_controller_alloc(struct device *host,
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
index ffc6eb13f44b..fa235c92592a 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -337,4 +337,13 @@ static inline bool serdev_acpi_get_uart_resource(struct acpi_resource *ares,
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



