Return-Path: <linux-pci+bounces-14013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F96A9959F5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED9E1C21EC1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C6216A2B;
	Tue,  8 Oct 2024 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qHkAVQNJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A69216434;
	Tue,  8 Oct 2024 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425919; cv=fail; b=uK+rbaBW2XoZNQTRgHvgtVNFsDzRzI2Gg0hWwhW5PS7wK/tDB7iD6XWUmUDtuc2amtF/BRWUOhRtlu/6Zb31tTbFUcBTaFLdONtYyrTwJG2s5hDUTDdKFR1Ld+6c9lwoANJ/OlR/T1fepirstdpj5+8wXGade0wDfDg1ir7LTQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425919; c=relaxed/simple;
	bh=tWXbjlwIM9qNFbbcPhA4yhkUdCvK7+WU0BYTLWYNYWE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVcDK9PMtTyXJo0RfdT2dviyz1DajBXtUudpx9Bf5fm5mEF4qpDK/y/Cf2SADdRlLKokAQQjuVUOGYEFaBL73U0smoSYptObcxmDcnavVXF77nUSVqiQozu427lh/nmzUlipK8Mf/uLVRUR5vbEwpFrbmegU8PjRLhQ16bgb7lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qHkAVQNJ; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnOgsgtHwIMdgFt9UAHe9r9yq2BvoS6I3K/Iodj8cfKjFoHA9ByEgHtijADvetmhIBz2UibkeKi0AqlT9HdrTYfA59DbiDkNBOvB8coBb6seUqYnhACwwwedJ8z85L05PXblK0Wi2KgundwrBm/0XP7CPa5IXCL+utQ5HiGHAjjiTlKl8sozP3sQZPN4JbRKCPoqKQwt3bS5TBRplq4+d40gX9tdpPRxqKJgyMwOG8/TqgV/8qFlEJoEX3SMi8TAuLvZESzcsVYSRj8BBzujiqbUHINY0ZykVGwtLuJErgO6gdcqaIP3w8xuo/ta+qi1tgp/IZrMjubd4WF15hjDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C0kM8b0VZECq7tQOLeCsFwAlc0hBQXp/54ZKhCpVQ8=;
 b=D3Fa/0Ejr75IagB3ZfzNnN591tKrXdpTjpPoG2ASP8pwMOYPA/WLP9MBQWD4/WI271fCKJesbHXFfQWNlbgY8qhdDgjntO8KucX7yJt3ihAGbM222WQWkVA1wk/prAJAnfAVwTvBNqcN9fZY7XXBUaTBlWnZ3p6CNfzaBo3bd/8GQTcu32a2/Aqqngd0i6aBVbdBfmLLHJ1Equ2kAh3gBXXxQRnlovpZMtvOT1CGLE24StZE/JiGKJol+SHLQewcb8oQT5Y6ZzZT5bHUBJY6+KG2Q1TvoAFc48lHF+HHIdzW+XWLOaTWtqNPJyHJMLXpf/WkvqjzGJV7gZKJ7HGaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C0kM8b0VZECq7tQOLeCsFwAlc0hBQXp/54ZKhCpVQ8=;
 b=qHkAVQNJRzSEjIfOUUgiyzuif4BjrBvKWCtDrLrSPofYonqg1z+jDS1exdjI5tAMdWht5YSYg3/BNQU5mXSXRwWkHrtGrgXynL28PrAAkWbiDUNoUqdzgVTGj6xcjxFN9Db34uENUoNywetdQ26ccMQVbGqcl5vmSPU1gHdIm3Y=
Received: from BN8PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:d4::32)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 22:18:33 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::ce) by BN8PR04CA0058.outlook.office365.com
 (2603:10b6:408:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 22:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:18:32 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:18:31 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 08/15] cxl/pci: Change find_cxl_ports() to be non-static
