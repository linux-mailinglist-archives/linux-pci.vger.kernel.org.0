Return-Path: <linux-pci+bounces-16932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8550E9CF57E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 21:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC70B30B98
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826FE1E231D;
	Fri, 15 Nov 2024 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BCmurFD6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BB81E2304;
	Fri, 15 Nov 2024 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701090; cv=fail; b=awpfS4ryhKqyOdY6c/rrd2n7X8YVFXLzv47NPYx5+M3z7XCe/1hU9Cg8Kw14yS2cyJiwpux7l3SCruVx6C2AziOptZfcLoAboqVVRXRs7TCyPxRm2Am04SsKXHi9eqr02AIM7qjDvdSfHM+xpIFkpl3OHIYoCMexk0ps3htQXBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701090; c=relaxed/simple;
	bh=koAKLY75C3UYEQ07t3xwKGfJ3cUl/0+sRzqFhjesgQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGOOHwsVwLElNgr48DSjeavV9xePi/mmdOrbjp3G5uhw3fmibw8m9mv116ForkSciwQmmDLcrS66+3mnvGFAb7GqfhYysjoWRaPaMpJ/MvlidDj1mY/Il3dtbwNSTkJg6E9viLff79YxeeYDSUo6cbGolWEtCLxN4zq6dVbNEQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BCmurFD6; arc=fail smtp.client-ip=40.107.100.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYzZIm6Ll3p5H4aU/g6r/ZEMmi2l85o/D82o/Yjv7wQF/LCkrdV0ZY9Ao41FeuIK3O231GN3qpLydoQfv5h3Jw1aOraSv3k4Guf3l6/WClWMPqMWzsuYJn/N5SygVIqvOjKgeXn0knJf7LY+KLCKRImE1OW/rLb9SsoE/x/G+vHOBVXwxFsVxAaU6hokufGeHmPS5BT+XrmHSEaj+HrUZGber998e2OY0qjWhIKbIzl48x9OOosniy8dRtt1sIMd+BGFzZOg7i71VeEjJM9y+ZlluBKE41Lq6eQB6jHNa0E8OROnjbORuwk9W35qKXTPzq84tFijl2dF1mrSy9WTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVljVUscDN941rfy+ZZhGKywvZc2S0YIh77yIUPjfLg=;
 b=ZDwRjTzOoHqyLNxL741rRRwRUzkZlZ+g1AZJOby/7MTIOMyMLmlO9UPgW7Wu6RSUYD+GPGc0wV6dEcPuwVjL0hd73qmQKvpj2iyw/DTxLnBXjy+IDx2sBoVlfk+GT4FED4+Q83AJe3/ndGaxqFtEhOxOh0AiWo5PYlBIw0Bn1rIW7pURP6G3t9xPJaIQPeap9CFKGGFcPVlhKPedt95FZ2YjOwyzMdjDBJ/O16GVQN2Pr3TmsiHLU+8m25ILKB+dvgONoXQ2tbMdjn61nY31af8gwtMIUe0/siqnotN6+no0fj8SOZCJpwbBBHM8iiQmyIi3W9xiA+VkJPzrbDEc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVljVUscDN941rfy+ZZhGKywvZc2S0YIh77yIUPjfLg=;
 b=BCmurFD6oQkj6ftDY0YpReb4HO53hFJuhtWXUPyYPT2Qs5SSu/Gq1uPdFBXs76sL8nDa6d3699i6X7WnlGBg9ET2HZFig0EpOi61MJBQRyRQfqCRulGpvcw7l34mfh533+KX6BCnfh9KwMLGGz2+gNzL+ZiZiRTS/uvPrDhA1bM=
