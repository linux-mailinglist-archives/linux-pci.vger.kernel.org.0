Return-Path: <linux-pci+bounces-8151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FF18D6BDB
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 23:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C2A289028
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 21:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DFF81AA5;
	Fri, 31 May 2024 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jdgrGhZC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994DC78C9C;
	Fri, 31 May 2024 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191679; cv=fail; b=c7aZ2BEnZkZHyMgwgywTmwbnhYe6IIYN9kqnpRNudVStxkHLgoB0zt4huLyIsHCzynlDPfE50DapbQavcirWiu680H0OavM4+iKm9SaR5sGTizWGMfejHjLiChmeXt7dlFqKIiLH6yE1r76Ymxwkok69yBrkrespuA9RCLp4mpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191679; c=relaxed/simple;
	bh=btENwbSnpFzoHh1T01k2JDYx10vsDoRjrXVQQ9ca9+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITt5xkwluWbyxWV8bzIYZCkbtu0PmhBc95RQF6eEhhWUF7F52IwFJpI8fADJYN/1VZIKnV6/OLVN2DfTvbvvuv4ZLplZF/zM+n557Zx4gGujaEUmPUmCUxzoQzWMdi1ChaJb6g/8thCyFs86y1wWbiNBsd61WRU1F2jqbFlzMRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jdgrGhZC; arc=fail smtp.client-ip=40.107.212.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDz5xJQYuzQ/AwMZ2+Q7R/hiKazsdXV63vZuFPEmIHU6UlYIZ10q9AqSEHxG8EV0/iY/dY7KKpPr/F/WIpQHhgiIsVmjbm+bod2E/PL3S6ptKVl+Ll4WCBdIduLvEzzKFNtizOSX5bUEdegsoIMUQAqgW5hz9U2X9OMtv3JAfHe+20lGTkcJNaaIZkaKXWDJu+F8GRMubULn0hAABDd7zCR9WXxGrI28+z2GuYaaOgurEZ/8wUFEZShXC1jcJh7AoBPpjMR/SFniYXjQ7rQ+ZW0sPouji+21ENcvUXff5YrIa7yeHL1oedgt+AgIO8S15pIC3AE+cArEw/KKJkr8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FNRNjmADYCA1uNaWioZ9Zr+Zk5zuPBkHnmWIsj3W+8=;
 b=noRfpcZsvQfRwZ7cVHVLT9yiPB6X82Ooxr1zzRNsBFsSZ4cAGImTv1L9jGjW4tseXC1/U1zUVkLNefEmtqR1Jl5EgdAwe9VaJm6v8bHF/d40aWrHrElcna2FYInUTO+uY87ODbL99lga55RRMrsk6gJQLjjjM4Ip3/l+e0R7i7l/O3ZFAL9R9ORtqBEDNmywOe3iEntxSAJwLp5c6KhHqz2gWTcHkpN95ieoBDR+6a4oRyQn3xuT4jdNG8oCEs+yYBYbdaqXO7NIyMEhbz8qcNN9qN1meSkbHWq93UYeM8YA9KHfVyH+jCwWwCQTUd62EE3Sb7cKUBUuW/nULHPTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FNRNjmADYCA1uNaWioZ9Zr+Zk5zuPBkHnmWIsj3W+8=;
 b=jdgrGhZCXFPUdV9P3GHxoASqU6YC+9aTXWvqZd6j85q1yUqKT0F5FBJR+6PwNcj+NQYSX77NM3W5xSw2j+ICv0XNvZk2WRN6wDlThpH3/zt6jZWrucUuWeAzuhe+8HZXE1D/01m7YxsU4sXJY+7Sfz+XZP2YKLK19rFNbW2pXGE=
