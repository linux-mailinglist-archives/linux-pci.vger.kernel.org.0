Return-Path: <linux-pci+bounces-40626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41662C42DA3
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 15:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7FD1884636
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE7221858D;
	Sat,  8 Nov 2025 14:03:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023100.outbound.protection.outlook.com [40.107.44.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B712D156677;
	Sat,  8 Nov 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610596; cv=fail; b=TcIL2fjl0TnseL9xAdeapVG0elFVF9vutfqxo0MnDO2V+C1/qsRy72jsywpGR2/eznzQ/Kps4yioTCHU3yKac1GJK23UBoEW1ytMjcLD1lbsio0eRQ9iIQGcKC+zchU1O8ZBgHnofT3eF3xMew3IgSZIKXj+Ijo6BRNpQqcPjgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610596; c=relaxed/simple;
	bh=kkkSztwjkWzHvNvHa8cZjDFHKf38e6sJJt9sJWcCEFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kg30AOcwWh47uhlg76wN5lcvOARKMfHBE+365VTz5V40OjSNuKUBAwtfPcu6sjwPs6c0tL8apFCh1GDbhCroQk4mo/3T+ts5weaWsIuibyzeQuADEwxRHRDDSWrbilmgK6xPoYJ0RAu8YUUy31I728184s4d1KebuHe5DGZF8t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4Hj6Un9ybcqT+HqovbxtyGMXj0QVXoavhzBxuw1K85KqBOIwq1D+p7dcrUH5UPgk0WLVl9zd6EG5aktHj+TXcYymDrrTxwQ+w4w0TZnMjoVoo+6JVwmAS58RTz+WdKpp/c1/MuZIKUaYo2g1U8j97jlGcnU3EsXjdw/kEdgZPwXWnKBDybSbIPtMWQc/RP0smBxd2mRU0HOhngCClwlNiNsocVnYyJDX3qaWga9ZAZKoIgj1MqM+sSAqbCrcLTOf7AgthzuHIpb+lf/d9KoHGjMtlQNLu3GodSjy5aUBu1vM+Skx9IPmOrrvkJPP4Swkxds3MpbwtmsFHH0Odttaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB39FNr7E8ZDx2fRTsrnz/r0DpHC8LZ/b7gDjjDvJZY=;
 b=IWi1vgfg/K/dw1P45vjmXvdnN++kabUnTHzYCUgSAtxvRME60ic62FkXYoU54Y7U1VItmKsWs7CiW4HpUFcefcj654d60ic8gYr5tZpff++NqJjTGgeX1ku728Y9hbPAIxryXHkX8qC+d9sYC8rSEj7UzLLa0dWVqKHliye4GSyJHtXkBraYzBnQ5QJo4osajFwbz+tVTehaWhsuEJQlWmnxhShzdaBS/Bkko5t/XmnYA7cN1ZePogUxwhosrZLUZBVP5apPLqTkcs7c8WT04gfUTb4AkPc6NzIscg1uzcKjlVbiXUQK5BO7lyz9sYVMVhY1aRr2Cq3LtdW9YNrp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PUZP153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::11)
 by SEYPR06MB8196.apcprd06.prod.outlook.com (2603:1096:101:2f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 14:03:08 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::9e) by PUZP153CA0007.outlook.office365.com
 (2603:1096:301:c2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.11 via Frontend Transport; Sat,
 8 Nov 2025 14:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 14:03:07 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 212FF40A5A1E;
	Sat,  8 Nov 2025 22:03:06 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
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
	Hans Zhang <hans.zhang@cixtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 05/10] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
