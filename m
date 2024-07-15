Return-Path: <linux-pci+bounces-10294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5777F931A14
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE5ACB22CDD
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C7F77F15;
	Mon, 15 Jul 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KjHZvGGD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A447173C;
	Mon, 15 Jul 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067287; cv=none; b=q8NnOaTbMpfXYZzGFpJu7Zd1w+RePm0W4DEFSCcQxOu1YjlqefVFpLYNzHOBqqiq/HtU5GtbgjOZRrkEQYJL+Tippf2qcotGrb1CgITfEI1YFr8Bcf4yyoSFI7gsvrB7JdGJzrTsO5BvhJzhiRlB1Up69/qOLdMZJM1JCiuYq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067287; c=relaxed/simple;
	bh=TgQWTBOU9Yc9+BVEnI59quvOHALQzRUmRj+EwKqFtEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEiMKjBHmGR0ZPbTTKv278n6z46JH4teqPMvOHTJMpYUB+Jvotu/5jMr7HT3v4RzSwpTOeZLgJgP6MvNICK0hR9fuZmIh8YSq5vBrGruIEgesjXSX/q8iS0j5R0nwHZhmJiN6x78tsyAuGDe+XGyDn1ApCwCcL7NJzduwWkBSrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KjHZvGGD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH8hPj029998;
	Mon, 15 Jul 2024 18:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BsqkTxTegj2hlVRLZ9DlL6Cl
	I6gvd2pgo9wFqQqHL+A=; b=KjHZvGGDj4A9LDX0pzCGxxMDUxM98Yz36S8vJLqv
	3asQWhiO59ExJ43nW9qIwNn60tqhK8Rh5BXG3nkpsNvPD3dkZmybpVTRRfirEXUX
	3o4IJNfLM50H5OC1+2UTGM7DJH8CaP+z/iBHhfvpyxMuVuulHAXhEa1cRIg6HPje
	moeMDz7VOqNl72tVfjrqTJLMiPHksMOrBxIaCCFWxpQK0B5c9r1lQ3PwSryLKjuh
	aGBgmF69cNyIyVkG/77wz/7s/OQPGzeWjMunRYR9wF0RKV6pvgrF4j3cayuTooT1
	meT0b1Ptuj6sz7YcWj+S5XexsCUQw0CIuDFKJct42wVddw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bf9ed68h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FIDr2E026349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:53 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Jul 2024 11:13:53 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <cassel@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <s-vadapalli@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>, Mayank Rana <quic_mrana@quicinc.com>
Subject: [PATCH V226/7] dt-bindings: PCI: host-generic-pci: Add snps,dw-pcie-ecam-msi binding
Date: Mon, 15 Jul 2024 11:13:34 -0700
Message-ID: <1721067215-5832-7-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T4gnOBKDQXQBRBiziBzzidh6lptryqV2
X-Proofpoint-GUID: T4gnOBKDQXQBRBiziBzzidh6lptryqV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=972 mlxscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407150142

To support MSI functionality using Synopsys DesignWare PCIe controller
based MSI controller with ECAM driver, add "snps,dw-pcie-ecam-msi
compatible binding which uses provided SPIs to support MSI functionality.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 .../devicetree/bindings/pci/host-generic-pci.yaml  | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index 9c714fa..9e860d5 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -81,6 +81,12 @@ properties:
               - marvell,armada8k-pcie-ecam
               - socionext,synquacer-pcie-ecam
           - const: snps,dw-pcie-ecam
+      - description: |
+         Firmware is configuring Synopsys DesignWare PCIe controller in RC mode with
+         ECAM compatible fashion. To use MSI controller of Synopsys DesignWare PCIe
+         controller for MSI functionality, this compatible is used.
+        items:
+          - const: snps,dw-pcie-ecam-msi
       - description:
           CAM or ECAM compliant PCI host controllers without any quirks
         enum:
@@ -116,6 +122,20 @@ properties:
       A phandle to the node that controls power or/and system resource or interface to firmware
       to enable ECAM compliant PCIe root complex.
 
+  interrupts:
+    description:
+      DWC PCIe Root Port/Complex specific MSI interrupt/IRQs.
+    minItems: 1
+    maxItems: 8
+
+  interrupt-names:
+    description:
+      MSI interrupt names
+    minItems: 1
+    maxItems: 8
+    items:
+        pattern: '^msi[0-9]+$'
+
 required:
   - compatible
   - reg
@@ -146,11 +166,22 @@ allOf:
         reg:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: snps,dw-pcie-ecam-msi
+    then:
+      required:
+        - interrupts
+        - interrupt-names
+
 unevaluatedProperties: false
 
 examples:
   - |
 
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     bus {
         #address-cells = <2>;
         #size-cells = <2>;
@@ -180,5 +211,31 @@ examples:
             interrupt-map-mask = <0xf800 0x0 0x0  0x7>;
             power-domains = <&scmi5_pd 0>;
         };
+
+        pcie0: pci@1c00000 {
+            compatible = "snps,dw-pcie-ecam-msi";
+            reg = <0x4 0x00000000 0 0x10000000>;
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges = <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>,
+                  <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 0x40000000>;
+            bus-range = <0x00 0xff>;
+            dma-coherent;
+            linux,pci-domain = <0>;
+            power-domains = <&scmi5_pd 0>;
+            iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
+                <0x100 &pcie_smmu 0x0001 0x1>;
+
+            interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+                    <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+                    <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+                    <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+                    <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+                    <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+                    <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
+                    <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi0", "msi1", "msi2", "msi3", "msi4", "msi5", "msi6", "msi7";
+      };
     };
 ...
-- 
2.7.4


