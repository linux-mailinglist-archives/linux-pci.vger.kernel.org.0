Return-Path: <linux-pci+bounces-13249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC797A886
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 22:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9651C22105
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 20:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DFF161320;
	Mon, 16 Sep 2024 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VFYVwgoi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940EC15DBDD;
	Mon, 16 Sep 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726519947; cv=fail; b=ThS7IY+ZA3RGtXHt7/nqTQKKMgpaOlDC+HVHKUrsdA0FwhrN41/QOFGiTY9Z7nZXcOy90QHv+YZVQa+CMTbSnKFW29GXJ7qi1ZTwSBc3gdOPFhKauUmKNo1C9C8qsnuFrlQVvKM2SUTHTj+u00Mrw4o2HT8kH0eeGjuicuvQ3nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726519947; c=relaxed/simple;
	bh=+SHu1cz4TmSIS5szBMQrR2ftPjmoRxXWc04Tu5ERSM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCVpKDC11oy8q92TDQNEmQu+geHaaf5XQ2hs447ZqRneZigXIeg6y6PtsM81C3T+/H4zXzoKy+5dXCGKwAy0T/e3ssOBiAdTs/xrD+DAQiKxJQpaJ0sqoCmDfwH5zRPB/El2BhX1+yRJYwT725XW6KASEswl2uELirZlab1ohek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VFYVwgoi; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLI17whfhCg2+a2URYFw0/9mTxOr5GlcEcbLLM69Pn7JC6l+cBdddX4MBJMma/ql17y7bSIIrFzW1NkHvvCa4mN4JpY1cP1RJ5RAdCip0CVk8/OxL3WYihLsLRp6XlQbDoNOnB1HUI0axAZss3hhPWdrMf2Xvlp5QnZDRaTxrUt0tHDNG0RPiqZwMYow5D4mJu+B9/DOpA5BYZ8qAQjSR3gmb5qJIxL+TBlfbT5XnsJbBUDoipLOJgel13RzPlErBjQwxX6EeE0A6REzaowGQuRBG6Nawbj+PAN9yOuPdmUeQEEC/IAEIVduRYZqxlnO10xgGn7LS41CscV1FVo10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyNJGi/6ZYPbBp24yZ6fsr4GtEu6YRSWKr+SNRgzekI=;
 b=GRB+mYnPvAei9IDzyPDF0YsQb6PP42efYpZ/OCcPBieNNHZkVN6FaRfGnxTCHQnWtQc5xIRzDtJxScy7u6m4tSBTiQAPycnoqH3Z5TIJtxlwdwhl2DEkKXOK4+hvSqjOpOtslK08VvuSUYz2RJ3jZ/7vW3fm7uZVA2qsZIIyCRTRBF6PgI+tN8trXBeqNTXdW3BMK8PuoMV6+ii+/bqW1gzJ1bPvfsCRYr27gv6EqbS7+0LeTPcdK3LHZxO+yZm8XX0ydD2XEwZevB+4IzNTu+dI74FB707/1bF2JN7JMVQXakQ+NGGceXvzCBVwP4uInYFfekMYoZIU5fn0qrJpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyNJGi/6ZYPbBp24yZ6fsr4GtEu6YRSWKr+SNRgzekI=;
 b=VFYVwgoixWh+WkmdaEJ3HtPt5NIlvNtLKSBavR2UpqvnO7krJ0wKs+RCbAGFzqTxI87dzfoHkPWWLGLrVxTfpc0WC1Y5ZnP6Q+ch1RMx1J+JGTP3Vu+vOw/8sb6gle+LNhaXCRXmLKKuPPbrECL9x5sHK6qnvZ+f3PiXhDJIXNI=