Date: Sat,  8 Nov 2025 22:03:00 +0800
Message-ID: <20251108140305.1120117-6-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251108140305.1120117-1-hans.zhang@cixtech.com>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|SEYPR06MB8196:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03135996-936d-42c6-4018-08de1ecf8b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EOILvl8I1c3oghW3MB3Ya+mkx2pywPLCuWTIPUC7rsE7NVB9B4iag7uS1RBW?=
 =?us-ascii?Q?zVIvsXGoQgiJvOC1Gw5bI3Ctj2ilNEf1Hz656PKVAVLstaiL7nljje11B5WH?=
 =?us-ascii?Q?a3WQjHu2NsTeeY74rJ74Mn/9YyTHSIjgEaknsYfhM7A5cKjQORqaJdiLAzcx?=
 =?us-ascii?Q?x1sRIXO46ige8B9cwE2aaWjMqcNiXOk/qIsAyM9eaF7xogDHKmk+qP62Pj9h?=
 =?us-ascii?Q?QrS8J9X29zk3w2E1FDGUMy0OcFgR37Te95c+F7BOjHY9cV9X6nTlPTj1TKbE?=
 =?us-ascii?Q?TneR7nIp5qDHnQUewz1CfOJzkIzHJN2ejTMDMvffscxFPfOY3MtChNZaFKdo?=
 =?us-ascii?Q?pcZQYPDdoXKhjlPIwfL7Hpgln+IOPdjg+r3tg1RhILX5EXHg4ep36LMJn+ai?=
 =?us-ascii?Q?f5i9gknt1yUWCbAAUNxeIj4X7/LnSG7mZcjsKIIlKUjAxfrjiUgZnTLyTAF+?=
 =?us-ascii?Q?SdcKr1Z6P5vL0h0i6eLdgNAYm+eKyuLVkQHbpzWfkwnrVEDPgU3Lpk7k456b?=
 =?us-ascii?Q?c7JgxYoI6K3HCaNJM6bPdWjyGdvp88er/owZsxIXOocEsA2u4lj6I2KzO5jO?=
 =?us-ascii?Q?6ZlnPj1yqyEnOIVQe+SvNqWqA4w+FPBQWNMcvlViAwWAff2obS8kEy3Lc54L?=
 =?us-ascii?Q?d6jVMVwnpjaAniKHiZf7Bpgocx7ZNBH5lfcRNBcEKooMgSV00PffUD9C1bkh?=
 =?us-ascii?Q?05UYXAfaHnjyozl4707J0wyWEkgTeQQ7bKneDPPHzhI9ptmsFfou00Y2V5xh?=
 =?us-ascii?Q?Wz16BNvvwM4xJT8OveYDBPfbtSQ480c5VU+urTRxaZ3NSORGUbHw924Swj0X?=
 =?us-ascii?Q?qtVJ4FLDTmn0u0RQeZnTQH0zVqCcpfpjc5rTJQnvBIXBNN/KmM5+spEQ0HuA?=
 =?us-ascii?Q?elr12W+hUCHzTRifzHC9lQ1f9xIrsFi7E0uPIjrGjjNDAHHD1d/trUoe75k0?=
 =?us-ascii?Q?p70hoqZr35LoUBmYkYqXxYiR7klMjaqH5QjV9IyN2p67LdJxg6cZixGyoVDO?=
 =?us-ascii?Q?tAE67tdQsusZFpk3o0lgEmsuNIYAk7LZ63UUz+vWv07sAkMxhF3Dou2UxxUo?=
 =?us-ascii?Q?QZnKZGz+4TBWj2YhCnBZEf666hXsw7WOdZeC4OUK/sbRmzHLAcNfuuNZ3bQg?=
 =?us-ascii?Q?PnUE1T+2FRDDND4o7XGn8xYEpjAG3/Kj2S42A/5AVLtYoWPBugNNO6rBU/RP?=
 =?us-ascii?Q?rQstmlyYiK/fflOlqCQBsBym+erAAwJyHSJw7EHFghMkp4NpaVIgexfmPHXs?=
 =?us-ascii?Q?YXVXZsOS4Ech216afINtXHu6JVruPiHCEdCNt6aSSvqwjbhPwC5HGiCQ/zKe?=
 =?us-ascii?Q?w4s64WO9VULvZX1Ob8zal10xOlqt0ZX7OMcb3HtPhUIP5GJZiiYbDrPlxtwk?=
 =?us-ascii?Q?bgB47iJ9vIa+Ot+HTTtP0BZY5HksADk0wiUja8676MeN5BVSWjpZ/W4JZwmx?=
 =?us-ascii?Q?eOjn5aJS4Wuk4udR90veC8F5JGXZFfimul3HpdrET5CtysSKgA2haR964iWE?=
 =?us-ascii?Q?3jeJVmKEFcv8Y5/K0XOq19yPFP+5JP2mju7D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 14:03:07.2558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03135996-936d-42c6-4018-08de1ecf8b2b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8196

From: Hans Zhang <hans.zhang@cixtech.com>

Document the bindings for CIX Sky1 PCIe Controller configured in
root complex mode with five root port.

Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/cix,sky1-pcie-host.yaml      | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
new file mode 100644
index 000000000000..b910a42e0843
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
@@ -0,0 +1,83 @@
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
+    const: cix,sky1-pcie-host
+
+  reg:
+    items:
+      - description: PCIe controller registers.
+      - description: ECAM registers.
+      - description: Remote CIX System Unit strap registers.
+      - description: Remote CIX System Unit status registers.
+      - description: Region for sending messages registers.
+
+  reg-names:
+    items:
+      - const: reg
+      - const: cfg
+      - const: rcsu_strap
+      - const: rcsu_status
+      - const: msg
+
+  ranges:
+    maxItems: 3
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
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@a010000 {
+            compatible = "cix,sky1-pcie-host";
+            reg = <0x00 0x0a010000 0x00 0x10000>,
+                  <0x00 0x2c000000 0x00 0x4000000>,
+                  <0x00 0x0a000300 0x00 0x100>,
+                  <0x00 0x0a000400 0x00 0x100>,
+                  <0x00 0x60000000 0x00 0x00100000>;
+            reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
+            ranges = <0x01000000 0x00 0x60100000 0x00 0x60100000 0x00 0x00100000>,
+                     <0x02000000 0x00 0x60200000 0x00 0x60200000 0x00 0x1fe00000>,
+                     <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            bus-range = <0xc0 0xff>;
+            device_type = "pci";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
+                            <0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
+                            <0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
+                            <0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
+            msi-map = <0xc000 &gic_its 0xc000 0x4000>;
+        };
+    };
-- 
2.49.0


