Return-Path: <linux-pci+bounces-44032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2275CF3FB0
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 14:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57DA730239EF
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EF433290C;
	Mon,  5 Jan 2026 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoFxAcbI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FF32BF2E;
	Mon,  5 Jan 2026 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621366; cv=none; b=MistjRLZxNRj7sjXb9YuFovOtPqvkr5e7Vs6GpHpL6cIfmDfMuCqlv3Hr6dRBiNHB2x9/91iVfgcWsyZ7E4o1JKC7XhmHVdyc5dUhcVSIGYqIzhO55KLy/mlopFBlQi1BBJb2Nj+apDHJ/6IoOlUXB+UdPCW4j+uoTTF/9jfx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621366; c=relaxed/simple;
	bh=I0f87bjCTZY8llByf6tVU8Cf67d/L6DylkhuokhPqjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CmRyTCYRbQ/yepu2gBTFpcwtC1NRgMPO45dj4I/3ohlFAlzCaVMS1FkY+aiZz2fMJcCy2YQpsKFNyeIpslOMYpLedP06m/Ub9o9TLoDOkZxUIV5lyVEYuseJklVnoEvL04GEPzp3Z6kpdlMQBzTbXCR/7PunbxA99o3IZ5V5eLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoFxAcbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C525FC2BCB1;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767621365;
	bh=I0f87bjCTZY8llByf6tVU8Cf67d/L6DylkhuokhPqjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KoFxAcbI+O6Lt7lP2pldvjDAqqUWO3lptqOmU3S4UNjjUIvq2AntiEd/5O2Xy6req
	 tqURiWbZ3Qf0707KmQR3Wu95iMqfBodLl8HGt+06GyRqWxPNEMsW1DDHqlP59kRRQJ
	 N/m9+a0KmviJW+TyCtPa+sbXNe+h+Xx5BMKF/C6l5KY0UQHnt1XN7TDxMHdn4+pUUa
	 yMNkdGYlU9mFK27QqPRcfMtkGJSXaMT+JnbIIROGd/yidGscgwfa0vHSC8oomUEeW6
	 G7xvONH8D9iNVVTNLXlzmhgKAlkH9Vj7yks5eeSEwmSKq+SaU7YmCig/WyncLz8EN9
	 aElRCUoiubNPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD198C79F9A;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 05 Jan 2026 19:25:48 +0530
Subject: [PATCH v4 8/8] PCI: qcom: Rename PERST# assert/deassert helpers
 for uniformity
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-pci-pwrctrl-rework-v4-8-6d41a7a49789@oss.qualcomm.com>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
In-Reply-To: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=NsPRggmF+WutEVzxJ+1fg6OdEWz3rN72PxavsxzAJAM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpW8LyZODhEFyx8+ElbRBxZdd+zdYJojC1HeXrE
 ARGhMlm0ruJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVvC8gAKCRBVnxHm/pHO
 9So/CACVFKIGwH6FtZVklizuGvtAsCqKZFrdwyrZWHIbr7YAKwWguXf2lI7kd/bGYZqXWNPCoaw
 lC6txH3YOPZmpwXiCE9d5wzXb5EhribQdfZPpbOWA3qe25HACIteCkCV2MpQsQk+HfFgc/63auN
 MM5dOVCHcUKEqyhI4MVFnU88RJpMpufhRrh8UqOifnpVedLR7O8yR02E+URioBsZbGo38+yUHpW
 zEQRbJStuV/ET5+737zK2b+GYSgWuNfcZKXlEfnR/EM+tu/10l3xIgFSfpJolC1XJpD7dUn9n94
 7WojLFtU26zOn3I0Wji1uNOS7SjLJuPdIbnVMi3OdgmIbgxG
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

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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



