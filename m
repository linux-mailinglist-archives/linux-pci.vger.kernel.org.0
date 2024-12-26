Return-Path: <linux-pci+bounces-19052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FE19FC8CB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 07:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5932A163224
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 06:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54FE17B50F;
	Thu, 26 Dec 2024 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Du3Q71Eg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E550170826;
	Thu, 26 Dec 2024 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735192931; cv=fail; b=hWk/FY1bSNvOEWdLpFz0ON2L9HAuv/F6+akI1NlFWuc4TtaAEVVVCCd1CqGSF2hWhCwgUVmNlh9gpOTSMQ8ZQNN9CIEg7OGR5H1k7Q6+UUOuhmLdw8aCdfGJOSGr71tEENyqZcjtErwe+Q2PZMOSVtK8CstjP0RKAkGiNKyj6pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735192931; c=relaxed/simple;
	bh=uc8RI+Ko9wjjna7DyKBrW8XxNxsqx+cwZbdd3aCtX2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2lTZdFK45VTi00f41eDtOW77kn3S3ZoVIJkdKqnahUtItLhBtP4enJpzJnBQV6elNs65G1hZVCRrUxZkrbWcsYnyXNay0/tFADCf6N9+Qor3uwIpQBV3rx4yP8KlvU7QRmWHbazlMb53dTwL20Jl6CHeDG8JnH5dk5tllsEFwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Du3Q71Eg; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk6Z1sLv0682fxWcV3lOHmifipYQha5QpCx+NJwHl/N4I4hGr0Pk2UFjO5mxVG2e19MJc76VDyslFBOePBhxfPP6K/iEcNNYSQ/5fT4TsGXeAC1rK/2VcbXlo33CprrKydL8ICuR/qkyPjgwOIwfGVY31JzWBipbHDlFQTQsnZc5QUJGzPWs8kVcVrS71o+vjvsHj9WT6Iiv5QToZ98rEvYt/jPZKJZ/a25zLh1Cwt+YgqFT/gIm2Y8ex8OYnhzPy7nCmNPkSXt4vMqWvDzEcBNd6nH0lp+AA0OFkfZOAvs2WE7GUjQOrrKnO9tkyMzDabYeKISk7uzDAsAqHB1akQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRR66r114yg/DlSm3APXf1AfMYF+OwkHBmjbcL1BK6E=;
 b=djfh4EQJwSYLu558ytimeIdmYcMbcWhhx9rjIQAh8v8D+FtiC0wDJ6exBMKFnNiJqWBGcAKvNWKiph0DAJROKmB+9zaGTZFZ7cAMA7E1y0ATdNzGOb2avCDnKZkQo+sc6bH5OGZEDwLGPPCh9AHP030t5Br9Mk20F+EDnUXv8l2nxRuLocFjTzk+ktmziW731DiMCx0KQRVB2yJ+NdEbaD0iNKCCFrddIW9P4fm+vHHG71upii0SJi5dsZ8pj6zOI2buzQ52GRXshOlRXr9o8/AHXewOaSb02GxIUmCWlqfhSZcjfKhFODi7ZLan65C0i28kP3B6AcPsjzpz03TlPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRR66r114yg/DlSm3APXf1AfMYF+OwkHBmjbcL1BK6E=;
 b=Du3Q71Eg1Fr2KIV5cnUDZT9/m8pNfG1TBJDIl88jqbWMtOutcVaTPDc04QQknT/H091bZ8C/dOjtV/bGr7B+WRTS1jUF/yW98J/DwR0VM/NW3BYNpYLPMZyuM0R4wdHt+nHt4gCATaAGtBhNcNi1K89hRDVjtxV9wDm1Kv5hHUk=
