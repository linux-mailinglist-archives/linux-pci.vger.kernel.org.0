Return-Path: <linux-pci+bounces-45005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A42E7D29AA1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 02:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03FD63061DE8
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBFE335545;
	Fri, 16 Jan 2026 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YOZ4DCJ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0FB32D7FB;
	Fri, 16 Jan 2026 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527749; cv=fail; b=gT7NV82BUsJU484cM7ZuA/Ee7AvV1eJD5DgoyParibsR19iR1YKqH/d0DyI802r2sJEDa0zqeKY98qVinO54/a5AmxEND2WBd+8+LIHnvU58ySjE9AGCFvS6qHhQLQ1Dgk2SFrZvmWLT/7lmjlDtNwAVDcjTh67rJvhgMA8tGk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527749; c=relaxed/simple;
	bh=mwxjrZo68YnPQAeuyug+e5V+lfMz0pVLDFxGNQWe1So=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5DK+CgffuxmzvdXltHtbH1ADvTGj7D2gO+xeHJdIW5lSsl9cucMun00loXNSdF7QziXIx4qd+Zmjb0Y/6cvqGjCZBJ2VjeYIEzMlDbHmj/nmn3ECqCUI/uI/z5UfChJi3u+F60ujrjn0AemlYEknQ2mJX6WGivJ1WvCiser4IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YOZ4DCJ1; arc=fail smtp.client-ip=52.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0W7ZwyjuYLFgfx/DMeJJvU+lcO7Um8JXAnlwUxRgple8s13eNV8Y1AXbSJGBBjfRrVx8MOdC2daTU1KKndfi6kCzpl4cTBlDx9k9E9E0hIyn0k6smysaFDBgF4ZeaBsKboYlVzMtAPw2/BPdxOgQqvZOcgSJrXjQ+QXPExGP+ZG00cKQg9Wo5aGvndvyWr7nAZOZaLEaHC8jBUyKVY7wy28DBG6p0KCzxkyjoimmHILgNyZTW0phbf0up8BSP/hCq0IemW58gqD5i4AnkqBbthbG4/Ta5ZVx3Z3H175DUPlCOVhyZa2GPdSeXvQQsVWnZiHZeYpldRPzRLDJqXyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bs5YGZsMQcB4d+lL0dCdtLPlKpP4MUmdhg9V0uqda/A=;
 b=TqhOv4mCEfTDhxP27TccxZSNBLArWrbJLgvL3tlDs1HHHidt7Cv9yoFwBMp5/t/CR6tw6nqBKjXQ0LbnlMAOXG2K5z+OZbJqMdwZAZYKPNyxGnR4WeITQhwgmycXa74Vs4WqBkM7+8nvR0OfV9vcNRpHna4LEPhb45mIEPYKy09fUQiVT4r4At7/vzm7jJ6wfSPKfcLlkhAtgQNgQYe922xWGunhljkj0BqfYCChsXyL/2yqGMt4OPaNyomQNqNTjENN0kwArPvwpT9N/8YPCMxqeXQcf1tCE+iR4lDG/WFO6QMI6OvtxzZbZxW/e3YnPBB/DvSDXNIRUwOo9CTxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs5YGZsMQcB4d+lL0dCdtLPlKpP4MUmdhg9V0uqda/A=;
 b=YOZ4DCJ1rEGv0zbkglJchEYP6Niot0kYXiwnQDEmMNE6itiXBU9lPOGL9km391bH3bsBASAxNqdYYgrhh6o2sPUPwR+uWNQatXIswUsfGmy8BDm5ot4horRH4CG4Vz47Xs1lV69CBNNv10iYTLFUleb9CJCjSYtOHk0uj39q9rmeWlywkrDaspaafTeFKYmVip0rc3p4eiqCbZXxSbl4ZdV1WhskwyGwRMl5qldSmtC84MnKJ6xwsewtqqqDx2oHCc//jhtbINdBdWFcwwJajmvBFA0vItmlJVjTPi0JGC5OMZaURcJtMxxReAHfLcDCRHCEFYGUSWfraYlGTs77GA==
