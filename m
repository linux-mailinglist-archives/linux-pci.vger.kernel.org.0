Return-Path: <linux-pci+bounces-9180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1F791481C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 13:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFA41F241E0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BCE13776F;
	Mon, 24 Jun 2024 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XyBN3dL+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20DD1369B6;
	Mon, 24 Jun 2024 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227381; cv=fail; b=u8OJG+6aG7nq4Btm4hQaoaXbo7VsB0FWOAjvUHqXsevYDlI1jHw90OoVKZ9k1+uzo5FybRWUjKjn9gr0nNi4cFCjTlZXQFSlpvB/8roJpZkLpyD0dogQkiQfbSEwpR0m/AkYMQkN/KaA9UtqqcFYgGwWFUgTuYPy/PDFg3ql9I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227381; c=relaxed/simple;
	bh=EO+kjpms1fUrlGcsp/Yq/4cUtaIBAqKwDFFTL6N0bKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWqfaYfBSrBDQWRxbCcRApKqULWGD7G6V8kThUmMkawHy3Zx4JFX0XOhyfQB68F0W7CJ8LfA9bME5N8Nz5j2hNYrXdovwvWa54YkvTVHeBXMe2JbyWmiXO7Shq0k4+u/iVFrwvioki464qdHA5ip42DGmd2rX2/q+2vnV0uezBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XyBN3dL+; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSDKp5J0V08VzJemXXnvf2UtaXfXyipjunVKjekXSrLkFOUHfv2IJ0NZjZUL0K4FA6hg0Kmj4ZSLYy0LEf1qv5GPBjPotYR0/CXWezgK9nR52YU++rnLnDzTpiFVCa8xylsgMSZNhubBSs1e0AEU7q+/24WPx/tucllp6ZmTGNlt3rIbSYzbHi3145w5td2kmiDq0p9JD1sVsRUelAdsf3jhQmw7Za03cMaFyyerhgZ/ktBvdY4u1G/9VxxJJUMrqbhI1nqr1RMh6oQNnbMsB6enHoFL2FJTlNum8BrW6H7Y+ciq5WkJ6EyCQIPTg5amAzTnI22uMHHjoxxWHNNHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXJS9l45THhDwuIPD0INZHCMKj22HA2c0gsgoOad7Fk=;
 b=aeDsQhjUUfxHYVj/ikC3Q+7+SJXpqJNmt4J/IqhQHMacW75dLW1zlXaiTJCObADLcMrcGOmFd04eYcF7xdgLDyxeieuYdxbcTtHDfNl7XdiHxGP16ji5Rbx1O+DAWy2dqdLpRiuAMA6yhDFEYiSHww5i4weNTHzm8TQnTojk4ye+JdClCC0PiXsF9PgGR1gw3jRkhOX5ubjo6wlOhRKPgTjAe9opGd74XHET715d5cSgH1V0Goz2PjmiyUEAFAzaSqaRApeWyQkXxv+0hMos9/KCY8MBEtzWq3JT9ZTDffawQkxaDD4TzPDmx9ZRhCF6tibWyPOSoeHm7mDgAyPqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXJS9l45THhDwuIPD0INZHCMKj22HA2c0gsgoOad7Fk=;
 b=XyBN3dL+rmVVesbkGvOFwE22F6CEKdcRN7K4scoVDn2M9nVcXLygU3UV46te8AyLKZgUbxdu3cN93Oaw8POk0FjIS6esGg0Y5Yd5LoMO1y658fui9oaOYFB9tCTJvuCU9qxkyYXYgQk6BU1nog2Ny6kxJkq2iJ+13mtIzo3z/fM=
