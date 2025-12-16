Return-Path: <linux-pci+bounces-43127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0385CC37AD
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 15:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFA1130559B0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 14:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8817235C185;
	Tue, 16 Dec 2025 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fvP6jVzV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RBwF6von"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6235F8A0
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892980; cv=none; b=TWTfHlIv6dQiMOuH6avHf4NTnSPFgLZw831tyNO1rf1HZORFGstaA6A/5u4HGLP5eDMqmNupW7RLdP67kEFs53/W77NFRCQWz6o5H8aUxpK3sSAqbXrD+/CSTWclrSJlnyRMv7K1lRxFutiq6vKc90n0RXkcmBOz0DvuYlt6NrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892980; c=relaxed/simple;
	bh=Fyphgpm9oWKQhl4y6fHTvk81D6ocscTgp2cQazg94DE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpKHvhejXbD3+pV3D8QCirS2yVbgK4BWRFj+QzUnoj1nn05FldqVbimmXzqUUwVyndl7ixaDnhmybUNLIr0GiY64RbPwugLpnF/H+TJsDcNzaZFNHVEY4KdtjBm5G6dj9Rohk6fQ/520jNod26JyNRFfnRUxLjKUdR09epb5sFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fvP6jVzV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RBwF6von; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGD90sT2869759
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 13:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x7/Mz5RzhnX1QZHAKW86jmwpiy8TOBH4L00hU7AiSmY=; b=fvP6jVzVKS61kc3x
	zKhw1sdeRl87LvJEyYqTH2j40jDeUX1Fn1e6WmLIqW0yTl2cFyehLsOQUf7wGxcz
	gxQb9KiXrlYYyykG27vnSmHKA5ncLlr3E5SaENFXobZ0UPvR/G7xrQ2z9PCVj4nM
	5FiB52J7eTNCBhEqqC8Ws3O3VHHoE/aKrh5qPAVEOe1vxrC/zn6uL0TaxARbicGs
	gmHFNwLzh352/dsgal0UrM6KiBO4Hy4RZb7ONrCsMTZa9KN3d4AiKx8YaM52xmoN
	IhqEoAjuiiWYtx80MXinUbIQoWSmh8jTy3KPna2rdi0kC7Vkoan8v5FHN7ulYyBz
	dL2NGg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b33kw9d6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 13:49:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0e9e0fd49so25475495ad.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 05:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765892977; x=1766497777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7/Mz5RzhnX1QZHAKW86jmwpiy8TOBH4L00hU7AiSmY=;
        b=RBwF6vontysnVDsTmjEps7whm1SCTZGwOaU7PnlaNkVMtcTv9ElwfPkn/2MW18ixcJ
         9514rs0ftG9beBb50HT7uQnM20bj6BsoYpSPE1OmYnGiFL1jZLZhllAuyIrX76+35cVl
         hjT8YXTamE8Fd59c9KSgQucKF/1xElSMdxmTd+WGDds8mgueC7v71q6ybyEsbSxlWHHa
         IXHDbpmfFMX9zKQ/HwGzYse+nQVMW2tArPEcdky85KOR+/Z5zqVWDLoXkeX8bGu6HPZn
         s3Gt5RE4MZna42+9u4IWnseVHsk6PcC1BUUyngLmGw2ZkKP/6o41YewwCapJeJrlTfwN
         9suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765892977; x=1766497777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x7/Mz5RzhnX1QZHAKW86jmwpiy8TOBH4L00hU7AiSmY=;
        b=W3FKs/dWnmtLA3lOoJsPV0FbyUrzYW2M3EijbHs2/+VAWMf1xO7l6EMgc0l6F6Kbhd
         l48jKxixhz/adIApBZZJJ/hwmXH+ObSNy1mIvWMm0cGFpJJHld8gZwleaUbUk0yo2Asa
         VSk7lG8souGXtzufaRWjXd8GRFYnxJsN3ZOUdLxPGwPCe0cd7kLeSZDb13q5OTARgt0p
         lLAzdIfFI03w2W3Vrx3+qFhj7PUrWMEqdS520R3g9+Hb5JnhrUkjTMlIsiOvmsUmiYGA
         DZ/sfVFgD9HXatRXF/DyU0II56OmLm7bxKFXm8xhLUp4wh9uvyInK5+1vMFXLyFA0oj9
         aVhw==
X-Forwarded-Encrypted: i=1; AJvYcCVWT95bNL1c7ng3Oz8peYEm63I61Ayd4R4oMLd66sK0u2AaOAzSgNHGtKEeyriGKqRH1bDcLWyCAqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwahKiOuqPWLIhVWoc1OaDumFlr5RX7dOLUEc4+K5KmZbcSxBaf
	aFVuqFS+lsqsJK/0fI/LFZQ0+A+kZN80FetTg9wd2nJUMgQIA+snPw6OBKxsX/ydZe9WIISlOVf
	KyauI/CQQEfCbw8Wz1n+USE3hnn5JSpJyDnFwsrwlrt5Tr2Ap0ewxGlEtBsuvGNY=
