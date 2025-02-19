Return-Path: <linux-pci+bounces-21803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268DDA3BB90
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 11:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A399018982D4
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 10:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58771DF258;
	Wed, 19 Feb 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ay4MWeah"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2681DF265;
	Wed, 19 Feb 2025 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960506; cv=fail; b=Q2B3g8kDhqh0H52Fd4VyxLqkUAxUto4cMYz1Hbt0A6h/YksIBh7krzTyi0obglgvBND2bcVftR7dYwDpSMUahQ9O6WiHsL4xaatQNZOVpz1ol7jjKlMXcwhQ6VDqx6mILVE87983PAu0wTtqo2l57vsISiMxDNe6B9OoXMZIjhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960506; c=relaxed/simple;
	bh=R597xJ+pgPfzNxOlGI7DxKuYBxZQteymn4j9XIVkAZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rqo+xr3umOH7zYFUhTm5zPOtOWsDov9MBSmCOhyim+01LkOs1afwxaA2B/DDglhn9AddUY8PqRLzpMEi+WcVf9jcpL4/dg1+cOpuV0BLmsPzKH62Y4OPENZpORHlJbe5etRCf71nQZbKSY/+gse3QjG9upxTZxJpYQ5++GGSIm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ay4MWeah; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANpCAQbHBJXYJxOYBe2igAb75oL0uome1PXV7UtKi8X6WYYy5Zlv/WU39eeV3UFigtknR/iPJeFUrj7NJZDZmWbV9DCvJyOOA2ir1kNHYOG5iki93iTAQoj/hOn9lO11v4pXKFFX8HG3k5V7J/t18ad6P84ojrBQ7cueh9FzPiOhsB513adigh9oiPFNLv7SwnEwss/WhwyWqoKtIMhGC49VK7qoww3Ioq6Z200jdSjku5sX6IvUUE7T41zsVYWGDqYlIlnzzVbEsxO5LZfzHZoRCHF/IHv60CmOU02by0avPNv+/EVDEN1Ylu7pD/T+wTQEsz6zbKJFJZnWuZsN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW0UonjTJp6wJ+9lnxQLef2iZrLtyk6ESOFSNdhKweM=;
 b=SxJfsMJVXukirQMG5j7FDTdkGwTOk9rXtg4yHYoKp5bjxI+cLllhOshO83FuQQ6JSx87bmpAjDE8xHwJTs9+SMtXxTRb7n7kt8aNO7qrgArrqj77z7YFle54gbEeSfj/swrTiFIQgdhVKoRvadpuSbpAKqMKkPJBLQvXYMtz4jLl7mSo8OxhFos1Hfp2zj/vzD8jAJNH/+8AHSAaAIVOuncG4LYvIXZ5TByHJ5ec3jLUusmH/BfDJreonkFIqY+xD45c5M/JP5WPDSJgPrfqT4IOEemqkLCRfLERk3VgynA2HvtbX+3wKoWPPKlJWlwIRkm1Kd6dOa/W4aCMxtOWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW0UonjTJp6wJ+9lnxQLef2iZrLtyk6ESOFSNdhKweM=;
 b=Ay4MWeahc2jYXTFzOyyjrXtXc2VASvWcOT469XFDQZPMY/BQj4Hf0f6ZKRoiwocK6y0puvKZlBkh9tT4Ucfm2BBkBRZXdL1SfwEk5Q9mJiFypx49fNSxMVdqEllKeo+mQDzf0zvD7E72M5LVbRg3jfz/A32oSKbu8O7dpr/rAB8=
