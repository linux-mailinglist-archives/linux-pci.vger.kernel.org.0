Return-Path: <linux-pci+bounces-9177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A59147BD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 12:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268EB1F22EAD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 10:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1869E136E1B;
	Mon, 24 Jun 2024 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uFJdqBaB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F701369A3;
	Mon, 24 Jun 2024 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225786; cv=fail; b=W+DGBDAHgq5osFPhtKzkppJwjPRp9EZn2aqhBlnumFH76dKqn8DSl7YrC/b/58e7RBsMm35ZOwu7aWg4egWatL9NJXskT/RUyM64dY1mTmFZSRX7H8gU7tqyXDzBcpAtKeAmQicC+UEENcVot8BXQ4x0UoP8YsDrUFY95gbNkvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225786; c=relaxed/simple;
	bh=EO+kjpms1fUrlGcsp/Yq/4cUtaIBAqKwDFFTL6N0bKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdDvg0L1allFi7fylKeQLlYrb8HUgKAtC0BPhfXBPhs6Rl8P5M2YHsdrfkgpAvxPSuUk/aHlnnqNWkD9Lv7mEGXPfDjIr8UzoGcFgxyFrA2OBHgY7hdwAKxzKU5NRB+8P2wUyLL5HGoFtKbtR0qyoQ+sd2o/EnuK+O9HNmuv774=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uFJdqBaB; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2ogamSzHHggU1CnOfhIswg952/Hp8WuSNq2F5qHfmkb5nsHkzOsxO+NeY/ZEvyGzVOX5/I6L4DTLeZTVvSbIWcu2QY/el1vyLbDZ6AsZZkKsEWpt+uZ82aNb1HuBq6nkug3avRvLlmzp2e+0ekEDQaAzE7fpgScnI8ExcY42lOP0I0enVGxjQBD1ikBXbCLLW87lJ5DtC8EiE8ro1WM8b80JeVEOq0/rwYnvFw1pALd5dHJ7Lx+PO6Cs0+3P1MFu4UGAcll/eKPdRfA+tp21E/riLHRm+nozGRFbzr/0xOC8gmJ77iE8dWLiLlJUM0H4V00N4akSUxOlARdiu6s+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXJS9l45THhDwuIPD0INZHCMKj22HA2c0gsgoOad7Fk=;
 b=e9MSj0aCPTsRfcRcKwio6ppGGIxLbWf6KhAgOmtRJ5ndhOkIyYBn/lmlqhpl6fGntzrXpIDKHiJ/5Z9w2vSI0fuhcsPaHV/XtLRs/UQjs1jwJm7zelWs5/lHcb47KFxLSiiLrYbNp44YdG8pw9TbqSYsRgvCdjhFqnaeMbbzYeoMPKGoWAjHY5b3w4UBHmi4xqGConserKwAeC43K6Yi8OlITJxax3Tt1vcMGRiANchB1bBMU1EYahWHz5ycAk/oeL5vrsi8QKAXQwTb/gOxmBDUNGI1IEApBKw2CIQirA2344ww+ZNziSrRJSNtxNn9HWvn0a3sWbFZEzkTzOW2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXJS9l45THhDwuIPD0INZHCMKj22HA2c0gsgoOad7Fk=;
 b=uFJdqBaB6ZA6LAUEJGpobg1wZHlJr8pM75uZnMb4QQUTUtLZ752ji4aAbHvWAOzgYrnJvFEdzxtGgdwVbDwxrB8jdpRWRabGr9qZD07S///X8AFeCoCVsq1ljzW32gngoL91wzdJGmlkgZToHmudzyvCLkYFLW2GzLGqWdOyk+g=
