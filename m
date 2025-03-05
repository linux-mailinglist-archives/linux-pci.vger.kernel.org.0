Return-Path: <linux-pci+bounces-22973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B345A500E6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 14:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D8718882F9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402FF1E531;
	Wed,  5 Mar 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RM9CB4YV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2072.outbound.protection.outlook.com [40.92.40.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443324BC0F;
	Wed,  5 Mar 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182211; cv=fail; b=qruUue5yU2XEg4Vb3qr2spB1QBhMXkXAjRWltIjh5B0kop/i/mpB7H/clRemJ38JETJZ6mHOjTBIx1B6fvrTHl+5KgRF4sSdcaNC+TGKnAVBGrxi6hM9xPT/cg7WQUKR+gq6ddGGLADycScaNOGuxLr6Ei1beQy5tu6xOvVQOyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182211; c=relaxed/simple;
	bh=rJ0qwn374VxpNXUyGkNQ/Ur6o2pIpeu4S0+njsFB2jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTP591JJNCf1k2MLYCMgRyz4XmiV5Z0djPHZQcslENTF+E4XUW+lEQrLTxGJ3YnMOyWwXCOBIsUFlJSKcFZ1GMdYrZPuNcQzfaH2o9n3ER9W7DS3y3taqeqhdDkO1aXtLdYxd+ShDWe+2NUleP9oJs/9/P1DFCyx3jrLSXfv/1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RM9CB4YV; arc=fail smtp.client-ip=40.92.40.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqMcuNNgdIwLIODIqC4mEulcRwSfoJnknrYWtklN+pLol+DboXDll/aiyCXI+w+5AGgm5JTFsI5DZR2CQoiEFMGLsZ+IFReh4tSslAvznL1BknoKXhKbWxIUkLSTykU/8DG1oMIIg4ES3GV96NFOpGpyQK2/gHR1fB0wth8pVr4SgCb6c9HFe1BQRd83z+KjxV5qxvgq+StBOLxdAvalQ7YJTEbAJnKxIKBIWm+vOfEAob7Gm8DHrDIVAo8XiACaNLh3cyDBJRIzaVR0xhote2Ff0btCl04E+zBj1+zV0fwFEe4EnQ12FwwIy+y86Mz9Y55u9RMJhnvNV2UcYTrNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qwBpHNvmRxOK4qFeKHYEINvGC7h0Vx2FZ7BTpb1nBY=;
 b=l/kuQTiJDSN+jwaMm/9I8Hd1yIdHrK4N3lo3iOKSfbh70/WvTf/UzJRBuXpZMR3irQLy843M/4JxguTozUhC9lN2LF9ROgi+zwI3JSwok2fiH3JrytDlAKIOT/Bb8bxgfbvPHjGkrjkxPDsuBKOP4VHsGtb25dZWG5KPz6mXYDpE3aAOkrBroaRcb08nowjZoEyz/pT0OQW3BPGa9DCyvUWv2yQGKD9vn1UQTsjJQhfTZKSHNZUTO93/8wSGXMAIibDMwquBXrP0fD3El5YZdieKO6i7bYTMJJcDM0mUthgyNRVHAxHztBSga+JVuKq79BCtT3dM0tefO4Hp2nXxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qwBpHNvmRxOK4qFeKHYEINvGC7h0Vx2FZ7BTpb1nBY=;
 b=RM9CB4YVmX+aCYpzk2wkx3yIU4VI7brJXgkMiUOwf/LvZ3Sddw6rsMwE1AQZSMu8bkWyXvR4zNwFiiY1yvZzCkCAr41OXa/ldTsGOWW1hOJ8mO8SCylQQ8LWl+eXep2OUBs6qoiL26bYeVfaaenIUdINaSatB+7dT+pzLL0pUQ2c7XfArieAk9UvHbPrHgWk1wzzNzTDxdvz41XjPyDfvwaygeCEW2yRLAspzF1ea8eKZwTc6mvZNYBchph5kLrqkg6Zp3ETlBYy39JbakFrhNshtdZdnu219kIIHbLPqGh3lt9xrGoO5ILVGaqZtxLlUNLQf0SjvXEmXs+CqJdjOw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CH2PR19MB8895.namprd19.prod.outlook.com (2603:10b6:610:283::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 13:43:27 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 13:43:27 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	andersson@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
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
	vkoul@kernel.org
Cc: quic_srichara@quicinc.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v3 3/6] dt-bindings: PCI: qcom: Add IPQ5018 SoC
Date: Wed,  5 Mar 2025 17:41:28 +0400
Message-ID:
 <DS7PR19MB8883E7167E44F92DBC29FF3C9DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305134239.2236590-1-george.moussalem@outlook.com>
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DXXP273CA0015.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:2::27) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250305134239.2236590-5-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CH2PR19MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcb6b58-5c95-4dc9-4ab4-08dd5bebb4fd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|8060799006|19110799003|5072599009|461199028|15080799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vC/JeA2OPhszBKKCyKUiGFQWxv0kBSwCJKT/fPT7e3f7Isij3R0tjSlCzuJb?=
 =?us-ascii?Q?AovYOiJbhzNcaMtZQEGtuBGxbB8kQugCACiw22xs26TSt4gZMpjuwgLltREP?=
 =?us-ascii?Q?hFTT/uT5J8dOimF+80e+6ObnUN5421iwALlr7hYMiCQpLeZR7jJI0BzqAEYM?=
 =?us-ascii?Q?DQLejH6qxRDB6DUWz7S3p5uUSccYtW9W5NtcjD7sMn9EFtzyQr69PEkLYyLm?=
 =?us-ascii?Q?GILiGl74CRLahiznGDI19naer0sVYGpzv4/ZMf6vNHA9ysLYiXFnjAukcApt?=
 =?us-ascii?Q?rlgnLTgux8TEm3+1QBsSwDIJEzFknvqLCooG49UTH1VX13U9QiB8NOGgwDfq?=
 =?us-ascii?Q?k7ky7juOXfBcawyV2vWxHTqbgGnCHfcDYw4VaSroYejJ5XgIt2b39y8A9Ssj?=
 =?us-ascii?Q?X0s5JNCHGzcV5+HvH3X1XZhGi0Su5t9jvjL9eNewxSVu6ygWYWBMe10Hsxxg?=
 =?us-ascii?Q?sZv1J1UChOfwjnh5gG0fziNz/4biQMmbWeO+9P8TtZTaJDjLTrMcmqcuXbOt?=
 =?us-ascii?Q?fB0AbNZMb9EFLCw9q3k3Xn2qPexnRg5u41mUsadGc5kYPYTkc0122W2lsy8o?=
 =?us-ascii?Q?DQ1fyAzybHnPgwyEc6jH9K9ykYM7w4TMReF1wAQ4sbszhCKDZ27AIUpjTJXx?=
 =?us-ascii?Q?DUFa5DYzrq0gE4tTPSQirwyt+4Rl48cAflN78cQmbw6KzkbGd950v1GyJzUE?=
 =?us-ascii?Q?apx0AMgZ/tyrhc5RnsMkVlbeSwJNu4o+m0o0hL3kCWW1lTVEqTxy1BzkWwAU?=
 =?us-ascii?Q?HobK2TNt35YkI8XTiiRmWJtL1Mw1VJFSlzKATLEhyub/2vuqn4PxmZXch+91?=
 =?us-ascii?Q?cTqg0H8TQnpewiiXBCiK+IMUGsb1fnZBpCYu+50WRLhkQaSb0W0iv1nieuGr?=
 =?us-ascii?Q?weYt74aJnsO9FdaZqxdzWrZ19E5x9KxQFowOGw9X5LwHcEA3bnk5a5dH/7jI?=
 =?us-ascii?Q?zxje0NI0b1m4Tclb2WGlW08dRBaY1ev/ZPaLPNquHbRfox4bIsAXquoMAQqJ?=
 =?us-ascii?Q?ZVMwoWNCboO94b23amYqiInHIxNtwyI5jJmqOHKmoBMZITmX9gBqY24V3004?=
 =?us-ascii?Q?PZNN1EVNs6hGgthMvU6hDln7vamMvraQ9UPLjEzy+sWNsu++Ah0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?olUeEb9p5f2MUie7eHVkhTFp5gWLIF62aQOIdfnNVCM64QwQiEBdlawbJqPk?=
 =?us-ascii?Q?EymrodliOQKFN3an6Bfmhsuv1TKP2P9G0SBr0rcY8h0AvymuCq7LVAS3YYlX?=
 =?us-ascii?Q?gsAsM19pJNWfZ4hdGdIhFCU17DKIDz8HATU7oPANV6bPE36yl/m8wSxKXFIr?=
 =?us-ascii?Q?ZbkssjbVTfPdbMJw8gNbdBkgsStNpgXGAykRN9eTE2/7mpMrRUwi4+/3cEFE?=
 =?us-ascii?Q?2nK6hNkA5XwztpZy2X6fAvPdDo4b34GOUCqaHFUlgf+HP8yRmd9LZWSaBvo4?=
 =?us-ascii?Q?NNdc10YaX7kty7nQmnCszRgMWUQHScNDQaPUWF18es7KXUGr46DqZJDdz3t3?=
 =?us-ascii?Q?v6FLS21p8CLFxa91UdTOrw9+p9nt5PntQNNpwe5HTQslFjOjSOFT74jtIhIx?=
 =?us-ascii?Q?ypj0SKyxhigPgORD0QAcaRuoMMOoDjz7/WPlje74CiSEO+Xa95LOPe5y9naB?=
 =?us-ascii?Q?KO8/JwoxUb0dGS/ae5NbrHuNgjpRDKtFdITsndLbCYKan2aB8Ypft3RQQ0GC?=
 =?us-ascii?Q?gIDu4GDlWUjE6R7AvSpEuVhSdHToQ/ikVN6Z8J2qV19Uh1N5eDnM5HO+MzQY?=
 =?us-ascii?Q?ENloNWEmxHuKyDnPTGkdBvMj9SExpxsJCFeyodPFh9dAVi6akPen5NoMwXBi?=
 =?us-ascii?Q?y5dAAIlQ/Z9GIxGh4TdGISVDWYZGci2rKiLC6rTP6ZxGSKsdKxubgdyBWZ7z?=
 =?us-ascii?Q?hQP3YFcVcgF2qkMW5gBb9P6AQE9z1PGyPx6FZuDC34oyh4RSQMT3f9Z9FLAs?=
 =?us-ascii?Q?nEmozujJEmCUA7AN5P9fkpSb/DzokV34B2/kCyzSFyXyzhYpDf/WkDAv950+?=
 =?us-ascii?Q?lAF0LhW7QJrUemegJkdYJxhkJo0QHsbdGllNomMNt5mZpBGHc0uI2wHLr1+P?=
 =?us-ascii?Q?xPPDu3MsX6HVtPHLy7sOzi4Ti6fCotpDdO0MFQ7S8dwGGQymhdhtZsNp3k3Q?=
 =?us-ascii?Q?aQ2EeAZUkP3+1VVzE5m/pgCZ5oFeZspQ3lCc8UXUZNgKHd5BZhdYBxrYBKpP?=
 =?us-ascii?Q?oSkCMSi48apori/Ys27UgNSGUraeCXENAhnc+RqmxRn+hVftpS/P2TLkb0Ch?=
 =?us-ascii?Q?R2a2vlwFDswqItoEpL/qm32HUhVuhTDbQahCB7uyedoWlBLb+T0hvLSg3IEi?=
 =?us-ascii?Q?a0kll/EITfbLikUwVaiKTnlGyBMl1Ye/SyfteDgbRHXC6iemBMEHzaHbflCv?=
 =?us-ascii?Q?BJnJ9Vclo6wPpCEHdCKxzJd9nEq76nEYbP6UO/Qjk52NkzwfBuchu8E463y4?=
 =?us-ascii?Q?b+rheiy4ZJRwjBOohEf3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcb6b58-5c95-4dc9-4ab4-08dd5bebb4fd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:43:27.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB8895

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Add support for the PCIe controller on the Qualcomm
IPQ5108 SoC to the bindings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 6696a36009da..3aa8121b8ae9 100644
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
@@ -210,6 +211,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq5018            
               - qcom,pcie-ipq9574
               - qcom,pcie-sdx55
     then:
@@ -322,6 +324,53 @@ allOf:
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
+        interrupt-names:
+          minItems: 8
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
-- 
2.48.1


