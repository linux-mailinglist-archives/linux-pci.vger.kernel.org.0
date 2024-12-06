Return-Path: <linux-pci+bounces-17853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290629E755E
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD60216A3E1
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D9420FABE;
	Fri,  6 Dec 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TobWx2KY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2720E70A;
	Fri,  6 Dec 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501559; cv=fail; b=O7+fgFnSlvlmUJ+de2yWrtEOjeC3g7Gq8x00anlZgSIBwO4nskjd2BYFqhdHG7IzMSRashihVEdG097Cdzi5s+ilaDU+415wt6iHu/s14vMk4ajdA+dGTzf6Aq/2JT1v8XtHGUUJF2anISJi8baAT3TQw9ly2nvcmCK/TZTVcck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501559; c=relaxed/simple;
	bh=O2tgyfLuD4FrR/vAWACNKO2AEuAbqENgbcOrMaQbV4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzUhaRp4ydrditn8g1tlTSAKL5HLxFPHEzPmk+PFsTsx7dn4UAyI0LrZK6faUYuWqLEMJOSsX7dokAZMz8MMfcyKa7E0P0jX3mn2rjqcaJQMoXz/TxH0XeAatBCCLIE/WB2hJOQAQdP9LU2pqQEUJirhAvhfKl3WYL2Gla311tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TobWx2KY; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T60rZmTow9T2r3QT6CuRtITE1wlEArKdxfS08fI0pw3jJ6Z1ldQLrXFrYOiC1Z2LHNXYfurD1IsCu7yf7oR/wt23dw3LhVuna5T62lIIWCRHoaX7KN0vHtRIEoW2AcPqFtZUu0O5YzlWH/GAdtg0uWmYkdThl2H4xEvVbPVcYKPQ9Db8+sYQ28mHs+4UibER1cW+R0lR2elLNJ/K+2EJgl1/yLVdnPHPS7SSQ/bsthPx6D/KoEfqqqNl7eMN0gMPlvr2U5VwIS8beHhoCSIuM/G9ovu7NqmPZoHKhqmDPo0FHDWjOEsbRMwZRiwBI3Y2Jzfj68B/YWnLHN8JVWejXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQdL5h0LeIad4WjSklXOQXicb6CKC4V6SyF7Q0m0rcs=;
 b=A8Ck1ZAxYtP4ZTcMSqoR9Q9v9j208eCdAGIgXPYOmEtVjsvFblTgZ9d3Pk4aORdaL54Y8+ya90NB8avtbWdr1ZaW206+w+i+HoyKCHal9LqRdOFtdgrpKUbPELCmP0mWQK1+C0+8Chjmcm+OHJCx6S7mmtDGs03S4DOTxtUFTj/UdyxgUsnlUM9Nwuzqxa/gST+3HwYMYCy0OodOtsshcR7bfqSNtvo+JHbGfPRtyI/D+RdHOxMEVrvTjlVYnhIdBykhDAIBwxR27Toj4IzQNbfV5Wqywx7U50KRdqD9or7rsDUf3Uf9g2Q9jqYFPjLO/TkQQy3EXejpouFwc8jB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQdL5h0LeIad4WjSklXOQXicb6CKC4V6SyF7Q0m0rcs=;
 b=TobWx2KYLF/R1HX1bvdDdwVZLmTu/zQYZnbAVEWd7DZK+z/vklOAivyoP+nSpYSVrf8mrUW3awmDHTeupK5c6lAln1dhbpLcMjy53gaZZFj/chW5/IMOF2XLmuaJ+EKwQl5NOFDgbXqj7vApxRnHUbcSkgDWQzBOBeA9gXHY8m0=
Received: from DM6PR02CA0057.namprd02.prod.outlook.com (2603:10b6:5:177::34)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 16:12:31 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::70) by DM6PR02CA0057.outlook.office365.com
 (2603:10b6:5:177::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend Transport; Fri,
 6 Dec 2024 16:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:30 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:29 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Clemens Ladisch <clemens@ladisch.de>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Naveen
 Krishna Chatradhi" <naveenkrishna.chatradhi@amd.com>, Suma Hegde
	<suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2 07/16] x86/amd_nb: Use topology info to get AMD node count
