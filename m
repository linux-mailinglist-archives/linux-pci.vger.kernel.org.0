Return-Path: <linux-pci+bounces-15133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46E69AD289
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9118B282DEB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9CC1D1F50;
	Wed, 23 Oct 2024 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W9D2GKil"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4E1D0E05;
	Wed, 23 Oct 2024 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704135; cv=fail; b=Nsk75nXTETg4z9ZFkDf0k8p3Ua4JN3T1gjSOqAF3210KI7Wkvd3nsYfir9K3s2MZ8f5w+xARHjBDy4hgTJr1R4WWsDL0A0hSayEs8DoS6pD/9ltWtQZJF17eSjFYn0G7QaDLK0Hacq0XI0yXlY/sZkCsbJPe92c4Q/bJX/H2xUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704135; c=relaxed/simple;
	bh=6QTTtZIOCJ8NQv9QmRENZ06EsAD2DOL669+fp4rUoSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9S9qFYW2HYKZUM5y5gQyqRZGVpwwCBxdQj9yFtm6YGc6o/x3uGDgXzwUJJiaVDkMnEJDSKtdc7ebAc1c5k7KZOi61ClcLUIPW5n0KN/+53VnMjKPt4W29dVN/rI38upr9rb/VOEJRDQgoEIcjwY9lTbBFPe9cx2cOO6Hw3CglU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W9D2GKil; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alq5jOJIKvwzk1JiQR2nuB9zmV68cSrkaF7f1eCpRDRHftpbf9V/n9R8WCFGdM95+bE2kYQZ3uOf9oUyFqOEL/SceHIMgPTMgC1xAntXcWsNvN7p5IC7l7KMARufJBDNboNlwY3PPufm/SWM4QR6vmWIzolRwDURw9W0ZChBnZStJJVwQvRxeUGyU4G3tYIbvlit30j5uGtszVrioa1QNgDobH2OaYsdzptVHY9R9Ip+8ysFyAW/GBCto78FGny38wETCfu/U20Qh4DRWpWfTZNubEYmgz7Y5bu9ZEfsAB0Ow6pZx5jAidOY34N5ZkIepmAuuGpDbUl9wTEFEN2g1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSXYlVIZ8N4FqmQHo+wqrNlTeh6OkDvG9eFryXZkW+U=;
 b=e9uaUYnJRM1WFsuRHBPWOteuScSK9EO7Da78M7830f4QGSST1M2FB4ciJnJli7BOgN0H9NzmP1u3mOW2KdWe3DcSWHhKn4oTKTfoh8w4ji0DnqNAF/P075iqB7hJ7nz6iCIqLe1OtE/I02T5CDml4Y0zx5iBBexhoI1rgZpokv/N0keNyhBu8B4Pv0ATJP6iDqtzy4BzAAX01yfyQOZzoqxjEDhsZ6ufOEoIGFBXlcIPenr6KpOIEuhYBb28qNbBP8BTimi+3EWN238387fVKgygfgt5lXEMmp7xsmBF4lHyPRime/THLvVhOZkVS6g4Av3tLi00uajxRazPFpkg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSXYlVIZ8N4FqmQHo+wqrNlTeh6OkDvG9eFryXZkW+U=;
 b=W9D2GKiltHUnlOcE4Pkitr4as/S9seoaUsijz7+oHzbllH2393jeu6z2NsD5hud9i3cLBbxjbBvj0PQWiXqKRMNCFlDnEd3UUvqOyuRsKmz+D1BmjfueVZoBe9XZVP1EHsxmrNwjja7XLaqpG3dWIye1BzkRbWRwdIKHR5+HYGo=
Received: from BN0PR08CA0012.namprd08.prod.outlook.com (2603:10b6:408:142::34)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 17:22:08 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::c6) by BN0PR08CA0012.outlook.office365.com
 (2603:10b6:408:142::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:08 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:07 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <mario.limonciello@amd.com>,
	<bhelgaas@google.com>, <Shyam-sundar.S-k@amd.com>, <richard.gong@amd.com>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <clemens@ladisch.de>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <naveenkrishna.chatradhi@amd.com>,
	<carlos.bilbao.osdev@gmail.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 05/16] x86/amd_nb: Simplify function 4 search
