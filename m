Return-Path: <linux-pci+bounces-13723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DFC98E166
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 19:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D934F1C20B33
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334511D130F;
	Wed,  2 Oct 2024 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h6zHtjqt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7D1D0B98;
	Wed,  2 Oct 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888477; cv=fail; b=W+bzICzpocNcovvXqmtIENBA6SMlaWVEYAbyHK/vo9lx1AM3tSRCGFn1FIYjJtrS8sz7tU1JOOcKja6Itcn3MNXkjYF5XHAWUu1NBPsNaM6O1Vnx4O9JHQcCbqHYQGvWAKbRysO0UgcE1Ze8XJ0930RRuuImaUf98pvP0TC1hyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888477; c=relaxed/simple;
	bh=yAZK6hUfDiIK8k8WzNKlB3FUTEfoOUj/1LD2zGi4cQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOrrgPDBjP3InEqC4fZDZErrnpOvh1az0Bx0OldQDhPg2S3QYG/Gd/AXsUSv2aKSwX5dof548ZF3NdNRd3gYt7N4pyxK5WJO47hJk+9+YBbUA4w8+FLXx0fgPUAa5Eton3pbmQ6caNvTKNolsB53f4i3PhvuZTul9gG7Ty1Jykk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h6zHtjqt; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v09N7Um0dwkBtKohqsNIhglZ+1/8zVp8nz67n0Nq0p/yavijW89O+0e9ftAoQ+z6CHSvraAiVOgcP3gxt/qt595pCFVR9m2jzWUH6KqhqVxolG6t1NIq1vkxy1UeYUX0AIPj1sVzmQmXcjIowIifiTNyrs1zeaY7bbt729HT1ptncKulDFoQ0JjV0p8/J9tjKdy+Ro0fKgmNsvaHXUniwezScFxaRww+RUCHtm+0RRVAJPSUiqyKvOfp6OTkOtaVYwta5LOQp2JZPOTkcc5bFrE5WWSugXVvPpa3Do6l7t66HP6Y8zqy0w1bVxrqF6ZUBHd7xWKMSnV71sGUWIlR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNgpq07v5YZYLTb3beaoC4kaV0hX9qVoFMDzGQPEADc=;
 b=ArpJ0Opf5rbT9NVWj+POJNaNisYvT60+k3+ubZzsRz2AZ9mBm2tFaEb/lPsGPmO58WnzwkXPq5Hm0olEu5g+anjesZ5WKvSUTJBteW+6lT+35qHSXJKO1TgMSJkLiu3JJGhYoiPwLBF0wIT7PRCOLvGdRRCrRGYJjrjZCvT1OqFylDxCnwbDE8YD7ZRRTY/NZw5x1Tb3xSurU+DT4diwVeEbpL+DPpuvVWiU65bZolbAizO+tIYpBFXEH3UmhiWjmiJWacWgZmLK8IvVF0TDEd5ZiRAAWnJvbT5B3C8S4OUQRfr2/XuK+jzbFcbSFBCZW6BrEbJaq3cz3YkjW74xGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNgpq07v5YZYLTb3beaoC4kaV0hX9qVoFMDzGQPEADc=;
 b=h6zHtjqty0QpU8xaoRz2hpq9NlPwtUitYiAsW2n7xvEbyHsQtEJOVHF9p+g4bdcvDk5b/t3acHzhgqjBiLgWuNkS98HgSSe6RI3ko3X8omwGCDKeUCts5CduUYCZot6S2OSRuB/CcaOdxKI5uk0mpQ8F7vz74WYSXwJf6rDiWvc=