Received: from MN0P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::7)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Fri, 16 Jan 2026 01:42:09 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::72) by MN0P221CA0001.outlook.office365.com
 (2603:10b6:208:52a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Fri,
 16 Jan 2026 01:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:41:57 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:41:56 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 15 Jan 2026 17:41:55 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v3 3/10] cxl: add type 2 helper and reset DVSEC bits
Date: Fri, 16 Jan 2026 01:41:39 +0000
Message-ID: <20260116014146.2149236-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116014146.2149236-1-smadhavan@nvidia.com>
References: <20260116014146.2149236-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 1712ee6b-31df-4681-13fc-08de54a07695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ny0ZIYsAeFtXSAhodcphvI8oo8Yger6ScJz4Iyeeqes6ml9/AxPa8IssX7qb?=
 =?us-ascii?Q?0gJ6QPmkrktNU/ajJ0fEvdmlJ+w0EeefWzGlmhSP2I2LKFYing1hzC8dE/1O?=
 =?us-ascii?Q?MsH01ICPgfR9PPg+2uMg0Dm+OwzZ7XemjWNm/uiAFmP8B+Pp3PabArCJAgmK?=
 =?us-ascii?Q?PL1pUAlOa8VU/6sPHEbwJ5b3GHetTGY6sj/K/NwvIBY9j61hqblvvLfkPdYU?=
 =?us-ascii?Q?4FwJxOF8zziX1dOKRxriwnpzpmlnAFXxtzw4x+VzQgoY0RnhletB6hMVuEUH?=
 =?us-ascii?Q?mcfIlS1jidvWuMLfFDEcOKhxxQFXeklUfuwnPzbjNS++W/A4sSG9RwR+x01f?=
 =?us-ascii?Q?0LCx8bbgJ3tdEKo8bTMSUEtxz7lESMcwY60B3K/jLBfhAjmtgqAukuwMACI7?=
 =?us-ascii?Q?9epDErbWwaABVaujUiuqVXsaWP/mgH59piCQ3B1wSMV45z+ufHHaKrd0Svnf?=
 =?us-ascii?Q?V1ThfS99fnolVn539iay9KsrhXTPM6fnCxevo8EYf94Od6xMpGy6mcskssWB?=
 =?us-ascii?Q?zXHvXgeyOoDQSOyTnar1GbnXJKK8CXqgFtHk6DQN6O7f89m2CE4AuV+AT/34?=
 =?us-ascii?Q?qmBBGRW+SRUIAVCFjNnOpNdnkDaSdHKZ5aOiZ4DCC8PDPqEGu2hPaniXhGQo?=
 =?us-ascii?Q?bsGOtbMVuNLXKgYhU+UwPqcUgQpcEiCs5neGdNt3CNNoJHvYHs1ufCnn5h3h?=
 =?us-ascii?Q?bVN6y8/KDQpOgee9b1jOnhNtLPf7z0nFB44T2d0Ic8t1I6vSVlduK4ZvxCki?=
 =?us-ascii?Q?qRGc3EHal+XjAbYRKK1cnTIKmucg6WuZZ7034RAY2QOAqk59Ihmo8X4xC1Wz?=
 =?us-ascii?Q?G3wiCi3Y12d/BO+Ct3cHU8RWwV1ZijTu3JXwF9m3i6fXLNSNDEeylYNxZ/r4?=
 =?us-ascii?Q?BHuMWmNOYJa7q4DGselmk28e7xKwCnrQpRmlBfh+VM+sN45Ydru7p2Npdg4a?=
 =?us-ascii?Q?NiX/RRo1lRod/zGVy78jBnUt/7cBat6yVN90rJ5DSrOidmN+4cdaFszcWCZv?=
 =?us-ascii?Q?rQndYynhbbRhMlFiA2OApDZW++dc2TVzEWxBt3VYAMp9sxUJ5y7oMt530P59?=
 =?us-ascii?Q?hAi9PnPc8I7yuTAMVLuYVfXJzG75dQ53TBjX6fTIb683/Bv7KmdIxMVfyJPp?=
 =?us-ascii?Q?HJvYFlm80fW2wqXivtN8YlnZ7Z3FcDTUZ/Wt+j17JB7owB9q2zZ3Bu6TBoeQ?=
 =?us-ascii?Q?HcTCtG22IMVc0ma6b5IjoJH+sdCnaHjW5Wkb2g4H3UTLUkMsQzqYJLrYzEtW?=
 =?us-ascii?Q?7tteEmfGDu2lS+0PXsgESCTOWxySEsBWxygNCpjqTNfA301/CcYjlWg+k6MN?=
 =?us-ascii?Q?1e0C+JTgrg4y3zRNhjXi4E/FSB2457ptQQDZZbjgYfNum0pbEZuU78z3/p0b?=
 =?us-ascii?Q?e2OnMSjt+IXVOiLtyaq9AbMC1E0KPqpXXld+BJddQoCndzozxlRDrp84J3Ld?=
 =?us-ascii?Q?S93UeeV96qLBWnSKN/nGXKEYZxTkXkp+/ZRYiPBSeLXGZDunU0bg1zbu6obk?=
 =?us-ascii?Q?6zefEen4fpY1K5d//1CEWo5H+jL7QaPA+Ot8cnZ+/Lw2e5Gtht8nvTxXVmn5?=
 =?us-ascii?Q?8BnftcFprMdLJ/AMMGDPo3pzTeuIaEU7iqfi/oH5JKiUNkKEa1BX+2fi7ZsR?=
 =?us-ascii?Q?WD//OZcoFkpWjay5iWnGxqT8kilQDFwxX4LCawt6pgjUJrqaFZO0bmQYn03+?=
 =?us-ascii?Q?ciVTWx0ogmBWGafsmo0+hG+Isac=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:09.2249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1712ee6b-31df-4681-13fc-08de54a07695
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206

