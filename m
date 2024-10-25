Return-Path: <linux-pci+bounces-15271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A1F9AFB90
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 09:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A321C1C21111
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F871C0DD3;
	Fri, 25 Oct 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFPTLDMB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD8199237;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842903; cv=none; b=eDzRdNuBFZvVhMqDWco2avZ4Bj+1vGeY7xDCYa1QLRUwxt5rVS9i3gThvtV6kO+5ZjXd71sZyHxgzU3Z45zzGv4ASNVB8k7jb4GfqTwPHGCqXhjNAiaz/OgtiBy4pnW9Sa2AH88+7wjbh7SaPHuUyomxElc4QJLOGVdZ9Lat/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842903; c=relaxed/simple;
	bh=xsioCY39TMmED4dmq57286M326Pu5X0lo5xq75LORhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpbgIwGsBdbgjRwsxCRbNrgh4QQhKXD4boo4hLwpfCq/W64nPx8FYzU3+LF6J2XQClfoW0SBd1ie4LNxQ2MZzUGi8oaAFQu4p5GKQcEwmxRBbX0q4E3AcAkVfN4sxZzfuniIJSyr/b+pW1yyREmrRsDPaNKYfHpcLStrWxYhgS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFPTLDMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E914C4CEE8;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729842902;
	bh=xsioCY39TMmED4dmq57286M326Pu5X0lo5xq75LORhM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hFPTLDMB2EIwbwnDV5uPvFVg4rp4l7feinLaAWUrv5XcTxwnKL2PRQ8Rglf3o6p+u
	 TmbOt1fomWK9Cg+zg/d+LjEWH47ILV3Xy3RfdWKsEo1LBS93Mpof9lBMhEA/QFO0l1
	 LqRQyaVhsAoRYXa0TjGjaAMskalBts3c5VwpnTrdYoyp0/iDJGfG0bMI3S+BdbGbQ5
	 5fCJPjbFxWBSBAMUVQB6MHuAq5njovLFW80TyTwbk/1KvOi5QmF/Iyxwq3iztQLkjj
	 ChgyciUrLQoh8o6uib+vuJkiq2CM1U+Pux3NBsLo3FTpLBa0sTb89ZgS68dR/DFkVI
	 GrXyzv1u7NBMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A63D1171C;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Fri, 25 Oct 2024 13:24:54 +0530
Subject: [PATCH v2 4/5] PCI/pwrctl: Move pwrctl device creation to its own
 helper function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-pci-pwrctl-rework-v2-4-568756156cbe@linaro.org>
References: <20241025-pci-pwrctl-rework-v2-0-568756156cbe@linaro.org>
In-Reply-To: <20241025-pci-pwrctl-rework-v2-0-568756156cbe@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krishna chaitanya chundru <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3016;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=umde/gEf3xryIYWhEQXTOZb+OYyr+RucmbbfjNEuNcQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnG07UGAg9nkrolL4cB2g9Lnx0saPQGfzOUZKEF
 4f39fULM7uJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZxtO1AAKCRBVnxHm/pHO
 9XIyCACmIiZaGcBALCNfIceqSQuEMavLpnbUGB4PRhmxgVrRK3KsjTE3altX3gKuayVDbA6MR3Z
 YiUMRxKobB14WbeJfc/fRDsre7fZ2+azeqIhWHn+u8UYO7SH7+jOE+hh+9jmwrebUljwPUfz8JH
 +8vK8++I8r4WniCN1YNdSVFJHIIhhG1UAbNsC+1wnoFEuM03eV6J0EQ9+4TB68NzIe2r0laSe0h
 1THtkvz3FZ7xxNR3pX5foODZnCS6KsBzIagXJ2Woiv+gNZ1nkt6A0bFU20MFJj+r+In1XBy79lE
 Ysj3gxw/BxiBmLvcIRKdN9h8CNds8DilRH01bXxFviD4AVYd
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This makes the pci_bus_add_device() API easier to maintain. Also add more
comments to the helper to describe how the devices are created.

Tested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c | 59 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 645bbb75f8f9..6e38984e576d 100644
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
+		for_each_available_child_of_node_scoped(np, child) {
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
-		for_each_available_child_of_node_scoped(dn, child) {
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