Received: from BL1PR13CA0338.namprd13.prod.outlook.com (2603:10b6:208:2c6::13)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Thu, 26 Dec
 2024 06:02:02 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::60) by BL1PR13CA0338.outlook.office365.com
 (2603:10b6:208:2c6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.14 via Frontend Transport; Thu,
 26 Dec 2024 06:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Thu, 26 Dec 2024 06:02:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Dec
 2024 00:02:01 -0600
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 26 Dec 2024 00:01:57 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v6 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Thu, 26 Dec 2024 11:30:42 +0530
Message-ID: <20241226060043.18280-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241226060043.18280-1-thippeswamy.havalige@amd.com>
References: <20241226060043.18280-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: bec0bfe3-5394-4b3e-174a-08dd2572d105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AlZU0gKBSuHlj0shh++xDkG+1jbGEylnvmmakxHBB+a0dN70r8iR6VUtstpG?=
 =?us-ascii?Q?IY656KVVLViuYXnc6pPD/foNlDhxqOu/Gfurd5VhmCbUfdEcqNDTi11yew7j?=
 =?us-ascii?Q?7F7WDkL4DdrNQuOobZgRcem8RMV3tnO27AqzPwV2qtHNnxvjQ5HrFNrzYoc5?=
 =?us-ascii?Q?npUxXSJd6NsBFspd7Cvxg1biIapl2/ukQW+2HeuRy19wAC7ZONgG3oiknyOf?=
 =?us-ascii?Q?mlbTkWJhz3m2b6QrsmArlBfuarSPOocegytIZ/8sU5vRvsVh+A6W1WB99q+U?=
 =?us-ascii?Q?Ln6VeVFyOaEns7spV6LOzKVxxQwWywk93n0Og9Hw36KWLtvCvv3BV3KMntuk?=
 =?us-ascii?Q?k1sgEV7R9cLc3/Rt4VHGL4CNtbgTbpoVw4BNjDRxDf2Uu+MuJxu9XVB4h4KK?=
 =?us-ascii?Q?RfL9k5W526+ivIb5rhDdm0/wvwj12ODsNZJ3Ea55nFavARldRWmGI7uwoZem?=
 =?us-ascii?Q?vZ0pV1ifML7CXZtul53bEiz8jfMo7PAPZ1wm5+qTa+lYdUFoIuRp5s0LG+ZU?=
 =?us-ascii?Q?wfwLpEkiLkny2znfgY86C6vGPDRBtJltTyFs5v1dkUTigw/Rk+rFtwVUtXeT?=
 =?us-ascii?Q?+oF9UI4IMqVp+1ytga11VDz/XEKPRRL4E7XkjC54oD5/N3/PX4lFNs1brxPK?=
 =?us-ascii?Q?VLNCLCCjuU2WcbLqjWN+1JdvqQVF4A5tuYxPea3Zk726Nl3rF6R9FDkFmch8?=
 =?us-ascii?Q?vHtuRZqauxag1aBFPMqSTNk/Sdb/FR9kRN5PADYli50iSxHtdqfDz6KU/5TN?=
 =?us-ascii?Q?ppGZjXQ+CvQczdHVPwga5hsKDaZKOlIXETpbYSwAiul1+PKGirEDMRObJ2go?=
 =?us-ascii?Q?odk3kwgT549hN8retcOG993y/4jr5JdiFo4U3YuoGAUgU1zbeFtAbTepTdKd?=
 =?us-ascii?Q?tt7K7qseAzTtVUBrZ9AH4/O4j4jgtpxCrHSgFoZ8cvToz7RPHr0/39vhf3l0?=
 =?us-ascii?Q?M3CQcOq1VitCKOKjwz+hzYTfM3KVn8nD5cTIgLb2W6DSDKR6TgwipB99YG9B?=
 =?us-ascii?Q?SxWOYi1EwAW2vOccTE9s2GGGjuYZjwPZxhTae3lC2b1lonkxgKQB+rREW2qD?=
 =?us-ascii?Q?PsnFuRksmACt3rzTGH4u12MVsrQ28qfI358eE9kiVYfo8zaFwqR+q4rAA/WH?=
 =?us-ascii?Q?wtPIKm/qqEPLz0vm1tokOAkGnKTg/Ci7fJj0fBxb5KCMS8Smqaqmrw0KugxP?=
 =?us-ascii?Q?+qeRU9GReoBjvklpNPfdD0LD1FgxhpzeQjtJic4XT4weZNPmRdQy2oKtGnDa?=
 =?us-ascii?Q?0+uKFJuD2Lh8mPlaNJtzQztp1IrhACUUV8QGla8KRb0ZsDmZ1aVE1jGGbWJg?=
 =?us-ascii?Q?4zg3DigALMyCl5jz/s7WqzKBmN7YcXlHyWJQrjsi86GVPzribiVr7x5gftBh?=
 =?us-ascii?Q?yKskaE2ED9sYhVGm4dzp+B8xCelmm1PUNLQXX9AwSrYIQhPDYNbqGr46nFf2?=
 =?us-ascii?Q?Y9Rlku/89mw6lD7/4tTwt7J4sp/mBYVD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 06:02:01.8968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec0bfe3-5394-4b3e-174a-08dd2572d105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717

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
 .../bindings/pci/amd,versal2-mdb-host.yaml         | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
new file mode 100644
index 0000000..db751a5
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
1.8.3.1