From: Srirangan Madhavan <smadhavan@nvidia.com>

Introduce a helper to identify CXL Type 2 devices and define the DVSEC
reset/cache control bits used by the reset flow.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/pci.c | 10 ++++++++++
 include/cxl/pci.h | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index afcdf6c56065..6fedeaea6185 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1082,6 +1082,16 @@ static pci_ers_result_t cxl_slot_reset(struct pci_dev *pdev)
 	return PCI_ERS_RESULT_RECOVERED;
 }

+bool cxl_is_type2_device(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+
+	if (!cxlds)
+		return false;
+
+	return cxlds->type == CXL_DEVTYPE_DEVMEM;
+}
+
 static void cxl_error_resume(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 728ba0cdd289..71d8de5de948 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -14,10 +14,24 @@
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
 #define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_CACHE_CAPABLE	BIT(0)
 #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
 #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
+#define     CXL_DVSEC_CACHE_WBI_CAPABLE	BIT(6)
+#define     CXL_DVSEC_CXL_RST_CAPABLE	BIT(7)
+#define     CXL_DVSEC_CXL_RST_TIMEOUT_MASK	GENMASK(10, 8)
+#define     CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE	BIT(11)
 #define   CXL_DVSEC_CTRL_OFFSET		0xC
 #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_CTRL2_OFFSET	0x10
+#define     CXL_DVSEC_DISABLE_CACHING	BIT(0)
+#define     CXL_DVSEC_INIT_CACHE_WBI	BIT(1)
+#define     CXL_DVSEC_INIT_CXL_RESET	BIT(2)
+#define     CXL_DVSEC_CXL_RST_MEM_CLR_ENABLE	BIT(3)
+#define   CXL_DVSEC_STATUS2_OFFSET	0x12
+#define     CXL_DVSEC_CACHE_INVALID	BIT(0)
+#define     CXL_DVSEC_CXL_RST_COMPLETE	BIT(1)
+#define     CXL_DVSEC_CXL_RESET_ERR	BIT(2)
 #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
 #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
 #define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
--
2.34.1


