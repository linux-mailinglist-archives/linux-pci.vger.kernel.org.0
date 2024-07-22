Return-Path: <linux-pci+bounces-10582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC49388E4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 08:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA101C20E22
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 06:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AE11803D;
	Mon, 22 Jul 2024 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bvpeld+p"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED02E1B27D;
	Mon, 22 Jul 2024 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721629594; cv=fail; b=pidCAaKKkd4bLDLl+2xXlpSWNRUKV8lrjNU3pz9qYH8No8y1UnzyzR/P/EuP9qNfI535VqeoayH65naIMeAppqOolH5+rRyuTNzBny2nSFJXs1n0VxKAoxrwJ88bM49qvXmjGkPhlw0fmWDnzr94d+Y1qNG3UXYBzSuHhbhfFH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721629594; c=relaxed/simple;
	bh=Ac252ZsGtTBtFrhBJm8ICPov9afxZEj7nHeF154HK7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhuDvZ8olDr0sPJ5yYwRRJgPG3ymt/teiW8SwBpg0crp23WrBmk3jIuYn7B9v+exIpar9wR+n5MYCaI1OJNyn0/KSWKTPWx//9CxqdSd7gn3kuPEZ/ajmRCq7t1/BsjZurMBojKlP/OR5jwFGMcfaYO4eEdifAD/LtQ5pzgWcjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bvpeld+p; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOsev8Qu5FxKORqITi01eJGw+pjrh1WJ/k2Dud3SpGVmV4YmpOBLNn1k9h5nGYS4NtMy1KM0jdD8xETYZw8sh8BuO0mm7eQUBqnO1RGDDI2uAsSJKB8dp1mvyefK43YElM54mrt4rQmkDMJS4HPNdbNJzmFcyDkjrUc+MjDrtcXSfrh4A8ITQQ8VlyZ7zX4nBgxl4C/bXnL9fk0o5lvPaeB2K7U0lOoUq1SQUxUeNRMiU/gliC7XjKKaoCPQv1EMLYMNls6Rij7n2T3n2HL9BYjCe6wyQPzPqxZQ2hILRPFYbT8EE40FFJUoK3YJDGYmIyRz8E3TPODZc6UIqFVKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx0rTwbbvA3LJi9fxiy53iORpAvZtRm761lHb6iyjS8=;
 b=om+r6GgvtAb3PjJjNDFd3Plh6WIXWkCKmo2xa219FU8qKyktO4qzzpVybkSE7kYmFsFrqHcPzUi5vC/eGXL7HOOQCr7rhwwTcUC27qmEqzopcoQ1r7Ff2WICn4K4ZJxI3Y34zBM2sMqgrLyiKl2xqDz5iRmf6S4CpPI/kjmBFA9gLqAyiSazAQaWj3aVjy0d66uqUI4EwjJoA1U3PyDf2ybv23EoSGIWvDux03iFoWIMg6eVV+HT+xZW9idi73npF26hS5U5BO+kdvXrHfcJKUFSCq/vNryPt/JaFLoIrZv+U90r7EuIA+UnWU+L2mrGWHVfJnXDsJbD5IsOIDlB7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx0rTwbbvA3LJi9fxiy53iORpAvZtRm761lHb6iyjS8=;
 b=bvpeld+p71u3Qa/L8GJQJFg0nG61CQ6wWHX7QkNVFigx9bmqn+E+sYrX+K6WR+KDyE9Y8Q0+8LHhpxKjGV29T8kVOD31gXomr4uIcU77T37k5QWr5N+SHAjt5tLbPfd69QHctevMGuqTw89Gjd0lVLocMwXTZcbJ+/DCvUXCgtE=
