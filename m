Return-Path: <linux-pci+bounces-34825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06746B3771C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04721BA1072
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897421C16D;
	Wed, 27 Aug 2025 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5oDeVd/0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8301F9F73;
	Wed, 27 Aug 2025 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258645; cv=fail; b=WAkb0uVN4zFk9Eb9Q3Err0MsVMla9VqgyOt6bTdzi767Az1sekNZMgeIAcvXiMzz7fk0bV8XckJX6eqscJOVNp6gfmG7pk0sERn65tel+idw0nsGgtyaVlwvgPHUNekXZSlU32RzY4hk22PV008ivMNc3cEY25p4e3c3IcJltK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258645; c=relaxed/simple;
	bh=zX9QmtidXg3lRgTIwpV0L9qtuJQEi4bpOWZSaIIB8t4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqiFjpfktx1aW35LrFEKnkX6TwrIeycfX39xgKVVF1TsW3PdSU/NzvuGo9dZjXy78pr9LPlZeMlGkH2CGcsNwk4gIADPejBtpnO1WCPj4J4YY2pOaMRCsXpG2fgbTw6yQgY8DbHqyqIS78uuOjvEM8j/pUNhttu8Q3XWHZvD3u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5oDeVd/0; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrlNYVmRGj+L4YfoKH1Uo+/lnmFQzhpPZHf9ij9YuvVdYEh0YmLb/kUelb2z22BZtYvko1Ta5EdclfQW82vuKUgxF7MsVJDtR1uz+4QzfhOrO4vCIEwYTbRMXq72jVH9Q3ATS8C3T/qQa36CryDYS/tqVGqwQMV+e5qSbCUZqp9n0j+PbjkeBGWfDkR4vHjNIXkLYBFrDMV/m5mW6Ae9/IsAJOvAFf+BabasRVfQIRWMHI2cFJAqasAxWvp4FgjCScPBY/japf8ORfDdwmaSeqLMAQFwUfD4ZsauuQMqZQB+yp/nE0vfuR/k+da7Bokc5vzbDWB/5ixc4ImLj6XRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMlyy4d47/132lWN7RhzC01bcQPc0DbOy1O/RIKJcSM=;
 b=NmSgC1d1AyeJJWC+nmfDsvZTiHOSbyYqroOuXbvbDwosRp7tSWPNQxK+XHftYqLzAWO1Iztt+V2rTFphYmYybtsEPYAYBPbuE21mC+vKUjusDabxkq7yLMt6wVO+kgWdUdDv7i8F27Y2PxFqzFQaDPpSypVg1b8Zqg5svC/zGn7L9VkgZi1G2cKiu7hw3UyRGWdwRd75Yi7UiSkXLMeRW5/k9t9QiTRt73ChvDiAfMz9lYAyDF+LQUCNVv69fnc58XEHzRAq5nY2IJE22H5I8y2vagaVoacYr868/RzQ7BpVZGbvXi4NDlY6jwCPvzNsIMnpI81pmHUhoUQrgpz2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMlyy4d47/132lWN7RhzC01bcQPc0DbOy1O/RIKJcSM=;
 b=5oDeVd/0r2xjYarHTxtCXRJxXUeUWQKcNfevCbs6HAW7n/rK6EMOTOvGQhIfDtA36EZmPvFIvQJnXdbYyJ21xwUMiKRsh25s4YhvUcxEvPi9xcRrCnqIhh6Ro6Taa/gq045cFPqX3U/REc72u7AVFirTJcmETDQ487+uOUHpl20=
