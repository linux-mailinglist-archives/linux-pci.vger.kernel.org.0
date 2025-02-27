Return-Path: <linux-pci+bounces-22515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E9CA47464
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 05:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BFC3A7CC5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578D71E8359;
	Thu, 27 Feb 2025 04:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sq2LnGDk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AFE1E8356;
	Thu, 27 Feb 2025 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630340; cv=fail; b=D4KPbk1mDu1Y4mCStwlClf0skv2beZ60ZP5/RVgT6IFSma59JrAXS8sECAO8ThcNaljjKy3bTXV3jE1SQlPGZys2TpzxSiwO0UIusCekvwTZzEqUw+AsxyYtiLdvVOPMxqDvpaq61kV3JYyW5C8aS8yPigz3DK5nA4xgHwas/TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630340; c=relaxed/simple;
	bh=0+tk+y8bmFjD3wZQu4E2Nfkv6nGL/Whnb7K60rcmFVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuS7M0aIsCgzuPynYnamCGCFNtxdm12zT+CcaeImggOTIcIFXdHbCeVj8JF8nRia0BnVS1XMqGWljhhdOX3bu0swUZrixyA+/+8lhRsVFdkDcIa8hpeTYOrbTJRhpsDU5tWOYFXWsploUcR+RR4vHzmL0wAlmKh2Uyh5cxEBLb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sq2LnGDk; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOwIf2g4SEjD0UgArct/dkW9AVnSyd9VIH4HmYq3NF8c+dnBcL/RUjl31exsv/w6RGRnGrcOpOm6TDCSKx6fToO6/F8RS0wXpIq0u31BKGxzg9ocDgh3Ore9AJovc67h73z3OrcKjvDyw30x9ZUnrsyf2GPL0zUOAwV7hHdGSj4fyZArez2u+t91DFkR15Xw9eIn3RiIdUtFtOZKk6eZQxzatQaytfHySOshFAVreWW7t9w7xAB6eSxfM3/lvB7gTagRLRmJdsTJowuPRiRWYi+0cr3y/HmqJrC/FgmO6A67elVDsLBnZqd2Pa29pl89PikpFPBqUK9ZUDyQwkGPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjxD8fHDCECt8GF2YvmDZkm9rfYtKhgzwqLm3XiHRwo=;
 b=Hvh+mMt1GST7Of7Qkn3PMB9vsLKQB5hN3HL2hGHaowwaXP61qSZPHWpEl5oEFRHTv9XG/7UH4rAhehPsAbP40E9/GsnCKdyEVT6J4Nr1QfqLRxv/0bzU3+RUNn2FvMO11fSUXFlJ98DhnEi72NiothHVpN5gIwri0upflbFeY1ptZzyF/sDPCBJttiPd+4gDAPhgFbM/ZM/9zowB8GtMCyGrLiSiG+sOhOn79FRHsBE53INvKZKVlXfpI360c/wXq6UGUaz8HqJWjA5GasAPRQCvkR1bhmUmQD/bLLNjqPlXZPNT8KdUXBiwvNWzEQQASJFQkP8hFreCXaH7ovwdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjxD8fHDCECt8GF2YvmDZkm9rfYtKhgzwqLm3XiHRwo=;
 b=Sq2LnGDkSq1seAP1gVsSjkggnEGuWDmhzrHwwST/SnQ7T9+Q1LMhzUUaTORx49BB7Ueq65WUG6TJqlsB9nqu1JKl4I7aszNpnT4xT0/jv/49Vn5KCycxjnPoWfoAbbBbu46GKtxJrbJ3ejv7tDb4JzZj3Gaoz7TGhEQTtN1YVxI=
