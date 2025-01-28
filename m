Return-Path: <linux-pci+bounces-20431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C2FA2045B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 07:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCDB3A766B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 06:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5000D1DEFE4;
	Tue, 28 Jan 2025 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FPAAUGnm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9C18DF86;
	Tue, 28 Jan 2025 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738045677; cv=none; b=CkYi/M0qnsR+8zxtuZjBrubn442N5Jdx+HrCypBElu9HF0nle9lKpPBTa0qXu1a5VF0ejEkEW0Vp1TKbzcHF2qlTsug+s84bR4e3jr1PNQoOSC0AUf/Qz8VcqxlZQ/REB3RReVE+KovnamhIuuMI2rJkvvq4y9YZQpd3sK/qogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738045677; c=relaxed/simple;
	bh=Uod8M8vpW1OR1qS+XZBYmtXeu9VjFqIZymuD+QDwf8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaP6yBPqnp6N71p/3cOVmWlhtORjP1nTxVLL9ZkSB3DnHwrgHjZlUqaMWTdO4hx36t7IovTLuo8c0LMKhUhst6BS52Dip9Vc8QBJM3LKjcYx9wggsxiLTBDXakEKWOCbtl2wE/o89i7nRiCl+y9VYUCAtEZt5hpgCyB4q05r+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FPAAUGnm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S0Vf3D002698;
	Tue, 28 Jan 2025 06:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JoWXz0+hbIKwSbaA5Rj4Bz7KEmuoMxiykAKBvtRi3z0=; b=FPAAUGnmXY2drPuF
	9+rJ/smoMYusTeO8AWU4trgaRlXfwSoIhkHHeqp3Gm9+UPA1/eUDPIS1NgLpX37O
	NyQRmUgVd8Qqyn7kLdrfuoYjdRnkXhXHZRIjfV6bVYGOPm4p+62UptQqTPn8kSTT
	wCzIOsExEUppHyxsKMiSO4KIZ9H3OJUlO3CeYCNwXBQcZtKWyNgkrcrp9k9RClA9
	7WIHpyRJqBRT36cg5dK7cdlXP3nxFF1QMdgGOP6MEP71QSxJUXJiHe/2Ub2RurJp
	JjtYz7BN0N0dytYblQO/6lIEvS2DUdd7A+jsdXv1EH5ZgNazZjTdWlCm1QvRB4kg
	5w6Kgw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44emry0htb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 06:27:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50S6RivU021053
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 06:27:44 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 22:27:38 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 3/7] dt-bindings: PCI: qcom: Use sdx55 reg description for ipq9574
Date: Tue, 28 Jan 2025 11:57:04 +0530
Message-ID: <20250128062708.573662-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128062708.573662-1-quic_varada@quicinc.com>
References: <20250128062708.573662-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E1ARl680u33wCXtiP1i6Jl1jUVBMAgN7
X-Proofpoint-GUID: E1ARl680u33wCXtiP1i6Jl1jUVBMAgN7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_01,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=806 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501280046

All DT entries except "reg" is similar between ipq5332 and
ipq9574. ipq9574 has 5 registers while ipq5332 has 6. MHI is the
additional (i.e. sixth entry). Since this matches with the
sdx55's "reg" definition which allows for 5 or 6 registers,
combine ipq9574 with sdx55.

This change is to prepare ipq9574 to be used as ipq5332's
fallback compatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v8: Add 'Reviewed-by: Krzysztof Kozlowski'
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 7235d6554cfb..4b4927178abc 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -169,7 +169,6 @@ allOf:
             enum:
               - qcom,pcie-ipq6018
               - qcom,pcie-ipq8074-gen3
-              - qcom,pcie-ipq9574
     then:
       properties:
         reg:
@@ -210,6 +209,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq9574
               - qcom,pcie-sdx55
     then:
       properties:
-- 
2.34.1


