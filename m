Return-Path: <linux-pci+bounces-20530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8904A21C53
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 12:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E13F3A6394
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F8A1D8E10;
	Wed, 29 Jan 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HDj+bvjb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B51D63CC;
	Wed, 29 Jan 2025 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738150252; cv=fail; b=rbouzBQ7BG3mlOR5w+h1SO2QMZNJ8T4hn2DOjrvOuiMegmnWlqSXN/RKRzwfwaNUEMHRd1iU1oZ+Om8Q8eX9g5gIeYvG20kTgVnY9n+boZxqdLt9xThPTegVfVzHi9gYIWu42yeuYu3UC/5rSzESlVZH8s8pEPmU2oJGQVVNcz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738150252; c=relaxed/simple;
	bh=WL/SYz3rZ7wt8GmTDecbLF2g5rcMBVR6n4aK/dHIj+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XD86OwWzU6FhdGrsPxDD3xKGbOth/idtm5mKUAXWk3fXOvIzMMIwieM9YRDEAYGa+uqjtXQX7bdWdnSeY1JE9Y7/WjgKx8DsHmfN319JFvj/LxWd/1R9KMt/a2Bdwgkt1FPxU/uRrkwdhXmzajmqD1G8UfmAdhwn9yHn1AjUbs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HDj+bvjb; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtPPQb10vjVriMFGSs4/zjGtimVFbPlb6u3xeKX8KlbQSyadcLY0OhdSLppYXoZUD4Xva3R2cGnZq8DR8syhBwjjx3yksjddYOdOjZqBFVecmA+NQ94bzOTWZF7e0b9Q5viUNhhmpJQ7xMDdsQrC8J0PIAZQ6ZLO1rlY1HbD7HPwKnHiTrQZOOzPq26z8puNulU7klFjCrj8wu93Q7ypcf7D2lkv64/aQFrHha9kc/ZGLSYRSubQXta12F7tu54GfMV6LuCCWNW4VsrlwD+eZfdS/50uv8IUFxlgFiL37jGD23Tu045cXlnYwxdt05d382+pGxekVS6lOSxvfZy1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVLDwR5+5d/FVr/wQL5UUiKjvcRDZqSUSQ1TJtlZEZM=;
 b=qrZ3hH+Femyp7Gt0/Bn/lp23acDm3fJR192Lm7joV4LR8JNXz8urujOGbDFrU8BK+WVsliqtQUG0gI3Oc+Bl20b7qnm6LKZshp852DZSVCScTV/ihOD179BR54BrA8DdjZgZR28OauvCeBU/TpfcE8JMPpKzEE9Q4yaXi5DNoMvbQOWByJk15l1iTn7NCtUoocIkS+wx7gzXyMPywQo9UWwd9kvAOYiF47wuwMrxkZnkiAfTMjo9zqL4tYHK6R4nDFjReH0SBPh+mqezXEpDQ9rywuj6IoEdGF5tSjFc4uWrmnwX0gopVzrnaz3CcZ6ZZFJhLJcjGTsuXzwFQ3m30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVLDwR5+5d/FVr/wQL5UUiKjvcRDZqSUSQ1TJtlZEZM=;
 b=HDj+bvjbqMKKrkyaEfSW5q33A4MRAesJF31Yi64LboazAXfheGcUewFPAiFrWzJvrA7ZbpUbgfPCc7SUWLVz2M8ZfVuK2Ni+cs/MizNIARQOga/T4ets7qKvuCgwXhUgEBAJ7hzr4ZNZfaK76IB0QtMbN8YP0+dEF56WnvwwpFU=
