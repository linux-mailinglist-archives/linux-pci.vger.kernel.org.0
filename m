Return-Path: <linux-pci+bounces-34625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4483B32B5A
	for <lists+linux-pci@lfdr.de>; Sat, 23 Aug 2025 19:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8CC1B64F4E
	for <lists+linux-pci@lfdr.de>; Sat, 23 Aug 2025 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2D625D204;
	Sat, 23 Aug 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmepMl6V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69B1E32DB;
	Sat, 23 Aug 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755971057; cv=none; b=LnWFDE/KwgpRqjcf5/d+ve1tPEKTNcwibVjjk9WTyIirAO3ZJi+QmAhUAWmRZgkRRUUxXFtJxSdZad6t9VNawUwMykT8Fy554wFFK/UukM3LNswUuRnJFt/VNAHBjI/QaGMEi7GYD8hajNo87McTgXlpF79/2/u1ElkbhS+YnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755971057; c=relaxed/simple;
	bh=ITDCWkMf1Ws3XB5dEpE/PDc45fLUzmzNuMSSBuSZ5O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rpcbzK7qjtFso9Feuh3/CmCuhD4/FsPC8yZLhtQMosYLmPcTUadTgT8TAF1XKu3pL4CP5/kork5FxXmsyef1ZSyAy8avmme42YndA92VvCP4HIH1SzXHyN+dhrbBoniUD+x+2WGbyh6scYDIwFEYDDDDcUJlq+ZpqXIQWP7QnS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmepMl6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2882C4CEE7;
	Sat, 23 Aug 2025 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755971057;
	bh=ITDCWkMf1Ws3XB5dEpE/PDc45fLUzmzNuMSSBuSZ5O4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=cmepMl6VPEX+/DIBSfIAO6/qly5skE0KMH4X3j0G8vGvtU5JMN9HnIYH2MI9Ju7+H
	 1o4pB6ERyNEJVrgnOrvIrEMzEPBI57T5ngoST6TcdH4ebYekBAZpV+4x+7V7FQGlIa
	 Vj4Vivjs5MueQLvIxdQgV9tA6XtP0+GVrmR39X2zVIY8pRxcxJ93paedmxpJA3Qq73
	 9u/5baAwNRmz3RaIRdDzv5rpuPRy9s/a8342u6xAeknI8zCOqX5O0KPxWG3AB2QW4F
	 2fFRsz3+kUIsR7dJAF0FQX77A2j9X0fziovKFmSMMZl72HP6PidHEPSkh9LtfziaRN
	 5R40Xc1N+YNfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF518CA0EE4;
	Sat, 23 Aug 2025 17:44:16 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 23 Aug 2025 23:14:11 +0530
Subject: [PATCH v2] PCI: qcom: Use pci_host_set_default_pcie_link_state()
 API to enable ASPM for all platforms
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-qcom_aspm_fix-v2-1-7cef4066663c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOv9qWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNj3cLk/Nz4xOKC3Pi0zApdYyMzE0sjsyTTJEMTJaCegqJUoDDYvOj
 Y2loAU4Asg18AAAA=
X-Change-ID: 20250823-qcom_aspm_fix-3264926b5b14
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Johan Hovold <johan@kernel.org>, stable+noautosel@kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5931;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=FvAS2lrBy4QcQciNcZNf/ZyUYHY+/IJEof92RVatcC8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoqf3uYNbOl0o5Jc7QJ8AgmJwxlhykuMzGO3fAH
 /bOjc22Oq+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKn97gAKCRBVnxHm/pHO
 9TlzB/4n4OPJa4xZvM+2Pt5FZm2cusOd4R0VaRaJFRA4MEZ9S1K0aVUhftS0Lp/lLuBIKJquAC2
 Okhe1oT8qtTZ5lQ1+NBWg34I66VekaUSZX9hD1as0Uh+8V0/suT3Jo20AYxB7i6x2uxoOJhOp4u
 iOSTQKbdk4cEITzaft1tCPrW25euQThCGIiTzqir5zkvmjDlCB1eppoFROzhEFRulD0FxRGZQOa
 +a9CZSmDQ6PetY3H7crO1wAeHKob98a7JwBbRWSJ3JJXO9I5sVYSnWpCKmMrFns46szyybrbyvq
 7b0Npu0rSNZnWsLI4lPo+JESXkIXcswAADea7uvOf3DIO60l
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
enumerated at the time of the controller driver probe. It proved to be
useful for devices already powered on by the bootloader, as it allowed
devices to enter ASPM without user intervention.

