Return-Path: <linux-pci+bounces-35985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0D3B54591
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 10:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3AB17AEC4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 08:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DE22D3221;
	Fri, 12 Sep 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7jY4Y0b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1414125C821;
	Fri, 12 Sep 2025 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666122; cv=none; b=omQ0pdXZ1QuTCZivzDGjQWgS38k2M/sR7Lo9nJoXgN2SjfoFEUX5flYTotY+FhCgHFo4LyJYxlt4l8s1iOQPnFCO8xjKGqkPdWDRKYmboiJhPM9pOUaqqh9l28E3lQWI7DJo+A2IaU14619ZV4L6edPHAFk9xLWZLf/TFKM69DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666122; c=relaxed/simple;
	bh=4e2GIu7b5fa+yMjLUHq3pmSOYoEdO+/TNGnDVcHo+r4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kCv3dX4t104v/wV/7uL3SnmgeoiBo8zIQwnvpG3bjGHT6MjkuW9JApIOetp7+Dj2zLPS8Z7BYlljcGYtzVhtvpzTDF/RQkoZQU0Fg9ex+YwvH7JZbgMBuBmJtad1Sp7ysXRA+J1cYS5TosTcJqEUcHT7GJHWNFQ1VvPtIIGMbzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7jY4Y0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1909C4CEF8;
	Fri, 12 Sep 2025 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757666121;
	bh=4e2GIu7b5fa+yMjLUHq3pmSOYoEdO+/TNGnDVcHo+r4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M7jY4Y0bkr5xzbRwpi66TXp6xpfyzGqMn4+f0/JkesPUp55lWlsGn2BYFhOdZu/TB
	 ak7DgZ5UCtP+xbMOyWTM21ZTEO3L1e05fs+edGOiZLWSKnpQDNN96DHQuKn9ZzBQOp
	 FhLtqg3vu0VR9PBDQ6oz+5Lvs+0Y8B4dMQyBiNrCSM6560vkcpIv++VyddP39VhkAk
	 zBGybEVhbmJOfdlEqo4UdnFHBVnw25Vxm98TTx7vXY155TLJ7t0xrL9RI0F4LFZACI
	 3bcuVavpFSfVdAkyjRFhWhNOJKKCS/tXxA7TP5IWuhWD9avSPF1N+3+37cQZ/NVQYz
	 b359YEJf5CHcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1A4CAC582;
	Fri, 12 Sep 2025 08:35:21 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Fri, 12 Sep 2025 14:05:01 +0530
Subject: [PATCH v3 1/4] PCI/pwrctrl: Add support for asserting/deasserting
 PERST#
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-pci-pwrctrl-perst-v3-1-3c0ac62b032c@oss.qualcomm.com>
References: <20250912-pci-pwrctrl-perst-v3-0-3c0ac62b032c@oss.qualcomm.com>
In-Reply-To: <20250912-pci-pwrctrl-perst-v3-0-3c0ac62b032c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4251;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=jCv+iKeOMcKQiy+sgTT5FskEFZPk4zscRN+1zwZTLe8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBow9tHNza8f0jG3b+AspCiBV7VAMWXAy5GxYIcV
 +W5YLUQLBWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaMPbRwAKCRBVnxHm/pHO
 9TV+B/0Sb2Sb+ByTUWUhwh9Jb8VcxsX+SYLJX5HFb3MYZsh7tHjpaa+Q6rEIJq4+5aciNw4iOj5
 v5FCy4gvVNsws1rRHvO9/lT+hav92CuRXJvDCiGfImYYLERBX2O4q5rn5l4Ms+r3BTMdUFZB2na
 zR+6Fqa3vKD3CjqSSbRB04VeBMT9HwmFamrMpDwDHh6r/alWJ+0F67epE0UJfFtO2dzcWCdeuji
 6pZ7OoUMllq66vwvcgByO5hx8ntSpGfzO036H0CGBcJTKKEc8AdjddiLBLFKkYkNLqqRsJECb50
 8CL6tomfbk7Pd+ZMZsSdVf8dxnZF4NVVPcZl4wStPvZTAID4
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

As per PCIe spec r6.0, sec 6.6.1, PERST# is an auxiliary signal provided by
the system to a component as a Fundamental Reset. This signal if available,
should conform to the rules defined by the Electromechanical form factor
specifications like PCIe CEM spec r4.0, sec 2.2.

Since pwrctrl driver is meant to control the power supplies to the PCI
components, it should also control the PERST# signal if available. But
traditionally, the host bridge (controller) drivers are the ones parsing
and controlling the PERST# signal. They also sometimes need to assert
PERST# during their own hardware initialization. So it is not possible to
move the PERST# control away from the controller drivers and it must be
shared logically.

Hence, add a new callback 'pci_host_bridge::perst_assert', that allows the
pwrctrl core to assert/deassert PERST# with the help of the controller
drivers. But care must be taken care by the controller drivers to not
deassert the PERST# signal if this callback is populated.

This callback if available, will be called by the pwrctrl core during the
device power up and power down scenarios. Controller drivers should
identify the device using the 'struct device_node' passed during the
callback and assert/deassert PERST# accordingly.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 27 +++++++++++++++++++++++++++
 include/linux/pci.h        |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 6bdbfed584d6d79ce28ba9e384a596b065ca69a4..54d3dbc24020e979f668bb294448e8429cd8bdd3 100644
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
+	if (!host_bridge->perst_assert)
+		return;
+
+	host_bridge->perst_assert(host_bridge, np, false);
+}
+
+static void pci_pwrctrl_perst_assert(struct pci_pwrctrl *pwrctrl)
+{
+	struct pci_host_bridge *host_bridge = to_pci_host_bridge(pwrctrl->dev->parent);
+	struct device_node *np = dev_of_node(pwrctrl->dev);
+
+	if (!host_bridge->perst_assert)
+		return;
+
+	host_bridge->perst_assert(host_bridge, np, true);
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
index 59876de13860dbe50ee6c207cd57e54f51a11079..08007ef244c0a8bc2be27496bea7249ce3e00935 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -605,6 +605,9 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
+#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
+	void (*perst_assert)(struct pci_host_bridge *bridge, struct device_node *np, bool assert);
+#endif
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */

-- 
2.45.2



