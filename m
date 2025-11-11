Return-Path: <linux-pci+bounces-40829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F39C4BB3C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A67518936B8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C387C315D49;
	Tue, 11 Nov 2025 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IKn/mh8C"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C982E22BF;
	Tue, 11 Nov 2025 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843243; cv=fail; b=V9m/m/332s5X8trt46ave+G13oY3IgrUjlXbR2qEPOdQMmE4C4SeVNgz4we1lULuif70lalRqv37OB1jdCBEtu2KpjlG9PQGEB8Tz293zcsqSmmARMvYi55vbyw1bXvge7WWPyekvABXPe+oxAQjq7iI+0BH5h/C/x6kN4SskA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843243; c=relaxed/simple;
	bh=vDQo7m+kcVfhG9meX02aLrjvhlmhtl86CLXipAxy2ro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OomCHfTJa3J8uOFBBfu8jte16Au9YCm7kTT4A7FZXvByjSdk1oqyMbh2+fpcJf9oT3mKBi5NZ1QEKjZmmIwtcXTshAA5gcjH7it7mz4ehGq6elobEtgb/KIIlhegJZXgySQe/hsANf6rrhkwqbte6tSamq2gwMyHES+8Rn0VYJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IKn/mh8C; arc=fail smtp.client-ip=52.101.62.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPnyB6yieQ/awiY1nHkTBusl5yhCoUVb2BjaC6ZWoQjCAZpBGXxpSRzsKXOzLvEZB/dF214Ugrd6Kqmuj8/MC2BuCNxNqsAN+MxzITUU2p0naT3XCVe3qwQSb8oKvtKzeN+c/J3M2eEVGiG2EwZ0FMUBBVFu7xqSQJ9gsyYHTfK5tB31dFVBtU38IhCuUXEiP/LA+Mnz/OHKOTEwL4Rp6kvjsKGd39uoZhkvsx2iLOh5XD5TOGU8LPP/pCYE1jn4pTD7BTBFwXGsCZfVUtGWO+7xHmAPSNAIcIob9bENK9gSVoawqVGs4Txd8b8Rjla1vye5FgW4e/0XaTDTqDKQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho7/ZXjvv5qIX5nXfLzBsm1Wf87SxGz31GbrBJv+4Nw=;
 b=HLkDqmyM3r+kdNTDWFlc1ENIVGlxeF9hJMsNPt9ozUU5qyI7sR8XhB/ZGBmsDQokp/FvW1pfsul5Y2ozzq89nNxC9wiA2bQKT7kW5y3XuheSwqlUgdQB10DaxODxb2QL/MoDI8P42GOoCcX0kscVZFkDVE89bxydvSgUqv3dxw0Gt+BiIuZIVWMfAzhAYZ1Q4FWwjCxhD/GIB6Xw5EvovKLCqUwWtdn2l9uCQzC4AcjcMzh/4zRUijnQfRV2/IwOEES8HA2/44s1C00MS5vqO81peh+XkRPs/wlpxAtZYmcq3AHX5Rcjj2y8n89A72zKbZ/m2GrLMwZXW7mMXOOl3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho7/ZXjvv5qIX5nXfLzBsm1Wf87SxGz31GbrBJv+4Nw=;
 b=IKn/mh8Cb6RcIWIXm4koVqEqA8iwUz4C9ILnL8wfIDK9bDoWgw+fmPh2p2fTpWy4yW8BTo/JVgEfp5O4RVl+VjKfOH/80pIThDAIJVN39bk0GdfbHKAOdsM0KpqvnRyz4pCCJeKto8DrAq36MaBDMb6mIsyyRTAQYJ9GAJqtJZ0=
