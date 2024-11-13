Return-Path: <linux-pci+bounces-16709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B00409C7DFB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F50EB299F6
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81ED18C933;
	Wed, 13 Nov 2024 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KPlzWJdx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE742AA9;
	Wed, 13 Nov 2024 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535004; cv=fail; b=fiZ6n+NIieGPib9fCnJxm+sH1/Zf1jER2MS7dbFHcF6XdYd//UyeKvyRjxHIGQ6WACBbR8+eQuMA3BOqddzUPyf5H2dsk8QCNXi7Qs9izl0sfiNFS5DUvR7Zckf0MRZKPIjCejBUKBK7IKJuVnkf3wm8Yb0GSmCYNfIgaWpq1JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535004; c=relaxed/simple;
	bh=JBnHRI+e46cqeB5QJeMAd1WU3XGuk2W1/6kzw78jaVE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aF6+fp/Yy6+SPeK7f745saWEnmKrJBpn+6jBwmw34RIG3FthZmIDnkpJEHvBToUbltB98BAN87+dKwJ4Z7aDx4XfE4U5ALPL55qAkF51Uo4ogD81ZWYFQ2sRsOHXuSoZSNrhM7dK3xX8mCRB08iNj49TCSMM+y/ZzneKtqE8lw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KPlzWJdx; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2cGjkNjeOTw7NsHGqo5ceBJP2zko2KdVVMAik9VMgx2f41Q3LKiHMYpAYJK9SCYwjN+lnOgVOP6aw+TfCU8oGiuc/PMutAlxW0cJtuF9WOVfNWIxXqs/e490/N/YJspB+o5LN3vO6KE0n5qVUHbPuACtyj7KOMQz5Z47rf4FkL2+3cF3fzyhJInUXWxoiTM8/JBY57Xph7JCXxXEMXCiinXHJAwR1SL+Do9GA0xRp4AqrUMfyxfCNaMwI4bGVHHa1MioJZvoaqGFbqVoNfVLfMCNRD+3TmKnwywKsqd1Hd3nPmgPc7C45V8C49RU2HaeLsWKnDzb51PskCVTtv+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nG2AbAN65I90hLvpP4AAHW8y+MJuQFiz7W7eN18SpFo=;
 b=ePrdMvZB5HVEhsRsYlg91dFt7JtT5ND33h4N7W91g+DjzQU4pSNYsPeDiJXgmcmt1lCh5JwwZrdmPo7wvklWddTWKMA77U3XDIrmUoHt/WSqJVmIbTFqvyPZiltxhCF0H6dE3VM2PsDL1AcGcKO8RCGCYiD5f5DAGiLG0G2EcNGhpLMH6ynWFUYoE8cX4ntxnZ6cwheN3Otwr5zbOP+C7z5Z1wyLGriuEOHuhM+Yfp6ZhG3AurNAvW8wCLgBU+DggG9vfWmUQ7Syw7jvfw726yZjon8MC97LGQD+ViEku1lIBYm+V2tRed1smztUtXlD1G6d/mYU+YtmjbI3cLyB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nG2AbAN65I90hLvpP4AAHW8y+MJuQFiz7W7eN18SpFo=;
 b=KPlzWJdxG1k2L4wirUnTEHtB8nrTrShXRvStGuDvfXWdfo88FbiNwSYVs13dxZKLjVtT7HDdx1Oei2mu4kCHBuwoYmRgXnYobtizHAumjBxDTVg7qGZkKICFJ+sVoc4f0/F1Iw5s/zlGtmPvHl77Q1rLLvnuRNE1tckpQ8eCcxM=
Received: from DS7PR03CA0074.namprd03.prod.outlook.com (2603:10b6:5:3bb::19)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Wed, 13 Nov
 2024 21:56:39 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::ab) by DS7PR03CA0074.outlook.office365.com
 (2603:10b6:5:3bb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 21:56:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:56:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:56:37 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 11/15] cxl/pci: Change find_cxl_port() to non-static
