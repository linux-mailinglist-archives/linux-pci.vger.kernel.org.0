Return-Path: <linux-pci+bounces-7305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11E68C12FA
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449461F225EA
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26E14B097;
	Thu,  9 May 2024 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EzRpleTh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E16171E61;
	Thu,  9 May 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272186; cv=fail; b=dqtfsbyDSFxVn+al1U/eZUn44oSmEggovKGd26Ldlj6BOEzU5nj2KV253Ks19C9+x5dH5IaUhO4Tb42dFCHDKiGYxdWlGAnL6ZtDsrU6RBNaft/+x2zojqTFSl07Ahz9YiNFVMLRo8SrDhhq5xDWSJhHk43ADm86F5VPUwlMeMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272186; c=relaxed/simple;
	bh=Sebm3OjuOFFFFNRYH2dUCIiHV1tBLrl2wClphyDNZ4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjs7XH0bcHn5gXTNiuiq8Sa9nOz8KJzMXquV8Gm0wVccsweY61JJwMZ+aUygYiSSLyYHTT/+Us06LNyIfqSlbRXhLmdO5qhAsPBWDbdPaXp3zUr1nV6WZWz8A4IKcjR5ubgqgNZQU/LJMNjpQv+GHmc2pxEw4VnGQgcRZt8jEDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EzRpleTh; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsGmNYjBQSCmkEnDQSU5uAddbK/mA3EdgBf4FDVlfQMORNfrtNl6lub9rCtRdyAlly7jiMZ6TPM/TH6vATAEZgFPOpjxupWYUUYZVPuuT3TuGxkQ0EkzzqkaCqfVTVG7SeoMEUguVGclf4xHfJ84evXccn3v1UJP6+zavdmwSvT8POT72AtkLmi+D2eUPu+TEEEHz7WJjCTVBAo8NPYH66kLId8eH+mpy5Io/CbcGgrPgi9DDyE6eUj0eFavcIYIv4wEVuDBE7DMyIMAxhXZ3k6PTI+96MleHR04dADlSn8DRFMrwWDivUxxCH6SHy9Hvi5wqb0zdhGJoG90JwlwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyKIwVCJ/5zXgFKQoytLGB9KlcgUgLwEnCTGpjfht24=;
 b=O/kIM+Ms1S5xuTy/maJBMfxo1MSxdASvj4b9lr+lHbFNg0mmdHoKoD1hUoxZL1xg+fviK9JP9tZ6FXRKhP5btTQsQv9KChQSPGYC40t3x/L+VeVS/ET2xEDOtN9XjP8LmXIWkeoEKhjQOUjrDCZZFOiG7/KxkTJWyVwUzTT+brqSGhMCWxDGyHNMSU4htfLL57P83xwSDGXERFAurTIsQYbU5Km2U7shbNtT2H2P+o1aPmrRxgRXPqZYFlAql3xLVtLCiJZXK0GxGc201Scj4ir8MKzD59Y+xRc2M1DKDiEBE5g/BimepzAbxlfZMJcYtwI6wF8kHS1pYOyH3rzkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyKIwVCJ/5zXgFKQoytLGB9KlcgUgLwEnCTGpjfht24=;
 b=EzRpleThLWnoB8UHbalDXQADIBMzmKfzdqO7Xwv0lmHVKfW79E0xEm6V9N9ebqCbje1IZ2EiKdES3ksUWbm8K/2yYVjGlZ9Um0eTzau9YprffHzMzlXUikdBONpQgOcfbk3jqLU6o2V7DZKE2j4u4beZ7z3/xAs5CVcxmVIeFcQ=