Received: from BYAPR02CA0052.namprd02.prod.outlook.com (2603:10b6:a03:54::29)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 01:37:12 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::7d) by BYAPR02CA0052.outlook.office365.com
 (2603:10b6:a03:54::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.23 via Frontend Transport; Wed,
 27 Aug 2025 01:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:37:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:37:02 -0500
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
Subject: [PATCH v11 07/23] CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
Date: Tue, 26 Aug 2025 20:35:22 -0500
Message-ID: <20250827013539.903682-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: c529a13c-b439-4fd4-b961-08dde50a3ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IsWvUZER3vpMErw51Dgfokkqe51UEL6QNTKvh4LkNWV9sVfE63eWHkriVBJT?=
 =?us-ascii?Q?fmXEbLmfH1tmuMT0dtQNuUrxBW8rtqYRpN6ijai5h3e8X/8E/qWtko5YlKT5?=
 =?us-ascii?Q?wKJE6/KVGbEOmUEklDD/+u/BOFI6YyfbNyBgiZizKKq+oJUcPkpkCMvqJ2jK?=
 =?us-ascii?Q?yvWt3f6Ar+0dznQOo03S0tTEkPdUXvn0sZpOBzTkkjixyApluT2gSFtSt/qT?=
 =?us-ascii?Q?uCDF6Lx3WJPBpDMPQMnzSiwM+n4Jgp568k+WyBx/u79UFqCY8YF/2GKTCKsA?=
 =?us-ascii?Q?rLj3HBAk+XinssTtkQ/7B64N0Y5yWU3bIBgLlLvBMSAil+ISBZBoViBMTJNa?=
 =?us-ascii?Q?P4HNITnSANJJm5TyZESxe3hTnd1wqsowUUSsaXP2FzO/kXtnmfo2MO+YKgRz?=
 =?us-ascii?Q?UedRynNqGHMrJ+4bHP7dtC5Ach56ujIdB8YRc5yTiXS0vjNl0Wg4uwRe8igA?=
 =?us-ascii?Q?Ztzu3fkSnMPCFPRwG0/VB8568DIfTKn5JhAZyaqQ2IabyHh3jBPn1VRCtE8O?=
 =?us-ascii?Q?PL1Mykc8uhzLaDL2tyjYSut9+zY+Xc0GQ/K6o4GJkADT7bIPDb4e5nLC4HXP?=
 =?us-ascii?Q?c9+My5ybbSRvKFGPBLRae9jWQrVeFJlPxP9Wncg8dCkL7wOlTXqV4HRETIxc?=
 =?us-ascii?Q?Up7mxnG4hUTqlBG474Gn/z4JYRNj+nseN6WXV/eSGZFYkEbb7K+QYfXQ44ZA?=
 =?us-ascii?Q?5RkTEFlJoODerwaL9GXmwvIoWtSjldrL41c5B/H5xQkOLIUStUoaCVTUQpgc?=
 =?us-ascii?Q?eD5iuX3bXyPCV6DpevJ7Grjva/Dy5lr1RhszAsBhTeeYRkAjW2koyZ7KDLTs?=
 =?us-ascii?Q?08LAJgVDgdr69urT2gMvTqHGfAwyCUcGX8bkMRbUA0D+AAAf1/H8bQi0mAhS?=
 =?us-ascii?Q?HaMa3QkUa+kQE12U5xQyCdNzd7IX6ifpoksGzInWoXjsdVBZ/LwWl+Lbug2w?=
 =?us-ascii?Q?ZfJA3le6nscGn2LIK6KPJROPuMa1PqhF9MwRqe5dfoVR0OQ3FRmqlepUPFpu?=
 =?us-ascii?Q?9L3z7SPrTZLHAWiHgCaxMjb6gf3K2KgqQBa6x8YI+pSnMNH30cBHPX/BNhMk?=
 =?us-ascii?Q?YceXGWJDqCRb8ukE+J+FGXwGbKKbWzHAySH82OJ5JAkpSXYSQR+iWeUM1qWc?=
 =?us-ascii?Q?AiIqAVSiqeqXQcpml3mskiwcGHbg2VJ8LCK8txgtvmZX6I1fl1Zt3ZdkSYRp?=
 =?us-ascii?Q?rgk1j/yb+jN1pVIBHbWTYTvubqoBSDN70YMY7WmsX/XqCxfk098so5x70YEn?=
 =?us-ascii?Q?DAhRTW5eHCUOk60kzf03SidawwHaijQtJF/s+UhffDkbykJVypWKjDeJQbpr?=
 =?us-ascii?Q?ja5Mv51zDTmM+4Sx2O0huNm+Ajg1TxwpkvqH0AjfwJu6IMgkdQ4x3zxav5kd?=
 =?us-ascii?Q?Eu73IkRt+/8tM6IxldAUCctjJDNNnQWsCoKOmgLFwN93+06HfXQIF91EwQBe?=
 =?us-ascii?Q?mQk7rKYApTK6EMAEMapavPY8KF/2vFb9c2Rrg735a+2QZoA2M/9AXpGde9Bb?=
 =?us-ascii?Q?LsrgOgifP1u9Z2AKo3K1fHXvAhZKdCHhzqaWeDQ2IansqFTWXQm/gGKN3g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:37:12.0100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c529a13c-b439-4fd4-b961-08dde50a3ebc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553

The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
accessible to other subsystems.

Change DVSEC name formatting to follow the existing PCI format in
pci_regs.h. The current format uses CXL_DVSEC_XYZ. Change to be PCI_DVSEC_CXL_XYZ.

Update existing occurrences to match the name change.

Update the inline documentation to refer to latest CXL spec version.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c        | 62 +++++++++++++++++------------------
 drivers/cxl/core/regs.c       | 12 +++----
 drivers/cxl/cxlpci.h          | 53 ------------------------------
 drivers/cxl/pci.c             |  2 +-
 drivers/pci/pci.c             | 18 +++++-----
 include/uapi/linux/pci_regs.h | 60 ++++++++++++++++++++++++++++++---
 6 files changed, 104 insertions(+), 103 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a3aef78f903a..d677691f8a05 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -110,19 +110,19 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
 	int rc, i;
 	u32 temp;
 
-	if (id > CXL_DVSEC_RANGE_MAX)
+	if (id > PCI_DVSEC_CXL_RANGE_MAX)
 		return -EINVAL;
 
 	/* Check MEM INFO VALID bit first, give up after 1s */
 	i = 1;
 	do {
 		rc = pci_read_config_dword(pdev,
-					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
+					   d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
 					   &temp);
 		if (rc)
 			return rc;
 
-		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
+		valid = FIELD_GET(PCI_DVSEC_CXL_MEM_INFO_VALID, temp);
 		if (valid)
 			break;
 		msleep(1000);
@@ -146,17 +146,17 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
 	int rc, i;
 	u32 temp;
 
-	if (id > CXL_DVSEC_RANGE_MAX)
+	if (id > PCI_DVSEC_CXL_RANGE_MAX)
 		return -EINVAL;
 
 	/* Check MEM ACTIVE bit, up to 60s timeout by default */
 	for (i = media_ready_timeout; i; i--) {
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(id), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id), &temp);
 		if (rc)
 			return rc;
 
-		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
+		active = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE, temp);
 		if (active)
 			break;
 		msleep(1000);
