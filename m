Return-Path: <linux-pci+bounces-39254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84452C0572E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 11:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24CE1B876CE
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 09:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE830E842;
	Fri, 24 Oct 2025 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F5H440ql"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32B309F14;
	Fri, 24 Oct 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299787; cv=none; b=aZqgQISPCywzFqo/5VIa828TU8g5+ibzrkUmI2CdGibNb16R8P0FuTdYK5qd8prisYUnZqBZyfXvFkv1MmCHymFiHndoMti6MGqzTkFSGTZBbMRO2RdutWbTBTDRjMpxVwxb8krX+YYjX17BG6gpXhVDeUj/d6fUE6c115SZv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299787; c=relaxed/simple;
	bh=+rTg8afm2y0TqphIbfAwVlHDfvMM7iwTS2VI5qHvrdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HxxJwPCmIGspIy5w3SmqY1xzp0VJOQjgr0I+80HrCAeyBoCLX8sJtf2u/wjQ/xSl56K+VxvhpAF26dIFlbIKqXmIheLR5aWOyBurrEtwk9gRdgIc0ViizocN/axRzAyK4GM43rk3QHR6dPrtvqoa9NbybwUtHUzEez9TaARld1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F5H440ql; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3M7Td010231;
	Fri, 24 Oct 2025 09:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=t6fT3KfXhJv
	+XgqO/RptMTACwmv1xlUEN1ugE7Ghdoc=; b=F5H440qll2aMXiqq6/HZ1zhdoVG
	3A+UJ1yBHTOPAeTQYV495V0tBQu7+1L6GwHDhBYUAdoiSMNymiuutjlQ0qJc1lHo
	++ZHCfmu5wNaTFVY0KubuHeSoUs/k9gZ0XRGhm7NleRNs7y1L8AjsaC1S9Qyub3l
	i83Pvy5ckvlpbEHTTKgdotmshrMTWkxEjkOclbVUBZm5KbQH+CxWST9xEkt9eyOx
	xAMSOphsK38vB9hjnUwQP11XN4rnS9nZJcMdj8I0Remk4qmLYEY1liznkEiOYbC9
	JLgv41Ulte/jym9Os3vr03o6H4orPB3sBlgcuWE/CX+MxAop+e/EudfwJ8g==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524du68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 09:56:16 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O9uDSI026102;
	Fri, 24 Oct 2025 09:56:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 49v3ymy0qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 09:56:13 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59O9uCk8026079;
	Fri, 24 Oct 2025 09:56:13 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 59O9uBD9026068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 09:56:12 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 999A85A1; Fri, 24 Oct 2025 17:56:10 +0800 (CST)
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Subject: [PATCH v14 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for qcs8300
Date: Fri, 24 Oct 2025 17:56:05 +0800
Message-Id: <20251024095609.48096-2-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com>
References: <20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX/pOnDomuXM59
 VQMzIrqXmKOOaFMQrPTQSaTDKpvVPfkoFXjQK5jSFBk5VdeL1DeQ/eAXaomG4kuF9RDMzXOB1IS
 GDwlB4odLWYBRMmxGvfSkYUHyXhhS6FiwLFn9I4lYMNgpTNUQqrnp6vZGT4BOkFUP1sG2Nc8daN
 DEyHISvHWpGQX+/UL/ie57mHnUK14m/j6JRSaGZUQKr2Glt8KV5pZEdfiAkOQzW3hJUor+S+rgK
 WWA66VDtKvc8aOoseosnuqDJsRqPEipqot7ZZNQEZ9poIGYQe7ZZSRMfGV0EEWgGgrOSArIHMmT
 G7svV+54tC+WH8NNwZSyxsXcTtR1v1WkggfRMkNv046YbEZtwMltmhkrWqQNPxnrMQ+kWokFxeI
 ECEwrmgSZI2liAgCqoZ8nm13ZKbQXQ==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fb4d40 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=YhLpWKUAjgHs1wdaIGUA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: wIVwlbHV-wSvJBRMFht6kB6PUjdkTL1E
X-Proofpoint-ORIG-GUID: wIVwlbHV-wSvJBRMFht6kB6PUjdkTL1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
specified in the device tree node. Hence, move the qcs8300 phy
compatibility entry into the list of PHYs that require six clocks.

Removed the phy_aux clock from the PCIe PHY binding as it is no longer
used by any instance.

Fixes: e46e59b77a9e ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS8300 QMP PCIe PHY Gen4 x2")
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml         | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 119b4ff36dbd..d94d08752cec 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -55,7 +55,7 @@ properties:
 
   clocks:
     minItems: 5
-    maxItems: 7
+    maxItems: 6
 
   clock-names:
     minItems: 5
@@ -66,7 +66,6 @@ properties:
       - enum: [rchng, refgen]
       - const: pipe
       - const: pipediv2
-      - const: phy_aux
 
   power-domains:
     maxItems: 1
@@ -178,6 +177,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qcs8300-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
@@ -195,19 +195,6 @@ allOf:
         clock-names:
           minItems: 6
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,qcs8300-qmp-gen4x2-pcie-phy
-    then:
-      properties:
-        clocks:
-          minItems: 7
-        clock-names:
-          minItems: 7
-
   - if:
       properties:
         compatible:
-- 
2.34.1


