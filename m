Return-Path: <linux-pci+bounces-30592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3DCAE7B42
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910A31BC7978
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1D29A9ED;
	Wed, 25 Jun 2025 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ab8rJEaO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5A299AAF;
	Wed, 25 Jun 2025 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842079; cv=none; b=lLXWcWJQqu1v8Opwq52TqQwYHIKvqm24HjNzUPRhniAm+1PZLGmyueECfIU/z//L17+BWWF9tVxZ+hbspmVaj2aeycm//oS/E/qUestk2LdFm9zc1q8c6/SBSyiipdq/qzoEByparmndxuP9asS9TD+aHCvxrwZwdLDoejXA5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842079; c=relaxed/simple;
	bh=RWtJzvoBJLoNAPg+99T+h1ZSWa1l79k2V0fKSfhK4aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r2/9N0cDkeDHDiDAZTuo3l9KXh/DDFYav2oiSN1naUwCG5Kwku2UcRw3iAv6uchUedAE36b3DcQnvs1o2iGVPNvhKF7pe3PQveEWBlGYrpYhOMAAe7IMns8UViEMazD7OoHkCX0BoQvJT6ThWxbLJIzJKaV78PlH9EnB9QPhKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ab8rJEaO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P4KKf9015714;
	Wed, 25 Jun 2025 09:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VUygOxBJHK/
	NDzL4Dxb8pxQPxA92Z5RmjWqw+TNHM0M=; b=ab8rJEaOMV/441ygzuoh/iFIZGy
	Cs1CZTud5BN1eqUgs7xbzVA7B8XaKWJurjIfGzpR4qZnivbYD4eia+Cg06gmIMO4
	1ipbJ6/+Eayg1BQA8HWNxQXS7ezADaG/TjoCstNyctNJoFce+cGcqe2JFKg0tARd
	M0m8nen4rJ5TDfPVISuRfw4S226Q6+AadNIeUUYNAQmcMIPPMaSJadIsEVWc1cq1
	UU3xK7ciZoYNF1QIbgRgjxNN6Sg2y8T0Q8Y2hAoU1gHmol/qWMO7gGHzb2mmPjWU
	FSZKn7IBovNOTaRRrVzCOvlfu2hFHJ2GiFvwfdoNnPm2WQaPsVQwHBCceAg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5r9ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:01:02 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P8w5C0016614;
	Wed, 25 Jun 2025 09:01:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47dntmas9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:01:00 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P90xbK019589;
	Wed, 25 Jun 2025 09:00:59 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 55P90xRg019581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:00:59 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 14B6B3832; Wed, 25 Jun 2025 17:00:58 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
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
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v3 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
Date: Wed, 25 Jun 2025 17:00:45 +0800
Message-Id: <20250625090048.624399-2-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
References: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-GUID: xv0abv4vbBCXzenI9ww500KkJ_TD9ng6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2NyBTYWx0ZWRfX1OsFW4+hhhPb
 Pf9p9xKa8jLpsDIaytzBDRqwI+9AV1S3qxqbKkcM+7qjh/VCy0IFLX5GjECtiNXzeNwCMo1jSiJ
 U35F05CwkC01TP2IFx2PO6f64ZZ5broO6lChzRgFVjJMu8SEUZ7nRbwM+I6iIQql/l3B4F8WHxN
 FgWlHfRPixTxY7ufv51FXlPKclQVqB+XrPFnNBs/epxvn4Lxf1L8aBMw7TQtrFDf1d9ty6jKyQg
 JtmkGlJBoh8AAORdnUv7zti5xESQq0FEOlK4T3HSABubEQXWqiHVymGv7Ma7JXBQtoZnZwyr7uq
 StNON3fRjco4iypPbqzL0yfx41Na9IUNA9B4KMkYGxTstgHdYIbX8UUfk86As8xiovxMd4H686r
 V8T/6L3co9FExp1j4jZJzmS/hWGumAK6OLRqGjCHKyuzIth5C4p2MXb7S46HFIf/5tSc7OVF
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685bbace cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=MFBqe-ynCY-DoL1lFewA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: xv0abv4vbBCXzenI9ww500KkJ_TD9ng6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250067

The gcc_aux_clk is required by the PCIe controller but not by the PCIe
PHY. In PCIe PHY, the source of aux_clk used in low-power mode should
be gcc_phy_aux_clk. Hence, remove gcc_aux_clk and replace it with
gcc_phy_aux_clk.

Removed the phy_aux clock from the PCIe PHY binding as it is no longer
used by any instance.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml           | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 2c6c9296e4c0..57b16444eb0e 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -54,7 +54,7 @@ properties:
 
   clocks:
     minItems: 5
-    maxItems: 7
+    maxItems: 6
 
   clock-names:
     minItems: 5
@@ -65,7 +65,6 @@ properties:
       - enum: [rchng, refgen]
       - const: pipe
       - const: pipediv2
-      - const: phy_aux
 
   power-domains:
     maxItems: 1
@@ -176,6 +175,8 @@ allOf:
           contains:
             enum:
               - qcom,qcs615-qmp-gen3x1-pcie-phy
+              - qcom,sa8775p-qmp-gen4x2-pcie-phy
+              - qcom,sa8775p-qmp-gen4x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
               - qcom,sc8280xp-qmp-gen3x2-pcie-phy
               - qcom,sc8280xp-qmp-gen3x4-pcie-phy
@@ -197,8 +198,6 @@ allOf:
           contains:
             enum:
               - qcom,qcs8300-qmp-gen4x2-pcie-phy
-              - qcom,sa8775p-qmp-gen4x2-pcie-phy
-              - qcom,sa8775p-qmp-gen4x4-pcie-phy
     then:
       properties:
         clocks:
-- 
2.34.1


