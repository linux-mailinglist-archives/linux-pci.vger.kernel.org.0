Return-Path: <linux-pci+bounces-4362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB21F86EE65
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 05:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122E21F21228
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 04:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728EB1401E;
	Sat,  2 Mar 2024 04:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A3zvmc4w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5991118B;
	Sat,  2 Mar 2024 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709352047; cv=none; b=PJCfTUi3rmJFWyG7Nr9HIJRzgdXypGKehyk3Vvxr4USlKU/Ki0gC/A+sFMl2W852tdzLyHjpqSplW2cNLSjxuGroJUAugP+f/2/cyXZwi6wPfcbxuZ4FEW0HAAoaC9WHpDYuJ9Pycj72bZFDQ7iHhdqLu5nLatLQz16zPgCCTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709352047; c=relaxed/simple;
	bh=sUI5hJ3jZ135N0buYIvZdIjDEI5T2GRIwmaUXAbq2Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jHopQNH7lyE25jTJ3xSDx0Z9s16r99ZVNIgmkvQLZepxDD/IGSv9QvRes4WhRBb+0gbJ2HlVoUgqmNd/PGpGFXaRJt3evk4lxALP4NGsGYZw4xQzQc+o+q/68TdyfrBw60wUImkpUiAXDobKMzjpkBrfo9hOl6r/CSSo1Jir2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A3zvmc4w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4223cHE5031520;
	Sat, 2 Mar 2024 04:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=2ilRA4F8XouQOkHZIvowRMIrWXeaZkTccgPDvx1p9nE
	=; b=A3zvmc4wxLRzX/VcTHg9RhWfaAweNbZmOCrdllNke7vOLA32U1mrvF2aqfH
	SUV7/VtoVcpHvGRyS9kmReJz5X+rWgMYVe3hpkBbvmeuNOl4PS0wtmc69iW/e/9j
	ACuEfRQa9+VuH2TYLPJxEQZrTbJW+aRRsuY4wdozuRZ1SzpK5qkxtQHVHtrvQmij
	uAS+R18obwUqdNJnY3nqPmt7w/6GK1SLgk/DkH64rss2FYbHr6+5gIEUFN90IV6P
	ySv31DrmFHMD9OezAzcCx6B0Sgurk7FIkWwCluRyX0kI9mtLBQpfHVOM/VL49sdF
	qKOKVKR6xvlGX7FSHmPP0TZckvA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkvb700uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Mar 2024 04:00:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42240bk0022020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 2 Mar 2024 04:00:37 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 20:00:31 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 2 Mar 2024 09:29:58 +0530
Subject: [PATCH v8 4/7] dt-bindings: pci: qcom: Add opp table
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240302-opp_support-v8-4-158285b86b10@quicinc.com>
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
	<quic_krichai@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709352003; l=1100;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=sUI5hJ3jZ135N0buYIvZdIjDEI5T2GRIwmaUXAbq2Io=;
 b=90BuwUoUGlGb5Y09sLQamOc/5rpkMeK9o7ILGO8ZC+p2acsODxhCGkHSOAk3L5F4gMoYvHXp1
 r+hUoI2CdbVDfwhriv9NOS1JxRzBVKav+Dw5Hnk19L1iian3snlgmXA
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O6xiWKqvSTBjrPZnzPKcPntHbJeJmXuu
X-Proofpoint-ORIG-GUID: O6xiWKqvSTBjrPZnzPKcPntHbJeJmXuu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_24,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 mlxlogscore=919 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403020031

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
index 5ad5c4cfd2a8..e1d75cabb1a9 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -127,6 +127,10 @@ properties:
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


