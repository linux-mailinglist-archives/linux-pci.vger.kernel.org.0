Return-Path: <linux-pci+bounces-10592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C33938C14
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 11:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80C61C211A0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E289A16A94F;
	Mon, 22 Jul 2024 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DOEpB8QR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1116A945;
	Mon, 22 Jul 2024 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640577; cv=fail; b=JLwkVI7xS4cNDwxE7u4pO20Ae+L0qRRKKKhflbeUAeS2JuAfauNwk/EJEfycX5J6oMg3QilnCnTuRRCk8/OwrftnWT/fKnWl+xwccEQutZwETgwJviIdqje+/4LT0HzIS/B9+hsoaYQEMSKiaXb4U6wNgl/vblNEQHzGgMifssw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640577; c=relaxed/simple;
	bh=6VPGbwCsBN20KHceC8H47cNbdWNZKjUF+ePs8daLrCg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZFdR22id+0xY5g5+kiG/xphzo09oiiD1Yk1hq7a+Y9vFJzb40SaUk0IneckNhu5XgE2d6yVmIYkcyWWC7Jp3uT+qfome+fWqxSfll2cW+39rVsfpBT0LUiL37L6T26k0WGYWBmCst6DADvm+u6CPu8RDsK+I81WwpJb1MCZ9h4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DOEpB8QR; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhTy4WQrBtRd3Msa+4g/fOVKBkKYAsSO/cJ2hichzwFEn4KvmOkBTO8nr8JIhsOaiF6IpHPiAzxrzKzrWxGBVvsPLV9CMiAIQNSaWWx8apUQ0MWqo+nFj1xRQVW10kPAJOIQwZPzf9vn9DOen46XQnaXjn0K8KaDzp4mJErAzE6qIE1SAuUOXUhVPuSH9B5ZP/VRj9VqTUjXiPmY4Dr16hYPri2Y9SFo0LAYHCUqDayfhvVORKyPL6YUDCxeIynVZdyIOtycg8dEdXozILvrw6tW1FfMQTiHAZswCO1ajvqmNL+qYl/pa6qL5l6czAoHvLo19tqSh5kAJ1KKl0eeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye2ccXrzPXqmi0ur+PzV1KjH63Y5JanddEthUPusoZ0=;
 b=mMKUcA0qM5WmSyb2WKbdedLJiyiDTDgFDpmKWb20dCY84T+YR52PmGGNuBMYEmNVeHZNwLFmhtnIAi5YHVmjNlEN+ti/PzsvNwTzjm0b84Or7tZHm5O16lQlJgcTzi3zxOeiThyRUbjx38Q/wTnjDTo037DH4YD4vDAMEBFJOwVts7ZFwMt7tyThkpB92rIxFv7rxb60xy5qWWEuyD6WDbA7rGeRCxjjvKUt1NuAjZ1MNym1NPXu+jVscRKrBbQjjHVPG1pBfRya5We4e6d9lxSVMdZREoZGJQqbSg2hZMWl+G405BTnk2+vX0P2cK1YpTGTmBFh6ZFJB9i6JpPVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye2ccXrzPXqmi0ur+PzV1KjH63Y5JanddEthUPusoZ0=;
 b=DOEpB8QRvUzL6XpI//R020HNfqCUQxoeWJgb2LXysFGRa2q1SbCYTEAC3rXo8fV35lrZ0C+r6f9fpREGLOB4E/SwFAFc0pgSAly1Je/eC3TCQLWODH2/7z+M9pDsbGZmlEDwerQma0VNWieyYUXgX6rkQ3klNz7U2qRPLrC6iLA=
Received: from MN2PR10CA0024.namprd10.prod.outlook.com (2603:10b6:208:120::37)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 09:29:33 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:120:cafe::44) by MN2PR10CA0024.outlook.office365.com
 (2603:10b6:208:120::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 22 Jul 2024 09:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 09:29:33 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 04:29:30 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>,
	"Yazen Ghannam" <yazen.ghannam@amd.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2] x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h
