Return-Path: <linux-pci+bounces-17848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E889E7548
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DA41885BB8
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0B820E00E;
	Fri,  6 Dec 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HoXp1lzU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08320CCE4;
	Fri,  6 Dec 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501554; cv=fail; b=Z9a+jWjGf8W+rVw1AN2NarR7XjdE/21oVKT97hIXYKFYn4eDyWGHVgu6f84ZyeLxobVjI8kJn8liBcKRn9kRFxhQ9URAU5ECGr1Wb1E3ji8YxqQnTthxltPuDBEwZgtsXADhKcjchmyAaHkoYNZyD7vJZIfqczfWZpQ3rqti5io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501554; c=relaxed/simple;
	bh=TZRC3eAR9VV9wfoJblx/waz3/VovV6C4YBcQko5iwIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKL2hz8O0whnxnnx/FQtAFmPARZNdgtqUnrqnYLEcBew+6mCblufTykEfo2S7NzYsCyHOGF1v6gbGhf5deUaFwSA+9I7by9lFJuMLsstlLzn084r4GJemeoeMBG/x0G52qFRf4SZBODXBP4uA9uoYNpODhx66gnq/L8gd7NfVms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HoXp1lzU; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ye7m08/Ah3MFCGa9aH7yHUVSs8f524aYMr1d2MmNcqUocyEikJMrPU9jSjthwKGIKooaDWcteCBmjIl3pJ81UHGsnGX07d7Rz9L1QnHKDpKKU0dhpuQaK79DTJWDiQMghkGcu9B49gP2+UAQI3u0uf8cmZ6QeFOpCGg4v9Wiy3z2UoeeOGBfFdcCbFQjjIjUcNzoaudqUl655cRXdu4edAYYbCWn8hlckPrM7IGqnctKYKwhzl7+eLxd64Rsn3HPMRw1AkexSffpEu4Xx2NHOGqJYoNwmGojGnWOj6NkqbtWc/bEvdUCuWWkfgwotssXv6To9dy7C59n4HaIY8Zx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5U3p4tm0z43Z47aWlormyNfSIuoP1PZRUwGhXonLW0=;
 b=Pw6jQfNGRskyIx9TzLYyjO8+6bCVuo5920KxbZYCOHVUTB9y+4Kyutsv5b4mq4ZDGMwF8F2ogdtBkBcwZK+opA05qsekaQIOe2bBZfec/E+onoKSsxMHmhga+Ci3RbiglMfrc8EDOYIj1fEpAT4CQqTac1/jYaYsOiUeu0YFnSJOfo+J5cJPuFYg3sg7/rdmURls99hiketny/2tQ6xpXcRlMx9wt/2UKaVS0wd0Mws9oA5ik0emBIjoX9GEPZwjuolDsP/N8H7TrJIpfzf9CFw5ezKWwODh7sx4lVuWxdKswrJ7sEtZDReM5mcbSqZ+M0lXYxjijcW6Xppv1aPcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5U3p4tm0z43Z47aWlormyNfSIuoP1PZRUwGhXonLW0=;
 b=HoXp1lzU82W0aNv82GZXFpOAPYyGo1yAWpyhN9naZ4qD8wSRQQ/MMqWWGgDhAWs2Qt96kiO35L3NC7ztSyBhncpb4mYRJWlW1Jui1IpOuSw7GNEzc5Wznoekt+ltm+bXZj7NIV08HOFnhonXEvBh8l0DBZgruCUDFchK73qaMZE=
