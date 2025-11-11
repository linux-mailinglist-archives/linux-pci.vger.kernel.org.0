Return-Path: <linux-pci+bounces-40830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEEAC4BB51
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE98F3B9D25
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4431B11E;
	Tue, 11 Nov 2025 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DKTvFnqQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B687315D25;
	Tue, 11 Nov 2025 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843268; cv=fail; b=GsLfam5nePhG7WtgEEtqgdffEbBrbZU3VGR0OOooq/8IkfVUnxiCETHKlAbYzr8robWxTNVFFCkKwYhXu6xgGSEWkKl83XjYkZsf8tqHsvViW0+iZaYMrbvPLjiepQYFtn5w9lhECv2HwlfpfszHDYvM9Rks08haEKzvQokBXjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843268; c=relaxed/simple;
	bh=oNWPVc4OkVMKcREKMyQy4TbimLQfdhHSeOzuGkKgM1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyoZ3jwmc+pFBBstEelA7CCksPIRz1Gt1noZh6CHY32d51Q3nnRWqEDkj+sO/JAIRHSeN9gJaCsl2SqzRq18rQ6LJgzUmZEAkSn8VQZgN1zD4BIn07bJ6D+MThcjn7z40g2H7RzUTf8rtBZ11ULcCmuLvN2WeK5hhlEbd4PUcz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DKTvFnqQ; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCiUkka9g9oU1MFbIZDRyvT7SD+H3TEc1EV7YF/VJkidyY3mv3JZ/tnirgbApGtsBFTxXkibVVf/IyCMUozJXHn/BgG1DrkgxESvY/3+93sMM5Wr1tBbBr5Wd9cmthhbjJL3xJu9t+xGghPqoMvqZsC2JpeSuhdIgEUPu1pBG8OBGxVZWn7Oe6oELHtQvGqLwaSghr2k99kmC/1WtC9A2kOsbAGUXlpRyc/k27fdo6reuJER+Io2DTJ/diYZ1/ayOiphMBxSY62f2csGcDrkF2K7Z11/a9cEzUVCcDzaYVSCQbCosm3XlNbOYKZpMfVAzBRc8JHRcLHKFYrKVNSUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3qAONot0f4qVIlaG8CnclmxqSdevBCx6Jk1vGCf39c=;
 b=D1qiP1O1npMiX01MrQd8qCQpkrhTN/d7L/zUVz2eYB0cwJPFDVFjVIhOKeL5rZ0altV3GBTo/A+zJ5jpagI3k0XVlOhvQ65KrUeC1vYsEAq+L7hObjwJsNcjL9o8k4GbX1davtECrBWx8S/d3a7mtytNMyWDrOF/9p/bE9ZCK7t+hwOo8ofDMwRjdlI1LyjRJ+HDS3xUDSb6Zgfj8ZqrSOiT5sbS/tUIc8O7gHmVhoAefM+YumtfPzpFeUv8hghZO7OdM1J2RDWLg0fwyWWfkhSQUiS/AHYdVN6/642f4x5ucRvQQJhSdTNvDTuL9N7gpsFiNoJfDwYp8VITB6dyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3qAONot0f4qVIlaG8CnclmxqSdevBCx6Jk1vGCf39c=;
 b=DKTvFnqQzRBPXAfXv7oAebgfqa+0eT8UPHZ7ohpCFbIG06M8lz/lLv0P20txz0hEkgfWiKUCu5WC+0NjqKiRCPmZyg7Z8IcvnkZmEQxNOLNRl4MmNf8I5UC6squ5hKc+VliA+i9n/cbz3oDTQCyP++sRp5/Vw8K6OcOAse+I858=
