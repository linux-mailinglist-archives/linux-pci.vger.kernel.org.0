Return-Path: <linux-pci+bounces-20699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE97A27252
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 13:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FE51880475
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22132139B6;
	Tue,  4 Feb 2025 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gdTBd9yF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6482135DA;
	Tue,  4 Feb 2025 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673211; cv=fail; b=ReV+nfskp5cny0VSYsZoVPlmz+XPJaWP7UNwoeucrGDSl3276kFv5wMRlM9cYRthZ3GfxuGLyNbSWBAR8fyATdDFgwle+FnsDrKhGilWPdbzttSRKaiogS6zG+PHffi8YoEUK1eCpXANuBiMF0ZPJ/Abb4a9aWyGL2y73Y5G9l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673211; c=relaxed/simple;
	bh=P++m/d0VsVM7YoQP933dmJ5YCSpDg+4lbR1AW4nF4Bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHQE09s/eBKzR0kWD9psNLPQzZVASDUk5dyRazyG6NmcjppSYmV2R4CqlEO+cPGb4reuTh9ftX5ViASxahDhxfV9EqWW1CZSiy/VvuSbq3QwTUnj+eZnn9dXrdbQ4cgeZQAqBSNPAsa+ia6ZUJuy7bvNePxxpM09NUnQNWaNnco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gdTBd9yF; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4jfn7TjQZhOnZo8vfIoesNC6WrHzN4F12NzIuXiQZIpMy/Z2i2CkBXGD04kHVF3qoyUcRP8oUgUG/CLfSQ27s8Us2AkYSakgmw1kXGi7bLbQk20j0ZohuSn+hEPe9tYg1dqfotXWS8cU2vNL48FMXl8tXqCkcZ75czzb/YnvKW1wS4EqETmD+MHIvrlDFEdWIsgipF+aBBRhyIYJiKFpaQH7IddfviH2nPHRq3RLsWivQ9Ysqb0+t6QFEXmT4CxnA9Lmdy0m2LcMa2u8i/EqNKMVpw/goDVgSuYIeFU2BjJZ5RT7sO4aN4n7tHaN218hRz8jOvUiPQygvI8xPKabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BST0epFSfHjcKvOXbqWE5L+9NdM4BbrcpBt11Pjuw5Q=;
 b=LXiguXXfKtkj67XX6L2cNGB4oIM7BMxt9t2v4wSRavWqM1e74C6bxTClHsftTBAaQlo82qtQOracPvIjy7uSMF9BOF52+wYUQ39GJYlL+6Bqlc03fXu6mIkzw8Ulq6+UQjJQGj8pEYqbd6NK+4VgP0FyrZYbE9KgZQfbiUZkSwG8pyvqFevmM70n5xCNjoZXHguixp7k58Bzcvy5ZStNQmrqG0vPYy9qvN3b1B7WBxH1ovpGrNhDR4Neyb6iTzMbAKqrgq2wohJbwbl+znK9PEIDFOcSzGco0vELwgPH6dZx6h3Eb2wyxmCgmktRTOTp2uHMQ74xAxZicyZRYQ1c/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BST0epFSfHjcKvOXbqWE5L+9NdM4BbrcpBt11Pjuw5Q=;
 b=gdTBd9yFHBZS0j0JRmanMMAjYhxiKxd5roxvMlC4SHIExav5JvwsIV62LZezIwkfykl+totkCLUXWyQBgGNJl1QMxBgvPQBHoeEav20nbFthfbqqRcbNi7wnhQH9GK0Ktj2YaybRoicODFyRHM7ui+qsYTonz/QfF2oGMf4qQvk=