Received: from SN6PR04CA0089.namprd04.prod.outlook.com (2603:10b6:805:f2::30)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 06:26:29 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::9f) by SN6PR04CA0089.outlook.office365.com
 (2603:10b6:805:f2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 22 Jul 2024 06:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 06:26:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 01:26:27 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 22 Jul 2024 01:26:24 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <thippeswamy.havalige@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <michal.simek@amd.com>, "Thippeswamy
 Havalige" <thippesw@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root Port Bridge
Date: Mon, 22 Jul 2024 11:55:57 +0530
Message-ID: <20240722062558.1578744-2-thippesw@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240722062558.1578744-1-thippesw@amd.com>
References: <20240722062558.1578744-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 53bac269-f03e-4a0c-c8e7-08dcaa173850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U30evg7JN8d2lcgmnCRK43yjDQZx0fjNl1W+r9NF3+ul8lsW+vTsBTOOgW7i?=
 =?us-ascii?Q?EggVzWexNaMNTcUwWfWoR1ERoVmwBp5zMRfq/jz/u5oZpJX4I7T6Bjo2D/TC?=
 =?us-ascii?Q?ymWSDhQVn61O7gabvgms1uyulICI2M6onPShg8zBkvX3gUvOgpRWg7DQtVsk?=
 =?us-ascii?Q?olkdWMN7yUewfxHzWtoY3h3NZX9z8Z/KgSMrKUiUwDGeh2G9CdB8Dle7tuG9?=
 =?us-ascii?Q?LRjp9C0prtus24oGNzHfsbSYcwFQnDJrgXwL+ZaNo4Oh7laV95ds0qib8ROV?=
 =?us-ascii?Q?43WdXi0462MqsAUryWk5vfAZwtSBt6O0t/cefsZ4wFeGAHkaScvCu5YEzD0d?=
 =?us-ascii?Q?FeFe17m0GCoKYX301XVUUB2YuyZwlvSEVQ/1Mkyx2MLUV+pvLbC/NH1dNZC2?=
 =?us-ascii?Q?QkdhbkoNK7jBjS++0wMhRaUusQA1rnK3cvL5cS+/ShffVsPRtWCoTble2vqk?=
 =?us-ascii?Q?yVyMrHGtnjR6HAcSMiGpLgq3OvTZb2Xm7Cl4gpzoBmBi598bzZBOsRHzQe7F?=
 =?us-ascii?Q?62XXAar7tWgmzt3zisbnqiwww96n36dhDJi19MzbmrqAtf+G7tRoCPC35IWw?=
 =?us-ascii?Q?lhaqaKtFZhgpsjSB/zSiTJxWBAvh8i3M8xYXlyOaOf7CHRXuKZoPVvgdj1MZ?=
 =?us-ascii?Q?Rrsg4IfqvwS4nxjCavB07FcaDP5Ye58aHlrwyQ8l0lC43gd/lm1pqnzqErPK?=
 =?us-ascii?Q?BXk+HUkxb6Xvz9oqgf21VaTsnmQPeZlSfBfOqMnQ3HUbvoY2bh0BJEvAMndW?=
 =?us-ascii?Q?jU1IhmO0YtKOE6gyV9SS7di0yP5JAHOeMsXsFXR2MhM7Fhqk8UpIcXDOprIC?=
 =?us-ascii?Q?LULY/1/gLLdYFBBa2yhWlHxAdodiGrWSONy+NUinegTIZ2TLhIZHct+x+K45?=
 =?us-ascii?Q?PqrtBOX84Datdp1vzXqqeizINJtQWOXbn+OPAI3Wj/B7MCcxJvB30O7YJswG?=
 =?us-ascii?Q?6e3W2E2ZPTAmxmhdbXb5ltNDPKLDdLxXlULf1Dn1W1R/gP9X8FiCt13Nq21n?=
 =?us-ascii?Q?rsNTQPjZgRD1ArFxAtR4e3eKmD4ITKGI84xs2lFHqgvaVBc1Vu3m4MGqDojT?=
 =?us-ascii?Q?xln+/l3z/fRtbhtC5b8Scf3sgbxZI9L/+BtKa/6keoeTRGyiuiG8vAbCtXj/?=
 =?us-ascii?Q?nKfLz45C58q9LNkx2j2ga4sLvYcfMjkuT/nKbwk3w17BaLF1FDm8Di1HuLls?=
 =?us-ascii?Q?jrMrX9yFddQrxWcYkrqub15g9M1d6HzIRCgo6xqQHZCpQiPiWrHp9Yj1VCXM?=
 =?us-ascii?Q?3Nj3Kg3YO5GqGb+KQzDN1I36RdKEYZkqqfwYF31j+QasRKCGqYkXAb7nyOc0?=
 =?us-ascii?Q?Y2u6aFGwuMmegl/R87uuGoIlYf+SlcHIbnj2i6IjbeY59KUA/mOuhYy1pjQT?=
 =?us-ascii?Q?e6ffoHIAcn99S3EYROxNVEWnAQ/MUh2lHVS5vuqF8jTjzg6j6h01jhWFeMqO?=
 =?us-ascii?Q?ib82pdodwsoMZRSpoSyqUho89oC3ApqI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 06:26:28.4774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bac269-f03e-4a0c-c8e7-08dcaa173850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405

Add YAML devicetree schemas for Xilinx QDMA Soft IP PCIe Root Port Bridge.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
 .../bindings/pci/xlnx,xdma-host.yaml          | 41 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 2 deletions(-)
---
changes in v2
- update dt node label with pcie.
---
diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
index 2f59b3a73dd2..28d9350a7fb4 100644
--- a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
+++ b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
@@ -14,10 +14,21 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,xdma-host-3.00
+    enum:
+      - xlnx,xdma-host-3.00
+      - xlnx,qdma-host-3.00
 
   reg:
-    maxItems: 1
+    items:
+      - description: configuration region and XDMA bridge register.
+      - description: QDMA bridge register.
+    minItems: 1
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: breg
+    minItems: 1
 
   ranges:
     maxItems: 2
@@ -111,4 +122,30 @@ examples:
                 interrupt-controller;
             };
         };
+
+        pcie@80000000 {
+            compatible = "xlnx,qdma-host-3.00";
+            reg = <0x0 0x80000000 0x0 0x10000000>, <0x0 0x90000000 0x0 0x10000000>;
+            reg-names = "cfg", "breg";
+            ranges = <0x2000000 0x0 0xa8000000 0x0 0xa8000000 0x0 0x8000000>,
+                     <0x43000000 0x4 0x80000000 0x4 0x80000000 0x0 0x40000000>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            device_type = "pci";
+            interrupt-parent = <&gic>;
+            interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "misc", "msi0", "msi1";
+            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+            interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
+                            <0 0 0 2 &pcie_intc_0 1>,
+                            <0 0 0 3 &pcie_intc_0 2>,
+                            <0 0 0 4 &pcie_intc_0 3>;
+            pcie_intc_1: interrupt-controller {
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+                interrupt-controller;
+            };
+        };
     };
-- 
2.25.1


