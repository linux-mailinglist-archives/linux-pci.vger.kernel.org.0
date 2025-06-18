Return-Path: <linux-pci+bounces-30018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B79CADE53A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 10:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB93317A229
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BCC27F01C;
	Wed, 18 Jun 2025 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T2NQnlfN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC418635D;
	Wed, 18 Jun 2025 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234188; cv=fail; b=AhBIk/diEzOAz/oOdy7tfP98g46BE+fLHxMEHnV2oklx0+3E4sQowSPCl6Fu+5GMG2O2sqTMd67xljYySn7W9XUV1tYyLjzDlaxJDIxlzEqLDsMlhGrVrWkbFQuC9KhqM4YRC4bkAAvQoMqERMgHEeuXZHRTuBwLKoUlA64o82Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234188; c=relaxed/simple;
	bh=2EbaDkHUKp5Enak4/dVv4xMRksCxekJ7juYoVDbdQIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+CnTOfUdMMomqpKpYWmfWLb+ZU7k5eiXjOFgEU2nz7zBhuvwixaGvScQq5PjzElDLpD6LWmDF0OBWm99M1M6C1sZV6WoCXxEHRwbkvJux4jZEdUb/jvJuhSiBrK2KTWnUFp7GJccvRQNwaR+fEgVQX618ky9vVaOg3xEHqJcMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T2NQnlfN; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZENlPWIjbN+UBaz6GoI7l38Rlm0ZwXsZIEPgdNJs1B/5JHw6EZsw9Oot3Kvhl7gO4WeXEG+1YO/tIeIj/0BocFhJCQKlvxvAJFyeRIfcr1qcfR5ElgPwk5Fa57Ne0E+3YNjo481xMYqG9u1aihSj5vCGFVx07y2pH2IclR5ZgjORD8sIu1cchLCKCKQ4TaGwYY8FT+d4MdfKi7bwjrcZWPvNaV/wDqU3WOfz02rqIMuNakskoE9T5GusDEFyIY96xjDOOA1O7D8ZX7HQ/MisujDM4jr2ZeA3G8R/RcEZ2+/Hra/EQm1b5wSmY/AFEWMS5V9fYWTW2iytL7Um89XgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS9n9RRohJIyhMjVa1EZaphfBBH7y0z3/hYvFYrtF+8=;
 b=xhfhEBn4GZaXHXPlZICHBeq8DONXWea+VZtfiliuBTtXTWesVh+wjWGNJZuD2PHm6RemjKSfFfoeBY5kymbSC8dCA4vfBl0iw9XevBsgLeGDCP4fszMx+/mVStMf15VCHdXogsxiI7S8QHouEsIA76QXbl2ZJCZEaJUSDLDfNmJeXfaREUzLXJNXacvlYpp7rwACsminDlkSe1MGZ+KcCBGW22uamau4zLEPpwcmeId9mnM3pdp+UUH5Ckyi+wV+s3cIAgZuIyyFwhJ+TtNqY0h0hkAcz9J10/Du4XWkB8uYv7zFv83nXPdhYyV+am57iCPIw9ibohWeByHCu03cMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS9n9RRohJIyhMjVa1EZaphfBBH7y0z3/hYvFYrtF+8=;
 b=T2NQnlfNmCFqyr3YB2mL9SMwz7LDRRU8ah+cOdBzEB8llDGRTR4P7Zaiv6hesAKw3OjOMQNouDJxtoOirSb3rn8oogFJukGSj5TM25NwdfybAkeRUiTehdGejaLx+za3dNqMq7KAgXm8r3+2mXH4sEoZdk3PeWdZL3fezNrGi2Y=
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 08:09:42 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::ce) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 18 Jun 2025 08:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 08:09:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 03:09:41 -0500
Received: from xhdlc201964.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 03:09:37 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: amd-mdb: Add reset-gpios property for PCIe RP PERST# handling
Date: Wed, 18 Jun 2025 13:39:30 +0530
Message-ID: <20250618080931.2472366-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250618080931.2472366-1-sai.krishna.musham@amd.com>
References: <20250618080931.2472366-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfab3ec-6a2b-4491-07b3-08ddae3f7ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uXTwDkL6QBBa2tRQlJpZ3Aej+fIFD7Zs5BfaXJZZtX5IRC18gtC6l43DLMtm?=
 =?us-ascii?Q?LbVh36ces0g1QpJE3vR9kaY22Nj/X+f/LmOqaXEISq9fwlLYpjc22QZvwTmY?=
 =?us-ascii?Q?2B+qtVqqA3gQ4lQX2yFxnv2YOZ6DyZvwEaGqVEdM+ScSF0g5Nn/B7c+Ug24H?=
 =?us-ascii?Q?9sEHfLgP7pAoLb2iayxecF7CNKDhbNWsVIZfzlyOxY7MTRtkgQw3zRjEbgG9?=
 =?us-ascii?Q?VSvBfeXTDBRf+g+OGg0MtMhbcm4VJwmiU+Ry2jrO0XQLssRGGDds8pv3D8yf?=
 =?us-ascii?Q?x3WQkzw0FW9ih0Z46ZPGaIPviFHmK5fe01nbyoCkEMN+ydHdRwDdN04cltV2?=
 =?us-ascii?Q?Xdck8fEy/vzYx/t9ZMFUwKn8DdISw8eXbB10cbMeEKc/lrVT35/yFQfjwVAL?=
 =?us-ascii?Q?xDEkGUIPSY3qTYpZyS9WwmUJo4tEvz2k1zqFjvhDZfD9LLdINROplLda7qwm?=
 =?us-ascii?Q?i/ey2pDXvzOZjSGqGjnTOO/oT5q6I1LWke2youimq6/OKMeWLepqolhKGS1L?=
 =?us-ascii?Q?uT/xyEXE0rx9LmNOubDYjQDlIQBPyO2NuzgDM8QAcTXoHyzcBgweW3n0ysyN?=
 =?us-ascii?Q?Q3usZiOmB2zGinGsoqqs2Gk+OqDBR/FH+10Y+mddvX4sGME/HC8+wCwMGdL+?=
 =?us-ascii?Q?si3hfDpjZLWb1B+lkCgjOJIyQOa+5loKlmZ7y0vjKJeRGL0MDbKYh9ifAQc2?=
 =?us-ascii?Q?qm2bbZKD82jQiI1sXqyK26yRx2EQC+FnTl6wphw/WuTve2VnzPPcKSjEqchX?=
 =?us-ascii?Q?dtLSVoyeGuizEY+O1FEJ7wXW+nqBMpcopBSLqzQxtF/+OVT8ndmPnogX8wcF?=
 =?us-ascii?Q?JBTKfjRi2pRrYDw9EmMqRYjhLznr80abiANKvUgynhV3VPD8rChTA3+VWwY6?=
 =?us-ascii?Q?q9Fr80weTJfB6GIiFRN3ZSgfuXIfxTruVbjMP0abHa3WrQREZLdD2Q4NKYrr?=
 =?us-ascii?Q?/PbcsDK6pF7DVqCLRYVTfRjwrOLQF433IfjxHKo7ac8f55g3v3h1caSTv8IC?=
 =?us-ascii?Q?d2CUA2G46v+CzABZgeZAQsT7GUYD0bT7OZde798pe5jks0m2qCLYwz8dVXtn?=
 =?us-ascii?Q?E3k1wfBbO9l1EKPul5wMCXfSjO/X2vQxPZIdHOgI9157rDgzKtcOm+OVvlJ7?=
 =?us-ascii?Q?ayLv36vf0KloHhAAWt24SMSxZHVtDx1hKpqbQSb1ehTGl2uJolKtmGMqd0z0?=
 =?us-ascii?Q?XGXTWSsgAPhE/8b0FYkeHpZFNqTWxmhGvJy5TMq3iOSJrG/dhlUmWVlJId+h?=
 =?us-ascii?Q?7s17OaxH7/Sggr5244tSKVevCsHITZlDrgCSZsiSpbMjmSXq2Piw4fv04H8w?=
 =?us-ascii?Q?tXLtYqdtROJ7K8JHXTBkCebujiXS6tAbTVRN99EqOTUiiKpBHvpGTp3xYkmh?=
 =?us-ascii?Q?A23GmW+3Y4wQqbZodcnLNCte227pRIx+Yo3hAWKXhNWM4dh8bCjqzeL6rrRl?=
 =?us-ascii?Q?Vx2i895HGKXccSkpc8xFCUF5PFpPHvm9LkICR/4Ph8ZR1fsVY6QF+t3eYMzQ?=
 =?us-ascii?Q?oJSKnYIRYDPuUCszlRbv+Gz2X6VXPT/JXNty?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 08:09:42.2950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfab3ec-6a2b-4491-07b3-08ddae3f7ad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729

Add support for the `reset-gpios` property in the PCIe Root Port (RP)
child node to handle the PERST# signal via GPIO. Update the example
to reflect this addition.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v3:
- Move reset-gpios to PCI bridge node.

Changes in v2:
- Update commit message
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
index 43dc2585c237..3ffe4512650d 100644
--- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
+++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
@@ -71,6 +71,21 @@ properties:
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
+      reset-gpios:
+        description: GPIO controlled connection to PERST# signal
+        maxItems: 1
+
+    unevaluatedProperties: false
+
 required:
   - reg
   - reg-names
@@ -87,6 +102,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
 
     soc {
         #address-cells = <2>;
@@ -112,6 +128,16 @@ examples:
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
2.43.0


