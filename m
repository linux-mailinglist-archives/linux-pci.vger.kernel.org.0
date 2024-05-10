Return-Path: <linux-pci+bounces-7344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54558C2305
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2861F21C36
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1856171670;
	Fri, 10 May 2024 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CWn22jro"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F9171658;
	Fri, 10 May 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339957; cv=fail; b=sPfL+uQfRwRPFm3/f2m4tiPpjPjX2z6ZyvIZBgmUMs7UAwgHDBHq0Rs9zaMnDhNzBdOne7gzbYGhSlnuH+dt50TMq3iw5kkLnYoA8U9kwxXMsHdfFLMnaNTJeZ4pteOW6Q3v3paUeH45bQo8y8KmlpotwVIKnkN+N1nElF/7S08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339957; c=relaxed/simple;
	bh=RLUM8YE9opYWpcSf+B/VFyv4Mx0PnhQTG0O3dm8xrJQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kk4UsbVw+cApG2N/viqym/ufVbBzR7ifFR/mILFS/yVEpXkbajobJHo96L0kh3JSyQkU7DJkDkkzagL5R5hfZGXVB25TO7UmoGjheE8JdTwl9vqjguDWG33Jk3S11r9pkq22yf35JzKPNFUyXQmN7nay0SK3ldhjLpRDTGYScXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CWn22jro; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX2CwOHe3FRMMVXj5GbO0tOzBnGMSn8sjZXmtWG4jc8azBIQZtPxWqyapA7NF/9M5z8nRKQy/1psAYEnJXzYtqI9Uql5vG98mUeKUzcddI1gX2VgU0gB36Z7Ewo/ZuL+crWqdRT8EDQgbswwUF7jsbLpmnWqK0N10mf7UvNdnW7z8KG3sZmEt31G5pvz96/eCcI2xw0hx4kHRKZMaeU4Fn998viFmh8B3Fv/1nbaMqUxSQoHWYgx2bXNT+VuTqVoKtLqYOjFB7rGzlJG7m75+afkPg3DvH7Azb/XwdpNrbF4qbqusVdDyZuYny/SF6mbW5a1/k4kuEtPqhBlTekqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsdUcbaiKYNMLlCgy5MuynV8kfG/Bx/F25dvEDDdW2Y=;
 b=C7Iq60NRACt/gc37dNgoDy7jy8ZzMT3F1BQqTeQTneuzCEP3g6a+6XGw1KqaMTsqCjSM2amwGm990qYbdWYzjpJD+257CoPhfhjlnK6Ietps+xVRJP0IZYSjF6chQw+EA8hc6t5oYwSDqZ7DVCOKJYXSbIHysLk+k4jkeaVIXE4BEJ7woL6I97GIjBESdlQOVSwc+XWS3YRLIlPpSc6hckmLxPliDXl7eqHLb9JP8LiIBkpwIpoFWoYWhXOXZtNpSvXIp5UWjN5KrOTiCCoPAeQRrade+c7iFpo+6vbHzIMHdYQ75imzD3kxa7I0DVECnXrtAh21OMJAvX/lvxG1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsdUcbaiKYNMLlCgy5MuynV8kfG/Bx/F25dvEDDdW2Y=;
 b=CWn22jroQQj0Seyta2EM6tMISG66BG2diMYuBfOdSHvZuiPwN55iTtqAKqsPuuIQZAa6thO3p1dPj8VJ+u8P0e+0wp/ss+ml2AvrE/ovrYhoonayOLLC+MHIZydf6JcixDXPcLweellEMqd1JOd+I3Dk1TudsjCQy4qoMNQVuBo=
Received: from BYAPR08CA0011.namprd08.prod.outlook.com (2603:10b6:a03:100::24)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 11:19:11 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::e) by BYAPR08CA0011.outlook.office365.com
 (2603:10b6:a03:100::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Fri, 10 May 2024 11:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 11:19:10 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 06:19:06 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Anvin <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Muralidhara M K" <muralidhara.mk@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, "Avadhut Naik" <Avadhut.Naik@amd.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Shyam Sundar
 S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH] x86/amd_nb: Add new PCI IDs to the MISC IDs list for Family 1Ah