Received: from SJ0PR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:332::25)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:40:27 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::b4) by SJ0PR05CA0080.outlook.office365.com
 (2603:10b6:a03:332::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 06:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 06:40:27 +0000
Received: from aiemdee.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 22:40:15 -0800
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-crypto@vger.kernel.org>, <linux-pci@vger.kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Dan Williams
	<dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Eric Biggers
	<ebiggers@google.com>, Brijesh Singh <brijesh.singh@amd.com>, Gary R Hook
	<gary.hook@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Kim Phillips
	<kim.phillips@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Michael Roth" <michael.roth@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Xu Yilun <yilun.xu@linux.intel.com>, Gao
 Shiyuan <gaoshiyuan@baidu.com>, "Sean Christopherson" <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Dionna Glaze <dionnaglaze@google.com>,
	<iommu@lists.linux.dev>, <linux-coco@lists.linux.dev>, Alexey Kardashevskiy
	<aik@amd.com>
Subject: [PATCH kernel 4/6] iommu/amd: Report SEV-TIO support
Date: Tue, 11 Nov 2025 17:38:16 +1100
Message-ID: <20251111063819.4098701-5-aik@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111063819.4098701-1-aik@amd.com>
References: <20251111063819.4098701-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 498cd9cb-aa24-45de-b1f6-08de20ed3369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ro+V2vz30ibsykxNCy6xdfR86fOkr18zymnLTQoUfiDqwkyUn8PojcW6bGdI?=
 =?us-ascii?Q?lPGCbI56Ik0Lq6mebAgLaKoXhXmilsRJMa+XqQaH9oSxZpJoWhkCIi+CR3BC?=
 =?us-ascii?Q?kKqd0xKA2kbTPqpRNLMGoRTwm0ICICQQRAba9HMY+F2tQdydCnt7VMqjJSu4?=
 =?us-ascii?Q?lQy5qDbO0K+3e8ecHJc5enV1WNVxaCiiJ4Jo3gST2y3804KnRlvqTWyw2yDw?=
 =?us-ascii?Q?oiTQAfjhGUEb2sYDeU17IXfxVrntxu6y6+HVe8n8LOhCKq9o+3kqM6O6af1o?=
 =?us-ascii?Q?S994CHHEXDC7CIosLbMz67MKAa8gT9MfLoNhGeSnGfXjNopEC0RH/Vo6z6ne?=
 =?us-ascii?Q?Q2vvGydD83MvGhRlLLZsOf9C+iI03sowg4ySQCIQhHvsXp4FBQu/bIF/SPo6?=
 =?us-ascii?Q?MZ/AF+OoSBkF1X+7O8Nj0AJdFtGyyM0SpjhM+lkz6VIUSQpGOpzfxLakMTut?=
 =?us-ascii?Q?KloyZKXfTL8DYcn3orKx4m5/QzJc58kmEg1XYybbPupzOrQrpbH9a2qZAs8d?=
 =?us-ascii?Q?9oVjdfPv/Jb3u3tFh03Ig4qu8R2qq5s5zLtMLmJfDihVcwD6y+0sXNQnTfEK?=
 =?us-ascii?Q?rVd+MTWcy3v5LDxONRewhNm4ZxeQqGEXRZPMgM7bASfnwr0JXNS4lwYqlUA9?=
 =?us-ascii?Q?ZMuNsqg4Kr2ASLCwaX7TWqeK10+QkI8k9wpfBnJOvP53vQfMpQzNXREZ2MsC?=
 =?us-ascii?Q?X5/d99Lt5RDAIjmLgXHfx1IKlv/XQ+ijhrYMcTq9pBdoxrG1VIWEFAq7mIk5?=
 =?us-ascii?Q?xmUWw83K/cHJn3fa4yRrpkfmyjQ87iz8UfFMbamyFPC1OxAU7ahZGPHvcgWO?=
 =?us-ascii?Q?C7qSSPWTeMhbgmaIFpU/0uUjsZnqNFTqxt1MzwLTCd230r+8EpTQ6Zm2Fjrd?=
 =?us-ascii?Q?C4Tv6nPsP0aGoOTC5/8wEtZniqjVch1Qf+2re1ppBSyFgGASN/khz53e/lsj?=
 =?us-ascii?Q?8qjRNTGdasTCszqUqScemujGWo9539d0fXqlGefe6ocfWYMCObcBwnr9ArQm?=
 =?us-ascii?Q?yPbDm4jfzCvJcbugcGTcxwPLefefQ4WwnodUGOOiQ4Op+EnrkynZv9fyP4ET?=
 =?us-ascii?Q?S6HpgLMlwp3srCqaZTNo4d5UCgpleK9k9qD+YjqsH5AXJ8Ygbqey2mQwsAXT?=
 =?us-ascii?Q?J6my7drkTBO56B0G4RDXrkM7GMqrqjMvImbSXWbotGHMMqqNrG7Vtu3nJQgj?=
 =?us-ascii?Q?E5UIp07tloTcNfwsGMX3yLFbFolSDB0IhUj0oK8WOWubUHgKue4Ueew6E3hZ?=
 =?us-ascii?Q?mhdT5Me4vPxsNI8Bc6RHWiDAAbS21Mdr/BTE9OHy2lG5WHEtWruZT0vpadqF?=
 =?us-ascii?Q?+uycJaA2kopnnXdT1FB4dqlOcnwMMY9doC8v/I2fpLcn3S+JJ++AzdzWkf9u?=
 =?us-ascii?Q?MweYmjETgN5Mlm23r8nexyBGu+ZIz62zBILE/YVwWUptGClYQ/rjsPBD1gYu?=
 =?us-ascii?Q?cslMbL+U4RG2KLXDlRr03YtwDDrTYizotUPLXJWjXaNIyvkB530cnXq7ha6g?=
 =?us-ascii?Q?up4aCJxZ3ZpjISFvfwZzatqH9kiuwkxKVDGchpD1fTsU8ZMf9PIwlD9+Gk2j?=
 =?us-ascii?Q?Jsq+yqHeUdLgiUef0dI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:40:27.3761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 498cd9cb-aa24-45de-b1f6-08de20ed3369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459

The SEV-TIO switch in the AMD BIOS is reported to the OS via
the IOMMU Extended Feature 2 register (EFR2), bit 1.

Add helper to parse the bit and report the feature presence.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 +
 include/linux/amd-iommu.h           | 2 ++
 drivers/iommu/amd/init.c            | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a698a2e7ce2a..a2f72c53d3cc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -107,6 +107,7 @@
 
 
 /* Extended Feature 2 Bits */
+#define FEATURE_SEVSNPIO_SUP	BIT_ULL(1)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 8cced632ecd0..0f64f09d1f34 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -18,10 +18,12 @@ struct task_struct;
 struct pci_dev;
 
 extern void amd_iommu_detect(void);
+extern bool amd_iommu_sev_tio_supported(void);
 
 #else /* CONFIG_AMD_IOMMU */
 
 static inline void amd_iommu_detect(void) { }
+static inline bool amd_iommu_sev_tio_supported(void) { return false; }
 
 #endif /* CONFIG_AMD_IOMMU */
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f2991c11867c..ba95467ba492 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2252,6 +2252,9 @@ static void print_iommu_info(void)
 		if (check_feature(FEATURE_SNP))
 			pr_cont(" SNP");
 
+		if (check_feature2(FEATURE_SEVSNPIO_SUP))
+			pr_cont(" SEV-TIO");
+
 		pr_cont("\n");
 	}
 
@@ -4015,4 +4018,10 @@ int amd_iommu_snp_disable(void)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(amd_iommu_snp_disable);
+
+bool amd_iommu_sev_tio_supported(void)
+{
+	return check_feature2(FEATURE_SEVSNPIO_SUP);
+}
+EXPORT_SYMBOL_GPL(amd_iommu_sev_tio_supported);
 #endif
-- 
2.51.0