Received: from DS7PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:3bb::31)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 20:04:42 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::8f) by DS7PR03CA0086.outlook.office365.com
 (2603:10b6:5:3bb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 20:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 20:04:41 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 14:04:40 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <helgaas@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <asml.silence@gmail.com>,
	<almasrymina@google.com>, <gospo@broadcom.com>, <michael.chan@broadcom.com>,
	<ajit.khaparde@broadcom.com>, <somnath.kotur@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <manoj.panicker2@amd.com>,
	<Eric.VanTassell@amd.com>, <wei.huang2@amd.com>, <bhelgaas@google.com>
Subject: [PATCH V1 2/2] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Fri, 15 Nov 2024 14:04:12 -0600
Message-ID: <20241115200412.1340286-3-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241115200412.1340286-1-wei.huang2@amd.com>
References: <20241115200412.1340286-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 016e551f-d607-47af-a049-08dd05b0be24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U+REQ7gf8dSQy2slAdG6gNRHW5sFrudQM/A9XcB06G9cwAH+WEk3noTPeltm?=
 =?us-ascii?Q?ruflG1gjISUNF26fhXsh8/fm5o3VxVJif9wKjfNMFndDFgkLCLqpZlQAAu1L?=
 =?us-ascii?Q?nY4DZP4DVLg63lgKE+NV0oYQE/ynF0zXVjA6vJEoBkKK9TKpjRxBJaZguOG6?=
 =?us-ascii?Q?/K+2MM/T71RCNkq571qT0M9MlzXacjVpiGOyVD3GKEE5U6UB9VmQ6Ximpe6/?=
 =?us-ascii?Q?ucS7yl6XflnEWjN+K4l6+8p/IU5f5fqrGfDLgkRTu4th3X8XT4FA6DtWLDH+?=
 =?us-ascii?Q?zapDkAp2TvfccgAPvcExjNXCnF32fFAF8mIOiWNph+E/77MuHR/sXPjGLfpn?=
 =?us-ascii?Q?O/SvtTbKxmDQnvRqmMZJ2QUMs9POzCfc3QJEZTZu2F3B6XBPrsaMPuvPNZOd?=
 =?us-ascii?Q?KlR3OhL86FesR4mATJZxC38t6xPZ49cmazz3R8ml8oaDoXYnlkuhoCjlTc1u?=
 =?us-ascii?Q?+4wG+hFO85KVKOa7OxAH80UtomEkbb1EI5XRWKnbWXcwYqP1+I7R1RzqSwCu?=
 =?us-ascii?Q?0drR05hrwgocO2h3Onbeg3HgM+kdpzNB218FVZZPoBy4DdUTie4YtmToG6gu?=
 =?us-ascii?Q?PNhY/V69eEkN4PD+p/55dQc2PAzZ0ita42tb6DqdLa5g4lJWYSReRChyq87k?=
 =?us-ascii?Q?gWUynHEh4wNVzZrEvH3Ya6dNjUI2cZ3NI3IOi0p75niYLqhIdIPshFTLRi3d?=
 =?us-ascii?Q?fDMrQ54lNOvL2UkS++zOTMeQtW+gWGGxmXF9Xbd+nFKMTET9XQTMSY1EKLUZ?=
 =?us-ascii?Q?jdIHwyqNFEIXkQyXUsE2Q0MU1dsARvlioQ1B6dilRnjXrBhdNOiDuSfDrgNV?=
 =?us-ascii?Q?ZI9cAkn/ViyzbMX+PAe9zKDmEkfMEW9+MBh8kJ2VGyZsgPyZrrSI4b1kX2Zw?=
 =?us-ascii?Q?nY4w7UR+ZaGys0tDpBK8voUQFnnG8HgEH/j9oSEvMi5KgpfhEoseCTnM5+T3?=
 =?us-ascii?Q?K0OrZpx58Ab1hsn8Dcpgjy55m3NRuGRhDcnKwRc4wyvamQxBCtbjlIbgyn9M?=
 =?us-ascii?Q?T/XpjtY/lFpUlZDr1NkaqS/yQYltskcomgMRRJXBOPmjEvshyRZUGumftXHP?=
 =?us-ascii?Q?H10gfEm9deUW4w4EpWVT4fldRJJKApf7LvWBuyaq4Kej1nGu7I8tfCobIqQy?=
 =?us-ascii?Q?xD/zuWXhEpkxMQvp5wCj7lxF7yzYGX6fbLCB/xjSGEflb6u1hRmQ1KwNnW4C?=
 =?us-ascii?Q?Y/NDNxORDM/Az3NwrfDac36BKqt/b4D+1MuZs7xUWtywReI33FcZzUXia3Ww?=
 =?us-ascii?Q?eHwNxvay8yF7gW6/9olJbcx8wYOHYlQsjKkCH+bCzAqpJU4guax0Qe/Xdq9q?=
 =?us-ascii?Q?Jeu24SQD7K35AP6YFqMU76ZEe0f/DoghpVqPVaPtaXMDmQtbhqff31zjTV2b?=
 =?us-ascii?Q?RJLW8N9ZESvcCdAFiZ5e0dyeCYUk9eYWWH0qT4901YqXfMCJIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 20:04:41.7839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016e551f-d607-47af-a049-08dd05b0be24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095

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
index beabc4b4a913..b609bb0b87be 100644
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


