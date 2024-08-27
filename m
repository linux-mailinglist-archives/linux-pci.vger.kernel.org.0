Return-Path: <linux-pci+bounces-12239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497209600B0
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 07:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E833E1F22CAC
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 05:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BD2136E0E;
	Tue, 27 Aug 2024 04:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pI+OB1lm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67EF15623A;
	Tue, 27 Aug 2024 04:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734750; cv=none; b=Av5QBZmtoTUP2kcIMmLmmeJk3HkVZ/3PO+XpX9u/3D5qyxPW+BLmLMu5nDPugX0jXTpbh9orS+QFfslg+b3PgY0QBeLtdN3CWXWQxdALFbCIWVITTgBcaW39dvk+ljE/IKeeGPiQSQ+E9X7tT5VWSdT2DDDbZoLZJvVaWIKGldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734750; c=relaxed/simple;
	bh=den0R47vJ5dWVBkraX2DlbIpeIhiEvA7YmXMI0JRU24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQ+/fxFaf+ww5CqSK6TNuXKOJQUYEpZBGWWLdlFutC6yEsrSmQT8aN/vnI0+iTEaH2SsPErRwesqftyq2GbcfPANW5iaduAIL3+EJDR/Nx/djkzjKXuBcakASSxYeDH7rwz8kTtbK78USKWKnxAZ+gtwv3DkUfoAmO3ocBYZpXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pI+OB1lm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QJHT2d024185;
	Tue, 27 Aug 2024 04:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jHB9yk9VaKLj8o1RY2pT6NEb5yxM0s2Bi/4RN2ueWyw=; b=pI+OB1lme4v0EhZI
	/h4DqVh5IepbIAgS6hpG00ix3cTAVkEaYqp1yL+KEXEQzAfiXs4vPIBvwnC0x5p/
	Fk0b7sdZWDw/jWJJ/IQ4uXk3ExQrn3t8E5AgvpKO7NxPD8JbvjlFQtkHf76PZ1zv
	pvFP+GF8DZu1y8bH6O1xSGvu5msm2KPAHRIBar5RwvW6DNRltr6TanvG76tMfgJl
	4xflew5WZPdHM2E6WGlwQnbzoCFgQcXwyWoQh3Mhp9CgagG4cttVJp/JpDTJ2jb4
	VsjBDY5Ar6Ge/G2gzS8FkM3n2411Hcu0ehmIdXsf4HW8BvIgWfQB8sPgC8UAUp6T
	F4KV4w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 418rbxaaqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 04:58:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47R4wtC9028644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 04:58:55 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 26 Aug 2024 21:58:49 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <robimarko@gmail.com>, <quic_srichara@quicinc.com>
Subject: [PATCH V2 6/6] arm64: dts: qcom: ipq5018: Enable PCIe
Date: Tue, 27 Aug 2024 10:27:57 +0530
Message-ID: <20240827045757.1101194-7-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827045757.1101194-1-quic_srichara@quicinc.com>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CG0lggzUw9Qy8DAvZwHZoq4UbsbXlpnY
X-Proofpoint-GUID: CG0lggzUw9Qy8DAvZwHZoq4UbsbXlpnY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_03,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=768
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408270034

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Enable the PCIe controller and PHY nodes for RDP 432-c2.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v2] Moved status as last property

 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
index 8460b538eb6a..2b253da7f776 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
@@ -28,6 +28,15 @@ &blsp1_uart1 {
 	status = "okay";
 };
 
+&pcie1 {
+	perst-gpios = <&tlmm 15 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie_x2phy {
+	status = "okay";
+};
+
 &sdhc_1 {
 	pinctrl-0 = <&sdc_default_state>;
 	pinctrl-names = "default";
-- 
2.34.1


