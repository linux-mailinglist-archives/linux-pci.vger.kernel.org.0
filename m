Return-Path: <linux-pci+bounces-24810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01544A72881
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BAE3B5768
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE990149C7B;
	Thu, 27 Mar 2025 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AfbdFrJA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB481474B8;
	Thu, 27 Mar 2025 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040164; cv=fail; b=MlXxFLtXpixI4mMaFbiiBNZd2FuVHnoAXbjG9BJsVZJ0whjpfqa2Ln44r1byVcnP/Y3HqxPaXZ21/iJUnv/fJhadKHXGjQ0OJVTnLmlG1q+o70fbgRMOQ1jRMN1mTBO3JT9OEmgGhSEjYe7gaSShLHS1eegruehGiIBGYUi6ihQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040164; c=relaxed/simple;
	bh=MYmOxnTC4B0GUlauHCM7cnbpWb7bdEr4UbE9Ni7l3xM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WthyJQaD2V5/FZT28ym5ahXzFI6rr3X4dplc4wvae1MXtF7JNg2p1PZGh8vh6eDKq5jDZrO/6ROLuA5VCvtfRyva2npNcAY16O01UStQ8rzQ2NUyLnbrSnvb8ziNEcUBbbJz8MbmKzQX+aaVUXvVa5ieXrkBIDnKunndwsen29s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AfbdFrJA; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEmrXEqpwMJ3xRnMrUL4n99E0RMGGjKBEsEFFf6Lhv99S9QaikZ7s6es9QCtD1RzhmqtFU6sH/JH9ikmKG467BoImB7yPx6d8/L0sYgAdojZ+zpsArDtA9A4Gags7BlOEp2EwmUtV6aTXmxnPlqLbkJC4IAutgR3ojDWLUriuF9QO9oW5277h8m2HqNPcKHc58Gj7cluE02Zsydq1ShZbWe4UuPyiGvql12edK1k/pZn+umaYBabFxQD8sPYu3zhM64CT7EVeibPXCqqbjvIeODf2T+KuEwHoQBk4ne+/LnuXOL7ApMG6b/MUTSFb5N03CJ47RFt9NGgngJP+f9cDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlrbCBKi48nAXR62tJrL6X5Ze0TjJ+j8s+o4y9ZOSes=;
 b=dW9SF01Tc3XD5tX8sIlvSjENyNccFtjT2EaF0S0iqWfDpkhQW7p5rNnwnA+YgXigNkzAy3XQNJbC/45rQL140KXonzprbSCSxAawn8myR/5IxUAgIqYPa32GL8IWie4LCx/yAG1DTmuxH+6w6VlZw2LQO8OXJWtphuhmaCYJjO6cARacLqApgL9pAKMhCM5seA6M8uct678aO8/X3Q/V7NWmM4fq9spFnPOD2e4WKxpBJKVKlnaWG1zzLmfMrdafaUKUDy8x8SKT0uRDXsDRotypCGgkEwaZOftZUsPdYzpifpJ6crxfQFf4ifwZ6YmMtkj/b9lDeZdv/xQz1WH4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlrbCBKi48nAXR62tJrL6X5Ze0TjJ+j8s+o4y9ZOSes=;
 b=AfbdFrJAnHSzSD/Q7YGjikrdJC4mX3MOSjQ+DH6sfuFWQjk5xw2PaDbbrNGa3pv+ml2yYku5hv2hrDxXQoTuOoBzXIsqMNWh34wQs7YhkESoiUqk8o4pIOdScNhabuXjArt8tm+Dqcfa70e3tKp2YRA2CpMNob+bAkPX+ervUqc=
Received: from MN0P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::12)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Thu, 27 Mar
 2025 01:49:19 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::ac) by MN0P222CA0008.outlook.office365.com
 (2603:10b6:208:531::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 01:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:49:18 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:49:17 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v8 10/16] cxl/pci: Add log message if RAS registers are not mapped
