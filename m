Return-Path: <linux-pci+bounces-22628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FF8A49533
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BAD172E66
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D084C257427;
	Fri, 28 Feb 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xp+WPD82"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01443256C8C;
	Fri, 28 Feb 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735306; cv=fail; b=Mg/lmI68Cay1ODnnXQBDa9cnJCXNjjMDG6dXB8vaDf5Yb74uPAjQu0hX2TIdvYvbx30J7Kq3F186FZvcz8XUcemle6VJGIp3Hv9MUSjeXK0x/scfpBE9yCQ0xYQxv4t1gYXdpa3ofUkP2iCS7qOqFYr+kJkByAnB0BWcn4H9AQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735306; c=relaxed/simple;
	bh=R597xJ+pgPfzNxOlGI7DxKuYBxZQteymn4j9XIVkAZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMT4kv5+ym8CL/UCyHsa+KVsfyGrI84Qn3e/gYlX6fMJNUQnYF0L7yAxxPn1qVbwd8B+yCodxwAUMDqPjPOWXE6P6JXPZpj5PB8+0QW34gB8HD5ZCstzMe8rvQcOs9SvKZm6e9N6Tmom7p9EEGg4tsHhLAojorIOFfevxAeqIYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xp+WPD82; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLCZ6TbNr++0XGoLp7IiriJQwoOnREO8dU8M1GLhOHwOjtZ3VkmVm29LFVUJzCsYqV2Gtd8vkhJ9GH1wmqmhSebOIt2FwuAqK6iVzSKc8YOaa1sKW7RTdJ3QRUHnULSrHiPjIW5PRDHxLnj4WJYNSqGhjDwqTbcbPLLWs/x0QBiQudNQIGbBJtyFsss1W8VuJdm80K7ZDZCjZQgWrUVrcyaHH1KRRg22iq3tAc5dx1nFs1qjf1Da8uFdEzxkcJuF7hVoZr0k9Z1amlBkeaYDXso5dkCvN/BYNI5FnQJL0Q0IZxh8iiiylGysEfeBbaypts8WCynJ716Crt0wAzmTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW0UonjTJp6wJ+9lnxQLef2iZrLtyk6ESOFSNdhKweM=;
 b=vtOUyD9PpuISYWsbqM0ypr/F2c9O8xsLIqXSikBP1/myMflWT6NLekA04G5q1VNNtZZYoiu1AOAdNED5ufgHfQ5/eB17nvPwXKFrGuBKMvXiiduJ5mxF2x2veNGsPYVz8v+eXWSc5N9+6gg/I69qKMEZ+A6nNsHRsDOIfDg/AOFACCvdike0qTh4F6duvzp4oldm5CtfNpjapMOt9byxXUj83xWjvm87Dv8PM766J59OURf3/A1+z5o54r0fyYrWRhN4OyTV7Oz2eUr00+7f43kbtXXSrcXCoBCxTPaqdFqhef9YPzvvMSDrxIRnQ2b/qTwNzy5CeFozs/WNpzAm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW0UonjTJp6wJ+9lnxQLef2iZrLtyk6ESOFSNdhKweM=;
 b=xp+WPD82Qa2S8tQEoBsfkKivB/+PfzGka8mRxDLpeI18EtL+1Ud86YUPHwDh9MXK6o6Wd9JRWvs9YSzgHEI7V0h59SSyJlDEHkTdifZY5SPWblRRBqtnV6bj7jSWU4YsoeBY3eKWlntK+SnvfxvPuSQnggSLneMrPHcXC6gSWMU=