Date: Fri, 10 May 2024 16:48:28 +0530
Message-ID: <20240510111829.969501-1-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b45efc-c03e-4c75-bfe0-08dc70e30411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U1fQmzs3UEgvWiRwN7vEuE6Hs7HXOtOn4y2xwiqOi/MnDx5506wyJ1jXtIaW?=
 =?us-ascii?Q?2gPFoFNykoUTBZ7OO0dQhdRhjGfPyOxHSt2dktZYV9v0KU5ajGudLk1FKsSf?=
 =?us-ascii?Q?lbsKQ6KURRXU0GkEt1zyw8tLY8bZe/i0/N6505eTD5fHcxiTurp97xE6wL2U?=
 =?us-ascii?Q?J6/SysecETuR16tEEnOX6FHYbRa9hksX2/9JtUUVSYyEvKg1vElnhbb5/I3P?=
 =?us-ascii?Q?U3IDgGNDoGrq5RIRm/CF0KuRoVEMaKkegDAmvHIhOniQMTcsQJCn6dZTiiiQ?=
 =?us-ascii?Q?rsMAlNLymje9U90vq6S4io7Ok61jtvyCBtWb0n90aOrMuone3l8DYm0KCzr9?=
 =?us-ascii?Q?vovU5p4j8F/sya+LzTJdfIWC1Eez6k+cfFsxQ67l1SkzrbYtKe43mrHpN+KC?=
 =?us-ascii?Q?CP4QL7+UJwdsUag32BGg+hyqjc2Vyzc3WtsLlJ8OM9GIpacAWYGA+7SGnvTa?=
 =?us-ascii?Q?6TVtRNKarJ8g3fEOoPpZ4FZRbMxJmFjy+Pr898wgL0P3bKJNlvl+a4JuYHcC?=
 =?us-ascii?Q?Uf9Mbi8IUFX2YDImx/A2eD5pgIalyEYbvA9LNhEyi6IgCJ6X5BoaRURvz9xb?=
 =?us-ascii?Q?DazB/5QM6q+1n55onoB7ESA3Rc1uphSJR3WLRQxbVUsF07JJUthXfPkeN8mY?=
 =?us-ascii?Q?bJ3C+lcrf9teyMglb1oYjOs9VdJ79xNLT/Bbl7UKAbV7EVzRb7UPR2oLSixv?=
 =?us-ascii?Q?HrxVvtuj+YRERx9B1SH0Eo3MEmxwvikEyCVjUvLE1UHPJCJcFvCgOHLPD4eh?=
 =?us-ascii?Q?aE48AgLofqQdNlFZGPcbk613pIv6kzPTsA4VTAFTipZvu/nFKR7KYAShjwCC?=
 =?us-ascii?Q?GU0rNB/2ejQQuhK16tODkX41wXZ7OUB4+qx8gAmIdL0GCa55l8B+burH8FgM?=
 =?us-ascii?Q?7TC2H3q++EiFduvysgU5D0ieByDOIwrOjJ/Wfcn96fZXpRMaEkCiWjGwu+dP?=
 =?us-ascii?Q?Dw1DPhX8aQqSRjtxrcoqM6S+XfEKxcT6bygqZ6FKTrK2b388HW4AOTFoaFMw?=
 =?us-ascii?Q?uZ3VWZKla9rMm+FIkLKczbk0FqPcFE5QnsFtnSGr4EQ84qgrpsAM/Y5ozuVH?=
 =?us-ascii?Q?1e689UZgj0QFpy8oPKxcP2vKdsvX2Mszt4Fu4U/bIDweiGJAo0Q7TBPLCB66?=
 =?us-ascii?Q?xrl1M/XHgNmTSnNoqm8OePM6pmm07lne8ZeNUgzebxxtGY/JrgNOBkjGBoCo?=
 =?us-ascii?Q?cVt8AaId9louvz1qPORHQ3K8Fa8kptzX6kr5RFrXuIYlxG8FWrQV5WMkijvv?=
 =?us-ascii?Q?xsbnyq9OOGLdrunuo6R8qQdGntY0VrA8tzd/GiqynpngSKyRFkFjV/klOMJ7?=
 =?us-ascii?Q?TTA2t8b37utoFFtFAl12j7u7vWvP7lU0ZAXFf2Xee+MW16NBBpu5PTNVuXFm?=
 =?us-ascii?Q?yIZIYjyrmH75UrejsY987wSC6XLp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 11:19:10.6677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b45efc-c03e-4c75-bfe0-08dc70e30411
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764

Add the new PCI Device IDs to the MISC IDs list to support new generation
of AMD 1Ah family 70h Models of processors.

(As the amd_nb functions are used by PMC and PMF drivers, without these IDs
being present in the MISC IDs the PMF/PMC driver probe fail to happen.)

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 arch/x86/kernel/amd_nb.c | 1 +
 include/linux/pci_ids.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 5bf5f9fc5753..3cf156f70859 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -95,6 +95,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
 	{}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a0c75e467df3..c547d1d4feb1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -580,6 +580,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
+#define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
 #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
-- 
2.25.1


