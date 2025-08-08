Return-Path: <linux-pci+bounces-33613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C46FB1E381
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1FA37A3DCA
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 07:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D90E275869;
	Fri,  8 Aug 2025 07:29:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023118.outbound.protection.outlook.com [40.107.44.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5C274B36;
	Fri,  8 Aug 2025 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638187; cv=fail; b=pHcHkzcplrt5NU2StmdDrr/4g9ocZjVe7e9OtS04pBZdJHnjZsUvfyZnwN5EBK8af2YXahsCSL/k3XSefNhrYWuiYaD+dV4llyF7+jVLx/1CiywwBHe/fXeGkKas2E4aoWLy0mRn+hSXkFJ/40uhW/OmLwV/YxTC9qok/OKJtjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638187; c=relaxed/simple;
	bh=3Dpjhv0CDATpofkzuwFYLCPacvPU+iTj+31f2ewK8r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKkZ+taZn2z/5SMJQtoCs4A769cmZ9NjjVwjNYo00BMRZtmGsHd5QZAzbsdxDSTC9D7XlUePHrrN8cOamFdNI0i5uPZL41tlY2vxYoqwDy9Gy64IRvEFah1Hph/ELK4cEomaQr7eIr8JeZWsD5uzRVAOGx2fY6TPb5aa9CHS71E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7zdZWwNEZadJaMR132P7/mhHa2iZc8BGAGb84cp1/zUz+uXzfD+zD6gh5ShqO9lLF5HseL6AGtGReqfDohrzmSxQRTl9trnBc2JkHyKlR2FnJ8e/JCCWw8y87HDwFIAqihN0th0KwhdRqXhEYEB/4ntKPYg7kCkF0eM1SbiS60ZLLM4VZ0T+CNzZKk8g1UNcxV8dgLFPdr/71MySMwCQECPqzWvaRO6VaGE961VivZbRktspNhxb7TR5igtP2SNyMEOi4TrTjOtOnTjhWM8qoGlYUKZWiEm7oAXqE0lg3vmKl5rwQbvJULtNnOAfnycuYMikPE41k5I+v1mKRhYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oWY1ZeY8wffb3fZMVrjm0d+W4QBizzKrdcwJMlq2do=;
 b=LZp9bEz5fYbzUcTs8xCx74P83PNMywsH2wRyL6joM7/mGtbQV10z9dkrJiI5iA+vr9/79m9b98ULIO6boNUuBtBvkUlxVUYzgCBWsB9gDJ6j8mdp9rlnnJBbtExuFulgxOTpcUlwrR4iofIlFqxi9rE4IQqOZdFqMT7GFtVukkGBKnBnSAdc25hsYTTFKzP0P0FRjUkOUg4WzL4FPtnetX6XhSUn84jofJcqQ9j3Bjf7YDdcf9CfHVbHhrxhAsoGTJm1uP90+pYUPNnrBOFlYKcyAXPveE4cYrot52afRcXUw7q/QRzQEyYBW/1J8Z6uf0ZGbT+ttp57VZP+9fHX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYAPR01CA0132.jpnprd01.prod.outlook.com (2603:1096:404:2d::24)
 by OS8PR06MB7323.apcprd06.prod.outlook.com (2603:1096:604:28a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 07:29:37 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:404:2d:cafe::13) by TYAPR01CA0132.outlook.office365.com
 (2603:1096:404:2d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 07:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 07:29:36 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 70B4841604E7;
	Fri,  8 Aug 2025 15:29:31 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v6 07/12] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
Date: Fri,  8 Aug 2025 15:29:24 +0800
Message-ID: <20250808072929.4090694-8-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250808072929.4090694-1-hans.zhang@cixtech.com>
References: <20250808072929.4090694-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|OS8PR06MB7323:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6a76413e-2c56-44ad-9e69-08ddd64d5405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OrvNv55IGZHjNFKqLtSJGEZfHmdxYI/z/ivsIy9104LSeSoS9lPZI3LuImGq?=
 =?us-ascii?Q?vw8rZ1mLN3ZB6NHKZW+LPHCaK66IRTo8f0OElO6svEonlRAGO9PA2wit1FWw?=
 =?us-ascii?Q?7HreA05j+cp8e5BLFWwRL758mmYdzMeRkqRN9mIGaGRmu1xIESUilvjc5jXf?=
 =?us-ascii?Q?GBOdfhIVXCMEpdXg0K5Ds5uXOrWQ3egN3B8EqMBuaqfszVWPLfGsSWoE+cR+?=
 =?us-ascii?Q?eoo1kZPIrVVQKKjRidpaW8AnFD+miq8UuUoQ3+YpPNxabsOOrSHlX8pyriST?=
 =?us-ascii?Q?1VUM9q9amZle4X49OIFf6yuXA8APtCIerBNpVJJIahWFYZQG4fsoXzDvzcGI?=
 =?us-ascii?Q?uPy7eaR6s3vuShG7YkQaIHUW+XvWHg5jYW5b0nhdinV+x3S30k/ug1Pxph2+?=
 =?us-ascii?Q?BkRZ2yNhipEastrUnKdkiODSoLVDTnzicnvwgpG5cJBMobGiJaUwFovvcwcj?=
 =?us-ascii?Q?u1wLn6rUVrXIBWFgM+OmdsvpGbKVCpfZyfdu+Edy8kiqXSl8mAQAMfWy5k5c?=
 =?us-ascii?Q?hVFbefe04OdZpMWuhu3rzMHjJIEg45GXaKt0m985dD1YDc7VVlvL/8quCRSt?=
 =?us-ascii?Q?CoaABh7IQdvFm36CROukxwHTN+B41Wj0oymZhOLxHOSE1a/46/79rKZz6gSq?=
 =?us-ascii?Q?gedTXPO6YLBSfvFqGlu9PlPFwjJPRjU4RAkvSEj69BGkG+frqrr/tYnmIy0B?=
 =?us-ascii?Q?xbl2gbpkKhHMBRj20KjCi3KmM+g8U3hMcA/2/Qjz4uK5st2dXhxV0UqOM+QC?=
 =?us-ascii?Q?9m4XU3TMZ2Jxm/imy1U7yN27umJx1TAAny4+Vurj9PXgbIlCGi3gCRDzfoh6?=
 =?us-ascii?Q?wRzxKiQNJ4ikCpuxnMqKdeN97wy4cndHZ7tU5S06a8gVdc0fsRZleq55Ywc2?=
 =?us-ascii?Q?J+K/1vtLpBxXBvQ74Nv2mgNCKa5xIck95advC12pZnaKnpDB7r9v8hzdPpt8?=
 =?us-ascii?Q?DRSTt1uANxpMGX4kdXjBNDkXX0JHSvd6YNarhFKNrsr/9iFIFyyO74AFR3cs?=
 =?us-ascii?Q?UAURzLVNRlGJdltSzG801bUCWmtZ78ZbrfLWcbM1MjC5ZAXDAMm2NFqSl3Z2?=
 =?us-ascii?Q?OCPaup94UzLnZEgQ18cK+VMpv9iMyyvYTfwuubO1qShl8tapjxfGLbS09b9R?=
 =?us-ascii?Q?V0EV8g/TOa3Z90LZQUHNDctuofKPar8F9O8B2aEdVihaouyk/Z4cS2/vruds?=
 =?us-ascii?Q?HVQ1Q/n1RYzV7zV2rH7y+ZDtA/TM5so2s5VSuThGQ2jjTKwRPNAwBpF+FQbb?=
 =?us-ascii?Q?aelSXzVAgei7bnpMsAlK+IrfecIZgU/G/HA4+Nc5T8w8A3sapy4SG31h+y1P?=
 =?us-ascii?Q?q+R9jb7YuYMrzh7JrK5yosiyVu3JTvYijXKXDCV0mWHaTRQbfBRa++zZX1Z/?=
 =?us-ascii?Q?XZjyJoZ78yLJpjjiyPat3Ul1AvB5Whn31iY0DA/6CEXWO+j2eAw8J3ra7tlE?=
 =?us-ascii?Q?nt56M1cgqB20SXWRyEq5QfyXt1PSxrrJ8dZT/y0BvrEsdEHsQfPQmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:29:36.4848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a76413e-2c56-44ad-9e69-08ddd64d5405
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7323

From: Hans Zhang <hans.zhang@cixtech.com>

Document the bindings for CIX Sky1 PCIe Controller configured in
root complex mode with five root port.

Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../bindings/pci/cix,sky1-pcie-host.yaml      | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
new file mode 100644
index 000000000000..5aef69ac14b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/cix,sky1-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CIX Sky1 PCIe Root Complex
+
+maintainers:
+  - Hans Zhang <hans.zhang@cixtech.com>
+
+description:
+  PCIe root complex controller based on the Cadence PCIe core.
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: cix,sky1-pcie-host
+
+  reg:
+    items:
+      - description: PCIe controller registers.
+      - description: ECAM registers.
+      - description: Remote CIX System Unit registers.
+      - description: Region for sending messages registers.
+
+  reg-names:
+    items:
+      - const: reg
+      - const: cfg
+      - const: rcsu
+      - const: msg
+
+required:
+  - compatible
+  - ranges
+  - bus-range
+  - device_type
+  - interrupt-map
+  - interrupt-map-mask
+  - msi-map
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@a010000 {
+        compatible = "cix,sky1-pcie-host";
+        reg = <0x00 0x0a010000 0x00 0x10000>,
+              <0x00 0x2c000000 0x00 0x4000000>,
+              <0x00 0x0a000000 0x00 0x10000>,
+              <0x00 0x60000000 0x00 0x00100000>;
+        reg-names = "reg", "cfg", "rcsu", "msg";
+        ranges = <0x01000000 0x00 0x60100000 0x00 0x60100000 0x00 0x00100000>,
+                 <0x02000000 0x00 0x60200000 0x00 0x60200000 0x00 0x1fe00000>,
+                 <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        bus-range = <0xc0 0xff>;
+        device_type = "pci";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
+                        <0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
+                        <0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
+                        <0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
+        msi-map = <0xc000 &gic_its 0xc000 0x4000>;
+    };
-- 
2.49.0


