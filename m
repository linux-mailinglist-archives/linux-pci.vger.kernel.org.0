Return-Path: <linux-pci+bounces-40827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA491C4BB27
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8AE1893366
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471853148D8;
	Tue, 11 Nov 2025 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EsqJzhGM"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67662FC866;
	Tue, 11 Nov 2025 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843204; cv=fail; b=jxaVjq4aCi6KHhlbc01k5+Arz9L+4CEO9wKOyCkCRS0uPEVnkvNLLze3n9uVAOF9bthVT5p/hIsLmkNgfhduWeaVr+UhqTGFo+aok9XaJROv8NiQiMLVJ8xBVdzFbQBAld9lePHpCF/dYeYZte8Lg6HmQLL7cWH5GmKcfBI0iEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843204; c=relaxed/simple;
	bh=UjyGprnLlOUIoWmUa3SIuMapciTe+LlCBF0gkYhhpZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEJWFqNQzdF6AvO3WjvXUJnixdN3IDF9kQnfa7UgZfdLYm1xfcFp7lux12KnM6v94s6DCUDPVaUj5b/9w3G75l/YfuHddr6rWNB+2u7lcgCVZOoac0+rT591W3mli0oG9FUzQV/ru2djZ9taKbI6TBjkLrhmRDLIxxVPg4SRPls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EsqJzhGM; arc=fail smtp.client-ip=40.93.198.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doVrXR4IJEmNHp138SKF5ebiMWOG0T6VIlS8ey+0XnaEQRo3mJf5w7Q2e0LMv+YmLu5tD5F/UvLQxEqr0l3j5OiM88Tx4+vqNgWyDdtLGGCGQACUhrv2L8DxCWX6HJHdf69Ewbgst4WZcw/lUE/mg08dkZx3OSKfmsFooqkOXEjQaOu8QsL/CUfmboY8loxd7a7M2xmAjoPhIzYsvuPgKerXrT67sRwUkWMcXOuO86hyOGnf5HN50X9Lo7zRiIazdg5jWzNOW71dlTNetuj/OcoAenY2ZkBySIL4XYYNOeZrMJBoXGKhao3BP4PWsjYzb0q1w3rY+UV14jm7IT/iBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COdCPJxaJjhBHn5+KvEzw8g9jfWJ005Q4MoPek9coDQ=;
 b=kFXHPYk1Oosj6w6EyLoXpbDeBxJ9XfjveHnsHaEuUPIqS5eMUa32glqP9HhcTaKQ/GjNsteBk/A/Llbj/92gr6Ved7ZE8f8D5PFPzFXVfgUkXjwiHoAYHoCHxD16UmGqw2daim4OSOlrpFqmpi43xhzStU4LlBCzXTXTQxGdmzqdr547R5IelC/mk6RNFGuer6YVbYw2bFb0js44SCh+Tre+dVgI+RZdJt199eQYLTBWGIleCxlNJ8N4njTuvDWNwXE+XfYNKjp1J2d8yM6FLEtT9Vbm7fNAE1oqpIm9B0Dm0Dc5uUaudgY0PNMzDdijo7M0EhyjKZYZkKTbg/rQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COdCPJxaJjhBHn5+KvEzw8g9jfWJ005Q4MoPek9coDQ=;
 b=EsqJzhGM/oTjPyRvsMGi5tWvWW8n/U5vPsKswewI0L4ZJ6o0pWl4xIcYUo/fx64wzX3HH/InDo7SH6y+6Y/aUCDpaXg5v0CR8GfrwtMnVJpyOMx5ckJmUjgeNWE4dr/tNxvcqCzOxCvNBwRV/H3jT8iDth4aWeW36U4TPobtE8I=
