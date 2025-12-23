Return-Path: <linux-pci+bounces-43563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FD5CD8905
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 10:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 781F43051170
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 09:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13AE322B70;
	Tue, 23 Dec 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0kAJaJV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BCulNzoI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C888332252E
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481405; cv=none; b=fjAsCortwjBfBR/zZdRsEihoqtK7EMiSf4sRzy67DYdLHA1EHKHlcvrptrZEc2f6t5r4jPZSsv9lgrOeWxoJ8jIBEoHSzBfbqTB0NE8dpUR2Xi/2oD9FDbLFoYUCFYeLsYxLL5dew3NCGDoxD2/vn3E0gvsA/Zc1rxJgsu165ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481405; c=relaxed/simple;
	bh=FQR6dsDhey4ML3/SnqgASnTn8AJ/5HU7zdmwI4k5tMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/2p2lv+xcGM0JCPVx6bddgiSKkTI1G0UOxDO8FoG8nQCZAlSYxKqmMo2eBrxc4JgHLuH60IvJyaKDFzSMxkEIQZ6U3BywsLtMZRTzI/L3yLr5fkJn2yD9bHfoHMrdAjWJc5HXhYs3huel6SZUmYqckYJCUMKri/t6/8amtxoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X0kAJaJV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BCulNzoI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN33Q412199005
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 09:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wck3tooHoIpm+N+wymmifuiIrLisQvtGlc+efrbARJc=; b=X0kAJaJV9gtGXT+V
	gG3BHNsALuk3S/UVZk5cE/9NQ0cXytliX2p0gOB/bleL3bTEExCH3Z5gcei2c3NM
	5Tj0ow7tf/QHl9BkG7F0yWK8oOkYtG90p4i6+Ag974byle/X8t8Pp0olsCqZh3lT
	kroJ+0myYE/NB/R1cHtQXmZF38/gQ2T2JgYyQPxbLN6hMQGrAkXUdhrk/iGOL5lT
	qNDYthwb5cLHBaFWoa0SAJsfusNPKxQOQvlJVBqNfLLdMCKUhZWBNkZAoR3lj6q3
	dwSDMFjJ/+rRza3yKXvkUHC+fM/Zknp2louxY8Lzsbd1/CR+15xs/U9JZdZScfgg
	udrnhg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b73fwujv1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 09:16:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f1f79d6afso69043995ad.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 01:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766481401; x=1767086201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wck3tooHoIpm+N+wymmifuiIrLisQvtGlc+efrbARJc=;
        b=BCulNzoIqs8tZB1cBHspm0ARPcXwTvE+QyPEck0/sfJ++zHdF0MKvoKZltUR91vfBs
         aTXKAKtMVDhM5dxnCFUNLtwMgqrOCmLNwxk7o/9/+Nsh0L7bQww6rMcKnrJOEEoceX+y
         en8SNvfzMrbqHYZjtWDX8TGdjD38TDQp9fBGhqYu27/ywgM+BZKBuk0q+EI1D7UorURf
         rpMYkCDeqOFdjaGGGKbOlgxBV1AzQqErE5JTrqqmBx4Tipbg1zHhRi/Gqxeiy9mRBguV
         r2GmzlqopEI8TPNXmXSmu2z3UR1WbDAp3kCJFh2TdrbYyVAuK8COXVdxtA6c6bLumQ2r
         2Skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766481401; x=1767086201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wck3tooHoIpm+N+wymmifuiIrLisQvtGlc+efrbARJc=;
        b=C0e9Nz0C0DSe2ZO+EGc4Pa5gC9L7zCon33x+88pFN5h1L3xuQN7EFseULiwGVeyFyS
         rJpfKoA9Y5XgsMUsLqlO1eoqm3PNfeYvNG9MnJnljCzoxQLUfFQFIWLwm1XJL9imBelU
         8rZNsRqttl5petS8ppiYgnSh1MzrfS7Wa1VNAewBnJQndiJ/VQFHbREThlJePdhTbHoK
         4WPPfrR274JjMU0auQmTD2VKHZXX+wvLXXZjIgPYzU96jgcg1oGh4WX4H5kfjJTqjp0t
         CUkhcqLjWfljntX/IoQnA51WdMB9wZpNFXQe3zxJCEUsQjQI+3mCvESX7ai+woGokhTU
         ozlw==
