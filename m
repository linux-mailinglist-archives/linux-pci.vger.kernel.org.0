Return-Path: <linux-pci+bounces-17877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A509E812B
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 18:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A6D1655B3
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29403150980;
	Sat,  7 Dec 2024 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YI9jgdXJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916F14F115;
	Sat,  7 Dec 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591515; cv=fail; b=idAAsTf0oouEIPzQKOumwOwlgt1UHu7SwysFYxKg8zcOrxjKcqCHrx2H99kV/qiXvvCBK7UP8z9WX4SyFy47XU9Ub3or7hZpK69d61luk66i0lp6ngvtYt6gHMoRKirhI2VZvYqxpDsd0bTCgkpxrufL3/ewZ7M3xVWfQOXDm3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591515; c=relaxed/simple;
	bh=01HqJiZhsySqrjhBunF5BXPNMxY1HBw1KcV8zGuZDJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5RDijZGKpBO5BhSxjAvg1PHwFZpCxpDfiCzM88wbPLy5oVJ29SjvVtQ6EGrT8NKZ/RNxqM+tRC7DW6SQ/ES8v5PLUuCL1owHiamHuImQKM3jRy1XOWHHY331hGoao/E+13Wqo9EnDTGf+tovS1pe28LSMMZaqtT/r+gPtUCXRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YI9jgdXJ; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLnrcEKClOmBDl5zU9BtfNd4gk+I2VJFSiJE4f/D9vY6+fOmlTo9TYts/X/RaBP/+ijxRAG1tTEtKk4SZmLsaW3nPd/od8Kk0DUUlNBZpYG12LpeEkwRbF1Xuci6pMOlhz5HP2OgBdQBjtiXneMzZHdvqjD6QEM86FNsm1hIo7iqmr4X1bpQDhG+oUr4hhJQFjP8Eh596R3c/kZKLoYfmJOJbKMEPeksjHeKyWBw0RZvQHiI8QvEv5xF5oa8NZ3Wx2P5JnAjTRb4+ZzKVNVa3gOoViIhgdEiUHbk2Phf0i+H0eVPmkttipo/AMBRU9/RZrKzcMghS5Vv6YSMn2X5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLaz6Q5IcxGCDyfP0mUpDcTD0ZNKxoqrKvGxwixEyj4=;
 b=wCQLvBREqibQETzC1u8JIW6md6vAh66P9BVy4SeEbm/FxLK73Xs0eZoGeMTUZ++cRihznTqQgVOHvAZceYtWbMlP37rZ69nH1ejZz784gIYuqns7Pibzd8SjZhRRQZc14uT2AW0ChrqdcWzYRPNdNKwxp35kgCiD/wrigaW+OVCFg5NUNVNX4tmG+tAaCsOwBfLLnkp6KBggDxOis96VaclU4jliqUcQN55eRhuqtHiDa/iPgtBQrpopLm03Xxud8l4Qk84M/PXRPOrPJNaBhejEo07ipoa5cbOo+jYZAKQy3m3oAHbkLxS/HYdmEpY2yp3dJLOOptMcsNPlWYtuVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLaz6Q5IcxGCDyfP0mUpDcTD0ZNKxoqrKvGxwixEyj4=;
 b=YI9jgdXJ+1ypcT1tcax2FfZWH6mSY20j7G7v7X7fOMtBranby/7bw0kVZPVdbRy/rvkfxzVgLtSQHGWqt8z090ebjrGPrmCSZaKrw14cKsc7eRR8dnkpdtdxUyMRvmhvO35SCHegOvDZb9Uj8otv+Vpzxd2ylfpOawnDkFKCP7o=
