Return-Path: <linux-pci+bounces-12496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FEE9659B7
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 10:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06EA281F06
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0112416DED2;
	Fri, 30 Aug 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k3YHv/YN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621DE16DC11;
	Fri, 30 Aug 2024 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005555; cv=none; b=j3wF4GxrT6mfJKAHz4/PDE3rsXbtPX/9l5oKUBaji8Q0wzwGq8iFMKmVh2W7KVph65K8/WJFwvwSdRYXMTxOJp3qhhWUISqI7g+WCjAvQviJ5kMWpVgkQQaDg6UAMm12fYUqqeR6F1Wx9wUUK0avOrTnPDuR6gtJNBaABp6tQT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005555; c=relaxed/simple;
	bh=6bwu2w9d0aV+2H1I4AQmCsG9leruzKaw4P/s4ZtF3pw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BN6VagzDnTUec2G4uSU5Lr5fMlLahGH5/WG6WH4KgCBf9gLR2rL65YkrpGD0sDQpaRTwxfMk5Q/FeiOAL0MGCSFfvmNJ8yolVtcK6fYxqdFObJzlaXrMu+Vj2GShXgtaXKFOg+NNANVfuvqHG+vprEK4o025CRu5P0H1k0M0lGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k3YHv/YN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U7S5Iu025031;
	Fri, 30 Aug 2024 08:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5R0aMu5OW6q4KM6k4W3HEAXlvZsWfOQ5vkAr+jKoYfY=; b=k3YHv/YNxwmUQ57m
	PJydysxIpBU3+drhwBkCxjoeRVRMFvu1s8x1Zdz6ZoNJG8GWoUrbvUjrv9N/wms0
	sXZ2hZnSAaAR1vez0GVaforfSKjqj0mf5xcG8unFuhVPaAImS867RzBE6kUZoMqh
	hi/kvqk9S49BgLSLta39ClLK4TfEnJmHdvCjUs2MJluMstl/6OgMRvTPG4dvUYZz
	WKCGIM5AGvT8/VXjgScDDGzkv9uW4rbdh262IILhJXfdleSqM/30xa2kOZMeJhgN
	EmbsFDWBnqLy8KXKuWahSp8S+uTVirWNiCPQ9RyhMCowVZgvp73rRYND6oDuDP+D
	Movolw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puvfw6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 08:12:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U8BwDc008563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 08:11:58 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 30 Aug 2024 01:11:52 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <robimarko@gmail.com>, <quic_srichara@quicinc.com>
Subject: [PATCH V3 1/6] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
Date: Fri, 30 Aug 2024 13:41:27 +0530
Message-ID: <20240830081132.4016860-2-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830081132.4016860-1-quic_srichara@quicinc.com>
References: <20240830081132.4016860-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lppIvEmaSu3JmzdDdespBRnksaOSLamT
X-Proofpoint-GUID: lppIvEmaSu3JmzdDdespBRnksaOSLamT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300060

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5018.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v3] Added reviewed-by tags

 .../phy/qcom,ipq5018-uniphy-pcie.yaml         | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml
new file mode 100644
index 000000000000..c04dd179eb8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,ipq5018-uniphy-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm UNIPHY PCIe 28LP PHY controller for genx1, genx2
+
+maintainers:
+  - Nitheesh Sekar <quic_nsekar@quicinc.com>
+  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq5018-uniphy-pcie-gen2x1
+      - qcom,ipq5018-uniphy-pcie-gen2x2
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pipe
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: phy
+      - const: common
+
+  "#phy-cells":
+    const: 0
+
+  "#clock-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - "#phy-cells"
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
+    #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
+
+    phy@86000 {
+        compatible = "qcom,ipq5018-uniphy-pcie-gen2x2";
+        reg = <0x86000 0x1000>;
+        clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+        clock-names = "pipe";
+        resets = <&gcc GCC_PCIE0_PHY_BCR>,
+                 <&gcc GCC_PCIE0PHY_PHY_BCR>;
+        reset-names = "phy", "common";
+        #phy-cells = <0>;
+        #clock-cells = <0>;
+    };
-- 
2.34.1