Date: Wed, 23 Oct 2024 17:21:39 +0000
Message-ID: <20241023172150.659002-6-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023172150.659002-1-yazen.ghannam@amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fb5096-f0f6-4faa-062e-08dcf387394e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rl8w/eQAC0op/gJb8H5jZPfoVbeN56k752V96pcK3X6S6qfZRX7/tDXB02AB?=
 =?us-ascii?Q?lqh0qMiV0FGH2J/l+7AVWbyEX8o1l7obp0zJuWmPu7OgFNqrcQGD+huM/LpB?=
 =?us-ascii?Q?x531nkkPAfjja6KYm9qQEk2G/KPQVewmkw83fgVdC7GO6diqtpn3pUovoqMF?=
 =?us-ascii?Q?N5hym4sAYe6akESp8Y+p+j9Ho6lkMx9iUHQo8NQBUCsv79OGcP5Njz3f4vfU?=
 =?us-ascii?Q?8peiZspclzen/CwD7mTxDD7iBgGL1UE8KjOS/eRKp0frt83SSk23etLAtlLz?=
 =?us-ascii?Q?Sk+R21C7fFkPpkJk4lHOMsXcVRAX2ERLgR9Li4N0do/zvpTfeiHh0eojgUCF?=
 =?us-ascii?Q?li4ii2d96kgYsNodXVaUN8C0+2llF9oD0R0acKsrBePYpldHiav8zH5FmXbk?=
 =?us-ascii?Q?EmupDKfIm4roS3YlKwYzis9CdehxC+mjzWl8wPLgAEFGQd9DIn13gmtEqhqJ?=
 =?us-ascii?Q?TFImKY5NY1yZpJpYroRevS40S1WE241eLxe5qu12v8c2O0rPLlBGBRkh+a/D?=
 =?us-ascii?Q?acOGiHlgjz7vjfdJ4V/rXnyTClHGzmcmEClRTE2wBGvcKlXkyVOPQS8qXc7L?=
 =?us-ascii?Q?1wsNtTfXP+a2javA6UKVlTE3rVu/191akNP0P/w63jo6+qleYVJDufC2qCnq?=
 =?us-ascii?Q?ZrVu5RaQdrTzRAVTaClejHwa2D+TvAPTdiwTq6Zboz0D6kqDGKgnI2OuxTXP?=
 =?us-ascii?Q?ds21ju54Vx41ctVVP3398zcnkig7Zm3oRiOHJZA5ZD3nt6b1z9ybwB5jYixo?=
 =?us-ascii?Q?gLkU+kCi/zwiO20UhnpdHNId2Ld1KFvY49dzmTxFVZz9izFSw5+1nKV/1Atz?=
 =?us-ascii?Q?OtFLYu3CsDKeb4fUWB9KDQ/DRyzUimxE+JlWNHyNyyvSYvwCyNSYPWnA4DzN?=
 =?us-ascii?Q?MODIGecNbLSNEotvolYAwurMHDN1puqcYQs9Ky7mVFfqO14V1rsEELZN+aaI?=
 =?us-ascii?Q?kJLHHBuNFyu5puY7cLbrtjlJf3PUaJl5kxsUVK+vJEp0r1EjBAdOGAE5f1l1?=
 =?us-ascii?Q?j1MPPEnWxFgcIjF1nyb+HTgj/WR30+1GENptHlYBxtJ9rTsPzTwWFSwGFEX8?=
 =?us-ascii?Q?WShGtMnOnILL5Fqo09HDt6Y5bQR22x5n0RaKVs7Y+sOKu5OaTvgrj7eTVVag?=
 =?us-ascii?Q?qNPsQl33al+VHpzQxRUuglQ9LwssqFqzAPOfO0s3VQb+1AakemA8SO+lg4Ps?=
 =?us-ascii?Q?MDY+bUYBBQdHE+sVnAl/uhI0jlX/nRT0wHWmwmkEuGfcZGyptAeh3G3MMEOO?=
 =?us-ascii?Q?pxaCN62VSjmHz4xm9t83MzQeCpLrH6zHO3gmlCG+B1CUMigEctzGi/y6m9Yl?=
 =?us-ascii?Q?EXWTzL7qDZ3aDR2Lu4GDDct9ZdlVG+rCC/CvF+7a1HOAIo+GyemrdwRXcbAi?=
 =?us-ascii?Q?33UjE2SeQc4D0HRQxlsoOU/wwhgsnzhwAfWiXwGfiKO0sTjoxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:08.6692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fb5096-f0f6-4faa-062e-08dcf387394e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231

