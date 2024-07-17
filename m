Return-Path: <linux-pci+bounces-10472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806D93438E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E229E2852A8
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C35518D4B8;
	Wed, 17 Jul 2024 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ls0eehuc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E118D4AA;
	Wed, 17 Jul 2024 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249848; cv=fail; b=jWNjAXm4Ys1/38uB+qua2dmohEmykWjKAixjldOm4ET1gMpE56lMzqziMhRiXGtWqLtek+NaIBRrv+FZ5kaa0kd9ZCgsASrEO2dJuqrbKozRR7ajpNCSZSZxVLUI8Km2XrEm75ktUsSEkL06wF0DDX66KyuD0FBrX1YctcLnN6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249848; c=relaxed/simple;
	bh=L6uVgYXb4jiEUQsUIZUKyvThyUcAUo8z0y5McPcgboY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0Boa5OYVc/BCHap8SS48OsspLhc2VstqyXtiR4bEwkjnOUJEoQVH4OKEitlnlOWuHw+S7/dltDty6icq/+NVoyzAwfFl+eVRExWnvRVVQqNBsfX65fUCsbcFQZk7lqY8o90W/uzjq0OUegYoBjpO5QTEu2F6DMK2BvvxJpj7dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ls0eehuc; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVXbzoaopx/60JlhvLqeBgZfMgadi/5nYNsVRCr8cjmYq6Eh7o6jsIMGQD1z9bCcc3B0tiTPx6y8sRIc5otkyiAVfa72W+GgwGXTjvp+gBl7wWqT4SlhVy/zV7GgxC8dabsDozwqERtGswJ1JuHl2nCcmZ8qs9HOxDuWXMY/y0wRKv1kiBy/ea9sD7Bxv3qNSV017nE16RrgykNdr2GQ/+q/Mi3k2dPV5tQ2x+7QzZvD+Ei/NXRNx/iOjXhAkI3PW5wzbUlWYgbQwupI4N1LPJVMXW2UU1YWaBM7FduQgL9Hu2ZWe58gAYbgFR7Poqse8uirmWUI+FKgMd1ltjXSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0JjUx42yquUrCVZK9l/ZQR6cp8uqnlRxa1afchh9HU=;
 b=CqgzcRWH51uPGTT3+o9U5XcqPcqEvvKMvWdJJpJeC6u1yEa3l1kW1/C97eiaC0ksnYqpcySMk6qDifRZXHlS3eZNESTK9fXAIrKKglRVc3NaIngyvvMhxyeaUzGf9K23Dm3Gpo7t0gjH6BPD96wktpD/qpKmI8Ca3I4B6GiR1G3Ggb9cU6On5eTv5QxnxvywUhjzaMzd6DoEYx2lSi7kmU5zr+fMYAZhtUeDAT02vhTkKv0p/2wrICCc7E0Hcxd/zFeYz3xYn9m3ax8VQEpZwszl34ekay3Zn8ESmHsKGLsqo0NTVG+oyC0a0fblJpiLHhyWoBxLGfv5HnQ0rbASVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0JjUx42yquUrCVZK9l/ZQR6cp8uqnlRxa1afchh9HU=;
 b=Ls0eehuc2uF6GlZ+YbLH1ZrP4mf9qZ9x2znmUFrDNQhor49KYGlPMNRy6YmFARazuCVsx9aW6mBmMdVfgxAOSQTIpaN8Wn5M6PbE1dBgDz+3dDio7nkRdjBQYKXWZhFY0O1xtwPbVJh891cdgz3r6Q5kSdaeJyfFggjY+AHfSJ8=
