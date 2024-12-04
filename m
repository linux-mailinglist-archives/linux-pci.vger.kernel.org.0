Return-Path: <linux-pci+bounces-17641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B399E3945
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A964328506F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C921A1B3949;
	Wed,  4 Dec 2024 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iaVCCVWc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23421B4F09;
	Wed,  4 Dec 2024 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313138; cv=fail; b=I88gwpbjKuyOPocsP2soc2pPJ353UP7r9pISl91aVAUVIBHUboHhH9ig0EWslBfXT+tTdYkCBsrKVZD8uXKL0BKu3+A/Er1Y7CMqJofxshZ0Ei+ZDatNMCjKE8OOFRDb6s5qBm9H9gyuP4FOg9t8VpfYXH0aph50GECk90sJIfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313138; c=relaxed/simple;
	bh=nGuZI6uhQM+Jrvlqy76kZiZSGVKnkx+onafXru1oaMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4GFTqyJu8gxf8UES5ti2wWuCo1MUyOLQnWev+BRIrm3TkwV3uQLbPzzo/JI4vHwq3/TdR2QU2aE/KgHgGmnsy8Vv6w9ZY/gHjv0M9V4Lt1WWwnFvDaiecM2kJMt8aQYjB366PlN6qMEOnj0XPN6nhtkmF9XxHbPsS79BsmWKL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iaVCCVWc; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/Uneeo8m4P2RnmIKEwxMow46wRLSGgtAfH0WTI8dedLRHw/maMt9Vj8JsfbPkG67X3Y82J+hZFuiBZN9JQHtkwiIVTZ4ap17SyJj0CHQgXdyXBz3nZDOnEdD9EPtLSCXp+e/ViCYTmaNBBSCDHrot4ehKpFXkR34XvRh8w5WLCo+6DvDjRI+VVMfnEByOG+O0P39aIhxRt8/axtO2keddsICHFdv2QXUcT53EE9e7qhrj+1E1eVHZGBHWNiiHRr5xuc0kO/b02+cwRE9zsNDVxhQhDbNqjsC2sfZEjcvcn6UMBPoBHSUjkzNVRjfahvwa5cvPkC0S/p+Mh4JVjF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GHnBzNdpfu6pJRwpMwcB0YFE5yGHm1b5MjY8zRpkg4=;
 b=Q07B5rRctFZtBibKx1WTzOovIGi2sIovlHhFIRlzEBY9idAljn4qyd3fbZyCnPEkYVKV3XDg/4LVWwcMTXML82a1ywMWH0PfoZxa6t7FrjUW5yrnTx+N0eeS6qnnDljrpy333YphbuJPEl1vxNwOmaAXPN4kihq/BPE3EUfjgOibOpCXvDpjo/awOKVif7tniObC8NCtiR5AP7MkBSGAfW46cVkYvwlamtoant4s+tMyRJ7dhowCQijLoJCduoRxPNlLC7rQVBz7XqC3pROnDBUZfDEGZCbSJFI0VDxNjJQKVsLbWsV2EFpr+CZr4i/oVpnxjWVvHJM2C/nSzEhF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GHnBzNdpfu6pJRwpMwcB0YFE5yGHm1b5MjY8zRpkg4=;
 b=iaVCCVWcgnDQ5s7Fh9u2lIH8ExGUuWJfkvZ5JCJmV55p2LA1Dbc1y4CGzz96+4gxgKoeQ5b74hcTmRwTGf6OESjDFl7q5IkMUAPFnRZzbYjS9bpkKUru77ltdOKdelPn50N5TnW+O6knJfoTWtMIkA6BfOBl2f5mQfCfKcyBg8c=
Received: from BL6PEPF00013E08.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:5) by DM4PR12MB7766.namprd12.prod.outlook.com
 (2603:10b6:8:101::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Wed, 4 Dec
 2024 11:52:12 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2a01:111:f403:c803::8) by BL6PEPF00013E08.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend Transport; Wed,
 4 Dec 2024 11:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Wed, 4 Dec 2024 11:52:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 05:52:06 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Dec 2024 05:52:03 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v3 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Wed, 4 Dec 2024 17:20:25 +0530
