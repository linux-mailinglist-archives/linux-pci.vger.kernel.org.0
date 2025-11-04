Return-Path: <linux-pci+bounces-40250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661A1C3242C
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B552318C6E6C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D6C33CEB2;
	Tue,  4 Nov 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TfpEex0s"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03AF334363;
	Tue,  4 Nov 2025 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276000; cv=fail; b=gaw01yIRwdnls/UPtAO0k9FbwC63Fz0TUbxpmbeBVHWGnYmIMoZBqWkpfSsmvYADC+7KPvkfnWeMr/OfmXcR1KoGiIxaoC14v4fLs3opjYC5GpqGF6mTVe7YAOLIFGMmKyxvAgzObNT90lv3sTeAXx/c4t26IKpWD8mXAXqV9zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276000; c=relaxed/simple;
	bh=UDnpf3J98Kq6yY7pqQx6LwO+gk6VO5Jk30+LB0JALEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KayWFeQOxKZ8urArmE1r+kUFRqtL11xZjlwbOz+C4+8DviaX4qUxDEw8YDs84Ip/SM/Rwu9axXT5GAC375CUwoZsc56aM2CgK6RS8paLDmQjQKjFonjvk2tfxn/IOxCkZgnFFCi9Vv+SHTztXBAM/qUOaP6AVxn54WV86bhCUcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TfpEex0s; arc=fail smtp.client-ip=52.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yavVVFww8b9lQw3JyEU+PhYRQozuGMsx2/TTx16W2g2DUQ154CF1WSB8oxiWEgflpknGIgYJ37VKv/CYkntMz1x2lgpPZppk7XKi9qzCAZ7ZquRpvI8sa0daV1Z7eR0iEbe6zRSicuvvu+6GWd5qzcfjB40ZeQrBgqVtS7EEZZUIpfK/yT8qkm+ZsEH81j1y44dkH+0yFtuWFK3/WMfEwv1Ct46fov4WpeZKLCacQ1HRqdgkvw7Vwxs+fgB+6sFgVh4xD07uN2PqyhXhT7nQKh2H1Q+VZqQy18AOuWWy12AA922ftpVfG2KLHmUOImPkar67JQndgsNS4EMVmiykWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1V1ht0eAPCC7n3ZuPQAZun8SUgK9lddep/56siyTptM=;
 b=BSdHsAENIwRjS/kg9r77laTaukfZLQwMuwdmFL7/KSv6wV8yEa3Bghggvl3nLKH4TJbghK531sPukTilcA2OftMh77ONQSFTeU4QlDODsT8PdK0LCjIu9Qk8XOwbujTRCk6u6W0u2jfOcj6eOix0mB8PR7w3KvhK6xi2njvhjZmXP0fbFyapB6MXrvnGBwzvBkL1xoEyHrJlgAG3/bPEehq1YdkxE0QQu1lo62Gv6bFk0cfUMkgSQfQ+/oSYE+zt6ymBLNCiSeDHrsqta88CPB+V38WWV7TX18F5VKCUj2rCye1FjLcnslP6SvcmpdM40K+n4opTKNbotNswQJtSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1V1ht0eAPCC7n3ZuPQAZun8SUgK9lddep/56siyTptM=;
 b=TfpEex0sT7RsSb9c/zPDxPwSiUn8ivWI2Z+35TlDuRGTWQgrhTVcIHgnA8aBPaQSIYdAdPamvDe96VTixo+7Vyq2AXLP9LrCM7LbUiZB1NTqkh6yAqaR5Kuba3jIrGS3DQPQgrE4jFUXwgp4BGuehczBvnFfyvZgAIXfGMkfpks=
