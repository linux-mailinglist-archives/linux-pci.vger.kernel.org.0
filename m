Return-Path: <linux-pci+bounces-43817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 879BDCE7BEA
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 18:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B651E3001BFC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ED8331234;
	Mon, 29 Dec 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1PVNPus"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AFB331219;
	Mon, 29 Dec 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767029226; cv=none; b=TraxIEKP0kvvgydD2JOQuWBInF8/1J/tZltcORCyvcG11G8oelbpSwVTpatHfk8u0GS2yjM+UpIY+Rm9ZMUakDTwRSZi43FyIeo8OD79aVx2gTqI0FrwJ1xiJ847x4Za0viJaHfBIvihqfpr9idR+IVH4dq709Zswb3GbWGUPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767029226; c=relaxed/simple;
	bh=TXzF435WU9VYp7LjFqBeYRn1UNuJt21HFOqXY6px3dE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KfEGsh0A/GcLg5lC0IBNIa6wLWCdk16DWZXadRrBveQAD0eP6EENHF3q0KA/DQ5nYi/ItOTUHhhr99xjipGL/pEs2crbObCYPO43Nccf8GFtul2aD9b5JKrypEZhukbm3i6Gc8oPkPcxD/q2PztBlz/UX/CXFUZgJ1msLuwi1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1PVNPus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AB66C2BCB0;
	Mon, 29 Dec 2025 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767029226;
	bh=TXzF435WU9VYp7LjFqBeYRn1UNuJt21HFOqXY6px3dE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M1PVNPusH2ZCgl1552zA0L+BCDMUTzHiGAARAFMjsJQQXUzt04VoZoLYSv1y39KqB
	 yJqG+6IlQjzVi55MdgEg8MgPKSBm/G2cTyx+AkQlbo6lVXifesNWkYJWYx0RD2ZMhF
	 cEYjStfnStKk8Mu9GbWSysRmUHDCHjPiUgaTABKEvm8e/R3eJrU4eBBjKzf7qzDC/C
	 6v8+T01c6mgBzT5WyLTn+/EV6U29ct7koEjdNQvez+HWTvTqPNVtO8EJYZjkTtBsSL
	 H8EDSktys4tNbF//J7/4Yr9ZT2QVTdo0OFDGrBjZM9xH+Wfk4qo4gGfEXNG3XT7+x/
	 KebW3MkqA07Tg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DFBE92FC5;
	Mon, 29 Dec 2025 17:27:06 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 29 Dec 2025 22:56:58 +0530
Subject: [PATCH v3 7/7] PCI: qcom: Rename PERST# assert/deassert helpers
 for uniformity
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-pci-pwrctrl-rework-v3-7-c7d5918cd0db@oss.qualcomm.com>
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
In-Reply-To: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2787;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ncgLgkMFVujyqBgktgUh6eUIgflyWGjZ+0g78z7CeOY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpUrnmxi6KB+fRNxWX9kzeLNU/o+gpdx3ATVtCN
 E8mnmZRMHuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVK55gAKCRBVnxHm/pHO
 9SGVB/9qNDupQXRtd6KkRvL/8ZQmLIK8PPOxYnAv+XWBcVDtUJZsvKBpuAr2T63C2b7nwKt5yYK
 ji7HpnUOUCVvMgp1GbAOQSDltv848Cq+i7DYOuuydEmPGYjdYKPCHQ128NZa1V+yq3bBY1WLQUE
 JnKLLsMXtIsGO5b9mI/Iih5bXpBb9o5LW+RIdvGvHdtOtfRRWvqXqD4e1whoLUkyZNgpTVnrVQU
 zjz7Vu8uDWRmjYpCtHvsgoMBz42lYY3LukkEZXksVDH5h0bs9gc5If1hC6Jl/isCB0Xei31lKYx
 Iz+zt+K3GT7jKPflQyGdOH/3o8yWbsbDnU2BIUeuNq6WBVKd
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Rename the PERST# assert/deassert helpers from
qcom_ep_reset_{assert/deassert}() to qcom_pcie_perst_{assert/deassert}() to
maintain uniformity.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6de3ff555b9d..a9293502e565 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -295,7 +295,7 @@ struct qcom_pcie {
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
-static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
+static void __qcom_pcie_perst_assert(struct qcom_pcie *pcie, bool assert)
 {
 	struct qcom_pcie_perst *perst;
 	struct qcom_pcie_port *port;
@@ -309,16 +309,16 @@ static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
-static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
+static void qcom_pcie_perst_assert(struct qcom_pcie *pcie)
 {
-	qcom_perst_assert(pcie, true);
+	__qcom_pcie_perst_assert(pcie, true);
 }
 
-static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
+static void qcom_pcie_perst_deassert(struct qcom_pcie *pcie)
 {
 	/* Ensure that PERST has been asserted for at least 100 ms */
 	msleep(PCIE_T_PVPERL_MS);
-	qcom_perst_assert(pcie, false);
+	__qcom_pcie_perst_assert(pcie, false);
 }
 
 static int qcom_pcie_start_link(struct dw_pcie *pci)
@@ -1296,7 +1296,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 	int ret;
 
-	qcom_ep_reset_assert(pcie);
+	qcom_pcie_perst_assert(pcie);
 
 	ret = pcie->cfg->ops->init(pcie);
 	if (ret)
@@ -1322,7 +1322,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 
 	qcom_pcie_clear_aspm_l0s(pcie->pci);
 
-	qcom_ep_reset_deassert(pcie);
+	qcom_pcie_perst_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {
 		ret = pcie->cfg->ops->config_sid(pcie);
@@ -1333,7 +1333,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 
 err_assert_reset:
-	qcom_ep_reset_assert(pcie);
+	qcom_pcie_perst_assert(pcie);
 err_pwrctrl_power_off:
 	pci_pwrctrl_power_off_devices(pci->dev);
 err_pwrctrl_destroy:
@@ -1352,7 +1352,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
-	qcom_ep_reset_assert(pcie);
+	qcom_pcie_perst_assert(pcie);
 	/*
 	 * No need to destroy pwrctrl devices as this function only gets called
 	 * during system suspend as of now.

-- 
2.48.1