Received: from SJ0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:a03:33e::9)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:01:08 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ce) by SJ0PR03CA0034.outlook.office365.com
 (2603:10b6:a03:33e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 17:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 17:01:07 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Oct
 2024 12:01:02 -0500
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
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V7 5/5] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Wed, 2 Oct 2024 11:59:54 -0500
Message-ID: <20241002165954.128085-6-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002165954.128085-1-wei.huang2@amd.com>
References: <20241002165954.128085-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 171f3b6d-8504-4b57-42fc-08dce303cf16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fVqLuxyZmq7asMCSAGntYUQAceWnGq2b5pNYO1VFUWJxFVhgH8RdgGIHwqN0?=
 =?us-ascii?Q?yRKGdffGfae5S3pCnAoV5aYWGlGhUUtSJXhNqoDEYpK7PlvOcvDZUbyoSnRV?=
 =?us-ascii?Q?R+AczbQcLvHOlxpI13DU8QxXFSYj3vEz4ZOkUV4tjByCIRbsJl82IpardjAs?=
 =?us-ascii?Q?h+kWYKx1US5MrtvAzObs0ZHmplqoOMQSfVzw5rw+iUkZN3sHSJMaQaWe6tjb?=
 =?us-ascii?Q?9q2hThal9KzVLc3SjKomROcxRmaYdDiYTzeB422UTOm1FgxiSGi2hHee1/Ar?=
 =?us-ascii?Q?jKrGXeYq9k2iNPOhnVTj5cyUKJJBLsQq2sim1Ss+gkZYDWTTnJDAOg96IqIR?=
 =?us-ascii?Q?CwupXA5y39my62AIHK/iyPKNpyJS7jBP3MtT8QVhL1bCT6NGNG6CX4+JxvOo?=
 =?us-ascii?Q?CwlWgnzyN0hIQYL9GuDFKM5iGGSUXvYUl2KnX2vw73hMSH+G3zuhMmBWIm4D?=
 =?us-ascii?Q?ZdFTpZ0N0CfaklMP0sBoRv1FgGQye12R7FTK0xecRFqX3w22vTp6iUrwhw0m?=
 =?us-ascii?Q?TSkROa/mdiE5Hexg6XvPfXjUhoq1f3PaGufips8iY+DOyiaT5DKwyNaYM5CW?=
 =?us-ascii?Q?g5Y4fj3JNhIgq5q0WkcJ5YMfDFEjqsdYeYxNl3BGj3anrU4HPVUdYh2Gtzeh?=
 =?us-ascii?Q?JlUIZMCTKH3xYafan9rE7LWgXHK77WQDoSf5ejZeXqBCyYodAw3/16MvsFV9?=
 =?us-ascii?Q?iAFLKxHhbezKDGgcwKk+VtNJY18YIuvpezeX1d8mhkGXYxsdD+2AGUFNWJ1B?=
 =?us-ascii?Q?NwZS7tGwjj7vqMAQ5pCRJ9x9cy7kC4dz7wqPt38EKSphGdVMY+Qw+/oIT4MY?=
 =?us-ascii?Q?O0MvV1vVFJricORFWtbEAuaBYAFMLG10+LpGuAwR+AVZCm/yNeQ7adcyTLDk?=
 =?us-ascii?Q?ougq2zWhCAOyYH9jRPxSqAz8+NHuJLv8G0H78X1hUDXCi1Cy7aLkcNBvVCyp?=
 =?us-ascii?Q?6l5DETqYtOH4s5ExE9vx328wuj+2lvmMYjehCAhejoCoCL31/y2Gmk96F408?=
 =?us-ascii?Q?Lykpz0fGGRSdFcO0DVyhLlJDS9M4rQX7HO5Q8K4eUmEZCw7k08NXu+RchkXT?=
 =?us-ascii?Q?rvekezL73E2zwmBCXXgjG0XxEDT2zICVQ+1Z9QQERbcUIKuKC/cP3q+qbOif?=
 =?us-ascii?Q?2/XzrASV0QZ+Uo1+BaxkiMp0Fo71EM2bG3BoSs542UWpjyMao18DA+wLZ5Mv?=
 =?us-ascii?Q?NHqMgNAnkOExMDQggcEAuOCh6manN5u9IGRkg/bJediW4r9XxdlSiCsypp1n?=
 =?us-ascii?Q?50/HIAKsYfOZBqJ5oI/sRdoCJrbC5qMxcuKEpOFgY9MGlE3AfPJfDoyJ217g?=
 =?us-ascii?Q?EoTUvnJjxmOgYm0vcbHheKpFDEEZZJorEGViNFdVKx+zbV5eno+mvuRdqkuw?=
 =?us-ascii?Q?BcsYjDqhOwQdOQwbZxY322IfLGVF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:01:07.6955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 171f3b6d-8504-4b57-42fc-08dce303cf16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166

From: Michael Chan <michael.chan@broadcom.com>

Newer firmware can use the NQ ring ID associated with each RX/RX AGG
ring to enable PCIe Steering Tags.  When allocating RX/RX AGG rings,
pass along NR ring ID for the firmware to use.  This information helps
optimize DMA writes by directing them to the cache closer to the CPU
consuming the data, potentially improving the processing speed.  This
change is backward-compatible with older firmware, which will simply
disregard the information.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 23ad2b6e70c7..a35207931d7d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6811,10 +6811,12 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 
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
@@ -6826,11 +6828,13 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
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
2.46.0


