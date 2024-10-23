Return-Path: <linux-pci+bounces-15136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D69B9AD298
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497452821D3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B71E1E2300;
	Wed, 23 Oct 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nDs8IxF4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6AC1D9A62;
	Wed, 23 Oct 2024 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704139; cv=fail; b=ny+e2PZljYERXUXQK4nvRk4eRn9kAT8TJnlEahi3CQrqVHGYVarb1ammn+QQMbCx3Jr+/kQhbHXCcDl1iHgS2xDBqzUG0oYCLMWPS8UNCablB+UIHKNa3FwHEyLC/Dd0Vhn+gNcWF28exgzhKYzQTVqZxP8owfTs9pyDDf/lhwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704139; c=relaxed/simple;
	bh=9jYQ3+paKfNFcYwOiD7jslDldtQphgVdqBxOj7HxMpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoGVO0L3eixgtCzdW0jpGwGzcsgxqgTLXIfKaIwnJvob45x/lVLRb3mvBdR9IruHe4BNeqTQrExeUKU4IRNx5boG8hUc1O6z0q+xqZIfLgJ1sx2L3jpTL2w70bBC1vJlU5MyPSE+3VJwfVl5FOojbMArXAh4bxg9UZP/mu3QM48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nDs8IxF4; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARsSGys/mhSs0CJcvNQBUG5Z2k0WFoDJpArk0BD3q3vwT2uFx275b8mjCnaZA26F5S2oQw+yYO6hawFdyqkSgbCcpcqzfz08S0r3NMkIW0QSlI8De2TwBzsXZiZJV59UVpetQy444vhEpaGi7uaciXwsoBP6HOuqwoIWc3krqF70vrTJxxdGABwaBMdHDusp7qp5KESkoyy0wW9GAuY/4dpA6iOfiJ6zyvCiGLuWszsNOEZpaZ4ieYdV9BPOqEG+8o6Gli80uh96ogNqauJj6ILbd+8OQq9yPsVSFF5AI11gHFmOkBk0ewFTt/ZKmT0SMNdu6PsQwzSWdIe/FEiftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMqgRIYFrt3pq3n3UVV0NA0edvPQ0s0H/wUFqGpLU4Y=;
 b=ArUx6UBPUaQvcSzbWnATkA9T4gFKNWu0zg2BSVOBmfLdMNRnf6Vmedo4gpJo1p3Db/+dRP6X+bDQ7S0fpLZZ7mus4RFZ91GwUwYl3/IEy50+ToniYFySWkAeieSfdLpnQQWa1FehpgDEdH2qq2HQMcmST46Zf7O1k7psSUGQbmGJEopd+OMKcsJawWBn2lNt2g773xUqw7DqYeapE3uWxwafN9evOZ3gbehJ4MfjBkbT0z6CdK2D+ubIk41siqGItjvuCHs3d5KhzpEAU2BBnrj3SaCQkQJJFGhxdH8CtP9csP8P/ke5fYqw7qkZyfBlOgnPISPP8csWl372ZGKQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMqgRIYFrt3pq3n3UVV0NA0edvPQ0s0H/wUFqGpLU4Y=;
 b=nDs8IxF4kooaoPFqlKfO67JmRv3n9XgUI0KlFS9d5W5BWcaPyoIz1Unbif3o2kzPCaW8PUkkC2cCxHq3JyVSYT2cP6KJoSNsJiq8qXO4agKkOECNUH3H19x27FeRYP0on5kJjsTKTIvv5I13lXW0iv2ZkgSy5MFVLYMgO0hASHE=
