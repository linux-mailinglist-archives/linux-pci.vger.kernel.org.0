Return-Path: <linux-pci+bounces-15359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A24C9B1163
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A247A1F29693
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481C021765D;
	Fri, 25 Oct 2024 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U44ItDjo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394881B21B1;
	Fri, 25 Oct 2024 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890287; cv=fail; b=VV1r4zn78Fo01/8EYkWP54iasSTX2TXQwYuqFBDYQzl9eTyDk1fRaQQSKZxSLe2lU03Xx/aMb3wXWfgfzl+2BGS5S/3O8Rl1sWYdp+I7MnVxGWH8pT57+ZPZTgPJAaK06tA3jTPsQY1dKi+nGXboWqc9LOI59SYulxtoLh8ulhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890287; c=relaxed/simple;
	bh=/gciUkMMv/fmzvWAzaB1/vpC75eH95U3LDrMbnbb9CY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A43M4sAtrQFTzUr9PWmsM1Wqwmb3g2kK4zn65/ITT7RWRnCIIXqJperWUHjOBpxWGhs/pFO1JIuhPHdN3emqcr6FRJ+DrzJfp3Uf+jF+bRw+Q+BCBgjd1F0PEHIiwpz+z1uEAdVl2ywPvd9ez7wVYpN65YuKhRZe4x8mwPDp680=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U44ItDjo; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLGzgq6RfEpsni2vqrKc454aEHIo3OuWhVonuS/HjR1B/hEWFsWhAnCm7ivIB1LVdOrCHhVq/TKjtkbYrK3O2oqIBfe4+TlxJPRE8/wnPrE1hkVwqYwY3mmRzpTQfHo+9HfwR3GvvoPfka2mdjNcsM43kbTShxX7eBTk73SXgxz6Vnl4VrQS6NZ5qPiQY9V3pY+4n6qCJjUjXNVa9YETghrszkRZ3+2M0eRaoAHHoVgfUc4uFEr5pFqMGZzyAcJbkVmbFaVDH5kBlAvWY410hPk8ZHbdHiU2gPBkQ82hnc5EQEHuxcXU0zLGtl1Vx1Gi65CRCcmzxO+favH5NEN/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB7aW/QflGOsDvF/CcqsN9ewFe2W7T/z+vI8ciwGPIs=;
 b=Zm5TQYzloWBPV6kASpoGB82C1G05I6Dce2Al5NjTh3eqDWJ51EXP+2h+tRoBs4HkO+hcGV1FSv4U8JK580pbBHNvILZrLickiu5mzVVHXDJEMYdOsuPqFK4Xnc62hjtnR+w1PqKW043/E5BwQqvdAm5sXJ9LH3O7ZnmUgW3mkUo7WRDrijbCeDyY9kvoGlUsve2rRkrVrptTq4LN1n0C/5ES4VDjuKgssgHbefRaXr2C4rcukf8pvKOnXfVQ7BjvDQXHoEBH8CwO3qExLYVev8m7Zanr71R9ilw2n0/QdSqcvTLPKuPUPKr0ZETQC1jN3inw4xN6G1eVuwk5cxa3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB7aW/QflGOsDvF/CcqsN9ewFe2W7T/z+vI8ciwGPIs=;
 b=U44ItDjoAqWIbYygEveHAqF5maIeYJGh9lyWOXO5Wn29bgxx0RM2trHoL9qoHDKS6GO9HF0V4xCJ6KW8QYWqcbjhPF9IytJaI/W8rZ7n2mftvn85bqliYSTsT1yD6OaHnvN+HCMrNSkbT5VViDHzyFZAayWcELMEGymj+HWsCQg=
Received: from MW4PR03CA0073.namprd03.prod.outlook.com (2603:10b6:303:b6::18)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Fri, 25 Oct
 2024 21:04:41 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::f0) by MW4PR03CA0073.outlook.office365.com
 (2603:10b6:303:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Fri, 25 Oct 2024 21:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:04:40 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:04:38 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 08/14] cxl/pci: Change find_cxl_ports() to non-static