Received: from DM6PR02CA0167.namprd02.prod.outlook.com (2603:10b6:5:332::34)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 16:12:28 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::c) by DM6PR02CA0167.outlook.office365.com
 (2603:10b6:5:332::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Fri,
 6 Dec 2024 16:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:27 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:26 -0600
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
Subject: [PATCH v2 03/16] x86/amd_nb: Clean up early_is_amd_nb()
Date: Fri, 6 Dec 2024 16:11:56 +0000
Message-ID: <20241206161210.163701-4-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: f88ffaba-5f94-4b9c-9a4b-08dd1610c771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ukLpvX0qukDnlfhx24EzStWk6MdhJl7Sz4GYkhoQWYfkvI5j4luTU5CG4Vny?=
 =?us-ascii?Q?/wl5aSprw/7z+RXngTbeiKVf5BHPKu1svMskBCM/AMj97e+z7e5suD2Elp7V?=
 =?us-ascii?Q?wHYRCjJbNhMAEmiE3CfVbqwFTREIz1XXNUHllrbw0aI7oLgYF5xsksLSvbA1?=
 =?us-ascii?Q?KOl8Z7TLiWnp6BLC4THkWoCaTnUgjnVWHLtQBQ23oFFVHq6S5Ub1TxBm1La+?=
 =?us-ascii?Q?sV+xPQ7Vw2nv6E2FljrfMF35lICgPmCROrKbJ/zgTwtRZP3wXm98SfuYZrjo?=
 =?us-ascii?Q?dC9x+FLMCIS54W6WdzMXKTCGevFb9i0slvyACyQ9tqZ2VMlMGct2zkW8E7L/?=
 =?us-ascii?Q?uWXlewH3yU89RHaX3nPDW2RMPjKGE6f/meYuRoaVlGuUVZaEk9FdKsM1tP5s?=
 =?us-ascii?Q?QowLWl1M00avXk45EoXwHZHnDAS2HCoWGQXylY1kiDBhfPd0kn6guldwM75G?=
 =?us-ascii?Q?uypxEhEP8Q/n96l2dJwWo0LkJ/Ds8/ajlHhysxld8c6wBlTpB8y9RXJD03mt?=
 =?us-ascii?Q?FHfYULVtRohhtX2Jiz3h1SW7+5bZbZp9g+Xr7SpWWp1MfvAtENiiPSrGrH0x?=
 =?us-ascii?Q?gZtmpJuYdo7BGM4xqyRIp9pi8+P7Cfdr7oOVACSWgrGEWaMTvlgugMCoL5Bd?=
 =?us-ascii?Q?OR2hrQP3FLVv04+/mrpuGyDbJ0f6KeojMXD8aQ8ImvXafBaUFu5JCyFYUrKx?=
 =?us-ascii?Q?yDoMO84C4O8W5q6MhoNTvPCfqfBruq1shJSdg9PDWmd0Sn4HF9S9PCa/Q5Vq?=
 =?us-ascii?Q?XcKRdJBrRs7YmUcRTsIz6ZUErf0kr6iukrs7nbZnNxwuf7A/S+i0t+OWt8fL?=
 =?us-ascii?Q?rbi/r9equ8GmNOEqN+oDlIT5+Jzv1jiKY0mWKKwkKxbGZdDGhPKtgSOGpEzI?=
 =?us-ascii?Q?uYw3UyMRi9arsvE0gWJWZIblyOR969eNzNpRgZ+s06iRwREl4ZeMvdoyEgUl?=
 =?us-ascii?Q?DGobczdL3aqe2eofyd2EFXF/cPqZUhMlYX4gx2ShKmpF830MS8iz1X9/cFAp?=
 =?us-ascii?Q?b/13kOcnhCYzZiG1A+g9SB5tWEAZools7YMCTYKNiAhZJy7md/eoGkFhmsEf?=
 =?us-ascii?Q?E61fYtCM+JQi53sh8Bu0/tdp2lNvprAgS0uXhGmr8KCyaLYzCdTk64uZkwXf?=
 =?us-ascii?Q?JCFUfxnpgCQTNKdKyf+1eBYsgpRtXXUspTYLs9+JcHsu0obHAAmoiQUwzq8m?=
 =?us-ascii?Q?yPGo5Bc+F728wP5YxzS7ckMlY/1WkJqO21SLAXYTuSxmQ5k4ofZHmHrovmjI?=
 =?us-ascii?Q?bjIy1MRsKuIgngRvX9chOxFLmMa9lCfAX3V+da5VRHlgO4qQfEnWdHzHbiY4?=
 =?us-ascii?Q?H2wxTNcJD8+lLYvf9LGJxwt/v3aMIGsQ2wKQbYmT0ZNoVZ0Lv+LukLpGVt9t?=
 =?us-ascii?Q?bCz1AAIeMXlDHNTueCa3ipu1xQwg/1L8wCvUkTRJBTGhaTLfh4H3K8wVUWTo?=
 =?us-ascii?Q?uPhfkA/KqDkdL/PsWVt/GlRkyy5ty0PxKqiC5kPqqlefGjOFiMB/hQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:27.6783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88ffaba-5f94-4b9c-9a4b-08dd1610c771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344

The check for early_is_amd_nb() is only useful for systems with GART or
the NB_CFG register.

Zen-based systems (both AMD and Hygon) have neither, so return early for
them.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20241023172150.659002-4-yazen.ghannam@amd.com
    
    v1->v2:
    * Change boot_cpu_has() to cpu_feature_enabled().

 arch/x86/kernel/amd_nb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 37b8244899d8..ee20071ced99 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -385,7 +385,6 @@ static int amd_cache_northbridges(void)
  */
 bool __init early_is_amd_nb(u32 device)
 {
-	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
 
@@ -393,11 +392,11 @@ bool __init early_is_amd_nb(u32 device)
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return false;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		misc_ids = hygon_nb_misc_ids;
+	if (cpu_feature_enabled(X86_FEATURE_ZEN))
+		return false;
 
 	device >>= 16;
-	for (id = misc_ids; id->vendor; id++)
+	for (id = amd_nb_misc_ids; id->vendor; id++)
 		if (vendor == id->vendor && device == id->device)
 			return true;
 	return false;
-- 
2.43.0


