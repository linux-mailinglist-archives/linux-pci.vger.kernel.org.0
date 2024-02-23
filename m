Return-Path: <linux-pci+bounces-3934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645F08615A0
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 16:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964091C23FB7
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7866482C7E;
	Fri, 23 Feb 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOTuRidG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2583A03;
	Fri, 23 Feb 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701788; cv=none; b=hbec8dflC5S7s91RBP6pVaAgDhMczjQ7wEyy5Yo9ZrJVGcfFchxQWiTTQKq1z2Zz4IqMIHmJnXiNB2vcLevcdsIrjBSuXWhrGF5xjPX6GjmKkomLRgByRkJFR8vQjS2zWQTsfCNmYvgnXbcw/WOTDK2cmURmfcXVqv4NTWYkkps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701788; c=relaxed/simple;
	bh=+MZNQen3wcYHTNycJniWNvbay9tcVWDXKsVdslC0djE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBtIAcMEr1r2cRjLnROtygymYwemCt1EbYte3qNRWSONDkGq4D0j7ivfV3cvZyzdirUfdnnLjDdg3GJB7soglysIxE7hUU3e22+jKrCH1OpVWK8oc+59VcLCD+hJA6Nq8HL6JZ5231nBHgn2YXp8JYts7bJ4rTsGK7TERsfoHG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOTuRidG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98205C433B1;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701786;
	bh=+MZNQen3wcYHTNycJniWNvbay9tcVWDXKsVdslC0djE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOTuRidGnMQVuYfe+pILwzBb1KejZ6SdNH5TybZzzp0ZE51C+sdgTDdjy3KDp19HJ
	 zmvwwGLN7Z/gL9Kd2jBapVUZ/AN9825OlvtsFegQ+AWLMPq9uML2LKUj+sYKgMAgqf
	 M7O+Qm0MHlzYf9FiHAZFV48eJEE3VGan9R9QP09tapmCPAiOU5WqeLwP5GFd4gV+6C
	 +3PWB/iSV/+mEhlUoOts/CCQI584PNxJCPq4+T7zyE6GEePehLNTKfZAkNtzp9yHZG
	 Dq53LJql+qwxam9g4WJU3cHTjIMqdtiODX+x4leBpT2cYWjsZBvQ6DXNlANPeCcgk/
	 fjkNuQfBDW8GA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rdXOJ-000000005Fb-0VmY;
	Fri, 23 Feb 2024 16:23:11 +0100
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
Subject: [PATCH v2 04/12] PCI: qcom: Add support for disabling ASPM L0s in devicetree
Date: Fri, 23 Feb 2024 16:21:16 +0100
Message-ID: <20240223152124.20042-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223152124.20042-1-johan+linaro@kernel.org>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
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
devices on machines like the Lenovo ThinkPad X13s, which could indicate
an incomplete driver ASPM implementation or that the hardware does in
fact not support L0s.

Add support for disabling ASPM L0s in the devicetree when it is not
supported on a particular machine and controller.

Note that only the 1.9.0 ops enable ASPM currently.

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Cc: stable@vger.kernel.org      # 6.7
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 09d485df34b9..0fb5dc06d2ef 100644
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


