Return-Path: <linux-pci+bounces-21688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E22A392AE
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 06:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B907A1D4B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 05:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D81B395F;
	Tue, 18 Feb 2025 05:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dp6Fux2n"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171C1B0437;
	Tue, 18 Feb 2025 05:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856700; cv=fail; b=qBRg+9iRwIdnCxM9Gi9CQBDPuXVDUP4ztz6AiY7AyiCrh2dbqmPIgx9RBtNYlAIWbUzbtSBbNY8Qv/0ZSQozP0cze86fqUPePnRxwgW2NRQ0vVQrXCY4YaeFq9maMkF2HxWnQCxejag4EnR27IqA9xZfmmY6cKmj0bdDb6Kpz4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856700; c=relaxed/simple;
	bh=R597xJ+pgPfzNxOlGI7DxKuYBxZQteymn4j9XIVkAZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtt1FvL26bEqdc9Z2BLOx7/B+mSYPgHYhph9WNLRpuiFbDv2ZDybnOKhIDzV7K5lSdKRGmC5IwaP+AKEZydHVUYwNCgdklfZLvoP82waWB0ZRCxTJRvctqupxCfbUADBdgcFcDWWkAYwa15Yyb9NOK1McZuLyXddnBr3ruDcMqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dp6Fux2n; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5mT3LvvWlrQnmH7mk0WarONdk6Cyd3HCD3/OrdMB4XXYCLARcJ7DZkm6GX6BAUVoz5Vt7JFRLISUw9CDPIPbJ+TJ8brdbD8AvkNTDLHwralRHQC/YHJh/7yTuUduk1F9s7egibpKRGjE1VfFnEnHiedjq79kETmVv2vclu8wr6NT82r82S6/+wG+9gqUS2E3Nr2IJi/+oJOz5Sn2CRipkUeA/79I6gC+KA5C/4bhrD/AucPnMitiDSA5Ygel535gxCirYePlxTKQ1hXfOz8cOzrF+mDoN3fLSNjoeaJN0S0Uj75ZUKKoVzXasX18dkbVQCU13CbiESOAKNJxfBfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW0UonjTJp6wJ+9lnxQLef2iZrLtyk6ESOFSNdhKweM=;
 b=OFPbv94x+xd3qd1eDZzaZueH8aMR7ygb2jEaCGuxKFc46uUMK/eQz22akyOEIYmXqVGXTwgcfuG94uQF3MNiX0ntzzmeTEEIPlGiknaL1E1sTfyX4RYWSDbKS2xkjXJkLaxwX47ml7dUlGZMXB8YZyplzROZbvTkZP+2qCM5dDPYx6s3o4J0z+JKYuEl+leWwc75GR0VqDZ0/a2PXhVLSD5+iJ7YpSeIXQfkDlnwyYUGjQXbigdXBA+aBKIr9kqmCCnxDTY9McVSY4Cj930RP7FU6Gk/G6goWPxrvGOsXpyKCcC7UvgEH6Dg6r3XAtOGFtc+0OTjZt0NWHPZn9rw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW0UonjTJp6wJ+9lnxQLef2iZrLtyk6ESOFSNdhKweM=;
 b=dp6Fux2n2S0cl774E2RGCqsIyzJ9DiwcVIrGyPqpT+iR1wDFT8f8wcq0YKMkUP4qsIps4pHb+U3spgeZFJaazZRhURy8+IJRcaohfCJ/IHKaR7y5ZEWXM6knYiGST0WLaGEVUGmd2nRsbKLc2e+qo+t+oMcLq7Xw28n9M3ofjVk=
