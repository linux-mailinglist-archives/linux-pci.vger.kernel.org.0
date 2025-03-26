Return-Path: <linux-pci+bounces-24719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910BFA70F0E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 03:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569E1189DD59
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 02:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A02813777E;
	Wed, 26 Mar 2025 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kerF003S"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F60146A60;
	Wed, 26 Mar 2025 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742956157; cv=fail; b=O1MZldBYdXD0trdYt0uqBKdgfP17TzXcn/DR66EjcwvBeHY90sgNZalsyCKpnYOTZLlse8bqb3iBWTvn1eLM43dJIL+7hMHlOPAU7QKqFwEBdjcHPURF9PTiRYKHV5nQuOcA4ytoOfOfh6fbv0LDDUjLDY3jTx2rp0xUl0CeN+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742956157; c=relaxed/simple;
	bh=W6G3Evy19uX+grxE91xHViRsS8N2PSNyX8VHRZNdyhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKiH8SeIdi37MoCvYN9SzMY6zVgSVgFZPzjJVQXHKxCX10r3Ebi+vil84hgTOEcnuYZOaIwhePpPpbggXZ2AzAK533LNtHpmI0hzbyUC3V5SulVfsUhy/H6RC9oWvFqJF2Z7mV9/KEDQkY7ZiNSUBX4oSQof2YWBBtkw+HsNH/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kerF003S; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JY8PxwadlCm9bqPTaWpNqyM1NQ48ks/Nz4CY1OLNA9dZeN8HKOrB68cuAw9rpzZovh0iu+Tegf0bMzStYJgspecrSpBx2oQctvGrcFgyMqefLpJyFpIoEzS+5oqAq74mVKrt5jrEC5sxW0RavsVnYUOc6VnLO2Z39v7lcy3sbMjErh3APAEPNakhj1XMCEodJbfStHTrZhT+WooyBiyjaU8K6fakmFuoZKYkq9JTn9UusToUvNaEAEVgNjkKXXS7oYde71/2pTV3JszrEZKiB5v2AXNORnjjPRiJXz4mHOQ5+pAXlCdZd/NMpZxi6pO9nBTmtMU9hA8ylP9q2UfzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdaPfyd3TgkG4rKdWpJ+lb9ltJ5RDLfUQ07Awh23iFU=;
 b=SwJTnlRlIvB44XOZ54ouuQm5kMs8JmKfv5yqiZJ/pH34sbRl3wA7kEK4/g/7js5jjexn6gfCgHpHO5EyEFzrIVwJAAMjFAPvGaVynMgHxrXQw7bLEfyQphJlQ0rkgI+j/hmwTPeaagGN9jDACFEC1mqpjU4cB+JzuceCWc1ePNc/h0vXTf141gMa3BN5GxGs9e+nk3WAk9/9cYgE1q3n98prIOuGjVAh6V11lOxMq8/Wnwajehnl/A2LVB3vaPwUbr0GXw6cjKAbJHmE4yNG2cSrNPHuCz1SVjUiLBoHam+0ZoObuEwwOWHjoTGrVs7gFQkrlUdJQFfCwurAgvNn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdaPfyd3TgkG4rKdWpJ+lb9ltJ5RDLfUQ07Awh23iFU=;
 b=kerF003SJGJXKlSs1Gy92R71KUhK0Qd20Vgb/7W6qWW2ODb2YYRATx8twyHKDAf+po4gY2Kvd8kr3UI6dDgOhSSg/1wKq6ANah9U6lKVM8u8yS8KdE7D0KpENmSGbhfts16emd8j12eO+YAzMCTzk3DJMHYpiJhKYj7qG1Z17So=
