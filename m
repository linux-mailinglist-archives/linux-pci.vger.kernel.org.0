Return-Path: <linux-pci+bounces-19469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B6CA04C55
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4124F3A5A72
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BEE1F8922;
	Tue,  7 Jan 2025 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UJH9CpwD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB781F8690;
	Tue,  7 Jan 2025 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288956; cv=fail; b=D2jdVIyJc6+0AU83GTb8AnhKUwfCGK4woRTuzYE7qH5FenfXBhMLQxpcb0OhZNqfBTqxyjQ65caOH8Ob3x2PszWu+QBJyfpgcH94yUB5LkvFTc+mW4MK6LVuvHa29Xepa69co24PPIcQA1WIpeZ24WhaUS4q8meJXWsGgdB1GNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288956; c=relaxed/simple;
	bh=TatAcIYsVj6wY8FCBHdF1P+LI47nTfwe06r+ZhZjhsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eURzpulTu8SscXpwlW1u4rl6JQriqelJxE7vsQtbLvduoUqr9cf4639ay+Cv+xTOaNNc+kUnf4x+ta1MVcdW/wQ+dBCsgeq/4qDLJDl3rg0P7IiIgdt5ZiWCaGUPjFRbvic+6iIxiqwJwkRxg9+tTuppXnkarT80Lx6Z7fBEXgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UJH9CpwD; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho+yWFooUoj7NLBcWic4Pug2RmUO5RdY2kneCwyYQ8rj25GksHkGoitvVP4oP6qLHwfQ3y0OglD5A3IFy/sbkqVvYqri0+8CkIFQxBM/5kErvsQrmOkRfz8C3OeX3vc9dtMVy38prqMLMA5i0nozz1c+gB//YrlRV0LESO1KGqN5i0vCp35rrNSmG/zR9rXKm1niDfdsTUv50pQaapbZXZfZzvwIsP3ps/3PWS2ObXGpZ5NzW46+NcOO+qg/mrA30X8Gs/SWmtrpc78KHtTmEiVy+scXAENTHy36HWViW0QjCL1beRqt9/TbuhfeV4GruvEP0/8mAaFCTFT3A9K5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2TGr8JJKhSZtT/YEyGBWOe1g/QTYZ4V5oDKMj9ToO4=;
 b=kq0NGGrBBoDgilWqc0e0Md5q131VJIjXbB6tKbN2z9FMEL7/9XHRhndAeUVoDbiigv43GuNaSyMRuJzqjCbnIsFh1Zne2zjhrcy8NtCVpraun4bZeAwS1KdHJzGAmyKfoWHfB/H12QPIrDDxHy+ayYPoC2NGloM2xrnmLi/TmOpzVfTwSOJXe7LVUzbM3bElULM4DvVBf41enxvDI06aJRFSrMWjThldN0NJCLpqT0vy9gsgPch+6Kt/96rHI3H6ZiUrDvbOIRjV1vboYfrYPvUdR24AgQ7AX8jR/EwGAPZyxjs90s5ijIXKsm3h7aPftCaG0iVV9WtXZGxzImSBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2TGr8JJKhSZtT/YEyGBWOe1g/QTYZ4V5oDKMj9ToO4=;
 b=UJH9CpwDMrXYmw/at/J3pgGczRQTKOWnU3I1whQo0P7PPAcmWkVvbEiwHxF01Xh2oExEtRcCAE3WCrGVjVnQicaqAKS6HDlnLqpntQv4U8tZgoY740VVJEMrp81IWPOXTu4A1eWZ3pu2tqQEnK23nWT8df3PbkARtHvxv/uPBxA=
Received: from SJ0PR13CA0224.namprd13.prod.outlook.com (2603:10b6:a03:2c1::19)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 22:29:06 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::ec) by SJ0PR13CA0224.outlook.office365.com
 (2603:10b6:a03:2c1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 22:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:06 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:29:04 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Hans de Goede" <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Naveen Krishna Chatradhi
	<naveenkrishna.chatradhi@amd.com>, Suma Hegde <suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v3 07/12] x86/amd_nb: Simplify function 3 search
