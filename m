Return-Path: <linux-pci+bounces-4497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6C38717DB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A401A28173B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6CB80BEB;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqKr58BB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFBE8061E;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626486; cv=none; b=tC5PiE+ED8Ym+y3pvrXqTZOhZHbHITH+QPwlymBLcA+YC1XnHc04+p9FJlgtUPc2gM7BK6MiyAdVmtlFufmkTUqWZX7Vm6S0Vn8LnVsGrfu3POORj0sWOpQ07Jw95lNkitQ4nNnHlcBqIIYI/vL3LJdtLslFWWLDHr7v9dgnR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626486; c=relaxed/simple;
	bh=SZw49HDPW+I9QK3XYA80NnOgMYXXl4SLIPsCVKDM8ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYyL3CR508oego/lNPOMqcITnQCZxlv0tOH7r3kffeaUTiKnbyjm9FfR42yfqhLEbrIwSLwk2HpPYc0pQc60fQQy/iBBtzbVeF/uk32PW2tOHTdga0cHVTVPNGzxEO2mED09BVpa3s/Hvqyo//0cFEuSDtY/GpFHxD5iPjQF3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqKr58BB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D97BC43394;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626485;
	bh=SZw49HDPW+I9QK3XYA80NnOgMYXXl4SLIPsCVKDM8ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqKr58BB/iYxh02k23Ur3P9fLCPFNjcO6N9217KiQ8oegficJ6en3fvX1T1N9Kjmh
	 MH8jDXtFSNmxhxsQtDBLhpj1wVTtLTQCPW88UT2nJnUn3x6jrQTa944a6Z/vFX1FDW
	 OOkiVyQf7r0l9CA/WdyPJ9kK3JTnrpkcWT8/YTvAwCiWcaWmBjmAnw48E8PbKvE4Ye
	 fyKjbIzV42v4Z8ApuOC9LthatKBT/S5dymfkvsKvWhAU3AsKyPiv5ipir4Y1qpCptS
	 9ZL1+3GDxW0wcJ+bOcJq+PV6a7OqN8yLukrxZOEldY4ygRWUkzhoy/BbQ9iMf4q+ry
	 Tl5XaaQI119Cw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rhPwq-0000000037v-0FO1;
	Tue, 05 Mar 2024 09:14:52 +0100
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
Subject: [PATCH v3 04/10] PCI: qcom: Add support for disabling ASPM L0s in devicetree
Date: Tue,  5 Mar 2024 09:10:59 +0100
Message-ID: <20240305081105.11912-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305081105.11912-1-johan+linaro@kernel.org>
References: <20240305081105.11912-1-johan+linaro@kernel.org>
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


