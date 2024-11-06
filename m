Return-Path: <linux-pci+bounces-16174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D99BF904
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B921C21E31
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 22:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854B20E316;
	Wed,  6 Nov 2024 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h2DjztTd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EDA20E024;
	Wed,  6 Nov 2024 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931260; cv=none; b=NIDGLL43CdhpGQlO8pxPLT4Vmzm7YgMAO1Kpwql72dcPmgkL1UFNaJYEnCUSDiMzGY3+3wqkr5Rf9WwdyaS13ukA6Xw5k5gGa4PUjpU73PZ2CiGm79obvdSaKiQdg5sp4/a/rz/43RxwXKS+IZ1zPMOybbICx8QaeFJH+3nYopw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931260; c=relaxed/simple;
	bh=U1E/PezRK3mMBWpMpVz/1ucpQWl6Z7F3QZxkC8Xgi5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGGdxiBJm8uymyfpW1bEbrF6m+ueOqKcFuqQ9ty1Ky+UG8qjb+2OlxeIgPz6D8Dp8Q97idcKPFvp2tOaannjh0WCG3ghza0XD02UFgikJLCt1iny/ZXuzj5NVH41FOBWdqBLyarWX1DeMe53NSk+7WEmbDmO6a5IQHw7ad5nXcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h2DjztTd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6AekBn002679;
	Wed, 6 Nov 2024 22:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MkSO+TBW1zgiT3/tc5z3LLX3s+rIQIg7Fh/Fgi6sldE=; b=h2DjztTdFcjJn3fB
	wXxLjgBn3/DiqinPwrt4IcEYaHZ+8FbffJ34IhsqAHLXoX2iuugos5raUP1VzFSO
	fITBQLP6lS890aBvWXfnP7zetzrv7wCE9x2Qgy/TBsaEFXPvLLb2wdnSUV3yOBIm
	dNHJcXf2XtzF78ekJDhvyJa4STRLjeYu5sVE/OJYOPFlfJu+WRUuzXapJgJ36GqR
	lFeaRK/LO6BX2VH89gijSpxLegTccD4SuepPO3gQIvfK/twWUtm0EzedRy/x7n2k
	DCFn84RsV6O18Vstoun37jC366/6QMguyPzuujt+s3W1ObXiB3Xd5JsmP0qJ22PO
	yxDXYw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qvhd39pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 22:14:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6ME5iZ011723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 22:14:05 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 6 Nov 2024 14:14:05 -0800
From: Mayank Rana <quic_mrana@quicinc.com>
To: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_krichai@quicinc.com>,
        Mayank Rana
	<quic_mrana@quicinc.com>
Subject: [PATCH v3 3/4] dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM compliant PCIe root complex
Date: Wed, 6 Nov 2024 14:13:40 -0800
Message-ID: <20241106221341.2218416-4-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106221341.2218416-1-quic_mrana@quicinc.com>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fTOlyan0p4NGzWp9R_Mp7f47Z_4IWwA7
X-Proofpoint-GUID: fTOlyan0p4NGzWp9R_Mp7f47Z_4IWwA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411060170

On SA8255p, PCIe root complex is managed by firmware using power-domain
based handling. This root complex is configured as ECAM compliant.
Document required configuration to enable PCIe root complex.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 .../bindings/pci/qcom,pcie-sa8255p.yaml       | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
new file mode 100644
index 000000000000..9b09c3923ba0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sa8255p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SA8255p based firmware managed and ECAM compliant PCIe Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SA8255p SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP which is managed by firmware, and configured in ECAM mode.
+
+properties:
+  compatible:
+    const: qcom,pcie-sa8255p
+
+  reg:
+    description:
+      The Configuration Space base address and size, as accessed from the parent
+      bus. The base address corresponds to the first bus in the "bus-range"
+      property. If no "bus-range" is specified, this will be bus 0 (the
+      default).
+    maxItems: 1
+
+  ranges:
+    description:
+      As described in IEEE Std 1275-1994, but must provide at least a
+      definition of non-prefetchable memory. One or both of prefetchable Memory
+      may also be provided.
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    minItems: 8
+    maxItems: 8
+
+  interrupt-names:
+    items:
+      - const: msi0
+      - const: msi1
+      - const: msi2
+      - const: msi3
+      - const: msi4
+      - const: msi5
+      - const: msi6
+      - const: msi7
+
+  power-domains:
+    maxItems: 1
+
+  dma-coherent: true
+  iommu-map: true
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - power-domains
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pci@1c00000 {
+           compatible = "qcom,pcie-sa8255p";
+           reg = <0x4 0x00000000 0 0x10000000>;
+           device_type = "pci";
+           #address-cells = <3>;
+           #size-cells = <2>;
+           ranges = <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>,
+                    <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 0x40000000>;
+           bus-range = <0x00 0xff>;
+           dma-coherent;
+           linux,pci-domain = <0>;
+           power-domains = <&scmi5_pd 0>;
+           iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
+                       <0x100 &pcie_smmu 0x0001 0x1>;
+           interrupt-parent = <&intc>;
+           interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+           interrupt-names = "msi0", "msi1", "msi2", "msi3",
+                                  "msi4", "msi5", "msi6", "msi7";
+        };
+    };
-- 
2.25.1


