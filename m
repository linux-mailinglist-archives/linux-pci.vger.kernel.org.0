Return-Path: <linux-pci+bounces-44815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB27D20C7D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F02763001810
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72771335545;
	Wed, 14 Jan 2026 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OHGqurUN"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012068.outbound.protection.outlook.com [40.93.195.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F32FFF8F;
	Wed, 14 Jan 2026 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415158; cv=fail; b=uwV3F3dOqGsYsdNMM/J3hPCiVpMLxGd3NvSFdtCPmI0dWNc2j4TUblfdqxBU4J0pSsPzQB1W1A1KYqB3Ts/8+iQ2hF/tr+UAyDXfqWfZKsffLHuJ5l6DErd4/ddka0PCflFBKxGm/HNckYQeMR+oQoHvT0UJ3xL8ZLKXrGu1WtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415158; c=relaxed/simple;
	bh=NZyemTYnEbwLh6qn4lirQmY2tmzcqsKry/kDdJdRpOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLph1TZUaKo5HOm68w8X8MzGl2vHQrLvX+utNdw0NYxQJaA0pXKUWOE2Plapfa2VH6qZMKKIw/0PkocNbGT8SGvTxFTrcLqpaj2uOlMLR8KWQkkKslFMuhiR7we0ga1stBbhccfCUrZB+HGY26JESFgNzkTlsAIGEMZpJriJiug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OHGqurUN; arc=fail smtp.client-ip=40.93.195.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwsgZQDSnqoJuXH5nLa+EmNx1tSdE0EYnv5wxAAJNtVAtV6yvD044DZABDIqB5yRDY8KoA/P9CMB876bFFhEfJXuhHXElyvLT8KYWpNtOJoZ1Dfq3khp2RxQISRXsaYnyuuWfiE9cmPZ0CdmGGfuj1XzkpX3HhDxhg1rlIv6f5JkHRTbH66fJbzBUod7Cgm1ZXbYdp2paLCOB8AEs2gN+j4wrmx3WYltSJfTRK1b3hJf85XXDIISyw9p5ays85IMv/XzeVZUyS7x00Vawz69p2tnFfq9oIwJvg6UH/mVLlaGX4faKbP2GFXyaQK2YInc4MKmOr1YdjKRgyDOu9PwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ+s0pH9zI2GlKS8102fBDia+mFaooafJcWpDK13O2Q=;
 b=n2BfvHjJGUD30uAFN+CnVv825GUugLRxamQwHb10MTvEWqJohV1Vc8fA1Ly20sXGkjORlHGArh/hvJdccQJqDHkBE5b2x4Utd7kkt7QoSqgMvipuIgAU1hwstZf9Cohmn2byv8Q7TXmaDmVOArIJII3YOZLoFZGC4mbRo5fX1EOe6I/X7p2H2gUMWtJkGcjn72GLrevqleVuTX7n7cxqe7SuAin3sDL/G3+OVyDCrDyg7ZGsPf7sUP+Jm2q0Nfn/ROGImA8pmhrDIz+E/I0gf+ls6evSOWO/1hPcv03an1CqqPGoOgeUg6NPrJ50fxmwNV8dbyGBv9NkzH/e87EinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ+s0pH9zI2GlKS8102fBDia+mFaooafJcWpDK13O2Q=;
 b=OHGqurUNJUWfJVc07D2gEbDAkVahabuTZzcOam0r2cSi2pVR+GlVE0lY1Z8k0PXy6p5aSu0phJgx0RTgNKjeBSJalxPunT7X5laDVw6hy6v619EKTLvMXKbJC09ddhmAofdFVw67fotsDNtzn3Y3DTlsdBE7h/Y59upQiEE1btk=
Received: from SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::34)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 18:25:49 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::c0) by SJ0P220CA0003.outlook.office365.com
 (2603:10b6:a03:41b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 18:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:25:46 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:25:45 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 22/34] cxl: Update CXL Endpoint tracing