Message-ID: <20241204115026.3014272-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204115026.3014272-1-thippeswamy.havalige@amd.com>
References: <20241204115026.3014272-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: df22c785-d39e-4755-abe5-08dd145a170b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v6X+EFyAZE0w2hXqoKsWYh/b2yt4W5ApBafo9ZrDbG1zL9QJ8JnFXkICna11?=
 =?us-ascii?Q?MlZCKNTU51Z8HXjwIzfVs+rYRtuEJftvnMmQlv+i9g0iDp3OreSPjjEQvcND?=
 =?us-ascii?Q?YxukXH3Sk6t1ayGtI+Rbwp+q+XDEQeeDYiCxTQv6AqQXalxHb+Hn4QT8Tfwr?=
 =?us-ascii?Q?MQdffztSUrNXbyrE/QRWgkrRfnS1Rgc6letbU5N5W9+1ev1h2fvqodMd4JG/?=
 =?us-ascii?Q?OXoDIosOjMZxdo8jxtwHN8U8B+PPRPn5F6uQd0q0/KHJkrCliLrG+VuIMBCp?=
 =?us-ascii?Q?EqQPtZhTd4HiopW4MVy8pnggrEw53h0uidfiU6/JAjjEcvWtkmvfg/9e/wvP?=
 =?us-ascii?Q?SmaXxbYL9Ivvcn/DjYQNB9nCZJ0dVzGFE3ggUME2doy6IyJweth7oQ7+Dchy?=
 =?us-ascii?Q?jh+QO0vFMQAZia7FKgGWvZOYYSos48GSsYYcLsOV8RTZYiQELCScL2CeyjvW?=
 =?us-ascii?Q?U9xEPacrp/q3sKzqLCvrFjXTWz/T4P9zuAB3zvUFoh54TPAdYqADUjHULCcT?=
 =?us-ascii?Q?h3BcwHX2nKq95uHeNedYC2nvlVN5tucCmjvmLJ6qUbyEUT2jo+oTo/WHZlzl?=
 =?us-ascii?Q?/cVejPE1cWvFfxX59snZvtDpOfppBelf2PqvZu8eUPLrn2NpH+qDSZGJ4w2k?=
 =?us-ascii?Q?yG3jaAd29xkqrxJK7F27vNZowmzbL20UxPRZaoMQ0HbtaVaphXNtgIZ7Nqkb?=
 =?us-ascii?Q?9vVQ2AZj3gHg+6WRR9PlomJEgp84Jv+XfM5fZhzELDG1qliIBQF3FmkX7ivt?=
 =?us-ascii?Q?A13njdknbVSTPNL1JPOyaXpb70LOVcAm374niJoCt+g1VZdI86JkmbPYX8Mm?=
 =?us-ascii?Q?uoioEE5ufCYFJRQ/bflJmcSMRj5RJ3NCkxHw2KDfIYs4V0L/AvuxcEQZQxHK?=
 =?us-ascii?Q?qBMaInOSUIJ0xT14JTiiew6mjZdpHPiKdg9v8Z7Sp4L4h4lruqu4fIqWQaWj?=
 =?us-ascii?Q?W0yq2PHI5dCJ+SRG4kIxKn0vj7umudFXBljhHnc8hJag3U8If+jusvNJvUce?=
 =?us-ascii?Q?bCO7Cu5o9CXKHdwUfw/dZf1Jm0B4EXwQl/bFFQNjb8SByCOr4Az8BnuAKMj2?=
 =?us-ascii?Q?2n8UB0ybgJoNVB5fzb11gKnm0w0YVZNYmgKFIhtdZiIvg0+PnXdZ73fVim7C?=
 =?us-ascii?Q?bsbA7LBY323KZtqFwmOfJzCrn/g5vjO17JgTvrCWSGRwvvxXJlKDOvz6bf7j?=
 =?us-ascii?Q?/6Vq9gWn9IXkwwVkzjqolcLWNIsFHDrTKiv4FnOt//JOjmPVpMMHG6QfiVIB?=
 =?us-ascii?Q?OkdXBZh20wP0Hqo9PdJFSfdOpXVHaLdtXC2DG8YVRNDijfec/awin7Kb3Rrj?=
 =?us-ascii?Q?Ygl9Il5Rbwf96fdwtY5RlP41vjGcZnjfcMKCXceThXqrIxseAbiQU/Zr69e+?=
 =?us-ascii?Q?o1y/7IYKugIsbBL+UPECT9NKXWzUM/cszMHbVBLBeskPkQesNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 11:52:12.2106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df22c785-d39e-4755-abe5-08dd145a170b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766

Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
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
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
new file mode 100644
index 000000000000..c319adeeee66
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
+      - description: MDB PCIe controller 0 slcr
+      - description: configuration region
+      - description: data bus interface
+      - description: address translation unit register
+
+  reg-names:
+    items:
+      - const: mdb_pcie_slcr
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
+                  <0x1000 0x0 0x0 0x100000>,
+                  <0x0 0xed860000 0x0 0x2000>;
+            reg-names = "mdb_pcie_slcr", "config", "dbi", "atu";
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


