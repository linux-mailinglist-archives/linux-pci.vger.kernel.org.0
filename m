Return-Path: <linux-pci+bounces-36273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A28B59D40
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 18:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E58132423C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 16:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D152BDC1D;
	Tue, 16 Sep 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRe0Sw8m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5FC2BCF4C;
	Tue, 16 Sep 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039190; cv=none; b=dO62JK3yDG7Nl6SM3pkuTuPH8Dd6LXMro/rorKyWWZAtwvzwLclfsannq4VabIHIDOQGMDuU2HIs0jkkjcjQYcrDzuUwpEBYecgJqOnmP1TJp5Cl0Tr5WxOGoyHGDVaYSoi4P7ySz0/wPGUiUTiBls3XrLByXRgstUm+X2eygeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039190; c=relaxed/simple;
	bh=nhZwLjBbK2lxiUbM3t8zFDAtYxpphbtAjNYYlri3ZUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKGgCVXcjynAj4Vv/kHvodjn5ActwpeDXZ8n8iVASkvP8mrZd93IJFJJ2mRE9gBZ4nwM6h2Fw6mPaUyaHiznuK1AKUx0Qg9vY6lW5f65R/hwsxj6cSozVYT6JsU9vvdHWWw3DjshCAnS6pedwxgR4pIdV2uIFPN44uSpkCYe3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRe0Sw8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C86EC4CEF7;
	Tue, 16 Sep 2025 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758039190;
	bh=nhZwLjBbK2lxiUbM3t8zFDAtYxpphbtAjNYYlri3ZUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vRe0Sw8mFbPALFrvpvM93JgBBTb8vNVpSo17ARfesbjLoNPviK3zMrBvPmJpLttbs
	 oQ+iAk9HHoVGxD7k+6rH/LeZsegj1u9FttFjhGLOAfzQ1Lj5a0+Lyuo2TogmMbupbC
	 ti5B3I4YDY6iLLpY9mfXp9frsxuDmg6JCX0X5+FVSupavXczac98jpM8OY1pCpjGEz
	 AY28jiR2ZbeT2fsCZb6XtdVONLP3XFQYPo/N6AJDntfq/0wOVjIdftOvYMM2d6gZdt
	 9W8J5IFMHd7tmk/upHc0LI5lOJYWlOneO5twMxTf/RMX46u8w7uDaAaK1wrPJq7puN
	 uWYnEy80nvzIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D9ECAC592;
	Tue, 16 Sep 2025 16:13:10 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 16 Sep 2025 21:42:53 +0530
Subject: [PATCH 2/2] PCI: qcom: Remove the custom ASPM enablement code
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-pci-dt-aspm-v1-2-778fe907c9ad@oss.qualcomm.com>
References: <20250916-pci-dt-aspm-v1-0-778fe907c9ad@oss.qualcomm.com>
In-Reply-To: <20250916-pci-dt-aspm-v1-0-778fe907c9ad@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3086;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=v+JInE9O8Tswt5Gb7HgmBeTnkIFZVhVGNtOszvn/Reo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoyYyUK92Y9Hk/YDUED8Qnpzv5tspszujaDTdSe
 cIRz9x6xTuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaMmMlAAKCRBVnxHm/pHO
 9WVcB/9K6OcVd3VxKpE3xwCCevGn8evTpp/gGbH9Ca/IxDN7167JcoAou+d0EQI+VP50snw8Yrz
 0r4s5nbsp1sK4yJnpUuWsAmNtYzg/v1baXQTBPvwXjJ6u21I11J5xj5mZUsTah3/sRW2sn5zq3W
 +9EzK0gP+6/LzlX28jIjIlCYEUyM+nDcUsAGeBCXyd1Qc32hG5P1JEiIyzrIfflI+JPSps7EloY
 RpMU7ruPWY8AHFYO+4XBezZAGuaVoS50TAo/eNmk39lHvmYW9yaSxaLXBb4mvL6vvycO1XKaK3A
 cQUDUeuBWZOlfitJSgadqLgAL5kbMCH/58+mA1Isju67HQsI
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Since the PCI subsystem has started enabling all ASPM states for all
devicetree based platforms, the ASPM enablement code from this driver can
now be dropped.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..a1c4a9c31f9241e9ca679533323e33c0b972e678 100644
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

-- 
2.45.2



