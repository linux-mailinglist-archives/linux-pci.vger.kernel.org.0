Return-Path: <linux-pci+bounces-18353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A11069F04F4
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 07:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6E216A367
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 06:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607D18FC85;
	Fri, 13 Dec 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qZW1GkW0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4647918F2E2;
	Fri, 13 Dec 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072072; cv=fail; b=NGbm8FeeXJN4Tovvnkk72+/uxy4iuWLSJCdQublCS+4sYwqkNaDOvt1SI2fABkjLrxR6ZomzYPmgmp9vUd8qU4+VimxIQBjopQbsxYqzbAEmIqK4tAM5THVSvbSONkfb7Zt8lqrEWsJ4XJhvDTTkfbSSkOBS7immPDDE1pNoHxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072072; c=relaxed/simple;
	bh=xxdC4Q9AAUJEPWOKYprk8gqwOW9KgmxKki8LZGBxklQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDx6T1tbqX8svuVnyqhM4D7EjPUfAXtJnG9rv2wMkgHcCwqhmlVKL546ZLQjS6qSDwCDV3LD+UtUYey+T+j7A+vnyEarbbFEL/ipYbeq9R1H/lPZAQSbLrRQpWkUoTJna/gLaCmxrhN5DcazLasnxUt7ovPECOMUYyhemPdNalY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qZW1GkW0; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezgTb9SIz3zcKnq0j3OLHZ7qgLnUbV+OV7U3PP7uVY0Lj8lOcRyNYBKpCVJn421uzCB74Yl4ctqIHNFNJ2X/x7G24uXmUt1GK1rs/lQj+F1SVT5obod9lgD6qz6yS4r4pHXkNT5ETiGBChiEIX12E2qpiztHK+WvzqjTggA9DLywpSv3R3eHwgfyM8BvVFwMRKuQ8jGrngWXtE/ON2blV27ltPGNY0KL/1KEw6uKPod7LOZQBvy1yylZ8IMTKu0XNhSQ9tYNaUnseJ6HTI7BaQPiEPVUbx/vQuasY5hFVEnp4magdzvXdFuYOt54/KgrF0Jqfxkh3TQ2haHRFUewgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+maNLWcOujsuWHDrboOketdnYHTiNRR+5P+SD8ctvM=;
 b=n3NMdDNT9szpkE82/WGBpXx/7BVnqRRVttw4oYT4gTlSpvpaKl0NG3hMvngrkcDGjIFecFzHuxNDN8Sq8kyPgNBVIFrJOgg+2SWgKlr5XH4ZnjLW3iJQPXsjKJF3+i5+7MbYIoUSz8v9bJMxiTW+50m6QnmfZH1v6E0MCKMojffv2Sbxz9C+s4Z2Xh67hHcCFQZ1wdCJih6PQI5D/oBmDJosFtsvM2z/lLOjeDEnwr5JCNdq2dpooODYW8li1ZfradYKmf/3YENshsX0Udo7oho7kaYmtMMHpvYqEr57EqtdxKUZ/hxZYoKZ/MzylnVz0jRBTlK/lUbx6iOlWq/I9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+maNLWcOujsuWHDrboOketdnYHTiNRR+5P+SD8ctvM=;
 b=qZW1GkW043o9fSNp2lv5k0S3YU//3u686TQpkSmiRjtnghUL/P4ZtD3LIz8apOpRSSMuzSQmIP7yq5rLhV6tqhNvLOAx8XGx0gij+3UEVv+lRGNQ8gFCVe5rIWRXpM38gt2lXoAhVnRyoY09AFCUM/okkvnbkwGN/c1xbkNumC0=
