Return-Path: <linux-pci+bounces-21141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47838A303B8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 07:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9BD3A5A62
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 06:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B6F1E9B25;
	Tue, 11 Feb 2025 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y9LV1bw0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CAF1EB186;
	Tue, 11 Feb 2025 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255954; cv=fail; b=Ik/lrTWami+uIBa9ArrIa9ze++K1P7OdhUzxrTHYGmOJ8ZGiKKLmimsbuB11eqH4C8F+ZsrzX8VSInrZUtIEKf6aPJFJPjxk5G8qWEo4ZVtS/7W0ezuYz0gWM8osk7GgF534wsfpT9i8iwskcT8IWqMdv8A9e2ul2wEFW8FDzH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255954; c=relaxed/simple;
	bh=3jcXYoYETZxSB9KNoC3akr5sg5A7EI70s32KoS75hf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxiVxubON3vqf6EH4fF5MxWbs1A/0Dko4ctBmk8JTqZ7BBW4iEi7WqlyVX92cNB0MtpNO3KQ7XV8C90jR0LZ5l3wnc/R3+F9Sok0iTnN6VuzL8OCna9oUm4PSYuqroYh6rF948OBOCUTKVrIt1NZTOQKdnrr3Uz/TpDzr3IQCoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y9LV1bw0; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWZtXC0IDqpqoQgOZQzDeCFDqIEzJVHBlGG62qqJhjrVFT/X8rX6opLeOVOnwp29BwVhncQSA22iH012JmCO0jXk7IKuDdsNjvyC7oN52bL8+PLFmFx1IaffdfOLCcjtghXUkRwxHan/OBRvy1C9HbdnPcuMJlrWZECKcwvOkCxX85TiZHN0XvIPnn/w9OfjNk3jEBRrEjNomUgySnVqif5ysvc13hHkhG6P1kI/7HjEIjaUX7H62wvXXtOHbLevm7MjAd0+fGBxzVLSoipQh4HVPxuPHETjL+bYgJ43eRrWRktuogs2F9WqWT3FnwqKh8MmTN2mUIl4SPF4QBQcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yC6IFtH4aD2o3oRy6wjPjgX24xu/OnD1hY59MZ3cgIg=;
 b=UhNJCAXbaGi4bom6DNphO/OKDXwcAJ0a0RjiTccR8eTObdUxk1SH6hYygqvR/aEtmznQl9aWslvjrK7cFA1o+lTXzeYwRLazqjpTpGbwe9V/Bx3FtMjB/CCnl/AXdwlAdaUFxavUscQZK6yjEXtx4t1an/fw5qYZrD7ByP0z5HPvHXa45WQaPb418K9jZM19ngUuU2rr4N82DNxaSzCN2gjLH0CmC+mg0Gx1wCTN12jRKzgLwWFafDiEFqwOFitX7nNvwBnEsHjc8WC3D7MxQmvsB/6rUfwBO/yo+35JO6W62Wlcd0tROFba5ffDChSj1mvA65P7C/iiE1jhdN+bww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC6IFtH4aD2o3oRy6wjPjgX24xu/OnD1hY59MZ3cgIg=;
 b=Y9LV1bw0Qa0pAbhfNkIkxKqC8qIOmXG7OAj/brbMjlvF/abl20vrArI2ldILL+bgTdowVqAnI9JiSjsf5yvVJUn6kr/1fEDEaVaxJKL7F/Z4v5Rbj7ZHvPBIRQ9Qn+bOKYCdRZi3IHN2cPQj2yjasQpYPiYUKHDzO34vQ3A4lxg=
