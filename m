Return-Path: <linux-pci+bounces-21617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D6BA38440
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 14:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB0F3B77E1
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDEA21D590;
	Mon, 17 Feb 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G2ZeHnKd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34021D001;
	Mon, 17 Feb 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797728; cv=fail; b=AioD0BCzjkXOA6KG6TL3kDoIY+ijj25metNJqcychQ938Fq1X99Vl0Gn/qexdc6Tb3nAFo8lIfoHYyzkK+lScVX8QDkWcKCQfHu3KKAWskkZAkMXhfdRLOfzdwYuq20n5MCWeUeGl1CLIqH+olBv3sVXFKoksFslpwcDA44S8tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797728; c=relaxed/simple;
	bh=TjWv0MVEEz5NbFpXIWehPZRLXkDOudJ7luycns4pZNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8sJrzL6AZrMS6Kea0AJr7A0XDA4hpOgX2YwgtSfHS+W/PL3/QJzf5H6x25Hwjpcd9Ekf7FrSBDzlO/GQ15tvhEMh9RLR8i/7GDrd3c9oh9INtdj9iJzgIw46BuDgOkZtE7qH2R9yOlz/huyXKwu8W3Ipan8RgNbpCOMmbb9588=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G2ZeHnKd; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUhTycLTAAWOVXPacBR2kTj4eOyc8hiI3IjWjVZ5eVeoc1iA8x6Jvxy47mJrdfvHB/lr2PftD8k7cpe46ODx5KPsDhVd9vD5Glq7rwdM+iULDPwYdF6yhrnqaWu1LESYUcxGv97bvfJFKmTDXKvPa/e2E/8GhxKrg3fZYOJzf6sVfExN2qxYcUL4q1OFVlqijglAEAgQWly3LMZ210iMH33IaNA0taH+E88Zv93TYqyrLgH/RUNPvj6ju821+akgjBWZrQt1Zip+ZoPB4wCxnFrSTG8Jxwg6xouK6OTwWipCn11P2co/54I7BCDmSi6rlY6mbB24jw+m8P9LeogpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTcKwhsgr/GxrfH8rscGdP+OeiAvAa9unSBQEa2MC/o=;
 b=bBag2wpp2iZv9DscunSmsDSXJdVG/rgNoErTs15nUk2nkhmfuBvzYsGo/lYsWsCE9E2WB62bIw/OlKNMs5JhhaQY4tJWEb+131swFQd6Fmph3LMPKUcI5zgyw7lceOpvqj3LiAWrj2qgb1y7UKhPnqP6yEk2UqIwRDUqdC7s+ErH2+0bx/gwCJMMgP17XGCwnzm9AL2F9ZEMzznx+xF537gHonbS4enMv+Ar7v/lQMubtHa43CZNZl34LcH3qSVYDBaYSHEAL0wcpXDq0UVbgB/wg6aEDi1gVtTRuhhqhMcTZ3INBX6C7eO64cNq8vktg9in4DYVwHq+cd9GyEszqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTcKwhsgr/GxrfH8rscGdP+OeiAvAa9unSBQEa2MC/o=;
 b=G2ZeHnKdxt5E2toknJeJmRTGUr+AG+VrZ9z8Zfm41kpRnDroK9S1ZZFrF8rNbuj1wJjDc2mBIlWuc3h8EvuXs25aYe3CYPbZskhhKhM/Rvkb/Tfeuyx+azBfA91SlD5Ym1x7R69Y7VNpNEqnUfOK4qlzTZXaVt2bY381GWmGlDM=
