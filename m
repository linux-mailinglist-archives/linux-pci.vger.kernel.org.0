Return-Path: <linux-pci+bounces-44100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD42FCF8560
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 13:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8468530499F3
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBA632D0E9;
	Tue,  6 Jan 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nEMHp2w/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f8j/8iDy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712832E14F
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702920; cv=none; b=nnx53HySn4R4Fj0mHNRzbuI4xmU2HQW9rFXWK7GZWKKWmF3ClwRblhYdO9BwhDNXipcttjeZgO6gJUhuRgild3S2A6xcwbi4GfvKs/kg7yCCAuz2yPAnYmGGGS4CWHf0fn4g/SGTamkSxG9rTYHvAolSbwP7XYjRI/OW88gjdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702920; c=relaxed/simple;
	bh=lpREkdKrYB0i9xOdYVwf95ZKijvVrCKLc5MhFmp5Mds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGy3kJYQTycV13BT23SVE2JQiHIwf2HRgfl5+yibkQTz/7gi8s08go9oD5634rlOiQF90WrESkK409AuWWXDsAq9viXYv4lBZNVUTul6TpUE0EWVm/VVG4a40Jir3n7Yt/LWHKIcjcRSVX1ANFqrvpbSmUNdEZPPz73t1ckvVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nEMHp2w/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f8j/8iDy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606AdEjZ3214062
	for <linux-pci@vger.kernel.org>; Tue, 6 Jan 2026 12:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eXweGIGQP+389eatYl/A0e37pEINDI7V0gdpqnXDHQE=; b=nEMHp2w/W++28fiy
	jAg5IGg4HtnzAmqyQIvnIo5ghdnxF68byLUXy6xhgX5lw6wtNoHTMWbqW0QCfoAw
	5jXvWXCTZjlfU+a3UHu9Stu8YCVAWbtaEq2kutC85Qj5nQezANKkjiOt8V/ruOS5
	4M8aGl5l7//V27tSOsi/4xv63nL5rWyIrPHLZ1X6YhamtAksgVq984crmmPfmIjP
	SOPZ9+WXmvtSclf29R8vKeGfMgqu8IhcUQJSrmyNMlu45pWohuDjDkgQkR7x3BNa
	4ABgPKUROh+0tIqTJ0gcvlNug7kRvSQSsldiBErcnaXf7YMms13AUel0aytzHSOb
	hrcPfA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgpnda1qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2026 12:35:18 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7f21951c317so834659b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2026 04:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767702917; x=1768307717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXweGIGQP+389eatYl/A0e37pEINDI7V0gdpqnXDHQE=;
        b=f8j/8iDy3UvbT8kv6CydL8kctZ3aCkoyhnIcvXlGPqfMIzW7rUbP8s8prYvxPe+uN2
         Jb+Smh9lKwjEwVCOsROS0GG77bvOp3foWbH1FG6Ty9XcyBBSTk1heltJS/yHWTXW5hNp
         tF3iYh+pb7hVkDWFkk/3H3qO7uKBFnxckZxq5YYUa8UMx/nMinwBUEAOQZ6NcRA4stT5
         iBXT0ox720nqV/C/sv9yK+KZV1L3XQvS3GDhE5QTirz+Oa8xYWyhB5TrClK9O0lpSS0I
         pj8y0k1Itc7O1oXs6zu5INzlvVMigGkm3OCLXLRw1l4UotQjG7x2HTdM8M8G02JxUMZP
         KyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767702917; x=1768307717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eXweGIGQP+389eatYl/A0e37pEINDI7V0gdpqnXDHQE=;
        b=mU2NjAoahVMfmfJ+wBlr5BJi8zhyf3WeCMi/nzEgoR9aVfrKBCPgatpi8qJa4Gio2D
         Xju8yL6xaxroGYT10A7lQmI9UvWppoS20OnJdRhub98nSik1Gty2LlReVMcgG3ZU394+
         M7NBvaj98n7FcBXEfI4fB31JgRSanBWJfB06yi9Ivqk/NRAPVdIa4y/Lr849p4Q5J9bi
         wwKBkSpZwR+oa+h5xNyL34nnPAdvz1kVemXNDiSWOeiO07Cdm3z36vn/kx59MSNZ21Np
         3ICJ+/mc1X+FBg7H/P1T/UbSEkHxRCk7bb6iOba1X7E8b7kp5cc3QCigcTnkTDMcj9t/
         Leeg==
