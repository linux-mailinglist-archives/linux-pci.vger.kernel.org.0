Return-Path: <linux-pci+bounces-7643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE2E8C9859
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 05:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143B9282879
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 03:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC1311718;
	Mon, 20 May 2024 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iItvZHx4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585EC1C287;
	Mon, 20 May 2024 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716176016; cv=none; b=A8um2+EpJfKNRwThlkgQgGAGsg249qPyDt0o2zRVZJ+sowtYDohyT9Bm8Piigi32HCVf5lyWJukzWaoQUPNKa82xa0ZCzn+xHD5tk/covjZlxQsLg9MsZhEY0v1LkeEQWOBaycxcAtsTLhLpFKD2j+UCypEE1b75qdWL0E93Tg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716176016; c=relaxed/simple;
	bh=FG21nJMzDgQVBPiWDAMRoSDJCoh5DoD48CK6U3Qv5f8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tJ7U9aVSnf1NX4ZEXBm7Gx7ZBHprVvuWGDIwFHBdUv1DInjIFhfFwkkPtKx2G+K1uJpPYj4lFvk2TpWDHXcX5v7Mu76zR/eyIRWCC/5tmgme67DeMUv6Wy+JGXIktDlkkotfshKkb3IzoeWKEyN4famANmq1j67XYGzjMRzBw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iItvZHx4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44K0vWhN009728;
	Mon, 20 May 2024 03:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ljGBYLQFC3HKRQ9g+LrdPl9BYHhm2n7q5flQqnt1vP8
	=; b=iItvZHx40gBqPLe/iu6Rw/DX6Xk1XXZ9U0kdriL8StjpHYYTOhoMjNqzhvx
	YkB3QaF2uAuCWYm/Kj60EK0X0JYF6FL0a97X/pKlkhWIqABGYzeoIp34WmTTS/Qq
	ErMnMR6MP1WJUEjqHNk6q4K29ovLCdOLSXCUty+k8jsazxOu8OeS0k24vXJYX5cG
	vwli29eQu9+n1H02WHxl4zjz9iqLmXmCcP0cOBmqGIJbIpUng+83WBsRkowet6gj
	8SPw7Q7xq1XW8pJoTALQvWMwf5e+7wCFn/H042xQ6uHX9LZb/I+WaZxUISmsJDFH
	+YHLGirccYmKyrQxcIWoTMCnnsg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gadn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 03:33:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44K3XNx9002388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 03:33:23 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 19 May 2024 20:33:16 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 18 May 2024 19:01:44 +0530
Subject: [PATCH v13 3/6] dt-bindings: pci: qcom: Add OPP table
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240518-opp_support-v13-3-78c73edf50de@quicinc.com>
References: <20240518-opp_support-v13-0-78c73edf50de@quicinc.com>
In-Reply-To: <20240518-opp_support-v13-0-78c73edf50de@quicinc.com>
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
        <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716175976; l=1082;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=FG21nJMzDgQVBPiWDAMRoSDJCoh5DoD48CK6U3Qv5f8=;
 b=bZ5SUCPKI0zNzaJ1WHzXyY9g/XKIgTf928Pf2zgyOEWGEBalJo1O2iWMX05pMAGPYvLcjL5g9
 d8EHre4RYdADpsiCVRGoxxCHv/m9wY54DFTJhGLKbFcvhJSXF3fo+av
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y_iMjETBgw4NY4aGj6N74Y-GRr5R1zMG
X-Proofpoint-ORIG-GUID: y_iMjETBgw4NY4aGj6N74Y-GRr5R1zMG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_01,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=916
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200026

PCIe needs to choose the appropriate performance state of RPMh power
domain based on the PCIe gen speed.

Adding the Operating Performance Points table allows to adjust power
domain performance state and ICC peak bw, depending on the PCIe data
rate and link width.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
index 1496d6993ab4..d8c0afaa4b19 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
@@ -69,6 +69,10 @@ properties:
       - const: msi6
       - const: msi7
 
+  operating-points-v2: true
+  opp-table:
+    type: object
+
   resets:
     maxItems: 1
 

-- 
2.42.0