Received: from BYAPR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:40::24)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 10:21:39 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::5b) by BYAPR04CA0011.outlook.office365.com
 (2603:10b6:a03:40::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 10:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 10:21:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 04:21:38 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Feb 2025 04:21:34 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v13 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Wed, 19 Feb 2025 15:51:23 +0530
Message-ID: <20250219102124.725344-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219102124.725344-1-thippeswamy.havalige@amd.com>
References: <20250219102124.725344-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a1e0d0-20b5-4585-3bb0-08dd50cf3299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qm3sbfPJzU3RC7zeyyPZ+U3i5hBhNdjZiNnsszmXby1aSzreoKd0OQzluwrD?=
 =?us-ascii?Q?i5nM72kGSrV3TcRsKfFtocQGxs8m1l2GYH+uwndXVk0oL297GdYjxNsdp+Ax?=
 =?us-ascii?Q?Cueeaxfqyk/Cr8gvWilBG0bDWzCRc0ERlp+sbOy1ZMjuQNU7TMgVNdAwxH6W?=
 =?us-ascii?Q?A/7PdS6JQN2kj0BtEfv0t1iBR+0WRWx1qVX68vGdyCkOjz2ua8GLj8kW0faC?=
 =?us-ascii?Q?MIcBslNfSocKHwSclZEjv/qGEEvKjtVRxqvoRCL5SXLqyidtNPNx35tsRoP2?=
 =?us-ascii?Q?yBSHjSSg3z2vyheFkb3hJPv2O8fAK496/JXGS3ZNgzoUA6jJ2EK/F6qb7nWN?=
 =?us-ascii?Q?nFkkN79f/nAjLvdTJeJpRUmnWYDCu5KxAUn792uibC6l+gwShzJEURRABxPf?=
 =?us-ascii?Q?ROxxAK1EOsaYfQxqzAopffW+Nb45xMwLX1FOuk/sJ20jY67697ILdVjcYKbW?=
 =?us-ascii?Q?8AYfjXuVpAFJ6UAtHBHWdnblSN18MMX0nzNCKOESqHurkvO33MW1nnu/4EVr?=
 =?us-ascii?Q?JoTTH/hxgxS/GNLYe3rPQbzXx5qLsipa22EuNzq+yZ8tIe91WdW7ONCJxX6v?=
 =?us-ascii?Q?RJo3dLfRwMJ3HJh04AOIJGdkeNTcjSmJUVXfiVao9RH7dBLEuOVQPQeFChUq?=
 =?us-ascii?Q?GGuTPCwSvnKseKFUSDNmfzAGSFTi+bbUotVrjeRkhXgqHiEk8YrV523dmtqW?=
 =?us-ascii?Q?jBhptjOA61izB3P1Vg9EcFsWnCQQixP7E4nn+xOph13oxBOrE5TIzU47C0QP?=
 =?us-ascii?Q?J+Ylm3rJbqvzLTwEv+nplWRU9EfPV3n7nm98EWka1rjdnWH4yffxmysrggoD?=
 =?us-ascii?Q?qvGPtFGW3gRMhF8whnpFdgikPbXa7VdMwwszt/dtzKEiuZGfZlYortT0VsBT?=
 =?us-ascii?Q?1tbrDvEfK4zb1GIf6ceGceTytBw0fS4dPtEtL5nUGj47aT+/5XXB4/8izs4I?=
 =?us-ascii?Q?yJSVSnwa+bcstMvV9nBtZ+s49E4pVI1rcADnuLN9QZG4qHt+z59TAVU0IP3r?=
 =?us-ascii?Q?LC9pN2fK2N3X1f3ujti2UWXK2P+8SY7ydTfboUDTgARUP4QepyDAC5zwEhUR?=
 =?us-ascii?Q?jyjspeoiGi5KfSuIemvNF1kmpg9Kqno9ejNw0B3QFS7oD+hZgZsRPnDO4nCc?=
 =?us-ascii?Q?ZHTM3995teRppwy6eMnD8zpnd4n3ikaK7rfliCJSJAElDS4xjBf2FVHCfJE4?=
 =?us-ascii?Q?+o+DXZtzoukYuki5td30NRgABmLyhUCNxrEEGKswKAtZMdj/SNr6DEwmF0CZ?=
 =?us-ascii?Q?d2xPvReFqGWTO76xt0tLbDeh6lSKKCBy5QXpU7vEUobonx4WqkhO2DcQxW/r?=
 =?us-ascii?Q?acf1VzW84jkbJdBtR9nZgo3dwu/1wWN+j12CU3pRwnwo2sNmQiqFCUCxobdN?=
 =?us-ascii?Q?rdaHgztS0l0HT5phfd661uInMJOkB/IckEFCn8jLIk7Vbpr1hpZWYAOK+BkO?=
 =?us-ascii?Q?oQJlYKVNDCH0hgh1/5Qnte3YBZS91RZe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 10:21:39.2115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a1e0d0-20b5-4585-3bb0-08dd50cf3299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297

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


