Return-Path: <linux-pci+bounces-34829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D7DB37725
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE7D7C4654
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2AB1C84BD;
	Wed, 27 Aug 2025 01:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lJWngTzX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA921D3F4;
	Wed, 27 Aug 2025 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258684; cv=fail; b=NUofWxOEjKsY/0HUTNQiGJaXZAoFZ/SvSPVV7n4XqVf1s98FoRbJgYKsbIXSh1t3kJj4u+s+jlnA7USvNEgsIKd9L+su5Pcj+CnWTU0DqyZV/GnLyTSzeituDcgl39jwwXcI3nRJEomPTE2zP19djUqzEfCQU0+LIMXOdww+AXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258684; c=relaxed/simple;
	bh=bQ5FKxv2FxKdj9HOETfBLydO3TfXi29R8d58zIt2yus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWVVfflx2yJcW6084ikb2XucadIEBG/Co0ZDW0PLgMkK7b6zoPP5dkaTMPo4CAzliJp4vAf3ExQef4E+1ypNpZ7gf6TSEpMswHAIlyvjHrPbMsXF6ufHDYXPemTUz4gsUDFcE48ogOCgADJyZMDDRj4sk0wr3iGxNBLRRiq7CZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lJWngTzX; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE4eNAAoiXdAAoRMFgEUGEVRlgcMRXwqfEEP4Wxwj9xyzbMdbGCc1LVqLRIgLBftMnyRqVzRQMOe/35xuHAMq6j5Hk4QhnWzMiG/yG3sdFRmA5rVTaEge2fsOR02GHnYrqfjzhOZu3zvP3CTf2OxoxbaQXwRHn1zqZo4lkDntVWUZeSQEZPzH1fI9S8nbufTlSorCJtnZPx6jQ9YlkHWjEjeW88Hf54UDDO6z3OuUe6B43hN2etFW/GQ8aHH4+vaOtGrV5jlECxZTOG6H5v/x/Lz61bcrvbVN/jdInmDzIo5k8kwPXTG4Wtlen4IjeWc5FfVDH6T3yh2JcA+7jQ9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WB4lmzpvgKKlxld3nRnQgC+Zs11d87ebkHJCPRYvYRs=;
 b=Nziua+Z8HnZblyAA2LmsMmKjFDjSB2ou+ASwe5+ThDwYmEzRfB3cFvHYv4QNgQtB3X7Rn3sqxJAOov9/sH3wQqIymdhl5i1PFI8C4Z8p4aQ7iqMDIQuCIA7xTNH/u43VN6Zvb5Ma/mJBSLKFySB32e/kPsOc2pCDbr9eeaUrjDDOnQevHl8aC3+tE4c0T7TiWnZCzjO4Rr9JrXFj6VrP1BTw1JgFdS3RzoLkzfeCLwMypr96PRH/UNx1Pu+BNpQtJN20WJo4X8uGQ3XWx6ZCQ/jIDD+i+XZSau7Fjh15tvlZknJyerCjZsdg8///vKFznEOCczDWO0GRwRF4rDp73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WB4lmzpvgKKlxld3nRnQgC+Zs11d87ebkHJCPRYvYRs=;
 b=lJWngTzXkkshY2EOxXVleV5A35O8zn69dsw1RpJKzKP5KCI9B+wbB6PBeRYggLhOVFpPuj1HY33FU5GiL8FgKk4DxR8F5nfJgZbzVYQFrCHmxMztrJkXxZgBbFKRkLvcXXRf6PYhX+9ewUE/dhVmeVfp8rus2/G1ra+qorR5nvI=
Received: from SJ0PR03CA0110.namprd03.prod.outlook.com (2603:10b6:a03:333::25)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 27 Aug
 2025 01:37:59 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::2) by SJ0PR03CA0110.outlook.office365.com
 (2603:10b6:a03:333::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Wed,
 27 Aug 2025 01:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:37:59 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:37:58 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 12/23] cxl/pci: Log message if RAS registers are unmapped
