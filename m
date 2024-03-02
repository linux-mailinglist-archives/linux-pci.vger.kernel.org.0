Return-Path: <linux-pci+bounces-4360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F82486EE5B
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 05:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12361C2158D
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 04:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23F28BFD;
	Sat,  2 Mar 2024 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QxGaPWEE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459F12B9A;
	Sat,  2 Mar 2024 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709352034; cv=none; b=ZIBiYAL18Ca/D+NTGuGHcqcI6/7Mx+lb+z3bU7seqo7/7oXZQg09FPNHhscPoQkEYmkNyzV98wLpVaWIlUolLaQ6/JzgLZv3xnKjOzWLRbWvcrAaASia/mEcpfw8TJ8ZEsP8l8dDbd8cukrbiYwRMtFPsoiDOAXmwdUFiNqZGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709352034; c=relaxed/simple;
	bh=nrOFF1PG0Ddvzaj3cU3X6VJdG6aS86Nli2BwddOLFA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KLIPCK+HPdZy0yhi3LxbqMOzfYz0WG7WtCT4gpZENHpOnr/cas90ldg+mxaCFeCRe6BkhyAIRegUN2RNWPDvEKV+y5p9T7CknYkZXkKcGp5jwEmUIzz9D8ipm0+UKn6P77oOpN19bOl99DD+3rG0+rgVoTNJ/j/uqU9q3vQ7xyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QxGaPWEE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4223PHKB029084;
	Sat, 2 Mar 2024 04:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=3FogZb3RjOu/p0gevLn/krzCPQWG9ibDSved21e76mM
	=; b=QxGaPWEEeO57rRxfqIS4XhuAi9G4Ho2j0wsx4p+lhQMgc1HM+ut64er+P/s
	oiyQBLG1D9HdjsoHtEm/FGmxJAAenMaDJ6KsNhYi2OrWi8Grd/rXdInOE6WyISz8
	ZFQiiIcnuxnstEN6RUI6E4JsDKP5mgMbr5y5IF27hF5XjwgjXlS3bZXAEx7GUKGN
	A3lK7mIXRE6M1vxgSd+/nPD/hqoytXjdhh3eld5DT8uyQ5OBn+UlsXNVkUuWSVEf
	8T1M5a5NiBe/y1ZjmI2ernXav0FKK2FFrFLCk7YpduGU9x6nlGNc16LgUnvpEVvq
	FfmEGZvMXkTanH5GDLROuFBO28w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wku2wr3s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Mar 2024 04:00:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42240OqM006833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 2 Mar 2024 04:00:24 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 20:00:17 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 2 Mar 2024 09:29:56 +0530
Subject: [PATCH v8 2/7] arm64: dts: qcom: sm8450: Add interconnect path to
 PCIe node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240302-opp_support-v8-2-158285b86b10@quicinc.com>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
In-Reply-To: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney
	<bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709352003; l=1479;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=nrOFF1PG0Ddvzaj3cU3X6VJdG6aS86Nli2BwddOLFA0=;
 b=HJdwvIqS/ykP/LoV4t1efAFoFEkOMB32mavxM6+uFVVeUz9cYc7Y6L94fihxUpUANVtqQYHrp
 qsmlTswKNg/BoVcyN2cELHaH5YED/PkkCQRXYUZkS4dAa1bghbKIG4Z
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AkpGrqIMuq91HT9pCVew3kMLDG6ASIGJ
X-Proofpoint-GUID: AkpGrqIMuq91HT9pCVew3kMLDG6ASIGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_24,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403020031

Add pcie-mem & cpu-pcie interconnect path to the PCIe nodes.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 01e4dfc4babd..6b1d2e0d9d14 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1781,6 +1781,10 @@ pcie0: pcie@1c00000 {
 					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
+			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
 			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
 				 <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
 				 <&pcie0_phy>,
@@ -1890,6 +1894,10 @@ pcie1: pcie@1c08000 {
 					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
+			interconnects = <&pcie_noc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_1 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
 			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
 				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
 				 <&pcie1_phy>,

-- 
2.42.0


