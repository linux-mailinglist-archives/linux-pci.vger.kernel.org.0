Return-Path: <linux-pci+bounces-19470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61830A04C5B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B421886B10
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE81F8930;
	Tue,  7 Jan 2025 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZsfPxcri"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAFE19883C;
	Tue,  7 Jan 2025 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288956; cv=fail; b=jhNoxWSOf5LEXL/n7Y4sZ9f0IE9NIO2UtZIz05ltB2d6xpVMOpVU0BEx1RUoh+t8Uepc03lA+UujxJFoRuzouHyds1MjsVQPZ92P9pZDEtp3j2gmG12XURu12GMNL2jwEd0ZgaE1xWlj5LQmo8RYwcCyRABojREtdo5Otz9B4X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288956; c=relaxed/simple;
	bh=eT4QOn6i+F42MOvmmgrHNgO4yOFqO6H1OoWI43V8N6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ad4GClz3/3Bj/l7DdBuoGOvTxnPUtYbT6pkMWJg4vUNZ/nJgxrQLzljHxM0Bgu5bxNFVzNXuKoTc9nAzzw2k6L4YyuzW6zj1s0rqBNGT9n564zWU/2/kfm3tDYGUziJZ415ZmCjyrsm+chCDoIskGEQwHGTu9B2WZh3Qdv3qoEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZsfPxcri; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3uSGGePGyTvDCjlrse7F7qwNO66U+kcqw4E9EaNTJ9ukWkgNeJGKC29RANgNMvKs4LOAbZXQSy9Ay8pSfrWO3TIoPjfdxnPuJsL9p6WPe9MXk6Ljma9odGhuTW/rYy7MWGLwrN0/pbQs5Dm0+Tl+qUt1kHNcXItaoG+NP4p+9j9dikmOlFR2iT44hEYWO0X6T0f3FoQVezmJZ96gJfIcymRqVLZVtWY7GnIovX3bft5jkDNw322g+I+RPrKRUjnBVScZYld9UuI3jgSV7jCL5lilRwCJP0E/FfKOSChrXpjTxEgZ/IlwGIXJJG4Ruuj4YveHvH+sFPPy5yHW1kEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oO3rzNo163jw8vfGuuZzx4tfRUSllfmNOA9/1VzM3k=;
 b=apkn/SYTq24zsDc6V+ERDXQlQvtLKzyE82LRkvdj5zFnSIHioel2fjorWLvpLJAS+J37RO9PDHlnT705nfTaNmABAG4s6JjORs8RghUM7lgR93pElLHUwKb7W486PrgMQrcPoEjQXWcKIE9+ExHA7SJVKyK8XQklh/2vVL/0eKeYgotdXl/0FgSZKlYiz+yHcqVdpjtM+1mxKuwkVFyltaRD0vkxjH9VeEhA+XtPg3K+Q+/zxwdjAHhIwEWZgTWJMuzrdDXmPIhskEYFTkCAtI2EGrAbdNiWu+SrCkHITr2DH5NWRSPMuhTNAuc30RlCUDY+gnVPzNqRuG6ufXbihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oO3rzNo163jw8vfGuuZzx4tfRUSllfmNOA9/1VzM3k=;
 b=ZsfPxcriv8+ylipvIvpQZRf5xpyuC0IbkJqh9HSTMrRLgkCaHqFCniEaVz/P5H8cEaRUo5Aj0OaI425taomukhQHy9DE8Mm8as4Y6qgHkoaa2AeDzKZxVoE1qzFsj7Du31hIADg0sqVmtDIV/H2cvZJx2sNf3NRDRxSH3MBgfJM=
