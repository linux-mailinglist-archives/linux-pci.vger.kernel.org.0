Return-Path: <linux-pci+bounces-13610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46771988C22
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 23:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12E2283F25
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 21:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CA01B07A0;
	Fri, 27 Sep 2024 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2u+0fM5r"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366321AFB2A;
	Fri, 27 Sep 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474290; cv=fail; b=QqzKNWc/fy/oH3VH49QtQsF/eXMW0ytFZBUk8gUkrJsxZImXKKyW4C0KI9Sqbff9vouFQSGiAFnHdT5IU56JJw957t+cznIp8XoIVt2+HuP4K2vVXT+Bapi2XrswQPIcuDsucmacNkqHhZl99e/U+jhFfXGouVKwCG6rdnXl2Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474290; c=relaxed/simple;
	bh=mKkOS8ON8XXsl0aoRfu7ijfFVm/v2jDUewUB0Qaj/fs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtVn9VIsEVnll7a2iziPa6QZNznrc+utEDTigmFQSEPrk9WvlobF0ypiIlhRc4UUmlkNPoNAeUWXBsPI2oTaMCSLxeRUgU31tQlvpRLoGloRyKlptSDnSI58ihR4r6kmY/BakrxK1bcNTIC1mkrY4pVmWM3X4NxGc40qcKr5v/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2u+0fM5r; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oT40gjFjd/JrC5Muy1U4HUfwMmi17wM4qkd7PkGaypuppMMtABq/wsVLvjvbg+8w+fiuQXjkaJsADRAF8BjsgE/2K5bYB/64tphnMfx6kUR1xUgRLpkf3C67pCFQVwFR85zIAGN0oCsItrNhh2UAdluEjOHn6q9M3Mu6EkKpK1YMJbitlXaL/YrPXf/Wu7Pigqa1i1dmM1v/hqYthfgISJBcc1MQ4DTWM/n9cAJPMLCXpr/q/upPxeDmi70jbLdaaDtQuDOh0qq4yBTsT+s1fec2AaqIrGRCZRtMKKq2a2ebDUGTSXAU4B2BDlat23PXgYC4lB0V3eJbVM7FKN9kOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ab5DbcMXrOiy3f5rlhru8sFW1zCR/SsN7yoO+mXTswA=;
 b=YOpSZFT7vUGRo0e/a5nMvI0hp4fhAHP+8OzT4jXIAtoTnmsPdMr/3ApnLIWOov17IQaJ1uA0zMXdrsP36mkcpXzeZhEI6MMAPmqzYaTg2bVz54qaM4c9Q4adfrTBRLiDqx+vrb9Z6R6aGgVg/wWTu/iHs5TzKVWJu1+khck5pL8aK6o+g1jcmGfjwe2wQjrx+T9j9KVpX/3M8OL88YWbnA9fkdNaEfr6OjRFxM7DU9rFdZmbASHskEjUgmQKTnibPzmJPLuhfoZIgDDk2EiRIkppy9vbOaLhesZ7MNOjgk7dMlrx9uMNRV6DebDsQibyrddPxaKHBF5gQkK3gg+jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab5DbcMXrOiy3f5rlhru8sFW1zCR/SsN7yoO+mXTswA=;
 b=2u+0fM5rv2/EZ5wtdtxX/L/0R2BzJsU/eeBoXpjwavzmWCmqbGSQiCLvbeCKgT6ob8DBRgWHiP8zDUUebdQr1WLEDSqm20WR0Wq9SZFfrtiHGg8jKsZW46mIAU+ADIJmqaT0YfP8B7h66TEpa0TjMtbHloDXVVkqmyIo6y8taDE=
