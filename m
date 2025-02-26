Return-Path: <linux-pci+bounces-22435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAACA45F9C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254581888428
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A02D217F48;
	Wed, 26 Feb 2025 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H6JD0s7+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369AE21B1AC;
	Wed, 26 Feb 2025 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573857; cv=fail; b=N4UrQfl/Oh5/TrkrzPULTDOleAtWS9wS+n5KAgZiYQzkLM60hPig66jLQKvGBgXhhoDGODy6l8fbgsP/tu44wMm9OuaZVGxMPV4hdNHVNnhb3KOUKHboufgxjqFQ03MeP37bDH/8NSrGaoApbdE3VTNlnp0UNorzw4o/pOXrH+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573857; c=relaxed/simple;
	bh=kORjb1pZ+aLxdv6Wrv+OQ0hqUuQeNQUtzX1EvOYNglY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPJiGhgcVrVTu9oQIpVelvRhV2e3crlcvXffT7Obl4mcpSg3Q//ojT1ySZwBPLi8EY4rrqA0D37CQ8aLRmCB/Fa8wVETHMiuzgR6tX4nRHE5ha0VlZqdfn/qppfT+JRfMX1Zs01S1NfKzA0XbxVE6O9+TafyXrq4c4ESmY3Zbwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H6JD0s7+; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIN/UkR/N/We10p3nHhCQrOLP0ZIF4ALr59gqdktGp7yuxINammpv5+vSv1YQQIe96jXSlgBfbIZKjujCIApYkrihCpM7z+MbiVsF2OZ+oAGULEuiANdNUxGLYolLJsZfUiaUpl/RCTLhj6Afc04UQbOAQyr/HfnNDbgprd7FA3/+smmBnTHlQvY8Sjt33OMSrG18o1cfuJMCdxS266JRFX3/vAIRHnmTjGeKhofgjt52eFYXUhbI7CUPjF8AJema46WNOJFXWcr0E/dZhrupAElwnR1Y4MdDZcavZdmoZIDk6p/h36iW0i3uBPioi3w80qQRfwPWe4UBTLi6Gz9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpOSaYQ64YcGLDmtU9GleHrfKhLcS9DL5NWXTnnX5vQ=;
 b=G+8m0o9zleiAdWFP+gM3XG7Rz7tKRUku38R74TGV+w4UnM6GOSiXH8DkuuVMASG6gs0I+wdt0gw2iOHLHfbyrp38KevIueOTHVxhjfv9nDmAghp/xwUAXV3BWghrIZC2ttBOcwY0Ti3cf6UYNWdPDh+VBA59Wyld3bLjZ5uV5U99WvN8iWaN+fecqiFt1j2qHvylf1Ch40AEAUHwgOGfMa6jUg0aBez5Bb8d9FCC0s66l6CoQhEcdDxNUXOTUYwk50KoeAqQKzRnOWFfAaNO08JKLC/prQyzfvQLzkYf5h8GEjXYX+chxm3nko5jV/tOyRWUnS+KOjg751JfHNJ7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpOSaYQ64YcGLDmtU9GleHrfKhLcS9DL5NWXTnnX5vQ=;
 b=H6JD0s7+FPRHGuStM5RN2v9p4++U20es2FnK+gwp3CepL/FQZ0oy7Iy/iP54DOGgIn1asjkqtZ2SUwyIsRzZIqN72E7iGhg3vMoeUrtyPJPb93yOPzCbg2EQ8v19kwc6q/zKgtOREk4M/J0M/b4XfAnT5yfhZJT/1w/H4G2DU1o=
