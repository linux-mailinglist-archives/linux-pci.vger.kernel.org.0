Return-Path: <linux-pci+bounces-44806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C64D20CEF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29CD5308FFD6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89EC335094;
	Wed, 14 Jan 2026 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gtS7PXCv"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EDE2FFF8F;
	Wed, 14 Jan 2026 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415038; cv=fail; b=Z3SCqCnCmAQLtCnTyhU/RCOiV5xkAcGawW5Z/jK+keLnP+jDdgTV7N02dWJS2hNc3ufz0UEgpTBvJGgArcHIsP0Xf0Ion1eeKCuH5ejreOEinogm81HsYf1K6n4U47IOqNNRNKk+YJH0zM3+5B5qpjZhSVlm7gXk+Mtno9+qCF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415038; c=relaxed/simple;
	bh=X70IPDYXC9YicbQ9DZvsmzYhD4ngb8ZjGjq4RTqFjno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IO5c4Q2BLVhfel0otRlgiEVkpYVIRRPwDf12Igp52GdSJDbFlK+aMwGSNSMx66osYpnDobvllI2WHJK9NzZMcXFPc8YMLRTp/5fpoE3ps769rzdJK2wh0NC/gF3cfPst75UI7siFMCEDA6YeCjqJ2t1bGr3J66REft48OQo+/Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gtS7PXCv; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+CTxX2qtnFrmBwKyohvRbimdYd7mlXFQS/qbKge1EXwhqvvSKBv6461+qPxkpT0LqYUGpSuYhBVRrdZHRdJd18ma4J6haDS5qW4v850IJnBv6fObqoCrzAAEFX4l90DCTOhHfRR1q2tnpBrBQxCIbXqun2npT7yEKsywUhdoHYvkIUh46v3a+GevSo3k1gWQDwKB5+wzejeTtgfr5Sq5RMLVPZZlMOKZC3yZzWy0XYqrcYYbqgrRl3tqTYlTWCzuhYoP+kl8SBixcsokhXKZyeDRMDluQnR3zhD+/6zpA0r+Vsy5ZNeyi2AiWR92d07ZhD74E26TqvpuT+Uik6Yvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/HZ3FrR6G6EiLxq7Zb/2t+2DmaMV1n7ejQacfz8UWk=;
 b=GszXByhZgFODzk9XiYxqIUI1uhXGYWbsT/P4cc8ulB1FYC6aPOnFpJOz7z29Q/L7WgWWknUP7dz/v1TGLroeL4kkA4j98/ITvKHXbJyG2bwHBi8XdVWJF7ILTwbsX7hqvPnAOBtUf/2YAYHn2ZevWHr5BGk673F9X5KYptUMPLgiHYQNGCrUoxb6zNMRxO8Wy7F3r3sNhosgkwFma+a5NbQ+Hjdf34egbQVpf59JAugWTeFCBwGT1thHE0IC7/R6cemWUUK7l8tail2uDCHQHoJ103PYA4i+cXhxdYaesu//Oo24VJPzqEUAriHeZ1UB7BQU+KL7TwETsFlIx1pH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/HZ3FrR6G6EiLxq7Zb/2t+2DmaMV1n7ejQacfz8UWk=;
 b=gtS7PXCvJ4/JCXmgu1/8O09MkXxik5ll3xkbsm+lt03oyj08zEpWckA4VOBKLwDIiPPW3KCyEAo0AePfnnWjn4WZqKbnmqtn779wdxw5JoOzw3i4xIrFFrotR86DVyJwNJRkF9hCvSE2v6zMQ8jmyVzwVVHC2DdDf8/WAgxp0wo=
Received: from PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::10)
 by DS4PR12MB9660.namprd12.prod.outlook.com (2603:10b6:8:281::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 18:23:52 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::ce) by PH8P220CA0032.outlook.office365.com
 (2603:10b6:510:348::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:23:51 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:23:50 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 13/34] PCI/AER: Replace PCIEAER_CXL symbol with CXL_RAS