Received: from SJ0PR13CA0224.namprd13.prod.outlook.com (2603:10b6:a03:2c1::19)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 22:29:06 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::9a) by SJ0PR13CA0224.outlook.office365.com
 (2603:10b6:a03:2c1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 22:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:05 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:29:03 -0600
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
Subject: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node count
Date: Tue, 7 Jan 2025 22:28:41 +0000
Message-ID: <20250107222847.3300430-7-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c36c6c-a29e-4877-a0b5-08dd2f6ab226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C6Rw2a6BL/0VqKQTBT0FwqMDZ9KG8C5MC5uj9UjVQkdYIAVzzs+hLL2VVuNp?=
 =?us-ascii?Q?Mm4mFAK5vx4/7V1d2mJxcYNnXJNLxuGM9gw8sfb1vTL1NoQqpKJ6IDq+Wn/k?=
 =?us-ascii?Q?55OfzdLJLVRs0JiNgVDpLHYFv/AmmY0MruTaK+evAkb5vR+ykOCe17VV1x+i?=
 =?us-ascii?Q?Xdea9YG2Rie16Gm1YL3iojykmd9rcfT5HzefnSn1riQ7COdjIqY5oC9XTZUr?=
 =?us-ascii?Q?CP0wyHB0Wl3YcmDartxQoR2lgMIwrte7O8PnVyyZnY+jUvuWXKLmQzt4W0O7?=
 =?us-ascii?Q?36+sGhtOgIacjMrSy6L/ta9Sa4Wt3SS92vA7PZnWdiNl57fRJLIC9Fs8LhKE?=
 =?us-ascii?Q?DjfDlOiKjWk9+Ddy0LgvgaJPwzz9mt+nXswJnOZaOvdye9prLsp8IVJgITPV?=
 =?us-ascii?Q?s+WR7+jKQx/Ed1eDg8lqzqRKVnm43gfWpsjXMrzf18fB0tRRp2jHe0k2LQbu?=
 =?us-ascii?Q?5zFWGReLYulCy9ZvzhNCq0yDV1wbxhtql01paScbDBWWBw8vM3DNDKh63mfJ?=
 =?us-ascii?Q?ySkU9xJiq2vqW4qBys0ghCmyIoGwhga26MdtFwoldQZSksPPq8W4CCynGPJl?=
 =?us-ascii?Q?8r8dYNTf96I9I1eSwAaDRBoGWVOvhMRsMaXul5+eUDY5qFWQIiqOe4gTUhXV?=
 =?us-ascii?Q?gpsRKt50ndiZzzJlZJQr3oVXIPkCl6vaVECXnm+vDxfhUsw+gA3LpCzAUxim?=
 =?us-ascii?Q?SmzDwg55e1j1pgxEcjG1QJlxlcdkgoDsmwYgP/2pvpkUDDsV78mKSYXtWVtP?=
 =?us-ascii?Q?ditbY4e3qhBaDFx00/1OdvM2ARMvtzerOOtnmd/eo3VfhGiSNZI42IAyxB5h?=
 =?us-ascii?Q?P97G9t76+NqOlqF7bIt630QtikKI6JrdV0oODM+tR9DqUfKnwmiFXHbaGj6G?=
 =?us-ascii?Q?IYc2+Kju+Dvoi7GDb+zPpbwGcLblD5uHtrgIyW3iaAzfXDV3Ysw2PAXlBsyt?=
 =?us-ascii?Q?FO1d0hJHeaItb4+yjlb0hcsIIEbPaXaJxu0Gur7y2iq8Wq6k60Nn5yuUHQXZ?=
 =?us-ascii?Q?1b3pybPK6i3IL7THJKQ7GrMHkmIzKKApptYvoTPTPvDYT5ZNgDUYcaXRmyDV?=
 =?us-ascii?Q?E1pEG/ff4yRnTx4xw/ojkgHK2wV5PXRu3gioQ4BcRk2XRfOIN/AWtaQHIjQt?=
 =?us-ascii?Q?Y1It3jytaGg3ei/IWk0U0iYkgOrZx+e6yWqqL7m4WKt8PJHgIZUY4jPuT19k?=
 =?us-ascii?Q?FcwMToz9EgYuPvVMlGyPhhwQkKCVYDqpjoRV0SA0RvztB/jiMR/BQ2eaNBS+?=
 =?us-ascii?Q?IwfFVjy5PugKU9xmqSVyXncIR6/UTFlpAG0xNbSPbJI4I9+A1RxSCmkmuGbc?=
 =?us-ascii?Q?Q1F3LSVdTuw/GRw3jp/lqg4TpPf1V6RF2o6BnkdOB4jZiTV+ggnR499WjstM?=
 =?us-ascii?Q?qXwt6bsITktIVNpX5P9pv/ncOBxkJhRJ7mJFcyXnQsXXRRsDNX7tjQDhN3CV?=
 =?us-ascii?Q?mUOV6Vb3A82ny3goYQxlBj9M6HY86xLOYIgzbS/glPC9ZdOwpmpFLfU5OhWh?=
 =?us-ascii?Q?jfkLADFLIz5RMG46Tl3DjYH/5s+hQHB07xRv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:05.6830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c36c6c-a29e-4877-a0b5-08dd2f6ab226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

Currently, the total AMD node count is determined by searching and
counting CPU/node devices using PCI IDs.

However, AMD node information is already available through topology
CPUID/MSRs. The recent topology rework has made this info easier to
access.

Replace the node counting code with a simple product of topology info.

Every node/northbridge is expected to have a 'misc' device. Clear
everything out if a 'misc' device isn't found on a node.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-8-yazen.ghannam@amd.com
---
 arch/x86/include/asm/amd_node.h |  5 +++++
 arch/x86/kernel/amd_nb.c        | 22 +++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

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
index 6218a0428c77..6371fe96b988 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -186,7 +186,6 @@ static int amd_cache_northbridges(void)
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	struct pci_dev *misc;
 	struct amd_northbridge *nb;
-	u16 misc_count = 0;
 	u16 i;
 
 	if (amd_northbridges.num)
@@ -196,25 +195,30 @@ static int amd_cache_northbridges(void)
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
 		node_to_amd_nb(i)->root = amd_node_get_root(i);
 		node_to_amd_nb(i)->misc = misc =
 			next_northbridge(misc, misc_ids);
+
+		/*
+		 * Each Northbridge must have a 'misc' device.
+		 * If not, then uninitialize everything.
+		 */
+		if (!node_to_amd_nb(i)->misc) {
+			amd_northbridges.num = 0;
+			kfree(nb);
+			return -ENODEV;
+		}
+
 		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
 	}
 
-- 
2.43.0