Received: from PH7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::15)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:57:24 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::f1) by PH7P222CA0004.outlook.office365.com
 (2603:10b6:510:33a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 20:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:57:23 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:57:22 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>
Subject: [PATCH V3 10/10] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Wed, 17 Jul 2024 15:55:11 -0500
Message-ID: <20240717205511.2541693-11-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240717205511.2541693-1-wei.huang2@amd.com>
References: <20240717205511.2541693-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: b84f2344-2755-4fed-896a-08dca6a30ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VVMJfGa5moz6SpwW9U5OP3Jd4ixfcroAqepeIX18NtxyaEIpsoqqRclm4xAX?=
 =?us-ascii?Q?MSjaVb6lMcm3egPia4wMXdoPwxz/mFWaoYd/NwLAWrJjSZ62gtBRPKFYfn9u?=
 =?us-ascii?Q?Fwkr2zThiB0qac+E5qpzqGLzKmmDTgiAHdfX+eO7dwG1pZEUcA2yIDKJiUll?=
 =?us-ascii?Q?o4YmfdTDje20ktriLNagHJsPTUK+VPuPdA5NHBFQKwqp11o9Mud74FzGgZky?=
 =?us-ascii?Q?u1Ay7HQVu0naP7rqZTSVvi1avgmo4u/MhG/csgkozCq0uOlZ8PzeRRHhxZuQ?=
 =?us-ascii?Q?nXqd4HdH2Cbkgot95vqgpH8vQ5I5b65mR/coUGA2RX4bm0HEfX5JlDAlAs4z?=
 =?us-ascii?Q?zEfZFJW/B1iUUNN6/F7FzHGiE13MrB57JnZ/cGQCilOIwBMeUtn9+VAAj57u?=
 =?us-ascii?Q?onTy9KNbgf0pMiNI3CFmPrpeqEeTe/f2ZH5/yMA62CI9CPy01IF7X8hDEezY?=
 =?us-ascii?Q?NBWBhGzEYF+ZdavnARmzuNTFB91IYO9/xFwgt+Z2s1J2NS9t397gh9ZNcMll?=
 =?us-ascii?Q?8EXHcDJmdb8AcfSN/S+p3VphgmujIVtQcKTTlScA8k9VpV5/7Di3GXzIbC7B?=
 =?us-ascii?Q?xx5Rb8AxPl0d37FrY71Vf54CTo67wGeqTa2RKDEGOjaobgGwwp/0nR887rac?=
 =?us-ascii?Q?acNKVH30Uye36XhmlesckUHL8yylMavB7Wsr9Qm2lTPtmEnYe/4GchH2ndAK?=
 =?us-ascii?Q?H2SaHeUvdq3zIqczqzMhx7eAEeJ3jUnnBjkNzHQRkTjOfXtW5yUn3rLFc9OF?=
 =?us-ascii?Q?0JJZKag5aGClDlggvWB1+4wo4BbOWk7tZLc1umlNciKDgxzTjJAlWP0/yqIW?=
 =?us-ascii?Q?Dgl9ynx0KoaJChbXpn59nK2TC9u4EmRBuWojnb9C2N7yECUWr0lqCCzjQbFV?=
 =?us-ascii?Q?H4vRTzsbc+VTzvwA2hWoitIAFUXWteGAJ/QKnShnm9ovcWFIWB3TjLuPgzSg?=
 =?us-ascii?Q?FVuPG2bAJwNfdW4+vrDKMJvi87hGRIi2SGh2yN59xX1ISjNLaRE1Txx7tCMh?=
 =?us-ascii?Q?TKxHuZ7JKGCS93qOQHDij43Mho4copm6Kv8CYlmBdPR+gRaBagxI7aeI7RV9?=
 =?us-ascii?Q?6yHs7VBEDJIGuJdDKMiTXQyCTmGFizhUvz8LBTVQ7UNDfuhTlBObCYfBnJKH?=
 =?us-ascii?Q?RSQxs0r3t5yUfuFZ8sTTV4hs44hfPjVHVadMSQKimvE7b/K95MIz/NKulLPw?=
 =?us-ascii?Q?7vgyvDS0UGCBBzIussrHVyJlfM0RTL+eZ8wggBbKHK+dXoz7G/r4N1YL7Ppt?=
 =?us-ascii?Q?FcTtG2UZZZaCJ4S2wFbMjJ0rJ4drmczBi2vyVOIhAXL953MNVVMd5C0Vtu9L?=
 =?us-ascii?Q?+ALWUHslfB0dROGTi4OwjfyMom9ERwdSM2wtJO7HXegKLLibXWEPAlznpLhF?=
 =?us-ascii?Q?xmIpDnKnBTIByvtKRN+eN03I1NrAKcm+TNvg022P781/eI3cygQxs7sBYDEM?=
 =?us-ascii?Q?40OwkZaNnWg7heF477j7PNIWTIpUcj/K?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:57:23.5428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b84f2344-2755-4fed-896a-08dca6a30ec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322

From: Michael Chan <michael.chan@broadcom.com>

Newer firmware can use the NQ ring ID associated with each RX/RX AGG
ring to enable PCIe steering tag.  Older firmware will just ignore the
information.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2207dac8ce18..308b4747d041 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6699,10 +6699,12 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 
 			/* Association of rx ring with stats context */
 			grp_info = &bp->grp_info[ring->grp_idx];
+			req->nq_ring_id = cpu_to_le16(grp_info->cp_fw_ring_id);
 			req->rx_buf_size = cpu_to_le16(bp->rx_buf_use_size);
 			req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
 			req->enables |= cpu_to_le32(
-				RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID);
+				RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID |
+				RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID);
 			if (NET_IP_ALIGN == 2)
 				flags = RING_ALLOC_REQ_FLAGS_RX_SOP_PAD;
 			req->flags = cpu_to_le16(flags);
@@ -6714,11 +6716,13 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 			/* Association of agg ring with rx ring */
 			grp_info = &bp->grp_info[ring->grp_idx];
 			req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
+			req->nq_ring_id = cpu_to_le16(grp_info->cp_fw_ring_id);
 			req->rx_buf_size = cpu_to_le16(BNXT_RX_PAGE_SIZE);
 			req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
 			req->enables |= cpu_to_le32(
 				RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID |
-				RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID);
+				RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID |
+				RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID);
 		} else {
 			req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX;
 		}
-- 
2.45.1


