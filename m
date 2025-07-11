Return-Path: <linux-pci+bounces-31905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37EDB012A6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 07:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4CC5884D1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 05:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17D91BD035;
	Fri, 11 Jul 2025 05:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NBd/UdVw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DE190477;
	Fri, 11 Jul 2025 05:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752211462; cv=fail; b=KXziPXEkB6kRk8UoS3BOo5IMLxyUGevBDlrAlVorZV/I6LiI2GE130KvnJ4j7QVs13D7AfigmB/V9IkvBF5YaBnveGaUArwXuvYled0YOCFbf+VT4seuSwCV6nXSdDHZHcZx9PYoUDXM7Y3rQDQt89hdIAfmskejVwnsv1Cff4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752211462; c=relaxed/simple;
	bh=rNHIDLrxWP5o0x6/qY0dYJKQH4GfqHLlv09YZWgBZg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZvwPSKKMMZeB5WahcHiE5QxMb5knr8oocC71PuB8o7dvfSkz3Q24AyRSJ/b4D9xdQ8AZEMVkD2+8CQlwIUgBQMj7tNCYifwhAooCsCE+mXqQRUTluL9x2P2+FhVZhtOb7rMGghDg5lKlzoWZ1aeF97vrzYs930miGmQJ7bORZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NBd/UdVw; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qL5jLV8uLIc478J+/1EVRx0B1s630Al61x9c1fvWN5ImvXyGq8bZ1ueKAKGSW0GGQ2AJP2X3JBWuR4bzDb8uNqhQfBWKprlDJNjnlT+/CYh8OM+tXltfR3bLqB3+n7J02dGaWyRW7u0QgbjX9Y7EBY1YJXMKSPyxbK/nZyPwoxg2gbvaqq7QAOnqltRzVH6qJmn9FSq/k6v1ywxAxNg6m8nc1JySwr4GGl0rc3mPGt09fo1K1h/uiN+mZ75sP4O6Y3fMrppLbXULi6mFCb3EYycq5m63yzOKdHqGvL1Da+8IMvGe1mDiLVBOBpQl/6bycpRqwGhfKRciFyJzWDpGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3Pmxvh9Qnf0KeuKBgBo4tj6FBpNz7o0AR+nSILzrVU=;
 b=A/mJmtvJpzvRFGnradnfbuf2Rz1YJj5DaiEkrHzTuZ+2OCoUGtmoiEgWaAuM7VT6NYXyhla9y+evlvt97bCSoHm0XQ3Oc8UO0NqY/pBgE2oSn//Dk45JSoaWqgDEsVegXcCw63H+t8MIbopPWmOgiIRHK2ix4AjgQx0h4Yv/wMjc02E864LtT4TRPArIE8woRyle9PSVkFbZozWyn+LX6mBgx0ramnajuoTMaNgrEzuLLgBzMLk88Cuaeq9pQxb82f7CDQx6iIQXGLzyt3LpitUgDArmBWZ+CkyGdXmfUmICM/NdZe79krXnIrSn0sRhzOMWsDiQwIWX1F1IwzRmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3Pmxvh9Qnf0KeuKBgBo4tj6FBpNz7o0AR+nSILzrVU=;
 b=NBd/UdVwJcXS4FoFQxfLl7xdnof4lDLJaCsDHYYaJB3OHyF9Jn5x1w4ajuXN0+jspdIrNh4wI6aWptyZzkBJ56UhDZwTPLncnV4hJJnltHdUUfk7Xh4TJnYXSbRoACrpFRxS92+BwYWdSxGOhpB8fRwhbh6YraQS10zB+AqjISI=