Date: Fri, 25 Oct 2024 16:02:59 -0500
Message-ID: <20241025210305.27499-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: d060fb99-2f41-4fdb-9a81-08dcf538a43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vLCXIDPjzVH+wq+VIZNkS37f9fjgCZh/VKAfpoLPARtaZz0/SK8e5FgRXnJZ?=
 =?us-ascii?Q?wJaMx3Z5cGvD86zjDWQGO5qeM9+Ofz537rQrsDCCgya3sY1M1rIFXZfDNriE?=
 =?us-ascii?Q?BCoy/Ua1wCBYXX3LDO32m0qiSd/NwHd+ShEvZFq7vpLFUE4F2NZcPcNKKR/P?=
 =?us-ascii?Q?D3oxgR8aYMQiEZfASAgTllnG8PpM/uiBSVVSCSGVGp3R7npDBvtgTAkb3tWX?=
 =?us-ascii?Q?Jy5lF3QbB2HOPtZ1pQ0LFW1MrLAwZ6+o3boTXhCPMqmIUWiXaYofqLArkdyp?=
 =?us-ascii?Q?/mDEEKs7G/rUP9qGcLKlPDhKj7vbSVmFNdAwJXLOdvDGeQunIlAzyCNPEDrk?=
 =?us-ascii?Q?FHlvAsZLxPDemy5LLnEvrFSwOO5qS+HFNJ61hF51CI67Nr7QiI4caDyvKPiE?=
 =?us-ascii?Q?qrV4ld2kOhiUiVhxHmgwMEh9T8JiEYiuoJFP+uuMoLg2bsUv3OYa/WyI+GFk?=
 =?us-ascii?Q?COu9jTKDzt+rh5p0RJFi6KhXQllKegfipDjleM5AmeUuPWbVar8eXuYj0gDR?=
 =?us-ascii?Q?ig53XP+lWWH3sjYhO2L993sRNpRhP9XYWb9a5i1LfDBHeLgPumZTaMMSBK4k?=
 =?us-ascii?Q?FxJfjVJfgzt7aaqG99MaBTiql7z39ZRR903tJC5R8gN+L4C7QF3aIoa9iwzJ?=
 =?us-ascii?Q?gx1v4WzDfGI2ncJU4VD0P+ifwLwFLmRY57KAzoFGVzw9hgfo2QGP8b//oCzn?=
 =?us-ascii?Q?FEwokf16u0tnNMtxizj+KmsV3+LGqPbCEzUgGOb8c0Ey4+h56LhLeW2eoha6?=
 =?us-ascii?Q?k1s/QVah1tsDXd4kNdnkDLZ6ffTo+9HA0QLKXqzXMe1hslAA5hcEKRD9Tbgu?=
 =?us-ascii?Q?suHB34Ltwcy9+r3geJLADYKpObwflXC0+rWoGkgc1+7HQGZ+XREwZ4Ydh7Xt?=
 =?us-ascii?Q?AzBsqXFmygjzo9AxcqJPidjYs9vQ1SG6vAgW8a8TE2xo/SvIGO2p94nOnki2?=
 =?us-ascii?Q?cgCLqWyoEmbiYE02HSsVZ4iDurjoB3tvfcyvJnRwWiykwZOvo1GI+ke7pkR3?=
 =?us-ascii?Q?lArvzeylgCW+yWaHXRanukvIQdacB5u1gv6FNgQpZSw4iHrRO9yIysAb2SBP?=
 =?us-ascii?Q?jp8xBiNQy6MW34DLBfYjMGTuy6UNrYtXTvdoAzuXeI4iLN7k4Z3UhSNEqlR8?=
 =?us-ascii?Q?9AqU9wJURS9kgKTRJ6zA5IKzrZWi9JAC1lzlL0bymFdMEQVISbDIRJoN3eHc?=
 =?us-ascii?Q?pCr6z8NhKFyf6AaHEHWiDw8nXx6+bfFHuip25s33gPIpvM2UrXKV2/kS4yEx?=
 =?us-ascii?Q?gX6U86vs/D4MjpazNkzVVttACyT8ZRS63gqHFOs8cRYHLeN3fQZQBBdAHJGJ?=
 =?us-ascii?Q?xGcQOnjtLBYnmwYOCi7zK/TLCxm5NQcWEnN1+lZeTIS3BMibH8LBx6T5nCcp?=
 =?us-ascii?Q?IhCgGC8qfcGQc6lQLW3xP6T1zLB5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:04:40.0498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d060fb99-2f41-4fdb-9a81-08dcf538a43f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070

CXL PCIe port protocol error support will be added in the future. This
requires searching for a CXL PCIe port device in the CXL topology as
provided by find_cxl_port(). But, find_cxl_port() is defined static
and as a result is not callable outside of this source file.

Update the find_cxl_port() declaration to be non-static.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/core.h | 3 +++
 drivers/cxl/core/port.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 0c62b4069ba0..d81e5ee25f58 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -110,4 +110,7 @@ bool cxl_need_node_perf_attrs_update(int nid);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e666ec6a9085..2ac835cd4f1b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1342,8 +1342,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
-- 
2.34.1


