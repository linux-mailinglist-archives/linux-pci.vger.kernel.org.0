Return-Path: <linux-pci+bounces-20128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E99A16457
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 23:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9272A1883E3F
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 22:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234CE1DFD81;
	Sun, 19 Jan 2025 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S3g0LX8I"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627621DF981;
	Sun, 19 Jan 2025 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737326609; cv=fail; b=ZGmZBN7gpqAPFKk+ejzsXG51DYVpYfRThrqOsGB0Z9xnQUe9BJCRYgbzNBrIW1DPe2jowI8hmtWwIAGVniptguUASsEdO4d5rtn7zfDpI7evJmGIce7Uayvntk6F7g+VY5bzccQdWgD5rXuPRs2t2THamQfAlj1XI7NnCbKmhWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737326609; c=relaxed/simple;
	bh=t/VXG7h/4PXV3I4+IlFa9vACDyDI94g48Gc/7ps1Q7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Za9JdRTm/vJabqWgiOxGwXkm+ZqKRxH6sEDIy6NnuHjuo7JsSZG8VTQv2KPkIILSS/mnQop/otHEmoEKXqOXSeFDTFNqZhVYHmTkF3SB7sBz1tjz8CYEtEA/fpI0kTIatmBxEUK85Z/423Vd/X/mbx2sROhjKpujME5OpkQOwmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S3g0LX8I; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8+dzYBvFM+Zj+Yno9WEU2LRdIFKZ4ukA4t6X5CjAOS/Jz8Ole+n+O2UyzK/QuqNcjK58MxPy0ebfAnME0Ds0/1Jfpj6x2rj/Gx1Q1SA1gpltSfayLI2cEsCCpuMoEqK+/3Ly5F4N18pJBYrZc5ccFZEb2ltp70gQBahKb6BNZ3AGTyhlITx1kGE1qd1M/nOu9QudLHR4fvl3lKRUFA2qQZEWyMl6PiGFeWGGIns2VaVFbANZ+HQb28asob4aOKOalm0PDpCgts+rTAR/bYLJbHzN7jNkDXauoZP2XpcXkK1OX07fvijV6V6IRWc5mxZ002m82jSbeQUE24AmkGuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OE5KWzoimMNjqZteX8/wS/nPj/7l6tmp0w32l2bbeI=;
 b=wEkGs573y2qLH50WV4gUS9k5yq1ctavTdl/E+PHelg+LUSwv0e5UZjODAncV4Kk1FNT45zaZdRotDCAXc9PPrqTSdNpEwZCOl/XY6IZsT5YNhj5M8bs5ahWe7LsLVLzrDhar2QyM0Mpnq6HgtvrHKrLap7NivedbYDZUBvZkCw+EsQE4xEDKNFiO+G8TdPtLlKk2Mykd7P/U87eCgERIN2sTDhbz87me7MVLv7YvJuiv/op7R5GtG6QzDIkFJmcu3QJOS902oGz1+O/yYQbf4ZxOzCwc7+/WCDafN8amiVKqaq8IqEr0vFhtt0h89agaOsK9AwuXRDaeQYFMboa4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OE5KWzoimMNjqZteX8/wS/nPj/7l6tmp0w32l2bbeI=;
 b=S3g0LX8IXk9LgJMqDcO/AQEUK5Ux95mCb0veAet4DEhmV06UmcCsE+BgpnZ9+Pwlr5ZS+AT30b2JoeK+C/oSofxSmbxtIAZIe04u8i3H1kVVEVOMlXFxz4uD79FpAs3y1UxCntryPDFuplqekDIu6B7RX96bQpkkkctWhKmGFCs=