Date: Tue, 8 Oct 2024 17:16:50 -0500
Message-ID: <20241008221657.1130181-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e84dd3a-8117-492c-7f87-08dce7e72527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AcFAKhBEICG4bYHq8PgXcHnsEYDkzstZkAokTIUYQPGxdOm8SK2UBKcGAfmT?=
 =?us-ascii?Q?d+FbNrQouKORs1XaBi4gmpPLvg/ZD1FPmMLx/Uo9U6RlomNCbgs6gZGD8hFt?=
 =?us-ascii?Q?RE1mtFTUNvSFl3eCcX2xM07ayOCX+snmY3VCsD8lv66mOFeZdYueQRZVsq4o?=
 =?us-ascii?Q?mjPwKU55CrbWDVZZUENPEFfEI2SvcmEf7VpMraWLYkbM5I2Q30lFPy4w5lfu?=
 =?us-ascii?Q?O7/tH8RhMK6tsNXX1GnnrW35MW5Kq5me8eISEbLBZBJbtFemNO7v0I8r3uVq?=
 =?us-ascii?Q?TMPgL8fvilR71XTQ+H+6Z5jgpyU3auDw6qPUe744gtEupq8NgiaufnDARgAd?=
 =?us-ascii?Q?qZ6u5/LdReyxMgOYB0eRT8Ob3NPaiO7Eu2eSqwFKYf0ToM2i4/bW+W3F+qlQ?=
 =?us-ascii?Q?Uxaq09YCWgmAz0cy7BM5AVTuX8iirHZ70waBsQAgafq9yB0TCssA7MqVZVUp?=
 =?us-ascii?Q?iPzaE7gnXDIilCrrsh3bjRuHWfF23G2iItmqnPf/Ug5MzXRrxVfBTng3AcYa?=
 =?us-ascii?Q?sX9SyFlLIaTVZWgjWwaC6Gn1+X5ABZRpW9CzDi8Bj/DB6JIEbhvXXwRo4Vjc?=
 =?us-ascii?Q?9svS42NFRv1hv06ZG/83FMywMtiTkh1w2WCiCmJU5ywtke/VnDEZHxIGTZX0?=
 =?us-ascii?Q?LTpdOSkVDTh3d06L3vxWPytffSYxVft6zi3EInppgZN8KPR6oJx5Xk2WUazh?=
 =?us-ascii?Q?+f3SiXT1mEXxdDGuQWG2Y4GlV0+CUDSOyffbTOBdjHOmVInHMMkuGn0hrO1Q?=
 =?us-ascii?Q?5Fo3h2BW893vXxxybB8NytfGLuJd/f2VEkoEs6OKF35G4+M4viEHkb1e1BN0?=
 =?us-ascii?Q?VdKCqmznTu+6V/703AsMamFdnerN5lzDLPTXMBGn9n+ExXjYh1BcB/4leQAm?=
 =?us-ascii?Q?fC1tmBwTX02CpKuLmQ8ClFu9g5AGhRpCetYxlGMhpif0f/gCpdxFcpWBRwQN?=
 =?us-ascii?Q?lO7vlpwzr8YvGfG0gFRYuJXpcNeVqaemkirfFFpRGH+CcwYPkMhIjQT1XcHq?=
 =?us-ascii?Q?hS++VutA3sgu/TbpqXBvD26/fvWCi73BJOvrlA2VXfTLgEC+HiXZzhDqukZ9?=
 =?us-ascii?Q?r4DifqvPzQwHm3idaOwZeZoWLJfSsxooQ7neH6m5mDf04Zaj96TY1k7SMOEZ?=
 =?us-ascii?Q?qOC8/jNNXMk/bAAWcchHSGAB04Zqu5JuL1cn7WlJboYIPMw+ieZBtQl2OkNs?=
 =?us-ascii?Q?PR0K85iIlnazQMiWfmXoXYTgS7YMU+FS24jgr8rQx7tD/qHj3ijPdAEzsRrE?=
 =?us-ascii?Q?SyemcDdNVhhe8Gk9L79AZjhw5NL1XKVRnr01a9F8rJJMpN5+ShMFw9QBvddY?=
 =?us-ascii?Q?ivDn61t7WNgSmsTc8Li0slrJASqnzTWBL8DW57mitSy+kWI6jraVxG32Jg7t?=
 =?us-ascii?Q?eNmYf4T2DxZ01pU+TuCSgaQbkrMz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:18:32.5949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e84dd3a-8117-492c-7f87-08dce7e72527
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138

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
index 72a506c9dbd0..14a8b4d14af6 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -108,4 +108,7 @@ int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 				       enum access_coordinate_class access);
 bool cxl_need_node_perf_attrs_update(int nid);
 
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..089a1f4535c1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1336,8 +1336,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
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