Received: from BY5PR17CA0055.namprd17.prod.outlook.com (2603:10b6:a03:167::32)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 21:58:04 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::9) by BY5PR17CA0055.outlook.office365.com
 (2603:10b6:a03:167::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27 via Frontend
 Transport; Fri, 27 Sep 2024 21:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 21:58:04 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 16:58:03 -0500
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
Subject: [PATCH V6 5/5] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Fri, 27 Sep 2024 16:56:53 -0500
Message-ID: <20240927215653.1552411-6-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240927215653.1552411-1-wei.huang2@amd.com>
References: <20240927215653.1552411-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: d0cb8846-92c5-4834-153b-08dcdf3f76a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+y93yY6Iv+KAXNTKj7+ZhXjy/5Jll/pIrY1AdFF+3/LvxZrwlHfew5CcJsXf?=
 =?us-ascii?Q?4e+GGzlIC1LXD3gmeF+BJ9N/KUUAc1vOsDJurwX+PIkVMLoD+bZLv8LmP6aK?=
 =?us-ascii?Q?LtYxdA1TxlNtad8LBbQLWHYZnonJO8lKcw2u7z7N8E4nPaCcFVTo6AdGtR9N?=
 =?us-ascii?Q?cDyllwFWELx1WPm6IsEeX3JtghHyp0FyZ/Ec8KfJS0Tq+ylUWQIhEmwmurgw?=
 =?us-ascii?Q?uwwnc5OIneagixQTjsk6zhvhKBocfw2YOPM9blVinudGUcdT+80hJCnkt8Pc?=
 =?us-ascii?Q?5CAJLsgnGFHVhv+C3aP540QX6Gaph7AAlofIHH9BD0o0YiH8Z8lYA56vNuRG?=
 =?us-ascii?Q?u7+C8pS4BA4tRDD8DLfaTc+XywVX9c978uYy/bQWrY0poj12vT3gd4SRxJE2?=
 =?us-ascii?Q?lZmGf4iU8z6iI0NiM+y26Mxi4EgpMKwNVOSXO5pQl4gifOMcqsbYgJlSkB5R?=
 =?us-ascii?Q?fh+1WZPwBwcUXciruB14N4Rjmt+NRgLiYSXIQiJuBMbVMbRj9s4YaU/Ji0kN?=
 =?us-ascii?Q?Xjm9eTrkQqVr5fJ1GRxovJD+5ibU5TaHwFFX9hO1uyW+qceb++2UDOiks3F3?=
 =?us-ascii?Q?e4dYPEo4HgTolicdW5EDuSCs9qcqC5y30ggT7DnUY+TPZqmboKNK0Ay8fX9N?=
 =?us-ascii?Q?dNMzP/BtK2fLbfUrdjOkoNyEv+9zDHfLWposAwnXer7rdpmoCNEEtQH77By4?=
 =?us-ascii?Q?3lAM8OVfUzFtWmDBQWWzCfQPKd9iKKtBOI08uf5yLyvASs6J69nFjvk14kRy?=
 =?us-ascii?Q?CJbuZ3t2VdqgJ5tHSfGEfZrzjWGiqeec6VaTuVKUkHEDFnbeEXUAmZT0edaO?=
 =?us-ascii?Q?OpRjZPp00v7RDp5wHL425WcPzF7z7gozyRdzLi2dGv8WRk1pNaD98eIUcpek?=
 =?us-ascii?Q?dnNh6dEPrwPVGtrzSvNgc9fJegeP8E+28HgSLxZ1MBCO/r6yNOdHlOcnbABs?=
 =?us-ascii?Q?LM0HgUOqHJOZL9CTnqb07cU01WOFI/05viE1W5RhzmldjFcGigNZngAtTMmC?=
 =?us-ascii?Q?vaCgH1TXRF86i3yqxvO+eaGefH7S3YJEZ2jQRO7DzvILOv+gf1XVXNAv/7LR?=
 =?us-ascii?Q?gPN74hb4cjb6WZdE+lW4ReFsCOuaCkdiEAH6U5ab9axp+pQpJhNbZFJ3X9NA?=
 =?us-ascii?Q?EGGDkGSKX9hCdsFHogXjAQw1DaolMJ0Z93jPT9bMwFYkVbWhq09u4P5DvpcT?=
 =?us-ascii?Q?4smqvSRDvZ0jTX8mkl+aoDIofI2jWmKhPTdcNSukgiOmjJ/wLJRRocUslB+Z?=
 =?us-ascii?Q?0mQSlpVZDeZHEcOsl4ijai4hVTjdjqTx838mYtTRptZWZQYz+D0Qfo+vQSCo?=
 =?us-ascii?Q?PnneTBU8IVKbdBp+Hch/Hhi/V1yKSECgIV4xRiDd2QOIhhohm86DNbiudawg?=
 =?us-ascii?Q?XsMzq/G94lzw2bhIfD1EQu4MpHgp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 21:58:04.4865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cb8846-92c5-4834-153b-08dcdf3f76a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378

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