Received: from CH0PR04CA0059.namprd04.prod.outlook.com (2603:10b6:610:77::34)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.18; Sun, 19 Jan
 2025 22:43:22 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::56) by CH0PR04CA0059.outlook.office365.com
 (2603:10b6:610:77::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Sun,
 19 Jan 2025 22:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Sun, 19 Jan 2025 22:43:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 Jan
 2025 16:43:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 Jan
 2025 16:43:20 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 19 Jan 2025 16:43:17 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v7 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Mon, 20 Jan 2025 04:13:04 +0530
Message-ID: <20250119224305.4016221-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250119224305.4016221-1-thippeswamy.havalige@amd.com>
References: <20250119224305.4016221-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 141f1735-7e2c-4d98-7a58-08dd38daad3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rBe4wYjAhIdh4IkLaLo0nhV2xYeaxd4emM+c34QHogl41ctfRdWntxWQMRC5?=
 =?us-ascii?Q?YCwB3dH1qzzgCnAfTeOI9r3OO/SYSc7Hz6kLfvpom0VtdCWHfxwjQKVBlO56?=
 =?us-ascii?Q?biL42h+m+NGJCKAOc0ceRdgk7zVv1a8LMX1RGNWYGCHirzyBQHvz9OuDIsyH?=
 =?us-ascii?Q?aQqyh3TQ4Iyh4yF/rBuKkzJeh73X7z3N3iP4VNAs+fQ2QQ6WFWNqbPdEW+8p?=
 =?us-ascii?Q?51uEoZbFIY/qOhYdGuVGpUN4kA1r8K3gaAiLDvxrBm3iBe55geRoV0tejBhT?=
 =?us-ascii?Q?6FT8J0gEPjf+SR29nbaKiQTgiAT4v3O9amAV54YwsOqMG0h+64In47Qn7jon?=
 =?us-ascii?Q?+B099sFtjPDZV4nrMApgSqT2AuRrIBg3skf+E++SwJn+KFVzLSGTCA8VyzCw?=
 =?us-ascii?Q?pyrKuOJTnXAF9xDRCUdMD53BP0VdB0w3F2kqbws0HBFnZya7Gk8BH+eWOkLH?=
 =?us-ascii?Q?pkJxTZFhMMpchAJI3IAj3xYz8xSrTIyh5mvCj09+ek8liGXgmEYWCJBXz3Z8?=
 =?us-ascii?Q?X+trAPzTeMParHmMPV3CUaaXacVqXbM9rWYqnO9DP2hXCSU91tSjk2GAWVAt?=
 =?us-ascii?Q?urYrZPHiP/jURmM4R5FsW2M3a9uaq0YIj2AqLx1Zt0dUSh1XbHC95J6o2/FY?=
 =?us-ascii?Q?Ots7DRomo4ErDYhL29IKwq5QzKvsAXZ70+ygeUbClz9lKnZFRNvxyxafKlzz?=
 =?us-ascii?Q?HrA9y1GO1NYqnR5hqzvEgVT395ECz1wiqK2iOJrWwdUd9U1GuHlXaivedGsW?=
 =?us-ascii?Q?fPXEjcv51Ny4Rosz5nEDivdaahHZE0xAtb2w6UxuERKYcVellv7vnL6MhGYf?=
 =?us-ascii?Q?IJnqE3rQt1Jng7eUOBHwCoN4wNviF3mgn7NMChO371QRhMz+QhmAsDaH6UhR?=
 =?us-ascii?Q?aliWCTa1Um2m0gX7yAv0eieaPkMLpH5X7hBJSmRa1oFzAq8ynwvSw8YMgIcp?=
 =?us-ascii?Q?KvJVVhdodJ01Ld7nYwkWWMM117D+T84/KitQ3JTem1zCeYNpstU6/3B59DIN?=
 =?us-ascii?Q?6YEzaTeiS7xJ5KkLGKx6jZZ/xvmDhLGYJrGMasopNWVibU2EC8IIDhjDCI5x?=
 =?us-ascii?Q?BHGqPr8qwxj7AsyjFrzg1nXe5OAAuY2pE6WarF5lWP1naw0uvPSVwyb0pWJF?=
 =?us-ascii?Q?NbkNqK+xwSTGkN9uBHBS5UCSfrF3igV1F/PnTPs3PCyongvmbWLCWkX+Rhbz?=
 =?us-ascii?Q?v7Ed4E6hwOvkVH/9B4AAJAR676UqfQd+GEvdJ3fu0JLm2ROA1BstKCqLE5KA?=
 =?us-ascii?Q?gsaSvmSZDJFT2RrkPPwCbU1X07jl8UDwaJt49ZN3tBqtrfWOCyoSlqG4SHHZ?=
 =?us-ascii?Q?a5d3WnWFMJoZoLs1wLEH+AxWpOJjeKBciG5Tnhr5krWStSt1uLPvRl1GjFg7?=
 =?us-ascii?Q?i2nKkQOIUgml+r/a/vPrwEBAwaWaBy0DCcm1kP9GiqQEJAxRv5HNfJ9ixz+S?=
 =?us-ascii?Q?m1MstZ8UBs+paGsu3iXDXbCsr7AUttnH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2025 22:43:21.5832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 141f1735-7e2c-4d98-7a58-08dd38daad3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v2:
-------------
- Modify patch subject.
- Add pcie host bridge reference.
- Modify filename as per compatible string.
- Remove standard PCI properties.
- Modify interrupt controller description.
- Indentation

Changes in v3:
-------------
- Modified SLCR to lower case.
- Add dwc schemas.
- Remove common properties.
- Move additionalProperties below properties.
- Remove ranges property from required properties.
- Drop blank line.
- Modify pci@ to pcie@

Changes in v4:
-------------
- None.

Changes in v5:
-------------
- None.
Changes in v6:
--------------
- Reduce dbi size to 4k.
- update register name to slcr.
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
new file mode 100644
index 000000000000..db751a51e63c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/amd,versal2-mdb-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Versal2 MDB(Multimedia DMA Bridge) Host Controller
+
+maintainers:
+  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: amd,versal2-mdb-host
+
+  reg:
+    items:
+      - description: MDB System Level Control and Status Register (SLCR) Base
+      - description: configuration region
+      - description: data bus interface
+      - description: address translation unit register
+
+  reg-names:
+    items:
+      - const: slcr
+      - const: config
+      - const: dbi
+      - const: atu
+
+  ranges:
+    maxItems: 2
+
+  msi-map:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+  "#interrupt-cells":
+    const: 1
+
+  interrupt-controller:
+    description: identifies the node as an interrupt controller
+    type: object
+    additionalProperties: false
+    properties:
+      interrupt-controller: true
+
+      "#address-cells":
+        const: 0
+
+      "#interrupt-cells":
+        const: 1
+
+    required:
+      - interrupt-controller
+      - "#address-cells"
+      - "#interrupt-cells"
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-map
+  - interrupt-map-mask
+  - msi-map
+  - "#interrupt-cells"
+  - interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie@ed931000 {
+            compatible = "amd,versal2-mdb-host";
+            reg = <0x0 0xed931000 0x0 0x2000>,
+                  <0x1000 0x100000 0x0 0xff00000>,
+                  <0x1000 0x0 0x0 0x1000>,
+                  <0x0 0xed860000 0x0 0x2000>;
+            reg-names = "slcr", "config", "dbi", "atu";
+            ranges = <0x2000000 0x00 0xa8000000 0x00 0xa8000000 0x00 0x10000000>,
+                     <0x43000000 0x1100 0x00 0x1100 0x00 0x00 0x1000000>;
+            interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-parent = <&gic>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
+                            <0 0 0 2 &pcie_intc_0 1>,
+                            <0 0 0 3 &pcie_intc_0 2>,
+                            <0 0 0 4 &pcie_intc_0 3>;
+            msi-map = <0x0 &gic_its 0x00 0x10000>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            device_type = "pci";
+            pcie_intc_0: interrupt-controller {
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+                interrupt-controller;
+           };
+        };
+    };
-- 
2.34.1