Received: from PH7P220CA0059.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::23)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 04:25:35 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::c3) by PH7P220CA0059.outlook.office365.com
 (2603:10b6:510:32b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Thu,
 27 Feb 2025 04:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 04:25:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 22:25:33 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 22:25:33 -0600
Received: from xhdlc210316.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Feb 2025 22:25:29 -0600
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe RP PERST#
Date: Thu, 27 Feb 2025 09:54:53 +0530
Message-ID: <20250227042454.907182-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250227042454.907182-1-sai.krishna.musham@amd.com>
References: <20250227042454.907182-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 096b61be-e453-42b8-4402-08dd56e6c78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TLG+z4W+Nqq4/9LAKZn4rxO2h/5Z6qDNsycxt7A5IEqsEyEHGcLQLKWUNz83?=
 =?us-ascii?Q?E1QqoOv04QaTsxipRm8SdPJpzVX61hMl91TcLmrfKBHAhjoAz5IF2nX/0SwD?=
 =?us-ascii?Q?fQl1+6R/McuwU+kyKcmRa7vUpzsNMJa88td8Asm3TDS78rm1701Q1Qx8Z/Xr?=
 =?us-ascii?Q?e0Bbw4MT3Y921gfNHoAD89V/qVuP7RHpB/ZypgtTbHxuRgB6pwmrcyfMOOXu?=
 =?us-ascii?Q?v59eQeK4pezJUTKOJwx6Vj+q+wezB164QKzpZDRyvE3pPoGs4v3FDLnWRrjG?=
 =?us-ascii?Q?JiDCOqgZtJ+7aZaVNoY9G6Yg8jkBrPEoOOjfqYvv+XbHrtE4JUhWhAsSR7eE?=
 =?us-ascii?Q?uGQeUCFzN6UtvTPBn/sKuwq6FrLEOj3KX19sX0Jts0CANeiCJbmodwEH7QCo?=
 =?us-ascii?Q?o+AkgVF7Bl2jdjl3QGrcdNE4+JAQWh6ekBc3NEL7TtgkCq1kftpWwp705Rcq?=
 =?us-ascii?Q?2H6legXLMNQ2vJyjBFrShpm/r2bMsOdzR1rVb+q2MhGFomjLkuB9w2CdR70y?=
 =?us-ascii?Q?QBAduSVDhCOqHDU2a87MSiPBi0tOkNNDLAbDk14tHXE6+2yvQ2ZNyqK/mXnJ?=
 =?us-ascii?Q?gf/dIrQ5G7rgae0m2E8ZwvNQU5T5ybabVXlPyRghTofQEnkuzW6ZvOS8UzXs?=
 =?us-ascii?Q?4FejOOtXhLoFzEcUEnkVFgDF92Q0PgJMBY1jTMTLKoLTuSliJ0m08OG/3a56?=
 =?us-ascii?Q?Qljj+mdskIPY+HrNKUWDTujJmzajNxqrPBcDX2YuJNNkhJ0y0nzjrHWjulwn?=
 =?us-ascii?Q?19BL2QCGPnjXsK64l3M5ioZD0R7Kx7AftC+umVrLvod8dBsf2DSGWm0R7B/H?=
 =?us-ascii?Q?U3tSdGIpZbw6M4f7r8p7KRAVXPgvwxBKadNYpOvojS+G9PEeZH6pcu1fn4r/?=
 =?us-ascii?Q?7AfY8+UQYUrwktXSQDRsvYFsc8TDarUerGrn7si9c7EeQPs3koCaKD1LRnds?=
 =?us-ascii?Q?HYRRa0Z9cAfY1v/JJNvfIG8RZRD7zcrQj16O8SrFHgEd5tNn8sXWSXNSRbdM?=
 =?us-ascii?Q?H0uO+NRy5Re+Hi7J8zHKPqj0gOgc2FsA/YvgbWn+gqWf8m+fBzpbqEGkqPAd?=
 =?us-ascii?Q?rHS0+EPTb0F4pl+z46I4kUXBTq93schTL/S+tdm1GtxBUAoVqvoW7mI/KMiN?=
 =?us-ascii?Q?bKXs/Ye1v+U2ESDZvG24d+dOWCLLgqPhbs7LJ1VNOXjZGWFEqTi1IcjY6yZk?=
 =?us-ascii?Q?9kp41410W4/4kuB69fQSyo6H/np018KHjIkEF9JPKSkBLcneaapuJ9Yd2xdp?=
 =?us-ascii?Q?nCSXupPQ/wdFjSSKGt5vtDGd7Rr7znbZR0B8WXQ7d0mWUENSfHxX/EELT1wJ?=
 =?us-ascii?Q?B7UF8NTFkhK7b1cS7m0EkuaeS2K8LyUgbOBUxxalOwU1UbgRL6VHfeeqXEoV?=
 =?us-ascii?Q?dTtdrCsgc+Dov8xeHwX3gKBrM+9n6lMdHlJWUbcg+L9Np29Fsz+QfLceN3Ok?=
 =?us-ascii?Q?gpGuWZ7g4FaCYg2vu3hfEQsIXbb8Dz+F0C8gfwoRfkQ/twZHk8BEJXoWv895?=
 =?us-ascii?Q?RmauDCmS/BmCptk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:25:34.5281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096b61be-e453-42b8-4402-08dd56e6c78f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591

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

Changes for v3:
- None

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


