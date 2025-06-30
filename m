Return-Path: <linux-pci+bounces-31045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B67AED35A
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3EE67A739E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0C81F3BA4;
	Mon, 30 Jun 2025 04:16:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023109.outbound.protection.outlook.com [52.101.127.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87311BD9CE;
	Mon, 30 Jun 2025 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256978; cv=fail; b=WGFPtHMkIvwl8puVrnS+sHbcptElUTHKdLgURyF++C1GqxSas4ZSg+icO0QMGayl+Rs88Iaod4rkCNDnuyVGW+RGNIyoir9aVTY9CrznzD4yC38HPjuMwvi/IBFdINlo5E5a6O2ACJ0DjlKYgkFH36PCBjpKxdJcGPW1WE1Vnps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256978; c=relaxed/simple;
	bh=CoK1JTdyHbN3kwbqRCGsgKZtU+/JwwN6QbZu1gwVdLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMF0gh0Y3Pj/rbh7NNXxaJFDraxXYMm4FaniDvQt1M5+6hTqmn5wltlyWbmQ7PjRxto+Lszh7q3R6O7400SiIZn7z4/MhNLs/IP7KYSB3r0+/QGt2+xKU/HWdMQB0uzRackE/+uMYtgsGh3caNPr+UyffokbvGYAH/lpC5e6kik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBR/ieohSM+dyBIKoVYm/1wGhSPq3jgWaykghqdhhaLQWwRVc7Yp57XiYz4yB5U2dwxh5QCHiUoVrRizLC0E/gr01o64deE0YYQC5yvr/92N9spC2QvFOxeMc2BuKQkjaNGP0yZ8T8bYTUAM1USb6LWdDTMT7MWzyucxmgkcNrva1t/33Q/PuXXpRMPOtrUdRVXxVT2KmYhuDGoOA8DHPhptH9zYWKj3IUnyaiL2CwI8e1OU900Bn5ANy+qfDHA/rUeQQdhzX9UYiDuJg0VKxyasW/MaKvMOES8GPjQZDt+cLZ/0+oc1jwUlBl1ukcEoxmMO/S7KexTcrvLXt+ZEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7WuRJvKkZISDMTnWV8gjT3xfqXyc01qQQ67bIePAvQ=;
 b=gLUHz4cWSxGsYpQILSI1wJcqIjDx3JPPiIj0kmAMJ/4KCRh/S8KoSPHXS+t49pKZAxYjjPj0xmcAQQRTdi+AQrLVQSxLBdtqAGFYUPZSg1NQNJeF01uWeazxQ+lQ/xZCZ1jEzyrf+thJQ/n7AqJSbc83ywR7Drph8mevqDrUvArv75+E1P6gqtkNiOzFO+xS63QpkaaZ/CxYUw3cZOOB/Ipi8xLjGoQFOWU58tcDrsEec/F6w921ph0A/8jjdtMdoDoywxwpBXvNb//rGBA7SQqxH2VTCkOabsNMP4l/f+lWhqqPKPZXNcQgHMmyl/mNqjvn48w5uc/RKxQEUUDFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0204.jpnprd01.prod.outlook.com (2603:1096:405:7a::11)
 by SI2PR06MB5138.apcprd06.prod.outlook.com (2603:1096:4:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Mon, 30 Jun
 2025 04:16:11 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:405:7a:cafe::be) by TYCPR01CA0204.outlook.office365.com
 (2603:1096:405:7a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 04:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C4BB041604FA;
	Mon, 30 Jun 2025 12:16:06 +0800 (CST)
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
Subject: [PATCH v5 10/14] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
Date: Mon, 30 Jun 2025 12:15:57 +0800
Message-ID: <20250630041601.399921-11-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630041601.399921-1-hans.zhang@cixtech.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|SI2PR06MB5138:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 59c1b0e2-f303-44bd-8402-08ddb78cd86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e7rvxOH/vWNE6CCt4pHqPMH1iZR8GvftfG96qGuVixMj+KzWNzuZ8p8eNOV0?=
 =?us-ascii?Q?5WTkFSpBFujCTmmcwALM4C7HF8D87FCRA5mNbvCoTVkrfYAMbgFhhFlsadiX?=
 =?us-ascii?Q?WaG+hsStFQcQzN2nNXi0K5ca4iWuxR0v2nEOFAZ85e0qrcbnZ5UMxSiSGl/Z?=
 =?us-ascii?Q?nnyfy4HwqDLg+3F/vRP4DdIZJZmigeDbesEnAdWH46o3JQMAJhbbHQBn2ovB?=
 =?us-ascii?Q?ie73/+QEmjDX4bifUNeX04tE7leOw+p1Xd4kOS/zVsY/bBbSbRW5jvT6LPq4?=
 =?us-ascii?Q?QsJlQxA7V/DjRIr76hwteMC1JMJMMUpGFPkVFifhw9k/4PI+w4ptd9iAbUJ8?=
 =?us-ascii?Q?wSGCRpUIlsFqXBzRrQrGfSWs8mHXJgUnBajVI2cnNW9h4ukfPKBobU6zZlIm?=
 =?us-ascii?Q?tOw1l10nZNx7owqdN1byvEN2PKDFnfoIsDayitwZjCzanLcSAuf9j0mlE8IX?=
 =?us-ascii?Q?JYUAm5OuEgpkH930+GwD3aiDWQALurPRkspTNi8mhqMZBVyiK2qvld5npKZ9?=
 =?us-ascii?Q?ap18hSAB0UyxunzBNEsN8SHJ6mschX63RYDv6HumoAML/jSjfnNOYr2PsVVE?=
 =?us-ascii?Q?LZstKxHtH3uFa6OZQH9plQHiJDJrPJ5cBdev+0edYn0qImolcJUVTuHsyn6o?=
 =?us-ascii?Q?4kULIAQHUxFh/RsT+LXHljMzQfscfMyIJrJCnyDxEGm5zAfr2RVvc8DooJ53?=
 =?us-ascii?Q?eIRmMHM9hipNgWu0uK3zoKnKoaE7AhZJmg2zo/ezkW1VBXzDBhTHCawOG/Zw?=
 =?us-ascii?Q?gVLFLGKL2p7/SKFQDgqDUh3QoaOdFEpEzzd7m8A9fTQR8XTR/5ubNneR48ch?=
 =?us-ascii?Q?E+UAH2vudN6LiSWBuy8e3ZBzpQsUuzYkPq4bwmYERDVpSA7ctyRyYmvitY1E?=
 =?us-ascii?Q?cqSJ17w0Q0wwYIU6XpTb66pTKcPnhKxgcB3wZTTxJ3j/KJCQWMoMh31l50Z5?=
 =?us-ascii?Q?ILGIFJUiTh09dJSxvsuhqdTodbtAQQlklcWSNsBlk+RIrbHRhnOEpF/pT/pu?=
 =?us-ascii?Q?8KZRXmsJVs7Rz/6zFbGEbfYMzR6Mtajh6STtNwsTkxA9E6FWEP5tJosy1AvY?=
 =?us-ascii?Q?B+Z+XarkzTi2T9iT3Hb+RLzA3XGJzr59NIh+PRRLjAZ6Dul2sIczSwNRUXNC?=
 =?us-ascii?Q?OOAGMXJBsMSuhak/lTcQMSmGw1ONJA0aGdtUrfPMMmdzbK5FYwQ5wuDPe5mc?=
 =?us-ascii?Q?W1cXbZJmW5NRsvfCn/+Cl2CGIJjbMRJsXd7XiEItEVjoOxZg3uyvcjngO9pe?=
 =?us-ascii?Q?3NlotEOBQubtxAdJwZS5KTYfyR5XLG2rSKNV2rva9Yy2M/9gePQ1MxvCu4Mo?=
 =?us-ascii?Q?NQJOmrMMv6XkuvENwPuP9u64NDUZm83BOAd4kon1sd7X3qtRC6zbCa4FTlXp?=
 =?us-ascii?Q?iX79XMgXT5jvq6kd/E+5aEmSG9Ov1ezikzNMP1l3nWIxxjiXvndxiZwNuFll?=
 =?us-ascii?Q?PNCIGltLFUUe2Ka3mNztk6RyLO81zX78eHChUtJXOUn06uzGZpVyEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:10.8727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c1b0e2-f303-44bd-8402-08ddb78cd86d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5138

From: Hans Zhang <hans.zhang@cixtech.com>

Document the bindings for CIX Sky1 PCIe Controller configured in
root complex mode with five root port.

Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Reviewed-by: Peter Chen <peter.chen@cixtech.com>
Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../bindings/pci/cix,sky1-pcie-host.yaml      | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
new file mode 100644
index 000000000000..b4395bc06f2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
@@ -0,0 +1,133 @@
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
+  - $ref: /schemas/pci/cdns-pcie.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: cix,sky1-pcie-host
+
+  reg:
+    items:
+      - description: PCIe controller registers.
+      - description: Remote CIX System Unit registers.
+      - description: ECAM registers.
+      - description: Region for sending messages registers.
+
+  reg-names:
+    items:
+      - const: reg
+      - const: rcsu
+      - const: cfg
+      - const: msg
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupt-map-mask:
+    items:
+      - const: 0
+      - const: 0
+      - const: 0
+      - const: 7
+
+  interrupt-map:
+    maxItems: 4
+
+  max-link-speed:
+    maximum: 4
+
+  num-lanes:
+    maximum: 8
+
+  ranges:
+    maxItems: 3
+
+  msi-map:
+    maxItems: 1
+
+  vendor-id:
+    const: 0x1f6c
+
+  device-id:
+    enum:
+      - 0x0001
+
+  cdns,no-inbound-bar:
+    description: |
+      Indicates the PCIe controller does not require an inbound BAR region.
+    type: boolean
+
+  sky1,pcie-ctrl-id:
+    description: |
+      Specifies the PCIe controller instance identifier (0-4).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 4
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#interrupt-cells"
+  - interrupt-map-mask
+  - interrupt-map
+  - max-link-speed
+  - num-lanes
+  - bus-range
+  - device_type
+  - ranges
+  - msi-map
+  - vendor-id
+  - device-id
+  - cdns,no-inbound-bar
+  - sky1,pcie-ctrl-id
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    pcie_x8_rc: pcie@a010000 {
+        compatible = "cix,sky1-pcie-host";
+        reg = <0x00 0x0a010000 0x00 0x10000>,
+              <0x00 0x0a000000 0x00 0x10000>,
+              <0x00 0x2c000000 0x00 0x4000000>,
+              <0x00 0x60000000 0x00 0x00100000>;
+        reg-names = "reg", "rcsu", "cfg", "msg";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
+                        <0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
+                        <0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
+                        <0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
+        max-link-speed = <4>;
+        num-lanes = <8>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        bus-range = <0xc0 0xff>;
+        device_type = "pci";
+        ranges = <0x01000000 0x00 0x60100000 0x00 0x60100000 0x00 0x00100000>,
+                 <0x02000000 0x00 0x60200000 0x00 0x60200000 0x00 0x1fe00000>,
+                 <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
+        msi-map = <0xc000 &gic_its 0xc000 0x4000>;
+        vendor-id = <0x1f6c>;
+        device-id = <0x0001>;
+        sky1,pcie-ctrl-id = <0x0>;
+        cdns,no-inbound-bar;
+    };
-- 
2.49.0