Received: from BN0PR04CA0097.namprd04.prod.outlook.com (2603:10b6:408:ec::12)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 05:24:17 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::fb) by BN0PR04CA0097.outlook.office365.com
 (2603:10b6:408:ec::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 05:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.1 via Frontend Transport; Fri, 11 Jul 2025 05:24:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 00:24:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 00:24:11 -0500
Received: from xhdlc201964.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Jul 2025 00:24:08 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v5 1/2] dt-bindings: PCI: amd-mdb: Add example usage of reset-gpios for PCIe RP PERST#
Date: Fri, 11 Jul 2025 10:53:56 +0530
Message-ID: <20250711052357.3859719-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250711052357.3859719-1-sai.krishna.musham@amd.com>
References: <20250711052357.3859719-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: e80b4ac3-b143-4d60-85f2-08ddc03b2e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wSXU9/vsxd7yLI3bBV9tbiWEhmKHU2Gsci24i/NOje4DpFKzXW3YQASHvEm4?=
 =?us-ascii?Q?LY7ULuW7JByx/rdrzxIjkTJN4omqgDCqtjzaEko0KkhLgmy1QsQ3XsQIpAr2?=
 =?us-ascii?Q?wXb3xHgdS3JmPRQ+v8t5AOS7/YVJzcBUoDwl8F7V1sCVS5Yjjwf6J6j9GaH6?=
 =?us-ascii?Q?/cDpkmA0DvGczEX0Gx6nG4jSVVpLKnCtsjlt/mornFymHWtJ71uSkE8qjpdC?=
 =?us-ascii?Q?Y1CL555mRfLw6cFoXsat9rNxu7GCvEAaaIZmHZe/bqMQfr2E3tGvPDH3m7S0?=
 =?us-ascii?Q?XZj4huH9t6fiU0tnQd7vUgSnbyUgBRFV2DXsWqV8AN7wAdh2JUH2pU1JJxc7?=
 =?us-ascii?Q?wfGzBFqQSNTaUXlKNZHPEJJOkyNj9Ak2dMRy2cuLbWmVYNRMVakskKQENHeX?=
 =?us-ascii?Q?z6BFN0Knvj34enF/MqFT/HUyLfVwWfrb8fwdhjAZTDbVK6sg5FdMqRBrI32Z?=
 =?us-ascii?Q?tBPfjehp8f28L2tkxnU1KpmeXiYMNTGk08098ZkEvSVZQLZ5rzoXLAOVyqMQ?=
 =?us-ascii?Q?E1zBVINisLZuCDHQA8M9gFK4lBo0pW2VZXPvPSm1zvJqFbj5Lbo+ZgcjlpPI?=
 =?us-ascii?Q?kwFvGSeD3afH54u/DPRnYFfDE3TuVvAuXFEAS2cLk2B//D8WleMWqcBYs9gz?=
 =?us-ascii?Q?aoU+YILiCH3jQckAYAEq1b1+xI8uHeYqc2VlJ8VYaK4/4h8of5W3X6fgqEPw?=
 =?us-ascii?Q?AheQOtOJHepE2RQO4avevrq0X5v86KVFZTu9g9K9uwy+9NXgcnkDQELosYhL?=
 =?us-ascii?Q?wqBh1RyRWS/Q1/5OUNtF3lhSv+KQv/EtwAQctnn42AnLlJDh24meah0+K3qW?=
 =?us-ascii?Q?HHpml5DghUD5dHzAZj3pTbqostYUG3fEXFZ5wnCwZP56mgqJAXryytHWgHTq?=
 =?us-ascii?Q?7oiNxdIbKWhSiXJakj78EBKgyYPMtmyMPB6Ebre7gXQ3MIaxDBNBcXhTZyjF?=
 =?us-ascii?Q?oCgpsQ/OiNhpPWoPd3F9w/s4sVneCuK3T++grg0cn38g9DpMbThd9DpJaeW6?=
 =?us-ascii?Q?riVDOd2t2ROYGkXkBkVLuxYnmuSjI6j7s4DtyFs9QJDOiQOvPVsTnLN37I0C?=
 =?us-ascii?Q?wvnYS2pKkXuta1qodrEmVwZt9BwRrwAdMl+bYL+3FHhDyKWRmN+6qSlyJG6s?=
 =?us-ascii?Q?ZIt8SLM4poYXxNbsquv1csIi7yIr3NpLBUSSXg3zChJMkQJsLXuQLw97JjqG?=
 =?us-ascii?Q?WlHWf5ixd67Y+JWqc+mNyVSLwFu1DN72+6UlAuLp0K/cGiS1HnHqIoanX29N?=
 =?us-ascii?Q?MFquX3tKJQwlk6M49/3PBEgFkE3+PB6UuNsxRIP2BKlR8Uowx9T5UPhB0k0c?=
 =?us-ascii?Q?Sbr7DvgQa9+YPR/uJAIYk73umZKoq7QbeZ8R5qs+0MA6VH2HTS1HVXtQ2btJ?=
 =?us-ascii?Q?m68RUvm6KyvtJB2GHGjbRd+o3rKpGdonoMuThzjGFOVc4rY+RvDWKnl2MswK?=
 =?us-ascii?Q?Oe0QgFKReM5d/Lr5R4F91gckb7/cwd3oxdUuhk3pPBitrEcd7XN+XOPoVb+O?=
 =?us-ascii?Q?4d3CjO4jxFdg34W8AmAzgjPGachLCJeDlLI59I1QXe64jYGRPeNs1bBm1Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 05:24:16.8875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e80b4ac3-b143-4d60-85f2-08ddc03b2e53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151

Update the device tree binding example to include usage of the
`reset-gpios` property in PCIe Root Port (RP) bridge node for PERST#
signal handling.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v5:
- Add Reviewed-by tag.

Changes in v4:
- Remove reset-gpios define as it is already part of pci-bus-common.yaml.

Changes in v3:
- Move reset-gpios to PCI bridge node.

Changes in v2:
- Update commit message

v4 https://lore.kernel.org/all/20250626054906.3277029-1-sai.krishna.musham@amd.com/
v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
index 43dc2585c237..421e1116ae7e 100644
--- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
+++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
@@ -71,6 +71,17 @@ properties:
       - "#address-cells"
       - "#interrupt-cells"
 
+patternProperties:
+  '^pcie@[0-2],0$':
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+    unevaluatedProperties: false
+
 required:
   - reg
   - reg-names
@@ -87,6 +98,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
 
     soc {
         #address-cells = <2>;
@@ -112,6 +124,16 @@ examples:
             #size-cells = <2>;
             #interrupt-cells = <1>;
             device_type = "pci";
+
+            pcie@0,0 {
+                device_type = "pci";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                reset-gpios = <&tca6416_u37 7 GPIO_ACTIVE_LOW>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+            };
+
             pcie_intc_0: interrupt-controller {
                 #address-cells = <0>;
                 #interrupt-cells = <1>;
-- 
2.44.1


