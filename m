Return-Path: <linux-pci+bounces-2104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D571082C19A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 15:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70235286DEF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 14:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838D56DCFF;
	Fri, 12 Jan 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RuBX7l0h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3473165;
	Fri, 12 Jan 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CCixgT010874;
	Fri, 12 Jan 2024 14:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=MOsWh/CPLlz3hf40VrgTRTtpboqF5Wq4bjb1XfbXPYY
	=; b=RuBX7l0hAP58cTRzbFVwsj4WmyGPHXA5w0vWsqjg6Q1dhNdJXvZBxyIg2sc
	5DQ2GNrdd9W/DfmBvDb2seMZRcnXB4UrRlEi0RyGBNb3yJTTJ9ITkOCuJc0cjV+l
	QJ0nzTbkHAPt+eY5Gfc6QNq2MN718+V5dy+5p7W0IKc95VtUkrD6JHZeGHMIsvKx
	663RjHi+/94HjZzgMRSs1A+AwaZtiKUy6Ha/b2PCmiWM4wBi9BodVVj8uoEiOp68
	1wpwsp0enDPmPjtJyNmbC1dd6TWDL3EAS/Vne5PPJCEVmqaSGx3cImw0wLRqhjfr
	KDFHHNaVjcvD25sWiDC8wGKZiEQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjrqj21qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 14:22:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CEMjtJ013123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 14:22:45 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 12 Jan 2024 06:22:39 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 12 Jan 2024 19:52:03 +0530
Subject: [PATCH v6 4/6] dt-bindings: pci: qcom: Add opp table
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240112-opp_support-v6-4-77bbf7d0cc37@quicinc.com>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
In-Reply-To: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <vireshk@kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna
 chaitanya chundru" <quic_krichai@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705069333; l=1100;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=rjDyan7hVChRyRloeFscwh9lZLtSClwg9Aoh3yWDvbY=;
 b=QHC80My6z+zXPy3rUj40Km7H8Bz1kLw/bVP3Ubgo8fNVJDK9hnb3Ms2371VlgwaYbddBidRJi
 D/6BvLdwrc5BN9q8q0QaHAZrf9E3/Ye0ZKFQ57hWBPYBkDE3wwe3Goa
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KNfwV7m6cJY9QvLiyf2GXH2slYWOzrZh
X-Proofpoint-GUID: KNfwV7m6cJY9QvLiyf2GXH2slYWOzrZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=804 mlxscore=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120113

PCIe needs to choose the appropriate performance state of RPMH power
domain based upon the PCIe gen speed.

Adding the Operating Performance Points table allows to adjust power
domain performance state and icc peak bw, depending on the PCIe gen
speed and width.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index bc28669f6fa0..a37b2ef7dbfc 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -122,6 +122,10 @@ properties:
     description: GPIO controlled connection to WAKE# signal
     maxItems: 1
 
+  operating-points-v2: true
+  opp-table:
+    type: object
+
 required:
   - compatible
   - reg

-- 
2.42.0