Received: from BL0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:207:3d::23)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 20:52:20 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::c3) by BL0PR02CA0046.outlook.office365.com
 (2603:10b6:207:3d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 16 Sep 2024 20:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 20:52:20 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 15:52:18 -0500
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
Subject: [PATCH V5 5/5] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Mon, 16 Sep 2024 15:51:03 -0500
Message-ID: <20240916205103.3882081-6-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240916205103.3882081-1-wei.huang2@amd.com>
References: <20240916205103.3882081-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bc06b9-004d-47a9-84c5-08dcd6917524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1fnyGcQ+DdEE19cBLCzmf5XRItLxtSeQSNEi1aQrIKXxHZvs0LiUB6tMkHL9?=
 =?us-ascii?Q?lxewKzwbuqpanWfRY60aIVTxLTqQdzn9g62cOs8sNJ3kOtIQZxC73Xsgv3Fx?=
 =?us-ascii?Q?Vn3inzAJdMW+Ilt4CVTKu8lL6+KGlBje5ZMrHcLZVbcsDjD2KC+QJNeyvn9x?=
 =?us-ascii?Q?CHTEIkVaddS+lH9QWTTvAnLEHqOw/jPX1Ujrm0cnd5fVDXMr4Hj1EWfUVz1c?=
 =?us-ascii?Q?9jMVgOAmTjDZVQyh3azz5HvvIF9okDJgTDmiGYJpnc611lfNcOiBH+VMiX17?=
 =?us-ascii?Q?ueuV3AERBywr7m4PIpupPAV5LZ9y9zl4gD/AGPquSg9DE4o8Foka5cQkt3Hm?=
 =?us-ascii?Q?nJeugzN/SKpdxEgzGa4X2Cgm+5/o+1+7MCmE+jhlC929RMfadVfz4vVrIHiD?=
 =?us-ascii?Q?1S/f2BrzrFNt8XXPeqtEWY8MT5fxkFCvYOVEh8zv2ByqHbnreJdB3j7LJLmZ?=
 =?us-ascii?Q?Sx1VOZuagBYFVgWud1Fa+kwoukSBUgaJkJmkt5c9GHMS/qsHboY592bVj3OZ?=
 =?us-ascii?Q?a4igCxQAGhXTQEmA+eebT0sKkGd1ZEWHLxrnUeq++zz37oVUqhntsI3Z+JkC?=
 =?us-ascii?Q?RZ3ytEWoToeeXvuqGZSyEHmFx47drc9klhTYOeeh8Jv7Fy9vo1u3rBYdBYqK?=
 =?us-ascii?Q?qxTAW4wTMy9NzOt6Wuc1S9ggaQkRoeYLK6JGDodx+il3xClPMYNHzve+N5IV?=
 =?us-ascii?Q?JtbivFMAG0NzLwXRpgAz8iKjTUhomwOhJtRpJQ+G9e01/VnDgAflk25EysvN?=
 =?us-ascii?Q?MJmnHEGTYPpEZHm5MRcJjkq2mPBqh+SQgr1Eh55mI0uzNLq+a07YDoQMH+mz?=
 =?us-ascii?Q?mme8doHwpiab4YN3YWJx2SfJApm7GXWh+fqM03AK5jQZOeXZ2M47Y2DPyaEv?=
 =?us-ascii?Q?+innqZkmGUIaJUkUkL9Re8uh0jMcw+vvYYR2bJXVDhZCiySj2kNdCnHl3OJ+?=
 =?us-ascii?Q?+s9g6hvvdvRay9fWv9Z5zvbURiGr4evg5+cMPTNZ83sJ3TWH2uEvWdFLEYkC?=
 =?us-ascii?Q?5qsqnb/zQNwVHlYW7lD6LYWIWMIxnjbqs0DlxP/px/crU01trwKZgLRBBDPm?=
 =?us-ascii?Q?ukGwZEINd9M8kcPGdtN5T4tr7w8X8XK5kvvMZbvX7kD1JYbAGUFE6O3eJJh+?=
 =?us-ascii?Q?1lpC6g6CSoqrI16vordIublPaRR4dsy/9A8xvGiuhhUfjkBXxZjtiCY3QxpD?=
 =?us-ascii?Q?2X+ZXyvYiQNECJA5oURWn4AoJE3xU28p30NpZg68qJKQVp7JcWbpi8sXtfR1?=
 =?us-ascii?Q?3RXyhU0GNN+RKPXCvIXxOegfCMY5vra5mTKl1zgZa1N65xHLyaMCGO+nI9xs?=
 =?us-ascii?Q?lvQ2wU8yqFKQykrHVMdNippDuhcMskXhSN+wDQz5Qw1Yof8uWbfsDMINYi19?=
 =?us-ascii?Q?vxngDdy8G60NNNw0shAEFBnsQfClC/JgVq7Wi4bYAtJA/w26mP7+JZwqR4fY?=
 =?us-ascii?Q?VqICHkv/fwZLJeP7TqzIwYCUrGCdFakq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 20:52:20.1197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bc06b9-004d-47a9-84c5-08dcd6917524
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473

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
index ea0bd25d1efb..48ca3095ef2e 100644
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
2.45.1