Received: from CH0PR13CA0041.namprd13.prod.outlook.com (2603:10b6:610:b2::16)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 16:29:42 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:b2:cafe::96) by CH0PR13CA0041.outlook.office365.com
 (2603:10b6:610:b2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Thu, 9 May 2024 16:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Thu, 9 May 2024 16:29:41 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 11:29:40 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>
Subject: [PATCH V1 9/9] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Thu, 9 May 2024 11:27:41 -0500
Message-ID: <20240509162741.1937586-10-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509162741.1937586-1-wei.huang2@amd.com>
References: <20240509162741.1937586-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf0f52e-fc1f-4faa-34d6-08dc70453aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oHnird0Xc/ohTDi6IDlDL4NRey+Iwm+gnVXIEvuvvzxgPBcptL96+30fgadJ?=
 =?us-ascii?Q?JMhV0/QljUOC3mDRi7KYOxNxZPZPDDFH2/eyvPYcMa3JYY4ukBSiCIgvLCHm?=
 =?us-ascii?Q?YPBZKSty56V2Ddj2RU0FkIACqPbDzlhNvaV3gCyAFj6xxipmjJ3Z94da8frg?=
 =?us-ascii?Q?ExVB3S10ZvrJgaSZTblzuhAA7qIMCVKW6ODQDMaRYjspZ+eUE4qQbc2piRcH?=
 =?us-ascii?Q?wv6FdloeUbgxDjrPHXmcFwGpF6uqvK9+QNoDMhLXsRYOTdW0fJHKEJsQls8F?=
 =?us-ascii?Q?OL3j8xm8zyq3y6wF1rjGsrnCplzeebDadsUhJnUF+atRt0c8Z3XF33KN5S7y?=
 =?us-ascii?Q?QYYtdTxvtSuAatqIeqoxzxR0vuI0AUGkTowKaG5v/MYhpFVpdMLDh+NqmUPl?=
 =?us-ascii?Q?D3OLLi/b+62WwIwIJ97GPfQZXurhtGKkc0NjWdZ1yME29quIGdv9MW4FxosV?=
 =?us-ascii?Q?4GlBGkemnhtzLDlXX/nDKPRaqzrV8li/TkOBHl1X4Jv/jCd3zZ4MNwKYOiDB?=
 =?us-ascii?Q?dHmRZDik/9ZW/mFAsOTZWoNO/MO8pu6vsu44TO25+iU/tzYwZi1sAtYx1gH8?=
 =?us-ascii?Q?GF1FqNmcSoUie89gyqH5AeJU49gJbSLLGStFDAJnusVvg9NmGLxV+icZTCOG?=
 =?us-ascii?Q?RhSSSieOMBal6lljFrUjvNxt8jzgBeSVoCrdFC+t7pI7LrXjF7zVJffEg2yz?=
 =?us-ascii?Q?psuVegiNJuaWMBs1dokrem9dhTqNMjmt0ArCwyk3ahLr5tSdWFwQmjQCeCWT?=
 =?us-ascii?Q?Z/fL4doYRmY3uen5WVzfl2urKgAEkjQJA5adXVymlcDlNHafAuPiMmKFVfKv?=
 =?us-ascii?Q?9Jy3+80abyume9jmsczwkPVF0CjSEi/u4Uj8aBxmWdmi0NkNB9DpDoQ/Lv3W?=
 =?us-ascii?Q?+56SRZdQVJzs+/CHi9uesCP8Hvt6ntjkwDCsFnnW8I0gSwK3Rgy3eu1NRtG3?=
 =?us-ascii?Q?kgDUBaLqoh0G/mZi3aj6oNhrHI/tGHAAdvQDdfyFC9Ciz6EHbEXzECuEAZGk?=
 =?us-ascii?Q?wrU9p/Kq0iEAE8a5h8CpsC4eV5fh0IANqycCl1/o+9/fu0kFxA2VzdDfjkMU?=
 =?us-ascii?Q?QzVbY6CISefrg4AJH6XWQeIcBhx4eEBR8vuwyMsp/9UHDFhoSS3FbX/7pQB6?=
 =?us-ascii?Q?Xlmy9BOdGxzuwYaIYClXOdYjhwkDbOkgD8xHh4neZqaD3avd44CwC+tuj5Dp?=
 =?us-ascii?Q?pGlMpFFzZi9ZMLARQSMOYSvtJC9QgGw8U/CLfH80c3r7qf1hVexge/J+FKx4?=
 =?us-ascii?Q?nRRwzkt0nVVG0yFzyKcjND86Sr/JtdTxxk5HJZ1ukH1o5gEPQhP+kHaT9C9d?=
 =?us-ascii?Q?pqQks73tFfGdvTX0I433UC9hdwEaFyL/HOZrcLiVxdE1BagqNnztTTHW/9GU?=
 =?us-ascii?Q?LrnZH8S03vxATqJD7Bbv0Rd1HovR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:29:41.8758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf0f52e-fc1f-4faa-34d6-08dc70453aaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941

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
index be9c17566fb4..2b5bedb47a27 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6620,10 +6620,12 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 
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
@@ -6635,11 +6637,13 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
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
2.44.0