Date: Mon, 22 Jul 2024 14:58:01 +0530
Message-ID: <20240722092801.3480266-1-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5845c0-b759-4411-2eb8-08dcaa30cbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tIQ9zr1HJwFc+1Ho7myEKm1OwdTlYx+d5lZGn0l6MLFqmO8zEXJkfyqqCHBT?=
 =?us-ascii?Q?wbRnyqGc95oSgALE6e1G3mh4+tHMNJdhiXBR8t74ny7ynYA/ujwvSsG7pcNm?=
 =?us-ascii?Q?8QSFqbkAUG+jN+5uS3HgzPaXa+CD6+3sgyQ6QFtyz4058+PeUM4oZuJye3Gd?=
 =?us-ascii?Q?8HCyckYi1LvEDcYPTS3Jk+uzF0n6HIoFEgRVt/+KLJI7AlmHMTJPzHlKUMBO?=
 =?us-ascii?Q?bvNtDOjKG1lDnL6dd/VOiDPFQlggpZFzxqyM/1HPkRvoBTei6DaJEwX0eKPN?=
 =?us-ascii?Q?xFrxFxo6GSzkob2UThtLHqhl47V5f5ckGwX1oPA2M2UA3pbZuS/H/BLfmEpW?=
 =?us-ascii?Q?MredM1ry/JhwYLLQmAsUeWGS6WvU90car1yZ9b3vLJZ+mo8xLPC0IcSwpPF6?=
 =?us-ascii?Q?ophFTXIVJxQPT8jL5fESb4W6yizQUQoXF/hCcjec0QxO/a0rpPHNK7KU2LS6?=
 =?us-ascii?Q?9We5w661kGCj8zDhiMwoXhuE9CTqH46iD4fx46Ir7betUBAS9qHVP3E9ggB/?=
 =?us-ascii?Q?YdlINt1SjcIKaxwlhkaoaU5M4EQR26TSd0StJHWmRivJcPV2iSzMxP2BGb3t?=
 =?us-ascii?Q?MQdL8u9SOFi3XVKShptdqbqBemiYPBqQE6NgdY/j748Q+TdY7PG9ljU4qDMe?=
 =?us-ascii?Q?6ZVIvcsf8T5ItUUjltOegGzm0/dd00KC+gD+/kOheqe47uth9O65AiAMR5ei?=
 =?us-ascii?Q?1qUfMg+ENZZatmAmvaaGrIl+vl/pOBV4VvLHUHvdfOjaPkzYzkhUuA7KpYqA?=
 =?us-ascii?Q?JOwWhoz6tLX1iSazGjLVnxmEWb/tvJu2o9RsoC1EVeZT0gBKAp2j2QAcmBHc?=
 =?us-ascii?Q?y5+mcXtysklJRi+6cQm2weadbsj7dpgTH/omLe26uPJFURuPqWZI6vkLJJub?=
 =?us-ascii?Q?iXdnBGKCb1GkKp+2RXH+cYAeZL4vEH7Sq/bLyou7OKdxPK3iiRV9Ln3xKjyz?=
 =?us-ascii?Q?LhgHtYRfrvPFIjOpfYRn2JgxBue3W0Xv/rJYYanhEmXaW/Erq5DOXupjFXMQ?=
 =?us-ascii?Q?gDcd9H/Wwb5tM1nUXIHqL0cUGSsxPoqoZDeYY5xhwZCFZ8Ti3+6FQ6gA4Abs?=
 =?us-ascii?Q?qg5IVf6OCRZ/eX6mmW/b0tUmOgP2hoQ/+2P7qRv8P1vvQzboteA1VU36v5mP?=
 =?us-ascii?Q?lCyoN0lUxDk05ERo7J8TN6vO8Fq7pUn0b1h1A4RVeeOA8/QiCnpbsx0p9Vgr?=
 =?us-ascii?Q?jSmvdau5wkqBbb2zutA20hQOcPxANlgMWg9FVJMqAtoDQBrRjnmmAB4zV9Bu?=
 =?us-ascii?Q?LbcxYzykMmQSYBku+Tu2p7zqjnH6zjLBaU88EHELL4YhkWaR1zQdK2yWlvAS?=
 =?us-ascii?Q?1fnHRsqSL7Ogp/+d6139INOat9B2hDKhCMQg25dmdiFGkHAbDLmiBzp8pNwy?=
 =?us-ascii?Q?VotMEnAKOg+8uJYXkySU7RuqcpldVNYaG3Hr7xJ/6oMTVK+ViDP1zvv2ojll?=
 =?us-ascii?Q?6USiuGivdhHyQYKYe6iG5Y8c0qUySD/s?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 09:29:33.3688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5845c0-b759-4411-2eb8-08dcaa30cbd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763

Add the new PCI device IDs into the root IDs and miscellaneous IDs lists
to provide support for the latest generation of AMD 1Ah family 60h
processor models.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
(As the amd_nb functions are used by PMC and PMF drivers, without these IDs
being present AMD PMF/PMC probe shall fail.)

v2:
 - Update commit message
 - Add Reviewed-by: tag
 - Add the new PCI device ID to k10temp.c

 arch/x86/kernel/amd_nb.c | 3 +++
 drivers/hwmon/k10temp.c  | 1 +
 include/linux/pci_ids.h  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 059e5c16af05..61eadde08511 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -26,6 +26,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
 #define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
 #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
+#define PCI_DEVICE_ID_AMD_1AH_M60H_ROOT		0x1122
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
 #define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
 
@@ -63,6 +64,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
 	{}
@@ -95,6 +97,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 543526bac042..f96b91e43312 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -548,6 +548,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 76a8f2d6bd64..bbe8f3dfa813 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -580,6 +580,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
+#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
 #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
-- 
2.25.1


