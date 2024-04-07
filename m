Return-Path: <linux-pci+bounces-5827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C7F89AE7C
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 06:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A588B228B9
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 04:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED7417C9;
	Sun,  7 Apr 2024 04:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G0uHNX7L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB98F5A;
	Sun,  7 Apr 2024 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712464694; cv=none; b=cycgS407QK58jqJDsf3To2daMf4sGtSOMKNRB55sOyexc3YZZ8sNZ2Wb6mlq92Hr1Lephy4sB9b9Lu5zygzfMugYffDN8hCW85El0x+jc/KFSVO6l/80EV5JM7YBpMK0UEtVB/BxMTd8tQXwnOYIAhjmPP7DZ5RUyLorp7Jnv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712464694; c=relaxed/simple;
	bh=38+pc6fp4Bi8iwgSa3k5uGDyyk5WKllARuGTCiydA44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=htrSLpQmYb9XA3ivSLeZWWjSm664KAazmxDMqIcEEwUmyYaiadqoBla81xjzWMn0SeddgLoJwA5q0oOCT0n9XrqHoURg0KrEZDhsi4nr7wxD3MynzopLUpcn2+voBu8TtpWhoFv43DcMpUBT8xy3/6pueeVvc4IQ/A/ljNklfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G0uHNX7L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4374ZaZO006274;
	Sun, 7 Apr 2024 04:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=7/pYMfcCmo4oJQ5sjwUXzt2sy72takiiTnS9dRadsQU
	=; b=G0uHNX7LxqeV08XS4RoybtoAAy4X6CM1k7bfyXk+MvRi0ORVDoBtUP2URVj
	LnwLW1+eP0KwmBYHOgtLagMzkCOxJy8zgnGhb520LZYAeSImcrbRWLZLhxmKm8p9
	0RCn9P/VMSqs3m+8tgNYXSFWHYFUwXd2JnemRgk47+swVa+r2o2IOwZ3qsiOq11o
	ZtMUrbdNCVhzeYQq6d1cL5CFSlbiqjeNU8hl8WHCzqia+m36sbkJYl6ueqy8pPHH
	zZ+6e5+40NLqfErcmkSKtViXRKbVtbxkb/wJRTc6DmtoH8C4ZUtC4NScoeTSkLQj
	ZIvnTiPx1+scVricrjSaPkyhZmw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xawbv1e6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 04:38:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4374c0gG031531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Apr 2024 04:38:00 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 6 Apr 2024 21:37:54 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sun, 7 Apr 2024 10:07:34 +0530
Subject: [PATCH v9 1/6] arm64: dts: qcom: sm8450: Add interconnect path to
 PCIe node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240407-opp_support-v9-1-496184dc45d7@quicinc.com>
References: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
In-Reply-To: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712464666; l=1661;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=38+pc6fp4Bi8iwgSa3k5uGDyyk5WKllARuGTCiydA44=;
 b=YJGSBIX4jBBSWhz9aiYejylRmLufHu/WDo8uKc7nAcN/qLjJIAMG5dVDqbcAAvK2F/DnwhYC9
 QPsHy9TlWrqAoIgKtK9/XiPGzMQS9T+Hfu662RsIztWZMKgFHoufOyT
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AOml5LHvveTMLy2eyBBfBvxCBE4SaQfB
X-Proofpoint-GUID: AOml5LHvveTMLy2eyBBfBvxCBE4SaQfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_02,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404070033

Add pcie-mem & cpu-pcie interconnect path to the PCIe nodes.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index b86be34a912b..615296e13c43 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1807,6 +1807,12 @@ pcie0: pcie@1c00000 {
 					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
+			interconnects = <&pcie_noc MASTER_PCIE_0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_PCIE_0 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
 			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
 				 <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
 				 <&pcie0_phy>,
@@ -1930,6 +1936,12 @@ pcie1: pcie@1c08000 {
 					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
+			interconnects = <&pcie_noc MASTER_PCIE_1 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_PCIE_1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
 			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
 				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
 				 <&pcie1_phy>,

-- 
2.42.0