X-Forwarded-Encrypted: i=1; AJvYcCXTEPUQAytHf3pQQ9lp4Vi/axaUUizwAyNizqQEIpgVnqkufkcBTjLa3t0B8MX66tCYtDGKrUhzR0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YylwW/FR24CUDb1e9XbMnQFl5w3ogc0syDxVbgIMClCkr6f1bfB
	zH8veJ7lw7cks4PKAJLC+aEe5MiNfwhCYgUEaOar/2vHy/P2NjacvM1f3HBg7vCyq53Z73JNSms
	9wiHtR7IVPIoIzjGurFMS+9mXBGj0nIDp8s5D67PTdcFod69pPHR39mFpbPXRplU=
X-Gm-Gg: AY/fxX7tJE1dS9FC3YNtSfUqRQdKvjN6laytk7J+4FTyyQW44EAwBDggY1ZrxX23sKY
	j8WpNfxprIoMuTdQGxfCKaN9NKFnhuoFIVBN0lFBTlPwQdhlBMJAWOELHJYAuqvADQ88/Jr33g2
	q3GjKe/EGe+iajnKg6wOlZ7EjBexhWvxiuxp3V9b5fPmn84tgrFPV4YyHAOf2Vz4gOAdcYvzcL8
	zhqFrfAlePKDtnfCPN4wTybSykiBD9hCyM2a14c966jqYHlbgHhYMWrHo831FMXIgmcr6qV1SLD
	8B8bzSTt+PRbxiaDbcLmwsB90aIcWMFFmj9cUplBWzAwTgDQqV52r2AnJfd1480vU31a2epkBcI
	LA/mInOVhH/qXvcnmX4UCL/4SxxxMEb2BKkxRlwiLKqQ=
X-Received: by 2002:a05:6a00:4295:b0:781:1f28:eadd with SMTP id d2e1a72fcca58-81880b6c513mr2696962b3a.20.1767702915952;
        Tue, 06 Jan 2026 04:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHge5WmZqCBf8j+3Ngw9xkT9W1WtOx50n7DYYhwZyH4ZZwl7y63KFgminhgHunMQGCuKBeUeg==
X-Received: by 2002:a05:6a00:4295:b0:781:1f28:eadd with SMTP id d2e1a72fcca58-81880b6c513mr2696923b3a.20.1767702915396;
        Tue, 06 Jan 2026 04:35:15 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e83bcsm2161583b3a.56.2026.01.06.04.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:35:15 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 18:04:46 +0530
Subject: [PATCH v5 2/2] PCI: qcom-ep: Add support for firmware-managed PCIe
 Endpoint
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-firmware_managed_ep-v5-2-1933432127ec@oss.qualcomm.com>
References: <20260106-firmware_managed_ep-v5-0-1933432127ec@oss.qualcomm.com>
In-Reply-To: <20260106-firmware_managed_ep-v5-0-1933432127ec@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767702896; l=5344;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=lpREkdKrYB0i9xOdYVwf95ZKijvVrCKLc5MhFmp5Mds=;
 b=/huxLK/6VSsK0Qf6AxudDDmeD+PNnbOej5xqjM/S4amSM+KIbtPLCg8h1kfDJutFmYO4VJAvv
 TnhVRiNI4l6DLI8A2ZIwZuAhx7PZ9q2e5z57FVhjR0URlbxZVUbk5Wr
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-ORIG-GUID: rVcoqBZ-SNcXEeYqqaj5b7p2oIG7dLte
X-Proofpoint-GUID: rVcoqBZ-SNcXEeYqqaj5b7p2oIG7dLte
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwOCBTYWx0ZWRfX72uoslvXq8rz
 wItdKYkRgf3WZ+zuiYxNe0+x7vEwT0+vo771hUTIvgWYF5HHRSJrlJPkATNn6Zd4JuKt9/IUejD
 0KLZSJ2C6EJ7oVJPM68OSJeW2Sp/sKG87Nt8g5P6oF0oIhSU5mTDSWTxuG4mf2wbipm4dwl/1Xg
 f8xuTVNKoWELT2WjddSZKSqE5n4mvrK66nI9NyhrL6kXrxW7/iAlfYl3CeehtYU0s6jTe8Z+kbD
 4nNfIl6MLSDUO2WdZBGJF9trtgFjLT9ICpE1l2E+V78w3lW52m97uO3twTR7VssgMimn/DFGHuX
 zhSSvrEOPkhZ7J8GVecSgTYtu/dXcdNxD9v2uT3ylC5q1tjaxCZ4F1vxtr5J2FwrbyI7MUVwpzw
 MWDs2iv53fp6yyxxgqWeU8veymDAQpq7DZ4nIbHXIFmLAfHhGHi1sIodxMvoWNnlHu8aD4cemOW
 MZktgKdnGcvCUbxqyRA==