Received: from CH2PR07CA0044.namprd07.prod.outlook.com (2603:10b6:610:5b::18)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:39:36 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::6f) by CH2PR07CA0044.outlook.office365.com
 (2603:10b6:610:5b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 06:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 06:39:36 +0000
Received: from aiemdee.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 22:39:25 -0800
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
Subject: [PATCH kernel 2/6] ccp: Make snp_reclaim_pages and __sev_do_cmd_locked public
Date: Tue, 11 Nov 2025 17:38:14 +1100
Message-ID: <20251111063819.4098701-3-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: fc448f57-83c3-40be-81e6-08de20ed1519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QIEwzHDZILcdTwNqe2ogTJircpE0FtMWnnmEYzlFIUxk8G5KA6u/4ZDInIBo?=
 =?us-ascii?Q?1+4a2bxzwcA7oJWrbY/H6R3GlpLdQpwcWs+qRDkzkkul62Xas3qHW/FvS1GI?=
 =?us-ascii?Q?kLQ0v6u7978JulZekGJK/aBnrDPHF8zGT/k6hODVR7NVGhGxZ8l4+Ck6I7n2?=
 =?us-ascii?Q?9X7IWwx/gP6UY5rzXjauDRXaw87pJ09fyYP+ZChP9+EkqkduE+aXUNPQI8Sw?=
 =?us-ascii?Q?8ZcfqFpELoRC9szhD0Iq5YGkBYg6vlHCTJIJ2exLG6qZlrYCWFLAIya2SwOl?=
 =?us-ascii?Q?l53qTWblzV033PepRlSnWnxiC/fZFg92IUm3KVyMlYK6cJ+rV1Xa9Nqm1Elb?=
 =?us-ascii?Q?KeHcNK0PMplamknTAzAnG/y8YtCGFDYs9b3nzm+5oT3kuLRl9xhP3rOlLE0N?=
 =?us-ascii?Q?vq2pdqmKLjAjz1phFAu097FZGOdEBLnzGPqJRShzYe0JLJyxkORLgIblweqf?=
 =?us-ascii?Q?bK+jkoToNYumFxsaLk1SxuYDMkVLnShmi7tbtp4QghHgLHHgtz6r0CM2GBL4?=
 =?us-ascii?Q?y/GNbLK14GPSAKCYMRcJlgaKmWVv+oxAGHDHONGU+SOxU6KEwiPITxrdw4bl?=
 =?us-ascii?Q?BcUMqG1cz2yRPB7ApTqJHhpUJYc+xs4CgYrf/D1bOCuip45221CafJTkaLq8?=
 =?us-ascii?Q?4Hgm1xQI5/+J7JtjkCXIuNjPgoai61IEGdHxV+awDE/vtRZKhDGyUtVBCdwJ?=
 =?us-ascii?Q?EwqK76tl1T033xUAWNaGsClDY9kDvACP1psHLBuvhMpJc9fVuSkJ7JHUmcVQ?=
 =?us-ascii?Q?8jYUwo1fUPuGHryWmfXbHWOvze10WQtfBlDy9QMERgg1XQ4TqMX7DQyerT16?=
 =?us-ascii?Q?lK1NB+lvy5i2PE0KlHUjtyGKqtrarQOHq6iILeTJjoyzfnI5AXUIVbHkqPN7?=
 =?us-ascii?Q?ld2vc1vgGcfVK3TSk6M7t4I9HzmVa/5sHXiIXvU/gME2rdCz12OwdJlKJ3TO?=
 =?us-ascii?Q?jVnRwDQBatRgeE+jEitwjOtjA0a3d2oOmc/Sy2xd+r+tkgoU3YZVacOc4Nt/?=
 =?us-ascii?Q?6AQh2LApHuDNUSKFQF1wtcsTyU+9fWerkxjh8Z9tMZtbS9E7Dpn71Wiho1oX?=
 =?us-ascii?Q?FX+902XA12tTAROr5anK0AHDinLYWtDR+NhiQBu6mPVJr4uc7t2wB/3JSZn2?=
 =?us-ascii?Q?PFf9XUPTNcJMdxwkBaYqz6AxgDGxtsJxRkaLY5Mnv6K2WG/PPLx+3C9B/vRX?=
 =?us-ascii?Q?sNQa/JpiEmrhNmS/OMyUov7z7vnxED3imJsSiYDadV8dWAzUnvTQus8/IDfW?=
 =?us-ascii?Q?iXFiho7zyY2t0QZaHDzgv6txHIa+Jo62JpT7Scho8N8rfZ7tmF9bbo0r7ja+?=
 =?us-ascii?Q?fwoJHsaOi6CH/Z6fxEa3sxB1sxTAgHx5Md2RkOf3rmzBMMArfzXqDf8HDgq+?=
 =?us-ascii?Q?ow7QbwfSaAnUOvZYp/yhA4dOfs97CrNANgnxFlBQE88niS6laV+h2ETTYWtL?=
 =?us-ascii?Q?iygVAjF964sPP8u51cyTAbitBuJrufGM9/esHubvKAyv7UK9rN4kq3FRH41j?=
 =?us-ascii?Q?h0mHgJxgbaPFg8NJJff/CFKGcrM7V4nsJFK5vv8fdoiVdAeZc8xABEaBjSi0?=
 =?us-ascii?Q?rubwhEErGwVRSbgqtXE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:39:36.5988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc448f57-83c3-40be-81e6-08de20ed1519
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456

The snp_reclaim_pages() helper reclaims pages in the FW state. SEV-TIO
and the TMPM driver (a hardware engine which smashes IOMMU PDEs among
other things) will use to reclaim memory when cleaning up.

Share and export snp_reclaim_pages().

Most of the SEV-TIO code uses sev_do_cmd() which locks the sev_cmd_mutex
and already exported. But the SNP init code (which also sets up SEV-TIO)
executes under the sev_cmd_mutex lock so the SEV-TIO code has to use
the __sev_do_cmd_locked() helper. This one though does not need to be
exported/shared globally as SEV-TIO is a part of the CCP driver still.

Share __sev_do_cmd_locked() via the CCP internal header.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/crypto/ccp/sev-dev.h |  1 +
 include/linux/psp-sev.h      |  6 ++++++
 drivers/crypto/ccp/sev-dev.c | 11 +++--------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index ac03bd0848f7..5cc08661b5b6 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -71,5 +71,6 @@ void sev_pci_exit(void);
 
 struct page *snp_alloc_hv_fixed_pages(unsigned int num_2mb_pages);
 void snp_free_hv_fixed_pages(struct page *page);
+int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret);
 
 #endif /* __SEV_DEV_H */
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index e0dbcb4b4fd9..e3db92e9c687 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -995,6 +995,7 @@ void *snp_alloc_firmware_page(gfp_t mask);
 void snp_free_firmware_page(void *addr);
 void sev_platform_shutdown(void);
 bool sev_is_snp_ciphertext_hiding_supported(void);