Received: from BY5PR17CA0042.namprd17.prod.outlook.com (2603:10b6:a03:167::19)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 02:29:08 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:167:cafe::b4) by BY5PR17CA0042.outlook.office365.com
 (2603:10b6:a03:167::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.40 via Frontend Transport; Wed,
 26 Mar 2025 02:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 02:29:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 21:29:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 21:29:07 -0500
Received: from xhdlc200235.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Mar 2025 21:29:03 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v6 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe RP PERST#
Date: Wed, 26 Mar 2025 07:58:10 +0530
Message-ID: <20250326022811.3090688-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
References: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3ae992-9973-4356-a68a-08dd6c0dfcbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QOf1FqSdhdudNucmTDJqJgNw8N7oBSUEmluIC54u/8XdYAM1h7P0V6twxVnZ?=
 =?us-ascii?Q?tjjYAbEXKGTYn7zPbMa4T0VDG9BNiV7omNADQfd/Wp1ObeaQ6YYH+eVfVxU/?=
 =?us-ascii?Q?C++RywapBkDh9u7uYoP/JrCVlchTOhKlljvkZOyW25JxaW6raFLbdaEKWqok?=
 =?us-ascii?Q?H30gPTdJRqn1AgOCKED3h33KwUuwS4kgNYDOc8TMGzZJR6o7BYKNYoax2Adi?=
 =?us-ascii?Q?Ey22Ec7ff2Ax7/Gw2d4jEzFJRedQBaybRmYyssMPWa5x3BZ51aOi19NhBUCB?=
 =?us-ascii?Q?M/qlzsRn7Z+z/N+qXrWNw0Q4H+jR5rp324/HB2UL78ocVnNvgj0/kzPA3S53?=
 =?us-ascii?Q?Ggow7me7Za7miolx2c7+3QAFrJMfOJHrWgp3gex9uH1CLp2vJzK6SD/iylSd?=
 =?us-ascii?Q?yaX9RtRik6doFQQBFhosMNRAIkOZvHn33nBKaLjwV8ddBtBvAU/EqNTFSJSo?=
 =?us-ascii?Q?g9CLXZQAOM/eUZRSZKWd1H0/4LDZZBxVw3b3VAnMIA31iWP9QkwSTYuHIWM2?=
 =?us-ascii?Q?V1ICnke/Z6HSOXTZKTeSH3mrkAIgrB0FYXpWAAuEJUcaiFgY3JOg7+1fEotV?=
 =?us-ascii?Q?NwaEKCnCh6BF1x/164ywEq/gLYSJvVqXumBsI4J1dAxAgqSWXkUpp0U3gMp9?=
 =?us-ascii?Q?4RFjqR5RrLlU+UzM8Z1PNS7b/P+BKA5b+N5mHJtd77RAgYpJnxW6kGDYNIn5?=
 =?us-ascii?Q?VNYGDsa3AUq12veRe2Jrmh8w55Xv+e3jqWamM41cSlAkDgEf6NEQ6I8q2q0u?=
 =?us-ascii?Q?QCXnUXDWTynZYFnr0IyOwqIKxyyqojffOfjbZJJIVpbez2mMrEJBgMEOo+qu?=
 =?us-ascii?Q?7sPb9bCG9Ok9mPW/Hw7jpF3Ii2Y91tL4ZDX7zj5bde0sua/EvxHktPQ2mE5N?=
 =?us-ascii?Q?jwxgwQYcsk+xXSGNp1EjBlJ0Jxh/Stn7PFFmuRYcDMypRaX53qppscLNk09X?=
 =?us-ascii?Q?24H1zD5lgVXy+8ccS+VQuTZOsEM2heh1045V9ixiGAMV3V2pT+eO4NQ8zXWR?=
 =?us-ascii?Q?RmcGYYHtneD6kOk8mO7CPkYOtCBD/5YUYpZKYvIZ+pIl/DWR4mXq10tVzf2J?=
 =?us-ascii?Q?j+K3g6GjVNbIojArXZSpqHmQ0H6LSOboQrcLaNe76RJ+ktjBmsYyU+nePieI?=
 =?us-ascii?Q?xZrwi9+r1LePGqZZ4+QJOSC//QaJBJHTQOjWB8ZqNL2ce3z7iah5yQe6n54E?=
 =?us-ascii?Q?OHve2YtrNcUewygNl5Vfpeu/R8d47Q1mtSFXnGeYk7EVeUDewTi7gCbpCv5X?=
 =?us-ascii?Q?7OE2cWZyxipFZJb/cWbKV00prwVpJbQjNSnGS4hPXJ80SYcLWjSAAYjKgs29?=
 =?us-ascii?Q?+ZkC7/+NkC/y5lfI0rqV7+m81cy+sYjxOBUvNlX2oi2rGkX5j6EchB8p4Eal?=
 =?us-ascii?Q?VHS+qQRo6F4glMZYintq6NlIJAlosmvtb8yjN9nLXyFjjOZecfWv3cl8xBd4?=
 =?us-ascii?Q?0wEfj2vklt+TxImyNjClfpZ4jmbL7umvZylNJMKX12hzKTZnH+PGlx300EZG?=
 =?us-ascii?Q?m7235kDZZAdIamo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 02:29:08.5668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3ae992-9973-4356-a68a-08dd6c0dfcbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096

Introduce `reset-gpios` property to enable GPIO-based control of
the PCIe RP PERST# signal, generating assert and deassert signals.

Traditionally, the reset was managed in hardware and enabled during
initialization. With this patch set, the reset will be handled by the
driver. Consequently, the `reset-gpios` property must be explicitly
provided to ensure proper functionality.

Add CPM clock and reset control registers base (`cpm_crx`) to handle
PCIe IP reset along with PCIe RP PERST# to avoid Link Training errors.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes for v6:
- Resolve ABI break.
- Update commit message.

Changes for v5:
- Remove `reset-gpios` property from required as it is already present
  in pci-bus-common.yaml
- Update commit message

Changes for v4:
- Add CPM clock and reset control registers base to handle PCIe IP
  reset.
- Update commit message.

Changes for v3:
- None

Changes for v2:
- Add define from include/dt-bindings/gpio/gpio.h for PERST# polarity
- Update commit message
---
 .../bindings/pci/xilinx-versal-cpm.yaml       | 72 ++++++++++++++-----
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index d674a24c8ccc..26e9cea41889 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -9,9 +9,6 @@ title: CPM Host Controller device tree for Xilinx Versal SoCs
 maintainers:
   - Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
 
-allOf:
-  - $ref: /schemas/pci/pci-host-bridge.yaml#
-
 properties:
   compatible:
     enum:
@@ -21,18 +18,12 @@ properties:
       - xlnx,versal-cpm5nc-host
 
   reg:
-    items:
-      - description: CPM system level control and status registers.
-      - description: Configuration space region and bridge registers.
-      - description: CPM5 control and status registers.
-    minItems: 2
+    minItems: 3
+    maxItems: 4
 
   reg-names:
-    items:
-      - const: cpm_slcr
-      - const: cfg
-      - const: cpm_csr
-    minItems: 2
+    minItems: 3
+    maxItems: 4
 
   interrupts:
     maxItems: 1
@@ -72,10 +63,53 @@ required:
   - msi-map
   - interrupt-controller
 
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,versal-cpm-host-1.00
+    then:
+      properties:
+        reg:
+          items:
+            - description: CPM system level control and status registers.
+            - description: Configuration space region and bridge registers.
+            - description: CPM clock and reset control registers.
+        reg-names:
+          items:
+            - const: cpm_slcr
+            - const: cfg
+            - const: cpm_crx
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,versal-cpm5-host
+              - xlnx,versal-cpm5-host1
+    then:
+      properties:
+        reg:
+          items:
+            - description: CPM system level control and status registers.
+            - description: Configuration space region and bridge registers.
+            - description: CPM5 control and status registers.
+            - description: CPM clock and reset control registers.
+        reg-names:
+          items:
+            - const: cpm_slcr
+            - const: cfg
+            - const: cpm_csr
+            - const: cpm_crx
+
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
 
     versal {
                #address-cells = <2>;
@@ -98,8 +132,10 @@ examples:
                                 <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
                        msi-map = <0x0 &its_gic 0x0 0x10000>;
                        reg = <0x0 0xfca10000 0x0 0x1000>,
-                             <0x6 0x00000000 0x0 0x10000000>;
-                       reg-names = "cpm_slcr", "cfg";
+                             <0x6 0x00000000 0x0 0x10000000>,
+                             <0x0 0xfca00000 0x0 10000>;
+                       reg-names = "cpm_slcr", "cfg", "cpm_crx";
+                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
                        pcie_intc_0: interrupt-controller {
                                #address-cells = <0>;
                                #interrupt-cells = <1>;
@@ -126,8 +162,10 @@ examples:
                        msi-map = <0x0 &its_gic 0x0 0x10000>;
                        reg = <0x00 0xfcdd0000 0x00 0x1000>,
                              <0x06 0x00000000 0x00 0x1000000>,
-                             <0x00 0xfce20000 0x00 0x1000000>;
-                       reg-names = "cpm_slcr", "cfg", "cpm_csr";
+                             <0x00 0xfce20000 0x00 0x1000000>,
+                             <0x00 0xfcdc0000 0x00 0x10000>;
+                       reg-names = "cpm_slcr", "cfg", "cpm_csr", "cpm_crx";
+                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
 
                        pcie_intc_1: interrupt-controller {
                                #address-cells = <0>;
-- 
2.44.1