Received: from MN2PR01CA0040.prod.exchangelabs.com (2603:10b6:208:23f::9) by
 DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.18; Wed, 23 Oct 2024 17:22:12 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::f7) by MN2PR01CA0040.outlook.office365.com
 (2603:10b6:208:23f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:12 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:10 -0500
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
Subject: [PATCH 08/16] x86/amd_nb: Simplify function 3 search
Date: Wed, 23 Oct 2024 17:21:42 +0000
Message-ID: <20241023172150.659002-9-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e098eb-a350-4931-5bad-08dcf3873b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qsYDOtUxjloBvOjgkwAHaetOfdMI6fCXuh7rDEn2AEPsA24kIvFFomB7tNIb?=
 =?us-ascii?Q?dO5ftFRmDDZJMPtehkPaanesQ7Xq+e8gx9mCKitXCaJXeHQDEEXGKvxqEooG?=
 =?us-ascii?Q?KUg4IACyHATfaMc6T/P/GnfgrRgBghQhBM8H/nhw/luHfuhpuNKx3y6K+RSX?=
 =?us-ascii?Q?i46Y36PA+KyKiyzeiEpnfK1J31/av0OtobYX0cFxbxoWvNwqWuLQvrILqRv/?=
 =?us-ascii?Q?+mUoiv6rTRhBwoaDljpuepqloQCBrYQ5k5P1oNttY+IYMv37GP1G2ZcgvBC7?=
 =?us-ascii?Q?Rlv9NVEfMsFGuat28PLtcvm31DbTcfdzhaMNWuVdUCDkoyPqlv+JJmC4FLV6?=
 =?us-ascii?Q?sg5qzGwoDoZgj42v19R1I84NedSWxh9cEiGR1gnCVhKzK+ixsssbSlbRvSeu?=
 =?us-ascii?Q?Bg3PekiNB+cmx3Fc6Q8z1MhxzzB6sb5ZE/UDFKRorBLS59VYkUxXL8JGcpR7?=
 =?us-ascii?Q?BWEHHlnjQkCLPR9wW9cAFnNqIjXVGpwgIaP2ebk4YxPD6zL2mxYcwSNWdiHD?=
 =?us-ascii?Q?WwS8ZGryVWI3M5S2ADDSsGjYBHeZl58Jj/7suzSfBohbS31OSl7Hm5pTVc8t?=
 =?us-ascii?Q?8rT815akesJr/igC7CMBugaDEOTSsDnn1rsXCfYJtaeD3pREZKMzaDZqJZhb?=
 =?us-ascii?Q?g/4d0o4sc6qA1fpT/x7fCUi9crt31hpsVog0qqICMWxuwN8AL323WF9Lr7QV?=
 =?us-ascii?Q?0qaMUU0oTlnzdVj9EcsQVHF+nu4M4GdMAcQU0SOuLDrGPrjbkegfvzUUbCwZ?=
 =?us-ascii?Q?wP1EOFO0aB66I2QpkQOdPQCeq9qA46reQ2JEdJ5UXMgchrINceHNwdZBkU71?=
 =?us-ascii?Q?jIvNI8Vssxx5BisE13BDOn3YmgNbbnRPNhRC8qWMZh2v6JqBOyrjmWqlZJPz?=
 =?us-ascii?Q?yWIQM6Fvx3OTtMOTBf3IZn7g4GmU/pQxSLXrXPGwOI/VrxoDa4xYZ0aPlWlB?=
 =?us-ascii?Q?TEgNrnuGdbj2ixJ4zb92OupD431pqKCZLYQOIICJeQj96p+ttYM0koK++b5t?=
 =?us-ascii?Q?GRcW6eCXTiTan2QgXcgIHyJ2UFQZVNWftTLXeVwlf0/M6wd8XmNzqDK8i/Dl?=
 =?us-ascii?Q?ALsj0NuR6gshLEkS/sNUxsnxa2SEizaoTyv2klYyx9RGMZhRlaeDjcDsMz+M?=
 =?us-ascii?Q?TvuGB2JkV8hr2XIGGSWC5zBxhhpXNuBeXSd3unhYPNPY78zvfRKhNZ/CkdmH?=
 =?us-ascii?Q?h+fSODlY0BNnYNTx2e+WaMGpJjbzENk0/nyiWHdydr8b7gTXJFHcIV87Tlgq?=
 =?us-ascii?Q?szQK6oYwwrZgUCfIpT86XIRNFMc+O1BmyBKUhYB3CNtrI2+34NudiPLW7Ptk?=
 =?us-ascii?Q?N3Mhc0HPUlAclU0aFsc6nlIrD1WTYge6fgBwA8RZ+vJELe6u5hkFiRazHyYn?=
 =?us-ascii?Q?0CSgH+/ZA0zw/kaa0PXcd9ry3YAXCMHfk7kGRYhj4/hq2kFNQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:12.0792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e098eb-a350-4931-5bad-08dcf3873b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218

Use the newly introduced helper function to look up "function 3". Drop
unused PCI IDs and code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/amd_nb.c | 46 +---------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 7ccd769f9c5e..9b159f9b4a11 100644
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
 		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
 	}
 
-- 
2.43.0