Received: from PH7PR03CA0008.namprd03.prod.outlook.com (2603:10b6:510:339::34)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 18 Feb
 2025 05:31:35 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::7c) by PH7PR03CA0008.outlook.office365.com
 (2603:10b6:510:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 05:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 05:31:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 23:31:14 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 23:30:54 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Feb 2025 23:30:50 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v12 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Tue, 18 Feb 2025 11:00:38 +0530
Message-ID: <20250218053039.714208-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218053039.714208-1-thippeswamy.havalige@amd.com>
References: <20250218053039.714208-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: b120d490-f692-428b-6e4c-08dd4fdd8288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z+3UOId9x7Pe5B2jpSz3NYiCZ1jD3eSQOFlPA5j9YulPnyo/4UBtYr7R5Gms?=
 =?us-ascii?Q?Tv0M+R5brPfXx48aOB7BgPYW4bacBZcHjL8Yqzk17fzy2iMrjFLimGeDCO6V?=
 =?us-ascii?Q?5XE4/mv1Km7XgZDheRPzqO/HEOM0rRvxWfl2IeSRAPCPBDlEzBSQ39m/nfvQ?=
 =?us-ascii?Q?9EEVJN8gZ1aHxL1yFRN6MpLuezNhbS/UgTDU1qnaW7tf8dFSoSZ1u04Fax6D?=
 =?us-ascii?Q?94LCgfYlNOPuqWiMOQbVIIrLn2pCpbFjEkLlIHF9uE4slOROX+xY3YncHF0X?=
 =?us-ascii?Q?hCUUiBBWQegz1v2iyI8JTZ3XXXOnhv3gM8qm/n989uIfGO5YqRbpURagDC1l?=
 =?us-ascii?Q?/3ruKXZTY18wFAbYSBNwhzKJknv+i8mnJCUtxbE9FhCqx5Ncin/pG1JCzCt8?=
 =?us-ascii?Q?iG5WST7sJqy4QbPh/XdkK+apgCxU46Ob7BA5mmscSPq+7/FHhuGs/guaZDZz?=
 =?us-ascii?Q?z7/sks9KQtAumYHNzyE0Me5IX2uz3O6SK+bnbZCS4gKISMFCOjGbSq1WQoBg?=
 =?us-ascii?Q?cuwdaDjwp8fZrAGUOy0l45ppVCu/gETlT7sUSbT4CMPtQGPZxvYlEvTgBfKx?=
 =?us-ascii?Q?8eo62jmKZTGOW1GFMU0z4w9VLYCS/ITPrjW8Mfda/F/+2IMGZQHep8FcwbIn?=
 =?us-ascii?Q?zPl1YJ698D1yCwlsmA9tEZFlSTweob6hQ9e2WaTlg5spkEEqyiBqSdzGuC6w?=
 =?us-ascii?Q?l7xDHflL+roddvDSA8SsPjp2HsmVXyM8krIF9QGcFUVXTRznPfB+9ggR+kb+?=
 =?us-ascii?Q?3H8TkpCIIO1gXDAWUppMLefVXjYlD5pTnQ6E0h71BL3W2fP2ncciN2YPh0cm?=
 =?us-ascii?Q?g3RqAhC1sevA80B49qmGH1mo8ahaL2SLn03ug9OdXTY4jo7B1Tl5BQ1od+VQ?=
 =?us-ascii?Q?7ZBpv43+3J/Fh7TjuSNaQdw5vmqwKw7mabTiQIM0G4oaMR/5oeT+aF7f0kIW?=
 =?us-ascii?Q?IEn+sMqmM9VKSv3259vCI31+LoFBJejM+bhGv58UyUA1d2MD3YEfI8CTFFTp?=
 =?us-ascii?Q?i1NYcQ7WkiOVOgrcH86zoOLfJWYoAmq23XQafLrHDaYjfGEJFUfC6iVoNNS1?=
 =?us-ascii?Q?FncqbhjMWWJDUPRbVjoglO1LBmNaqpaKsPPgEQHaVUrs7wkovva/lTJaSrBW?=
 =?us-ascii?Q?zR5Lzn9ROtmAzns7zHqpz10lVP1UoH2g+P3ywPV68gUf7sXs9F1Of9M7ME6n?=
 =?us-ascii?Q?dvWUJu2ON5HkTL3+kQK12kxi8qqoBNFK+Qsfs2LBRBOWAe8BeDTfYucNK9ZL?=
 =?us-ascii?Q?ItEo11GhIMrsVKhdctlgzMbl/tnkYfIzS7J2P0WP5IUJnVQBZ7+kri0IJ+k0?=
 =?us-ascii?Q?nzTSpnGJ7twBo8a2WA7Nsxr02dtEPR/7Lry472f7zAr65pkTwzxpIFfOA8ro?=
 =?us-ascii?Q?P+shfGk7s0K9l92AAYZod7gZ20//6KS2R0R3oDno2j4TLyLog3tisPr8h/U9?=
 =?us-ascii?Q?19HCvO86zzRV5SkV5/f+WO9M4R+rX+qv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 05:31:35.1105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b120d490-f692-428b-6e4c-08dd4fdd8288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773

Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Changes in v7:
--------------
- Add reviewed-by
Changes in v10:
--------------
- None
Changes in v11:
---------------
- None
Changes in v12:
---------------
-None
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
new file mode 100644
index 000000000000..43dc2585c237
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
+            ranges = <0x2000000 0x00 0xa0000000 0x00 0xa0000000 0x00 0x10000000>,
+                     <0x43000000 0x1100 0x00 0x1100 0x00 0x00 0x1000000>;
+            interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
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
2.43.0


