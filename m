Return-Path: <linux-pci+bounces-17573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDBB9E1CEA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 14:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15715B366CF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1693E1E6310;
	Tue,  3 Dec 2024 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u1FNY0N3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA51E5733;
	Tue,  3 Dec 2024 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229385; cv=fail; b=AzaPfiiogoiYdnrC3J+mTZCSAA0app7RbclZHWcwX6aNynVDFWOpgBy+BW08ifIm0RBhC1f/u5FrsEMp9rLbWi+Hg9Z5DOTB43D0Ki+l71wyFjbrmIGRN9hNZ7c8lvIeeHchzVZgxnBM9spWbOt1GstOs9vZ8xrbEMqQTwvQSe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229385; c=relaxed/simple;
	bh=0IvlZd9QYEHZPy02KzLzokwQ5JjMt/CMcqxlT8WSSMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vb6ROiI3IjA9YthY9ys7i6KPDjFD2ZJicHSku9/5Pq18mptpz5/itD670lwvaeqXLlb08X4lW5h6yL9IyrN3kI1m5dHjKnzX+HefusujlaOHmvccOHK7TqOFKakXKh/JE05pFZiUd9A7NoFeMrDqS7205pUD0W0PxEG337NpJh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u1FNY0N3; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7jYdatb1c7aRTbc+CJYXbhHZbwcPdYresWEsyHFG5GD78+0q89/6VDsF7L0IU0RE1Z91eT0skjAXs5m0hSSDVpuo/8JyVYYg8BQqse6uRSQLkDbKAAPdQ/rIVNsWK7kMZigPtwf6KbEUyijP5Dd/nwXD39UYAOyJsKnmGXmjKy01mY/G2GijtEMeFUyDaPO2Bk7J30knPtaXqWT56j7gpvrPbypgUhuEnWwdmjPBw5CLMLoZaZhk7CXVTaLI397GY2xYas8XFNa5JlxALfuMNpGgJZyu5uRySFAcpBnkTCehTpW8bNcxTT/6WbQHbwWFd6DwY56lMsVSS76y6aAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsL+npaQTghkQICUH/ZWCFrdn5y+jpxYsEyQBkN74x4=;
 b=Bg0PPIFffLLpsxjZlYoLJ7USvFrOL9CYtPQj5fXUNmyTtNhylqHzPLF4+LnCrQMHgUesaVdy35cyaTtb+9wXq/C0s5a+n5LuQE5MpLNsihNv7xj5qy+vJWR+iawu5bp44lG7N0xnyypvhZrHgOM1pPILJPZPvzhwlIl96cfCDDOmchwqHdDwdcMAiOrredp7v50mgAFl8/zaR17QHKA4gQXRDxnbWciiQFAeHvvQ1tvKEVIKn+jAaU0nToqo+jDMxLIL0wCjWeW/AXwIBUjo60cnOg2Vow0EMMe8S1TgCVQAb21L533oNyRgP2Id/8cvISytUNNmu3/TVZk+wrPFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsL+npaQTghkQICUH/ZWCFrdn5y+jpxYsEyQBkN74x4=;
 b=u1FNY0N3IUoLWu6/o0zA/nyBGc3N/8P20v3fFAF99F81GxyA/u8lNLx1HJQ5jhytlwYW27KyyN6Jov+jATWlcbs3/1r9y5FOn2zP/3mod7/eSeqLXW3oVBoWAR6OqUgYHLKg/hdYuSbCDSSHrMvNl7fFp9qHN2ZIFt2USs9mpMg=
