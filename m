Return-Path: <linux-pci+bounces-4363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFCE86EE69
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 05:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFC81F214E1
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 04:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E34711720;
	Sat,  2 Mar 2024 04:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U8tIVKdP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31EF17566;
	Sat,  2 Mar 2024 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709352061; cv=none; b=DaUy5PepDgeiuK210DgXHhf40qhI5GPYo5VUF37pKsq1UeBDD9zIInMH4PPRFUsvnFMx8EnLgQBEtgNg+Vb2m6tfkkNmrQkCfTSehB/QDcyTmjtoF6RBmjgnPNSXPFIoKVIzxLnFtIlmpIuUtEcR1i2IpreyRDoaSKO0mwLLPJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709352061; c=relaxed/simple;
	bh=QhBOenPCWU9RPOLZkMRagkZZgTUlqWbD929MpJwSVcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rmJg7+ZjskyYWOsd5OCdKWUxI39e2LozjVOZSuFaljUMBeekteBcilcLgfQBqCFl/rtLj9zIxr/irLld6EnWEJ5wTJsDscZKfVzSkRwkjMZA7n+roQKSjxE6HH27Pg900It0gcmeqD8++tGCm2C+yDCDbJSfmlga79IPdxUfaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U8tIVKdP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4223TPHa030744;
	Sat, 2 Mar 2024 04:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=MWJFlLU/eSswcHRepliMx7VnE186DBZvx1uc7BliI60
	=; b=U8tIVKdPmKlImkTJAicLjUAHcPxNZeFxqGwpY7YmA0ahayn+Z7wN/YPnr03
	v8Ww2DC1yuOQl2wsyVNfHLww1XNJ5Z6rO7sMvkKdIDc0c/Lx3zgspETWnUT6LRiS
	p8WiiLcgZkmx33O5nkJGfdc3kuYa/l6k3z0ccUkW/ZjGySfFomXMLf+pMdPrGMNe
	iuM6VDf3RpandfrXUZ++aFlA+BbYhsU23z2YVGrzwcDKF39P/PV3+pzt17oI198o
	PFXBy6QA74uuozttGHorEqFASusNFbwOcwaR7PNmJCaPPG2Rx1dEbRDV6Sgfgizl
	CtHKK88G/tgQjMQtMm37YYSzwPw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkuq50272-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Mar 2024 04:00:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42240ieB001102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 2 Mar 2024 04:00:44 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 20:00:37 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 2 Mar 2024 09:29:59 +0530
Subject: [PATCH v8 5/7] arm64: dts: qcom: sm8450: Add opp table support to
 PCIe
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240302-opp_support-v8-5-158285b86b10@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709352004; l=2796;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=QhBOenPCWU9RPOLZkMRagkZZgTUlqWbD929MpJwSVcQ=;
 b=vnx6mLJnnJdrZijp/viQGGipCrCgbXJPf9wx1hwyAyoKdSPIzRxCqMmTpajeqytIX644RXiYZ
 WxMCJ4FCMgOC+8ROJ+GbtxQ1eIxsoj88iBnFGd4DtfusIcLKtDF3eoQ
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mOQ5sA1A0AS8pVJZ8IyoZZYF-2jAxEpb
X-Proofpoint-ORIG-GUID: mOQ5sA1A0AS8pVJZ8IyoZZYF-2jAxEpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_24,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=851 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403020031

PCIe needs to choose the appropriate performance state of RPMH power
domain and interconnect bandwidth based up on the PCIe gen speed.

Add the OPP table support to specify RPMH performance states and
interconnect peak bandwidth.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 6b1d2e0d9d14..662f2129f20d 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1827,7 +1827,32 @@ pcie0: pcie@1c00000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie0_default_state>;
 
+			operating-points-v2 = <&pcie0_opp_table>;
+
 			status = "disabled";
+
+			pcie0_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-2500000 {
+					opp-hz = /bits/ 64 <2500000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <250000 1>;
+				};
+
+				opp-5000000 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+				};
+
+				opp-8000000 {
+					opp-hz = /bits/ 64 <8000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <984500 1>;
+				};
+			};
+
 		};
 
 		pcie0_phy: phy@1c06000 {
@@ -1938,7 +1963,56 @@ pcie1: pcie@1c08000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie1_default_state>;
 
+			operating-points-v2 = <&pcie1_opp_table>;
+
 			status = "disabled";
+
+			pcie1_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/* GEN 1x1 */
+				opp-2500000 {
+					opp-hz = /bits/ 64 <2500000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <250000 1>;
+				};
+
+				/* GEN 1x2 GEN 2x1 */
+				opp-5000000 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+				};
+
+				/* GEN 2x2 */
+				opp-10000000 {
+					opp-hz = /bits/ 64 <10000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1000000 1>;
+				};
+
+				/* GEN 3x1 */
+				opp-8000000 {
+					opp-hz = /bits/ 64 <8000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <984500 1>;
+				};
+
+				/* GEN 3x2 GEN 4x1 */
+				opp-16000000 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <1969000 1>;
+				};
+
+				/* GEN 4x2 */
+				opp-32000000 {
+					opp-hz = /bits/ 64 <32000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <3938000 1>;
+				};
+			};
+
 		};
 
 		pcie1_phy: phy@1c0e000 {

-- 
2.42.0


