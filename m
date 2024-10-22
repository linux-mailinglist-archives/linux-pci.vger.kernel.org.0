Return-Path: <linux-pci+bounces-15001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948FD9AA00C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 12:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932021C21BC1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D032619ABD5;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvroHRQg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ADE19AA5F;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592882; cv=none; b=D9mXWuyQxCFfN3I7MuiEqUXaA81YlXbRY0s42EzbMsONuYXe91kECiwzOWGH2w5XevtDCdXNi6RliJy/Xa9I1WzpDd+jUiWPQ3ERArg4wa8jELx5+QxYgZ8Xj9qs9Rz+XJpkLBdlOFPCz7C6LzX/Qz03+1l4F1UWXvkwZiczU6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592882; c=relaxed/simple;
	bh=nXrMDv4DLCwTKntmPRrNHTshkE35Wn5xllkAYNU1RPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPZvKefjgXOJ0F7xRwsGnxok5Q5mbH4Wm783AyCYmonVfl2QEfIhLHnWcE7Vxq2+7qPtePzyhRz+6ovLTSR9w8eM18ldcYI8xIFH7mld5tBPKXpgeCORWDlvsR9ag/T2HaUiD5Szif/nlx1HRQuy6Pnr2ZCynAdnP2dY+1qXHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvroHRQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62FB5C4CEE8;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729592882;
	bh=nXrMDv4DLCwTKntmPRrNHTshkE35Wn5xllkAYNU1RPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lvroHRQg197E6Fra1WlW2UtEZMMl9OI1bxoAE+0NCsIqQz98bviNqxpj6xxlLpCsl
	 DIbf31lZN8F8H171fYOgxCKgPnhVbb3uQA8Ujf6NQEavRbaXQbEuvVy08kmnZYFBF3
	 2aS5/7a6d5PW2i7fR6Zv7ZWAyYLJKJdst/yDTygiZvVdLfUerzNIwWBJWcAqy1qSYk
	 J7QEp4SHez/IeRaeIFZWrTmaB63sABbXs+85vAijC8rKrVbGNzIOxl/gmaDTmaGoMN
	 iHjYnEgn2qNVm7zXPpkAMDHXl+oHinRxCo1UT4t05bS4NbF67Q61bVdbtQBYKi9z7N
	 xRj10Fgl55MfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E0AD1CDD3;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 22 Oct 2024 15:57:31 +0530
Subject: [PATCH 3/5] PCI/pwrctl: Ensure that the pwrctl drivers are probed
 before the PCI client drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-pci-pwrctl-rework-v1-3-94a7e90f58c5@linaro.org>
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
In-Reply-To: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4288;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=CMCJAN6TTXnp4YKoD/4sES4pW+pXB0JA5zNXiTbypoQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnF34v3ndtipqnqpjL/0m97CWLr9o+/oUmMsTPG
 u+5FqUYSkqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZxd+LwAKCRBVnxHm/pHO
 9dB+B/9qx4jfhTowszqW04+QkzMLfxp8hx92XArz8U00OJ0j5rh3toSkNbf2LCcnHnM8xpE4Mmh
 vxxBbBeMsDmb+ABqG2LenkJMN/dvmCtpaClRuaeCu5cZvhGqZYZ+i9z18mLxxgzYT45gqoomNYe
 Ks+8BlyOWldFEO3SxR+PjcavhQro1wNeTEAJKTW01NwSvnFpNqD7uA0xS/8ls6QXfyknU899U8M
 6pzHXYznFKavGEsFSMiZv6U85kmW8bGIdfploIDzuKoSKcPT2+grkxGKQn4sktyC1B6Y1+SiiXx
 ib9z+m7Jhls+Z61zGyE/PtIvFANAug+vtLGWHvvGAWfinjha
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

As per the kernel device driver model, pwrctl device is the supplier for
the PCI device. But the device link that enforces the supplier-consumer
relationship is created inside the pwrctl driver currently. Due to this,
the driver model doesn't prevent probing of the PCI client drivers before
probing the corresponding pwrctl drivers. This may lead to a race condition
if the PCI device was already powered on by the bootloader (before the
pwrctl driver).

If the bootloader did not power on the PCI device, this wouldn't create any
problem as the pwrctl driver will be the one powering on the device, so the
PCI client driver always gets probed afterward. But if the device was
already powered on, then the device will be seen by the PCI core and the
PCI client driver may get probed before its pwrctl driver. This creates a
race condition as the pwrctl driver may change the device power state while
the device is being accessed by the client driver.

One such issue was already reported on the Qcom X13s platform with the
WLAN device and fixed with a hack in the WCN pwrseq driver by the 'commit
a9aaf1ff88a8 ("power: sequencing: request the WLAN enable GPIO as-is")'.

But a cleaner way to fix the above mentioned race condition would be to
ensure that the pwrctl drivers are always probed before the client drivers.
This is achieved by creating the device link between pwrctl device and PCI
device before device_attach() in pci_bus_add_device().

Note that there is no need to explicitly remove the device link as that
will be taken care by the driver core when the PCI device gets removed.

Cc: stable+noautosel@kernel.org # Depends on power supply check
Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c         | 26 +++++++++++++++++++-------
 drivers/pci/pwrctl/core.c | 10 ----------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 698ec98b9388..351af581904f 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -345,13 +345,6 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
 
-	dev->match_driver = !dn || of_device_is_available(dn);
-	retval = device_attach(&dev->dev);
-	if (retval < 0 && retval != -EPROBE_DEFER)
-		pci_warn(dev, "device attach failed (%d)\n", retval);
-
-	pci_dev_assign_added(dev, true);
-
 	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
 		for_each_child_of_node_scoped(dn, child) {
 			/*
@@ -370,6 +363,25 @@ void pci_bus_add_device(struct pci_dev *dev)
 				pci_err(dev, "failed to create OF node: %s\n", child->name);
 		}
 	}
+
+	/*
+	 * Create a device link between the PCI device and pwrctl device (if
+	 * exists). This ensures that the pwrctl drivers are probed before the
+	 * PCI client drivers.
+	 */
+	pdev = of_find_device_by_node(dn);
+	if (pdev) {
+		if (!device_link_add(&dev->dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
+			pci_err(dev, "failed to add device link between %s and %s\n",
+				dev_name(&dev->dev), pdev->name);
+	}
+
+	dev->match_driver = !dn || of_device_is_available(dn);
+	retval = device_attach(&dev->dev);
+	if (retval < 0 && retval != -EPROBE_DEFER)
+		pci_warn(dev, "device attach failed (%d)\n", retval);
+
+	pci_dev_assign_added(dev, true);
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 
diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
index 01d913b60316..bb5a23712434 100644
--- a/drivers/pci/pwrctl/core.c
+++ b/drivers/pci/pwrctl/core.c
@@ -33,16 +33,6 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
 		 */
 		dev->of_node_reused = true;
 		break;
-	case BUS_NOTIFY_BOUND_DRIVER:
-		pwrctl->link = device_link_add(dev, pwrctl->dev,
-					       DL_FLAG_AUTOREMOVE_CONSUMER);
-		if (!pwrctl->link)
-			dev_err(pwrctl->dev, "Failed to add device link\n");
-		break;
-	case BUS_NOTIFY_UNBOUND_DRIVER:
-		if (pwrctl->link)
-			device_link_remove(dev, pwrctl->dev);
-		break;
 	}
 
 	return NOTIFY_DONE;

-- 
2.25.1