Date: Wed, 14 Jan 2026 12:20:43 -0600
Message-ID: <20260114182055.46029-23-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 91515e35-f4d7-4102-1f53-08de539a562b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5UDsDOX4BpzbTiKMipIu8TQohEtXpDktnSpXsagcniGTrAaliLa0T+mMnvPg?=
 =?us-ascii?Q?1Nlg2LGRqdHqF2xLgGf85jh8Ur6gxm6Sjmj38ev2OM3iDB608VAjKkzvSvMt?=
 =?us-ascii?Q?wh7LhwH16tNphy/ncU1Pg5HEVdgII3700rPGcurm8G3cmr75viCpkK6qUSrp?=
 =?us-ascii?Q?2t9Ba4J9yd+UsB+QAxIIW8ZnK7Smb/JxSuCG3r1e03xPkXHzcDcJQkGiRjyK?=
 =?us-ascii?Q?BUmdQl23WsYH2vZxf/2Bg31Te/fBeGLwz3sNtg7DubTMx3Msn+P10bjDaYiE?=
 =?us-ascii?Q?SnSDkS79sKppAYN5pDCGicFx2EStGcKXdaT8O19YPNWh7mAMWQHbP/aM2o7i?=
 =?us-ascii?Q?wXGwloVj0wqXkmXQcTPFZ7VcNIOIJchRdN1sUZ+GS3trXDe/HzrHJRaRSjC5?=
 =?us-ascii?Q?QoYjhlwaQX9KO82aqb1S7P8idwiyWU/x6splCFhsEg4XKbAJQvWNcL/CLRn5?=
 =?us-ascii?Q?73DxFZqwXxKd2lADV7iEmB8EZARhpQGdpC9qrjiqDibBqKYvOCxFM9uLbz6G?=
 =?us-ascii?Q?XOTgLJkoY8FnUXY0AlVSP8mc4/VnoHfqvz3jZkrs1VQ5X4OheyWuLudglJSP?=
 =?us-ascii?Q?8n8Pno/TYgRzjPXjRqcmlGtJvbYZfPMZRqUYXQaC+I0U/GF7CoV/ismPg5MO?=
 =?us-ascii?Q?vRAvjVaHEe/Ymynwy5MJ3egvq9uW4RT0aXg/wB+mykRctN7uQL3K8LjuEiQ+?=
 =?us-ascii?Q?zqVzZeBVpVoUYwfwX9iGwA7tkyNEErimBN5kro2DjnnjWkB/vbBgOt6QZW8I?=
 =?us-ascii?Q?j2jC5IrCDtYjy7QnwjyspyclWOAcgBwEQbXA+6CnMHmO4h8tuaaBbwSq2Gvj?=
 =?us-ascii?Q?4CIG3Y6YKMdo7mQI3hxkgidwZLCCzlwV+xLhsXvDsPbrrRkhBLZH169TBfJs?=
 =?us-ascii?Q?wDdW6SxV9BmXFHczrjaFzjtu1FMpsKV3bTBKYPZFe08Kv6gBAbMItbCBMlck?=
 =?us-ascii?Q?39AsVvgCvUESGLXACLV6CXRNRoLPBKbdmT780aZ8sPxnuGsXfblyZqGBQUHD?=
 =?us-ascii?Q?8ZCEe3ixS4WCia+WyiqIzLNKHAIbaV50kx5bpH2NgyokI5L+GgSLlkxgvKIZ?=
 =?us-ascii?Q?K/ZZpFMpHUsJC7R6nTxc+gZAARGqbrfO4N65fhAs0Sa10bt8fOUkETV9KWr/?=
 =?us-ascii?Q?okyM0Rtr+OeFbcbmTB0o15AaiqTuKtvyATtemYyy+gRc9K8TSjHlkMrZJJzu?=
 =?us-ascii?Q?BQnF07edFUN1M8vooX8VRGSOXtQx35nFC/KAf4QB497NDejnKpobgLv7d9ZE?=
 =?us-ascii?Q?IR7Q5vrap4fd00DEtvxYkTRFu+i6eP4LXLRYZGIGkgAl9Jouhj9FmNhQ0g3C?=
 =?us-ascii?Q?Kb5S+dh9vfDGgUIC7hjt8yVDYF8yFWZNqasYMmACPSTNq8jG1/knPNzWKel6?=
 =?us-ascii?Q?Otk2FD5UOY4zD/3fSllQzi6gDM3AyyS7UQnd6HvF6wzQAV29Q+kszekU0w9H?=
 =?us-ascii?Q?aEa7LwAGp5P0wOMn/YHVYV5Ax+WLOp6rB3IhZ7tN/l0MgT2JN/PRBZlurYYj?=
 =?us-ascii?Q?BuytM7K9aFNGAITHM3wgy+8DGHJiPkV5GQpkeUzIBunZ4K1H4gaoykIP85Wm?=
 =?us-ascii?Q?262MNJxmQqC312cgQUMQHtRJkyToDsCXRqG1jMkfmfyQNY+Og9DBE/82GTUR?=
 =?us-ascii?Q?+XWxs1vK7qH2mO0+mdRMIHNkaPJ1FaQnW5SmyhRvKXe/ADDd7taN3F2pl1mv?=
 =?us-ascii?Q?EDSosUfjqqjn10+j3wyl+A9oTP0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:25:46.7591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91515e35-f4d7-4102-1f53-08de539a562b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993

CXL protocol error handling will be expanded to soon include CXL Port
support along with existing Endpoint support. 2 updates are needed first:
- Update calling interfaces to use 'struct device*'
- Log serial number

