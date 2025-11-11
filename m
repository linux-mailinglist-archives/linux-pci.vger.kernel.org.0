Return-Path: <linux-pci+bounces-40826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C10C4BB21
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B482B3B556E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1123B2DE6F7;
	Tue, 11 Nov 2025 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xeL8IAwu"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5212C11C4;
	Tue, 11 Nov 2025 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843159; cv=fail; b=bEsDWUT6oAPyi/sHAi26FPN7VbUnvpC16CmDh7pt9CcEn7oML1BBdJFx8PRKYjfPrI1ynrV87E33FJfW8YmhkVnHFeC6jpQt8wupIKWhvH/l9it7zGGWYVYcGrP9lFrx6P/Iw1jmM0C+gW8WNc7PX+TuLWR10w7jdApoRZ6EQmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843159; c=relaxed/simple;
	bh=LdXNT8U9Ze9zbJNrHMSOEUC08xnFu6VDCvZJ4ri/sx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpaXQp24FmgYPGIMo93i+0wwI4n+0SeFcJcBBrXWddBhQap10IUCd4eOI511FM2zAYV/RJ6PftgI6ECYilt9WKRvOXq1Ml96+nBWXMZDahjhpexx8+6/6qJHeKRTrbTRQddcRo4RahkoBnFDvGbJ42ina6BTvAtwTwOjQ8jCQhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xeL8IAwu; arc=fail smtp.client-ip=52.101.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuwjaT8MPbJUEqE4jri/uMB43qJVLc2C0dJJsSWwjwUwhSIdgseLaszETwAeJTuttalBO7/Zo/i4QR90v3zn0YKyNwLQNNdH58/T2sP7RiIdaYjVOSVYee4EO36+KD0cmIRXeOk48C51/26J6dHm59JDdQxWOvIfM14RWebFTPDmLeVTdDq/oGdwvuBnFEIwRKVVJaBnbTt4nLVNwvxjEQERw04XIDKbGQoFNV1O4couZUWx3rsgwLFZnU599aXEbyihwePDwT9ITI9iWkdZuIvBqe9ctj7ziGEfsI8NyyQwBVqyAkgv44PTxlXgwZQtqIgF8dd5mbT/HeUDU+GIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgCByMxESHCEF7kpck9BQJUy+cH1HToYvEIK6UUG+zo=;
 b=NrU3ISNAF02nzxk+jPq9KgmGGfs3a2ULTrK7Mr3scMdkuoF9NqQi4KQG545kjwqKIbDFZ/l+Sdzta0dDUa4vXbMg6aaftvir5NLsZ3SUgLjKC1uP54xjPJqrLqWXEy4Hv4GFvAWdTtarl2qjP9lB4Ly4knYpC943fNAou+xVg6TouHLsO6Hez4CRuTIwEgU62uraBDmsbv1jKACgEQ6d2hqY6tPo9ixnV0yms2ZI5hDDlKjs/k1BItExFEK6SmYqxRGciQIC4S7rssHRZPe3tLppzeWtf4sKgZ9I2E28aBlvta2diGumJs3bfqcLPW1Uv9+QSxn2dahzQ6pRdYcXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgCByMxESHCEF7kpck9BQJUy+cH1HToYvEIK6UUG+zo=;
 b=xeL8IAwuahQs9lQUaBAzew6A16VdyTNuLSB/d6mV+v3T21wymvDKWFLCIvKfBl3xv2jnzV+vrnT21Oa4Xfa2WjEkInSToO5B6N3bi9/dGuml5YuvcRhrn0DtYyJjT05pwqnTX+nNZog5GtQQzmqrJRhn+j7U2gPYgyG4/PIFrI0=