X-Authority-Analysis: v=2.4 cv=Jpz8bc4C c=1 sm=1 tr=0 ts=695d0186 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2tdM-IJ1x2Ue4swjlzoA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060108

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
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 61 +++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index f1bc0ac81a928b928ab3f8cc7bf82558fc430474..38fcc241032b60e4c93574e4d759596ddf268efa 100644
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
@@ -377,6 +379,14 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 
 static void qcom_pcie_disable_resources(struct qcom_pcie_ep *pcie_ep)
 {
+	struct device *dev = pcie_ep->pci.dev;
+
+	pm_runtime_put(dev);
+
+	/* Skip resource disablement if Endpoint controller is firmware-managed */
+	if (pcie_ep->cfg && pcie_ep->cfg->firmware_managed)
+		return;
+
 	icc_set_bw(pcie_ep->icc_mem, 0, 0);
 	phy_power_off(pcie_ep->phy);
 	phy_exit(pcie_ep->phy);
@@ -390,12 +400,24 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	u32 val, offset;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable endpoint device: %d\n", ret);
+		return ret;
+	}
+
+	/* Skip resource enablement if Endpoint controller is firmware-managed */
+	if (pcie_ep->cfg && pcie_ep->cfg->firmware_managed)
+		goto skip_resources_enable;
+
 	ret = qcom_pcie_enable_resources(pcie_ep);
 	if (ret) {
 		dev_err(dev, "Failed to enable resources: %d\n", ret);
+		pm_runtime_put(dev);
 		return ret;
 	}
 
+skip_resources_enable:
 	/* Perform cleanup that requires refclk */
 	pci_epc_deinit_notify(pci->ep.epc);
 	dw_pcie_ep_cleanup(&pci->ep);
@@ -630,6 +652,17 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 		return ret;
 	}
 
+	pcie_ep->reset = devm_gpiod_get(dev, "reset", GPIOD_IN);
+	if (IS_ERR(pcie_ep->reset))
+		return PTR_ERR(pcie_ep->reset);
+
+	pcie_ep->wake = devm_gpiod_get_optional(dev, "wake", GPIOD_OUT_LOW);
+	if (IS_ERR(pcie_ep->wake))
+		return PTR_ERR(pcie_ep->wake);
+
+	if (pcie_ep->cfg && pcie_ep->cfg->firmware_managed)
+		return 0;
+
 	pcie_ep->num_clks = devm_clk_bulk_get_all(dev, &pcie_ep->clks);
 	if (pcie_ep->num_clks < 0) {
 		dev_err(dev, "Failed to get clocks\n");
@@ -640,14 +673,6 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 	if (IS_ERR(pcie_ep->core_reset))
 		return PTR_ERR(pcie_ep->core_reset);
 
-	pcie_ep->reset = devm_gpiod_get(dev, "reset", GPIOD_IN);
-	if (IS_ERR(pcie_ep->reset))
-		return PTR_ERR(pcie_ep->reset);
-
-	pcie_ep->wake = devm_gpiod_get_optional(dev, "wake", GPIOD_OUT_LOW);
-	if (IS_ERR(pcie_ep->wake))
-		return PTR_ERR(pcie_ep->wake);
-
 	pcie_ep->phy = devm_phy_optional_get(dev, "pciephy");
 	if (IS_ERR(pcie_ep->phy))
 		ret = PTR_ERR(pcie_ep->phy);
@@ -874,6 +899,12 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 
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
@@ -894,6 +925,12 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
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
 
@@ -930,7 +967,15 @@ static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
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