+int snp_reclaim_pages(unsigned long paddr, unsigned int npages, bool locked);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
 
@@ -1033,6 +1034,11 @@ static inline void sev_platform_shutdown(void) { }
 
 static inline bool sev_is_snp_ciphertext_hiding_supported(void) { return false; }
 
+static inline int snp_reclaim_pages(unsigned long paddr, unsigned int npages, bool locked)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
 
 #endif	/* __PSP_SEV_H__ */
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 0d13d47c164b..9e0c16b36f9c 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -387,13 +387,7 @@ static int sev_write_init_ex_file_if_required(int cmd_id)
 	return sev_write_init_ex_file();
 }
 
-/*
- * snp_reclaim_pages() needs __sev_do_cmd_locked(), and __sev_do_cmd_locked()
- * needs snp_reclaim_pages(), so a forward declaration is needed.
- */
-static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret);
-
-static int snp_reclaim_pages(unsigned long paddr, unsigned int npages, bool locked)
+int snp_reclaim_pages(unsigned long paddr, unsigned int npages, bool locked)
 {
 	int ret, err, i;
 
@@ -427,6 +421,7 @@ static int snp_reclaim_pages(unsigned long paddr, unsigned int npages, bool lock
 	snp_leak_pages(__phys_to_pfn(paddr), npages - i);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(snp_reclaim_pages);
 
 static int rmp_mark_pages_firmware(unsigned long paddr, unsigned int npages, bool locked)
 {
@@ -857,7 +852,7 @@ static int snp_reclaim_cmd_buf(int cmd, void *cmd_buf)
 	return 0;
 }
 
-static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
+int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 {
 	struct cmd_buf_desc desc_list[CMD_BUF_DESC_MAX] = {0};
 	struct psp_device *psp = psp_master;
-- 
2.51.0