Date: Wed, 13 Nov 2024 15:54:25 -0600
Message-ID: <20241113215429.3177981-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113215429.3177981-1-terry.bowman@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: e627a3de-bd9e-470f-fbda-08dd042e0d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HJjA3D9brw9vuKl/aWk/lr2HRDxcjFdirf0pmXxAiGqdizTYBj2dhM8plqLw?=
 =?us-ascii?Q?3iXOqQSuXxaMFZoy8RY4c4e/llSV5AW0waI3vJUwAdZC4gH8Br12eEEZUwad?=
 =?us-ascii?Q?6rqLVpH+xy/rNUaNxqiCpXuoDFVMuD9XzvS0jRsuWbaqrD3d2dCQKdukDAVr?=
 =?us-ascii?Q?3XgOmEep4qmd3Bo8tLd0hVqb7gLYmm9CYk4w1MUBJCel7vFwgs7I31jIV3sA?=
 =?us-ascii?Q?TyLmc49zTD+wz1bDmp8NyTEhRKFkOR2iMBX82Q43iwykguekdKfPuWDSMyIB?=
 =?us-ascii?Q?jxE7knN2eczIyZvkxBLLprHES8dPFM1ZP68g+EA6ujAlCYp08mmQt/s5cd+D?=
 =?us-ascii?Q?/UEBLCyiakrjNpG3V03VbFywZZw9omK3+3V+YU2dRmfkhbvp82rCrWlqpgpp?=
 =?us-ascii?Q?FSXad5WYcZ/FcF1E34Kunar22O7jhvBZeuMy6tnkNDWCaF/a0nioYYvr4nZQ?=
 =?us-ascii?Q?AyitNJhKde6VzN8BgEA6lnEtprs0ISheeoI2IuydLOyFaxC8uwdnrNUYg5ox?=
 =?us-ascii?Q?B0azlycx3cEeUn8N1hlXXWM+1LrRszqEKjr2jVz9MQq1WNtkHXd0AXac0dhs?=
 =?us-ascii?Q?hCKYGI8oST8+Zaq2lmnE7NYWg6EvS4k5mIhf9Zq/dzQlwf+C58uhF9IkbtMH?=
 =?us-ascii?Q?OEcLEqMkf2HIQ+itDBfi0HEZ5b9/MKn03hE4i2AjmlmLmE1fqvXl/6oE2nCc?=
 =?us-ascii?Q?G2VtiPCLyD7snE6PPBzWmEIcH98rObOrP+4lIbqFCdKYd0r8w+7TUd7VwaQl?=
 =?us-ascii?Q?zd1W6jmnvJzU1+FO7S9qnoJhUPUwprsuqT2uXTqphQARXNw5EQ8NClL3+sGL?=
 =?us-ascii?Q?kuQ2aJO44/jbtqWI44BApEtzcsAipelI6yzvXxVi0DbIoLDJBupsddx7EdM/?=
 =?us-ascii?Q?SIeHVNW+xQKqciFzvIWONxC0E4tUoZSPE4R6bYEsZWf3QS5mhFg1Etu4S2lK?=
 =?us-ascii?Q?n4mHC84kXEBYei3wByCJNb2vcMhxFT1bovzrTWDNB1vxrulFr+QVpr9EoHy9?=
 =?us-ascii?Q?DqmiIAAMJBrZu1oBcx8LIeVAqhe6564+jisMIvc2aT8P1URCvaT3XW//I2uP?=
 =?us-ascii?Q?dwEfR8AvwcRNSnYqRXRalTS2huAzLe4GyeKA99ugQZVZTgaFRx4yx3nmlIYj?=
 =?us-ascii?Q?kcIR9vLSUws6UVI6cTyCV7zhhiIPwWs/vZw2bqylG68KDlIJHphgYchB1jJE?=
 =?us-ascii?Q?JmFTfcytyuVxAPjsx/rlVIfNeic9YmtcCEgF3j7QKv5YGmFmiks4632O31CO?=
 =?us-ascii?Q?X/kCotY2fQdudgBn6DXPgUTOUqHA7YzOY2O9NoF4LVFU5HhTEbq7eupSwdOg?=
 =?us-ascii?Q?MyVL7K96U+pOrGsMyXTTIgnHGJzZoGj/HS3J6YXnbXhqDWl6xyREW7J7uU9q?=
 =?us-ascii?Q?i4ouAkt+zCr8jxuczTAwTkZOPSRhTGKAzNBNcb0wfQF2Qe9xr/EXeHk1xqKU?=
 =?us-ascii?Q?AH3oJOqH5A4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:56:39.3772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e627a3de-bd9e-470f-fbda-08dd042e0d65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

CXL PCIe port protocol error support will be added in the future. This
requires searching for a CXL PCIe port device in the CXL topology as
provided by find_cxl_port(). But, find_cxl_port() is defined static
and as a result is not callable outside of this source file.

Update the find_cxl_port() declaration to be non-static.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index af92c67bc954..1c4daf9fd2f3 100644
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