Received: from BYAPR03CA0029.namprd03.prod.outlook.com (2603:10b6:a02:a8::42)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 09:35:00 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::1d) by BYAPR03CA0029.outlook.office365.com
 (2603:10b6:a02:a8::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 09:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:35:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:34:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:34:18 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 28 Feb 2025 03:34:15 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v15 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Fri, 28 Feb 2025 15:03:50 +0530
Message-ID: <20250228093351.923615-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228093351.923615-1-thippeswamy.havalige@amd.com>
References: <20250228093351.923615-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: cdaf0d0f-43c4-4fd1-4b8a-08dd57db2c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xldu5nPjQvyslDPCxBki7jeHaZiCtilxj3m+M3hRjwNeLI1Z6q88s7iXyOop?=
 =?us-ascii?Q?WUdgJIjc7tfo23R/FwJX+YtI/Na4cttkrOJciqggOWDYRTMGZ1wGoG148jVQ?=
 =?us-ascii?Q?TTT+k0B6YHN4e6lCybq0gcdoreuKu9lxB06NFLJqIj3LaoCHKkDWW5WwJZY+?=
 =?us-ascii?Q?4ycgPNj4UNjJpvuWk8CnfBE9r82qFF7x3n1qjiAvf32ibYyvaNrMxXesa6P0?=
 =?us-ascii?Q?YxGF+SUvsvXiMFn+YpHHvZ3Crr0HZcSe06mXuzTuaVYB4AlPNugiGvRVhlTD?=
 =?us-ascii?Q?oXakxi6QXrPzx3hjyUMoA8AI6r3cJQwzZE7oqVBP8OTS2OieZFP312jc1Qq4?=
 =?us-ascii?Q?EPdAiX+3WyuJbaziPlmC94vx2qYRhF9YRE2yYx6cLzXoq+XuGkAXvY6hsRaY?=
 =?us-ascii?Q?wxTtR2yBvzesQ/6BRsM/fC90PUKpmIrfmgvC3IDG3r1GCp6ZkRCeAqcURhnW?=
 =?us-ascii?Q?bZLRFLFlV9jwMuW8rCr2/ebDVOqvSPeQ7/noeW8o3xcANIzjcOuZiLSoatxD?=
 =?us-ascii?Q?TIjYBN+nbn/PaSwpCOPHbGHweDVqj3rk7O8BiSTveh8I0NMJQqjIYXQ0GRLD?=
 =?us-ascii?Q?182wdgC0GhCADosluymJ7phQJBObuwJu2AH4x4p8iHScQB6a6RSZHtE+ERjk?=
 =?us-ascii?Q?vE1k6+lv44y2dpGRv15QLzVCoGimN1riHbaJlEtJe9J7gtAat3uCsobm1zWJ?=
 =?us-ascii?Q?2s6+5/I5vpEh1W3q3f+6Rz/DL6C0UuvCrXKtg7bbrD9yNw8gePXAijtB5Jq0?=
 =?us-ascii?Q?oRLUz/75eSJFEigT5Y+WVR27QcrsvcZgVpgiHSUKUX01IvrF9LxUD65d6w2W?=
 =?us-ascii?Q?MDDimorocwxyt1QFqGHWL55VHjCmpiujfe2ibE8jPOhWjysL9qNOaegWWPpN?=
 =?us-ascii?Q?SC4etOIIEgypeh1PdAx41kpY71pP+YWip1v7VuktD4t9kFNlbVO18a27Lvoe?=
 =?us-ascii?Q?su03hZ4DmBNzh1keHorThgCnL2p4siff3EaCtXdAeNYXxXjTUZb5JCwNZDMJ?=
 =?us-ascii?Q?zpyz9P0I6qNZ6mOwqNPfbkV3yAjTLsDDK/WW17C8tNfrD7249JO7Ek/aUxG+?=
 =?us-ascii?Q?yoHs4HAzEWu/62iXoHyygfllP2PjiG23xu+6bO0BcJ1Pq5etdss0domOYHs2?=
 =?us-ascii?Q?3sCl824CogGyXKNKEgMqdNtefStWXiFqrhkTuYYz0bgd/avCX3hid+sksCuT?=
 =?us-ascii?Q?c7id9dZatepoXAlD2mFWO58h2HhlKZGe5TETALDi7qRpFTZk0j+94+3L1W65?=
 =?us-ascii?Q?3/dFRrLat8+nsRxFlaCU6CbzdoeTEeEYobVI/9vqugrfVn4VRic2PdekhGXn?=
 =?us-ascii?Q?CprEx5HCstbWF7bmda49Bs4WPmlMknonvGrQYFyxs91bNMhIj0paNgM+QUQX?=
 =?us-ascii?Q?Fc0nTqTclPYAaHwytRJlkBgJJzQr3kJu4V+AkUeWxkrhJWWojsUxAkO8qqm8?=
 =?us-ascii?Q?m1uOdedfcC5s/AHwifpVbZnqaHsyS1ex?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:35:00.4659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaf0d0f-43c4-4fd1-4b8a-08dd57db2c22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472

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


