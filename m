Return-Path: <linux-pci+bounces-33801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD5BB218D5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 01:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD20461C00
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 23:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2542246BD2;
	Mon, 11 Aug 2025 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WOAxQlnu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862C24290E;
	Mon, 11 Aug 2025 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953234; cv=fail; b=MsJ7/DIkJdjrNHDo+M/LD5ewKUKLk8T0750RIh/0ow+m3Te7CwywH4pzsisteVw0El1lpQrN6bAmPMkIKeTohKz8OtCtmuZIh/ruTGqZ7mOIue+XuxVQWcnd4ibT3/NOGXq8qKqkJNNxSJT0B75F7EbVhW4ywbHr6lbZw4FDHjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953234; c=relaxed/simple;
	bh=87tNejRacNQXZMVgtlt/9OuXccvrc21uWuZn2bxH7Do=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYosgZQHGTLLIZICpifPbK6aK7fXj4tMuf1xlm1Dn8sI1UlkqpKiUk6ztXSHNKpjth2ZiPGhh2qoUUpsfNFgCJqNUjU3v/kHnSFXd0PyWOTo2YEFG/CgXdgfYKSVNEYi5maARdW3OX3K5al9BrJ+vrwcovPmED62yuFPqsSUims=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WOAxQlnu; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/Zlvxyr905+xMoZYo+2P/CtHJRoRotvKuHu6dfnEm23OsJ4ahRIz2ecLr11IR79Yauj9xgUetDQY5xGB6MpCvChRmUvmoMw31N5qB2brJPsTZMRWdCrpvqxiU6FyXhbmeT/G6h/ruySMJfnrsweHOTM5OrdUYS+th6sfBkXDH+DwUdWTFhl0ryCF0h5RWrMJf670ToCx5+b+/dtnH7ouuOsPEcc4UM6JcbHzh11FvxP2SzGyqHcXr0coRRHr0gHFfQySlhaehlm1gRL+cNlYddfH7POhYgkJnj0EQwv7dH23ceNfIu0BZVnNMXOZpCgKym1eWEkt0uo9FOIUrifzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PIOxtdzXDKbPCUG3JZ5qDoi83JISsySVD2kOCny20M=;
 b=XyGtXoJXVTZ15bVtP8ezE+dV+iOJX5X0veThjE9kfHNRHP7i2pxRHUC58I8xMQTIf5/uGK9KjfGLD1MymnATZ4ungRGdMKN2B9cUjUr8vQ2mYaxUaKa6X3T1YeDoT1M0lqLt/JxB0qzsWPwye2KurEndsVEu3ZU66xvnV2naB9nUXGMqqljMvX9q1BxzxrTRkkGB6UatpjhWiTfuVNp+Ofef0WRJTZjLxSQP1W9Z3SDbC5m2PDOGB9+0T9h1IuEqMypzQtbkZGV6XMYTPDJ1/xM0xuwpy/PHVuhOw1qAKgvXgtPz8Hs2FLbX2/8kr7ad6c79O+/+h1rjTuZRlt7bDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PIOxtdzXDKbPCUG3JZ5qDoi83JISsySVD2kOCny20M=;
 b=WOAxQlnu6Ujcx8obrkxuCuN836NzNoyw0sliX3Oul1MvuntFDMevn7ZzVpt8pwinPrEE4Z5RPsW6RRP9vfqCHdAQ5m2ijOaQnBxAKf6FFc5zgLpGrpcBJJDQjHH0FbwpPcai+C6v8s49I58R2VrCfolk0ZsOnaLONzrgGKtY3VHHn46PkWKDDqoD6SP9OV9waXv75aUfUDpedthLFK+yYw4QhCwR7bvUwZuo8aWZ04cKqZ7ty9/SlENq7ljC48g2jQ+y1BL6otxs6KrOlR11sNKfdNlB/VTAiCxf/C89Boy/lGBsMGmlGT1p+dye26dMT12bxjsuVs0w2ty6c8QkFg==