@@ -185,11 +185,11 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 	u16 cap;
 
 	rc = pci_read_config_word(pdev,
-				  d + CXL_DVSEC_CAP_OFFSET, &cap);
+				  d + PCI_DVSEC_CXL_CAP_OFFSET, &cap);
 	if (rc)
 		return rc;
 
-	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
+	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT_MASK, cap);
 	for (i = 0; i < hdm_count; i++) {
 		rc = cxl_dvsec_mem_range_valid(cxlds, i);
 		if (rc)
@@ -217,16 +217,16 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	u16 ctrl;
 	int rc;
 
-	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
+	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL_OFFSET, &ctrl);
 	if (rc < 0)
 		return rc;
 
-	if ((ctrl & CXL_DVSEC_MEM_ENABLE) == val)
+	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
 		return 1;
-	ctrl &= ~CXL_DVSEC_MEM_ENABLE;
+	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
 	ctrl |= val;
 
-	rc = pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl);
+	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL_OFFSET, ctrl);
 	if (rc < 0)
 		return rc;
 
@@ -242,7 +242,7 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
 {
 	int rc;
 
-	rc = cxl_set_mem_enable(cxlds, CXL_DVSEC_MEM_ENABLE);
+	rc = cxl_set_mem_enable(cxlds, PCI_DVSEC_CXL_MEM_ENABLE);
 	if (rc < 0)
 		return rc;
 	if (rc > 0)
@@ -304,11 +304,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 		return -ENXIO;
 	}
 
-	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
+	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CAP_OFFSET, &cap);
 	if (rc)
 		return rc;
 
-	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
+	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE)) {
 		dev_dbg(dev, "Not MEM Capable\n");
 		return -ENXIO;
 	}
@@ -319,7 +319,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 	 * driver is for a spec defined class code which must be CXL.mem
 	 * capable, there is no point in continuing to enable CXL.mem.
 	 */
-	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
+	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT_MASK, cap);
 	if (!hdm_count || hdm_count > 2)
 		return -EINVAL;
 
@@ -328,11 +328,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 	 * disabled, and they will remain moot after the HDM Decoder
 	 * capability is enabled.
 	 */
-	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
+	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL_OFFSET, &ctrl);
 	if (rc)
 		return rc;
 
-	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
+	info->mem_enabled = FIELD_GET(PCI_DVSEC_CXL_MEM_ENABLE, ctrl);
 	if (!info->mem_enabled)
 		return 0;
 
@@ -345,35 +345,35 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			return rc;
 
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i), &temp);
 		if (rc)
 			return rc;
 
 		size = (u64)temp << 32;
 
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(i), &temp);
 		if (rc)
 			return rc;
 