Date: Wed, 26 Mar 2025 20:47:11 -0500
Message-ID: <20250327014717.2988633-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd39bec-1d9c-4007-b172-08dd6cd1967b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ga/i5Z+1F8La8C+KqoP2opQ+TqgI47avlaUH8QEl8wZSUFiaCjSSbm5fz4eq?=
 =?us-ascii?Q?gF63Eh1SxrEMD249dy/GTMld6oRcNmH7ec3ukdlEpzIh+eQj4V8LaepeG9uC?=
 =?us-ascii?Q?r2dmTNIqvZQUVMqS6ezlrmeDG2nOt1L6dCOQ7FKFcsR27JAMWCZ8vQ5DCB92?=
 =?us-ascii?Q?bUt5FuCiaRD6igNxnB4iJzaJADMsg3agCpmU6KjBvAVU2iMWKkI6mccttuNq?=
 =?us-ascii?Q?TESVkPwtbYnbJy3xs6ouvNp2JsY76GvSuGsGy2Zuw/EoH8mQH6FcP0+FQAUn?=
 =?us-ascii?Q?/uHX7KGjoZ4YbeEWQcmnW4OMIdIPYW/ASMdQZca1RbVeSV23qgVJgE3H9+Oj?=
 =?us-ascii?Q?JAEcU4+YzeA8LpNvr/Z/bDhkr6U6tM0bxw/A2TE/LJCOjOfEVZaQCYzlu4Xl?=
 =?us-ascii?Q?uuPfYKtLWI5j+hbNKieSE802yWA4PC9MM1N1IKNg+u/DJNONQvW2FFO+PKwK?=
 =?us-ascii?Q?FUtSDa9nQyantnHhitu2itdNReLaaSVelqZMTU09yxGbeibUaG/3RwK/F+n0?=
 =?us-ascii?Q?/ihGi88MMKtUU3eJVN3pc/2etnggj5jwXV9TWIbQohkKlQfO0UESz/FDqtQb?=
 =?us-ascii?Q?dkEyZJSkooi1FYhp0EtInu5CdGBtkHCkIDTZUHkLxWh/nKGX1Ba5bn72Fs13?=
 =?us-ascii?Q?K3I4/u4TdL+6Li9WZt2qZ+ym9D44gS/Tw1KvtQ4uCEZjg5KOYjFT2UiZGv9Y?=
 =?us-ascii?Q?nrw6StFFhd3TsprpOKY/urf3o7bQY9nUuZ1qET9ALd/9vfr1QuXHj9ehymG9?=
 =?us-ascii?Q?FUmaYZGHlJvkdK8t1YKua3XSs/yOEr42VH0Ug7iMu1PvhorQNoC3mQcrtX/I?=
 =?us-ascii?Q?oeaGRny0GWk/IKh7tA5sVPcSNG12/sdWI0GpHN2r2VZgsqGItLBmkVLBPrMv?=
 =?us-ascii?Q?YUAeZNjBWv4qAKJ8SnQJV7NoluN+M/OW9uLETmthVuCYIhdUkSCFae8e3QNb?=
 =?us-ascii?Q?yjUj07OtW2Bxy5leOGfA7cuqa6CNJk/AD2C4e6sswMHpOoVKjTg3Duu68qFG?=
 =?us-ascii?Q?RqBqz8X+YlQNJbMxJoevuOSkLusxoBBKcSFwFEVCDcIEGmWXtTRQG8xTzKND?=
 =?us-ascii?Q?ptcdyenPeGeKJCi1ICces3VY2ETBcIIaU7gk/Yjn24qBmCJoTPo7XH4IAk71?=
 =?us-ascii?Q?9JEMy5kvrSdf7EvSfDA9wMbzmwd5FThgBCGKHq5cfoXvMoNgXrME/CTcimTZ?=
 =?us-ascii?Q?1m3dc8iZMAl0LjkpmPoVjdsEaBcQdqsA/xzH+MHY0CsbdapY+MQBPA+6EVXZ?=
 =?us-ascii?Q?HrIXH6p4gI2h1L00m1+Q06CjWRVOMYvKlwqYVZfhMi6m7WqUlWp9lAxmlJ3c?=
 =?us-ascii?Q?YxZY11qwLwOFEWEasZwrnpwM7O45AMsrRpMlm+iMnkKanA9mAWuG+qsoeKYw?=
 =?us-ascii?Q?HzEvXRSU/n7o3fNzvIsmyQ5zGZ8ZaUsYB5xXQ8CFM/4a/tIoqxKOxDIF1ybg?=
 =?us-ascii?Q?ULG76a2tujEMa6qWoy4RuJmH+8j6VxBAbsaLDudXs2EyT5ECBV5JMFh4uIpw?=
 =?us-ascii?Q?/WBMC5FPc4Me+PkRIiwssH1/iR7kNW6Jf2Pr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:49:18.4819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd39bec-1d9c-4007-b172-08dd6cd1967b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785

The CXL RAS handlers do not currently log if the RAS registers are
unmapped. This is needed in order to help debug CXL error handling. Update
the CXL driver to log a warning message if the RAS register block is
unmapped during RAS error handling.

Also, refactor the __cxl_handle_cor_ras() functions check for status.
Change it to be consistent with the same status check in
__cxl_handle_cor_ras().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 1cf1ab4d9160..4770810b2138 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -656,15 +656,18 @@ static void __cxl_handle_cor_ras(struct device *dev,
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return;
+	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
-	}
+	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
+		return;
+	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+
+	trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
@@ -700,8 +703,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	u32 status;
 	u32 fe;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return false;
+	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-- 
2.34.1


