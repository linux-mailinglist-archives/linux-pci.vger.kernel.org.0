Return-Path: <linux-pci+bounces-17633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EB19E38E7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0C2284DD5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2E1B414E;
	Wed,  4 Dec 2024 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ViRJLWhq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE431B3949;
	Wed,  4 Dec 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312065; cv=none; b=jXPmeKvZNZfG+7+Etrirk/BpcgvdHPxzCOxn7YgQfBmoYYiVEWF25Djk/u/yMvQna+g3zWDdhlRg3sjXg+GGo0MDA4CuVixFbCPAfgZHntluEsWx6QVC+xV9Lxk4tx8i0BWcXHpHtgaRaJUn51Y9q8+H99nDj1/RiivU1WC+YEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312065; c=relaxed/simple;
	bh=88R3oZpZD2GGre1fQgu5Hm7bLT5jQHV+juSUuD/h95M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9TOE5+JSfXCCGCW0oVtq6CfXT7CydflKZpUtm44Mdgw44IJu7vMqVJNVaVFDaBSHXkMB+WEiojxVX9IHbZ1NjaOJjsXqf84LUnJlt9QAdxE3/MFkXCV1yKglV+N+Eg4h7+PSZ/2pKZt9lTTfVLrOuWhLya+2/m9pm65/xlJ3pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ViRJLWhq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B46VUdf027853;
	Wed, 4 Dec 2024 11:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N8CUwHXxrU17uvgVXAnoIjuNWJ3qOKuQzRThwkLdcs8=; b=ViRJLWhqzsJLxGVE
	QuUCyq/YaX+b+p59UB7wf+ZljaJmKqig6VIvOgJ5duGM7wxhCJI+uBBsSRT4AsgH
	1xkAMM/PzFniVtM+TsGZr40GIcDxighzq2GQyes7Xi4Uae4wFmJxOQ8lGAwYlAL8
	Pt5kY6fEytOY8g3KqFrb6NjtIJ9KH/Khjwbp9mzSTP3g4TmPAtwkCYRngPcKrVp8
	1CINJiA/L5Fch4Bmw5aIaO+9NOv0giulWXTcY2o7VSYFM6Tv5V1PJIsdgQy4gCAZ
	KPpjGLbe3JDK+XYCeBaq6dtkmK10UU87qGKja71oMu2hKXvSFPpDinGdVqmHy8NT
	lQSb1A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439vcem6p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:34:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4BYAQs013129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 11:34:10 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 03:34:04 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <p.zabel@pengutronix.de>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v2 1/6] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
Date: Wed, 4 Dec 2024 17:03:24 +0530
Message-ID: <20241204113329.3195627-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204113329.3195627-1-quic_varada@quicinc.com>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7BVsC1c6Q3mq0Rd6uvdh0O7ul90mENF4
X-Proofpoint-ORIG-GUID: 7BVsC1c6Q3mq0Rd6uvdh0O7ul90mENF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040090

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5332.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Rename the file to match the compatible
    Drop 'driver' from title
    Dropped 'clock-names'
    Fixed 'reset-names'
--
 .../bindings/phy/qcom,uniphy-pcie.yaml        | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml
new file mode 100644
index 000000000000..e0ad98a9f324
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,uniphy-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm UNIPHY PCIe 28LP PHY
+
+maintainers:
+  - Nitheesh Sekar <quic_nsekar@quicinc.com>
+  - Varadarajan Narayanan <quic_varada@quicinc.com>
+
+description:
+  PCIe and USB combo PHY found in Qualcomm IPQ5332 SoC
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq5332-uniphy-pcie-gen3x1
+      - qcom,ipq5332-uniphy-pcie-gen3x2
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+
+  resets:
+    minItems: 2
+    maxItems: 3
+
+  reset-names:
+    minItems: 2
+    items:
+      - const: phy
+      - const: phy_ahb
+      - const: phy_cfg
+
+  "#phy-cells":
+    const: 0
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - resets
+  - reset-names
+  - clocks
+  - "#phy-cells"
+  - "#clock-cells"
+  - clock-output-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
+
+    pcie0_phy: phy@4b0000 {
+        compatible = "qcom,ipq5332-uniphy-pcie-gen3x1";
+        reg = <0x004b0000 0x800>;
+
+        clocks = <&gcc GCC_PCIE3X1_0_PIPE_CLK>,
+                 <&gcc GCC_PCIE3X1_PHY_AHB_CLK>;
+
+        resets = <&gcc GCC_PCIE3X1_0_PHY_BCR>,
+                 <&gcc GCC_PCIE3X1_PHY_AHB_CLK_ARES>,
+                 <&gcc GCC_PCIE3X1_0_PHY_PHY_BCR>;
+        reset-names = "phy",
+                      "phy_ahb",
+                      "phy_cfg";
+
+        #clock-cells = <0>;
+        clock-output-names = "pcie0_pipe_clk_src";
+
+        #phy-cells = <0>;
+    };
-- 
2.34.1


