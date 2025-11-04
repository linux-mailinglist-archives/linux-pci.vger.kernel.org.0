Return-Path: <linux-pci+bounces-40167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD1C2E88A
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC01F189BAA0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E4D76026;
	Tue,  4 Nov 2025 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PMKcZqzD"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C71C41C71;
	Tue,  4 Nov 2025 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215136; cv=fail; b=Xt2q96MnhZR8co4/JXnQFd1i/7W9Zj/K3uzqyodhUpYoSZWBQ2GVHtO78A5BE48c/SBSsWKU4JAU56hwJG3hzs3sTR9o/9jd7GP8grlq9ycZvA/UMEuwe71sJRVAkwIJEFDMnD6q+1oM0olxlhsU95aHnLlK2JairnCu/hnR1f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215136; c=relaxed/simple;
	bh=rIaav0Xf3rr1bOJEk/GlTvkt+qSvdPSvgi2lfd+TE/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLuIOb+Gry4/XpS3olG+dtl3TToaFQ3WxEaJlucYWIigWhdHf1XNJAZlyFEkE8Jj6PQFi/ah5qoNck2ue54bqZWE6LgJtaJrx2356UMHWoyiLJz6vmk90WqCJQEhH3C6ESBq+F0qKsNdvbFsGWuFzN3NZfBzcZX/dqr6B8nYaks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PMKcZqzD; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TD+LazXxdOz/NMrvvOANomyJhiR7SCalqfwWv0oK4UHYwYVofhqVqrJKH0PCy1Th+/CUvdq8CvnhUfQgyGV3xrIZu18WF1gpy+Zt+A2oNwJTDDFlK2dmwPJlIehXymT4PYolQ/AClq6bYo2SEp1lhzIIUufO9rTGyZ5Vnyyebdz3Xnl8YXQr+eO0AR79B2ugRQSAN/fLDZ8gPmBvnpYzW9VG16B8AqUqn7pG3k7eBucXEy9Mb0phTdxbqerqt5tK1m6f0HX5mjzfzyds6ErsZPKAr/5/6Q4PeafMW218KdIHbp2iPaPbyrspGdoUcKB/eh8+YKZvz1YSjO4DhvBHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzqxRtnjRENW6FF3T8ZDiGue286gp53VQjtZK/uW3Mk=;
 b=cHw5HGi/32seApiDpE1JUS4UCJvX2AdxlY/MNjs6Gj4mdU6rM8KoYm/gxxj7oQXNMHzQcg+fPXvSVlJN6ggjRxknA8TElZfUeJoMGObpkwxIwhGO4MkRna1ZcOS0KBz8NcFJw3v1PASjhG7urqcEPXDQvnLLGs8XOHQCQJOxf/VUlLSY7VwwGUDBjVfOxXNz0hmiwgyCTnUpWrqGqAVWogXex7imjNpfNUBnT7EtBmv0RcUl7KQPBPVZyRBQTbS1YVa03YbXl4kifkpK2sa2XcEhx6fGUbvV2ekawCRYdy+eQQA2Ur8k9S56H5Jq9BpUnOTQuCwRxiYKHGYHAThcPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzqxRtnjRENW6FF3T8ZDiGue286gp53VQjtZK/uW3Mk=;
 b=PMKcZqzD6fyyG2QC4FnMyBnqFBRVtU4hudrIXFflncJHgnGrn1ET2V2DaTRGyU5ABEuygZr3A5aek1PtskwQPlHHTy8YD6Mfw7DgP1AM5zY0UxqpcDeairxwY67l1jXHo8Yn1lHebO9Rfxnmwx06QdU7JThji2btWKYdY4GAG6c=
Received: from CH2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:610:5a::30)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:12:10 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::6a) by CH2PR08CA0020.outlook.office365.com
 (2603:10b6:610:5a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:12:09 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:12:09 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v13 11/25] cxl/pci: Log message if RAS registers are unmapped
