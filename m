Return-Path: <linux-pci+bounces-33528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1D5B1D382
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 09:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781FC18A4985
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68CD246BB7;
	Thu,  7 Aug 2025 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sRUHPypi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A02243364;
	Thu,  7 Aug 2025 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552438; cv=fail; b=ExgN1Kp/XJYE7P3Ueryvng8GEoE/eqRGhNVmjhFjWXUvPp1etzcINKubqrCuZfjgNRi7p6K8AkWTvh2/w1TBbMoDyBAPXb9wxnDVaSsQFHFIA8GuXPmujhIjyFcIWDiNowpcQVCVx00zhTF6HxhAyPYeWZeJa11rhd0ow9WDsDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552438; c=relaxed/simple;
	bh=xzHGZsJqNfbrF/+O0hHhpUXwR0CxEuzpyspqKcWhtkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGpMiwKnTiiDvY8pJChoWCXu3su54v0Me1eMpA6amGEX++e37QEnphwlEEvOrfv6nt60NSecCNgklYKSz0V6v6Q5UyArgISxld8Vb+2hqkp4hQjxPbXEmaZfQq4mq2+ES9NH89t59wx5ewQiJZNge+oTY+x+4olVX0zMUwzgSrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sRUHPypi; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFqnDnD8yVNcqwqXlddFAPH0dJzmFY5jQhuBaxhn1mdKihca0MqTK3AMEVwyTFjxeRg1OkIZfLzJLhgqghWKb5/t9NOeVnC9ylC6RYghzdeYE2jga2lwf6rDTV6oAfuxtiN27/e7Rea2ZSHyihnHvffy7avcuvm86nWJaRhek1qF1USRu6MZv4PphpeedYpEQp0Z5o59Vu/d9q51B9W3MblrOH5Pmk6lVCkZMg5PkrWGYRoXLE5bUANlzoUk+cI53jgp+3YBc9F8kKSZbis2vD8rpjRdNSEcMaxD8LKryahg8nbV5L2S109PyanXrw0xcmIqWk/0tR8wAQwSEhBL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEyTzHVR9Be7Y+FhzjFKOEokOT8Z09P7ASdpbzFuJNY=;
 b=jm7bu1vm6yHvBlWh+Cc+Zbr5dRAjfie1hOk3pNc7MxbZYoqQfi/Hrbg2/CTwE8/TlXrsmQs2t8pp0iuMZGYnC0XzBjJJCcZVg0YpBcZOmHkuTrltOcL1+DttioFALyf6r64vm8nuTIFLmXWDx/px7rJh58pab+Y6T84OE5G+QIVX6yP1C+6I460uaJNAJwvcmKLwP41hOiiRqKIHlTWI8V8i4/o4gopZFPyvXKpwQLMAdWQDLrojISaW9dSA5clAsZQUvoEUK7GKb6Kl+F8bB7/OnMwNTad65mMvieXEQWdVUlzbYCgYazQfzZ6unL9KVe3ssBU/crSRB5ZroVB8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEyTzHVR9Be7Y+FhzjFKOEokOT8Z09P7ASdpbzFuJNY=;
 b=sRUHPypiyn6jJHRxSP1m5KGvulVLKV88zKOsX/Urw1C5L6oouwpfWYNqpYPeR9igTrIobntrMMdT9z3DmQE9WHXF5/y5FLEmkmq8mqyRz4x7riuADOzeQWRtCX51H7uFHVKgCV2u5cbPeTT0dckaPMXUKgjVmkl/ovkOsCVOIW4=
