Return-Path: <linux-pci+bounces-18595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9B79F4868
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 11:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83557188A96A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0851E1E2607;
	Tue, 17 Dec 2024 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NYNl1ChF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664661E22FB;
	Tue, 17 Dec 2024 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429903; cv=none; b=p7qlJD55PWgU48fcs/1gcPA3RaBaZxftEJgawQF3umyjjTk7DxkSuSu0VEiAUS8Si3ZDs4Xh+CEq8cFeQ+jdvdmZKnvuykGvkDVQghszEhpZaAYAxIRQpu+j38K4OSJHmGsg+yF2eX+yD331BRBDv6LJA/KV6ds/2pmZjQQDoVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429903; c=relaxed/simple;
	bh=Ls2Y6VzP3p5uRT89jZlh29MGSvr2YpDzbgEDOD7vsng=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmIp5sh+NQxVwxGk2BXXlWCYrX7yVd2PX4BuI4HNxLfojOyhCdtJnDrHHxglZam/9IoLc0khZc/lTvj3Z4WxATmHRUDsnTu3McSmq41Hw1e6HHoTKPJaFEzlVjRFqvbapYV0hAgVHxSK0fb/AINnrirrMPwlppgxOnwNYkEh4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NYNl1ChF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH61uxV005074;
	Tue, 17 Dec 2024 10:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ENbAtq/KnMHcZQudQ2PbURoZ3VPyaWG3D2DIp16ItNs=; b=NYNl1ChFlHqAY6QD
	lUeggjPdXAIqjC3tr8g2hvtK1wYG8/0tjUlAEvaw6SV8Mj++bQ7LjEnDQusZVWuF
	ePY8wEmH12NpEzLJtKJeJNlooYAlxhaoRi/SvLrVcdsvUPWoj1ewiEnjpqXcUS8D
	Tu1hszmhBKBGTBYGV615U1pVaLr50XvfHjxBavp5hcvNh0ctoPlPnEphriMDJ5Ep
	a976F5V1OAnlviTEpuHDgBU3gc4d+wyk/pi8TPle6Vb+wFdRLVAYb2Kpf0sejdnB
	rxtkdhg7YCWoZOwZl405HddNdrjnHq1FgB+q225XLC0kDzYu/cdM0FbuKIMWNqof
	jYNF5A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43k3p48n3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 10:04:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BHA4Nkb006242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 10:04:23 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 02:04:17 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_varada@quicinc.com>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_srichara@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v3 1/5] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
Date: Tue, 17 Dec 2024 15:33:55 +0530
Message-ID: <20241217100359.4017214-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217100359.4017214-1-quic_varada@quicinc.com>
References: <20241217100359.4017214-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: PgEqpTtoWWYw-lXVdigCAv4MAKjGErPc
X-Proofpoint-GUID: PgEqpTtoWWYw-lXVdigCAv4MAKjGErPc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170082

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5332.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3: Fix compatible string to be similar to other phys and rename file accordingly
    Fix clocks minItems -> maxItems
    Change one of the maintainer from Sricharan to Varadarajan

v2: Rename the file to match the compatible
    Drop 'driver' from title
    Dropped 'clock-names'
    Fixed 'reset-names'
--
 .../phy/qcom,ipq5332-uniphy-pcie-phy.yaml     | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
new file mode 100644
index 000000000000..0634d4fb85d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,ipq5332-uniphy-pcie-phy.yaml#
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
+      - qcom,ipq5332-uniphy-gen3x1-pcie-phy
+      - qcom,ipq5332-uniphy-gen3x2-pcie-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
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
+        compatible = "qcom,ipq5332-uniphy-gen3x1-pcie-phy";
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


