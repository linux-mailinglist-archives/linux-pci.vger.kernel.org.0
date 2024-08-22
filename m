Return-Path: <linux-pci+bounces-12051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D6F95BFDD
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898511C23569
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F061D172E;
	Thu, 22 Aug 2024 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gU67GFC1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E91D1728;
	Thu, 22 Aug 2024 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359441; cv=fail; b=FhVpVsJhcLBv6GCQN2NID+zcpkrVVS01vr1OgelSO/G+i8U8BdJusUspqwzYeN0zFxpuMx6l8GTinlz1jzDsuOWBgA9j2OOL2F7po8LS7q2nf/Ip8wAHx8nZyynjzsQB2/n6i4SnVVScwsW6cqoNH18JsiC5JVhnxqwbs+Rj+Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359441; c=relaxed/simple;
	bh=k0CMdfeVPacNL41VrFyrAgKKGSdNVISUtHCOPmVvLdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCPHaxEs3I+5lChOWo1T2ktF3MDeAsFihkkzQU/xDnBnBb/MO9BOQl7PY2f6a7iMXsENwsdten41R7le2y8JtLRhpddw4M5Z2uxiBMVoUtbd699kdFGZKUEg+PC8yxKCA66VdOY8KnFI3uumdexE+rP5+3VQvsWK3sSncqEPPVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gU67GFC1; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhP7owSuIfZDV7QrBsqTRPsbiC88QunJOinF0qPBkSEQJyhxOSMNYs/nRjJrzULb8eYcKR/hr63nOh9pjPUMh4DdbAg2WVS0iXFx7YD5R3EBD9swrSCrNUp6ZO9GR5IHWk41naZB91rhrtPS3W46Vyt/Ag9HZjTWR3q25qH1Jz2tQIFldZLE1hg1h4vkdCGMCyHEWMzkzgM0ejlca5+WNX3Ri75IueH96RI/Y+J2XkD9u9jmQQmnNRH8wVo0rgH0TUMSFTzxveWSlbpP8JySpJKZECmw9qi/6CtUtmOna+NFHsqUWFLvWGSuMgeByGLczS27zLaQGO5bY6IAo4o8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwHk0OBuSEKgHsoLxc5/ykm35uLmgtEAzk4cXg1Kyv4=;
 b=EkUWe2BnfA02emWJoLEfTPPPEqRL0SlCUUp406yVEk+ZX3v6Dc1Fw2l9jBITy0BeXbQs0t9hBBQCAWvBlxh6MnNxmyuD4h86VSksQr6YFm+z1veTBIZJRPizMU6nhQ2ovKYwKjZhyRe16yCalALtxwrUnBv1SKm59JhLgcMJqvOjZ8B0A0YEFwuxHhcj/sQRACJQOKkxaHRw9RzM7ar5kjCKQV8aJvmIvY9MEMj50/R0nJrt2ehr2nZ0UE95LEFY3ON5cf8CIaXtjY5ccpC4fCliqM+FGmLcKZBHuhw8LUe1VXObMGD3TtQbfjwcgFIIWBqGqnazhfgAvfEowi00iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwHk0OBuSEKgHsoLxc5/ykm35uLmgtEAzk4cXg1Kyv4=;
 b=gU67GFC1YuJAaqhLvSF7ar0f+lnUsMTbCMSBp6RQzDjLLrC8uwNJcZaZMPzXbqD7w/JsEiLjdbl1gOzPnAcV8VnLTdV0w7GEWEPoDQhCCA0Xya6vec8taLHEGZkgDIs/nPYlSjE/wrj5Wh0BSnCeLDCPfATMWagvxZNyJ81DrQY=