Received: from BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::23)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.25; Sat, 7 Dec
 2024 17:11:48 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::e6) by BLAP220CA0018.outlook.office365.com
 (2603:10b6:208:32c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Sat,
 7 Dec 2024 17:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 7 Dec 2024 17:11:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Dec
 2024 11:11:47 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Dec
 2024 11:11:47 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 7 Dec 2024 11:11:44 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v4 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
Date: Sat, 7 Dec 2024 22:41:33 +0530
Message-ID: <20241207171134.3253027-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207171134.3253027-1-thippeswamy.havalige@amd.com>
References: <20241207171134.3253027-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 4813e7a2-eeed-439c-098d-08dd16e23c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PIswNzcshVTvFVrBgBJgZKevrCHs95Zv2oXlmo5XVMp6Nt+Ofh/iqYdGx2iB?=
 =?us-ascii?Q?pZRYANL/cPw/iU5WD3cmGEXP4btMExQK1o/FLo5v5EeJ8mv3I4T+7y8/U3Kt?=
 =?us-ascii?Q?q6aEIjzh/wEqHik1Y0qBZCe/A7ErDHT735lJsnLDsoZtpVrmZgTl2GsVclMT?=
 =?us-ascii?Q?ejaCjY6RyNzAOvHf/+xLlqqlzRfH/E39TgQcEkX/1UqpwalOc+7EDYByRm0/?=
 =?us-ascii?Q?sYDf4ib441h50uLu7ptMinHrIbf6T+ARB09ZTcjEyCJKjQHPLkF8TXdQgnbM?=
 =?us-ascii?Q?n+GU88bRZsmEQjmSVQLcnr43duQ6rXbz7GKlIVw6p6G46CaKxU9TU4/gcPaf?=
 =?us-ascii?Q?XtOCl0muj0I09jBWzgtWGZLM4iDf+ZOLNZZkpd39sLXzlBEfklGYztn4cs+t?=
 =?us-ascii?Q?aAPni64Y9A5YxO7PEj224ovej7dOPqk1iVtAdd7+q8hmP6u9NvjZvVK0Z+Sl?=
 =?us-ascii?Q?B4ptOobGjQLwPrIzW6nddE5o1n8M5lexObmtRC4mE2EJHrJrNRPPTTU9T/T+?=
 =?us-ascii?Q?fYrwyWSwQjldktZdxXfzKatpIV2V/+wRlm+K1slYbUaYpyFWbkbbkCBGq7Tw?=
 =?us-ascii?Q?KekN8PwHwlszOWsccHO1lg8y1JYT36IpZ6oOQL7o+WVvZb6Vw2d12iNDnfYe?=
 =?us-ascii?Q?eot3JelTnbe7s9gxy/C4VZP69DgvDZvnyayFEwAhMU9lDSzn7V1C0sMCJbd/?=
 =?us-ascii?Q?52x/1XI6R9LJDqAfNUS/hHS/Q4uUUGZIDZWTCzs8dlnuxgQ+rBDYzVNA3gC0?=
 =?us-ascii?Q?K74xqWeWhJGBXgJ0NAlCOrlrt1nkvAh1CqEet4v2Dcuc37Pj+gdMTEpp61cc?=
 =?us-ascii?Q?eJdDIXLpzTJ9iBAW5zymR51fbK22ufSXF0uYRodnuY9jc6OVU3+48go3XOG0?=
 =?us-ascii?Q?8orlY8gA9uTaW2N3z3GBNHnLsE/bNNE6NVFVkGknAFSa2ePL7KyS5oIehiVR?=
 =?us-ascii?Q?KfaxbhuFQea9Ky7ArrNs2enM6ZMb8dTT0lNN+JQD+GKEwuu17VQnnNEUOKpR?=
 =?us-ascii?Q?TxqrVQ/M5ZvM2Ih+UNuNt55Ai3LKuet8w0N9lgk3iU8SKq3efMhMCPC+9nh/?=
 =?us-ascii?Q?6wBuiNcnVgcRA+aghRmZJAWGE7EwyNCI1Pontz7mlExe4AzCl8fSE1gLJA3D?=
 =?us-ascii?Q?ooyDIuhotCf2PMgKsAAXSotmWdMtO64HHadlSKhwc4qaWXUoe+ygzNXi5VqY?=
 =?us-ascii?Q?JteqLf81GvI+fiCV6u8NWwsRZAIb8Kv9egX6FLcZz+9rHOzD46pBbXw4NKQe?=
 =?us-ascii?Q?ln1EhdMLMhFEsSsb2yyg3vWlYBaOdcKym8UaIMn5bkf9+kgu/o4Fhy27K9oy?=
 =?us-ascii?Q?xgPnVBfDw9qJdUP46F734mGnelUQKacvhVj0QQkfwTmnOuBflK/ZUX6Sz5rr?=
 =?us-ascii?Q?d66aO0aWK94jRtU1zW5NrqjcAuGxKxdsbeycnp11bJvgIBK97A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 17:11:48.3832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4813e7a2-eeed-439c-098d-08dd16e23c2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697

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
--------------
- None.
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