X-Forwarded-Encrypted: i=1; AJvYcCXmvKv5DGWumkffdb5PNAwvtc4YL0l/ainkQlmQ/l3lkm8+5A9FRWOMT/rjGbe3uUfItyjs/7lLkz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrR58eQAFPC7waz0K0nhW5nX0HYOXuKBgPDMkVJfds/TKp96+A
	syGW44biMC3Mmz3l6uaX68G5h3DgPR/Gl2sVosoi4e+xNH+uLbM83yv698FWkdWFKtlCcFks66I
	D4Gi7kv6mCdaZPKX8kzdrSTRJi6UihuxcfNL2lOnNKWitQWfGFsY4AJ8BDYP4W9c=
X-Gm-Gg: AY/fxX5hgfCMMht98W4QB+4RlZQWtUX5JohQZZdkfAjLnXricmDUj4Qm74B5oZdn2+J
	ptrmmBkhMmdJD7DJNWJHv+/1h3G91JJQkyBsrA5d5VCJE64TlgIQfX4Y+ei6oMHdYneTuxGp6l+
	p6XO1Nj23kaSgow3fqARo52kpWYtWllybsgMpsevcLlwbI6Dm2EH+GXJRrnhI8LPozv5lmHAuMX
	O1kaGOBSn0OxnrdXZ2Uzajxd53Ze4J05WC+wLi+Vcyb/JZhRJFN9VSa41iZzxmEjIAnRUcY0mhw
	/6hk5+/lo9ivgDTXz80D9xWSWH4JZM1k14TQcn/TjHhAcOkWWOer7XUJPttla9AR2B57SdE8qCW
	XxI5hfTUtlVGnMMWW4qTJYR8zG7Iq31cCo3ixvZX/n/M=
X-Received: by 2002:a17:902:f607:b0:295:9e4e:4090 with SMTP id d9443c01a7336-2a2f2a3cea1mr147985935ad.52.1766481401099;
        Tue, 23 Dec 2025 01:16:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGAlirpRipXROZCpS05BoTq9KBagcVAGGY/9W/gwY/p8mc5A9aZsoe19o4/W4AFLBj84OgUQ==
X-Received: by 2002:a17:902:f607:b0:295:9e4e:4090 with SMTP id d9443c01a7336-2a2f2a3cea1mr147985625ad.52.1766481400579;
        Tue, 23 Dec 2025 01:16:40 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d76ceesm122507585ad.91.2025.12.23.01.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 01:16:40 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 14:46:21 +0530
