Return-Path: <linux-pci+bounces-23704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A056FA60894
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 06:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA813B2092
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 05:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882D61519B5;
	Fri, 14 Mar 2025 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ob/zbP2C"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2060.outbound.protection.outlook.com [40.92.42.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEF51411DE;
	Fri, 14 Mar 2025 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931833; cv=fail; b=T7NdJqu5a7YPbIPB1OFiEqyG3vZIIqr9hVUQNs7HOTMTNcu1W1m3jI0ph2RBZJV1Bb+fOsShUxdkX5W9KbT27piEdCAL2jR8GOAGqGKiv2x4FBU8jCqBZuC7k0HzB7enETbBhGh83W8y3tq9PkP9zMtkPQF/dlQh9gFurzyoo4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931833; c=relaxed/simple;
	bh=GcuIdE1Q6MdfQMJ7tRiZMyGHB/gT7Y9AwftcT8y1+bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ai8Ow1CQ8e+u9YLBjuDVa9xywFK5/W+xCRj4sanIJ+TjgANK+JYYRzaRysIBc5hkQRZEhi+xGcN5ZI4TuG9IevnL2o89ve2q4hzjIH2o1F12hg25h8L5TOvfyYrGp/1tR+Snx4vF+D3UYdB1qVkC+5DwIRZanLnBj7WF5H7OVzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ob/zbP2C; arc=fail smtp.client-ip=40.92.42.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EunJHnhyniNngr7HPS9T0kuuVbIR7aNncmW3UWW0OH9kk/nHO6vk1xRk0hyvSSYdQrjn3MHiDMMyXWUT1WSCZfwcLpqYuKQbHPjd/D+Fgr8cZwwSU8+XjrVg5XsRAw/acn3ZieMOsJl5mQStOMgOorEktPqbRkbEDP05I+rhcQVuIaXOnGgymZQroKvcEDf9bMMLVXRZaToUP+DyhUnScowQPYYGQwK1+6MXvcFH9FURVM6QdaaatMhGGBhZBt2VDsdQs4Bu3qcKGqLy1prwlXkbJou5ljjbvTQjQodsTvwu0Deo7cisCaEyMIku9yO/MR6PAAdlCpJ3IAP5Ugyaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q9QHU3Yf1rWjFON0rZ5Q36nGPUdQ9v7HXgosXo5x84=;
 b=viyOhJFv+gLtkDImw032Yg2uozjU114pxGGCaZNuRz6MIV55EEAme+LC/GDXq9+mSewz6mzSyZaqCLQ5iQWdrINzwdogU0zm6Gym31qX0xRQ43HhDfIt1JoPCMkLY417rpWeFXWx6qgdSb/XhGN7Kg1uuG0/igFO+7YdCx1Idgg8Dv0Yho4ZjZETS5W4GDgCzLopJzQfx4DlEcAdAjKL05U6qde261FMYqJIYACijrG0YKCfyyivnWOlp5gh0ImsYLZEupAIzEtCL9RLLq5A9n8Iwrb9e2VGPXDfJuzISLeSg8AIl4fTrSnbyem09qr98pcgcdZ5l60vSqMHpzyQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q9QHU3Yf1rWjFON0rZ5Q36nGPUdQ9v7HXgosXo5x84=;
 b=Ob/zbP2CHrOaD28l8kPcIZiOPk1PCBADJGOAuD1WC/Q9S0PgtjX38IAERAP1VkemMG/hzCQoEQX5sJb2VvGm2KUy684+O2LfvRqrY85Id4ZzWobQg9hJfgeXUv3KNkiqtD1lF9DvMGGS54yFURZN/uopU/dgUUx47Zvn16aDRRwrOKRpqrd9yZk4bx85mRIqG2XjlAZ8+fP/qO2f0/FjBkoy1gC0E9niKyY/z/ygyAqzUPm77mY6wCkRlXhNVSTsqbHVab2DFZxsdXUfh369QsUCMXfFrhxzGhPrGbbjRxV+mdIGR7sIH8fUBkIyDHMCGulAamQQy/MHtpXlVZcm0A==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SA3PR19MB7795.namprd19.prod.outlook.com (2603:10b6:806:300::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 05:57:09 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 05:57:09 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	andersson@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	lumag@kernel.org,
	kishon@kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	p.zabel@pengutronix.de,
	quic_nsekar@quicinc.com,
	robh@kernel.org,
	robimarko@gmail.com,
	vkoul@kernel.org,
	george.moussalem@outlook.com
Cc: quic_srichara@quicinc.com
Subject: [PATCH v4 3/6] dt-bindings: PCI: qcom: Add IPQ5018 SoC
Date: Fri, 14 Mar 2025 09:56:41 +0400
Message-ID:
 <DS7PR19MB88834CAC414A0C2B4D71D57C9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314055644.32705-1-george.moussalem@outlook.com>
References: <DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
 <20250314055644.32705-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250314055644.32705-3-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SA3PR19MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeedb7f-a82d-4ecd-d677-08dd62bd0e73
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|8060799006|19110799003|461199028|7092599003|41001999003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jukMh8B2Yk5YCVJCIKF2aa67Z7kDNZcERMg9JxLN6GISKvrGhvGuSnuA5rYm?=
 =?us-ascii?Q?zuko19t5s49BspuS6qw8VqAhJewMNRIH2Xp0Ws17ov46fTzwoopma4/ZYqOo?=
 =?us-ascii?Q?F1s68pgNn171Scp5bTonGExFDW8BlstTgCtxAbs5AWkfan4rkb26zo3GJmw8?=
 =?us-ascii?Q?sxs2inU2JygOvHf5S6vlcLb9I70G+UGGYeSL1BodP6fgm2Cq1Q8ReYzgoqjg?=
 =?us-ascii?Q?R8HDBBTnPFqI1+LXEYU6LbaU83lczND7DiA+NP7nAUcIQSOSQL5sX1o89YW8?=
 =?us-ascii?Q?IFQKLJtRMv41qrr/rYTRSfWwXUy5UIFCOYkRemNKXDKFResLV1QCP2ODXk1i?=
 =?us-ascii?Q?Q0UrkxCxuX/KVOO31AUcGvkAewFD/+nWxbEp8wmlQLpIPaEFWhRXG/GsMQpt?=
 =?us-ascii?Q?6qD1LQTFzQ66ClKxXRqs1OXX16S9CoZ8XRj8FCo4kwOXxeyWJlUfr1i5s+k3?=
 =?us-ascii?Q?R/31amL+NQpaPHG3fBuwKCyRk/yaWUKih9gu5Ntx+i9yPMAEPrAkY3cifRan?=
 =?us-ascii?Q?+7TAv0b6Q3GSinc/1b6Mn0Sgk/Pdt6tJRF+vtNrKvwryEly3nKS2Ayv8Fgss?=
 =?us-ascii?Q?rAf4gLVfVDcmFqnjKQNoMB/5jP8lUttjg/baSHU9DN3YDunwiJIrKFpDVIr5?=
 =?us-ascii?Q?NbY9bS0vrn9wyV6PQhD3IsOSzUhEP5osKzC9MzVZjGJGBuTQjLKOPhKYGtGI?=
 =?us-ascii?Q?B0BCMOOG9BF15NwjgJ5qUVfPvxnwH7QrJoVrDqAxn3P5D5ODiTE8W9tBq+5k?=
 =?us-ascii?Q?KORNBGa/17WqOHe4/crD5tUUuz8RVvRTlNsLn6Dk7O9AjylS8Yip3sHKBtU4?=
 =?us-ascii?Q?NaPCttA6w++jdyu4kFhKfOjF1gAaMRfO2BTDHPuJfJOyXSuMKn/rQXCI8PtW?=
 =?us-ascii?Q?4i1SoJ59e0Z9dKR1Hgm2/Z1Q+UcrlDRlwAN6R4PkQ/px8cYZ3jWoT2RhW3l2?=
 =?us-ascii?Q?uJ64k4tpznc+EutxL5jFNWDcv03fhMqEdBxILFUOGxwQ321y3rzLz7+st9oT?=
 =?us-ascii?Q?xrphpcaoic2qvL82gqpowwoKrSwPPk3jOPs1gef4ONuEA/jiMrgGXg3f57wX?=
 =?us-ascii?Q?2ndwQUcrqTlrx5CrCHPGQzH2mmGA6G04EoKE3d/HwKVInfrSqD8/x9XUKXAR?=
 =?us-ascii?Q?qilZg1FMEn54VXVnYfjFlIPUQXy9t+jPOA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CuFQ31tD9OuZfPVGArRDH1IrwqB2wq3ueTRuYyoI67rkv8OWPu1vqcx8sYSL?=
 =?us-ascii?Q?WnmbD60UIs2ntbuiFIgi20Y4U7G3LRSwFC+dbP6tYlX5t5VUpIhSDY+5Pj0J?=
 =?us-ascii?Q?zvmpRukY0q8323cSXYhSS8NM1WWqKc6nCgCFVSuDuO9tlsu+EIaUHTyNxXjJ?=
 =?us-ascii?Q?J2T9PXm2p/BLxOM8f5os2KeIGl12O0GnyW/AS/nxqk3OtRUk/vhGdXUFUz5g?=
 =?us-ascii?Q?rHsD1IQpE9EftyyKKEnU2cm9wHNPdMbkyLIyz3cfGxSgANJH836ATZA4pmZZ?=
 =?us-ascii?Q?AkST6IfJvvBiGQcStmlkb6A70UDjl5/PVFIYzAGblk7GNQEzD483a99g8got?=
 =?us-ascii?Q?M7xMDNreTE+68rHLvroq8ho/k4LyV+tbGgEFpGKizr9qt46feCY1lVqtbukH?=
 =?us-ascii?Q?uGTVm2dYcKIjkZPgDzCARP0JURm3nzNPW18SxO54Ix/foeQgnYRlVYhYALOa?=
 =?us-ascii?Q?l8RFwDKUN2ma4l9dlphGbrgc0+nu5qHkf/toPrhIVec4glTVJABgZXFvpifn?=
 =?us-ascii?Q?e7lhgxE6WPhBW0TZhe3nKUjnq1Qc4BvWmhn2wswv/MOLAheDt7y5R/QcD9Sc?=
 =?us-ascii?Q?B8yxgkJ50wff0Byipp9YvXxGr84znX/XxbNvhyzRTtV9u8fhuTTlM1A6DrC7?=
 =?us-ascii?Q?NZNGeHcJlSSVEUZ0qIYii9Z9mvVMfaUZSYNxkTWw81mRpjIFJAB+8ZctW1QE?=
 =?us-ascii?Q?jldN8B+4XX2Xv96q1s50qccwwBYahoMlqFXltyHpgkbJ89LvOb2S5LXO29iD?=
 =?us-ascii?Q?svwXtVSJiIS0p3zDZCtN0fv2VPiEU+yqY8AeHaQIxNX4G7wz7au1fqlfDDWI?=
 =?us-ascii?Q?M99lcw/UFqfBIhn+9oLNpW5WTa3J60tkgjgfUVPe00T/fjswaNkKLjDOSsMo?=
 =?us-ascii?Q?m2US387De/XLMIsOx47dDysz9fVBTGxKm9U075VIkPbLDyp0STSunxCTWaiD?=
 =?us-ascii?Q?G4CVY+Pv/gwx8LtWfMjb/aWMS/kz0nMenThoKSV/77A1zg6WOca/Kfi1DzFk?=
 =?us-ascii?Q?r+vyW+lAuSRI9wJagCkTnSnARuhLFPqU69FbEFFEjYSOlZ3fXk5Y925OLMtF?=
 =?us-ascii?Q?5VMfDw4u4mkQtYZfsnYB8MGWUyUEd+7ZQAGtwiZ1AVRnbMwMTw2myBT3gNto?=
 =?us-ascii?Q?33SqLlXDwfUy8nF+Ae7pBdN36qbMYe5q+AR2nJCyTASO/ugNPuffvlM3Hqv1?=
 =?us-ascii?Q?q37NKIQ9U/bZgpK2ezZHdVm9r0PiFe4/T7OQD/cEt2lFVwrc2Ipo3J8UgxAv?=
 =?us-ascii?Q?YYgoeFxD7zGxY/T4+Rw2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeedb7f-a82d-4ecd-d677-08dd62bd0e73
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 05:57:09.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7795

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Add support for the PCIe controller on the Qualcomm
IPQ5108 SoC to the bindings.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 8f628939209e..d8befaa558e2 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,pcie-apq8064
           - qcom,pcie-apq8084
           - qcom,pcie-ipq4019
+          - qcom,pcie-ipq5018
           - qcom,pcie-ipq6018
           - qcom,pcie-ipq8064
           - qcom,pcie-ipq8064-v2
@@ -322,6 +323,63 @@ allOf:
             - const: ahb # AHB reset
             - const: phy_ahb # PHY AHB reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq5018
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 5
+        reg-names:
+          items:
+            - const: parf # Qualcomm specific registers
+            - const: dbi # DesignWare PCIe registers
+            - const: elbi # External local bus interface registers
+            - const: atu # ATU address space
+            - const: config # PCIe configuration space
+        clocks:
+          minItems: 6
+          maxItems: 6
+        clock-names:
+          items:
+            - const: iface # PCIe to SysNOC BIU clock
+            - const: axi_m # AXI Master clock
+            - const: axi_s # AXI Slave clock
+            - const: ahb # AHB clock
+            - const: aux # Auxiliary clock
+            - const: axi_bridge # AXI bridge clock
+        resets:
+          minItems: 8
+          maxItems: 8
+        reset-names:
+          items:
+            - const: pipe # PIPE reset
+            - const: sleep # Sleep reset
+            - const: sticky # Core sticky reset
+            - const: axi_m # AXI master reset
+            - const: axi_s # AXI slave reset
+            - const: ahb # AHB reset
+            - const: axi_m_sticky # AXI master sticky reset
+            - const: axi_s_sticky # AXI slave sticky reset
+        interrupts:
+          minItems: 8
+          maxItems: 8
+        interrupt-names:
+          items:
+            - const: msi0
+            - const: msi1
+            - const: msi2
+            - const: msi3
+            - const: msi4
+            - const: msi5
+            - const: msi6
+            - const: msi7
+            - const: global
+
   - if:
       properties:
         compatible:
@@ -562,6 +620,7 @@ allOf:
               enum:
                 - qcom,pcie-apq8064
                 - qcom,pcie-ipq4019
+                - qcom,pcie-ipq5018
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
-- 
2.48.1