Received: from SJ0PR03CA0340.namprd03.prod.outlook.com (2603:10b6:a03:39c::15)
 by CY5PR12MB6107.namprd12.prod.outlook.com (2603:10b6:930:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 11:09:37 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::f0) by SJ0PR03CA0340.outlook.office365.com
 (2603:10b6:a03:39c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 11:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 11:09:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 06:09:35 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 06:09:32 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <bhelgaas@google.com>, <kw@linux.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <lpieralisi@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bharat.kumar.gogada@amd.com>, "Thippeswamy
 Havalige" <thippesw@amd.com>
Subject: [PATCH 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root Port Bridge
Date: Mon, 24 Jun 2024 16:37:54 +0530
Message-ID: <20240624110755.133625-2-thippesw@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624110755.133625-1-thippesw@amd.com>
References: <20240624110755.133625-1-thippesw@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CY5PR12MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 7020ae60-7e00-44e1-cb73-08dc943e2287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?txJD2slECwGP6tf/foPHgxnjWQWYkui+QPkP/8WXKhnpizxhhZpX4v/+iglW?=
 =?us-ascii?Q?xrw5+5LY1X3ruXSFANBFQt3u5e0fWHr6niOpyRdI0kIAgHgyH6Vt22E85QFg?=
 =?us-ascii?Q?tOAMHMADr6sZkzTcPXV9eCYNRCiml658sCf3odBIb2k/dBmyqXKAsi6CEVxp?=
 =?us-ascii?Q?Pkr3A4SP5K4jo/h312nMYvzF9Arm7FfzsjfdiApt5P69yUHLaPoDaqv5vROc?=
 =?us-ascii?Q?7lp5SvipqcT5EJkTPhikONEZcbYgYHtrRaz4kYf+HE2De6zkM9lrlBDoiYul?=
 =?us-ascii?Q?0KstOo0xp2wVx0j2qOjW7eIOW6QvkikAX5t1M0h4p6g9tdxV8yMPrqZmdHN4?=
 =?us-ascii?Q?IyTXfOoyPQcNuGZNAUHOC812pJA8R1owrTZ4YgNtrr4CkaL/penqt5lK1YHn?=
 =?us-ascii?Q?Edms19vH26KcBdjox8fMmtKwJlWuWnF1ipN7qWoDuErcKVUCzQQf92SVSTkV?=
 =?us-ascii?Q?18asr/4tFesf7xMcAVjNTg0dizDN+UigU1lWQGx1gJDD+1aEYKC9OokHGxfn?=
 =?us-ascii?Q?JJqS3I0tPcPmf+Q+BdHYQ9U7iE0CEfDrpGurT+NuqjL0qr+6P4AdT1KxugEY?=
 =?us-ascii?Q?6zRMJMuOowehOhk5H28yZSLtyNzYVeqTUMCtG2GF0VByNSDsw2Iivx1N1KoP?=
 =?us-ascii?Q?tcMSItNDedeycRH2T1TPCPLp5nyNnXwTYeZ2lvpE6j6ll2P+mfhPhUTLl5l4?=
 =?us-ascii?Q?QD5DOV3YIYAw+tG0etZGYcXNeLauIY8flScuodK2f8XgAOiX2A9xWsU9UVWG?=
 =?us-ascii?Q?eoQ90CT1xp2xaXCHRV5IET3SfVvmARYnPC8YXAjArz3tpyK1URK5rqnmL0N7?=
 =?us-ascii?Q?IHKK4B90YBoe4QRQvxcXslvoCHq2Kmq2chWqyK1lB/BHGcah0emBY6QL1rE0?=
 =?us-ascii?Q?Glq+x2R/pPfKKHKnJVvtH4y3LCKxVssheIzC2a3LJFTwutOIuADV2FEPVIlb?=
 =?us-ascii?Q?wm3nNyxUC+7d9rlYMVgGwBp2nD+/GIjIXG4APgbJUn9dez9iKT0givMlQbMc?=
 =?us-ascii?Q?hkOSwDwKiisv83v/P4YtgVzaLY9AYFNWfKZjpbnKgf/s81yz5lqtSmfkIflF?=
 =?us-ascii?Q?T1/nNgbgLfeaawV9iNwotaXPrweK1rL11fJ1C17uHNLSrB6dNV9u1l6Pqb+y?=
 =?us-ascii?Q?P7/3b+3d3HO+PIscl8M6KflHuxFlLUCWYVdxRSjsuudjfwXiqXbRjW7ougk4?=
 =?us-ascii?Q?/aQfNsyV3mfFsskIbUAxvswi/LdZWwu3jmwmLAP1WSnbBp6nYJXuQGyuLO8n?=
 =?us-ascii?Q?R4a28mAEXH+EAkjV8pD4X1vAdeGVC1h2swj7wXupNNJsMz8aPY73hI44E1gJ?=
 =?us-ascii?Q?5fIqj8ijDq9hdzrFQubE0llHN/D1ND55Mq7b1AolTENd1D3eg6be2dRvaEMg?=
 =?us-ascii?Q?r4Pzq0z943wz+5gtRgHsbNI4KyQhS4bkvrymo7IKmn4fluRyXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 11:09:36.6413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7020ae60-7e00-44e1-cb73-08dc943e2287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107

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


