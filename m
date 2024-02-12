Return-Path: <linux-pci+bounces-3352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF30851A19
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E35E9B20B93
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7920C3D56F;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJeVWBXD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE93D3A5;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756819; cv=none; b=C8mddkwkVKSIEbSon21BfDqO9+WJR4S7DHmQd6NOunZoBzOtLxIX0VrTz4hLHTV+h9yyrcDS2kxe+61vF2hRRqKMBRuRAUwzUX4uvEE9Rd/vJRcdRiDcCapHci9iJkFcLX51saLDmPq4dvVnpTaf5zPTYE4LalMlo8SzRy8l7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756819; c=relaxed/simple;
	bh=FW7pWyR6CDbZpSvqQAnPnh3O0BgUJoHXgLMGGLsnOac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7sYFh9FF82DjIwARA6I6b7ruy7MAuULifm2rwrXOl/Y6b/pEW1Dsru9U9wKY04iIJmGF0KVotqY6Fc1I495PyCOc4b+i7e+D+SBkZaVFWkaTuujPYZ1pkHVwlyt9wWmYt6qV9KohznLk4sIScXkryXEd+VNuO+sbeRZDMDa2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJeVWBXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3619C43390;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707756818;
	bh=FW7pWyR6CDbZpSvqQAnPnh3O0BgUJoHXgLMGGLsnOac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJeVWBXDa0zorvvqAbyrlHXWCaGRup8RZbadOxfQrtGqDt/6zQKGpjvLuZbVoZLjK
	 MnZNItAjt20yVUEilA7r5PXQ3hS4M7BBFZc0egOrZ7d3mU+mXl+ENkQuvqMpTXva97
	 GDao5hw2Ns9PmMpJ2Nd7/LLTQApVIco45bkwmGctYJ6TECGYEAwf1yBz+CFYabZ5E7
	 reXZoLV+xf3V4ZGFJCmUPp2Mf1uV6YlNSqgmQUkkxRrNeBhYtKcbMjZLdHOWd9XDJF
	 +GgCspH9nSSzWMJO3qP96ZWpp8fLhakLFmtwaIOemQ52rbrg7ycLHnQCGMoIPR+IzJ
	 +aQBu6xTozjkQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rZZZ2-000000007ND-3qOe;
	Mon, 12 Feb 2024 17:53:52 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [RFC 08/10] PCI: qcom: Add support for disabling ASPM L0s in devicetree
Date: Mon, 12 Feb 2024 17:50:41 +0100
Message-ID: <20240212165043.26961-9-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212165043.26961-1-johan+linaro@kernel.org>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent commit started enabling ASPM unconditionally when the hardware
claims to support it. This triggers Correctable Errors for some PCIe
devices on machines like the Lenovo ThinkPad X13s, which could indicate
an incomplete driver ASPM implementation or that the hardware does in
fact not support L0s.

Add support for disabling ASPM L0s in the devicetree when it is not
supported on a particular machine and controller.

Note that only the 1.9.0 ops enable ASPM currently.

Fixes: a9a023c05697 ("PCI: qcom: Add support for disabling ASPM L0s in devicetree")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2455decc574a..071741b81644 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -273,6 +273,25 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
+{
+	u16 offset;
+	u32 val;
+
+	if (!of_property_read_bool(pci->dev->of_node, "aspm-no-l0s"))
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
@@ -962,6 +981,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
+	qcom_pcie_clear_aspm_l0s(pcie->pci);
 	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
-- 
2.43.0