Received: from MW4PR03CA0218.namprd03.prod.outlook.com (2603:10b6:303:b9::13)
 by MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 12:44:10 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:303:b9:cafe::cc) by MW4PR03CA0218.outlook.office365.com
 (2603:10b6:303:b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 12:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 12:44:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 06:44:09 -0600
Received: from xhdlc210316.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Feb 2025 06:44:06 -0600
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe RP PERST#
Date: Wed, 26 Feb 2025 18:13:57 +0530
Message-ID: <20250226124358.88227-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250226124358.88227-1-sai.krishna.musham@amd.com>
References: <20250226124358.88227-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c024200-1baa-4671-baa8-08dd56634457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0G6uk9SrqXWiNI6clZpwry+bQ5sxbXVUIRUgMafoqex0uLK71mlvS3JcA1/B?=
 =?us-ascii?Q?kEhl4SjJGmkbWvohfjVNAfUSqk7FFtAE/uEW+dY5yy8GzlaqmqhMrYf4KjB6?=
 =?us-ascii?Q?JAfir8e2Ujvjw6uV0pbGwkXTZd1MVmdDxVFlqZqamMVF+jGZ+WIZleNhaDzh?=
 =?us-ascii?Q?A/Jwk3iBox5qzgNxSEXPvA5RBHEQGTIcr0PpG7kAJhD8ZiXEw+wRELpuvNGP?=
 =?us-ascii?Q?597SuetVVTgGJDHVwL/ej7pXxsem7h3kBFfCwbuQvQfbObafilXABtOxIBW4?=
 =?us-ascii?Q?zvpGv8HD9IH+Wvd4alUjajdQIyZ0SsiMBJ3eOU74HXwNLCODk878llw28qve?=
 =?us-ascii?Q?REcqAUGjx3oURz3DOp7G9qXTHQZtmPidlcnDkqVxuLuZrnHXyG9X0t1ldQlY?=
 =?us-ascii?Q?Znl5coMEkDCTN+5jPuGzRzRu661eEDhr0QkdDwEutng1PAgeOutvD8joNwQp?=
 =?us-ascii?Q?z9zwYJpssjuEshK0Ap2A4r8D7D4ltTSUWYpsePhekaxTC0OwI6jwCbNNO8R3?=
 =?us-ascii?Q?fWJrGK5ebRrQWRxmVdZHCoevfDZHsbllXlesUy4LYsVe39JeMxhBmINSZVa9?=
 =?us-ascii?Q?paEQUipqVgQZEtvxLpONb6xNBB7wljSqSg+bVKjGuVbfNF6EgDfirpWLML+i?=
 =?us-ascii?Q?Rq/4LjQE0g+m3rrgsHIgmVQRZM4noTHZ2eMV8FbQAlIQ1l/gQv/gxYQMlInQ?=
 =?us-ascii?Q?wUWdi1nlTYwS2yL423Bv1aTA/Xw/Aa5jLu6jCqy++xbhwIGzZDD6p/qFjlJ0?=
 =?us-ascii?Q?StGktG9ekT+tT+dwFbUpEu88M9z3NAcO+zb0HbREakkqhXAiTR06YJE/jvDw?=
 =?us-ascii?Q?RTX3bYh2NrVOYRxljjbhs4GvCE6pZwRGIEgu0px4tQjnxKGEfJhnm5GRdADw?=
 =?us-ascii?Q?EXLaiaIoDiDpal/5luIHadvyF7wapY+aXhmXV78UMHe9boNqvHJKJ4FTFKZf?=
 =?us-ascii?Q?y91LfiJ7aDpVQTKeMky8RkTFdtGdITue7pYrhOlW9w5OrD+2E1t4TU2j1i9b?=
 =?us-ascii?Q?mfR4vZK7QDkEMhfTnoWZMSvVDM4D8RSsj440aoE6Ct8QYCICMcWgomGoBe2x?=
 =?us-ascii?Q?lsY1kOl6MhVriT5+jAsl6pDEdwTElGhx176QCfs2nJqMratoEC1vqTjMWzSs?=
 =?us-ascii?Q?z1geU1dSC1V3FcdjQgis6o2m52fs8EBOpx9EGrDZOPgsU7O7q5/h30s9T9Of?=
 =?us-ascii?Q?W2rxDqWrLu1W7LjDCFCZVPWwijveue2umk+T51+wLGMO6N6ZbwfgiQwVgKF1?=
 =?us-ascii?Q?jeNc2fpFP645QVt3437bSPWEqYSc4nt9utIqdGrLrQt4ZZ4HKTNz8Va6q32p?=
 =?us-ascii?Q?Nb7Ps8d3iil1MTvUZnn9JyOSSmGZsovMEXrcE0FKWbnHfNrCppkzqgTDQtib?=
 =?us-ascii?Q?mhZ+99FJc6Fob5qWRmwAS8Muruf4uXGf6hptZcvYpxdAfXgBARnohQeMz6YZ?=
 =?us-ascii?Q?/qZYi9CC2X2uk64tOhfjeoxf1avtJrKEMR6hxcmMgG70XlDclK9UM/HcMe7i?=
 =?us-ascii?Q?eNQSDN2kqB0Qfc4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:44:10.3110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c024200-1baa-4671-baa8-08dd56634457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681

Introduce `reset-gpios` property to enable GPIO-based control of
the PCIe RP PERST# signal, generating assert and deassert signals.

Traditionally, the reset was managed in hardware and enabled during
initialization. With this patch set, the reset will be handled by the
driver. Consequently, the `reset-gpios` property must be explicitly
provided to ensure proper functionality.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
This patch depends on the following patch series.
https://lore.kernel.org/all/20250217072713.635643-2-thippeswamy.havalige@amd.com/

Changes for v2:
- Add define from include/dt-bindings/gpio/gpio.h for PERST# polarity
- Update commit message
---
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index b63a759ec2d7..6aaeb76f498b 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -33,6 +33,9 @@ properties:
       - const: cpm_csr
     minItems: 2
 
+  reset-gpios:
+    description: GPIO used as PERST# signal. Please refer to pci.txt.
+
   interrupts:
     maxItems: 1
 
@@ -63,6 +66,7 @@ properties:
 required:
   - reg
   - reg-names
+  - reset-gpios
   - "#interrupt-cells"
   - interrupts
   - interrupt-map
@@ -75,6 +79,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
 
     versal {
                #address-cells = <2>;
@@ -99,6 +104,7 @@ examples:
                        reg = <0x0 0xfca10000 0x0 0x1000>,
                              <0x6 0x00000000 0x0 0x10000000>;
                        reg-names = "cpm_slcr", "cfg";
+                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
                        pcie_intc_0: interrupt-controller {
                                #address-cells = <0>;
                                #interrupt-cells = <1>;
@@ -127,6 +133,7 @@ examples:
                              <0x06 0x00000000 0x00 0x1000000>,
                              <0x00 0xfce20000 0x00 0x1000000>;
                        reg-names = "cpm_slcr", "cfg", "cpm_csr";
+                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
 
                        pcie_intc_1: interrupt-controller {
                                #address-cells = <0>;
-- 
2.44.1