Received: from BYAPR11CA0105.namprd11.prod.outlook.com (2603:10b6:a03:f4::46)
 by BN7PPF915F74166.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 13:08:43 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::69) by BYAPR11CA0105.outlook.office365.com
 (2603:10b6:a03:f4::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Mon,
 17 Feb 2025 13:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 13:08:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 07:08:42 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Feb 2025 07:08:38 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v11 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Mon, 17 Feb 2025 18:38:27 +0530
Message-ID: <20250217130828.663816-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217130828.663816-1-thippeswamy.havalige@amd.com>
References: <20250217130828.663816-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: 5855fe05-b0f0-45b6-7958-08dd4f54349c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2sE+2t5aJmq4y4Ssk/kkNdgqbeo/V1CtErzSS3hOgIdpae6aO2cAVGt8MZUA?=
 =?us-ascii?Q?mSOl0XDo02YhSo2BZCmjlThedN3MTxhnOpsOvdrRXKhZjgjJkjJFkMMLEOfv?=
 =?us-ascii?Q?p888RGpCYWw4ky2VmiqLaNz3ygIHbmS1Br4g1jIJxiK1nZEGUDDOBiZb+YZ0?=
 =?us-ascii?Q?sqac7O0B9VHIIshq7bpC/juADGoEpHTsPZPPshtqUVYs4bKvwH8JLVVRvquP?=
 =?us-ascii?Q?gdl0l9DaEGF/ItbyaHBiBUR2Ev5bWAFEO08pmgp2XYjQe+16R7QLnGIBMGhv?=
 =?us-ascii?Q?NrsLWD5kOTvgAqCQ3uAEhN8QxwA0flkUx6hIGn7z4/tgInKWhdSN+LMXOQW2?=
 =?us-ascii?Q?MpRZ/84FXsmcA7L/rHreSDpyIorpkQqJmyzoeFkgZtVwUGTzyasfNoEAB9bg?=
 =?us-ascii?Q?SVI2Qm4LbPL0H6CAYyIuOyqsZ5uKuLuQOVVWM55sopolkDgTT2IGkJU5QLz1?=
 =?us-ascii?Q?5yJc2I5WC6VbpnGkBuefg1WkG7DU03RvXwrfv1GhDD5zT8/VbGNndDgraTFP?=
 =?us-ascii?Q?Dq3MkX88z/E27nHoxbu1HiuTxrMPClablmDiovAxtsCnYC6x9jrTJWR5dQQr?=
 =?us-ascii?Q?HdOiwe0Znf9Taqr6JV2QNvQZllpM8ptKl/9hsUIw5jgxY2J0ZzyrtZrQrQna?=
 =?us-ascii?Q?O/H44RoywnFiFZ1C1euLPeKdMv6w99vyIBHTQvrls/AVxvC2X1hRC9sYgoD2?=
 =?us-ascii?Q?iqqDVi+7XA640vV/zqENVJYVyZV1wpba+QA4YerSInTpG4Z3YDVcmuH4nIgV?=
 =?us-ascii?Q?MDJpzNU3DkFvntI25TEXEBxXex6PxOpEnMLlO7KAcltdXjZIaNFlTaDapQDN?=
 =?us-ascii?Q?IhUUhIOKAijJ1DdWOZ1SdIiwQ7yMF6QTeUOJjNrkUcrY6qm2FWDNRvRQN3XD?=
 =?us-ascii?Q?9JrsBysaNElUM1sO+HYTE1qjzoJzMUSLM1WAIyOQjZH8+hmfERthbGEjN9JI?=
 =?us-ascii?Q?vjV6HBLPjWW8y30fT4XeKYiSt0ysm8pN5YQ+qCh38acZPmnvlsJB4gToQq2B?=
 =?us-ascii?Q?PgKXBQzTSkjnwyGCdXz8xCtk61xnNNGCMdd+OcbkMukIU1Dll788V1m0gxGf?=
 =?us-ascii?Q?SffWw427G9SzO6/ohek+bWSKHDn/A+FZB7clivC+uT4anfVAEqqvJkmbS4Db?=
 =?us-ascii?Q?fJsUyxMyWiFRSDA32qUtRt62p8IO+C35ZzUzXJ074ZlbiNE2HPI977mNPh1U?=
 =?us-ascii?Q?gWRmh4IMlp3tNjTDn60+ZJS3l0wdWpMXeTGzfb3sSLme+rTF3no2ImnKwpGv?=
 =?us-ascii?Q?l0RfKIxn4VqpjtXCHuxfCOnJBFh5nZT4E5XvzYNuKYq5Nml/p35EpKFz/05S?=
 =?us-ascii?Q?JY/y5vsAR/D2gBoNJbNbvZxddxURWotIZDGe1Kvmgb5xU2azDMXDdLMk0Nrt?=
 =?us-ascii?Q?r8JE7gGjHAld/bA/4irxr7ZSkjwXUdAgVNMXh9NAroinCT2HNpEtVG2kOtfv?=
 =?us-ascii?Q?vYP1JNfgnQDNymLs3hm4dryVKlnu3zy3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:08:43.3433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5855fe05-b0f0-45b6-7958-08dd4f54349c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166

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


