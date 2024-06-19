Return-Path: <linux-pci+bounces-8991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811690F1CD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 17:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23DD5B25808
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D271514FD;
	Wed, 19 Jun 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j69YxypE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8943E13B7AF;
	Wed, 19 Jun 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809907; cv=none; b=bzRqiAQTQHCCRuewdp7EjHdhBsdFYE+jZ7PyFmJ+0M/9kmQI9On1b+uDvwRhlTsMLzGE2M3Oe4fTTxbtBZ45oeK1rkIDzhVf2YoNCZnWrTLuQo4+GU2zxpVtgp7+zLGbnY72SiKtfgDui/x+ySNQ3dhkQG+S6F6OABTGJsjAaXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809907; c=relaxed/simple;
	bh=FG21nJMzDgQVBPiWDAMRoSDJCoh5DoD48CK6U3Qv5f8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tNvgM2IhH8qZjbFSnK207IPNeVKB/Eh/RFfvpx34YtnI9SUH7Yk+NX/dowKsuHZwa/BpCSRSEYZL3wuGSkYnWLqv9w/G68AeAPWOwY66RbJQ7g3wRmPit08mgygyDEDQwD5pXHd/VwxHhjZN99/NwKieJTkndOHCFYWe6dpSAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j69YxypE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JA4K0c008449;
	Wed, 19 Jun 2024 15:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ljGBYLQFC3HKRQ9g+LrdPl9BYHhm2n7q5flQqnt1vP8=; b=j69YxypENRZfG8/A
	FQyVz6Yu9OCw0ABnqwRH+CC8mH62iSren2rVTVMp4zHCshS8CTKUmr4KE6mmcgxg
	tuj4xtk8Id7mpN8wn9EhQ3lRn94vTJIwvVcLnNutda9KUpuwMTEBubR818ewsWEe
	sjzv6Nsn74CefV2fF5SYRcbRKwtEF5T92cYfnp51jQCJOFCiFr5pVgP5JDuE94/i
	tYaxkGPmzackvl9RHVK9Qq52ngHvxI0udTmnKChSovSzWYjvcxATBfVHn5VZtLB2
	H6nP1ywtNJPMuTpmETcaNwLn3Ka3uAmnLdr/jJk8/eXcJHTdbyQ5PPPGc1g2vuip
	N4fYvw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9tj3sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:11:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JFBYoi000962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:11:34 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Jun 2024 08:11:29 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 19 Jun 2024 20:41:11 +0530
Subject: [PATCH v15 2/4] dt-bindings: pci: qcom: Add OPP table
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240619-opp_support-v15-2-aa769a2173a3@quicinc.com>
References: <20240619-opp_support-v15-0-aa769a2173a3@quicinc.com>
In-Reply-To: <20240619-opp_support-v15-0-aa769a2173a3@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC: <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718809879; l=1082;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=FG21nJMzDgQVBPiWDAMRoSDJCoh5DoD48CK6U3Qv5f8=;
 b=HXDb9w+C2MkmeK9090SIvN1UU5kTiVo2tZQKmILJNxaC456hKAN899AjH7vbj6+bCUPBUtEIO
 Y0vpG3m+ZQrDnoIws2vBuXKQl3QKk4Ouw3lAiZBBZ55YziZ/obwLCPy
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bpOKeSQKapEGiPuBqUIvSvJoRSpQe7yY
X-Proofpoint-ORIG-GUID: bpOKeSQKapEGiPuBqUIvSvJoRSpQe7yY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406190114

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


