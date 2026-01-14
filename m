Return-Path: <linux-pci+bounces-44809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE304D20D49
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD5730C020A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F25335074;
	Wed, 14 Jan 2026 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="op0DD4Y0"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1962FFF8F;
	Wed, 14 Jan 2026 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415081; cv=fail; b=k6TvvD/fDWpbLSfie7nPHFAl2W4rd9rQiZj+44SLU0DEFTb4iRdr1zww0tlsBWDt2Z0zsi5w5sCWdJ1iLVAqoGd50Iq/MQIO4JKJ03a8PDdByJI5TwPGfgsV/YpkZ+rEF710SA6DWyCzwXFrR4uhkMLaPIZM67NDSAJjN58Vqo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415081; c=relaxed/simple;
	bh=AwqCIzcS+88XcVAEAslgF2deFMRrlNNRNZJRvLRAxHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgR/UyfWoqNE4ItHidxwi6cpC8YRsc5mFu4zGihmgEFFdxxHE9e9GfHIbKIM9x5M059vrFFzObFSsEHUBS6TnulyzGIsVHiwdpml4sgwgP3ls/ccv7NLDWEJaCmoc3IDMnrZ0RFMPUDW8IAATBrV0rN6wtyEwi1kPKfKM2vVpVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=op0DD4Y0; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnSj8quIZVxqqrrMJCVPIjwAKlVYiKkHaimQ6ZMr1GUipCnaN553dTTF/U5H0+gbUYBP72Evp7MVj2z2/gJSmIoajZqBSdCkAizNEEpWLZPDmGS4reaf+Zb4SZ4dQD7mSQ4mgWg1/Rm1z3cbQAzj5412X9frMCH2FnRLt96UGf5QUSEronhvJXGnci6d/IEvvd7lIAjF9ajw022EvbOX7Eft/AGhulU2fMLfg6CKfbfUvcTWHvHRXGqxKXueGzVlJCUIa2e+RYFqq22lzBIPJDIz9BY56MJu7l99sdvCvOcp1vplXuaIVKwEQosKOg+r6VsCUU0dLaC0Zbhbf6f3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iu+sDMckn4amfMTSIwTQG13Y0I3eZXniD4L8bEcXsX8=;
 b=zU1MyhQyrkZJgBglUWduSJU8bTPxqAemyRU1HRJZpdq4OOuDFkPlTNbAoM4otwi1Nx371e5mflAzJamTwemDtFI1mkqk8RPVuH+bH9koljSXCR31bZTSpc/wjEwvXV3WTmjRwuqDYQ0d6d8o+lU+MF+xHqF1j8tQ9d1TTspyTgiPYAQuXJDJKqj30yzzZtA3uui4w9iyUP2jGjTr2E8oqU4qehZFbaKsyx5G6fVeTJITbgq9hB/P0kK1IPVvxf4wYD1N6tnZnvUTX7UAjjXQG1Q3IMBzfemYftyFGK6Ok7Q4xujROoRrm3bf36uAcpJP3RG5A9gA4Hj64lE6Zggxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu+sDMckn4amfMTSIwTQG13Y0I3eZXniD4L8bEcXsX8=;
 b=op0DD4Y06J+fAHAr7g6OiygPhiWf2lj7QdLEPNKYPm3IHQ6r5fXa07kVztu4anWXEwJJ8RSY+AX1zC5l+pIFk2tDUIrjf5/V/C0ZYmacqB2+1eZhd69qU7OA5XSzbBTVaB3XoUlEXkcXhB2EDbWX34GLNH93jYhbtniRXDUuFnw=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Wed, 14 Jan 2026 18:24:35 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::dd) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 18:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:24:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:24:33 -0600
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
Subject: [PATCH v14 16/34] cxl/mem: Clarify @host for devm_cxl_add_nvdimm()
Date: Wed, 14 Jan 2026 12:20:37 -0600
Message-ID: <20260114182055.46029-17-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad2de5f-3b2b-49b7-e16c-08de539a2b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?noWgZB+4XURB17KFMUrUJixq7WmSDLoRM/rgU0NuB6D8H2m96ImGGzHE0nBk?=
 =?us-ascii?Q?N/7Tp/J4GfcSikEVYpnn1V7LkGah0yWzxSnyyzXAfPijCvxZP96JOZzkNcHd?=
 =?us-ascii?Q?8BW9/TfTCQ7pcujE2hoVDtTR/6omhxuxYmqDeKX3jsOBCnI7swcdpSmG4Iny?=
 =?us-ascii?Q?hf2HZIVA+3Ui7G8lgcvFq2m5Qmnjb2gI6SkXT0X1nT9ovEbCVpbJDuPjq8i9?=
 =?us-ascii?Q?YRoEeR82D3L1o3SSLsQqoQx8dYyBnnL6pOJJNKJ3/x6xlWGUc4dKZZ91SeKp?=
 =?us-ascii?Q?mI58cc0T1/pB8TsClot7nE54nw6EbD52z+xbzXR8xCL6ttPFloT7E+QdYyjF?=
 =?us-ascii?Q?io7zE8gN3qKm0CKXpsO097h6nK2sHX0kxU7koAUQw+QCUySqwvJAOPXncbtr?=
 =?us-ascii?Q?LAZIJCuJXkjZGgLdaQxBUAMzF6EyVEtVLIr2CwA35YXmFWuUmLr/S712iVAn?=
 =?us-ascii?Q?TzwLwLQg9IfRTCc1DJ712+a3JW74mm/gwh56dv6rVuiypXQcuofCmT29l0MT?=
 =?us-ascii?Q?yE/RCnGj6AFomGxXMyF8LB/lcvGT7BNbPoH3ZkHA0/Mub4GfAMZ2QXuZ+/3Y?=
 =?us-ascii?Q?lVeE6CUPlieRtqfoErHDy+zmnpGqYLb0SMWCBELLUOez9KcxqT9ZBftTu0nq?=
 =?us-ascii?Q?16wwhY8Lq9scsvIGHokY9eOlfu9xs0SSZkE0Nw5cdyEpQ+KuCpnkDLPfisaj?=
 =?us-ascii?Q?s0SBvgL2duEXgiOG3wA4F77DZPIfwAkhnInBkCj4AarVauk1ml7MdmG2909y?=
 =?us-ascii?Q?2GlWaHQRWulvFpq5htKFRDmN9R2wcWvWayUXWMVJwfSxAha42I5xAEaELL/8?=
 =?us-ascii?Q?qgdEHARs3HQAgN7z0aMdzIcKO7jCqYARIUy8n5i/FI++e+3jgy8SOmn/7y5T?=
 =?us-ascii?Q?7dMiWA0JEaVHzmoyvKyim3TujQX1qA7t2Ru0Pl7aRA2/wSvartIUydhM5bay?=
 =?us-ascii?Q?G8vei2dt0qIHhCOgVV78nBra9Czz7LjXiwBQAScEzeuV0WKOdkhxUASdzA+u?=
 =?us-ascii?Q?0EhJpz9+BHCPavzIKYwd3WFzb8+9hUPfXI5HbGDze+4IIQ6rl2KYUwXMdTUT?=
 =?us-ascii?Q?FxCIRzQlOKN0a7lsIO6BclMVMlmHFcvd+RdWTWetoslCzppBRRt7MewYzpwD?=
 =?us-ascii?Q?IRU5nrW2LcedRpYsR3pS0PlD6MlD+Ag7h7nx8XVZXAocJxaSE+keu/n2Atg4?=
 =?us-ascii?Q?rkVgHSPNTrvCV3K3KWjNQ/G2zoQxfRuFwo59Zzx/6TnNMFykvSQ6Ss7L2lr4?=
 =?us-ascii?Q?D0LoTsDldVY0PJNzu0nNTgSYd7JygqNflt7nafbSQDgpaN80a+54qsNl9q1W?=
 =?us-ascii?Q?RVbZ+mfOKvXzOoZHE9Fk4NwxbSbvzmwaxIwKjvou5IgAa4LYOa59Tey48lBZ?=
 =?us-ascii?Q?Ge4OF5F1PNOL4rPePFiAViEc+o+Wi/4zN2m3BTLhylabZM8vN7uRzGbSehpZ?=
 =?us-ascii?Q?g7bEcLvDeBXGlQW5ta8nmTH0mJNH69rP7BXrd1hHLAYjINI0dPFvgWxfVvKc?=
 =?us-ascii?Q?RFJCZn/C+vVtzCDErCcr0fj/I9No1mogKB1XMdWRyviLrllxqWBAscRVpIWb?=
 =?us-ascii?Q?QQvncDDzcg15SJOgpOTpuB3xZFi5ks1TEryPrlDiW8kRu2g8H1DR+zPTrwUg?=
 =?us-ascii?Q?NM4sObIWJvPYn0BhMnt8567/WAbaR/W+G8j1ubCqw8GAKDhvl1sNDhwcVMe9?=
 =?us-ascii?Q?un+7veexWj3k1Zg6QXZuclZ00PA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:24:34.9497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad2de5f-3b2b-49b7-e16c-08de539a2b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969

