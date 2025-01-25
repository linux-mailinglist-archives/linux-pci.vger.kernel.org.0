Return-Path: <linux-pci+bounces-20348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29EEA1C0D4
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 05:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA350188E266
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 04:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2EC206F1A;
	Sat, 25 Jan 2025 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AsP2twnm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034E206F0A;
	Sat, 25 Jan 2025 04:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737777608; cv=none; b=k0/iMCxRNPwN3Nr22KdnN217v34csruoaEsnvpJyQ6kfhMJCLasdF/MCARqvsEKUWw2eMCQJJ93t81uE/NcWq+iGjIecXWXBVnKaSX8B8RaPpOUO6bK4baqrlJsVaJzT4j6OPA5Zc6UAu/EdTKWEMjdtmga8qUgfiBK1F+VFqE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737777608; c=relaxed/simple;
	bh=05BF7inlDiYHaC1qBWctSVC+or5QKtakRnq+B7Iz8pc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzgMERt15xRpWkvfX0eJU227PWLGZo7lx/L/ERS/qpYqR7DUgrBw7b+RGTBSym/pd6DAj42o4ewgQ1NXS/KW5RX42YwFOlGwtjVQr4GN4F2xtsuf7TTYJxixyzTn+v7gB/I4nS433J5rbvsJ51Rz5/2gBCwumgFMYPv8OhhAMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AsP2twnm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50P3rPtb028954;
	Sat, 25 Jan 2025 03:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RaKYYJMZTmjzpQAVRmm5dJ8L2fPuGYmRw3AuAtcoutM=; b=AsP2twnmt1sAx5BR
	PZcLOHspioDkbGSfXSjZ1MxB0QbaBPrDjM2TSaBmwQyGZzASTu1H96alu3kJQLGt
	oW1IHrVFkB8t1lbaZvzzkpGShL65Rc6NV1pOfC8zKPLAj5LsAfFFAlOvr6KIpnzf
	WicyEjbaFLpp+D4QPGca9yr7BWzoSawWemgACaI4Uex4ayScHy7BI+uHwTJ0C3KL
	ACzvuhA0GEnt3fmswbYp/GOB1IXR1fsQuLmKAXOj0vxrR3l2UDH1JrMSO+WMVaZn
	jd4J+Qgw6GiVyRT9w4jPh4319W/OmOrHtaPDdJ0db5YKr4f04XPCEYCvkx3E+nfE
	OLcVlQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cpwqr3v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 03:59:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50P3xnTM008800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 03:59:49 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 24 Jan 2025 19:59:44 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <bhelgaas@google.com>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v3 2/4] dt-bindings: clock: update interconnect cells for ipq5424
Date: Sat, 25 Jan 2025 09:29:18 +0530
Message-ID: <20250125035920.2651972-3-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
References: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Do7XR2XAQTmOLjW7uhndlhMNwyAsgaZs
X-Proofpoint-ORIG-GUID: Do7XR2XAQTmOLjW7uhndlhMNwyAsgaZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_01,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501250024

Interconnect cells differ between the IPQ5332 and IPQ5424.
Therefore, update the interconnect cells according to the SoC.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 .../devicetree/bindings/clock/qcom,ipq5332-gcc.yaml       | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
index 1230183fc0a9..fac7922d2473 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
@@ -35,8 +35,6 @@ properties:
       - description: PCIE 2-lane PHY3 pipe clock source
 
   '#power-domain-cells': false
-  '#interconnect-cells':
-    const: 1
 
 required:
   - compatible
@@ -54,6 +52,9 @@ allOf:
         clocks:
           maxItems: 5
 
+        '#interconnect-cells':
+          const: 1
+
   - if:
       properties:
         compatible:
@@ -65,6 +66,9 @@ allOf:
           minItems: 7
           maxItems: 7
 
+        '#interconnect-cells':
+          const: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