Use the newly added helper function to look up a CPU/Node function to
find "function 4" devices.

This avoids the need to regularly add new PCI IDs for basic discovery.
The unique PCI IDs are still useful in case of quirks or functional
changes. And they should be used only in such a manner.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/amd_nb.h |  1 +
 arch/x86/kernel/amd_nb.c      | 66 ++---------------------------------
 2 files changed, 4 insertions(+), 63 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index b09c26a551eb..a0f2182107b0 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -4,6 +4,7 @@
 
 #include <linux/ioport.h>
 #include <linux/pci.h>
+#include <asm/amd_node.h>
 
 struct amd_nb_bus_dev_range {
 	u8 bus;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 65884d0613f8..34c06b25782d 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -30,26 +30,6 @@
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
 #define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
 
-#define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4	0x15ec
-#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4	0x1494
-#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4	0x144c
-#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4	0x1444
-#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4	0x1728
-#define PCI_DEVICE_ID_AMD_19H_DF_F4		0x1654
-#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4	0x14b1
-#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4	0x167d
-#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4	0x166e
-#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4	0x14e4
-#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
-#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
-#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
-#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F4	0x16fc
-#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4	0x124c
-#define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4	0x12bc
-#define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
-#define PCI_DEVICE_ID_AMD_MI300_DF_F4		0x152c
-
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
@@ -73,8 +53,6 @@ static const struct pci_device_id amd_root_ids[] = {
 	{}
 };
 
-#define PCI_DEVICE_ID_AMD_CNB17H_F4     0x1704
-
 static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
@@ -107,35 +85,6 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{}
 };
 
-static const struct pci_device_id amd_nb_link_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
-	{}
-};
-
 static const struct pci_device_id hygon_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_ROOT) },
 	{}
@@ -146,11 +95,6 @@ static const struct pci_device_id hygon_nb_misc_ids[] = {
 	{}
 };
 
-static const struct pci_device_id hygon_nb_link_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F4) },
-	{}
-};
-
 const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 	{ 0x00, 0x18, 0x20 },
 	{ 0xff, 0x00, 0x20 },
@@ -275,13 +219,11 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
-
 static int amd_cache_northbridges(void)
 {
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
-	const struct pci_device_id *link_ids = amd_nb_link_ids;
 	const struct pci_device_id *root_ids = amd_root_ids;
-	struct pci_dev *root, *misc, *link;
+	struct pci_dev *root, *misc;
 	struct amd_northbridge *nb;
 	u16 roots_per_misc = 0;
 	u16 misc_count = 0;
@@ -294,7 +236,6 @@ static int amd_cache_northbridges(void)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		root_ids = hygon_root_ids;
 		misc_ids = hygon_nb_misc_ids;
-		link_ids = hygon_nb_link_ids;
 	}
 
 	misc = NULL;
@@ -328,14 +269,13 @@ static int amd_cache_northbridges(void)
 	amd_northbridges.nb = nb;
 	amd_northbridges.num = misc_count;
 
-	link = misc = root = NULL;
+	misc = root = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = root =
 			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc = misc =
 			next_northbridge(misc, misc_ids);
-		node_to_amd_nb(i)->link = link =
-			next_northbridge(link, link_ids);
+		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
 
 		/*
 		 * If there are more PCI root devices than data fabric/
-- 
2.43.0


