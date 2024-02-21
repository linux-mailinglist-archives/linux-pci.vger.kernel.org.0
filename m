Return-Path: <linux-pci+bounces-3822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB1C85DD62
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 15:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 544B7B21062
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881097BB14;
	Wed, 21 Feb 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SmlThAbB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE345762C1;
	Wed, 21 Feb 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524269; cv=none; b=H2ogikXN65KKAVM9fAGuATkFSdmPjbGmZCpnfK6v+lwaMEjRfYWL5J0pABuc6xpw0LYzDJrO4zAyU6xpZUdWnCFNN+9k8FEfokos3eYwEUv9XHZ4ejMWaGRUuiSiy7yuzq19u5hLi+WoUzOYpPG5qnNwaiovJN3A36xDsleZgwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524269; c=relaxed/simple;
	bh=rDN6YXXi4Jj9hKLri75fs2GXswgudO4zwSM3AqHNXIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/SxrK0NANCv7rU949VZ1+vHUfbNclDxY8RWw35gI1fcsM2tNhi68IQdSKi4O1jFQU+jQRPCxePo4SEtvwGeDHaXArStSYVZxVXIpPXSqxmEZx3tUeS596ndfJolYsYZOkc8saITKP2UBeN/uFSR/vL1z7gmgQfXuXP+lKq9HWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hu-msarkar-hyd.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SmlThAbB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hu-msarkar-hyd.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LB0AcH003491;
	Wed, 21 Feb 2024 14:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=Ur2iNkD
	AwgpJroYXONg49nEPN3PEIQqjXl88ksY4Vjw=; b=SmlThAbBOf4IE3ll42/CyI/
	EjsE/KtNgN9N7H18nCJyEezuFIqvY8mVI+MmHrJn2ejlh/KPHg6wTtk2fAPxNADs
	q2cg0v5PUua0Rmvrlg8ME+axxLWMIQYzdYKb5LhtvZQ11dqtKrn3x+FcDmF70Gzj
	sL3M0t9I92LsnVb6oBh9FgYBHJ/QO4ZjPCmu2Kgxn5G7Syc1SD8TtG8K5SFLNj4R
	yCvCTXVO6MEw2lhY1Q+3Il1beNt2yMizbSexwOxPAuNChzQda66AWI52JxmHcxCx
	Mz2XVlRn2Gx5X4ApXZlJ7LfwyzrmXLVDmKprAPy+WIckCeXKSQQj7jSwMd17IoA=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21s240h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 14:04:15 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41LE4C3R013272;
	Wed, 21 Feb 2024 14:04:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wanvkycfg-1;
	Wed, 21 Feb 2024 14:04:12 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41LE4Cei013266;
	Wed, 21 Feb 2024 14:04:12 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41LE4CA8013260;
	Wed, 21 Feb 2024 14:04:12 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 0)
	id 44F4139B8; Wed, 21 Feb 2024 19:34:11 +0530 (+0530)
From: root <root@hu-msarkar-hyd.qualcomm.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org,
        conor+dt@kernel.org, quic_nitegupt@quicinc.com
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: PCI: qcom: Add global irq support for SA8775p
Date: Wed, 21 Feb 2024 19:34:02 +0530
Message-Id: <20240221140405.28532-2-root@hu-msarkar-hyd.qualcomm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
References: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n3PIdNzPqXevbg6Z9UZMsPFp0XnuC4o2
X-Proofpoint-GUID: n3PIdNzPqXevbg6Z9UZMsPFp0XnuC4o2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1034 lowpriorityscore=0 mlxlogscore=977 malwarescore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210109

From: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Add global interrupt support in dt-bindings for SA8775p RC platform.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a93ab3b54066..d86fb63a2d2c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -63,7 +63,7 @@ properties:
 
   interrupt-names:
     minItems: 1
-    maxItems: 8
+    maxItems: 9
 
   iommu-map:
     minItems: 1
@@ -873,8 +873,30 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-msm8996
               - qcom,pcie-sa8775p
+    then:
+      oneOf:
+        - properties:
+            interrupts:
+              minItems: 9
+            interrupt-names:
+              items:
+                - const: msi0
+                - const: msi1
+                - const: msi2
+                - const: msi3
+                - const: msi4
+                - const: msi5
+                - const: msi6
+                - const: msi7
+                - const: global
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-msm8996
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
               - qcom,pcie-sdm845
-- 
2.40.1


