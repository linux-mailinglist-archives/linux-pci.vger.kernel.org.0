Return-Path: <linux-pci+bounces-17413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1CD9DA794
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 13:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0CC3B27896
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EFE1F9F5B;
	Wed, 27 Nov 2024 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gK9A4QZ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF831F9F55;
	Wed, 27 Nov 2024 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708716; cv=fail; b=iWf9IH4tWRt3GA3coIyCeg100HVhVSuiNL2JMyKGUpAanKTR8ly21/Ckyfl5iYivksAbG7DBP4MUX+1dWkMDbCisbQuiq+ep9KM9gnWLM9hB8tABst0kxE3Gk7MflZGbj7a3WvTLTCaNbVKSaZrrhKbw6N/ksVWqyG8+Y/7Zqvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708716; c=relaxed/simple;
	bh=jwS9mzUlkGvsiWE5FNNlrsUdxe37R21aUAn6EJDwNOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYG5+wWn1xgkv2LGKX8iaocZZyw3VZY3ZcPEVYJhpfbpyopYUDKGZGlmROuDFnZs7HlNHsvc4iN1fURcR4dPVQ091hPSrTtWuQU0uMsHGeumT6NskI6mjFSWStD+Z0WTC4T72RKpUMQEH4tkWYbQqECVy6RXXnHUysVLwmxv3HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gK9A4QZ9; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQ2gRwhOVmke0mX9hUVOtDPz589CCjg3hXhzdbLRlS4TS883eY7dCiaav+hQeacIbPSMKa/iA4crJgPBhHu0iXlTqf/qeprVbPrXYNrheHvcZZa+jDEElBsvK/W5UaNDrAAvsrpI4FhDGm9u6fSDLvDUWqcbgg5VcDqiwU689RZ+yL3VJ0rn5hGlaYwYNczk9bn4BLi2oYOcNgK85bQ2y5UCarMnvyijn3ecSdB9FcAv+NLaxP0yF99k3ABQ6xOU0KGu544ZrCaRm4MlRc63sg55ued6NlIIYd1vfJyzwTKIwh1FzwA43otsjOcsp9KJ9p/F66Vtr6EcCHanjRIzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ub3tY+I5sj4+4UXsyu63PWci1obvywN0MsvHBGPOCFE=;
 b=xCegqHtHelyqRp/nGIzhLQoL5+AOZLmk7dcTC2GE8CrKURLubTTA9bIqmNR6gaNCHHZY4ovopfHxQ1XbC3+XtrhNr37FN8ZDMRJtzF5BJMVLra4IBWd8UY7MYwv1uyavC7ATysTpq7i2PiTn9u/BHc/EV0ts2lpo0o+m3JwTYs94z8qmlqrFraDeFPVbnnwEz0N7cdFB/4dqXNZDofW0vByb9jCXo7FyiwhIutjEijpdf48NMEsgehrRz2L1twSWjiyjRAJ1wFgys8WwwweTf1f5wfhlK8nsnnB10+PK3cKRhl6qc2/LVNpYeXcddRsyaus0zqzlTn3C3FhmcAgT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ub3tY+I5sj4+4UXsyu63PWci1obvywN0MsvHBGPOCFE=;
 b=gK9A4QZ9VHLe7ex5jz6yVItGYZ0ds/6U7yRgHqfJvrtlm9oFA2o/1pr7cvtaSjMR22IbovgfasqmtzaZi1LGxMS/WxK7MhSz/WzHcu7ywsnJH1gDJ+J+ECNecVYFdJ/l2FRXJ8JQim0Il0Db9WbhtBaZc27aO7QXEgZLQ7+4cHI=
Received: from BYAPR01CA0042.prod.exchangelabs.com (2603:10b6:a03:94::19) by
 PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Wed, 27 Nov
 2024 11:58:30 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:94:cafe::d9) by BYAPR01CA0042.outlook.office365.com
 (2603:10b6:a03:94::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend Transport; Wed,
 27 Nov 2024 11:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 11:58:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Nov
 2024 05:58:29 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 27 Nov 2024 05:58:25 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH 1/2] dt-bindings: PCI: amd-mdb: Add YAML schemas for AMD Versal2 MDB PCIe Root Port Bridge