Received: from CH0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:610:b3::32)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 11 Nov
 2025 06:40:53 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::5c) by CH0PR03CA0057.outlook.office365.com
 (2603:10b6:610:b3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 06:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 06:40:53 +0000
Received: from aiemdee.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 22:40:41 -0800
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
Subject: [PATCH kernel 5/6] crypto: ccp: Enable SEV-TIO feature in the PSP when supported
Date: Tue, 11 Nov 2025 17:38:17 +1100
Message-ID: <20251111063819.4098701-6-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: d75020c2-f469-4813-4a2a-08de20ed42c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eCcgCXdc7aujZ63af/zcgUnm5ihvctw6eOf09JrL+JlbZZ1LI9YPcxbpOiY/?=
 =?us-ascii?Q?JuD6AKo2i9NAUzK9IUi8MKj5xQRjsnHSwglsf2QUBkUJldWEMPdxuU+45gg4?=
 =?us-ascii?Q?HFGFZ8CyYr2YDu7KmrbCQ+ed1wm5HEHoeSevZsUrGDyMQROQAkgtS80ry17G?=
 =?us-ascii?Q?K77LpgBleWslDNbSUxRXWJ00vNfDAZHDefDn7JrdaE2gfThIFPessuD0DJjo?=
 =?us-ascii?Q?0v5zScB4jw5dM1oR7D9/yQvg/O7d2aBJaCbGTcJOK/AxE0EUAHJih213AuQI?=
 =?us-ascii?Q?VpHAth1euctAET9MB9g5j5Attcvg/ptfshEmo1aHtEh1DwqHosFCHZo6rVos?=
 =?us-ascii?Q?z1/a3OO6eTdFa7C0tcE4CGTs1lofh5FCOlcLMlNh7s95a88QUpQzPT1HpKej?=
 =?us-ascii?Q?fLCMhIf3AaAhHH1SBVkXKGTuBGC4sblJUJ8ikmwO6LGBrV1C3PkwtrF5JSjM?=
 =?us-ascii?Q?VKDe0X+DV3xBY0V5u2jnRCfuWI88RbbpliNmNWDp0RQXOAiOgurXxzpqGxFt?=
 =?us-ascii?Q?uMxizcUs6jGaOLaPpdVZ6Wsbgmmqc8IXJ9LkTatdUdbmwoRlc6DJ5pHiKzFn?=
 =?us-ascii?Q?NaLgCabyBWHS45M1HvSvn0lYQfXg3jQXlvTiygHnjHs546xruoo65DfRB6AS?=
 =?us-ascii?Q?hxKMzMyuoR2zxgMlBE7z68TC84L/h7rvtMI8cgV6dZClxHhkCNweQmLb5yGR?=
 =?us-ascii?Q?gWeijR9nbcsgiq3xlkxELjUPmIOkIxMOQP2Z1RttUNverKB9I/JSe+YgSjzy?=
 =?us-ascii?Q?YpHMiqUg1nc2g8KaX32/5W1t27ciwlC6ZtrgrodyGbfys9e7KSlvVo4gB+r9?=
 =?us-ascii?Q?Pl/kddwJ2vkuAn0lLNQX/ExZ5PxIS2NdNod/0RSdT9at/CgmOJvmaET/ExIY?=
 =?us-ascii?Q?zBwjqOQkfvGTYBCBYGbfiyXGfuNjAOuQeygv1duXN9NkISZFjZgjyh63VC7T?=
 =?us-ascii?Q?PegPK5U03HzpshmYzDTNTbJoXfLaENuwyTh7n9Q+s3TiryUi9DA440Fwxe76?=
 =?us-ascii?Q?RzcbbBGE9mgYv5RbTMTOIw/8bpv+tYejZRJBP9E4P1rKvrRUi42Z+qA4gjsf?=
 =?us-ascii?Q?DXgCwUaPmEs9beWO9/MD1oLy9kzuYkpWRGUeyn+S+T6NRLqgmpWvztj39y14?=
 =?us-ascii?Q?njL1K2MTsjjGej0L56zbPw0BKuNMsbfiAWmKSHV4kUeLZj5VH0r8gUYy8HYY?=
 =?us-ascii?Q?89sy0xxiPejpvhyAz4JUHq/e3qUiAu+AJBf/dKJtJk912Un971mgjOOCBMMs?=
 =?us-ascii?Q?mR0VtZhbqjNI/2Zn4lexuNIuIAYG48P8qaPrbNCOiYQUGBzBN8lI40DiDmkh?=
 =?us-ascii?Q?xpIENIQxX9MG9SJnCi666AQ0ZPqF6tY/Vi4b6QLYyWmqw4oKW2iWj8jawM/B?=
 =?us-ascii?Q?ZrNPYaAtzN0aTZdIQJpMxRQjt0coyPwLrYaY3c6xAIgcFLaddThzZDZ6NCZH?=
 =?us-ascii?Q?i+KZM/UiR15B2Pa9O038g4yuPTXOiccSAtWQURB3WWqFxQTCmEG17eO+l4kg?=
 =?us-ascii?Q?uzxscFvfm3eBCT7YHveEP5MOPaOj7dDiqd6PDhFk4E/Co7jFA/7YL5D8B1iV?=
 =?us-ascii?Q?oEG22t8ycDhy2XsgZIU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:40:53.1973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d75020c2-f469-4813-4a2a-08de20ed42c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427

The PSP advertises the SEV-TIO support via the FEATURE_INFO command
advertised via SNP_PLATFORM_STATUS.

The BIOS advertises the SEV-TIO enablement via the IOMMU EFR2 register
(added in an earlier patch).

Enable SEV-TIO during the SNP_INIT_EX call if both the PSP and the BIOS
advertise support for it.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 include/linux/psp-sev.h      |  4 +++-
 drivers/crypto/ccp/sev-dev.c | 10 +++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index e3db92e9c687..6162cf5dccde 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -750,7 +750,8 @@ struct sev_data_snp_init_ex {
 	u32 list_paddr_en:1;
 	u32 rapl_dis:1;
 	u32 ciphertext_hiding_en:1;
-	u32 rsvd:28;
+	u32 tio_en:1;
+	u32 rsvd:27;
 	u32 rsvd1;
 	u64 list_paddr;
 	u16 max_snp_asid;
@@ -850,6 +851,7 @@ struct snp_feature_info {
 } __packed;
 
 #define SNP_CIPHER_TEXT_HIDING_SUPPORTED	BIT(3)
+#define SNP_SEV_TIO_SUPPORTED			BIT(1) /* EBX */
 
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 9e0c16b36f9c..2f1c9614d359 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1358,6 +1358,11 @@ static int snp_filter_reserved_mem_regions(struct resource *rs, void *arg)
 	return 0;
 }
 
+static bool sev_tio_present(struct sev_device *sev)
+{
+	return (sev->snp_feat_info_0.ebx & SNP_SEV_TIO_SUPPORTED) != 0;
+}
+
 static int __sev_snp_init_locked(int *error, unsigned int max_snp_asid)
 {
 	struct psp_device *psp = psp_master;
@@ -1434,6 +1439,8 @@ static int __sev_snp_init_locked(int *error, unsigned int max_snp_asid)
 		data.init_rmp = 1;
 		data.list_paddr_en = 1;
 		data.list_paddr = __psp_pa(snp_range_list);
+		data.tio_en = sev_tio_present(sev) &&
+			amd_iommu_sev_tio_supported();
 		cmd = SEV_CMD_SNP_INIT_EX;
 	} else {
 		cmd = SEV_CMD_SNP_INIT;
@@ -1471,7 +1478,8 @@ static int __sev_snp_init_locked(int *error, unsigned int max_snp_asid)
 
 	snp_hv_fixed_pages_state_update(sev, HV_FIXED);
 	sev->snp_initialized = true;
-	dev_dbg(sev->dev, "SEV-SNP firmware initialized\n");
+	dev_dbg(sev->dev, "SEV-SNP firmware initialized, SEV-TIO is %s\n",
+		data.tio_en ? "enabled" : "disabled");
 
 	dev_info(sev->dev, "SEV-SNP API:%d.%d build:%d\n", sev->api_major,
 		 sev->api_minor, sev->build);
-- 
2.51.0