Received: from BYAPR03CA0024.namprd03.prod.outlook.com (2603:10b6:a02:a8::37)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 20:43:47 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::2e) by BYAPR03CA0024.outlook.office365.com
 (2603:10b6:a02:a8::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 20:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:43:46 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:43:44 -0500
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
Subject: [PATCH V4 12/12] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Thu, 22 Aug 2024 15:41:20 -0500
Message-ID: <20240822204120.3634-13-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>
References: <20240822204120.3634-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f30e823-22fc-42f8-2ebf-08dcc2eb1ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jc0/Ca1j0zxQoyJXHrVMgqC8vv7Mw/7kLqHlnAKhHvYyX0HyagBeCM50x5b2?=
 =?us-ascii?Q?AfmIl58js+3iI00V1owMyPm+CPMye1R6X10dhWS3LDJVc/IKZeS2yVGVNVbZ?=
 =?us-ascii?Q?hP0O4dFtXgJGVX/mZMPz4iIDXD10vu/VJYbIaq3OmYvQBEhDywhHxJsH8npi?=
 =?us-ascii?Q?LSpbAHyEm8PD7M1ONLLK1rZb3xInygQ+83kNMAXbmphHOywo6ngA+wrxmYb2?=
 =?us-ascii?Q?toZWzvmcVEMcAvKgfaPIeUmWy3gUhr22OsKlvoh4v5KXV+aft3YfwaUzy+v6?=
 =?us-ascii?Q?29y4h4cbzIDxZlL0Zixz3kuEnn0dwBhEknLd8/z/CfqQuFZZx9LgzbbCi0Pg?=
 =?us-ascii?Q?EXNSC4qMdFsNIij5YDCXuNUY29GbSLbde95iUnKU5mDbtt3nFxAti0gWE1qT?=
 =?us-ascii?Q?Rq/IK0yX5t5VuPRMWHdMA30HTw0vcDdcV7D5Am/KZh92uYY2oMGfEyvnu4in?=
 =?us-ascii?Q?Zb8Ji6gHQ8lmcuxIBUw77tbpZ711C0M+Vos+o4/pBYByi50TailyAYH1ERAC?=
 =?us-ascii?Q?8P0NgMqvMYf/piCf5nAl2lPuk7aksFoc0LJtaHUkWx7nBzKt2UjJJhlKLtY2?=
 =?us-ascii?Q?SIRUZd5cHK2CQvIPpDjuES/Hfd3gLqEjU7K/1bzNS1QNQvJ7UyQQVkELbaux?=
 =?us-ascii?Q?ODg4U0OmwxyARqPHsymm/RQ11boMN1D94Kw0UjIe3OsAJS3J8G0aUtrfKEBD?=
 =?us-ascii?Q?K5Wxn3QBe0vNF+mXaFfsksilvnZ3lLM96ndz7T9paa69+hBbR5lBSqaNySm0?=
 =?us-ascii?Q?EZ1PWPuKyiAmyHL5Uh+aBgWSxkULinTCmb2XqQ+6tVuMc/Um7WB+N7kkPhbQ?=
 =?us-ascii?Q?Q+eWzhNhfpBu5vSS1HYpKUXd35YAEa6Yl5t1KHX6W8f/z6X/VlFL3/pwwKry?=
 =?us-ascii?Q?tnnXFR66QnFA3oLbRZB/Kj47rA7oyTEoEmw06nLkzd/lcfApcvKW5wTB2ECU?=
 =?us-ascii?Q?EyYxWGIgFbWoLngN0B0nIhxjXeK6VPnINwytR+sPHD1dcdMEEYpOIcMOMPs8?=
 =?us-ascii?Q?ZJCkXyih2DN2X7LjWN93Z7hzZgGv87HZmyichZjUYm6kwKcXrIEQQi76AWEr?=
 =?us-ascii?Q?3Wvfc4dzb972AwiKnCIgxTlKXPjqtXARsK1a5v8cFZjrmQEX7pv5GfSrvxbE?=
 =?us-ascii?Q?SUez8958Uf/MnQEhbA8pgmCQti9aL/6Iqb+5YtbiouB8zBe8FEGIjrkaunyy?=
 =?us-ascii?Q?qO3z9v5CvA842HaNaGpwUxv3C2J/BWjuQCFK6M6ZWQ1+duLfO/hj5gjwPBAW?=
 =?us-ascii?Q?wBkt+0cgVQOIReDUdCgNkKy30dxb/st5iJkSDyhHG+zXXq32oVF/41bxqdve?=
 =?us-ascii?Q?6+zSI4P+s7lVfKOnOpyH+E/24fkwcNXAPdKb8hHXzq2BgpkIltrMFGQ9dIaZ?=
 =?us-ascii?Q?Ua/Nk8CrQHBXw8kt5yX414LU34ut8IbyaYrnLUFrJfgRwipTXXI+0xuy3zYA?=
 =?us-ascii?Q?Xhyucd7rY/GUeg5d+TFYOaS1GIiizFgA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:43:46.8399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f30e823-22fc-42f8-2ebf-08dcc2eb1ed2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101

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
index 5903cd36b54d..5fb46aaa16e3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6838,10 +6838,12 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 
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
@@ -6853,11 +6855,13 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
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