Received: from BN8PR04CA0065.namprd04.prod.outlook.com (2603:10b6:408:d4::39)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 12:36:18 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::7a) by BN8PR04CA0065.outlook.office365.com
 (2603:10b6:408:d4::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 12:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 12:36:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 06:36:17 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 06:36:17 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Dec 2024 06:36:13 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Tue, 3 Dec 2024 18:06:07 +0530
Message-ID: <20241203123608.2944662-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203123608.2944662-1-thippeswamy.havalige@amd.com>
References: <20241203123608.2944662-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3477ed-c288-463e-8f86-08dd13971598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y5wTGv38owwlt+1is4wIikkq8HFkt6ogF17SQzVmnlfM8vq91huHjPdoW1if?=
 =?us-ascii?Q?CI+Y9Hn3YZ52Bh0t8Jk7OQKk9cfJX6AM8m28nsYnzOUix1pW+aSU2rToddhE?=
 =?us-ascii?Q?/NZfJsZ93HNgz6UsgVk+gytPBARWqK22erD3pg4mJmBYqWES9cDhybsrxcye?=
 =?us-ascii?Q?5nKJtuYAxQBzV0mxnSWtU2dZRlniU2TaNlrdm3JNaV7u7eUumsRiWikDQdnk?=
 =?us-ascii?Q?xS1v5RVIcyTGq2dGfiWD3yfThIVSyh5PNlWHTFmolV4wsAz5Qy+cZcckS1kq?=
 =?us-ascii?Q?JScTv7sQMYteT0gknmV9cHuWsq1M0CzU7QVki8oKBo8MvtQsqCaPUzMOiTR5?=
 =?us-ascii?Q?1flNsJsiOBa3MImqbpDOVwlZNzV02UjaC9AUVq0mOymD6rskI5qZuj7KQOmq?=
 =?us-ascii?Q?N1EhsLWWyePL4QZLFDYa1KVEh0iLWcaf1XIQpCbeZCxkWpEk9DsSSSLZ+pep?=
 =?us-ascii?Q?d+dJMvG2FLHx3oz6vhd5ykYFl01rJfIVEpUA1qBunjqNCvC56r57cVs9eTx0?=
 =?us-ascii?Q?fltZc87FdgYBNUnB6TLNPl6kz+lFHDKxDdJhVMSjwjlXAn17OZv9fOfiwm8G?=
 =?us-ascii?Q?E5PzG78GX5xaLeVEfsAqp5YII1FvUDp0HpZG2vEd9HMpdcxA1tJXgFO/PKEB?=
 =?us-ascii?Q?bMN/k3HiFaggA1pOcWINuKxrX2wHFO8p7KbX2iirR4QX7GRV4teDRMm4p199?=
 =?us-ascii?Q?RD4bXk7CfzJRXgY3V6y80y/BMcvp8dA3NrISmAPzW6pjYT5YvyqvMfAc/xYY?=
 =?us-ascii?Q?C9bmoaMXN9Mzsw8fIxV70kevpnIPojQh3Be/ntLVfQsmZ2xs9aPL/Dp0mOE4?=
 =?us-ascii?Q?xpyzbadvEzNlRVZiUxzTwTWB2+eZi3+anenfcJkby2TThyqEXmpFTzcrPYQp?=
 =?us-ascii?Q?Jf3l411zkdcs52Hbv8+sVSZammLEvJxEzjEgbbanLflihs0ygVQK6UxMoS6x?=
 =?us-ascii?Q?oTvoelmnn8qg/dxnj+KeEtAcN3htmi3YsIjq4+7dXrrdvYxfBTsXpU7TVdwf?=
 =?us-ascii?Q?Hmv0l1PPV8WCBAO94Km+wr9O6R2SCvXHdDTZ5pLEvLqyiLIy9LpX0+9fW/Sj?=
 =?us-ascii?Q?VZFkiXdnITRRDLZZhJE6u6aN/z2cFv3P7+PziMXlcRcZbfWiPXJxq+un3zEJ?=
 =?us-ascii?Q?JXXtay7Fo4WmMPbZd/t8G7+8melBGvKqRjTA2wGBdGiVQwt3Yyghy61LJdFk?=
 =?us-ascii?Q?9YTLc1J8aH7WcraJKDDuE2WNDyMN1AxwQTqyZw/bkWjFwXaLa6qFk93B5YUn?=
 =?us-ascii?Q?P6ASngAvCzhSqIsh3pFmEnIGYUplJB5oY8+Qiml55lIV2vF45k4SZ++yC4iH?=
 =?us-ascii?Q?7wHgtrfZJsIf4OC0hWjZbFP+QrrmZUUFJMb7Yq4Zyu1YbXulTfhA2CBRa+vZ?=
 =?us-ascii?Q?6j8jaLpUGKT+DDL7YG4bc6goeo9YP8UA6o7LagnShvwAurjnQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 12:36:17.9162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3477ed-c288-463e-8f86-08dd13971598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657

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
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
new file mode 100644
index 000000000000..75795bab8254
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/amd,mdb-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Versal2 MDB(Multimedia DMA Bridge) Host Controller
+
+maintainers:
+  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+properties:
+  compatible:
+    const: amd,versal2-mdb-host
+
+  reg:
+    items:
+      - description: MDB PCIe controller 0 SLCR
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
+  bus-range:
+    maxItems: 1
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
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
+    additionalProperties: false
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-map
+  - interrupt-map-mask
+  - msi-map
+  - ranges
+  - "#interrupt-cells"
+  - interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pci@ed931000 {
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


