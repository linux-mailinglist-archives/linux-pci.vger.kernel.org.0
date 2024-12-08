Return-Path: <linux-pci+bounces-17886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954DC9E838F
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 05:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52ACC1658D0
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 04:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19063A1BA;
	Sun,  8 Dec 2024 04:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x/YFgy7C"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818E07F7FC;
	Sun,  8 Dec 2024 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733632806; cv=fail; b=Rt3yBNk1l9vultOhZtwJ1uW05U9wdxyU718ZnbBBCf7NV5CnzdNH86jqUZrKt/hvB/JzWWzx51YE8T2zmm4xpUfZPLPXrGoKSwFpH8kMDamxBHYagjg/tCatxhJm6QsdWdxjG4Ip1C3q3PJdPkTRB1W9w5Gl1oprtZiG9xUaRtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733632806; c=relaxed/simple;
	bh=0ZqiC1MqTrTRS5U+wB23Sp+b55bII8//HKniubEbMDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkhnWNS+1Qd0T7V4EcIA1t8oFaqBRxXxm1EhM5JsjhdwsaZtO+AJiRCrBUu+1G4iTq6k4BKNUfmi7gPvDVmPniGSF8twNalp8uzTQ5kWbBg/RgliNuCiPOcOF4pSIzfxWK6NE31bnkX6zsTAFkUf1qHuT97SwmIWLDTUnPxGorg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x/YFgy7C; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLV+UHtKFdYa95y4rLJ92A/8Gw+BmtCAE2xNsDSY8hMngOi3BOmILOOBftnC7G46hpZKVUEhXuiLJ8vGpqWk+sgWoIpp4+W+0qFl0zqzLtLjUBUTiiQPWYxNm0s3LlLSqtOsJHAv9+FHsg7bvAEoGDiqiCT2xSvehyfpFuqXjr2TnwIg54NU+xAiWqF/rSVk5jHBw/7j3jSACpzMk8jLqS2RB2q4KVqoptJCJD01QRxB4RDPbBowcAPyyI7hZVTQQ95OJUW5GPY8b9mMtYNFsqwDijYsbw4s1B2Wsqhyo4XfZ+Yywbst1TgepJF2s/emrmaicezAXEwR+sRMYIh7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgRrxelI38fLt2v+YFWrDVbRcWYbxwjaQ+Yvlysu8dw=;
 b=TFdWkZU20HDVJDbXPEnob885H6lyLtYEGQWE7cT/f4lWGIq9G7+FHUkA2aNsfOym/+ARdpsu8Qk6Tb8V46B9Eq7OFSRVaC2K754sg7s9qDhsSjogXCcVsOwQkK7gsxI6pfPifCQY8He6p8x3SCPmhVVySzfIc3Sgbnb0PXVkG+Zww6FPSdFgNdychuHyRylGTED5G3h7BXE6KZukCPFFMpJ1MrGapNdDcFixFxPuwK4+9yzXWIH+AcDk9+dPVRjBTjSxQ80/DrnHSeDPEnc5C2fbWHdbQ7kFW2wTPfbYOWkZLHRyTxBGsNXWNr06OT25NMMHaWrBz2pEhg1a9BOcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgRrxelI38fLt2v+YFWrDVbRcWYbxwjaQ+Yvlysu8dw=;
 b=x/YFgy7CC8adEOYx5HR6phZ03w5fW/qOrcoGfkg7RA2Fhmhps2t18uhlsTA7OOmYJKF+KEblZIpUOUIOLSAs9MIzP+pHnYrq4Iurfu8HAWIFtKxNE7g8voqgwId+1SOshsXwIBQQ9fXzszOtb+K/eYL6gZpETB93K0O1jqWSNW0=