Received: from BN8PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:70::26)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 23:00:26 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::b8) by BN8PR04CA0013.outlook.office365.com
 (2603:10b6:408:70::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 23:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 23:00:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 16:00:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 16:00:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 11 Aug 2025 16:00:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<jgg@nvidia.com>
CC: <will@kernel.org>, <robin.clark@oss.qualcomm.com>, <yong.wu@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <kevin.tian@intel.com>,
	<yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <etzhao1900@gmail.com>
Subject: [PATCH v3 1/5] iommu: Lock group->mutex in iommu_deferred_attach
Date: Mon, 11 Aug 2025 15:59:08 -0700
Message-ID: <44783ca52e17a9ca0ce7acfe8daae3edc3d7b45b.1754952762.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754952762.git.nicolinc@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: b647f384-12a0-4666-7f5e-08ddd92adc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IJOYiK7sBsD96m2AiPnp+10AgQ4vQ+syKCZNszHCF6cLVm7j19KyLHrsI8Tj?=
 =?us-ascii?Q?R9BtaWWRbUIiwzkf8wecZLdUNOvcRQFQvxZb1dTu/6bZA//3W23vK/3seeH1?=
 =?us-ascii?Q?Vbt+5IIfgIeqWeExXzcl99vTnyNp+vo8JVUcVImnaz9sydy2ArKrm7xKDt+r?=
 =?us-ascii?Q?+ggF/xOpNcZfGWcjHx52I2cf0m9SfqfjHuC/p5faPJAJJPxBLZ3tBi5ZDUEh?=
 =?us-ascii?Q?IpcZ0u83NsRDUlSD96xgm7OgzFuJsZe/ebvjKuww2064WGx8mfrWfohAPiUH?=
 =?us-ascii?Q?tp5Lg87UoCISJQQ3kUJOkhEznQguetERgYZ1XyP9mLj8aHGUBDfUpWRWofsO?=
 =?us-ascii?Q?bhzbzvp6YkLeAvpjP2lgr+//y3PY6Mk8vTKpL/zEMPa4CwAoRFWdl+4yjqke?=
 =?us-ascii?Q?+tgU0Gbf3qHEABRCPFakrsXOG4ZR3mu7jser45BfZ/jXHzP9KI4Yw/6PMVlL?=
 =?us-ascii?Q?4Q5xJQ8j8k/A0wDkkE8/1SkG5UrdiVdeRGPbLmL94BN2rzcF0g0RPN3vTlJ5?=
 =?us-ascii?Q?3MOcRJN/jF8PMiNw5W0JXfaaeo5zHgRR7P8vnMmN1jpHaYcI0JqNry+lS3Df?=
 =?us-ascii?Q?cdS2aKanisN/Ck4ac8IphhTl379GMq0SRG7IJt+DG291DCe+IgY8BZfYBVvH?=
 =?us-ascii?Q?CV6LycPQEgz/ZV2WQSx0TPdU6wzeDVIEhu8Z4gFKBMAI4H+k/vqyJT5G6BfY?=
 =?us-ascii?Q?qkocvh4IFsWFL6gtDuov0ltNHUhJ5oxBReXVMFF2O5ezIS3yw55Jja4gCpQq?=
 =?us-ascii?Q?2EFt0R/P1tn3y/quAboLosM7dIkJJyiwcPXMFa40eGM+4/vs93WiHqto5C/s?=
 =?us-ascii?Q?fjmW4XoWSVTKwo1w+8NncXLMYZWti3AwI15+cmCBsKV0bgOe478oDgEHilJG?=
 =?us-ascii?Q?jV2J6YgbCgHUQOSlpGF8pud8oxh0rnfeF+aSzNyqf8UFo9PYIiWny0In3W6i?=
 =?us-ascii?Q?yNQbLA8Qif1PTztAv0sZKsCoDOH3Zyns5/v7tt+24blGI7P5Bk8lj50vaVH1?=
 =?us-ascii?Q?9yYdj/LTTjsrCMS0fUBxzV8p04YOaTdZyjh4f7gVZM2kAMgHkmFC0SCFPZY4?=
 =?us-ascii?Q?zoHUvYRK3+DrkEbyz9Du+N1EGBifpXx7RtnIFgMVhz/7iQKKBN7724vMoAe8?=
 =?us-ascii?Q?f6aMmdkde5LoCv9vA0smDjfTdg29YQMODYGyjxbqLv6n/AxHPsQy4p7U2sQc?=
 =?us-ascii?Q?sQu62RRHnMJozV0xrdXrCb/YS6S6RSgTdJF3iG9Y+p0646tBdAerPBhseEYL?=
 =?us-ascii?Q?YkzgvDQ0AUkLM+G/CLiIw7gKcgNbO8zlCQu5jpD7zWmfBUfQa5GBAk4kU4xJ?=
 =?us-ascii?Q?xTBmVQtIiRc4ZWiSkjfCAYLR5ylsiHgo9fX2MwubAv6CnmyEKEJ4XunT314Y?=
 =?us-ascii?Q?2XkvzhKMUD3IPZ0fJLd9i6VBn4fkrffJEnj2LYuH/cXUrHQOGuAp/b/MqF/G?=
 =?us-ascii?Q?NqQPicqhIFCI91Dh3g4Hi32jE1opy259IJnCwfeFVkXVD+NS/ZscYdyGdwDK?=
 =?us-ascii?Q?LETb5o9byqpK+kA3P1yIDpsZ+kWWKPqtwCsI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 23:00:25.7946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b647f384-12a0-4666-7f5e-08ddd92adc08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337

The iommu_deferred_attach() is a runtime asynchronous function called by
iommu-dma function, which could race against other attach functions if it
accesses something in the dev->iommu_group.

So, grab the mutex to guard __iommu_attach_device() like other callers.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 060ebe330ee16..1e0116bce0762 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2144,10 +2144,17 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
-	if (dev->iommu && dev->iommu->attach_deferred)
-		return __iommu_attach_device(domain, dev);
+	/*
+	 * This is called on the dma mapping fast path so avoid locking. This is
+	 * racy, but we have an expectation that the driver will setup its DMAs
+	 * inside probe while being single threaded to avoid racing.
+	 */
+	if (!dev->iommu || !dev->iommu->attach_deferred)
+		return 0;
 
-	return 0;
+	guard(mutex)(&dev->iommu_group->mutex);
+
+	return __iommu_attach_device(domain, dev);
 }
 
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
-- 
2.43.0


