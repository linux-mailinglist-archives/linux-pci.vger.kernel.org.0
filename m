Return-Path: <linux-pci+bounces-31633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9F4AFBA8A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 20:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B4C1899DA4
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 18:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E28264602;
	Mon,  7 Jul 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jlq8eToU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632FA263F5D;
	Mon,  7 Jul 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912339; cv=none; b=qFa4NM7TyyShfJLAWzJ9cjYWWMzZXVU7Ha5zID+RtvyzfykqeAx1tbl7B3h0l4qRDsEHxE/kJEV0GLi6oyQFdUOPcAy4sZ8qKp+kyEIaLibcwC6PN61qiv5gTDEpouvouSq9hiPX1gxez5k9t+YENlGpPcMOqm03h4m5HByvhTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912339; c=relaxed/simple;
	bh=Jc5W8YWG8wc8WHHktFwpIx1XLVRVaPHGDSbx0uJxsVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2dyztpxKTQOyCglyB1stqOmCU/Cycta+sowvmC+cubdFX8FoooR0KG1jOGsqP5pN+pKzGX8LU22ZTT9t5PLXb/TsyKXXprHohYgeuOL5tBtJAcUbNt70rbxptLcqQNch9wj3DXyQ85mjJmMN5RzkZNzDAGC7oKwjIH2p/ZY7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jlq8eToU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CABC4CEEF;
	Mon,  7 Jul 2025 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751912338;
	bh=Jc5W8YWG8wc8WHHktFwpIx1XLVRVaPHGDSbx0uJxsVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jlq8eToUmM5nvFNRalRuPLXy8Z8Rnl6x6nEZ+UrHDpP7fSDpS3ZfN+Sq68yu01Fmf
	 gUnuQ/tjJzXHgRg8iplaFg6urZHQy2D0fFONhmnJK2C6Q1Q7vesfyC5WSx5QPZkfr/
	 +9yXmCyWMzNgtgrv3NsyX+fBv+eyd1xuXJF1Xkl36OecVG/yuMmDQgMyn/P1Yo4ZrI
	 y/bHIMBr9R5sVZpvy2zeWnUxmfzsB3oMZrrgRgwipg9R4pBqaYeZ3QdeIavJiZSDYf
	 mtJ7eObBqef/U5Wj+2eF2N0/ucag/LWZT28+lzwvXFMNqcFy957hFipWwmL/yX8tK5
	 Ejr5FbF2lVk2g==
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Mon, 07 Jul 2025 23:48:39 +0530
Subject: [PATCH RFC 2/3] PCI/pwrctrl: Allow pwrctrl core to control PERST#
 GPIO if available
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
In-Reply-To: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5803; i=mani@kernel.org;
 h=from:subject:message-id; bh=Jc5W8YWG8wc8WHHktFwpIx1XLVRVaPHGDSbx0uJxsVE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBobA+Fr1jxYYwqxN5mEPdnnWkmDD3HZwA3qS20I
 SlsHWfPiwmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaGwPhQAKCRBVnxHm/pHO
 9W1YB/9TSjFH6U9IRw5x9eTMmLVwyAxxNmB9wNnIoeNFtDVrxQ3nUIsTek8VmHeGjm3J61jE5+O
 ljmgtl9bnPdq9CQK0en3tBKJXNo57AV+Nwxyelk0JGp/8vr8nXR3gy9VxYWFQsimEOrTgl1dnSQ
 DIuxxuB8P2+ZoOBLp9NwUmb9QVZ+EeoukWuiVAOqLAUUs1VXPbhz5wSGFClnYWM76gnRXr6i1wD
 T3G+Pnn1nk2O3qXITu9CYyonFwoQZZUmi3wVNY1o2u31Z41VWsMwKw9vCTELrMLmuTXYKo8Mx9L
 Fc5BxvkJ9+mW/YSzGqIqXB0LSVdPD9yVjNZTYawWxW76J8wN
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

PERST# is an (optional) auxiliary signal provided by the PCIe host to
components for signalling 'Fundamental Reset' as per the PCIe spec r6.0,
sec 6.6.1.

If PERST# is available, it's state will be toggled during the component
power-up and power-down scenarios as per the PCI Express Card
Electromechanical Spec v4.0, sec 2.2.

Historically, the PCIe controller drivers were directly controlling the
PERST# signal together with the power supplies. But with the advent of the
pwrctrl framework, the power supply control is now moved to the pwrctrl,
but controller drivers still ended up toggling the PERST# signal. This only
happens on Qcom platforms where pwrctrl framework is being used. But
nevertheseless, it is wrong to toggle PERST# (especially deassert) without
controlling the power supplies.

