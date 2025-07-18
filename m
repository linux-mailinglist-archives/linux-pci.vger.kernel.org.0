Return-Path: <linux-pci+bounces-32508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A365B09D98
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 10:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE565A2D45
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 08:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A7820B7F4;
	Fri, 18 Jul 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NlS+OyHh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8E1F95C;
	Fri, 18 Jul 2025 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826657; cv=none; b=B+UJxMF1Qo6REXkXgrWDd+jHeAawvJfvXa9hpW44urdU6I9zd/3iUeoCKuybVmXdGpgdXHgrUpRgGfN+LwIw9TWy/cPocG3csdMPEINnUmOntyuHoXFs+F+Zu97VrLrDnPVoYf5LdLP2AE4Yvc34mwyW/SKy9dUhLg+5r7bjzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826657; c=relaxed/simple;
	bh=0K4SPuuIcngGAFPRvbGGNcGdo9ZYodG/HB4xyll+vhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MpM5xYOlTlo1d44CKpIgxzhhng41RvPNmpObm0k/B+Nq2UOusLHgZLAFl6hyEva2tybrmrKn5l+Ewu+JyBiy9EH2hTGdoFxkgnzSINKJGHmmOT0Ix+6NsdLP5aCnC2gxyec9qVlENvkKw6YJTlGN+H2CHAtiXttfFw27gvQ49oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NlS+OyHh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HLqEHM007306;
	Fri, 18 Jul 2025 08:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zVcXn+xouwm
	9M08R+gXXqzI0UC+BcJoS5cp4Pak5RCg=; b=NlS+OyHhnXBEDBfCa/5wTU8iZPT
	Q1bk/phcLnrkOUKh7LE9wbUmCRgH+RSPUNPYv1Idenk9AllLWUmP8Wnk+uHsYtFe
	NLZX0uY0d+FUyiW2/FLoah/FGuPXI2VwkszsE5g1waLUd66qecRwUVNgZaAzQowb
	UI9TX2jy55/Rnqo0sCMSQNKQi6HrcQfXtsMt1aNTaJetI5OnKbuJl0QdXiW1hdZQ
	SaP7ZHfF94ktr2PkYBYtDoifUvwl01Qo4+GoEn2gxBZ7fDBLuFJbZDBshYOJMF90
	H4aj5gVjvIBO8d3sLZrbO/j4KpHb8smPmPlnDBS1uuvbTbMER3XHNuhoubA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfcabv4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:17:24 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8HMTv009040;
	Fri, 18 Jul 2025 08:17:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47ugsn1e3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:17:22 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56I8HLSL009026;
	Fri, 18 Jul 2025 08:17:21 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 56I8HLwY009017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:17:21 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id C7F1420F0D; Fri, 18 Jul 2025 16:17:19 +0800 (CST)
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
Subject: [PATCH v5 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document link_down reset
Date: Fri, 18 Jul 2025 16:17:16 +0800
Message-Id: <20250718081718.390790-3-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA2NCBTYWx0ZWRfXwIq40YDNN5zl
 1ItrSG+sTbs9UYR1genU5cmifV5FwnZ0VJv1Y73ZoitBGUFwrr/EO9c4Cq/vsz4q7paZfuYuZ3z
 0grphOj9P2YZ5Q5Xqy25adtg4Cf83LQjEoEochg4f3+bLhpR3sIGnNGmZ0/V4q571zaDUqOD8HS
 WdlkUXq/DpKCfZ995JBW4QG6puq0Knxe23F9utO8ciRI+0YtyBJjrRkub7QHflyhaiwdGAk8RfQ
 5aXjnqC8X9vMeBYl7yUajuwqhwvi3owHBt2Qt5fyztZzdlk1FJrI8a8n+dOn3mgli1nNPsc6O0S
 izusmUf95HqXUyG731gN6ZEBKc8DNehWVRV5U/V2UePn/CT7Yq2H0k9AR5aFMabUxyukrRMIHxO
 2MDMZMq0hdX099HkPtP9DRWfadWNIhjah8RmwdGw9iLGRWA5rvCh6s01V81XqmiIgDGHf6Ol
X-Proofpoint-GUID: EhVVNoOK0H0ITpnirQkqVb9GfTNLjT4p
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=687a0315 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=pGOvZgHL2iAvQvMqjSkA:9
X-Proofpoint-ORIG-GUID: EhVVNoOK0H0ITpnirQkqVb9GfTNLjT4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180064

Each PCIe controller on SA8775P includes a 'link_down' reset line in
hardware. This patch documents the reset in the device tree binding.

The 'link_down' reset is used to forcefully bring down the PCIe link
layer, which is useful in scenarios such as link recovery after errors,
power management transitions, and hotplug events. Including this reset
line improves robustness and provides finer control over PCIe controller
behavior.

As the 'link_down' reset was omitted in the initial submission, it is now
being documented. While this reset is not required for most of the block's
basic functionality, and device trees lacking it will continue to function
correctly in most cases, it is necessary to ensure maximum robustness when
shutting down or recovering the PCIe core. Therefore, its inclusion is
justified despite the minor ABI change.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml    | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
index 4b91b5608013..19afe2a03409 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
@@ -66,11 +66,14 @@ properties:
       - const: global
 
   resets:
-    maxItems: 1
+    items:
+      - description: PCIe controller reset
+      - description: PCIe link down reset
 
   reset-names:
     items:
       - const: pci
+      - const: link_down
 
 required:
   - interconnects
@@ -166,8 +169,10 @@ examples:
 
             power-domains = <&gcc PCIE_0_GDSC>;
 
-            resets = <&gcc GCC_PCIE_0_BCR>;
-            reset-names = "pci";
+            resets = <&gcc GCC_PCIE_0_BCR>,
+                     <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
+            reset-names = "pci",
+                          "link_down";
 
             perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
             wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
-- 
2.34.1


