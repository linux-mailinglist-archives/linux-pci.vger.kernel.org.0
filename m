Return-Path: <linux-pci+bounces-43161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E67ECC726F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 11:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC7A230F1640
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D405A34D3A8;
	Wed, 17 Dec 2025 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="igW2HQdU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vy4u+CHy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD634D390
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765966389; cv=none; b=B412H7duMExW6j2fE9f8RSV5UOHmfzsSis6Ighx4eixQ6A7+z68bxs0zLyj9ZD5vFmUw67r0smSSEIngDmfWqbXV4AS7jrt4U5avAVjJKKx3bTNirKKQbCgb0uz4veU3vLWyaUF4KPKztXCMDrv42JY+uT3PcNmvXqMmJKFM8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765966389; c=relaxed/simple;
	bh=Fyphgpm9oWKQhl4y6fHTvk81D6ocscTgp2cQazg94DE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6z925zXZ9AvbycSbDARKmRV+uLGbUAPipgxqNnJyPYO03QP77WDQEqoP9b1/dPoZWGx8JcIfDNMH2JfE54gV5pH8TGv4WCfRR4cEscSLEBaKKzOrnfkaS93h/ildf7NvFsE1fK+HRLMnJLpiVEpBGMckPlLGJo5BMzoHGuBar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=igW2HQdU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vy4u+CHy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHA1ikA1501347
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 10:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x7/Mz5RzhnX1QZHAKW86jmwpiy8TOBH4L00hU7AiSmY=; b=igW2HQdUnnq0Uezc
	CnNeb/mkHttd/mGoapD5vo4iy81tvumIbt0y3nOnzc6X8/usfkBMVJR6y7WRSwrW
	7RkbbnRTh/o790IQu9kYn1P4HYscG9e2r7ZvVLXcD/Nneg1ltHzlEmglCc/Hw+Tj
	yLnj6MRPAblUe6J0dRBaABthd2TZioLXd4YViubfZKUDfoNKRSS9M2z4ZGiNM2oJ
	XEzTdYnubXWXS67PgpNr64gg5SSr0BYivvYoSRvcYKL2luydvfs9gVJZ0g6m9Mua
	Bnia7SSQiXSv/PvDSvwh/r0rZij1oigyGAADylB0eq3n/w3WnteZYx/cGiXXCqey
	9hA5sw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3kkesdc6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 10:13:07 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b952a966d7so11682247b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 02:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765966387; x=1766571187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7/Mz5RzhnX1QZHAKW86jmwpiy8TOBH4L00hU7AiSmY=;
        b=Vy4u+CHyLlUBZsh1XJnjplbibgBGix6nP6gn8x0PITZbeOJRESIU+wxD3dfada94/C
         mAAz5M3zP+qjtth+szV1U83rRnObLeMmVtuDJU/GOwFfiVXHB6TQynku5MFEWCF5R2j0
         pqbBMaW8xP3+CIcEIXFxttOKho7GBmvOGJAa80V5BPlmDDBZutK9KKM0pAggcqjtra5q
         CLlXOn+eRioXYeaWHeaX9Ge7pP/L6JoT5SbhQM5phdGzXh9a3XTIoywWRIyUT2OU/Pdl
         rC+2lj2dFlrHaeWImnzvoJW8EpFzFC4lQMy638qGs6Q5QSAhx3qupo9WXLVix0TKaBh4
         zq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765966387; x=1766571187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x7/Mz5RzhnX1QZHAKW86jmwpiy8TOBH4L00hU7AiSmY=;
        b=sQweqLoVddNJnyQnENI5N9qdk+JRljqvPUmrPcH4Q0Rt/WnDPpbvHAe+5m7/JQuYdF
         qmsOMti+dZxNLz4E8NdnpGlCONcHRsj7FAaenhgUjZdXBo68JgVlaVn+hWxDUKrHCc3I
         sDUsG8yuMfUNGHB31dAGSgDVYSDzttXeMEvA4FCeydFziZX1F5bKad33SxmrVc4Ccxjh
         R6Z76poTx+PvDdo5CIWBvmSR6e9CQwVcn9Mot/c91l393kS5vRmLo45x+lQIiCaUqGtw
         VEsx4znFuCiJPZMZ59Bxn0KuVZvIZC/A687t3JaoK+WW3HK5i5/GkvNy7xYtDbS+xQeB
         uq6g==
