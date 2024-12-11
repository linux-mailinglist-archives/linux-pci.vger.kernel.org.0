Return-Path: <linux-pci+bounces-18203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9B29EDC18
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8ECC282502
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA41FFC54;
	Wed, 11 Dec 2024 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="guc3UBN2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D641FF5F6;
	Wed, 11 Dec 2024 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960537; cv=fail; b=SIDaNhEVcaicwgaCUgxrO8UQkcd11OBrdQcypnh+P2AAG2hVa0ri2YFaqkENynlNGe+JVOQJ5roHGbSfg7fAPD7rZEWZfZ765xy+vWn2RuhsS1NP5eUEwFeStPelIFDzYe/DrCA9BDhT34HqKkonLQe4u47eg4hWURy/9nS75e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960537; c=relaxed/simple;
	bh=39GJQqT4d69UwG7+2o8u98MflRWCc3eZEHSAHjeKQ8E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7S2VegbDKLocNWUbLp4g3TO6iWY1LWPRZGbZn3TnGkvhV84gqwGC4Bnl3LsrEjJ0k55Y/3cQ13AeLTGTy6PVMA/queFZ/QwGFFhlDsyiIuGroPCbClFAdgKdF/zPngJEzT8vDXdCQusQp8n8fR/iS88dEodvBKoXtPOzfWXn44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=guc3UBN2; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfgW0JM0jGD9bk2Gf3U+UGXAf8XjXPrrkHru5tXVWRAsDnjH1dDOjz09xUvmtgt37An6ptUWbUzrxsg1VZc5ySbMcUW+RH9Srp3mhLX4oqgfgt8q6FeTEcsm08/wJGQUOPgAzQtLi1uoP37VFvK7/G21HozsSQenRsdhWFfYmQPcw7DHKaAHNbTlRIIn0IqRY9NR3X3PV049FOrlv8riNFOTsvuVb1brJeItBfWwMyxdbuUfgee+sMXOSsHN4Y/f4miUOaD+boacyjxdujf+qUiJ2yl3g37edCfkMeE5Pk2jLEAK99d1Cedf/RqmZkW0N2Kte9gE6L1+KaTq7b5V3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7hYzg+A3U8mzpynyVVyB2FoHSrp21VftyBBfDlR+JM=;
 b=K0OfZFPfU44rA2hbzxbkpvCkBBX1QQLCUAts9JDGrukYtvqukUVu6DAJCDCKYLrU/UibUomusPQhv7lY9i2yZUepftZ/0MxsUKQtOA831cjqWwd8jggn4bPv5G42gUwyVHasAWaz4ZdBQ9j4f5rN9rljuwe9LBnMwyEGLXHd69nq5vwZw2nGf9s2SIIJHkJh1LD6zaQU2q0w1mbHizCkat8pmNmerG+NgS/unsKThyTaaHGgSv7wMohPAUVRKahpFlcENsatAV0+4uI8YRx4zXMxPGh0zoJxIbrD+FEhSxkq7eLuCqFMhBGCyiT4snQGll9eUJY0vViASUgi8GdpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7hYzg+A3U8mzpynyVVyB2FoHSrp21VftyBBfDlR+JM=;
 b=guc3UBN2gJ46FGAv4XgNDRFQ7r6jN5BNhp3onPo/+7g0yF/PUZhvWLo2NF8zqnaHxzJN766rbfI/Gzflqy92aHn8PMt3gTNK0A3JYFuKGZV5rrTNd2bchAIVXIKvJqBGDh40BDqwChYR3c2dxJBW8Dvy1f++BX2r14+5UBaK1Ic=
Received: from BLAPR03CA0046.namprd03.prod.outlook.com (2603:10b6:208:32d::21)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Wed, 11 Dec
 2024 23:42:11 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::b6) by BLAPR03CA0046.outlook.office365.com
 (2603:10b6:208:32d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 23:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:42:10 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:42:09 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 11/15] cxl/pci: Change find_cxl_port() to non-static
