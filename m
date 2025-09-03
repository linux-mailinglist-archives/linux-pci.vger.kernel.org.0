Return-Path: <linux-pci+bounces-35355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 926E0B415F6
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 09:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E00A1BA01B8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 07:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4912DA74D;
	Wed,  3 Sep 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lamvf7aQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7802D94A8;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883614; cv=none; b=XBSPPqFWJIHGrj3nz0aV5HQ0hHTDwurK3HF879MLhoYRGzcOljLcaXIJdfhvmrcRwJJPGzRwSwQ/Dioi5WF1/uGahjdvHpR2OuZmyh/Tm0tl69ma8zHwp3AdmejlvEgVwmiIj+gnXeKg+7mIUNzoey89/kXbXZDELRmKS0WBXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883614; c=relaxed/simple;
	bh=W3hNvH5sZO6OphkLzRUvLtfBzQHcHDZJGE1fudwcs98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmNH4ggGazd0+Qm3k3zp6plqbM5zhbJmgTxZ470TVKIrzzpZD29Sc6/scuIQIz/SvoqSwz3Cmyv/qTcHA6Y1n5vuSw8mVEIhir17lYdThghUz2auQ83wqKz7AxScLq6p9zQ/5FIfskYVHUcfILPKDsXPrmh6u7zFUurXJq/LfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lamvf7aQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF8D6C4CEFB;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756883613;
	bh=W3hNvH5sZO6OphkLzRUvLtfBzQHcHDZJGE1fudwcs98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lamvf7aQlZoLv+L1+Mq3e9Ng7cS6T+KRGH4T7zeI0l4bTTkvjTkTdtw861vywrOSx
	 k4IQsXdmc5rPllQrp8Qpk3CAtPjNwPN4eEhxeEvzoFlCMtMW41VtqshBp5YGO5pede
	 L71f0Dyk/HznJBaxIUySWaufcbI80QAWZA5N9awl1r+r6/sHneLSydnMDzryLHbgAN
	 4M6JXGQ+xlIHBBSLiL32XJpZoAn3f1m63TGrvYD8JCOgiQiPUHXCFDnFRrraAj6RGj
	 YuPv83PIFeb259oksFhiJqMaiLTt4y93VBRIf5TUMwpa4/cJhJ1TDSd+2iYb1pch4B
	 CbWCmIqL5/lnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65A9CA1013;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 03 Sep 2025 12:43:25 +0530
Subject: [PATCH v2 3/5] PCI/pwrctrl: Add support for toggling PERST#
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-pci-pwrctrl-perst-v2-3-2d461ed0e061@oss.qualcomm.com>
References: <20250903-pci-pwrctrl-perst-v2-0-2d461ed0e061@oss.qualcomm.com>
In-Reply-To: <20250903-pci-pwrctrl-perst-v2-0-2d461ed0e061@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4210;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=3zHm5Gzo/IIXZ/G1nj/XT1Pq21XYLHP2BySYxIC/Q3Y=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBot+qbY5glF0uYf7AkMGjvaky6e5NrTN2X7/z1o
 OlGmSNmfN6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaLfqmwAKCRBVnxHm/pHO
 9bW5B/wNxh5qomqfQn0L2CarY6dq1Ht16cfCGZdHQ6mNZZOABgKfJh9R4qkoFDOyowWxYNKkkL3
 p4hU/l51P8qQdshkv4vorXgOFH6NWPbo1Ro0yP3B9LiJYH3ViH5OtFt+s8Gx0tKmKOyOyYhWQ4L
 50BThbQuyf8NRZNQmUiSuRfI24WHUAb6CDvcPIb0J7Uraios9c2VfvtGbc9P4BHOVkZ326rMrcL
 BEZu2MLmb7PuDvl/66TZ/7Zu+f4cD+OM6q8rMYiSUY0P0l1segBjMyBrDXaG9GRzaCroyNnnnpU
 oWr4Zuo6UVHaszOi/nxt3bhnA1xzcMlY26krJWH6dp3qvYlq
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

As per PCIe spec r6.0, sec 6.6.1, PERST# is an auxiliary signal provided by
the system to a component as a Fundamental Reset. This signal if available,
should conform to the rules defined by the electromechanical form factor
specifications like PCIe CEM spec r4.0, sec 2.2.

Since pwrctrl driver is meant to control the power supplies, it should also
control the PERST# signal if available. But traditionally, the host bridge
(controller) drivers are the ones parsing and controlling the PERST#
signal. They also sometimes need to assert PERST# during their own hardware
initialization. So it is not possible to move the PERST# control away from
the controller drivers and it must be shared logically.

Hence, add a new callback 'pci_host_bridge::toggle_perst', that allows the
pwrctrl core to toggle PERST# with the help of the controller drivers. But
care must be taken care by the controller drivers to not deassert the
PERST# signal if this callback is populated.

This callback if available, will be called by the pwrctrl core during the
device power up and power down scenarios. Controller drivers should
identify the device using the 'struct device_node' passed during the
callback and toggle PERST# accordingly.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 27 +++++++++++++++++++++++++++
 include/linux/pci.h        |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 6bdbfed584d6d79ce28ba9e384a596b065ca69a4..8a26f432436d064acb7ebbbc9ce8fc339909fbe9 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/pci-pwrctrl.h>
 #include <linux/property.h>
@@ -61,6 +62,28 @@ void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
 
+static void pci_pwrctrl_perst_deassert(struct pci_pwrctrl *pwrctrl)
+{
+	struct pci_host_bridge *host_bridge = to_pci_host_bridge(pwrctrl->dev->parent);
+	struct device_node *np = dev_of_node(pwrctrl->dev);
+
+	if (!host_bridge->toggle_perst)
+		return;
+
+	host_bridge->toggle_perst(host_bridge, np, false);
+}
+
+static void pci_pwrctrl_perst_assert(struct pci_pwrctrl *pwrctrl)
+{
+	struct pci_host_bridge *host_bridge = to_pci_host_bridge(pwrctrl->dev->parent);
+	struct device_node *np = dev_of_node(pwrctrl->dev);
+
+	if (!host_bridge->toggle_perst)
+		return;
+
+	host_bridge->toggle_perst(host_bridge, np, true);
+}
+
 /**
  * pci_pwrctrl_device_set_ready() - Notify the pwrctrl subsystem that the PCI
  * device is powered-up and ready to be detected.
@@ -82,6 +105,8 @@ int pci_pwrctrl_device_set_ready(struct pci_pwrctrl *pwrctrl)
 	if (!pwrctrl->dev)
 		return -ENODEV;
 
+	pci_pwrctrl_perst_deassert(pwrctrl);
+
 	pwrctrl->nb.notifier_call = pci_pwrctrl_notify;
 	ret = bus_register_notifier(&pci_bus_type, &pwrctrl->nb);
 	if (ret)
@@ -103,6 +128,8 @@ void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl)
 {
 	cancel_work_sync(&pwrctrl->work);
 
+	pci_pwrctrl_perst_assert(pwrctrl);
+
 	/*
 	 * We don't have to delete the link here. Typically, this function
 	 * is only called when the power control device is being detached. If
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59876de13860dbe50ee6c207cd57e54f51a11079..3da62e37dba5993b52413f16ec401ba3fb970a55 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -605,6 +605,9 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
+#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
+	void (*toggle_perst)(struct pci_host_bridge *bridge, struct device_node *np, bool assert);
+#endif
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */

-- 
2.45.2