Received: from MN2PR08CA0005.namprd08.prod.outlook.com (2603:10b6:208:239::10)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Thu, 7 Aug
 2025 07:40:30 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::c7) by MN2PR08CA0005.outlook.office365.com
 (2603:10b6:208:239::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Thu,
 7 Aug 2025 07:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 07:40:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 02:40:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 02:40:29 -0500
Received: from xhdlc200217.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Aug 2025 02:40:26 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v7 1/2] dt-bindings: PCI: amd-mdb: Add example usage of reset-gpios for PCIe RP PERST#
Date: Thu, 7 Aug 2025 13:10:18 +0530
Message-ID: <20250807074019.811672-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250807074019.811672-1-sai.krishna.musham@amd.com>
References: <20250807074019.811672-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb8d5d8-69c0-4dd4-f090-08ddd585af60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QVP6c5T+/y2nrsYdIf8QD3cMl51HdTYDwheU5KGUB6kCURPfIPOBa8SiJ7oP?=
 =?us-ascii?Q?8+JiwSje3peUi+7ThXHmAL1rond6ZXLWH92nlpYHd3PEMiKyL8CwC4I8r4Gd?=
 =?us-ascii?Q?jrU9hSu01txv3RZuZ6VEjNgjXOMAz96cIy9AKa7tw+6UpzeSnKg0hnoywIw3?=
 =?us-ascii?Q?BTDCftHEx493vIMZKB9UYbZx0DrWiZmZTtS9Nw/Ued15GCebN3RHbCRgGJ4C?=
 =?us-ascii?Q?ZeoOXGR6X6uh59FEygU8GSx4szgjHeaF2spZIwrzeILgSz0brl+CfnN550x6?=
 =?us-ascii?Q?V61Wvg3Xx863QZmR1F7A3CpUUlLLZlzNE0JO0wdE3UDzBh+BqsST/1DmpFeS?=
 =?us-ascii?Q?LaeVX4mV98/hrQ1tPZ8QLnuGyqCly3kBzu4G4sQlBICjlnflvOUlp2EEKxPj?=
 =?us-ascii?Q?IZbzELIR1de4asBTLIqP9gMXo/0tL3z4tv4bRsRNSZgNfyW0Nfi3e6PTXxDF?=
 =?us-ascii?Q?TD6olEVWxJjFQL3Tuaf4eatTEThdTiRx88XX0A77nkqQpAwjxoxymdMTIsVr?=
 =?us-ascii?Q?JRNW3uXvsRzX6zmn+2GfJJwxgWeKl3MrbC9lch3P4fgfMJyxhC6+rRDeBp5K?=
 =?us-ascii?Q?VSytEc4NxVA4r5uqhAY2Uk1JjRUDE8Mn+/HGuiKWw58BtBPd5AgYXp1apE+O?=
 =?us-ascii?Q?yHV3Iui/S7hc/ADnbf2r2vSo1txyLLLQ2fqOJS0Vv5wkGxgAM1qs/xd2NC8I?=
 =?us-ascii?Q?HagsHzfIrZTztzx7ULlDl+tDi+tqEMArdEwsuq6OgMCFr/0P/jBUjJ2SLsEH?=
 =?us-ascii?Q?pVv6elgIGrRnY9Cz6ZjsMZ2wlyDNEAsKGxN8E+rzSE8lmy2AClnlKzHR1dzL?=
 =?us-ascii?Q?KWSDSUSnOwdAum70QtNpdL5E8r1KMvMC3VvMZycZFGV951iXSfQZHeRT185H?=
 =?us-ascii?Q?/tmHgNMoYAViS2DSWqQ/IisWUA9MaM4IBLNzFt+R4A//NUsXdkROTpKWqs0r?=
 =?us-ascii?Q?1osFtDOT7P2kXXleMvyLf4/zbDTOrQ2IGRVIaLoPuMzwZlIY8VKg7SlPH9HX?=
 =?us-ascii?Q?65UQxRkpXOgBNn485XwsPYQu6GZs8qimquRkcunFnBM0M1ClBsg99f5Lcb0A?=
 =?us-ascii?Q?oWrzNL49YbruUX6yAdYqiDDYs7GdVYQaEv1UPHGVyZuuJxdua/4YvyqpnMlt?=
 =?us-ascii?Q?zxVwvwsTuHVS3znMwlQK41aPpr3h0Fx3qGDChvA+d4dqFzzSAkRU0yrlAx3U?=
 =?us-ascii?Q?3/5M0yREbubdSU9t6gf2nRTYx9wEDa4JKTxH9kZhyuZD9XdQzWZ1xCX943pa?=
 =?us-ascii?Q?5ioQpMze+qsU8iwdM2aMVWb6gj+gdxdeYesFYQr3inanuWiVZ8hVYGmANe7W?=
 =?us-ascii?Q?DBg3n//aVQjzpov5VCaHtkYhfLteaZ0wf1A/q2GO63GEgGx16H6w/p2b0SfW?=
 =?us-ascii?Q?J6dqYzx8cUFGIRjeX/qzGLRiB4siXAqpcQ7wnXJIQpwJOCrJMSrsOag+WkIb?=
 =?us-ascii?Q?VxMUTAfGDjxu3/8H4qTCVF6yrCC1y42Esmvl4aV+ZLXYBgUPjt5f1FDSjgp2?=
 =?us-ascii?Q?Zcqd/os9mnrL2zBQDYXbyLK4B5G6Byj2Tk8r8jmubBZvpTCaoMvXs2lUvg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 07:40:30.5783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb8d5d8-69c0-4dd4-f090-08ddd585af60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206

Update the device tree binding example to include usage of the
`reset-gpios` property in PCIe Root Port (RP) bridge node for PERST#
signal handling.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v6 & v7:
- None

Changes in v5:
- Add Reviewed-by tag.

Changes in v4:
- Remove reset-gpios define as it is already part of pci-bus-common.yaml.

Changes in v3:
- Move reset-gpios to PCI bridge node.

Changes in v2:
- Update commit message

v6 https://lore.kernel.org/all/20250719030951.3616385-1-sai.krishna.musham@amd.com/
v5 https://lore.kernel.org/all/20250711052357.3859719-1-sai.krishna.musham@amd.com/
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
2.43.0