Date: Tue, 7 Jan 2025 22:28:42 +0000
Message-ID: <20250107222847.3300430-8-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107222847.3300430-1-yazen.ghannam@amd.com>
References: <20250107222847.3300430-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: c8bc12dc-13a6-4a7e-8864-08dd2f6ab28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E3HTGIbFy+3zRpcozIfeOLU2v4ZsXNIeGSG8UaFwivQcxJbmiY9qf4kywHPR?=
 =?us-ascii?Q?slPwrwudO0Px2qFEM8SD1+WO7GwwuiJ2PqRIjXiwVPgLWzNxAji4BR1PgGZC?=
 =?us-ascii?Q?atviW1dqB61ZkuRY2dg3Vy9PprrdV+Z+TFNXzvvHiVqkdyIchbL/e7TZm91Y?=
 =?us-ascii?Q?CoDaWzVHDLrpehz9DxFwxP0CuAOX/GlAatNrL9P/6ugeAZQ9RkitqPDHBW4i?=
 =?us-ascii?Q?RpkEljmyr2yuqe+HnRXyvktTtrsOiO7y2qG4/CS4CuArUbyai1THiTp5w/Km?=
 =?us-ascii?Q?4QkNeW96O4Qsiy28rZ1ptu/4E7Hn5Nkt40+ALI4LpCfgyVfHwkiBHdEHdPan?=
 =?us-ascii?Q?phPrvqQG1/LJQfBR1G1+tNWAkyyRgn58HaSdteCiwM+5JBjr614kz/aSfGyJ?=
 =?us-ascii?Q?mOdW2UxOZwvpHQOyp6HH9yf7/w6GebJilN6Msy2bFLlPzRvLezoC4dRjLnr0?=
 =?us-ascii?Q?/xDlJFHHWJllQ9oOabKZkTldF4fTK/qYcZ12i2CBbY8wwWpMwolK1eZOy00Z?=
 =?us-ascii?Q?WCCfbQsKyE/z47n3v+cPAAO/q2SLl2T4OhgbLNxXY47ps9CP7ttX3+2TB7iE?=
 =?us-ascii?Q?BevLlrnAFrurUlYzBlX7wVqOiDPiSS0gW0/s7nkcimmKqw1V9uO/w9gFDWDX?=
 =?us-ascii?Q?mU8vM57FyvQlox4YivBc9RwnH6wFGKOi7/D6FpotBuyzAA4wGQLX3hLsEc4g?=
 =?us-ascii?Q?ygD0/lF3NpuXF1imxxsk1debwPx/3Fvw4yjgCh81VzPMFdftXGu5mTLLOg+4?=
 =?us-ascii?Q?LOaaBji56N5IhZzOx8lxxjXvvrxOcWsP7NVkY9EaEl1hvt3FG40cXF1ozSiP?=
 =?us-ascii?Q?RhGXSgXcXay7dAqQy1gVX2fmhPj4BKZ7wt2HdSfJ/l+9OKPSxPCAAZDoKHnC?=
 =?us-ascii?Q?mB/+oOnRVzunbTLnnTLR+/VIJrC3oB1QDjZVaqA/dxFjwtcDd84limPI4c5V?=
 =?us-ascii?Q?A3h0b4nlUBBm7BzOieUXaRiZ2WLN1hrM/oFzBh52/4p1NCJtjdo2GN4QlyPB?=
 =?us-ascii?Q?9pK3jiGNtkgEHTZl9Z12ZQmg3R7PWipp51/lwnOfHYgZM6VOijCktknANXWd?=
 =?us-ascii?Q?ncf5OddLg4SdcxvD3FRxbe+0WVYtR1LRRKttgVTylB05TnuO+XsyMabKxlDr?=
 =?us-ascii?Q?UeLjsGBN/FpAhIvqyAs5JxHXVeo1GHnFVrjfgEnZNfHrIe0ZioouG+I23fhl?=
 =?us-ascii?Q?91Ka0IBiPq3rKCEekz41zK5f6TdAkjC2qT7csJzqbufFOLmWUlu2bHxwaw4H?=
 =?us-ascii?Q?sT22O09rt9R+66dajawcHW4MYqUro/jL1gciK4uM6frZkoB+RjRgHiJPHmYn?=
 =?us-ascii?Q?+7X0AMI0EtJ6VdJ3/KNc/gwq8xVDywJ6DJBBIlRf5O6poHke/1WxBlMDqdan?=
 =?us-ascii?Q?FKE9rOVJ3tQo8KHKU+yujszOdJ+jubyA65Hh1jLlXHnRHrr16U8j7J1cRFEf?=
 =?us-ascii?Q?t3KFQr7aHmnYK0nnKuyPpYSWjs9yPrHzC5mFez5M5sakYt33audEe0WodTov?=
 =?us-ascii?Q?PD+KTdKFD/1Sjr9Nr/rkHzrbJvUhyPGS5B8r?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:06.3705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bc12dc-13a6-4a7e-8864-08dd2f6ab28f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073

Use the newly introduced helper function to look up "function 3". Drop
unused PCI IDs and code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-9-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_nb.c | 46 +---------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 6371fe96b988..e335d89ddad7 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -29,31 +29,6 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
-	{}
-};
-
-static const struct pci_device_id hygon_nb_misc_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
 
@@ -84,17 +59,6 @@ struct amd_northbridge *node_to_amd_nb(int node)
 }
 EXPORT_SYMBOL_GPL(node_to_amd_nb);
 
-static struct pci_dev *next_northbridge(struct pci_dev *dev,
-					const struct pci_device_id *ids)
-{
-	do {
-		dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
-		if (!dev)
-			break;
-	} while (!pci_match_id(ids, dev));
-	return dev;
-}
-
 /*
  * SMN accesses may fail in ways that are difficult to detect here in the called
  * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
@@ -183,18 +147,12 @@ EXPORT_SYMBOL_GPL(amd_smn_write);
 
 static int amd_cache_northbridges(void)
 {
-	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
-	struct pci_dev *misc;
 	struct amd_northbridge *nb;
 	u16 i;
 
 	if (amd_northbridges.num)
 		return 0;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-		misc_ids = hygon_nb_misc_ids;
-	}
-
 	amd_northbridges.num = amd_num_nodes();
 
 	nb = kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge), GFP_KERNEL);
@@ -203,11 +161,9 @@ static int amd_cache_northbridges(void)
 
 	amd_northbridges.nb = nb;
 
-	misc = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = amd_node_get_root(i);
-		node_to_amd_nb(i)->misc = misc =
-			next_northbridge(misc, misc_ids);
+		node_to_amd_nb(i)->misc = amd_node_get_func(i, 3);
 
 		/*
 		 * Each Northbridge must have a 'misc' device.
-- 
2.43.0