Add serial number parameter to the trace logging. This is used for EPs
and 0 is provided for CXL port devices without a serial number.

Leave the correctable and uncorrectable trace routines' TP_STRUCT__entry()
unchanged with respect to member data types and order.

Below is output of correctable and uncorrectable protocol error logging.
CXL Root Port and CXL Endpoint examples are included below.

Root Port:
cxl_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c serial: 0 status='CRC Threshold Hit'
cxl_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Endpoint:
cxl_aer_correctable_error: memdev=mem3 host=0000:0f:00.0 serial=0 status='CRC Threshold Hit'
cxl_aer_uncorrectable_error: memdev=mem3 host=0000:0f:00.0 serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v13->v14:
- Update commit headline (Bjorn)

Changes in v12->v13:
- Added Dave Jiang's review-by

Changes in v11 -> v12:
- Correct parameters to call trace_cxl_aer_correctable_error()
- Add reviewed-by for Jonathan and Shiju

Changes in v10->v11:
- Updated CE and UCE trace routines to maintain consistent TP_Struct ABI
and unchanged TP_printk() logging.
---
 drivers/cxl/core/core.h    |  4 ++--
 drivers/cxl/core/ras.c     | 35 ++++++++++++++++++++---------------
 drivers/cxl/core/ras_rch.c |  4 ++--
 drivers/cxl/core/trace.h   | 25 +++++++++++++------------
 4 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 422531799af2..306762a15dc0 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -147,8 +147,8 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
-void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
+bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
+void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index d71fcac31cf2..84abcf90fa99 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -13,7 +13,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
 
-	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
+	trace_cxl_aer_correctable_error(&pdev->dev, status, 0);
 }
 
 static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
@@ -28,8 +28,8 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
 	else
 		fe = status;
 
-	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
-					       ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
+					  ras_cap.header_log, 0);
 }
 
 static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
@@ -37,7 +37,7 @@ static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
 
-	trace_cxl_aer_correctable_error(cxlmd, status);
+	trace_cxl_aer_correctable_error(&cxlmd->dev, status, cxlmd->cxlds->serial);
 }
 
 static void
@@ -45,6 +45,7 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 			       struct cxl_ras_capability_regs ras_cap)
 {
 	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	u32 fe;
 
 	if (hweight32(status) > 1)
@@ -53,8 +54,9 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 	else
 		fe = status;
 
-	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
-					  ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&cxlmd->dev, status, fe,
+					  ras_cap.header_log,
+					  cxlds->serial);
 }
 
 static int match_memdev_by_parent(struct device *dev, const void *uport)
@@ -160,7 +162,7 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_ras_setup, "CXL");
 
-void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
+void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -170,10 +172,11 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 
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
+	trace_cxl_aer_correctable_error(dev, status, serial);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -197,7 +200,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -224,7 +227,7 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -246,7 +249,8 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
+				   cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -275,7 +279,8 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
+				    cxlds->regs.ras);
 	}
 
 
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 0a8b3b9b6388..3e33374e07f2 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -115,7 +115,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
 	else
-		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
 }
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a972e4ef1936..c569d92b6000 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -77,11 +77,12 @@ TRACE_EVENT(cxl_port_aer_uncorrectable_error,
 );
 
 TRACE_EVENT(cxl_aer_uncorrectable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(cxlmd, status, fe, hl),
+	TP_PROTO(const struct device *cxlmd, u32 status, u32 fe, u32 *hl,
+		 u64 serial),
+	TP_ARGS(cxlmd, status, fe, hl, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(memdev, dev_name(cxlmd))
+		__string(host, dev_name(cxlmd->parent))
 		__field(u64, serial)
 		__field(u32, status)
 		__field(u32, first_error)
@@ -90,7 +91,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	TP_fast_assign(
 		__assign_str(memdev);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -138,24 +139,24 @@ TRACE_EVENT(cxl_port_aer_correctable_error,
 		__entry->status = status;
 	),
 	TP_printk("device=%s host=%s status='%s'",
-		  __get_str(device), __get_str(host),
-		  show_ce_errs(__entry->status)
+		__get_str(device), __get_str(host),
+		show_ce_errs(__entry->status)
 	)
 );
 
 TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
-	TP_ARGS(cxlmd, status),
+	TP_PROTO(const struct device *cxlmd, u32 status, u64 serial),
+	TP_ARGS(cxlmd, status, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(memdev, dev_name(cxlmd))
+		__string(host, dev_name(cxlmd->parent))
 		__field(u64, serial)
 		__field(u32, status)
 	),
 	TP_fast_assign(
 		__assign_str(memdev);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 	),
 	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
-- 
2.34.1