Received: from BY3PR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:39b::27)
 by SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 06:41:03 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::7) by BY3PR05CA0052.outlook.office365.com
 (2603:10b6:a03:39b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.5 via Frontend Transport; Fri,
 13 Dec 2024 06:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 06:41:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 00:41:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 00:41:01 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 00:40:58 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [RESEND PATCH v5 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Fri, 13 Dec 2024 12:10:34 +0530
Message-ID: <20241213064035.1427811-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>
References: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 3946b691-11c5-4384-f189-08dd1b411cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K9TFQXhbdyQCDGjiF8a2DvMPB6eZjuhuy7noi0HGpWOjqADjQOAEFI7mzAhC?=
 =?us-ascii?Q?M4Rp8l1iOz4GmY5KQ2Q//2mSECN4uMNKTOk9vw983NJcsDB1v01jEc/yOyDo?=
 =?us-ascii?Q?RJDdV232YKArgAdc3Q8eYPVDcAr8TDQnNnMPDyjLsy+SjpcO4Gb6nv9va6kp?=
 =?us-ascii?Q?HfZtkRSVC8QSpz/C89xhsgDj179woibWIZ+x5Xip2aJPjn6Ly02T6QZ1sjch?=
 =?us-ascii?Q?KV+vl2D0+r82zrcPcLp6QkSUXFI+zgsYutYYBTrlp2JdOFWJEPJeZubqTX0G?=
 =?us-ascii?Q?xy2jpiVLp1xtHCjNDUdCQk8N1RL4TdVnxeBjMyZAObAN4ASldtx0Essb/3v8?=
 =?us-ascii?Q?A9T9NGXDWZ/p8QFIUsKV6bmTN3jj/5k2yGImeJ2ih0ZOKpjGl3AgHFcS8Asz?=
 =?us-ascii?Q?HqDVnGflMyQ4wjFFTocN3iFSihNiEH7z/sWrzuf+hMSVVH/cROQRQY82izZw?=
 =?us-ascii?Q?c7dKfdxWolCpR1SPEAq/alc3iXQxZ85uQtLb/EYB5nXWqxJrksTNyhcB0eFe?=
 =?us-ascii?Q?hMFG3RZUVMLU1jVek656oy1TSF6g/S1fe2G1QJ8CPd+4sCFWBRHQDWGX4MLD?=
 =?us-ascii?Q?PE+lgA2QuhgzB41iQ1/90n+EZySeVqNS/VDaiGrudY7RbZ3FzF4xyUn6atLZ?=
 =?us-ascii?Q?bfhzhqQz8zwPA4DnlZ1vc8hT938NDXbBXFw8toMk/DujZkQHR9V6LQ/1Ywzu?=
 =?us-ascii?Q?Lwh87UGbseZ1fLFD5OxU69mDfiJhQT6yI2B5CYtBcpmXfhddUHoEBNPyC/St?=
 =?us-ascii?Q?Kf58C/5NJHLL76tGgL5aLCjlovDrCVOU9FoB+44/JjnWHDTzzvB86S8SBjOz?=
 =?us-ascii?Q?uKYACdHIkUUMaewPH51GdJkvSriW3IJon6xoQZWDoh07nb1J981JbKmm07Jx?=
 =?us-ascii?Q?DKgoyyfMFpRqamaOfu/AXHAdU3hDhKlcJiQ0ySG28azVHdtxdt62VnDBNWUb?=
 =?us-ascii?Q?6s2yL0GQZblq+4RLNu2uzpTThEj3IOrlw0iV1rBFUc0Sq6PTDBVgYI6y3A/l?=
 =?us-ascii?Q?njgwSqO0AhLIXaMXJ3oyjRC8ucpT0STS5XZcLnvAfMS1X+xAj9CdzxAZ5EZF?=
 =?us-ascii?Q?9CaneYJP0NuV0UmlZ21yDAmJIZSX5hIEkuaQ7W76Ji7tZy3OvzKAZijYTku1?=
 =?us-ascii?Q?jJGrms+YovQ/8d2O946UZf94Jg0MV/vpXw6ELnE0NNs/5fHsUQInutzlPvqg?=
 =?us-ascii?Q?hQxaLdjLL5UT/JlCe58QUKPY9lMXOgYGd+2QBPAS1u/WlRqI+wuakh5sy+fA?=
 =?us-ascii?Q?bBRgXDc7zTJ85J1c0TVEc4uyfLzojvZhcsIUK4urtonuUDKA/BalvVTz2nEu?=
 =?us-ascii?Q?t1+STWzf/Z8yOP1Wx61HK7E0uwOWkwO9Z/7DIhwD2sI2S1QfUmhd8VwZHGt8?=
 =?us-ascii?Q?0/JvapT0rEUpsg/uMVPDuYrnWQLqFCkpG0Nvoox0eGIE2TSl+1yM8ZYE11UC?=
 =?us-ascii?Q?RuHBVMdF5Lt7Mpu5pDO8pNzjVFWxFDRG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 06:41:02.7882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3946b691-11c5-4384-f189-08dd1b411cf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882

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
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++++
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