So allow the pwrctrl core to control the PERST# GPIO is available. The
controller drivers still need to parse them and populate the
'host_bridge->perst' GPIO descriptor array based on the available slots.
Unfortunately, we cannot just move the PERST# handling from controller
drivers as most of the controller drivers need to assert PERST# during the
controller initialization.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/pwrctrl/core.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-pwrctrl.h |  2 ++
 include/linux/pci.h         |  2 ++
 3 files changed, 43 insertions(+)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 6bdbfed584d6d79ce28ba9e384a596b065ca69a4..abdb46399a96c8281916f971329d5460fcff3f6e 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -3,14 +3,19 @@
  * Copyright (C) 2024 Linaro Ltd.
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pci-pwrctrl.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
+#include "../pci.h"
+
 static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 			      void *data)
 {
@@ -56,11 +61,42 @@ static void rescan_work_func(struct work_struct *work)
  */
 void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
 {
+	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dev->parent);
+	int devfn;
+
 	pwrctrl->dev = dev;
 	INIT_WORK(&pwrctrl->work, rescan_work_func);
+
+	if (!host_bridge->perst)
+		return;
+
+	devfn = of_pci_get_devfn(dev_of_node(dev));
+	if (devfn >= 0 && host_bridge->perst[PCI_SLOT(devfn)])
+		pwrctrl->perst = host_bridge->perst[PCI_SLOT(devfn)];
 }
 EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
 
+static void pci_pwrctrl_perst_deassert(struct pci_pwrctrl *pwrctrl)
+{
+	/* Bail out early to avoid the delay if PERST# is not available */
+	if (!pwrctrl->perst)
+		return;
+
+	msleep(PCIE_T_PVPERL_MS);
+	gpiod_set_value_cansleep(pwrctrl->perst, 0);
+	/*
+	 * FIXME: The following delay is only required for downstream ports not
+	 * supporting link speed greater than 5.0 GT/s.
+	 */
+	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
+}
+
+static void pci_pwrctrl_perst_assert(struct pci_pwrctrl *pwrctrl)
+{
+	/* No need to validate desc here as gpiod APIs handle it for us */
+	gpiod_set_value_cansleep(pwrctrl->perst, 1);
+}
+
 /**
  * pci_pwrctrl_device_set_ready() - Notify the pwrctrl subsystem that the PCI
  * device is powered-up and ready to be detected.
@@ -82,6 +118,8 @@ int pci_pwrctrl_device_set_ready(struct pci_pwrctrl *pwrctrl)
 	if (!pwrctrl->dev)
 		return -ENODEV;
 
+	pci_pwrctrl_perst_deassert(pwrctrl);
+
 	pwrctrl->nb.notifier_call = pci_pwrctrl_notify;
 	ret = bus_register_notifier(&pci_bus_type, &pwrctrl->nb);
 	if (ret)
@@ -103,6 +141,7 @@ void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl)
 {
 	cancel_work_sync(&pwrctrl->work);
 
+	pci_pwrctrl_perst_assert(pwrctrl);
 	/*
 	 * We don't have to delete the link here. Typically, this function
 	 * is only called when the power control device is being detached. If
diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
index 7d439b0675e91e920737287eaf1937f38e47f2ce..1ce6aec343fea1b77a146682f499ece791be70dc 100644
--- a/include/linux/pci-pwrctrl.h
+++ b/include/linux/pci-pwrctrl.h
@@ -31,6 +31,7 @@ struct device_link;
 /**
  * struct pci_pwrctrl - PCI device power control context.
  * @dev: Address of the power controlling device.
+ * @perst: PERST# GPIO connected to the PCI device.
  *
  * An object of this type must be allocated by the PCI power control device and
  * passed to the pwrctrl subsystem to trigger a bus rescan and setup a device
@@ -38,6 +39,7 @@ struct device_link;
  */
 struct pci_pwrctrl {
 	struct device *dev;
+	struct gpio_desc *perst;
 
 	/* Private: don't use. */
 	struct notifier_block nb;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f39238f8b9ce08df97b384d1c1e89bbe..fcce106c7e2985ee1dd79bfcd241f133e5599fe1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/resource_ext.h>
 #include <linux/msi_api.h>
+#include <linux/gpio/consumer.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -600,6 +601,7 @@ struct pci_host_bridge {
 	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void		*release_data;
+	struct gpio_desc **perst;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
 	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */

-- 
2.45.2