-		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
+		size |= temp & PCI_DVSEC_CXL_MEM_SIZE_LOW_MASK;
 		if (!size) {
 			continue;
 		}
 
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i), &temp);
 		if (rc)
 			return rc;
 
 		base = (u64)temp << 32;
 
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_LOW(i), &temp);
 		if (rc)
 			return rc;
 
-		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
+		base |= temp & PCI_DVSEC_CXL_MEM_BASE_LOW_MASK;
 
 		info->dvsec_range[ranges++] = (struct range) {
 			.start = base,
@@ -781,7 +781,7 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
 		is_port = false;
 
 	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
-			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
+			is_port ? PCI_DVSEC_CXL_PORT_GPF : PCI_DVSEC_CXL_DEVICE_GPF);
 	if (!dvsec)
 		dev_warn(dev, "%s GPF DVSEC not present\n",
 			 is_port ? "Port" : "Device");
@@ -797,14 +797,14 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 
 	switch (phase) {
 	case 1:
-		offset = CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET;
-		base = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK;
-		scale = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
+		offset = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL_OFFSET;
+		base = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE_MASK;
+		scale = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
 		break;
 	case 2:
-		offset = CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET;
-		base = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK;
-		scale = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
+		offset = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL_OFFSET;
+		base = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE_MASK;
+		scale = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 5ca7b0eed568..fb70ffbba72d 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -271,10 +271,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, "CXL");
 static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 				struct cxl_register_map *map)
 {
-	u8 reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
-	int bar = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
+	u8 reg_type = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
+	int bar = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BIR_MASK, reg_lo);
 	u64 offset = ((u64)reg_hi << 32) |
-		     (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
+		     (reg_lo & PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
 
 	if (offset > pci_resource_len(pdev, bar)) {
 		dev_warn(&pdev->dev,
@@ -311,15 +311,15 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 	};
 
 	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
-					   CXL_DVSEC_REG_LOCATOR);
+					   PCI_DVSEC_CXL_REG_LOCATOR);
 	if (!regloc)
 		return -ENXIO;
 
 	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
 	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
 
-	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
-	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
+	regloc += PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET;
+	regblocks = (regloc_size - PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET) / 8;
 
 	for (i = 0; i < regblocks; i++, regloc += 8) {
 		u32 reg_lo, reg_hi;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 3959fa7e2ead..ad24d81e9eaa 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -7,59 +7,6 @@
 
 #define CXL_MEMORY_PROGIF	0x10
 
-/*
- * See section 8.1 Configuration Space Registers in the CXL 2.0
- * Specification. Names are taken straight from the specification with "CXL" and
- * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
- */
-#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
-
-/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
-#define CXL_DVSEC_PCIE_DEVICE					0
-#define   CXL_DVSEC_CAP_OFFSET		0xA
-#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
-#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
-#define   CXL_DVSEC_CTRL_OFFSET		0xC
-#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
-#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
-#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
-#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
-#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
-#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
-#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
-
-#define CXL_DVSEC_RANGE_MAX		2
-
-/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
-#define CXL_DVSEC_FUNCTION_MAP					2
-
-/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
-#define CXL_DVSEC_PORT_EXTENSIONS				3
-
-/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
-#define CXL_DVSEC_PORT_GPF					4
-#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
-#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
-#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
-#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
-#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
-#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
-
-/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
-#define CXL_DVSEC_DEVICE_GPF					5
-
-/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
-#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
-
-/* CXL 2.0 8.1.9: Register Locator DVSEC */
-#define CXL_DVSEC_REG_LOCATOR					8
-#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
-#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
-#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
-#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
-
 /*
  * NOTE: Currently all the functions which are enabled for CXL require their
  * vectors to be in the first 16.  Use this as the default max.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bd100ac31672..bd95be1f3d5c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -933,7 +933,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	cxlds->rcd = is_cxl_restricted(pdev);
 	cxlds->serial = pci_get_dsn(pdev);
 	cxlds->cxl_dvsec = pci_find_dvsec_capability(
-		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
+		pdev, PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_DEVICE);
 	if (!cxlds->cxl_dvsec)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9e42090fb108..d775ed37a79b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5031,7 +5031,7 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 static u16 cxl_port_dvsec(struct pci_dev *dev)
 {
 	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
-					 PCI_DVSEC_CXL_PORT);
+					 PCI_DVSEC_CXL_PORT_EXT);
 }
 
 static bool cxl_sbr_masked(struct pci_dev *dev)
@@ -5043,7 +5043,9 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	if (!dvsec)
 		return false;
 
-	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	rc = pci_read_config_word(dev,
+				  dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET,
+				  &reg);
 	if (rc || PCI_POSSIBLE_ERROR(reg))
 		return false;
 
@@ -5052,7 +5054,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	 * bit in Bridge Control has no effect.  When 1, the Port generates
 	 * hot reset when the SBR bit is set to 1.
 	 */
-	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
+	if (reg & PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR)
 		return false;
 
 	return true;
@@ -5097,22 +5099,22 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;
 
-	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET, &reg);
 	if (rc)
 		return -ENOTTY;
 
-	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
+	if (reg & PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR) {
 		val = reg;
 	} else {
-		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
-		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+		val = reg | PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR;
+		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET,
 				      val);
 	}
 
 	rc = pci_reset_bus_function(dev, probe);
 
 	if (reg != val)