Received: from CH0PR03CA0302.namprd03.prod.outlook.com (2603:10b6:610:118::24)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:39:11 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::7a) by CH0PR03CA0302.outlook.office365.com
 (2603:10b6:610:118::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 06:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 06:39:11 +0000
Received: from aiemdee.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 22:38:59 -0800
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
Subject: [PATCH kernel 1/6] PCI/TSM: Add secure SPDM DOE mailbox
Date: Tue, 11 Nov 2025 17:38:13 +1100
Message-ID: <20251111063819.4098701-2-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: c6071811-be8d-4074-85ec-08de20ed05f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?agpUSwKQnRiveYg42rWCmQp/jGW9I53U+U32fZDUQoMcOrTwyY8lxFxaeJdz?=
 =?us-ascii?Q?Knt9q8894mrHeasapALez7/Oo5rKLbw/1s+szYmTEW7Glp4CvI8fNPrSbQeo?=
 =?us-ascii?Q?6ACcw0szwjO/Gmq4SObXD7ksv3v/a9Yiik2xdAo9QfNwRNz8NqAfXqNfYNLB?=
 =?us-ascii?Q?lm+BD5BeUTknpBloLJmiwNV73BpJzleFKgfBN1G5YKpm9PjYbRxezqcnjygY?=
 =?us-ascii?Q?+FGF2RCnsDnY3kHthbnnNOlJTZd/rAKCmx5tHdWEF27DDt8aQcaqQ8zo8uTC?=
 =?us-ascii?Q?a2DxMMFjBYQcJbeN8elSdrY8L5FBeJWyDSRKelSpJiw0t6BBR6EDDSUgn3Qh?=
 =?us-ascii?Q?omHNBRYRe4KCLb/376QK9sgg5FTujz83vyBwo/HuooGJPaRaxDLP4e3lPRMG?=
 =?us-ascii?Q?v2YkwI1uIRhQE5WGQ11r8K3j/Klzpe8maqqTzFRQP6vPznVhQ43m2JrM3Rus?=
 =?us-ascii?Q?NqUS1lBYl1vlteqTtJ+OmlIu7N3P91FzlCT+rmPf3+g1RNiQuhWn+OctIxx6?=
 =?us-ascii?Q?fpvKsA5pcMwU9+ymq+tuTqp+fP4y5iNCPPrOjmKzmfTMk5R45NqT9cF4eLH1?=
 =?us-ascii?Q?KWPjnNEtKuoWkziDvQYziJKIjBgtG9sg2zrkxIdDbrKZzGtmM1dVyw2Kr2gr?=
 =?us-ascii?Q?7uzBFxdheQ4UbqMRZGWO4jwcd8fct2QzhRffRp/AyNd9wz0v/8XwR9R1CfKq?=
 =?us-ascii?Q?zD7ustyCHxKOUxuYF4BLq/Ij8ARiFBP87Rel3EGPkKXVu/dbGm0dSY/Qx1rm?=
 =?us-ascii?Q?y4j9RG3kpqOj+OpNLA6zOno2ofg27jPoQIxTDxrDUOecXUgbPdYKD0orkcCm?=
 =?us-ascii?Q?ECc46A8IKtdekbWn7kItxp5V9qfN4duk1LFHHLkl1ROYReCJO8w9wf6aBUz4?=
 =?us-ascii?Q?MIiysCCRK8AnKh9kPMswAL347aTJ8FC4S5zjL1GjPj4/Pc7nfyadHXuWejRY?=
 =?us-ascii?Q?JqXQ7Y9CzsQw/xsBdtBxGFT28WO5cOnNjhQeCwyzQ5CjpWMJGCjDIodLnoGw?=
 =?us-ascii?Q?ioPQF3rkjkqj1jIQ/1i8d514nnINQSZ/Q0TuCDiMZX2WCPl59RJ/Snf72DO/?=
 =?us-ascii?Q?q33eIWyAbFYgB4M20OE2TGRb81F7iV0ONpgfKkZnTDR5OFiVw/JT1D0N0wA9?=
 =?us-ascii?Q?YjHWIGgYP6QoEYbIJMiR761sLopKG09to3EARsOOx/UuE/zqqm7IyCh4wEuo?=
 =?us-ascii?Q?qyjEmiZ3cZL9ztVBD546TGqBSfxHY1sA1Xapi1dAK9b2Ve9comjHYsMu0YxB?=
 =?us-ascii?Q?1lqXB7DEEPm0CseA0bmL/xBd9zHwZ2I/1jV1m752Q/yc098NEEEX5N9//i22?=
 =?us-ascii?Q?ZZ675z5y0NpJshZlygl5IEgduI/CrufFD95apO5gN+Wm5JHsZLuZqTgaK8SI?=
 =?us-ascii?Q?+/wi3ixkUx1FLSBYA7vepWTB7OWIi5wBNH5FgsMxu1QIXtrqBgPvwoGJdAWg?=
 =?us-ascii?Q?YfQS7X091PGCrBiuljiLrqIQwIH8Cg/+oJzIpovEaxT5M8I8tjLwkLIZnIEK?=
 =?us-ascii?Q?/W6b/9/TqTEBqBlrf1QSAeaK9UXsXrmVppVyN6Thk9Bg8aGzmmlw158ySi6a?=
 =?us-ascii?Q?HO70C9G24UKcrJrLMOk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:39:11.2244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6071811-be8d-4074-85ec-08de20ed05f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986

The IDE key programming happens via Secure SPDM channel, initialise it
at the PF0 probing.

Add the SPDM certificate slot (up to 8 are allowed by SPDM), the platform
is expected to select one.

While at this, add a common struct for SPDM request/response as these
are going to needed by every platform.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---

(!tsm->doe_mb_sec) is definitely an error on AMD SEV-TIO, is not it on other platforms?
---
 include/linux/pci-tsm.h | 14 ++++++++++++++
 drivers/pci/tsm.c       |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 40c5e4c31a3f..b6866f7c14b4 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -10,6 +10,14 @@ struct tsm_dev;
 struct kvm;
 enum pci_tsm_req_scope;
 
+/* SPDM control structure for DOE */
+struct tsm_spdm {
+	unsigned long req_len;
+	void *req;
+	unsigned long rsp_len;
+	void *rsp;
+};
+
 /*
  * struct pci_tsm_ops - manage confidential links and security state
  * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
@@ -130,11 +138,17 @@ struct pci_tsm {
  * @base_tsm: generic core "tsm" context
  * @lock: mutual exclustion for pci_tsm_ops invocation
  * @doe_mb: PCIe Data Object Exchange mailbox
+ * @doe_mb_sec: DOE mailbox used when secured SPDM is requested
+ * @spdm: cached SPDM request/response buffers for the link
+ * @cert_slot: SPDM certificate slot
  */
 struct pci_tsm_pf0 {
 	struct pci_tsm base_tsm;
 	struct mutex lock;
 	struct pci_doe_mb *doe_mb;
+	struct pci_doe_mb *doe_mb_sec;
+	struct tsm_spdm spdm;
+	u8 cert_slot;
 };
 
 struct pci_tsm_mmio {
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index ed8a280a2cf4..378748b15825 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -1067,6 +1067,10 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
 		return -ENODEV;
 	}
+	tsm->doe_mb_sec = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+					       PCI_DOE_FEATURE_SSESSION);
+	if (!tsm->doe_mb_sec)
+		pci_warn(pdev, "TSM init failed to init SSESSION mailbox\n");
 
 	return pci_tsm_link_constructor(pdev, &tsm->base_tsm, tsm_dev);
 }
-- 
2.51.0