Received: from BN9PR03CA0380.namprd03.prod.outlook.com (2603:10b6:408:f7::25)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 10:43:00 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::7a) by BN9PR03CA0380.outlook.office365.com
 (2603:10b6:408:f7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 10:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 10:43:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 05:42:59 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 05:42:56 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <bhelgaas@google.com>, <kw@linux.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <lpieralisi@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <bharat.kumar.gogada@amd.com>,
	Thippeswamy Havalige <thippesw@amd.com>
Subject: [PATCH 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root Port Bridge
Date: Mon, 24 Jun 2024 16:12:38 +0530
Message-ID: <20240624104239.132159-2-thippesw@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624104239.132159-1-thippesw@amd.com>
References: <20240624104239.132159-1-thippesw@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d03239-8a82-49c9-7c07-08dc943a6b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010|7416011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4oBIHqaYiJyKssLCAR0/3LPa5lNAg3G+7EkBOf6nnUDoBCsOqcMsHlfxPCJ0?=
 =?us-ascii?Q?N76sM7raJ9lULnPMQfF99eFCr0GW44OnQDVZaWLiiGbBWrWa4qGNwXU/GZQl?=
 =?us-ascii?Q?Akjn2zGA1csYyaFqoXkzpeMacv1zeOE8GOk+ObB6pzOcsG0ZTG6kNSnycWy/?=
 =?us-ascii?Q?0BeMvS5tRSDehTra45Lr1ovIEbyLl0DM7i/mpPNSHXOMB7gGDZhy/f8YyWQs?=
 =?us-ascii?Q?iU4E/wBXIKW7XCggOvpYp2A5OGVuf2QGHp3tgMt9g6lhyBWCpM2oFW3OCNuN?=
 =?us-ascii?Q?3ej8IPpg+tCik3WFUm3ifF7ywHc+l7Ntvf5SO29FIAevPD6xx0r9oyS0SQOF?=
 =?us-ascii?Q?QvYzGQD70BV1JEvrxTVDPxv3w7BC2Dz1Ej4IzQIf6JFybQK0F5cSSV3i/JD3?=
 =?us-ascii?Q?6lA/fFILt7ycVouQcKm26OxUVtNyQYMctLmhggnWuTAJ0ZIVMdvseBY7W6BA?=
 =?us-ascii?Q?/SslmgDRwVtwCJqFdgKQ/jQqjjFwk0T+o1U1S5iHbUrA6LxOIBZQBnjonWjC?=
 =?us-ascii?Q?TrqMUKeYqYDzYEdinfLLbGJwLrK6sFIRiPJJAg9mKUUltSUGQfYDCyqqf0cS?=
 =?us-ascii?Q?z8ubyFfcjAe54uRkhK6XkqrE8W16COr7BmBeMeiL3QYGfYGaTYIj73WLCUWA?=
 =?us-ascii?Q?LuFqnlV+LaZQT17aD0ftg2bKM01npMg1c31Ess0RO+JxzrPJ9QxUgoTUaaL+?=
 =?us-ascii?Q?MS6PxwUaTz6A6wQ3m3zG/b8eNYe6SrLAvo5ITaa8hr5EiCE5xg0gy/zmMPPj?=
 =?us-ascii?Q?40+IB6FoKdATvjPckm3H73BeOx5+gAeDTHnjIYr9FX7r38TeMSlBrADBvndy?=
 =?us-ascii?Q?ylubQgpP0nOrW+0Aw8/CscmXXexi7RGGdNVYRQ5bzeMCLXt3Lxj2slyq8rdm?=
 =?us-ascii?Q?tb3zNK8nU/aiNPE6UGusLxiWfFheyNfsOrDQST2M2yl4OW+6Sofz+ScC5pss?=
 =?us-ascii?Q?9aaxYclpLiF8STd2B3InAp/dYyTWcwDtp/K2pg4wRMZnyQGtG0fwiNSYCXDu?=
 =?us-ascii?Q?sWbZz8JWhi/xDVEJ7g9tXMF/gUQAAOhq408lBOS/jk48wvZDUGH3qKeoMks3?=
 =?us-ascii?Q?GMWPZ0BDHyYlsVQT44sUObC5DWSQP3M6zyH+LvTQv1HuwK8Xf2NRdy82C8vV?=
 =?us-ascii?Q?m0fmpfol9hagbCd68yXRwLobOfxdHhpi5LoKEcuEJICqaeOsX/ff5tL5K5Qv?=
 =?us-ascii?Q?x4WTeE3eknAuyDsgNQ1gwo2CMk7ZCQPVmfFzgYHkY9oC22BoKeky0xS9/yCZ?=
 =?us-ascii?Q?jHz1I/ZycL8rYwLr4csdhBghFUmNTDHWBdYl5eQETXTlb8PRXyPrAKKm2doe?=
 =?us-ascii?Q?+9vLeYm4lSlFzLR+K/e6tOwC/cyDP/yOE3TWNTWTJGpke1HKJUlZPQevALUe?=
 =?us-ascii?Q?DchYXLQGEpiKggxFerNwINEd2sbqiZAi2ARpiPo7uYuQXYOW2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010)(7416011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 10:43:00.4701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d03239-8a82-49c9-7c07-08dc943a6b17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779

Add YAML devicetree schemas for Xilinx QDMA Soft IP PCIe Root Port Bridge.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 41 ++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
index 2f59b3a..b705e47 100644
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
+        axi-pcie@80000000 {
+            compatible = "xlnx,qdma-host-3.00";
+            reg = <0x0 0x80000000 0x0 0x10000000>, <0x0 0x90000000 0x0 0x10000000>;
+            reg-names = "cfg", "breg";
+            ranges = <0x2000000 0x0 0xa8000000 0x0 0xa8000000 0x0 0x8000000>,
+                     <0x43000000 0x4 0x80000000 0x4 0x80000000 0x0 0x40000000>;
+            #address-cells = <3>;
+            #interrupt-cells = <1>;
+            #size-cells = <2>;
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
1.8.3.1