Subject: [PATCH v4 2/2] PCI: qcom-ep: Add support for firmware-managed PCIe
 Endpoint
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-firmware_managed_ep-v4-2-7f7c1b83d679@oss.qualcomm.com>
References: <20251223-firmware_managed_ep-v4-0-7f7c1b83d679@oss.qualcomm.com>
In-Reply-To: <20251223-firmware_managed_ep-v4-0-7f7c1b83d679@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com,
        konrad.dybcio@oss.qualcomm.com,
        Mrinmay sarkar <mrinmay.sarkar@oss.qualcomm.com>,
        Rama Krishna <quic_ramkri@quicinc.com>,
        Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
        Nitesh Gupta <quic_nitegupt@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766481382; l=5973;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=FQR6dsDhey4ML3/SnqgASnTn8AJ/5HU7zdmwI4k5tMI=;
 b=gHqcLb5AxDUo4lpP8X7bw3fYrqHjmrb5a0i7fj1QHAbdfgxhDblVvGMmkwC9NBmL76WidEnwF
 B5+Uv77H7iKBjUH23UUXIwKYYzN8hssovpwByoPaFZ9nVRYlV+lCdVy
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Authority-Analysis: v=2.4 cv=ELgLElZC c=1 sm=1 tr=0 ts=694a5dfa cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2tdM-IJ1x2Ue4swjlzoA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA3NCBTYWx0ZWRfX5yPTo8jtVZvo
 lBCZnRzzD+x6a5Hiz3xTsCE3WdWkGQNHafPeXXxhncMAPQBarg9q2xPl4TCf8INbopDVeBO+TcP
 /d7iJ18ot/ZR1DAdSQ9Gi8J45BLFlzzhP5XwdbtA2qELItWe6Vf6dpZmjEWTXjUbf+n/V6dJb1f
 yVWOeQR6Fl+TtXgoiLtovTHbKi10lODCE4S3YNoK8XUeQdtpfjSJs8tjwTYrYq3H5nA6r9x1omZ
 CaE/bFeGxk1URy5xUeIbmiSUfaE9ss7w+eihSV0XYdqUFfqnF2etBE6FAOtKRJPkzXeZlBoeAPd
 wbdqAISg4TGnuZ1Z4slwyjT8QgmbXsc+2FNGHghr7l+YUYM5ZgXT2QMg2U4Khwsydie30eY/vlF
 X9obHxlvTkSrFHIbP0zrPIioBEaUR1rDiA58MYTXFSwX/F70rX3xvGK7jGbknhV7gsMM+jIjD+q
 pECZnJowUGhqLO0uUzw==
X-Proofpoint-GUID: BmxhMLD4zfl8BkeOomajeVxR1AdL5tRQ
X-Proofpoint-ORIG-GUID: BmxhMLD4zfl8BkeOomajeVxR1AdL5tRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230074

Some Qualcomm platforms use firmware to manage PCIe resources such as
clocks, resets, and PHY through the SCMI interface. In these cases,
the Linux driver should not perform resource enable or disable
operations directly. Additionally, runtime PM support has been enabled
to ensure proper power state transitions.

This commit introduces a `firmware_managed` flag in the Endpoint
configuration structure. When set, the driver skips resource handling
and uses generic runtime PM calls to let firmware do resource management.

A new compatible string is added for SA8255P platforms where firmware
manages resources.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 82 +++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index f1bc0ac81a928b928ab3f8cc7bf82558fc430474..3c7c2dc49f928514930f304421197435f391d88b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -168,11 +168,13 @@ enum qcom_pcie_ep_link_status {
  * @hdma_support: HDMA support on this SoC
  * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache snooping
  * @disable_mhi_ram_parity_check: Disable MHI RAM data parity error check
+ * @firmware_managed: Set if the Endpoint controller is firmware managed
  */
 struct qcom_pcie_ep_cfg {
 	bool hdma_support;
 	bool override_no_snoop;
 	bool disable_mhi_ram_parity_check;
+	bool firmware_managed;
 };
 
 /**
@@ -377,10 +379,17 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 
 static void qcom_pcie_disable_resources(struct qcom_pcie_ep *pcie_ep)
 {
-	icc_set_bw(pcie_ep->icc_mem, 0, 0);
-	phy_power_off(pcie_ep->phy);
-	phy_exit(pcie_ep->phy);
-	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
+	struct device *dev = pcie_ep->pci.dev;
+	int ret;
+
+	pm_runtime_put(dev);
+
+	if (!(pcie_ep->cfg && pcie_ep->cfg->firmware_managed)) {
+		icc_set_bw(pcie_ep->icc_mem, 0, 0);
+		phy_power_off(pcie_ep->phy);
+		phy_exit(pcie_ep->phy);
+		clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
+	}
 }
 
 static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
@@ -390,12 +399,22 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	u32 val, offset;
 	int ret;
 
-	ret = qcom_pcie_enable_resources(pcie_ep);
-	if (ret) {
-		dev_err(dev, "Failed to enable resources: %d\n", ret);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable endpoint device: %d\n", ret);
 		return ret;
 	}
 
+	/* Enable resources if Endpoint controller is not firmware-managed */
+	if (!(pcie_ep->cfg && pcie_ep->cfg->firmware_managed)) {
+		ret = qcom_pcie_enable_resources(pcie_ep);
+		if (ret) {
+			dev_err(dev, "Failed to enable resources: %d\n", ret);
+			pm_runtime_put(dev);
+			return ret;
+		}
+	}
+
 	/* Perform cleanup that requires refclk */
 	pci_epc_deinit_notify(pci->ep.epc);
 	dw_pcie_ep_cleanup(&pci->ep);
@@ -630,16 +649,6 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 		return ret;
 	}
 