Date: Wed, 14 Jan 2026 12:20:34 -0600
Message-ID: <20260114182055.46029-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DS4PR12MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e3a4c8-8ade-4b02-2891-08de539a1197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jRMnHikA927kFGNl8UnW1sDPxjm1QvSTcd8HNYhvEVPPQfVRKgVj590zt1u4?=
 =?us-ascii?Q?ujp+tKjf+7MZfc1aTP5fG/169bztKY6xzEUowBNBTDx2l6r99KUU8F/tfDCd?=
 =?us-ascii?Q?vq26oM/mu8HKPIBb4vXsPINH9nXonctT+uZBUCeZTs3YCRd56xScZ8qTYaLG?=
 =?us-ascii?Q?akteq3fPYnneVpP043YkkyfU5SYbJ0nT1u9oHaSX/TbwMF639zifvnbiCQJS?=
 =?us-ascii?Q?IGPMj+DuFVulnQC0v1hqcHwvhwPRspauqCnPYpMcuvm+4RaDcsozrSbS+drW?=
 =?us-ascii?Q?r89K0NDa/Y9pONFK/JFcr5jU6QcbY2T6io6BPpcaRYCcZ4RWcvP2ACLv467H?=
 =?us-ascii?Q?w0spI7lxfPkYiU1LVHrk7VmLyDPlv36lIJzLpqd1XwkpvuqS2kApJYQpYuo7?=
 =?us-ascii?Q?LDyclvJ+TIWXpaPfWedBcwAUoGo2X+ITZc1TyELJtwj4N2IxQlO2EjXBRijW?=
 =?us-ascii?Q?yrJ30Krkp5rkWEWJdEHWE4Vc9sY2iDSORQk3jO3rhds4MTv5birwow/IcAV2?=
 =?us-ascii?Q?rRHkXqWYgNWRZzXN+uRqOKce1j/XMFTHN+UwOLWGcBfzgK1pBTlZ0d9V8vgH?=
 =?us-ascii?Q?SYz0cQU+uBOsluZEP4+z6Mg2TOm9Hs38aRaVeQRIhH3W0yTsFMmtFmfdjUMM?=
 =?us-ascii?Q?YuUrF1tX1fpU8/fu4VIOblOqidCNH6gbrwJ3+LtnQR+pC3d1spzXwaIo1Ujx?=
 =?us-ascii?Q?42lZR33d8+pOCArXcNQ0QQr3y9hZGGlYa+JNDaIvzwxADqrE5xK5opfAQkDa?=
 =?us-ascii?Q?m0kfGa6yAlRo2Zcfjn+Q6oqegHktcJO0PsGXBhZ4m4WhyBmIlcoz3bwtNpff?=
 =?us-ascii?Q?Ry6HvuFASkXcYpomswV0s7wXcljRvOO4IGIpGcmGRPhkiGEgijkrCSsX/f4d?=
 =?us-ascii?Q?ZstwOcfVTpvpKrz+x77Kn/3xebuSOMNRXEL4Hiyx4zcTC4wmHSs/AQSC7cuH?=
 =?us-ascii?Q?gT/UnWfozfy4Yqn2VZRnZWMNvypu6zbSN9NlcpkVgFK5yZWy+zX4EWXEuWYM?=
 =?us-ascii?Q?IAJKISWZBOFmA+XW1YazC2LpfElxSPDliHwRFZxiy5os9Bjxa+QpNmfABO4d?=
 =?us-ascii?Q?WZ4N7Kwp81tc87obq3lW1KgzktCDZTJXvRoqxWFNh8NorQ6jk6/qgXjKtXyC?=
 =?us-ascii?Q?fZdQuVGUAHJsVdgb7WCzPkkmn80pJ3M00ZY5qqobvDV+Bm5P97vhLxOLtYgT?=
 =?us-ascii?Q?B9ibQALOqCd0OOcqNI0PO2AOJiXjNMvR5zolk/pGVD8HF+XhldFZUOWpRiOf?=
 =?us-ascii?Q?UcI39X5bkI1LwnwTdahyocvJM8Pr5vw1tuJkHI23tpishBe/NDj+GTQ5b2JR?=
 =?us-ascii?Q?8zMvBvQBrfvXDlmJ9ESoCQXwnZP9cGvxdX23MVDHFeuHMY8dNVLdUTB2jyWv?=
 =?us-ascii?Q?LbgxJAJLqCe+9dxdMKqKKLnGnoF6ibqcWt9l13sxy/IgTBKgMDwyK/OV2akY?=
 =?us-ascii?Q?jmOODA77V4ZXZE5te3/H/2pE8nXFbvt5fWgeBDWqcVilLzWHNKrjXWdkkpIT?=
 =?us-ascii?Q?VlmMg5ZRtQ+/M/B27uiHjNLHOMDGOeiyVbvfEaoZJLE2ofGImngNWpXdwuxa?=
 =?us-ascii?Q?SJOJR1O8lgIZrtZv87r5HudfVmLXAzmz3/wBYO89gR06ZeItquYm0P7NIPKw?=
 =?us-ascii?Q?Hh8gOIq6C6WfqvOp206xFy4CfxXAdfiafHat+aD1dfvtx4KeVZl4Hu0XefJb?=
 =?us-ascii?Q?Jc1xyFnAiMnc34EiQuHpaDKIxe0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:23:51.7506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e3a4c8-8ade-4b02-2891-08de539a1197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9660

From: Dan Williams <dan.j.williams@intel.com>

One of the primary reasons for the CXL driver to exist is to perform error
handling. If both PCIEAER and CXL are enabled then light up CXL error
handling as well. The work to remove CONFIG_PCIEAER_CXL started in:

commit 4ae6ae66649c ("cxl/pci: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core/pci.c")

Finish that off with conditionally compiling all CXL RAS related helpers
with CONFIG_CXL_RAS.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Terry Bowman <terry.bowman@amd.com>

----

Changes in v13->v14:
- New commit
---
 drivers/cxl/Kconfig      | 2 +-
 drivers/pci/pcie/Kconfig | 9 ---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 217888992c88..70acddc08c39 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -235,6 +235,6 @@ config CXL_MCE
 
 config CXL_RAS
 	def_bool y
-	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
+	depends on ACPI_APEI_GHES && PCIEAER && CXL_BUS
 
 endif
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 17919b99fa66..207c2deae35f 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -49,15 +49,6 @@ config PCIEAER_INJECT
 	  gotten from:
 	     https://github.com/intel/aer-inject.git
 
-config PCIEAER_CXL
-	bool "PCI Express CXL RAS support"
-	default y
-	depends on PCIEAER && CXL_PCI
-	help
-	  Enables CXL error handling.
-
-	  If unsure, say Y.
-
 #
 # PCI Express ECRC
 #
-- 
2.34.1