However, it could not enable ASPM for the hotplug capable devices i.e.,
devices enumerated *after* the controller driver probe. This limitation
mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
and also the bootloader has been enabling the PCI devices before Linux
Kernel boots (mostly on the Qcom compute platforms which users use on a
daily basis).

But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
started to block the PCI device enumeration until it had been probed.
Though, the intention of the commit was to avoid race between the pwrctrl
driver and PCI client driver, it also meant that the pwrctrl controlled PCI
devices may get probed after the controller driver and will no longer have
ASPM enabled. So users started noticing high runtime power consumption with
WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
T14s, etc...

Obviously, it is the pwrctrl change that caused regression, but it
ultimately uncovered a flaw in the ASPM enablement logic of the controller
driver. So to address the actual issue, use the newly introduced
pci_host_set_default_pcie_link_state() API, which allows the controller
drivers to set the default ASPM state for *all* devices. This default state
will be honored by the ASPM driver while enabling ASPM for all the devices.

So with this change, we can get rid of the controller driver specific
'qcom_pcie_ops::host_post_init' callback.

Also with this change, ASPM is now enabled by default on all Qcom
platforms as I haven't heard of any reported issues (apart from the
unsupported L0s on some platorms, which is still handled separately).

Cc: stable+noautosel@kernel.org # API dependency
Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v2:

* Used the new API introduced in this patch instead of bus notifier:
https://lore.kernel.org/linux-pci/20250822031159.4005529-1-david.e.box@linux.intel.com/

* Enabled ASPM on all platforms as there is no specific reason to limit it to a
few.
---
 drivers/pci/controller/dwc/pcie-qcom.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..71f14bc3a06ade1da1374e88b0ebef8c4e266064 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -247,7 +247,6 @@ struct qcom_pcie_ops {
 	int (*get_resources)(struct qcom_pcie *pcie);
 	int (*init)(struct qcom_pcie *pcie);
 	int (*post_init)(struct qcom_pcie *pcie);
-	void (*host_post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
@@ -1040,25 +1039,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
-{
-	/*
-	 * Downstream devices need to be in D0 state before enabling PCI PM
-	 * substates.
-	 */
-	pci_set_power_state_locked(pdev, PCI_D0);
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
-
-	return 0;
-}
-
-static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
-{
-	struct dw_pcie_rp *pp = &pcie->pci->pp;
-
-	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_aspm, NULL);
-}
-
 static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
@@ -1358,19 +1338,9 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	pcie->cfg->ops->deinit(pcie);
 }
 
-static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct qcom_pcie *pcie = to_qcom_pcie(pci);
-
-	if (pcie->cfg->ops->host_post_init)
-		pcie->cfg->ops->host_post_init(pcie);
-}
-
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.init		= qcom_pcie_host_init,
 	.deinit		= qcom_pcie_host_deinit,
-	.post_init	= qcom_pcie_host_post_init,
 };
 
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
@@ -1432,7 +1402,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
 	.post_init = qcom_pcie_post_init_2_7_0,
-	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
@@ -1443,7 +1412,6 @@ static const struct qcom_pcie_ops ops_1_21_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
 	.post_init = qcom_pcie_post_init_2_7_0,
-	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
@@ -1979,6 +1947,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
 
+	pci_host_set_default_pcie_link_state(pp->bridge, PCIE_LINK_STATE_ALL);
+
 	return 0;
 
 err_host_deinit:

---
base-commit: 681accdad91923ef4938b96ff3eea62e29af74c3
change-id: 20250823-qcom_aspm_fix-3264926b5b14

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



