Return-Path: <linux-pci+bounces-19968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C1CA13BCB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF54D1688FB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8DD22B8C8;
	Thu, 16 Jan 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf+2MQzu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34822B8A1;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036560; cv=none; b=jZi35T/VwBoqI9n41ulYFMeNw9SVLGT21pCR2DoLg0dbWq+tzE3lujKnUpEVe/IewmPCL1jxazQJfr33KuEe6HUidYPYJ+yL2b/AD525pYSQPEpv0Ss9UPhEJh3PpGhL3xyE1YTnT5IJnuNLbSrYRQFiqBqs10tSkjD5yf2CGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036560; c=relaxed/simple;
	bh=TqAmYnGdZx1QsV3OeXL36Bg8+NtxtJ4Cd/pnM6p+YBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+ak6IF7qcMv4qgd/mLD6WzzFsrhOniOMdQYdkR45qXp/ox9IGyWN9aEj3dXdyM8JxaMEV4K5IoRaAZCdgc/Hb/oLptLfzoeJH5TWa3tpG3At8t4B95TjkYPeO5VB6zx1uGq2ZgQ7yFx/MOLghfcw3E8k37yppm/zls4gJL3Big=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf+2MQzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4453C4CEE5;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737036559;
	bh=TqAmYnGdZx1QsV3OeXL36Bg8+NtxtJ4Cd/pnM6p+YBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Wf+2MQzumbxwtD6UxdP7XzcoFdy2YOt0RzMA3QSktgaRxPl4x7G2+bMh9Jj+o3Wer
	 mRtVjKxdWPXMhxf88cVqeWf3KjAWUr6cBSE32W3ekK5dBuPXe4ey+ihnO7KvXQwRP8
	 6i8FhFdqykM1vGRRuR92SIVRAOaW7phBYClv3bSjioRLyiap/ZDotmiHXRxhlpmKyK
	 1NpGMZVT0Uup/LqxhdjRPTaXWhM+mrTcPFEXYec3fa8TDzg1Oym7daVHhG3810TNrI
	 Qr9oKfj5VWfH0eE6OMg99Lv3F4HosAv5ryyPGOiEJS+UGkbIEf+t7CVckyFKp1Xt2o
	 IrQjmLdWVqiQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A31FC02187;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 16 Jan 2025 19:39:13 +0530
Subject: [PATCH v3 3/5] PCI/pwrctrl: Skip scanning for the device further
 if pwrctrl device is created
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org>
References: <20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org>
In-Reply-To: <20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2611;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=gy4PLjMdamyd52iwg/D99E/UTsDOUFjzQxLCaHwi72c=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBniRMMdKv0PONWXwBlZ/yC9+rLlA2+aPboQEGcV
 Qdk8GxoQtuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ4kTDAAKCRBVnxHm/pHO
 9diBCACGGQCeerSlzjd5UtoHZZdki3Fg6kHsSGUZBCdBgJwXRGqSHkW48jwQcsUlwg+Kqi1JpdH
 LHvK9O/rDjgDBS9jtSulkcnD/HOcp7Dyq6v5/HjWH4szlhO528hIGU5ZlTxDDj8/f24uihzhReA
 SATSKJzkm2NvxzASaqMteXhuGgq6fDwRk78k+W98R51kuR73yttfx53wHCxpGRIgRi3Kx50ZX2A
 rG03AAJELcStTY3dRB/tIiYoGmbe6/w8FCEOpjL9WBQaQLSEb3S4tVmBsIb8fIVmSqCRPw2aII3
 uOzVAGE5Sr/J450uO58LsGZA5FL+WkSnJa+HhAaJayV5fUM1
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

The pwrctrl core will rescan the bus once the device is powered on. So
there is no need to continue scanning for the device further.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/probe.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 91bdb2727c8e..6121f81f7c98 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2448,11 +2448,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
-/*
- * Create pwrctrl device (if required) for the PCI device to handle the power
- * state.
- */
-static void pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
+static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(bus);
 	struct platform_device *pdev;
@@ -2460,7 +2456,7 @@ static void pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
 
 	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
 	if (!np || of_find_device_by_node(np))
-		return;
+		return NULL;
 
 	/*
 	 * First check whether the pwrctrl device really needs to be created or
@@ -2469,13 +2465,17 @@ static void pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
 	 */
 	if (!of_pci_supply_present(np)) {
 		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
-		return;
+		return NULL;
 	}
 
 	/* Now create the pwrctrl device */
 	pdev = of_platform_device_create(np, NULL, &host->dev);
-	if (!pdev)
-		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for OF node: %s\n", np->name);
+	if (!pdev) {
+		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
+		return NULL;
+	}
+
+	return pdev;
 }
 
 /*
@@ -2487,7 +2487,14 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	struct pci_dev *dev;
 	u32 l;
 
-	pci_pwrctrl_create_device(bus, devfn);
+	/*
+	 * Create pwrctrl device (if required) for the PCI device to handle the
+	 * power state. If the pwrctrl device is created, then skip scanning
+	 * further as the pwrctrl core will rescan the bus after powering on
+	 * the device.
+	 */
+	if (pci_pwrctrl_create_device(bus, devfn))
+		return NULL;
 
 	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
 		return NULL;

-- 
2.25.1



