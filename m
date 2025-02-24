Return-Path: <linux-pci+bounces-22160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7E1A4164F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE027A2D99
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24809241672;
	Mon, 24 Feb 2025 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kVtKid7F"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886524061F;
	Mon, 24 Feb 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740382302; cv=fail; b=Ikxz3H8Ox8wEenCXRM9oCvQfl6PYhu5i5HoAWbUqxo+CxIGM4AIGzjjyn182/+4p2YvrzF0PbuCa0JfNHnW2/a25cTUm0RxHq8nNKNU2WllvoS7WqES6f7ScUSA/5XGegR6Mni0ZZC/9jNViSJO8eu4BgzrRolatr8bDJEwOvfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740382302; c=relaxed/simple;
	bh=R597xJ+pgPfzNxOlGI7DxKuYBxZQteymn4j9XIVkAZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ohj8HRXjLImHppBLB7GnKpNOwrSIiJCF+AhYYhjiNtU+YdiiHwVctT8YlKs8Vutdph5gi60NV5NygziC9R1MS+EUGrUynXYj0H23ii0nqJ7cGmRfIhR4LFyReYhNT+khFDZrtqmSO0F7JptZanZ0UMxceo2YhUR5as8rB/XdF/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kVtKid7F; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/p4iqEftXgqb67wCAO4PYid3UYCNVAPiDBs6da6Fv8o6ESKYkTRiHFHZ8tNJVf4E9CtEaXNQLZFmPKr2LQO5DJWn7TR7/4zQX3dDvPAvQMlP7ej6OWHJCOUcm33siM1uhFsxgmgsRH42HBJiHdhjCU6jGVAfEZJkPwlg4z0o3kOvdHmCw2xxOHhZFR1WxQV8ilaJ1EK13tfdWyZqNZwBqUyr6w/5T5fMjWHyRCHEkLHyu2phHS2QVlXNbSwbSIcucvB8eVpR8OAmsxIvP5YVBJirlzIb35hE/Eegiq/e4QOh8k5od8rUe1P2VEFsEABmUozTIxQl/XPuwCa1H6k5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW0UonjTJp6wJ+9lnxQLef2iZrLtyk6ESOFSNdhKweM=;
 b=Qh7RiEh6XpZF2rXSrt/qNnf1VFeE9nTMXkA6OkjfwP6b3I3v3EOI/5oD9nPftAWctnJZOg/m1xFh+Owt8j9tW5YggoIvZkASbSfid6YyhqO6PDPtZukgpisItQbmErroRrf3+nCihItYOFFFaVr71J6a4icbLs+RM3RN9uH0kvtA+nPsf7nDZs/TaFz6nSwkL0Z/x5erTP2kBicxSB3fHKCIfZHDMhz9HZlW0YEr6o61zgerFTBhv6oMLuK4GxeO1Mx/cNa+Xs91IkoKs6Ol+/XgdomRxtidIwX9HlHv+zX+HvsHfJHmri6AUBwLQ4oImAOp2UEDnpv3SHs7DzAyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW0UonjTJp6wJ+9lnxQLef2iZrLtyk6ESOFSNdhKweM=;
 b=kVtKid7FZgBcxh4IECYK8KJ9aU7urLmkVTeFB/80NBHY5zykACfUh/AUZogv1+m4DTaT5WnCW+EeIZtJtzWchj0KKHHztu40GdpTExAEO64LxPk6RM4ks5ekAMTTZwCD2DDv05l5INGYCIGw5njr8Pb2RlDwiePGyWYlFn+P0VI=
