Return-Path: <linux-pci+bounces-29902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E9ADBD14
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 00:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C1F17A1092
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 22:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56621C16D;
	Mon, 16 Jun 2025 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B0H+bQT3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D7122577E
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113791; cv=none; b=MsO7wtjQ++3YKB05mMvRFQ8sVkw9izkCS4jtSzP6BSz6/AtlzwrWs1ttqP0z8J2kdzFFk/gP93Cbpupc8fZN0nvKjIploPfpRy1KGYs+SsMWLcmKTr8plXaq/+J1zQK/lF46QYzQJUeHnK507QKkFjivDdYNLMEHfYoOOmoYaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113791; c=relaxed/simple;
	bh=wWoLmUns0WUn3BH8GN/atyRP8FM7lroOJobu/EUf+ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AaHb0qGXMvnghATBuPjXxjB2nXfmuxWlGFbEIOpKYN6dw70XyYQ22kcyaSTDNBvKT7EUMPC2/+on32a71M3XXyk8sJ9VPkk9Q5Yk9VrNo47QXdsflPkPZV8at9QJRjwpx1n7uQLumcnRdXzZ6PVISj9PxdMIajDuzGHfMStOWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B0H+bQT3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GKB75O018553
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1VuHuRqVDPP
	0zmwA1+wn2L4Tb0+7uVgChTHL2hpJ0DI=; b=B0H+bQT3VZK1hrJnTi5paqr8+59
	YiJSa67yY2uX08xDxTShRmsBtpSCX6750DPwdMlKzJrC1xUEjaaDfuFblQdcLQfF
	/ePpxwDNBJVvbdxoAFWDpZRlQ0sAuG4f9A/wQQyS6RfjuDPU1N8qJBD++Q4OBxM0
	3LgKxwRlOVU+rv9tdwu8W1gzGWgwn92T+OdK+VZKSskBDdsL+ItTqSuveEZVGxLz
	wYXEjIDIsOO9/Z1w1D3L0KtJ9YsWiblqb2rpjZHSWie573BWz0l65OPbzYgi1Zhp
	2k6nICqzJYomXNpsO4WfukgUasCqGstmUyUdh5fMm62BPyRkGKlrKj4hfJw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hfe4jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:09 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-747a9ef52a4so7419778b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 15:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750113788; x=1750718588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VuHuRqVDPP0zmwA1+wn2L4Tb0+7uVgChTHL2hpJ0DI=;
        b=Asp9X0DV4tewJLMTznizeYUKOaEmPD3if/M2JZ3pk9wQQktmDil4bHcjVXRbsdEdye
         sS2bu6MSiAY90bDVyc0uBT9vDaOxHN2k/G6nnbxHHXMLy1tbKDQTD5UWSaiooTO45DzJ
         VBo30pJL3dM4YLCuTInMw1u4lvmNmj8R1mKhJFrZUIpC2N6IM9x2oV/WkReNjLKwsjnY
         gyxatYrUGNXC8jb9shuhg+Y7tKkyOB25l+UV8S3kb84cxkwn0e0ZC257a1eUyrcYZd0u
         55VTyumdza+DAVsFkBGxbihSVY4KBJtgtZi7NP73ChO44oxNryYmI+be251aAXa0o7mx
         lOow==
X-Gm-Message-State: AOJu0Yz4TQdXhp62iLm0RHqbNP7JKo4+NmdWsqs21ZgmUbwEpdWpRs87
	m1OpzoMcJNRVQSnfEriPYLLQQpst3SggN4Q8+5iWQRB+/AYSmTzmI+auYhE3Q+l3cc4l/fHpS4R
	qtBeC7+jlvW57zqq7nAeOoaBxwRXQDD20YV+55DtUBZTrX0eWmIMPDrQWIZpSwdmDhY3Di+A=
X-Gm-Gg: ASbGncuHhUyzounyZx4UhL1NMFes56q+9NM+7MF/30oR1tyMUYmzlFAfNhSrpEm0Ipz
	S9uEdOJy8PsLeXA5BqnLfsWESDqHV/XGz9r83NOX12JihgrEXicv9hHZ2TLaKRH60siAzCB27YQ
	r95en6o87o+YOOLLjXvVsASFajNFG8Vhu8y4TtygbC8eSo8gmH9ar+9Dm2Yax9nwo2NzHlENgUv
	i5xSwChyIRLQhPNib5wAEdAc1/4VPhRJfq36fBEbnnzcoVxKsHAVTVXxV0oj0cYsNvJ1zWH7mt1
	QiWcshKFfPmqf5oKwYyB8gza3DZdP1vtkW6Ibnh9k0StGyxQXsIAUcmyOREMly160V65IrrT