Date: Fri, 6 Dec 2024 16:12:00 +0000
Message-ID: <20241206161210.163701-8-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206161210.163701-1-yazen.ghannam@amd.com>
References: <20241206161210.163701-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e40a525-8bf7-4a33-acab-08dd1610c94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j9sKG9+/+WGW2I13TQOTzkfsRvLmZMxmsHKT6MN2aEXcLi6O9XHpZPtXaLs0?=
 =?us-ascii?Q?M/bdzyFKqL1FEcP/MFgv2MGyLaJprWuM0WNkubEg9Mj5nW4vTS6liTAl51mR?=
 =?us-ascii?Q?fTUvFb1Bcgcro6dGMhWqJtiyH/7x1RLfm2AveFY3hpQ3ikdIlWGOSg4f5sbu?=
 =?us-ascii?Q?eCndFRh2ADWIzilhdcUVEE38MsdaZSzzK47dZgcmtMGlnKjbNphtpRAGRylo?=
 =?us-ascii?Q?KX2b4T3rALddh1CNEQI7Lrmz9zsyVrIOVNSkcyMEnFZrRo5en6j0VO+fVLZt?=
 =?us-ascii?Q?RgDMDK7pbQZ6J2KvFE6Fq9lp+owQoZZ/TQ/xuRmbjOMxxQ+V2L6TcICbx43n?=
 =?us-ascii?Q?jWNTTZOHe/qmV9DS+/hrZTuEq89pmiYi8VNTf26HseSyYbFAWypF+ROg496o?=
 =?us-ascii?Q?9tV/HW7+zt73yNCEvs6Hv4tZzImgYfRMQruIiCt/RZsJfwQpy1DpkVs+HQMO?=
 =?us-ascii?Q?MgdxizoIyB0T7H5cL+8d0drw6MPRkDl8eQuBZxps0v9wclK0XIV792LPtNjj?=
 =?us-ascii?Q?F07YQJUlvAOeIqFTlXH+xwxdE9M5bQtNnvBmX9PtNNGTBk8BJ9KKFfo1Bb1e?=
 =?us-ascii?Q?QEiJeDly9Dv28jbqGX22gGqB1fNVkL0UYBvuf06TK9yrtBv6isM4ceQ57NG3?=
 =?us-ascii?Q?QqP2olcVL6RC+WCce8Qouxai5ZBZdOLR5fm5caBWn6jIlO8DJr0EBEWwRAut?=
 =?us-ascii?Q?u6DZRgMoat7i7HuPm1nKXfhy8M+dB8C4Ce+yFaEF/Q1Yrq1ghqoezCUYt3zU?=
 =?us-ascii?Q?/4Q56iHNwHaa/94blTrwI54Ky8UCDHByHP/p62oEAqmAZTUeNitT1Tu6f+1q?=
 =?us-ascii?Q?zjji5xwd22pLZzvc/DZoZ8xIimVtn8y7nOjDxFfmamRlagEYJSKG2VYGTJBZ?=
 =?us-ascii?Q?7Z/w2fGE5Mb82nHHHxJVGoS3+/e7d/ukJZ1jwWbWpWZtlbM09v1eNOKxrWHu?=
 =?us-ascii?Q?5nItO/R8DAJh7lvRZd//Z1F+6vka/61a6+Jh4l70e/rfx77TYJCWH5HTke4H?=
 =?us-ascii?Q?qpsg9QSUw5+lf0gSj3TshRygDe49xSyQOyFmaBKkKYiBNz29Uvn9IyOddd0n?=
 =?us-ascii?Q?Cr/Idsm+I+spfQSUcHf8CuC1z4RPSegyGB6pAP3Y6dM4jafPQKeTdjqX+NH0?=
 =?us-ascii?Q?6hfezA5pN0s27nKqNv/jHMeVn6IIGt4WIGN6V5lRphb6ZYBxQIT5Osvv54xm?=
 =?us-ascii?Q?p9BK4Zjh/rsSHLOtUfHG3gT45AIqhb6d3+7DYwPFMNAXxy9wQckirI7Hgn1G?=
 =?us-ascii?Q?ebTSJaRnRXx/VHQxi1GNT985b2zizR61b8Xna7dfRfZSgpieXhSly55DTe/V?=
 =?us-ascii?Q?VpsKeo1fbvVdu8MmN5rxkFlX5tupUPfSm6utBAm+uFZTiGhdfXQgR6BLJzq9?=
 =?us-ascii?Q?iJTrncUUjAbydW7RCAb1bFzvDi2B1cgX/XbBenIXIDWTU8CSyPFlh4YVH/Sz?=
 =?us-ascii?Q?lKStcjLioHRENmeCHyvqEZnCkVeAeKK1hcE5WyEFrlxMYVJEokFplA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:30.7983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e40a525-8bf7-4a33-acab-08dd1610c94d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807

Currently, the total AMD node count is determined by searching and
counting CPU/node devices using PCI IDs.

However, AMD node information is already available through topology
CPUID/MSRs. The recent topology rework has made this info easier to
access.

Replace the node counting code with a simple product of topology info.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-8-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/include/asm/amd_node.h |  5 +++++
 arch/x86/kernel/amd_nb.c        | 11 ++---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 3f097dd479f8..419a0ad13ef2 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -25,4 +25,9 @@
 struct pci_dev *amd_node_get_func(u16 node, u8 func);
 struct pci_dev *amd_node_get_root(u16 node);
 
+static inline u16 amd_num_nodes(void)
+{
+	return topology_amd_nodes_per_pkg() * topology_max_packages();
+}
+
 #endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 6218a0428c77..371e33abbdc1 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -186,7 +186,6 @@ static int amd_cache_northbridges(void)
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	struct pci_dev *misc;
 	struct amd_northbridge *nb;
-	u16 misc_count = 0;
 	u16 i;
 
 	if (amd_northbridges.num)
@@ -196,19 +195,13 @@ static int amd_cache_northbridges(void)
 		misc_ids = hygon_nb_misc_ids;
 	}
 
-	misc = NULL;
-	while ((misc = next_northbridge(misc, misc_ids)))
-		misc_count++;
-
-	if (!misc_count)
-		return -ENODEV;
+	amd_northbridges.num = amd_num_nodes();
 
-	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
+	nb = kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
 
 	amd_northbridges.nb = nb;
-	amd_northbridges.num = misc_count;
 
 	misc = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
-- 
2.43.0


