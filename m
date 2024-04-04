Return-Path: <linux-pci+bounces-5741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A00898EB1
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 21:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729D11C26864
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C019132C15;
	Thu,  4 Apr 2024 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kmCHxiMa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8716782C63;
	Thu,  4 Apr 2024 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257907; cv=none; b=GZ3GiMwZ7n6B9+8wW8+qIl+ADuwa+EbSd50+InxdnPf/ue9PsDPy238v4l7h53rsOsb9vYZU1o0zN8AhHgQFPjIqKUiOe6zflHTQ02PIPdTcHs7j+juSOtydPvLKwqsnhQDQdUO7cp+v+gNeC5cpiLdacIY7ocnyoyF1pK2f73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257907; c=relaxed/simple;
	bh=nRUZgPhT7CdZ/m2K1wIQLsnm9eHosA+3lbgisaXXXVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnTNjfsyKMZMayswrJ66rg4NpUwpIRXRDe/nEcLQky2myzvz5MrfaCh+/JIMro8c4PcasO7ehT4Megb8MgSqtauY2IhrDMR8nvrZpq8yvPqxmMyomww9Cu2xbDlf3NKEoL2pzU8945jbUEc9oL4fPJaqZaGWwmPSoBmjlpwDZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kmCHxiMa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434JBN5P031814;
	Thu, 4 Apr 2024 19:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=MT68nDIQrfnWyBp6tx4J
	bQpmkugAQJhRdTyfmPgh/zc=; b=kmCHxiMazQMWo1c8aVr7HjjdySeMRSzRXSPk
	K7jj/T3/xgoiQb/3MGbO6KaRgRvfBlNo35rxnTQn5PwL5OVjT+Q4K9wnb1PErUig
	IbboyKcyid6fG9IqlXyYM9bnDPmN2EDNRbqKuC5f00BEPbAOLByj4hT/Pso1Zy/t
	g2Pu0lTrjWNvVafd+3bYgJ4hv1YUmTuqqtepT018NNkdNwuBnCqZyMdUE9Rfliu5
	BN/uP44uV4nDmypXmgUNRTB5LiU6jKv+cEJu41x1FsSRZR4Y1giLnaEvNSEp8fWY
	VZY6JBnUwf12DwY5GZL7m9M7jvWNgSYOPADvN6XR6ka3/d7LMw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa1xa80w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 19:11:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 434JBcUx026106
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 19:11:38 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 12:11:38 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <andersson@kernel.org>,
        <manivannan.sadhasivam@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_ramkri@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_shazhuss@quicinc.com>,
        <quic_msarkar@quicinc.com>, <quic_nitegupt@quicinc.com>,
        Mayank Rana
	<quic_mrana@quicinc.com>
Subject: [RFC PATCH 1/2] dt-bindings: pcie: Document QCOM PCIE ECAM compatible root complex
Date: Thu, 4 Apr 2024 12:11:23 -0700
Message-ID: <1712257884-23841-2-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
References: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nveXiKlpd99JpcAz8ILs6Hpg0n9Z5rxq
X-Proofpoint-ORIG-GUID: nveXiKlpd99JpcAz8ILs6Hpg0n9Z5rxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_15,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404040136

On some of Qualcomm platform, firmware configures PCIe controller in RC
mode with static iATU window mappings of configuration space for entire
supported bus range in ECAM compatible mode. Firmware also manages PCIe
PHY as well required system resources. Here document properties and
required configuration to power up QCOM PCIe ECAM compatible root complex
and PHY for PCIe functionality.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,pcie-ecam.yaml    | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml
new file mode 100644
index 00000000..c209f12
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-ecam.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm ECAM compliant PCI express root complex
+
+description: |
+  Qualcomm SOC based ECAM compatible PCIe root complex supporting MSI controller.
+  Firmware configures PCIe controller in RC mode with static iATU window mappings
+  of configuration space for entire supported bus range in ECAM compatible mode.
+
+maintainers:
+  - Mayank Rana <quic_mrana@quicinc.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/power-domain/power-domain-consumer.yaml
+
+properties:
+  compatible:
+    const: qcom,pcie-ecam-rc
+
+  reg:
+    minItems: 1
+    description: ECAM address space starting from root port till supported bus range
+
+  interrupts:
+    minItems: 1
+    maxItems: 8
+
+  ranges:
+    minItems: 2
+    maxItems: 3
+
+  iommu-map:
+    minItems: 1
+    maxItems: 16
+
+  power-domains:
+    maxItems: 1
+    description: A phandle to node which is able support way to communicate with firmware
+        for enabling PCIe controller and PHY as well managing all system resources needed to
+        make both controller and PHY operational for PCIe functionality.
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ranges
+  - power-domains
+  - device_type
+  - linux,pci-domain
+  - bus-range
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie0: pci@1c00000 {
+            compatible = "qcom,pcie-ecam-rc";
+            reg = <0x4 0x00000000 0 0x10000000>;
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges = <0x01000000 0x0 0x40000000 0x0 0x40000000 0x0 0x100000>,
+                <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>,
+                <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 0x100000>;
+            bus-range = <0x00 0xff>;
+            dma-coherent;
+            linux,pci-domain = <0>;
+            power-domains = <&scmi5_pd 0>;
+            power-domain-names = "power";
+            iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
+                  <0x100 &pcie_smmu 0x0001 0x1>;
+            interrupt-parent = <&intc>;
+            interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+                <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+                <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+                <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+                <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+                <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+                <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
+                <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.7.4


