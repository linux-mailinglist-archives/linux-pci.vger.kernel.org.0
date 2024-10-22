Return-Path: <linux-pci+bounces-15003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F7B9AA014
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 12:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE802876E9
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 10:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2515E19C563;
	Tue, 22 Oct 2024 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWGng+KD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B219C556;
	Tue, 22 Oct 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592884; cv=none; b=LaHSkVIHTkPAdeFJqoddboBlY0EvX3I1DMq1VZHR5NgPhgGZO9ov5w0Qip0kv54O+ipQSUWe/2ajKRt7M6zbmt9Y1KRv6ahtuN6FrArhfzdnHyhezTZlOdK2DwhrMAWrtOb1Eq0f1IM8Rlo60OBbsAE3j0cwGB/jfDgHrjeesSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592884; c=relaxed/simple;
	bh=iDI1BQiua45IUMp/ZWP+8paKKCC+IFjowSEqYFTeTFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Azb9UeLbH9rJ4oFhPm6qqIbbdbeNyPZvotUgb0w5SfauvXLJOVT7uz6z6sl6zqHcyXP0rKYLeF46t0WJJfhYj0HtOncnD/GlIWDp8pNfuJ2tXGokI41xsnoa9qZes+mmHg+0FbwZbdF8GVyGkm/1P9Wqq/ft08Dyapl1d/EVsII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWGng+KD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72D42C4CEE7;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729592883;
	bh=iDI1BQiua45IUMp/ZWP+8paKKCC+IFjowSEqYFTeTFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FWGng+KDqH8huUQF9VFFp44Xz8Rxi9Tpq+eXsoHWU4W19sqAnvjSZ9IPmSk72eDsb
	 gKAqyer04Rlgl2TbsgclYZcLuK+VeQ8R1m4Xtf7XjLHgCcimSM31vUHEbq77nsCT+V
	 kEKV7b3WiV5zc9lSvL6/fv4hwEHpgoEG6V2NxNgH3q9ftpBTodLXn6GLx0Qo7Gbqp6
	 DBzX5/WO1RaOOrGrXA/qb8W+F05+Hk3r6oSMNMQ4jyDZ+MyICpmDlzSSMimCHUuPsS
	 hr3BkznjcXBPh6TX0NRDvMmMu9OKLCo6rSg0lyUMPYtW5h9ge/KalOF3bpGBZCRLBJ
	 sbJZ0VprT2nPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C1CD1CDD8;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 22 Oct 2024 15:57:32 +0530
Subject: [PATCH 4/5] PCI/pwrctl: Move pwrctl device creation to its own
 helper function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-pci-pwrctl-rework-v1-4-94a7e90f58c5@linaro.org>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2866;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ysOLKy+185AD3GOipcG2TEA807qZUk22GeUQ5Y6pe4o=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnF34vmsof+M+5wL5XmngmSZCCByb+moVH/g2gE
 BwhvmPs2BiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZxd+LwAKCRBVnxHm/pHO
 9RUxB/9DKZS3wBi+FU7eP7EVhMTHc/nh9MECM0XNE1queAtb+/Si7BtnEdjcqvRwamCngW/kN0R
 q8U9RflthcVPaEor0YjkTnlPMM49we3BVurBjFoZp833MNguajLNFZJlC5308PwNEuxBfPfkRny
 jjZACCHEWlxya5zXo5YjqbQpsp71GtpuqqlQbU9bAUFwAdd0Pk8ygGygSZ47awBmhuyUGLUsm0Z
 2qwuluPr00FNCLDRqtBbw4p6EnlJztA9DX1EdeXj7oYXa30GA+1gKUEk1MBcYmQyFm+mC7OhJRz
 ZPdOVSoenL2EiN2B2i9vDphxWm3XFnVHb2L1RZm011JfFtnY
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This makes the pci_bus_add_device() API easier to maintain. Also add more
comments to the helper to describe how the devices are created.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c | 59 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 351af581904f..c4cae1775c9e 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -321,6 +321,46 @@ void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
 
 void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
 
+/*
+ * Create pwrctl devices (if required) for the PCI devices to handle the power
+ * state.
+ */
+static void pci_pwrctl_create_devices(struct pci_dev *dev)
+{
+	struct device_node *np = dev_of_node(&dev->dev);
+	struct device *parent = &dev->dev;
+	struct platform_device *pdev;
+
+	/*
+	 * First ensure that we are starting from a PCI bridge and it has a
+	 * corresponding devicetree node.
+	 */
+	if (np && pci_is_bridge(dev)) {
+		/*
+		 * Now look for the child PCI device nodes and create pwrctl
+		 * devices for them. The pwrctl device drivers will manage the
+		 * power state of the devices.
+		 */
+		for_each_child_of_node_scoped(np, child) {
+			/*
+			 * First check whether the pwrctl device really needs to
+			 * be created or not. This is decided based on at least
+			 * one of the power supplies being defined in the
+			 * devicetree node of the device.
+			 */
+			if (!of_pci_is_supply_present(child)) {
+				pci_dbg(dev, "skipping OF node: %s\n", child->name);
+				return;
+			}
+
+			/* Now create the pwrctl device */
+			pdev = of_platform_device_create(child, NULL, parent);
+			if (!pdev)
+				pci_err(dev, "failed to create OF node: %s\n", child->name);
+		}
+	}
+}
+
 /**
  * pci_bus_add_device - start driver for a single device
  * @dev: device to add
@@ -345,24 +385,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
 
-	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
-		for_each_child_of_node_scoped(dn, child) {
-			/*
-			 * First check whether the pwrctl device needs to be
-			 * created or not. This is decided based on at least
-			 * one of the power supplies being defined in the
-			 * devicetree node of the device.
-			 */
-			if (!of_pci_is_supply_present(child)) {
-				pci_dbg(dev, "skipping OF node: %s\n", child->name);
-				continue;
-			}
-
-			pdev = of_platform_device_create(child, NULL, &dev->dev);
-			if (!pdev)
-				pci_err(dev, "failed to create OF node: %s\n", child->name);
-		}
-	}
+	pci_pwrctl_create_devices(dev);
 
 	/*
 	 * Create a device link between the PCI device and pwrctl device (if

-- 
2.25.1