From: Dan Williams <dan.j.williams@intel.com>

The convention for devm_ helpers in the CXL driver is that the first
argument is the @host for the operation (locked driver::probe() context).

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v13 -> v14:
- New patch
---
 drivers/cxl/core/pmem.c | 13 +++++++------
 drivers/cxl/cxl.h       |  3 ++-
 drivers/cxl/mem.c       |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 8853415c106a..e7b1e6fa0ea0 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -237,12 +237,13 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
 
 /**
  * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and an nvdimm
- * @parent_port: parent port for the (to be added) @cxlmd endpoint port
- * @cxlmd: cxl_memdev instance that will perform LIBNVDIMM operations
+ * @host: host device for devm operations
+ * @port: any port in the CXL topology to find the nvdimm-bridge device
+ * @cxlmd: parent of the to be created cxl_nvdimm device
  *
  * Return: 0 on success negative error code on failure.
  */
-int devm_cxl_add_nvdimm(struct cxl_port *parent_port,
+int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
 			struct cxl_memdev *cxlmd)
 {
 	struct cxl_nvdimm_bridge *cxl_nvb;
@@ -250,7 +251,7 @@ int devm_cxl_add_nvdimm(struct cxl_port *parent_port,
 	struct device *dev;
 	int rc;
 
-	cxl_nvb = cxl_find_nvdimm_bridge(parent_port);
+	cxl_nvb = cxl_find_nvdimm_bridge(port);
 	if (!cxl_nvb)
 		return -ENODEV;
 
@@ -270,10 +271,10 @@ int devm_cxl_add_nvdimm(struct cxl_port *parent_port,
 	if (rc)
 		goto err;
 
-	dev_dbg(&cxlmd->dev, "register %s\n", dev_name(dev));
+	dev_dbg(host, "register %s\n", dev_name(dev));
 
 	/* @cxlmd carries a reference on @cxl_nvb until cxlmd_release_nvdimm */
-	return devm_add_action_or_reset(&cxlmd->dev, cxlmd_release_nvdimm, cxlmd);
+	return devm_add_action_or_reset(host, cxlmd_release_nvdimm, cxlmd);
 
 err:
 	put_device(dev);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 42a76a7a088f..6f3741a57932 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -887,7 +887,8 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 						     struct cxl_port *port);
 struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm(struct device *dev);
-int devm_cxl_add_nvdimm(struct cxl_port *parent_port, struct cxl_memdev *cxlmd);
+int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
+			struct cxl_memdev *cxlmd);
 struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_REGION
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6e6777b7bafb..c2ee7f7f6320 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -153,7 +153,7 @@ static int cxl_mem_probe(struct device *dev)
 	}
 
 	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
-		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
+		rc = devm_cxl_add_nvdimm(dev, parent_port, cxlmd);
 		if (rc) {
 			if (rc == -ENODEV)
 				dev_info(dev, "PMEM disabled by platform\n");
-- 
2.34.1