Date: Wed, 27 Nov 2024 17:28:03 +0530
Message-ID: <20241127115804.2046576-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127115804.2046576-1-thippeswamy.havalige@amd.com>
References: <20241127115804.2046576-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: d99d1c63-97a8-4e59-9be6-08dd0edacfa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ih6ByydSGp7jzM+QPZjyyd0zgWBWFEBc6q1Q3WmEVli4flYXvlJH4+8Rfqd+?=
 =?us-ascii?Q?M97YtEwDwVN/ItAzwKkJTzeuP4+hT42ScYQIxNxww+ywSm+UWRgPAxJjB/2C?=
 =?us-ascii?Q?eXjVYlzfTIZBa5yTL1PpQvroEPzMVDjwEQ0+FAAyat52ucSug1MDDYuBbcbC?=
 =?us-ascii?Q?PelqfqtqtM9nksP6EN6l4otIPSoQnSWvgaHR36t1E8uVPFFMUb2IlI7akEs2?=
 =?us-ascii?Q?zQAqfle5xnR9MzCymODGaGE1rf8zNuff4aWc4ykV+mFLy2j3FJB0CQOdXZ9b?=
 =?us-ascii?Q?WcCO0Bdkj08HPTYMnmrkw/iRZ2ckUfGAVKqDOxYdGcgo1ZQUv4paBmLkFaQ6?=
 =?us-ascii?Q?Z8KrlEc5ptST4iLv9IRYVRT7RtxDT6hT5z3KlISNmKBA7gPTZVDXc7qgNpr0?=
 =?us-ascii?Q?a42G5xJ0DJ3a1VXRbIIgVYfGThAI/U21Aq0WcZxSVkYfRLdcG18owKQCyiyC?=
 =?us-ascii?Q?BdTYt2V5wK3EPic2ngNOe+WFnaMNCHG6D5IRBoywqCKAPIYGWWtOIBfoA9Ra?=
 =?us-ascii?Q?Cm4Bh+7Qkf7Wjpp1bjKUOENgUStSkpSDCCAbAwMEoQiY6KHQmX5lQjLPi6Lu?=
 =?us-ascii?Q?axUvEFRLGv2DLA4MD87W7qbeJN1ntS7ulnLclu/k6YuhJRVnDgDUrDEEd6CC?=
 =?us-ascii?Q?4dBB39lrVsYumbYlUdufOS0MM9WxAUl/4II87GebL3h741cz9n5YF3xS56wL?=
 =?us-ascii?Q?3BPKWtPhoVQHp5Bfk34mEOioZJXOzyF0iBZkK0fk/bqzi7fJgzuAEXDyZN+a?=
 =?us-ascii?Q?aW4fBGyzFa4DyB7dmtQl68vYWPU+z5VfKSxQnQ/faz+T7mIX2RoS+/E8OXe+?=
 =?us-ascii?Q?qoMo7uBv5p8mvOiLYrmRHNR6w8WlS7QNCbwTJlmTNUbcuq/wSf+Sku1CowE/?=
 =?us-ascii?Q?92bwAKjCIyV1oWnsu9JYYpTSZRo9nkdVJGcDnwDsmiSZ+l3Q45ZBCIJDAiA9?=
 =?us-ascii?Q?ME7tTWaf5+CxWHtF5kYhPC1/ahuakbCcWcpyl+w42q77QLKO3E0tI+y7pJpO?=
 =?us-ascii?Q?7w6Ejzxs/hxz9BY90wLgYXZYdhqnwvbjmqrYyJtfZ/sk2fUV+MPrsB0+3QtC?=
 =?us-ascii?Q?bIQBeNQUphGNJHw6mZWbPaI707CezdluE47u7+06+QNVL2Paa+4iE28qBLZh?=
 =?us-ascii?Q?dP8vh1MGBlg8z/LyrwdgK7oQl2VunLcLkAObcl3ewnfEo2T7ussGBNKTQslI?=
 =?us-ascii?Q?T/Tmr4qZNgiQ7DH2X3ySKLfmWv/lto4/3f+TC57ghJmFNDpy8Qw140LaEhx1?=
 =?us-ascii?Q?ACD3zSa2IGMGEXT8H88GxpGZ1nbU53rw1HMARRuTvvzMdKA0gLXI2brZp8Pd?=
 =?us-ascii?Q?9RlZ2dynA8fP9JHC+rjEm9Lo3zItruuiIPaq1PM8VS+kIZqmVQwc1N/fulzf?=
 =?us-ascii?Q?PeF90CqjcWEHzbmPxLaT/fC0b4KGmwKjqbkvxBFmg7hzPjxJtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 11:58:30.4156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99d1c63-97a8-4e59-9be6-08dd0edacfa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789

Add YAML dtschemas of AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root
Port Bridge dt binding.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 .../devicetree/bindings/pci/amd,mdb-pcie.yaml | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,mdb-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/amd,mdb-pcie.yaml b/Documentation/devicetree/bindings/pci/amd,mdb-pcie.yaml
new file mode 100644
index 000000000000..ad9e447e87f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/amd,mdb-pcie.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/amd,mdb-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD versal2 MDB(Multimedia DMA Bridge) Host Controller device tree
+
+maintainers:
+  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
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
+  device_type:
+    const: pci
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
+    description: Interrupt controller node for handling legacy PCI interrupts.
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
+            interrupts = <0 198 4>;
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
+                    #address-cells = <0>;
+                    #interrupt-cells = <1>;
+                    interrupt-controller;
+           };
+        };
+    };
-- 
2.34.1