Date: Wed, 11 Dec 2024 17:39:58 -0600
Message-ID: <20241211234002.3728674-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211234002.3728674-1-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: b5af011a-c664-4b1d-c438-08dd1a3d6e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0qQPLvHauvgFi8qYIfs3v2MomZiQ98cujpg6Bu2gIB8u91OchPsVla6NsjvG?=
 =?us-ascii?Q?SCPQ5xCA7e1XRYtm96x6rNi4ZW+dN+SdFJw1YCoXjAdlsGP2a2F1W13oq4rs?=
 =?us-ascii?Q?Tf+2hKgmq4KaXvGpTJuo4/Y3jq7PCDMovVnLrcmilHXyZXLfsKZbwkjIQaxu?=
 =?us-ascii?Q?DhNgV6p8IGjXYElkpoUSllFStJTYyWcvoGL+8JBAu+ZEQhIX7WQ/Kt2KU5uq?=
 =?us-ascii?Q?cupxNR0cWagdMucx4d+v4PQ1ao3Yd24CB5djKlI+tNBDpqsdFElUsgxmJfcC?=
 =?us-ascii?Q?ZaTUx6GMa7NXiWu1/b3CFPbQ6U5ZjKahx0VhfcyH6N1EPqTAfhP4P1szlD3I?=
 =?us-ascii?Q?3ZLvCeMRGRpaPWX7A7FfuRpZxZ5KdLTXSxkInRRkCiS0+azudGd9qjbxYeFX?=
 =?us-ascii?Q?j97dX9/ZZsq1rRL6EjeUPVx8yPK2DarnX8jALeeKLaBetUMcruOnVIplz91E?=
 =?us-ascii?Q?lu0YCZZrxgrAc+3lULiDcJ+9eAh0dtA0ARKbdzV9S15dCg11BVwYwLFL0Fne?=
 =?us-ascii?Q?exRzCfnLAokbY1nHs7UGGP+WbTQXYrkC2EyS9rnfjGostY3Au+8lNh5k46pj?=
 =?us-ascii?Q?zpPx6MV65hS7ZH20Xu0oZuGh/Kw7FKuz879a4Xb0c7g1t7Q8YOfm1LjixnG4?=
 =?us-ascii?Q?sF1RGpXic1bzkzpkT3ErlaRi4jCV+42B+B4HGK/Jj1Olf3j/avotZ2/GQBca?=
 =?us-ascii?Q?wN0H/wviIs18OSLPZJmUwiZl53J/gSwFX3GN62nVetsX+Fma4vr06yRh4VL5?=
 =?us-ascii?Q?yfsWwS8rP/vlodcFGzMgPKXYM6UDz3RG5c7uWdyL3NBae9svKiYQ6m4m4lAB?=
 =?us-ascii?Q?9F980AAc+xTUiR7u7xmbFIyka/4dTX/W6recar1zwsKDKAspHqVITlptMLyR?=
 =?us-ascii?Q?7Iz+BB58XIcPsC39y6L3xWW//iN3DHGjQMgS94upvxyNmijWvqbW1JWDg5SL?=
 =?us-ascii?Q?AfrpKznoLCDq63lulVWAkrZlDE3CQ7QyV4JZeLxsP5KDdDsdYN1Mk6j3qYM2?=
 =?us-ascii?Q?YnijANjl8iMrWai2tCGuFTP1qO1r7vw1P0yHFtGVhU1XWpgf1CoZcLNBhnwf?=
 =?us-ascii?Q?pd7QPgb0RlyYd6/+2NPjrYQ5riczmUHV+fWcyfmgVOJQtI9aykCjS4UhKJIS?=
 =?us-ascii?Q?yPKlRwXIPQjFtqL2gQ1JFIHQpYd6Klex92Ty4MZDOaKpThcZYYC5AFfntXFy?=
 =?us-ascii?Q?r55IpZwZMjAjf2W1ot7eaRdm/kvM6SV6/ghF+cxzwM0C0hT/mHKrGeA6Fyie?=
 =?us-ascii?Q?dwyWGXE/L08Fnj3jty+P0suBiqBg/FYx7+k9CwlXtFKA0e+mAqXBxbThOLym?=
 =?us-ascii?Q?sOrr0ktloee4qLbRvWqbfOvhHWmq0+jYbGzKmdOpZZeV4gi6yZ50rse2PUUI?=
 =?us-ascii?Q?cM7nquW21vgz/2LjmYvwUfsS27f765Qzbf0Ds2QP0dXS1nj99ghbXM7aC5dg?=
 =?us-ascii?Q?ur2CEA0r+O6lkuSBJMt0nzai39DeVqYPfuOlGJk20/ku1ZwO/NX0Nw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:42:10.4064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5af011a-c664-4b1d-c438-08dd1a3d6e70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011

CXL PCIe Port protocol error support will be added in the future. This
requires searching for a CXL PCIe Port device in the CXL topology as
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