-	pcie_ep->num_clks = devm_clk_bulk_get_all(dev, &pcie_ep->clks);
-	if (pcie_ep->num_clks < 0) {
-		dev_err(dev, "Failed to get clocks\n");
-		return pcie_ep->num_clks;
-	}
-
-	pcie_ep->core_reset = devm_reset_control_get_exclusive(dev, "core");
-	if (IS_ERR(pcie_ep->core_reset))
-		return PTR_ERR(pcie_ep->core_reset);
-
 	pcie_ep->reset = devm_gpiod_get(dev, "reset", GPIOD_IN);
 	if (IS_ERR(pcie_ep->reset))
 		return PTR_ERR(pcie_ep->reset);
@@ -652,9 +661,22 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 	if (IS_ERR(pcie_ep->phy))
 		ret = PTR_ERR(pcie_ep->phy);
 
-	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
-	if (IS_ERR(pcie_ep->icc_mem))
-		ret = PTR_ERR(pcie_ep->icc_mem);
+	/* Populate resources if Endpoint controller is not firmware-managed */
+	if (!(pcie_ep->cfg && pcie_ep->cfg->firmware_managed)) {
+		pcie_ep->num_clks = devm_clk_bulk_get_all(dev, &pcie_ep->clks);
+		if (pcie_ep->num_clks < 0) {
+			dev_err(dev, "Failed to get clocks\n");
+			return pcie_ep->num_clks;
+		}
+
+		pcie_ep->core_reset = devm_reset_control_get_exclusive(dev, "core");
+		if (IS_ERR(pcie_ep->core_reset))
+			return PTR_ERR(pcie_ep->core_reset);
+
+		pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
+		if (IS_ERR(pcie_ep->icc_mem))
+			ret = PTR_ERR(pcie_ep->icc_mem);
+	}
 
 	return ret;
 }
@@ -874,6 +896,12 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie_ep);
 
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
 	ret = qcom_pcie_ep_get_resources(pdev, pcie_ep);
 	if (ret)
 		return ret;
@@ -894,6 +922,12 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 		goto err_disable_irqs;
 	}
 
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to disable endpoint device: %d\n", ret);
+		goto err_disable_irqs;
+	}
+
 	pcie_ep->debugfs = debugfs_create_dir(name, NULL);
 	qcom_pcie_ep_init_debugfs(pcie_ep);
 
@@ -930,7 +964,15 @@ static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
 	.disable_mhi_ram_parity_check = true,
 };
 
+static const struct qcom_pcie_ep_cfg cfg_1_34_0_fw_managed = {
+	.hdma_support = true,
+	.override_no_snoop = true,
+	.disable_mhi_ram_parity_check = true,
+	.firmware_managed = true,
+};
+
 static const struct of_device_id qcom_pcie_ep_match[] = {
+	{ .compatible = "qcom,sa8255p-pcie-ep", .data = &cfg_1_34_0_fw_managed},
 	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,sdx55-pcie-ep", },
 	{ .compatible = "qcom,sm8450-pcie-ep", },

-- 
2.25.1


