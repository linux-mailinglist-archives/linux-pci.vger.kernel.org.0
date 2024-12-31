Return-Path: <linux-pci+bounces-19114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB619FEE79
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 10:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6783A2AA2
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20BD195962;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIhtr13R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599521925A6;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735638254; cv=none; b=fQlD8M0dA9QJPBOv8m5TRTgZjOUPOrW5rZG2jPOjjhNUwgYePpoNOpMd7TOyT9KUXd5iv116tl9MtQ5mcaeB9znKAoKqrxRGTdMpBRFpN0a0D9QBg4ieUVXrltMDZM22JHZaiBYj9V6ZAikht6WrIOIYCWSFzXMuXW9XcyNWci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735638254; c=relaxed/simple;
	bh=I85exvHlAdHCyIBwyyJVeayckDAvYb7ppB240+u+sv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvlN5cLpuwxOQJMPaNReKW6C+g1UlvMS1y4aSk1ssWq0CWwEaYBj8vPvUsD1bjf2iVVm4dKnr6DbWtQaVTeZ30KOPeVzcRfX9eVFqEJl6TOn7K2XnPPY5WWepV2xB+GpaF6bGFhd8sqrW/2/0rYnHCeHMqZlLL2dRpj9FmQ+0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIhtr13R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FB83C4CEE1;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735638254;
	bh=I85exvHlAdHCyIBwyyJVeayckDAvYb7ppB240+u+sv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TIhtr13RstXyb56XfTTTu+LxMCmB14Y4yX9/IxxWddXSl3kPmQmhDau/E5rRO17ca
	 XXar4lI7l3ey9YoOrb8ttJNbZ48cFASvD28pkJNjxMAguwhoRxPOvXYhBr29IPKf6M
	 EBGWrM6fSD3s+C1DcFTZAne98DZbS6v4bC5BYLVrf1J3kCHlNKeG8EnmLz8Mi21jFr
	 UQd0Lrvh5gDqjWjpaJbA3lXUUklJdzDvjkW4KIeZfXFHgOj35jzWhvPKcpdk069neV
	 G8mq5sIFemW39aulyIM2egOKZK44X4bDjOogefSS8E60I7vRw99I4TCfKoWoMIz8p3
	 o5r5MTpV/2Ipw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08986E77188;
	Tue, 31 Dec 2024 09:44:14 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 31 Dec 2024 15:13:45 +0530
Subject: [PATCH v2 4/6] PCI/pwrctrl: Skip scanning for the device further
 if pwrctrl device is created
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241231-pci-pwrctrl-slot-v2-4-6a15088ba541@linaro.org>
References: <20241231-pci-pwrctrl-slot-v2-0-6a15088ba541@linaro.org>
In-Reply-To: <20241231-pci-pwrctrl-slot-v2-0-6a15088ba541@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Qiang Yu <quic_qianyu@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ZL4/V6JFUdmO0YAXp+rd+0EQhZLXt3iJU/vJV6wd1WE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnc7zreRTAGViodhIerB4qBU+JGtkIrfAxenxfp
 1BjYCey/LCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ3O86wAKCRBVnxHm/pHO
 9Xo5B/4k+7/RJtlU1DjUuo7dbArcYUOgE4GUwF22dv/aaIMygYddilkPq2OMFf+y/EGPrpqoXun
 LGMhs0Sj5Cqw2CY8wbsNpwU9RXLwfL9L66StOq7Koq3sbq2++3DwTKuSMD6wkZES6MeFT3YMVf3
 OM72sPqwIPIiW7MLDhvyCYWaylUX2Dc1pjTLndJ3Jiuphzk7PaVuGofY5EmKQ7MdWGhwKzdyP+v
 BvdSLJH7W6A+5eZ1vrUC8py6a2qsH+m7LJVpPkk0Y6yZ14UT2O0Eue1wJjPkABHxEDq18Sv3BtQ
 WW3CO76Fqxh1qREaveLfBycZMwv41a6FWwoGEWojQFOwnrvy
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

The pwrctrl core will rescan the bus once the device is powered on. So
there is no need to continue scanning for the device further.

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