Date: Tue, 26 Aug 2025 20:35:27 -0500
Message-ID: <20250827013539.903682-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b390d8d-cbee-404f-8e34-08dde50a5ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uX7NjawoRGE7Y6OMmlx1NFABVZDr3MYgahlDau6rgjazQwiviNm+jts81d47?=
 =?us-ascii?Q?Plg5OGRrRLBzlmD6lR8kAJzuntEUa99bCW6GtHxNcdCzigx/RrfyDD0Drt5P?=
 =?us-ascii?Q?YrJjVSWweegjHaQgGit9GDP6Q6lpAZk9+9W2M0PouTQregDxfPOshJgqyE75?=
 =?us-ascii?Q?YsZEXEwVfw/UuRZg8oaDWGTq/ETZSyW0o0KTHdIV9g5clkT5MYwu1ZfsqxCp?=
 =?us-ascii?Q?nOgbt3GVzrl0iJ5ovbtiWW5EO4n1yLCUvTe92HdCBMwHP97KFv9FvL299WAl?=
 =?us-ascii?Q?MNxNefqrN9iTSmFm2MANOqOa/iXkkZysCIzu+ag0NcUrq56vc0MTU2ST0QVH?=
 =?us-ascii?Q?zMw81w3MStJ7/dVs9I5hrJBTcWLgueiPvllIaMeDfWN2HhlKgVmIY5vp/BZQ?=
 =?us-ascii?Q?ynDl1DEeeU7n1T/cyme0GL2yc5G80X+8JfPMHD+YU1pL4OUzIdkUECo8dYZf?=
 =?us-ascii?Q?0q8PnSxc9/I8MqdAt5uF7DMNXzy7s7RyT0geQHPdgcLHEdaY8rSpmv0qq1oX?=
 =?us-ascii?Q?RL6IiYz7yhndXqMYDmE3w1GpDcQkOdBm3cvohUDI19wG04N1otRApzC9VgKw?=
 =?us-ascii?Q?WijpGYunnkAczvBxcVyBgYNGcQlwSUISZhHRJxFY8r8kxIdNh2SMD42h91Fw?=
 =?us-ascii?Q?7yzCWmcyTZYxA+8fZZXJXTm/SoDs9RwklU9TfDQdCoTlHXRpgCSFX+OmMjy0?=
 =?us-ascii?Q?HlPcSzR/HrJFizhsjqC2OQkKVkQHNXCRrlIL5FgYBGUf8O2XZFHIU4YrRYfq?=
 =?us-ascii?Q?abPOd9sIB1m3U0WcbQoo/iFTzH/xGWb64nJ4h8SVMa9Tk8itqNCMM1hveDUN?=
 =?us-ascii?Q?JhOQ7WXuni4Rp6PjLHOxqlVDuPly+IPvT/NhcrLWbBnubPXxPl4jUjnI4QIX?=
 =?us-ascii?Q?L/94uEa1zd6HbHvoKGyw3iXB5/KfuJZNDYHERWngIVAbxeu5dWPqcc1Bw/19?=
 =?us-ascii?Q?+zxzvaoBF1B4JDAddVoriLdX/IKanwahqSpz4TiF1FhozYPT3Te99AxSriVB?=
 =?us-ascii?Q?JJTrlVQdWmIkkxDOnFrPAoGtE6CPN0d9jtZDuRPLDVon2pAtjVZi95hMq5ir?=
 =?us-ascii?Q?JhWPHCFTuJK6UsxKHtL4hR26gLuoteR9Tq1KJ6WU9PvJcHn+IopTXW03UvlR?=
 =?us-ascii?Q?nd5kot+CBzwjP30sZlWR4eUj9XLyGkDnDyKLVEYwcrXxi4XTByiPVkwnTiHL?=
 =?us-ascii?Q?rEaNu53Ja4OJtDZ6BKVS9+yuknf9CkhaHienZQYY9FIwh024tZrIG1/PQmp4?=
 =?us-ascii?Q?xk28TbiRPQGOgF3JqtECTDiba0P45iHG6Ps9fH6pinYhlCmk+DbHwsXs6wjY?=
 =?us-ascii?Q?cdNAKdIuhCivACeu5/0iMo5aaCbUuNgGStxAQgryzEHKG5AIn3gkJeRqFhE7?=
 =?us-ascii?Q?VnFPKdFPOOkHKqK4doxzlsqsjgcmfcXzDHNkdyKnc4rLGVzAh24/fy+335e5?=
 =?us-ascii?Q?71WLjvbRu821iuAjGEcL8/NIOh9esqJY2QCkcSQ9/P8IS+SUP0jeuHTQFvLd?=
 =?us-ascii?Q?yNdWGTiYX4sUWjwohI0PUkdpSwlmWftsFp6g5SPwwh5DP7mMc5LcEQsQzQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:37:59.2759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b390d8d-cbee-404f-8e34-08dde50a5ae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379

The CXL RAS handlers do not currently log if the RAS registers are
unmapped. This is needed in order to help debug CXL error handling. Update
the CXL driver to log a warning message if the RAS register block is
unmapped during RAS error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---
Changes v10->v11:
- Added Dave Jiang review-by
---
 drivers/cxl/core/ras.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index f65557e7bfa6..3454cf1a118d 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -286,8 +286,10 @@ static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return;
+	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
@@ -325,8 +327,10 @@ static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
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
2.51.0.rc2.21.ge5ab6b3e5a