Received: from BN8PR15CA0016.namprd15.prod.outlook.com (2603:10b6:408:c0::29)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 11:30:47 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::19) by BN8PR15CA0016.outlook.office365.com
 (2603:10b6:408:c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Wed,
 29 Jan 2025 11:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 11:30:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Jan
 2025 05:30:46 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 29 Jan 2025 05:30:43 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v8 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Wed, 29 Jan 2025 17:00:28 +0530
Message-ID: <20250129113029.64841-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250129113029.64841-1-thippeswamy.havalige@amd.com>
References: <20250129113029.64841-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d418e3-19e8-464d-b9c2-08dd4058601d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0C5Hei0P/pzxvi/1KhzCt0YSUwU0hA8gd8a+H+PX838zXIf4W5v/3ztaQSpr?=
 =?us-ascii?Q?vBwRBEIW1+jhvWfwwsv45gVNO6oZSHtY5v2am2c83IYqGcm5qdVJpPkzLCCM?=
 =?us-ascii?Q?NftLF6CwzTI4ok8cfai2ZDuvM9azbX8FajOh+TekYF1R8Y45bR7uwQ+TCExe?=
 =?us-ascii?Q?XhgV17lyuJuQzu4hFOSjlhZVmKsGwLOmFkhFluxFlWKYGTKklWynfa4naRKo?=
 =?us-ascii?Q?cfx4gR8EcY8QhGIrwjPBK9Fu7QcAuIRhIru2aoPw8pkPnNWdSVKgkmWbFeQQ?=
 =?us-ascii?Q?GDJwzJwAJKhemz9uTLbyctAy48+ZYYXwqs0dno7Bn97izokpDWTzUL6lT057?=
 =?us-ascii?Q?WIwmggQ4lpwxYhjXrMnOXytmWyk0gduKIDTtTmVIjmnoiR10zpaG7hShuvpG?=
 =?us-ascii?Q?jIrEBkcTSx91Iu5uIdgNB9R7FkOARLdqes05WyaB/uyX2iwCQHUym1gu5TPO?=
 =?us-ascii?Q?VToLh4IFzhzu/YxHilzpMl6ocnqVH/aBe7aw4MPKQFtEH+hg3ZQHkIoExarU?=
 =?us-ascii?Q?bwLXI9qdeA+HoJ6hByZEkFd4rFo2GuKq7wxVmOssIL5XE8OsNtY3ba+VBhLu?=
 =?us-ascii?Q?mIEsonPcbX2QRe7LG7flzTnYb+XaiajzDSqiLeCSk6avq7g3GSPtmVBc0zWk?=
 =?us-ascii?Q?8GjcvHSiDtDKHLOKXAl/XTUJ23Om5lQJ9AIYoL+U0XTq5m3gciMBCv1MlJtx?=
 =?us-ascii?Q?YEzwFydt7pTRBb6zg/xHvJXh8nRVLBPhi9EbJXonphV2hc+G9KKWca7OGnb1?=
 =?us-ascii?Q?BFZkM7hl3gl6QGVHQbyuIV5pJ9Bl32FzQX7ILn4jMaqBOsTerM9FT6oI84nJ?=
 =?us-ascii?Q?ORbSZeL5A1ZGjthzy+os3dZvWB+DjNQNq8YLGfX+Y4Kvju7XieK84yUBqTuG?=
 =?us-ascii?Q?t+dQdvPCvLokb9/iCRwQVlWrgKCQsv1/4O81ruUb/InNc+ZvcHUMCVUUOC80?=
 =?us-ascii?Q?2dscMgPBDzzfWwQ//oFsoYRPSO7MahHGr7WDRzY0S3ArSOUbCQpRld690sBe?=
 =?us-ascii?Q?bvWqCOLG4Bbz6Ow10FnD29kWzrVFlCJG0YC6WNLJd7XNFcx17S6gDEEbo1oY?=
 =?us-ascii?Q?CjVaeo1oxcvIZZI2wSzS+YsHB89xEr6FF/gCiw7EeHVCpQtAoQ7qjuWvp/ep?=
 =?us-ascii?Q?WCMHIst0p35pG4NcN1XQHqZJaZoBsx642ki0k+MpJfA1pl98iKu+2HL4SLzG?=
 =?us-ascii?Q?yBkz0Zy8br7pTEI+rZ1+8RCKHq1MOhbAKtV1T0WkE5f4WoEdYoyjciQNi5cL?=
 =?us-ascii?Q?CiSAPOUY21GiV2RyF1mUT1Yg99Qkir0khl36q+1H2qxJMR9OhoT8M5RauPo1?=
 =?us-ascii?Q?FzcGYrEXZOJ83LbgfFYF0p57hGakpIeI/b9Ox9B9vJqsESD9w39RSSvpFdb+?=
 =?us-ascii?Q?aW8EIhzl38K4vs99PPhUUJFr+KQ0iYRJ836BXtK02a7WgwVdKUxGVZuebhV2?=
 =?us-ascii?Q?KRa4medztM81NUk7oAhnRdCNEsPy1hV7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:30:46.9557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d418e3-19e8-464d-b9c2-08dd4058601d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702

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
2.44.1