X-Forwarded-Encrypted: i=1; AJvYcCWdzq/FNNVhC/rv2B474AELChOeRJMkhvUcJFvZ8pag8HpbxJBt2pfNa8+S0o1VJWPjttj2GFd+9CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddBRC2ABSoHt6e3hO++EIBMQzCc3z0wQfp8ECnFCpl35sxs1V
	+07risBY8KtM7gjWZatbOVsagoFRFeHdOvZxpmF/7rGGXMi8kXM2KHs70Wy+7rUSGusO0PxRe6l
	lKgph7w2BKVZ2u2HUpnsftKHlKKdaYisuns8d7s3nPDMV4jPyKur7Ua5kHio5B3w=
X-Gm-Gg: AY/fxX6dQXvRu/SFX/5nvCzHW2S/1J3u8NejNuRYZxnJtdKdMIRz8Dp53u2ipkVo4hs
	JmRs2+pVuXBCoy8Hlb6DUo9MtfnjMeF/bYXgF4peMbnU6W6J1Vp8a3qecLMhFTHqc5+rJiAv+l8
	7sUgbLT3p/L0M+gp/YMNHfrpB9K92I38Oqv+zssbz2oGD0n3rHfC7IqoS10cdRn8Hq70SFzx7Eh
	X7aY72r4Qr/Bii5KouyeUUdU+FoOsqrF5QTJDkkqj2H6J+sAOo2VvnexwuI9axJJgUelfB3r2SJ
	WQnk6j193tYaePYnfZdHhbEjVAZerFRKcgayLNIfKS9nme22Z4iRAPJANx/ZVpXdW7rUkfwWchg
	cnHFj9USR1+FM7yKwQ7m+6L1LfmiPQtF55qlZgCGHLDk=
X-Received: by 2002:a05:6a00:1c83:b0:7a2:84f3:cefc with SMTP id d2e1a72fcca58-7f664a1205fmr16964533b3a.0.1765966386590;
        Wed, 17 Dec 2025 02:13:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0MZ3nmQGGxhARCP3mAJ2zLafaudmhwrnaWUzuRTwlfzQ6fEEDB4xWkBKl1zkgGoKAjQinWw==
X-Received: by 2002:a05:6a00:1c83:b0:7a2:84f3:cefc with SMTP id d2e1a72fcca58-7f664a1205fmr16964486b3a.0.1765966386040;
        Wed, 17 Dec 2025 02:13:06 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcbb11ee42sm2290347b3a.43.2025.12.17.02.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:13:05 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 15:42:46 +0530
Subject: [PATCH v3 2/2] PCI: qcom-ep: Add support for firmware-managed PCIe
 Endpoint
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-firmware_managed_ep-v3-2-ff871ba688fb@oss.qualcomm.com>
References: <20251217-firmware_managed_ep-v3-0-ff871ba688fb@oss.qualcomm.com>
In-Reply-To: <20251217-firmware_managed_ep-v3-0-ff871ba688fb@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765966367; l=5973;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=Fyphgpm9oWKQhl4y6fHTvk81D6ocscTgp2cQazg94DE=;
 b=OFGYAIvri6Zs4REOgRs745u+v9BLBtpIFNaodmrNm3Q3TuXb6/VrXfkrW+4awv5TnQRnnsxdt
 LH06T9egqRnAmWxHOTOnM+jFO/fVLssAJzodkUMjjyLl7MFVuB7pql+
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA4MSBTYWx0ZWRfX5i+4FleWLUO2
 GdVsSu7FA+dOx/HK+cRzf5umVQLglMBWERLmKErKWpaW0CayEBXIMAr84/wX3RtpQgS+Rs0VbSU
 zxD29lTGvPEVm0CMiVFlm3Ep/O6sxmBDbhvGVNNufoQ24cXben0ClVPAon0+tuFsfN4OzPU2PA5
 WR+2OiJYr/nEy36qZw6xxoQFAxjXPf1bR0M2d6/0FxQJdVWPeVy4N2h04Oc8IU/fTVAoG45f+Qo
 7Ql+L3p+OICxHlIqK3ACN2OYS1LxGUVsELIRQfg/SNChc+/Srzbd0QkngJdTqyBFzhRaqJD2UPg
 U8EE/0fpKgqc1C+qKWFeGtyLvFrXLNq+T3A5oH9P/EXb1ycnfvfAmcoO4UVxYDMMYoTr/CQSYSz
 Q6mMTKNyMYcWyFHQQgMg/GAyBDHphw==
X-Proofpoint-GUID: GqWcDZylrCJ6hNBfdDftmD93v-4DVJ3o
X-Authority-Analysis: v=2.4 cv=Fcw6BZ+6 c=1 sm=1 tr=0 ts=69428233 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2tdM-IJ1x2Ue4swjlzoA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: GqWcDZylrCJ6hNBfdDftmD93v-4DVJ3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170081

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