Received: from BLAPR03CA0094.namprd03.prod.outlook.com (2603:10b6:208:32a::9)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:06:32 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::45) by BLAPR03CA0094.outlook.office365.com
 (2603:10b6:208:32a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:06:32 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:06:31 -0800
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
Subject: [RESEND v13 18/25] cxl: Change CXL handlers to use guard() instead of scoped_guard()
Date: Tue, 4 Nov 2025 11:02:58 -0600
Message-ID: <20251104170305.4163840-19-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0a7c81-de4a-4208-48b4-08de1bc480cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Zj48e83BQmACqFDOk0TwspHifstVW3mH1oUc+C0jYSksCzFMC87O+K5g6k3?=
 =?us-ascii?Q?uXinOTsBjshO90ZlqeoX+GIB6g9rFsrpcF0S9r7/6tP8biOy5epuHXBk6FOk?=
 =?us-ascii?Q?7Xrf/HomXCBxn5Aj21q6w4NMNidn0p9aByUqq1XZTXY2J6x0tlwJtNRuGwEJ?=
 =?us-ascii?Q?H5Rc9dqyKk+np76Lt5o4YBdfoyCUJEKoBlo8D/JPkI/bQik0beIrYQJdAtjw?=
 =?us-ascii?Q?NLBtHWEof5OdneGR6boutuv9BIn30OhXAAJ85oa8zxUSRLDpVThMPGralrwl?=
 =?us-ascii?Q?45mDvOGoFtHJzbHAxil6DZxj8wnT3FHewjyF8hK1UgLz1ywbGK2H1Z+nG/Xy?=
 =?us-ascii?Q?rN4Jslahe4SgE2eBaYfuPFTlDPApdrD0/4ml6jfE3Q/w/aijszP0PXLICNT3?=
 =?us-ascii?Q?mVK4PtO/y9dPvm5xWOi6UOvwmSUmCj/I2saP6j15494xW9xYBD4XMKbPcNDK?=
 =?us-ascii?Q?r4do3nNG0Y1mbGar/Vu+PNpBGYPvIqhnTShurFzyYk1KQjlOo1FixzqUZXxh?=
 =?us-ascii?Q?lcvhnyJImmfaIgNwjWKdnTl0iXzMsrs9kGIDidcZjrOg4fljpLuO4reUQTtV?=
 =?us-ascii?Q?3IHhIE+jnU/XInlRyeDty9L4jvrOtwe2c/kpLiwRs2GmF2P7JnqO/Alrdv3t?=
 =?us-ascii?Q?+46buU7FsqUqSy+1G7HqtK00MV50cA0QJgvXp0nmqQiLsfKqhbhNyusOGD0Z?=
 =?us-ascii?Q?UX78kE5gZYpCukv1np+Qz2W+mQida/BqPvhy9WNYQul79MUQg28xlp44N9ZG?=
 =?us-ascii?Q?jXBru5jObW4vae8KoXs0dcSTvbtxyUltOmyxgNe43lMr4wVtZ1yk35SkZa72?=
 =?us-ascii?Q?OJEz3uWDU5Bo/le0kUJl5mxkYRApbKNZk8qk/ucDQInbhdLkVYl4kNGs2fme?=
 =?us-ascii?Q?IYbxu2VbRbp75eNh2gjaXA0hVeZ5bk+IZBlQTe0kzFCmtSRlFojBd8VP8PmK?=
 =?us-ascii?Q?4BBzKbQ2stGCrc1X/j7I0wjMqHEHVAWtumTJSPQBCBY02Ri2Xrwb1o7Z1N/G?=
 =?us-ascii?Q?CEoqapdvsVVvmJLKBdZzL9wAoNKsj2IPU30rCfNJwKj9ijelC3D1wFDKGGeh?=
 =?us-ascii?Q?vkTRbuE/oFQLbpxKuvqD1ejeh0ZmoaoqzamkwjEm0m/OB+JL8ExgZgVzkNXU?=
 =?us-ascii?Q?BOGtGsoP6LL9mPwW25F0gKDCN0CPaSCo6oUl2GpSaNFgu8/nF1ibMR6S4V6K?=
 =?us-ascii?Q?9V9KeZ5d+pZg8Dhhc8F6WSVAIoNsYToKge5YWzRcHbmGCzgptvHKOM6aG3VF?=
 =?us-ascii?Q?lzbrR9tqIA0dE42Td+BQwLv6jHhWtS+o+ShGgZnz7MUQjQKASSMzGmdTeTnQ?=
 =?us-ascii?Q?dVLRdaT7X4OtkGjehLK4M6qqa+jQCYy8twGsFzhB/bSuxOL7r9+XKyKTqhb1?=
 =?us-ascii?Q?Sw5Kdl3tGedQ2OthiM1CUuR1yla2yCVgI2GRviLykF9jaJLrNQrzviXn0gN5?=
 =?us-ascii?Q?EEicdmnFBLPsiqGCBCku396pha0XigU3yEnjw79AUKf5Pm+iOvhVLggDH927?=
 =?us-ascii?Q?u26e1usdaVoOW1SzCSEXVM5Ptho+gVGXg3rY24dLCpbBAMKT50L86/WY698B?=
 =?us-ascii?Q?GUnm9AjuamWpQqQDzvU0ICzSLy/7BBKs+oRz04lc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:06:32.1356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0a7c81-de4a-4208-48b4-08de1bc480cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515

The CXL protocol error handlers use scoped_guard() to guarantee access to
the underlying CXL memory device. Improve readability and reduce complexity
by changing the current scoped_guard() to be guard().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v12->v13:
- New patch
---
 drivers/cxl/core/ras.c | 53 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 19d9ffe885bf..cb712772de5c 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -254,19 +254,19 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	struct device *dev = &cxlds->cxlmd->dev;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return;
-		}
-
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
+	guard(device)(dev);
 
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
+	if (!dev->driver) {
+		dev_warn(&pdev->dev,
+			 "%s: memdev disabled, abort error handling\n",
+			 dev_name(dev));
+		return;
 	}
+
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+
+	cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
@@ -278,25 +278,24 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	struct device *dev = &cxlmd->dev;
 	bool ue;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
-		}
+	guard(device)(dev);
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-		/*
-		 * A frozen channel indicates an impending reset which is fatal to
-		 * CXL.mem operation, and will likely crash the system. On the off
-		 * chance the situation is recoverable dump the status of the RAS
-		 * capability registers and bounce the active state of the memdev.
-		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
+	if (!dev->driver) {
+		dev_warn(&pdev->dev,
+			 "%s: memdev disabled, abort error handling\n",
+			 dev_name(dev));
+		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+	/*
+	 * A frozen channel indicates an impending reset which is fatal to
+	 * CXL.mem operation, and will likely crash the system. On the off
+	 * chance the situation is recoverable dump the status of the RAS
+	 * capability registers and bounce the active state of the memdev.
+	 */
+	ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 
 	switch (state) {
 	case pci_channel_io_normal:
-- 
2.34.1