-		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET,
 				      reg);
 
 	return rc;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a3a3e942dedf..b03244d55aea 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1225,9 +1225,61 @@
 /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
-#define PCI_DVSEC_CXL_PORT				3
-#define PCI_DVSEC_CXL_PORT_CTL				0x0c
-#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
+/* Compute Express Link (CXL r3.2, sec 8.1)
+ *
+ * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
+ * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
+ * registers on downstream link-up events.
+ */
+
+#define PCI_DVSEC_HEADER1_LENGTH_MASK  GENMASK(31, 20)
+
+/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
+#define PCI_DVSEC_CXL_DEVICE					0
+#define	  PCI_DVSEC_CXL_CAP_OFFSET	       0xA
+#define	    PCI_DVSEC_CXL_MEM_CAPABLE	       BIT(2)
+#define	    PCI_DVSEC_CXL_HDM_COUNT_MASK       GENMASK(5, 4)
+#define	  PCI_DVSEC_CXL_CTRL_OFFSET	       0xC
+#define	    PCI_DVSEC_CXL_MEM_ENABLE	       BIT(2)
+#define	  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)     (0x18 + (i * 0x10))
+#define	  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)      (0x1C + (i * 0x10))
+#define	    PCI_DVSEC_CXL_MEM_INFO_VALID       BIT(0)
+#define	    PCI_DVSEC_CXL_MEM_ACTIVE	       BIT(1)
+#define	    PCI_DVSEC_CXL_MEM_SIZE_LOW_MASK    GENMASK(31, 28)
+#define	  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)     (0x20 + (i * 0x10))
+#define	  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)      (0x24 + (i * 0x10))
+#define	    PCI_DVSEC_CXL_MEM_BASE_LOW_MASK    GENMASK(31, 28)
+
+#define PCI_DVSEC_CXL_RANGE_MAX		       2
+
+/* CXL 3.2 8.1.4: Non-CXL Function Map DVSEC */
+#define PCI_DVSEC_CXL_FUNCTION_MAP				2
+
+/* CXL 3.2 8.1.5: Extensions DVSEC for Ports */
+#define PCI_DVSEC_CXL_PORT_EXT					3
+#define	  PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET			0x0c
+#define	    PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR		0x00000001
+
+/* CXL 3.2 8.1.6: GPF DVSEC for CXL Port */
+#define PCI_DVSEC_CXL_PORT_GPF					4
+#define	  PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
+#define	    PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE_MASK	GENMASK(3, 0)
+#define	    PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE_MASK	GENMASK(11, 8)
+#define	  PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
+#define	    PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE_MASK	GENMASK(3, 0)
+#define	    PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE_MASK	GENMASK(11, 8)
+
+/* CXL 3.2 8.1.7: GPF DVSEC for CXL Device */
+#define PCI_DVSEC_CXL_DEVICE_GPF				5
+
+/* CXL 3.2 8.1.8: PCIe DVSEC for Flex Bus Port */
+#define PCI_DVSEC_CXL_FLEXBUS_PORT				7
+
+/* CXL 3.2 8.1.9: Register Locator DVSEC */
+#define PCI_DVSEC_CXL_REG_LOCATOR				8
+#define	  PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET		0xC
+#define	    PCI_DVSEC_CXL_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
+#define		   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID_MASK	GENMASK(15, 8)
+#define	    PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW_MASK	GENMASK(31, 16)
 
 #endif /* LINUX_PCI_REGS_H */
-- 
2.51.0.rc2.21.ge5ab6b3e5a