Received: from BN9PR03CA0171.namprd03.prod.outlook.com (2603:10b6:408:f4::26)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 31 May
 2024 21:41:13 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::86) by BN9PR03CA0171.outlook.office365.com
 (2603:10b6:408:f4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31 via Frontend
 Transport; Fri, 31 May 2024 21:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 21:41:13 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 16:41:12 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>
Subject: [PATCH V2 9/9] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Fri, 31 May 2024 16:38:41 -0500
Message-ID: <20240531213841.3246055-10-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531213841.3246055-1-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 8510eab1-3843-4900-ec3b-08dc81ba64b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|1800799015|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5KPmR4vkT0zaOwqXL0T/DSky+3OcjymRMYvLddz+rrwjWDLDUnqetuGFCjEi?=
 =?us-ascii?Q?rTNwFs0iiIWjWtlQOhVefWlWJ5W8+5QnuazvmcoH9tzqhZAMNGLLILm1Omy1?=
 =?us-ascii?Q?u08AjY0yKZS1LPxkUd5vLY5D1VuJKUPCgo7hmMZCnTgpEn4HbN/H4/BVZk9L?=
 =?us-ascii?Q?J5kR9QxOIHPupI/I9SRIT9V3Hwi7hcafobk5gtV2jEbwmPVmyKTsd8OX1Awg?=
 =?us-ascii?Q?OT+vQKhTxQI2mhKI86vX8grhRZhqYW0X0VZe96oJIUmkMypt34zEzFB1CrXP?=
 =?us-ascii?Q?KjH7dJrUHWy7rr93nL6bo6RU7/MhMIlSrWKWIeg0S0OQBcsn1Mr+jUCNONwJ?=
 =?us-ascii?Q?hSMATRLOxXi1ZC+2mNKgz1Ift9EUmt4X/wwxeHE2+EZ70gjMvT3Xo+5lzXAT?=
 =?us-ascii?Q?XmK4opQ/QyX5bCJEiPix834wSUgswwaW+8yFqco3fxjaCvdqIaqVQzMOQ6fl?=
 =?us-ascii?Q?xwEdh0LDmgCjJ722ytqiyhx0n2EAxeN43CkbyW/LDQWz+34frwsT8Ws8LhT0?=
 =?us-ascii?Q?TLJdok/J6mbMBNUxCguKdTtgBUXBHh/LokMRwbCXNH9OdSdXdRMJ1+8KBuTo?=
 =?us-ascii?Q?vec3uQmZfSaVZyTRdWWInuLDgIueegHVgEcqNlAaeq0VVLx7wDeXTFNQpx4l?=
 =?us-ascii?Q?q671/cdub6X+wDtJHz86wyRL+fEpsEt+rtYkY4ZcH1pZG/UuXbn57eOdMKWb?=
 =?us-ascii?Q?Mi9En4xzRs6FzmqbRy1q3ZKrCxqb2fsmyGSHBoEIZKw/8yCeCjj13vVBIeg7?=
 =?us-ascii?Q?01xDyOGuYfj1wDJ1brzD2V9va5H3NHasb0MaaagvYXyEw2iwtZg+qJImTwGr?=
 =?us-ascii?Q?XEsc4j9BYjkurAti4to0AD50g4haAqRvovbK0x+03BVNUBelCIxfNO7vjiso?=
 =?us-ascii?Q?3yGN99xWvJuWjmfM6/HVQxiBrtCYC/rLgUSmkOMw8Cbav+xE+Oh6m1HJZYRE?=
 =?us-ascii?Q?AjcrRgUNDzp3/EIsFtuHE/P4/CV6ZF+Z8owfFm6Rr1tHLIe8hUDkjEgSuen1?=
 =?us-ascii?Q?F6JK8YWoD67YtF0xzywDUDRpONjnENAlHpcCufca7u0nXRVO7zrKu1yfL7Jr?=
 =?us-ascii?Q?vj5UuK/Y3ExJZfEjLh8a6llJVHeQKr99qbYrB4qogS01vttAPfyCU5hpAtJm?=
 =?us-ascii?Q?bF8VQJ/pBIZ10AjS76okgG2MsTGFw676zPlps/S0PaG+ZtHSVRqRRrZTnUdC?=
 =?us-ascii?Q?2W2wfk4B4amzmAD/kniv69/VpfZRdAGFG3zbd92/5aavvnJum669aIRthdVu?=
 =?us-ascii?Q?gAFdhGfAmaCUoID60v2YqQNwD65zlqTokiMyg1lgJVjKxcsC9AdWVMMnKy0k?=
 =?us-ascii?Q?zpFal/kYNOHaPkwBv1LsRD5WFl/dY92xCxgVTuLBDv6O77VxV+ygPscCQ5C9?=
 =?us-ascii?Q?jAtJWb9v1UNnWPl1gwqfv1eBykpM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:41:13.2843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8510eab1-3843-4900-ec3b-08dc81ba64b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988

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
2.44.0