X-Gm-Gg: AY/fxX67g15auDupGSuvU8NUZANDD/5Vmr1ivdjEkOQiFe1peIA26lgOKJix42Tion5
	j24Mgyc2mXdWmcKpqQUfd2ocWMiZW/T0rpRxYIgD5nBX+KC/DHvsX+HI8oS2ggfr6Or084H67im
	PUklIrMqw0rIn8ltwVQR+BtWaHeIH5rEzTWkmugZg4dmRaJrmdmN127TxKev4eb+lZPG1HVuHUd
	9625V09SVSAdzHblA3Ld5DE8xhSD7XDftEUwIULmSzdM93l0XfEhm+HpmYUc/jbPRmAHerUVL1L
	YefZl3hiMJJDhHjfSqEeu7ifWOvFAfMLATrZvna7WZy7OGa6gRRNZ+s3xKuhWzRgMJ7mgCFz2fe
	sBCQ+oVFRmsrwKtlsgfth0uZDQFPWQTkShrnz332VpgY=
X-Received: by 2002:a17:902:c406:b0:29e:e5e6:247c with SMTP id d9443c01a7336-29eeebce775mr189077195ad.14.1765892976687;
        Tue, 16 Dec 2025 05:49:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEW7799xblQ1JSbsBt3Us6FRqj35KPvzFMwqhjAxwrznE4otMhZ8ln8p3JbJLk6NgptxWvLg==
X-Received: by 2002:a17:902:c406:b0:29e:e5e6:247c with SMTP id d9443c01a7336-29eeebce775mr189076685ad.14.1765892976063;
        Tue, 16 Dec 2025 05:49:36 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0993ab61dsm99697165ad.46.2025.12.16.05.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:49:35 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 19:19:18 +0530
Subject: [PATCH v2 2/2] PCI: qcom-ep: Add support for firmware-managed PCIe
 Endpoint
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-firmware_managed_ep-v2-2-7a731327307f@oss.qualcomm.com>
References: <20251216-firmware_managed_ep-v2-0-7a731327307f@oss.qualcomm.com>
In-Reply-To: <20251216-firmware_managed_ep-v2-0-7a731327307f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765892958; l=5973;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=Fyphgpm9oWKQhl4y6fHTvk81D6ocscTgp2cQazg94DE=;
 b=fweZq6YJt+ogIBNs7H7qTkSgUeTy8mr6rZyNWQXHIeGEFjT2/olTmy+VzGwVml7k9Q/sKz9QF
 qt0QBLPmRy0BAOtpmZci+X2K/eV/8QSIPsinZpAU5NG/9u6N7Izdbfp
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Authority-Analysis: v=2.4 cv=TLpIilla c=1 sm=1 tr=0 ts=69416371 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2tdM-IJ1x2Ue4swjlzoA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: RPA3QS80Y5k8V4RLqCqyHCRag7cr9-qW
X-Proofpoint-ORIG-GUID: RPA3QS80Y5k8V4RLqCqyHCRag7cr9-qW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDExOCBTYWx0ZWRfX4pUYLS/UD9kH
 wUfZ0k78SnSGQSpU8MkOUHA8CC4k+N3eb5xYTX3dMvK5kbRhibNXWb+3tfBiPFhvjadVntDqdWQ
 QSz5HeBB3JTejd2Q8fPR0dHRez78bGIYisjfkuequnWYYjiZm4E7iVYHEO8NLQ1rKXMg2mmH/BP
 yRYqJmbdYyKELDmzbiXtWk9qXM28QD2LnISBZJj7XpN+HwJdUEAmbCEYSpT9dKyMDbNJBpWxIVP
 xDERvQmz6Mu3SQExicAwDgqHT5AXIU9MtMPfLnmkcQOwTFgiNJMuQlpBb3eHq3tLPZ07XQlvXjq
 Sk7tb5LJOjSXIYYN2aSyjuGauOHsS1YucF/vFqiinBpqXA1v87vige5p4PfTUpPweGtVOW2sw1W
 IiUJ3wmw6dXULZxj0UAIya7MPfLO6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160118

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
index f1bc0ac81a928b928ab3f8cc7bf82558fc430474..2de8b48511169a9c836828c22860dba45f6c9db8 100644
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
+	{ .compatible = "qcom,pcie-ep-sa8255p", .data = &cfg_1_34_0_fw_managed},
 	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,sdx55-pcie-ep", },
 	{ .compatible = "qcom,sm8450-pcie-ep", },

-- 
2.25.1