Received: from PH0PR07CA0071.namprd07.prod.outlook.com (2603:10b6:510:f::16)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 06:39:08 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:510:f:cafe::fc) by PH0PR07CA0071.outlook.office365.com
 (2603:10b6:510:f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 06:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Tue, 11 Feb 2025 06:39:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 00:39:06 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Feb 2025 00:39:03 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v10 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Tue, 11 Feb 2025 12:08:50 +0530
Message-ID: <20250211063852.319566-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211063852.319566-1-thippeswamy.havalige@amd.com>
References: <20250211063852.319566-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 7715275c-3ffa-4295-8b63-08dd4a66c911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3e6idAat8b/Mlh24+VfzKNR7YTXBy8rXj5gO8ljBD6EZXibhUKjyH/+IXV4F?=
 =?us-ascii?Q?3n3vkzyC2bsPiKWvABafibamSGbTYvY7fpV45Tws+bNojb/48Sdm3BwiiMlR?=
 =?us-ascii?Q?5K2nM5MLcOXfu2TtasZ0Q6iBZwNcIxjkFU1aGtdXKrp3fWDRm77vBP2n1Kd+?=
 =?us-ascii?Q?uMAMir1dTQHD9ekUT2vLzqhnfYZ/qHFtxRLCSZ476b64aCyANK6KXenBoIOV?=
 =?us-ascii?Q?NsPlu58cr5wDOp0WKh0zT9970yO3AX58rlNAvbDBe8odRCjUTs+2cwaFFZy2?=
 =?us-ascii?Q?RmoXxDVZQ1IePLTxIUkm+yd8iASg7vA8oLC/vyLTYByfONSmuaHETk5IsIRo?=
 =?us-ascii?Q?CmVXBGoq75gu/opOVDYZ/lwEtjYugt//8Amz4FBZfaJNCRdSVcQZdx8dZw2s?=
 =?us-ascii?Q?gJYyh8FWyXT9GJrMQ2rPxxnLqg8n3sezZizl9+znjV92w33mu5WZBLBlpqFJ?=
 =?us-ascii?Q?CaMOIXJEHVAhrBPfPsZ9IdmI8VcZnfYpPo8i4YVdhvoJivTQ/ioC42T0YkR6?=
 =?us-ascii?Q?Z41kG2DQcPY+BxMVwCwT0WFvn8YYwOdFx0OO9YJGw3hYnpI0I2yZp107eQKW?=
 =?us-ascii?Q?qcVXP275e9NtVTn+Ej86UlaK7zeu1yhgFmNK6B56xxMH4A9ZpB1oAxByLXrj?=
 =?us-ascii?Q?PwzGxNaRpoMifTFPE8TTs3q8qUyvT0J14XgudOp3Z2psK43ISrYXruFXd8qF?=
 =?us-ascii?Q?stHhDR3u8uEPV5yiBQ+Thwxlf6s1V4vXPDCDdrHPbWC2cZDGE9MD16B4JPsS?=
 =?us-ascii?Q?OQgtojc0cpOmymjJ+slmb+JtQHsjYLJcJsWWEjv4jSOJuINULt296jbK0REV?=
 =?us-ascii?Q?mSRhJwuJbhH/mmOQiPAUwRZqAdpdI48UhRIub/cGeyiexsOnWPBBmtNnttHT?=
 =?us-ascii?Q?x/esHPOhJJWyy2/IIyt7vdMbVSCHVIv33M+w4/MPRi9jWSf3yOrWrby86K9u?=
 =?us-ascii?Q?YGg3fEmP3dPLThVGk4v9j8QN6l0MCyPg4xLoZRkth0AjlXLZ59rn/7iUd4Xh?=
 =?us-ascii?Q?Vb0cRey8jjNj2YLOifD50thOdUJWSv3rHb79HveAWwsG/XeeUz7LQ110tQX+?=
 =?us-ascii?Q?rS7b8nfdXZPUZv8URVuYwUtihDth1WYTGbqAoq0ETaIBkrfe4xkrcyTQt+XU?=
 =?us-ascii?Q?70yC5EpO5B10XI9lki+9tnlkFmdPrxzHZhvFseqqcppTDu0uTd10ogK8UHMc?=
 =?us-ascii?Q?gwGKUVLNYwzzyn20HYw7rYY2mYZma3XxxZHK0pJ0zkOC7YH6JUC8xoDPGR3r?=
 =?us-ascii?Q?Nmsn5Z+NCHc54snjg34A/AXsPU/ZMdtXMFBWR6XxR4CQCdGNGZDSzRvFJpp1?=
 =?us-ascii?Q?LaMeu9f6hkQoK20jXW3o7m5TQvCWGD6x1g8e+WHAZwjosu5zPne0Lue8H3El?=
 =?us-ascii?Q?/JOZq6hnFwoeQpAwva8wvPg5JH6Jpe6m+kTJzbRQ0GtB57egCpbRGMfm0+dR?=
 =?us-ascii?Q?dKNQU0x4va58M27bHK0d/THC97FShdUZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:39:07.5405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7715275c-3ffa-4295-8b63-08dd4a66c911
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135

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
Changes in v10:
--------------
- None
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
2.43.0