X-Received: by 2002:a05:6a00:1acd:b0:746:199d:525f with SMTP id d2e1a72fcca58-7489cfdadf9mr14353944b3a.7.1750113788073;
        Mon, 16 Jun 2025 15:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWR32r953UO/4KqeK78HPSW5uSZMJedTKYClz5WLafReYJurpOR1QAZSiVqFf0ULnHWVH2Ew==
X-Received: by 2002:a05:6a00:1acd:b0:746:199d:525f with SMTP id d2e1a72fcca58-7489cfdadf9mr14353920b3a.7.1750113787642;
        Mon, 16 Jun 2025 15:43:07 -0700 (PDT)
Received: from hu-mrana-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083029sm7405077b3a.81.2025.06.16.15.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 15:43:07 -0700 (PDT)
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, will@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        andersson@kernel.org, mani@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
        quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
        quic_nitegupt@quicinc.com, Mayank Rana <mayank.rana@oss.qualcomm.com>
Subject: [PATCH v5 3/4] dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM compliant PCIe root complex
Date: Mon, 16 Jun 2025 15:42:58 -0700
Message-Id: <20250616224259.3549811-4-mayank.rana@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616224259.3549811-1-mayank.rana@oss.qualcomm.com>
References: <20250616224259.3549811-1-mayank.rana@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE2MiBTYWx0ZWRfX3VRF2jH2EOU6
 ZQaI3qBzGe2UWUFV0juJWgrEqrpakDdgDBO+X5qQWAS84+o8h83CsezCuTSR73tMOlD/wXIDWCp
 j9mteVbRY+cT1hGmn7FoNJX1S+Zq0cnLxYsHd7iwBteoF3LYyGQyiPHz2eQ423JtbzvRernm35/
 3Zi4NDsvHYAupNsod3+mAQkYpww0MsW75H+mrM5lMRpVE5QvIs5TnAtnZkF11C0GFakdv72jSw6
 d6Sefn+6S4LyLuNgUAVO05qXbpfgEpDgdeWEcCrDX6GFPXytipfBYZy6GZDpi20WPD3/6U+AwOs
 XgYf4vDbUXznUtJZ+6KSmYap60adVIRronCA9Vymw9p7CUA99Dnr2rX54mzXUyplxQ+N2wB37+6
 Ww9QrC2hDvKGZByyqzY4ZxZ5WRvqVtvUVK4Z7+ibb4HhJpyc3NyXXDTmH0RkHwt/DZvm3Db7
X-Authority-Analysis: v=2.4 cv=VvEjA/2n c=1 sm=1 tr=0 ts=68509dfd cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6IFa9wvqVegA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=MHjvnb3Eh_dVhpJH9IQA:9 a=OpyuDcXvxspvyRM73sMx:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZtzbdajYD_rR84zNs1kgfWosoCh7YwCe
X-Proofpoint-ORIG-GUID: ZtzbdajYD_rR84zNs1kgfWosoCh7YwCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_11,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160162

Document the required configuration to enable the PCIe root complex on
SA8255p, which is managed by firmware using power-domain based handling
and configured as ECAM compliant.

Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/qcom,pcie-sa8255p.yaml       | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
new file mode 100644
index 000000000000..88c8f012708c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
@@ -0,0 +1,122 @@
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
+  - interrupts
+  - interrupt-names
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
+
+           #interrupt-cells = <1>;
+           interrupt-map-mask = <0 0 0 0x7>;
+           interrupt-map = <0 0 0 1 &intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                           <0 0 0 2 &intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+                           <0 0 0 3 &intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+                           <0 0 0 4 &intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+
+           pcie@0 {
+                   device_type = "pci";
+                   reg = <0x0 0x0 0x0 0x0 0x0>;
+                   bus-range = <0x01 0xff>;
+
+                   #address-cells = <3>;
+                   #size-cells = <2>;
+                   ranges;
+            };
+        };
+    };
-- 
2.25.1


