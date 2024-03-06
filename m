Return-Path: <linux-pci+bounces-4561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA85387335B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 11:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6221F265E8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0EA5FB88;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2QhzLzv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392C5F48E;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719189; cv=none; b=JqdcaGappzO1eW8bO20CZMhuGKPryxfwx0kecU0o2HT4+nF2dmvPXOnGx+tOj7cHWuAc132gxFiAJifAkdUCgnqihNCglXBvSgV6IZ/fDAx5XqqMsN7nXAmkbXvQs0YZGyna8xR+HePyLLuMpAN6YOrrk2L9xSZOr6PCAH8jR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719189; c=relaxed/simple;
	bh=t19IiT6RWlcBi2EkLmBwm6R0bOy4AN3yK/qdKvg3904=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qW24b2l+TiLKyJc1Q9miWs4d9P7ZXQIUmf9AqjAvPKYlFSDij271p6R7k0eQAwZo+T4FX3UZX3qDSJj1yckYUwfIgfqQpe6lcXwvGFEHZNpAzTGiWSAeJERlrYez+o/W5TEnIL63y4C7nE42gQ1frbQPD+LJxdN5/PtIsD10IPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2QhzLzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26B8C433C7;
	Wed,  6 Mar 2024 09:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709719189;
	bh=t19IiT6RWlcBi2EkLmBwm6R0bOy4AN3yK/qdKvg3904=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2QhzLzv/eqvbYADTBQNp8scNPrLxqJc3iHNS48UYL02mXSsQWM7MSvJcGGHSmHzW
	 eVVuIzp9luJPJ6b179mzWpLxNecALAkAb/0CziPjiznWozJxRiqijdPruzwJGk9qrj
	 fXojX0xB+jz4yfmsRzHJy130nXQ6uxWzfYVho8+Km7DqVjyyzMaIlpxtOpQOypLIYO
	 mRH274NRnh7YTcV+dRAZ1GOP3G9DfKC8tb84d+35UT12lhT0hh/ANNdDl+0XxdEikf
	 PAhnMsTzFs1xL7j0a5JHIxLOIiS2LE1uixPgQSKQHsL9qvcqZtI7NEnJEZkF5zUJkT
	 tSobSI79sbVIA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rho44-000000001b3-3Ftm;
	Wed, 06 Mar 2024 10:59:56 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 3/5] PCI: qcom: Disable ASPM L0s for sc8280xp, sa8540p and sa8295p
Date: Wed,  6 Mar 2024 10:56:49 +0100
Message-ID: <20240306095651.4551-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306095651.4551-1-johan+linaro@kernel.org>
References: <20240306095651.4551-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting
1.9.0 ops") started enabling ASPM unconditionally when the hardware
claims to support it. This triggers Correctable Errors for some PCIe
devices on machines like the Lenovo ThinkPad X13s when L0s is enabled,
which could indicate an incomplete driver ASPM implementation or that
the hardware does in fact not support L0s.

This has now been confirmed by Qualcomm to be the case for sc8280xp and
its derivate platforms (e.g. sa8540p and sa8295p). Specifically, the PHY
configuration used on these platforms is not correctly tuned for L0s and
there is currently no updated configuration available.

Add a new flag to the driver configuration data and use it to disable
ASPM L0s on sc8280xp, sa8540p and sa8295p for now.

Note that only the 1.9.0 ops enable ASPM currently.

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Cc: stable@vger.kernel.org      # 6.7
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 31 ++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2ce2a3bd932b..9f83a1611a20 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -229,6 +229,7 @@ struct qcom_pcie_ops {
 
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
+	bool no_l0s;
 };
 
 struct qcom_pcie {
@@ -272,6 +273,26 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u16 offset;
+	u32 val;
+
+	if (!pcie->cfg->no_l0s)
+		return;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
+	val &= ~PCI_EXP_LNKCAP_ASPM_L0S;
+	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -961,6 +982,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
+	qcom_pcie_clear_aspm_l0s(pcie->pci);
 	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
@@ -1358,6 +1380,11 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
 	.ops = &ops_2_9_0,
 };
 
+static const struct qcom_pcie_cfg cfg_sc8280xp = {
+	.ops = &ops_1_9_0,
+	.no_l0s = true,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1629,11 +1656,11 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
-	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
 	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_9_0},
 	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
-	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_sc8280xp },
 	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
 	{ .compatible = "qcom,pcie-sdx55", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
-- 
2.43.0