Received: from BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25) by
 PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sun, 8 Dec
 2024 04:39:58 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::b7) by BYAPR01CA0048.outlook.office365.com
 (2603:10b6:a03:94::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Sun,
 8 Dec 2024 04:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 04:39:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Dec
 2024 22:39:57 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 7 Dec 2024 22:39:54 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v5 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Sun, 8 Dec 2024 10:09:27 +0530
Message-ID: <20241208043928.3287585-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241208043928.3287585-1-thippeswamy.havalige@amd.com>
References: <20241208043928.3287585-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0b269b-dcb3-4914-4c86-08dd17425f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D2G0W5Xa/KgJR8Pa+ZNPriQh4LNzU53PuD+8CtFyLWT3n0o0BtjXRXmpBACw?=
 =?us-ascii?Q?qFT5xIm3ZXzfAGVA02ZKICUDoGnzjx9qWcltVjwdb+GHbWxh+RU35JrifBq6?=
 =?us-ascii?Q?gj7It8Js7jpbEE5fbkHpvGlO/M96/7fAPq8YjwUi5Td7jnwunPQLeKC1ztSk?=
 =?us-ascii?Q?p/a8qHRiaMTy00qqZjZqYFcfHdPY+eusMAZ9Yq2TX8FBGgXgc6gyd35EfcjC?=
 =?us-ascii?Q?Rsh8y/BLZkXGTLcETZgCUhTDgYCylt6DZbtRy1l8K6u84Ix+VvVNU81pKmn6?=
 =?us-ascii?Q?sKxuW6QBsGkv5e1Z8mxltHghIW2FB8wsFkN5PImEL+ynpxpaCZ8oWsbO+QiU?=
 =?us-ascii?Q?NUKEgobappbCYBzoLofuVih9qb6lZglu8QJYc2JXzAAeuoxuuk2HbNerAwk+?=
 =?us-ascii?Q?Qw93gTkriYnDPNMNIUOONLbsdX9HNJNCo68o5xUfXu7r6I3MaP838ywwtY0Y?=
 =?us-ascii?Q?eRYAJGbiMZEkRZFJTfTyf9s5aMOrksovXid3ajcGSFvny7fUG9pGKzv9QxUD?=
 =?us-ascii?Q?bREBdQgOjIrQUK1bZUnmRzqdaH0gu6IesoAVsMhq43wdsTFnemvFzSl1mYeo?=
 =?us-ascii?Q?VBfbAobnKbffhNmJRn8gtBIfl7yJaNsHkKkELOjo9ZqIn9I4FfZvJ01A8Y1o?=
 =?us-ascii?Q?6OYL6IagSOifJwc75NXBA2y51ThSJDHp2zga0sRgftyERKG+LM+ZMMk/YLPr?=
 =?us-ascii?Q?ixw8TR3SLs2BJ8nLtWLDHSRowMYNFLPBOWhEz7aNKA+4JjikqwFakys3zE7u?=
 =?us-ascii?Q?cAJrl8kLuSZgnai6Ikh98wrldbPQ68KoWf46M9r8poD73kVJZWTUyLYc2erY?=
 =?us-ascii?Q?VX6toTEINI4Nlic7lJP3u4jxyV37Zg1LO1LCE0J/QKugnd9SE7yL8N+sO0fD?=
 =?us-ascii?Q?+lJQ1LiGQ+aBhPqprx+HZXDtp/ENnxSL25U4L55Q82rSlsAtYyTULiebGPvF?=
 =?us-ascii?Q?kfWTLXPg/SnVl/6C7UzuoIJBXdoRNJLkXkWvtWFCndsvDgtSgSfjcj/BW65+?=
 =?us-ascii?Q?IVUwBjwvayW8YYw58Ae4ks+ecQ6c8vmxrtW0JnJ6Y+qurEgQlcWMsbeAzouz?=
 =?us-ascii?Q?6ibOFxm/Poij5FS+9PwIOymbuM6PtXkkkBrveia6baN2U96tO1ncq2QkHotb?=
 =?us-ascii?Q?n5qdUGa+A9lBDYV4z3NYFCeimQQpZXQE9VBhn2gJaRc9KskdL63ExMS/WOoB?=
 =?us-ascii?Q?5D/SNKpIB3PmEv968Uycoci9RnD+aNXT1X/h3VnokDX/O3LCdkcOeDrpDbXq?=
 =?us-ascii?Q?RneoKzFhZnxU57kHQOE/e+12aPfYvhm/vWjbjBiCAWgSTGKxowmvlJSe1gX6?=
 =?us-ascii?Q?t/ZS2TE5QLrMDZ4hzSX5HIPAjAAiQInlrZ3B2h6MOHdAiGOte97jXzjptjuG?=
 =?us-ascii?Q?j9MEorPOxWR0J+lwjIu/cFleWxQQyeebE1tpREqM/WVFbNlkJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 04:39:58.6083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0b269b-dcb3-4914-4c86-08dd17425f1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

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
+      - description: MDB PCIe controller 0 slcr
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


