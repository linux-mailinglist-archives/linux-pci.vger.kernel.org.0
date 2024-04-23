Return-Path: <linux-pci+bounces-6561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284778AE0B0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 11:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF07328730D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1390462A02;
	Tue, 23 Apr 2024 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CfdG7UEM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBFA58ABC;
	Tue, 23 Apr 2024 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863315; cv=none; b=jf9USosF9PwfOn6Lpvl2sM2fw36QCErs+Q4AGEOAyxTzD/50YsdjNrf95KUddkm/fXn7ocib/AtdYZU9+8E6SH6V4AjlgNDSkN7859ZKcWyYa0sz5a+Shr4RZ76xNM+87fUB+qtvZiLAumzBYpy1FPBXh6RJ6Y6zgPoFKvYx+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863315; c=relaxed/simple;
	bh=4pRzd9+pDtrMLyrpkNkkMjxwxBU2FfbkTR7Y10bYL9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aBOA5hZ9jHTEGCfdDNQxqPGXHgKSK9z8k7QWD+sThkKGmGzixBKQusc75a21BZr6q1g9aVVNLbDFbv1WcQEDAU/dwoMJtNfHswBCfqJo5HzElnC8gqLmexSCD8XMQST3lboBRxO3HzJ3fzFPgPaBZyLDUMAXVK6TVkzeGY79ugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CfdG7UEM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5rNrI022152;
	Tue, 23 Apr 2024 09:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=9n8G1hcjc/AYvUEDDhWjwoL0BEeWTlgUdH6sujP57Z8
	=; b=CfdG7UEMkxVPetl0THUZB8jy0yYNJsrzEYrhp3h3M6pKctf1j1TIOEsYi04
	HdhaORLZDWMc0U3H+YL29m+zDV+yO+bMUY4ZioYTxNJbQj6MuQmzZfu2vdOKmE9E
	3WulHGsgRw0L+tnhq2Qj59kH332zXE8DXu3jqPJGiUi6H2rhYbN6xVn52Q0Pu4Mu
	eM4PXxFISnxkfpKSK811lG5SBCWt1eyULfPxPgwbG1EvRcWN/WiIHBbWzeH1M0oa
	oIvx+UzIoc2jLWRRI5pKhlqRKc+aH5tqWCCSx7QFYe2GcZbv6tdWd1oXc10fUnut
	Fo2c8DkCguCTEX8DC0cU10jOA5w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp6n2gddn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 09:08:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43N98JBo031668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 09:08:19 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 02:08:13 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 23 Apr 2024 14:36:58 +0530
Subject: [PATCH v11 4/6] arm64: dts: qcom: sm8450: Add OPP table support to
 PCIe
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240423-opp_support-v11-4-15fdd40b0f95@quicinc.com>
References: <20240423-opp_support-v11-0-15fdd40b0f95@quicinc.com>
In-Reply-To: <20240423-opp_support-v11-0-15fdd40b0f95@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_krichai@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713863266; l=3148;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=4pRzd9+pDtrMLyrpkNkkMjxwxBU2FfbkTR7Y10bYL9k=;
 b=jKZ+VM9c+rv//+pFQT5JCnA8K0CI1boZu+2HvIdmINwwjuqeAM1s/YZV1ryGGwloO+nbh1FfR
 zLbqdD+XGLcCb98yRqlMzcqnZh3p5xjzYJ+jTqWherguSV08DghY7j8
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iCSXCqnVD4F9I5Lz1YP2c9Df2qGi3Qpv
X-Proofpoint-ORIG-GUID: iCSXCqnVD4F9I5Lz1YP2c9Df2qGi3Qpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_07,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404230025

PCIe host controller driver needs to choose the appropriate performance
state of RPMh power domain and interconnect bandwidth based on the PCIe
data rate.

Hence, add the OPP table support to specify RPMh performance states and
interconnect peak bandwidth.

It should be noted that the different link configurations may share the
same aggregate bandwidth, e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1
link have the same bandwidth and share the same OPP entry.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 615296e13c43..2e047aba220b 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1855,7 +1855,35 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie0_default_state>;
 
+			operating-points-v2 = <&pcie0_opp_table>;
+
 			status = "disabled";
+
+			pcie0_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/* GEN 1 x1 */
+				opp-2500000 {
+					opp-hz = /bits/ 64 <2500000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <250000 1>;
+				};
+
+				/* GEN 2 x1 */
+				opp-5000000 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+				};
+
+				/* GEN 3 x1 */
+				opp-8000000 {
+					opp-hz = /bits/ 64 <8000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <984500 1>;
+				};
+			};
+
 		};
 
 		pcie0_phy: phy@1c06000 {
@@ -1982,7 +2010,56 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie1_default_state>;
 
+			operating-points-v2 = <&pcie1_opp_table>;
+
 			status = "disabled";
+
+			pcie1_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/* GEN 1 x1 */
+				opp-2500000 {
+					opp-hz = /bits/ 64 <2500000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <250000 1>;
+				};
+
+				/* GEN 1 x2 and GEN 2 x1 */
+				opp-5000000 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+				};
+
+				/* GEN 2 x2 */
+				opp-10000000 {
+					opp-hz = /bits/ 64 <10000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1000000 1>;
+				};
+
+				/* GEN 3 x1 */
+				opp-8000000 {
+					opp-hz = /bits/ 64 <8000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <984500 1>;
+				};
+
+				/* GEN 3 x2 and GEN 4 x1 */
+				opp-16000000 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <1969000 1>;
+				};
+
+				/* GEN 4 x2 */
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


