Return-Path: <linux-pci+bounces-36699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C845B922AC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 18:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7832C1902F7A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8203112A1;
	Mon, 22 Sep 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYSOnV80"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE041662E7;
	Mon, 22 Sep 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557814; cv=none; b=qiuOqeUxvf3UvQPObnrGTCmpAL7+uIqKNki3RqT/V6lmfqsgKNxk/Ugd6oIdUXf7sqUAPEsm/pozsNMkpSNmEnfaY2D6peBTgDb1UpGidXAxALGQh9MwJVML7DZ00m6r2NfUsjKtQX6uWBSb1oNbJKIB6mg4Y6145vJ3Qsu/VX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557814; c=relaxed/simple;
	bh=40eGwaZGt0426y8h5tNB3LgiDgmJeajd/RksG77m4nE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXPFZyEkHXkBo87MI3gzsBghWdlDKRu6fMmHJmCJJmbMC1mnuxt2FGsM+1iS2wF4+qT6ociJMFkudMGDnGXYKpfzZ6reJkKla1kT1QdRvmVF/SECntNiUKXcc5oF3q9p9COv8/ad2FaUere/IJj0BuRvTreANqpmTOEeysrN0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYSOnV80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79C88C4CEF7;
	Mon, 22 Sep 2025 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758557814;
	bh=40eGwaZGt0426y8h5tNB3LgiDgmJeajd/RksG77m4nE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rYSOnV80/tC/gg2PuDA/UErh9WG8OaOyBxFLDAEgpw+vaIaA0EMEQJtmokhIfNyQ1
	 yWwIx3QWIxFBkYZjE/PTSwOkAqQ00kqQUkyPe0KEm4dcDSQTP5mgj0DopToHIthvcK
	 FlZQ4x4m3BYbYJlUS16vxZGR9iIJWsfDtIGsujjw7BAZO6ytU8E6Zb69q6/vltHCrB
	 jF/s+quYxO1oAF9B+QaWhY5nuoEA6yOhqC+H68WgcGSaofxRW9dsPwzUZJMLMn3U3u
	 eNQ0a+75otjlcXUyMgzF6Chf15BWNVcLAJxXDfE+s5GUnTh7eAE5uGkP4mmsqiaKJc
	 SIfXGGnxDK3bQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1ABCA100F;
	Mon, 22 Sep 2025 16:16:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 22 Sep 2025 21:46:45 +0530
Subject: [PATCH v2 2/2] PCI: qcom: Remove the custom ASPM enablement code
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pci-dt-aspm-v2-2-2a65cf84e326@oss.qualcomm.com>
References: <20250922-pci-dt-aspm-v2-0-2a65cf84e326@oss.qualcomm.com>
In-Reply-To: <20250922-pci-dt-aspm-v2-0-2a65cf84e326@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
 Kai-Heng Feng <kai.heng.feng@canonical.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Chia-Lin Kao <acelan.kao@canonical.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3174;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=tvss3MdfYHL+rXNvlS+8nnRAEkq4Tu6jTREwynbA5UI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBo0XZ0zMPEa/DPJ+/ZwL1+RCq8cOUUe8oEBjqgD
 MnAAtPBIMSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaNF2dAAKCRBVnxHm/pHO
 9RYKB/9IT1Etlbn5Ys0d/XY24CXy3zkX6IKyRfYR1n1iRay5ZzhNSw3l8xWyKGzikZhWbZKvqCN
 YFb4fC/NV2gRjhsUUL78m0950MpeXr7LsIw//RAVZoHXCsbj6nVGq8A+uBSN4B9s9t2E8O6xTeu
 zn+ufAd3a1LhgLxmzLrEVXe9Dp3DHdi9F5JxMC4jXhX1QJ4xiQI4iMkwEJAOoZQaPm21/XV6TTF
 aRWtnJxR/DTo5hXi7swpOxEdC7ToW8sgb8z49qDWWk7BE2m5WOd3g/9FX7OAxGP/63Xzm4JYRg9
 w2gqZY7EgfwuNYrphxzXvjgzEHnAToXve4Xsweck19w9g0iI
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
Link: https://patch.msgid.link/20250916-pci-dt-aspm-v1-2-778fe907c9ad@oss.qualcomm.com
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
2.48.1



