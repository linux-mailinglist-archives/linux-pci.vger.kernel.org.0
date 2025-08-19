Return-Path: <linux-pci+bounces-34249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE80B2BA5A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4211BC0521
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7555B28489E;
	Tue, 19 Aug 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oej8+q7Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2526E165;
	Tue, 19 Aug 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587700; cv=none; b=Lvnkpxr7U5dZbWIGR2VTaDBX2Yvx7v53wfQ3Th9gd0wCRSQJlNHWZxNV3lNj/ivfSqyk07GC+dOsSv4Mbf6tDljM79aSb0Sje2KqiS12QFEWwUhd8q6Eed4LNnbH6O7+urvaXGx9ENgiStcPe6QCG7uCcXTsteazjQSUBQ3QwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587700; c=relaxed/simple;
	bh=3Yzrll35ovlysQTqMRm/+PchNYub3AF+TCnxQaJ2Cwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fkd/y7RS+y6LJs+GM9e321ZKPrCuyr8KvyFC3YHcAX/wAGQ+MIIg6AM/a6igLrIGAaJZNrzMCMIa3WIWgX0G0t8GboD8NhrWxRdexR1/86xZwltqy4PkXe0f1J9VXOqHnJEu/MMvVt+AZRGAmAqBQTjlqlP6ThHROnljy23dTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oej8+q7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD32EC19421;
	Tue, 19 Aug 2025 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755587699;
	bh=3Yzrll35ovlysQTqMRm/+PchNYub3AF+TCnxQaJ2Cwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Oej8+q7Q7upCxk6MKa1fOteSmMwQ3M/vCG51CRjcNPQgDvo1Z4DHhBcagO/1XmI1a
	 EUEDA+xdR7kT0sqJn5ZNMjhmHpznMbfNC6HWMQV9dS/67gsVw0jCJeVNGVJpUVqcDs
	 5d/lhbon7zeONpG8JUg1BjD4rSYfz6hRtIUPP4CL0FCyFvh4oJTmFNgw5AO2q/8bkz
	 0GtVYGqDUVrKvU7SFN4RUyZQjUOC4m5Maayi0GC2aVeHe2Ig5ZyKp9moNFqn5ZQ4UA
	 4CzF6mXXt/eS4En0Nuj7qtT9EkjRc3/+oD8Ub05o0FT1kk82S3bAHcGJAFxruYnD0w
	 ngSxjVLdU1LBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D431ECA0EE9;
	Tue, 19 Aug 2025 07:14:59 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 19 Aug 2025 12:44:52 +0530
Subject: [PATCH 3/6] PCI/pwrctrl: Add support for toggling PERST#
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-pci-pwrctrl-perst-v1-3-4b74978d2007@oss.qualcomm.com>
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
In-Reply-To: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4162;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Wl5F/VP41j+Wmr7pvHDX4DYYUQnHnskIua9yaeDLHHk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBopCRwnUvKL5HtXBIOusGiiiGgtA+7zzQqxPXeO
 X+c98wnPJGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKQkcAAKCRBVnxHm/pHO
 9UO0B/9lsxc/zKK0A+23UPDwqBeUsj4J1XE8hhyQ7TAOH5CHfY4SCDEpfZZJsPwNL/xfEWAXjVm
 z0Ulm0Zr+16hIqZcOmtDY1S367/5z8S8ZhvrLzS7cPrFXK6NBuTgD1gKqDANIf0RU/erGkLNeDt
 M/g/D3eU6mI3swFsZUz0tPUXmwkfmnPHG9hHM09ta0z15yyIVBd2357WDB13qJV68Sg9MIsBTGN
 avhjScUy5fKW5f3vVSiuNd9N1qrAFeKwcusbqrynGYWsLJ76MuEuuzeB5woOfqok0+ACPcCLeYi
 JZeKv+mF+lheYsZpXRJVtVmAfOlYs/a3nAdfgkLLeMfUEkmn
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
 include/linux/pci.h        |  1 +
 2 files changed, 28 insertions(+)

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
index 59876de13860dbe50ee6c207cd57e54f51a11079..9eeee84d550bb9f15a90b5db9da03fccef8097ee 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -605,6 +605,7 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
+	void (*toggle_perst)(struct pci_host_bridge *bridge, struct device_node *np, bool assert);
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */

-- 
2.45.2