Date: Mon, 3 Nov 2025 18:09:47 -0600
Message-ID: <20251104001001.3833651-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 15dae109-f1e4-4608-7663-08de1b36cc2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?db7BGcV9hcP4n0Dlnzm8G5sl2MPrV07Fpw1fQEdvE06DNeF09U2nttGkFS79?=
 =?us-ascii?Q?Av82i3b6sxsD3Kp5axnuv8+z/SnTs9mugWt/XZSnZMvBl2g2898lW8YkfUjQ?=
 =?us-ascii?Q?g7G+pOY/0xmXzcb00fL3ldjthxWn+VAL57WXfUCYw5YtQ4w3xR1JST8cclwu?=
 =?us-ascii?Q?ZTlyOuNR18sChOsHDlbuJhehlnRy9+1TaPE++Tenf5wcuc6/sDOxwvLovTan?=
 =?us-ascii?Q?7M+pVFYulGm+PAEzFmGK0MhWTuW89+ailZKlgbVpBXCVKRFnEMNH0Pm4QEil?=
 =?us-ascii?Q?z/PveBu9YzRCj54NtcihOoWqobzTEuc0W9GV5iylzaYp5IU0Gudxpy5fBRto?=
 =?us-ascii?Q?z677uYgXkd4Spi/VZBmHfKv5itiI6Aj8S6ZvoTq8TmhwopbuYYyvUgQrH+R9?=
 =?us-ascii?Q?dAjkw8LZzIRgI9s3ju7wjhOHNJbHBABAcNybuWoAGBN/jkRiBDe9imeLyizR?=
 =?us-ascii?Q?JPWQ1J1XYIDKyFzpVb05kUdiFHkGiFBb90Vx843A4EtU2aGUmw7u5myySMjT?=
 =?us-ascii?Q?xQoRNml0Li5EjSGvb+XoznqOYHWPXEjXWoC0PWygqsOBlBEbvLHuT9CsGFKP?=
 =?us-ascii?Q?KysNGhg9IszwSwpyrUUGJxbXIVb+njMwpxcDyrapPkZHrr7IS/dFzwuQngDk?=
 =?us-ascii?Q?MGaWw9pVr00OFFoaqZX1Q6vvl9foMgo03r5K/x3PtXxEoquXud+MN9QNB5Jq?=
 =?us-ascii?Q?hT3oX1SsOJ04/HykwOoiTG4tB8P/3UBL/N9wvZAtK9G0aVIhlvitJG1Sh617?=
 =?us-ascii?Q?pKNVVop4txFXEIBhN4OGHILjsY7HU48okKjviW+yhrhXMFgB/MaGgqGaHz4o?=
 =?us-ascii?Q?7DJXInGFd6iJhB5TeM2ROsnk7FtitZpKY7G0ZJl0ZQMs/JaqZUYVTrhzNIEp?=
 =?us-ascii?Q?TEaBh+LJZKQomAH7uqSNI2v4U14ZktLCCdDdF5GrrH8/5P/7gUQmC0fFBpO1?=
 =?us-ascii?Q?1Jzxt1+V46JAqTYc6Gy2PGoiTfS7BZbhPZb9/PP7YrNODTwPLoSrZvTL6hMI?=
 =?us-ascii?Q?J95fp0HIs/HmVlfY3top3sz+qljdNCEgg9RFkLPp2RBjFdJveUfdGbzg9jdr?=
 =?us-ascii?Q?d1Xuaz8VEr7l5z0uqpLJH0WNP4CO1vYAJnVliPAJ1lK6V2tDSs+Za6Oy1sKv?=
 =?us-ascii?Q?wBcR33uKucY5y/yOfed7ynm9wP/zcdnINv9hsaD2plUigdxCUl+NWNf/jnio?=
 =?us-ascii?Q?HOHLM3IoY37ZDH+7IuuiC2JUa1L5tNoLf3ixL5HbACqrZyU4Hq88JLXLLzlU?=
 =?us-ascii?Q?eLJFI32gG2R6HRT1MogP/jxMR0Yzsx4ytSfPSoQprIp+gfuL+Gx+sLojNer0?=
 =?us-ascii?Q?aM7kMNdPRBDkv0bI+JqokW1ae5n7fVEICoYtwedCf2vLI6efwCCeFvG1CA8f?=
 =?us-ascii?Q?3ruUKqsi0ynhMd061ahzglyQJflP2eKdzh+b0ZZRjMpomrYjw/uz+1YYPNP4?=
 =?us-ascii?Q?zpz/vvF4yNjx4GzisjNon/8qUTIB8YY6HzJYuq92DXqNDYlKnYryUjR0Q4RT?=
 =?us-ascii?Q?FZbigU8e6tGrWF8zz3JR4075IpB75N+X7Fivez+2QBt/M+99TLsVk+Rxox9I?=
 =?us-ascii?Q?3f+teemxRZmI8J8Xh0X9FEVa9ogf8KG2bAYEmVus?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:12:09.9707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dae109-f1e4-4608-7663-08de1b36cc2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360

The CXL RAS handlers do not currently log if the RAS registers are
unmapped. This is needed in order to help debug CXL error handling. Update
the CXL driver to log a warning message if the RAS register block is
unmapped during RAS error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

Chan ges in v12->v13:
- Added Bens review-by
---
 drivers/cxl/core/ras.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 72908f3ced77..0320c391f201 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -165,8 +165,10 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return;
+	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
@@ -204,8 +206,10 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	u32 status;
 	u32 fe;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return false;
+	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-- 
2.34.1