Received: from BLAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:32b::17)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 12:46:43 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::a3) by BLAPR03CA0012.outlook.office365.com
 (2603:10b6:208:32b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 12:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 12:46:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 06:46:42 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 06:46:42 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 06:46:38 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v9 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Tue, 4 Feb 2025 18:16:26 +0530
Message-ID: <20250204124628.106754-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204124628.106754-1-thippeswamy.havalige@amd.com>
References: <20250204124628.106754-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: b1817393-e935-435a-c190-08dd4519fa26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UQK8kWtmvABKR8OFXgJManFcl5rPbVFKV6J7jfydAtGl9YDPRKS39AmrMSoP?=
 =?us-ascii?Q?9mUEXDd+N88RpcLx+ETEWVtKLIxtggOEC8OrVCAVSmNacl1aI1L1A+S9IJfD?=
 =?us-ascii?Q?bvlFwMw+jYmLKDjg9JI7w/KTOSDj5RNBqsSRC0K4ewu4OmvjoTmy/pOkCWDY?=
 =?us-ascii?Q?OwMIjeFSCBRqlxwwncEIoHtrfBpKi0ctYsWtdz0V6BW8GCoDFtDGsKnPAzLu?=
 =?us-ascii?Q?A2w5hSCXnyPM4TXfAInrza78zIKI3G8f/ZgzTt3iw3eUded0OJJ2L/27RXTk?=
 =?us-ascii?Q?NiZWsb9TY4aIArWznLXcu15j6+/SqZ/h7/Psx9Kbh+jw4FcZsquQ+U1mFutg?=
 =?us-ascii?Q?xRTJ68ikHO/jinPN14CmiwypcEiGJrA9eYwSPL8TH1NPWBhre7O3+9DONyxa?=
 =?us-ascii?Q?RykrswVTSP9g6ezkVw3bssQCmldgzq8tcO5DU8lB7Um577vXwMcj9vDbc3JA?=
 =?us-ascii?Q?kRb61eL7tjxGdXJ+BDYLx95Ozh4WUbNMOtnr5Ibxnu7xKRyzIyH4X4B0EqGD?=
 =?us-ascii?Q?JGYYmbIi6aF3acuHz+x74iUmgRLgZJ8/t2a6tnpQZytaPsKZdPaFPDOiYLjD?=
 =?us-ascii?Q?dc5m7DXIRVYrMvwb3kKZNAKcTTSsm/zda0hWEvPb2v4NBOhugjKeAR1kkCKX?=
 =?us-ascii?Q?vtuMW5iS2QVg1r2CaJ6Smr4NRnfOJ8tOh/gX0cj3W1/uxuAYLWKt8czORlkv?=
 =?us-ascii?Q?pskMCuf9fWGmcFf0A/2gQnTo8Ru2seTwNY0mETFbFd0GneDouzxOedQcWD+2?=
 =?us-ascii?Q?T4wqdOf5VG1ZxG4yp4tB2kLSBrii8Bp6KCU5luXAFLkfo2M1/ijy0ohx5Xwp?=
 =?us-ascii?Q?2TN4veIcoIyr6EY5auEoC+LPjOvJUOws8rhg+ocQ9QHwId0i3wvAZFrlNeeJ?=
 =?us-ascii?Q?S+lD7WlPY8MiLXBLUsRE3wytxqHYTPpcpdbBBwwphlXEZp+7mEjxS3Rzgy81?=
 =?us-ascii?Q?78/HQgRR3MxeokoEecexeZziqG4VF44d3McAFm+0dMjLzgsaZ0Sw6r8WGkFY?=
 =?us-ascii?Q?r/eQgqS3ho5HPyQsK87HHw3h8TS4BAJu3MmJC4aMhsRaTWTpcZ16iZ11ePI4?=
 =?us-ascii?Q?Cz9me3wOXkJ1dHTXNqs8Tr4oxF8t+CSNZtziVy7MWpQjtuYeuQn3++FUdusi?=
 =?us-ascii?Q?+WITX0ZieSaiSaOzfUPmA8C4y29Otq1YRtkhDFzCqVtXviR0/MMpOFsEIYL8?=
 =?us-ascii?Q?pbKyiEa/1OSepSztipgK4zbPa0xZMybCstT8J5a2AyzNWsRe94kQsJERJqZW?=
 =?us-ascii?Q?DcVU2AcwTSGMnIveMm+adu9hsMyvPs8/kLLdjapiG7nlj3rCBjks9zyIbGbi?=
 =?us-ascii?Q?X5RbIwe3HHitAF+FguRGql4QzFDdAPBuvIUrYk/vQo/SE2RohFlEY51z3vEc?=
 =?us-ascii?Q?aj77OZLb6Briv8m/tMT3NHsQy4DqGitFNYlWQGwHYenB+9Y4bG7V7datxNWt?=
 =?us-ascii?Q?jflTQQETHNsovJQfsBDSaddZ0VZSGbz4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:46:42.9040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1817393-e935-435a-c190-08dd4519fa26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410

Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++++
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
---
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