Received: from CH2PR05CA0071.namprd05.prod.outlook.com (2603:10b6:610:38::48)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 07:31:32 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::8e) by CH2PR05CA0071.outlook.office365.com
 (2603:10b6:610:38::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.14 via Frontend Transport; Mon,
 24 Feb 2025 07:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 24 Feb 2025 07:31:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 01:31:32 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 01:31:28 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v14 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Mon, 24 Feb 2025 13:01:16 +0530
Message-ID: <20250224073117.767210-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224073117.767210-1-thippeswamy.havalige@amd.com>
References: <20250224073117.767210-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 684a5bef-6a2e-4e49-830f-08dd54a5430b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z9Z2bbDy8y/7Z1JvVK25IUhOlX75Pra3GSmhtAYVWRz1PIsgBDExUnZgqWDS?=
 =?us-ascii?Q?dXluP2xzLlqEM2z3W9Pk/jJ1WgOmrv3TTw3H9Tp5hoksuUM//Mgw+c+/pqbP?=
 =?us-ascii?Q?NS6D6EWHsmcMYdvP9th+JtTncBJM1X1dmzqglLWulcdPslKOyAE5Qqfd0x5y?=
 =?us-ascii?Q?iTKGv+3MFN80aYUdyBItXgQizsyTioyNcAfsf4XrTRqi+cd8lENkdnDVwj7r?=
 =?us-ascii?Q?wLmhCDs73G1e8Gkmmdz4G0JAR2XRYtqgmCwbcLNWZO6/phrGHb/sQa4hDY/d?=
 =?us-ascii?Q?iIySyzgvB9Rkp7VDAhz03hHSH+jfOovWr1NXT9EOiuMS7/IKbWMx1vwZIufg?=
 =?us-ascii?Q?Gif6MzZXCupNGso03tH3kHF0qE3ZnGG8thdDsPibb3ppqW+SMlHJuFLuKqdp?=
 =?us-ascii?Q?p8C45GpVCz9bC/6S47FLV9YENt09kJYw0p0BzW41HArCvusH6iar8wc/vt1G?=
 =?us-ascii?Q?FTsqKDCZxUXBXYYioWBcTl0YgUEsB3U9mUVXkB7uoTTxgfgfVMtEKb9Rk4yX?=
 =?us-ascii?Q?jnKq2QN5CPPTgheIibcne2l76FfkmKGMJue98N9ZbP/6La4pEQsLLRysn8Ii?=
 =?us-ascii?Q?QbTOtOkcTPnwguRicgxV2j2ifGMIJKZ2AD4DlXtga2jXCFLXARtd9B7sezVV?=
 =?us-ascii?Q?nfEKyWbHH9OAVB80gilnYErqFtGV0WO/z8FQ5fTo2NL0NmgoCuNPuiPPcIit?=
 =?us-ascii?Q?dra64rJ0YFTZ9BitqSz2JOrrB88NSKu/tOAhTbLHD5mLBPMFKPoBTOc0rXUw?=
 =?us-ascii?Q?84mMxy4qd2maTv4xgppvH0KtL1QXu9iTaMo1aJUUFPEv7Y3ukZjBVw0CkiTW?=
 =?us-ascii?Q?7GexZjGhNBY5B/X6n5jmbIN0pd3DLdy9k1czRWa2Ekjy1ARTpBXnllDXlNiU?=
 =?us-ascii?Q?SS2MAWxyt4SSWB0zHnVqZ5fIvE8atcY7uhOQaBhvATEUjEfBa6Ic+x+wqSB+?=
 =?us-ascii?Q?4rtooYLjKKH7PnVUK9f3meA/w1AFhnpognDMpV53zSRoW3iy9AdUY0Gv968s?=
 =?us-ascii?Q?3/h1DCx4cnLw/MBxv7iNNf7Scy6PxC6qHylgkAPtCc0zWazYY4xkm1BabV6G?=
 =?us-ascii?Q?plzXj3p43dZs63kJ5DGegC885x/2WDSDW99NCnHHjofepch0ssHnnZyu9IxF?=
 =?us-ascii?Q?ym26eKmd8kMTHbokiLON2uWpJD5BzdxCDVkxp6px6++OGRowm9DLeFiO5yxy?=
 =?us-ascii?Q?sIH3OGPkIvZb4dz5VDcFtj90tg8cE0MAXtqsI5kUN8NWt+SLfM5446pMNyK8?=
 =?us-ascii?Q?bCWZL4EC13quVTynJjAuo6JxIve9SeDMHRbn70xQDF0lRehXsitvgYahREH1?=
 =?us-ascii?Q?nls1iqYvnFrPWd6wrXHLS2N3FF6iEmhHR+CP+fYwy6wAqOtOqQGZvaMriGkW?=
 =?us-ascii?Q?dR+tCXhbwBXghGZat4a+lMyIzjutpfaqzIkbmPEKhg+Ik2WlZ1Pqmh/ka9Pp?=
 =?us-ascii?Q?Fg8SABKlJk2E/Yq61X2wNT8lmnzBlq86?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 07:31:32.6862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 684a5bef-6a2e-4e49-830f-08dd54a5430b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478

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


