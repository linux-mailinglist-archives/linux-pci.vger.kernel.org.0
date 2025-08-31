Return-Path: <linux-pci+bounces-35203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70558B3D5D2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 01:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0AC7A57BD
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 23:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8677273D6B;
	Sun, 31 Aug 2025 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IWERACGH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43604270ED7;
	Sun, 31 Aug 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756683169; cv=fail; b=r9t3UJL1v56vG9BUYeRLDyqBQRYyjkGABqQACbjCS7XZ72+yAyNpWvzii4j1va3ZIyF3N56IEf0uXveUof0tJQgDycBdqtgid0gMwMicYMXQ+vlV/bQn1U/hCoJkA4UrtsL8McNGAe3LGHgHvH+9s+nMaIVT8191M77atul92SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756683169; c=relaxed/simple;
	bh=pQrvzfH1++pH1/dI+ath2DuH2+T2SN2qPv2HBhREq0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Li7kgCn/v58Hw7nQoT58h7LYnyBpY9oBDN9OIHZ4gcmK2uWd9s/RMp3H+2VLKO0eq9TZgyMbR9DcAL605rmxMe/KZTaJJX1xO5X+aROrs9/R8/ljYTDmd0mZQ1B3izbhmw76A2wDWVMNR5H7GKf8mpHexWF7c1LmeXf3UT2SHwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IWERACGH; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fdyh+YDBlrDAfpBObUOSTI+cj0k8Ck84UZiyhzdBke5XObp/+rLyheHKwTJjJOirsHSuj66rryGbKsoKCRHTQAtIrZeoY4V/pwuBnZ4+wMVaniwY/l75Xg9LtWaX5/kPsKsN1S+clwibF2pXc0PQVbvGib3nLkLvqeGu8FMgaokIwTPduOfJncrVA3wfcPqBoxgWDTE7offAzMOvsOqLKgJPVHRXuiD2H4cPt5s7rCse4NPyn1aC7GsZw9ly9UseFg4ehv+vWq+ZOomJYO+moLUXCaTr/4JPVyTEZinb5bsDV/cESNQH8UBoQBP6GveP9AuTOFk7Vwcrxma9pQV9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++4zNiHar61MvfKvDki/q1sHSNo+h62pZZu+KLBPtdc=;
 b=WUAUo3QWkvsu8fbEG30XiQmAJSbz6ZouSpDZWA7KbsbbsTDx0smMZlMyuqqYxTMBcvjvSz90lB0R7D77X6LUqpGouABSfYqD+Kg/9lh8dd9DOnzGzHRCdtEXG2neLQ31CFsTeADGYFg2KOYxzrC0hh3irx73jqVFPdG1+nwNiZbgwnlb9Lt2TdQ3WpLa5Nhn/TbZaTM1Uf35qYw94yfMkl2Ailt2+f5UIPdk6vVV8R3XHbM5t6CkDNCr5HEaW/zEjpNCrkgcRgxgI+WRYivNLA0KS+XxTeq3HUYxt1rT89/wB2KEiyUUdoFs/fpmcziefd4zleMD2KzHhgJgmA9I1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++4zNiHar61MvfKvDki/q1sHSNo+h62pZZu+KLBPtdc=;
 b=IWERACGHg8sqWYAN2cMTrvjuB5VRN5op/YqIVh5yNllaEwM8iK9zuWf9TA0MKAQLP4yB56kMWtMlAfX/IARj/eSY03Zb4wepBh7CAEOYa43MgaAG5yJrfgvCwpOVRLfduf3uozCUcZ7CfwPcBKIGkEVfn8ghIqvBurvH5hT5k0eVSZWIF2s+F51vZUlNGPiYmdMwa2OSVlS1Zh4PR+jamZwFuotukyHxx6FM+e5LEjp9Z5WwsCFQtqwl0OUmgg/Yf0Ln34Q/a+lPgoNcKvb+400p71JmTZ+4jbmVAjavafOS9XTTZ1DJPrjGAc4typCneIej3ecWSZldASK+65bhhA==
Received: from DS7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::35) by
 SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Sun, 31 Aug
 2025 23:32:41 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::5a) by DS7P222CA0027.outlook.office365.com
 (2603:10b6:8:2e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Sun,
 31 Aug 2025 23:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Sun, 31 Aug 2025 23:32:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 16:32:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <jgg@nvidia.com>, <bhelgaas@google.com>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <sven@kernel.org>, <j@jannau.net>,
	<alyssa@rosenzweig.io>, <neal@gompa.dev>, <robin.clark@oss.qualcomm.com>,
	<m.szyprowski@samsung.com>, <krzk@kernel.org>, <alim.akhtar@samsung.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<yong.wu@mediatek.com>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <tjeznach@rivosinc.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <heiko@sntech.de>, <schnelle@linux.ibm.com>,
	<mjrosato@linux.ibm.com>, <gerald.schaefer@linux.ibm.com>,
	<orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
	<zhang.lyra@gmail.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <jean-philippe@linaro.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <yi.l.liu@intel.com>, <cwabbott0@gmail.com>,
	<quic_pbrahma@quicinc.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <vsethi@nvidia.com>, <helgaas@kernel.org>,
	<etzhao1900@gmail.com>
Subject: [PATCH v4 2/7] iommu: Lock group->mutex in iommu_deferred_attach()
Date: Sun, 31 Aug 2025 16:31:54 -0700
Message-ID: <9b9199e03c87c3cf8152cf93dc403a95c883811b.1756682135.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756682135.git.nicolinc@nvidia.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f80da3e-5828-4417-9dab-08dde8e6ade1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xc/kY8mnb0+InFbZzniWLWupmEfNxWs9A0a+f6d64i1HveYYBS5de8lfD/1G?=
 =?us-ascii?Q?QChygISbx7U0IK7GfRwtPl6nrcBvIozHj2CnnhZwugx9mVUSJbiZToU99Lr1?=
 =?us-ascii?Q?Ci3QGTg1krLqGisih2NYjoWNGbgud9Mk6kVIeqvVLYAaNR84HEdQOU3OGYns?=
 =?us-ascii?Q?bjV0tVAhCOWA0aGTFPr4y0CSKoxU+WVlSv2MvuSK5H4haaV0oO5kGPxNxkP4?=
 =?us-ascii?Q?SIQFWSFzjbIJ8d4h4tsT2FMUnOcZbFnQBipYyKkMrP0R6uAGe6gvXS15nrPj?=
 =?us-ascii?Q?hDgVxZvZnmUlKRyPpTTmnEJR1ZjzwruudklrMwRS814MDROrn2DSWgrvrVDi?=
 =?us-ascii?Q?Wc9/FMA26zNrAtXQ59Z73sOrrSnlt0laIYP67j49nvyJGzkbpMygOsQYx1XC?=
 =?us-ascii?Q?QAMDa6gnNKvR8+DmDAC6tJZbON7tn93Ttj4RUBH85/6jUm5avgzTbaJV339B?=
 =?us-ascii?Q?Es2yUziit7UmCRiiCVThJKdxyRfA/8oZGdX4x2DGY7VqGVCLonLex3IxKcy3?=
 =?us-ascii?Q?VRKZ2oFck9S3fDKt+yzXe3Yr3cXl6NOnanorywuqM3EGkkeZH0bhj+KQAYRs?=
 =?us-ascii?Q?jSFzCjGvOfas4VaZCOKBaPmrZQ8aXgUrTIaphqN3SHMKTk8zkzk/mDBml17C?=
 =?us-ascii?Q?Bxp347sY1evjt/2Y+dg/SLqWp+fyn3upKubS4Psqkn3GBaQT6YSDqne67GyP?=
 =?us-ascii?Q?aLu3g2kpcq5oR+Zk5g5pOo7fu2+uQJDRxHe1oOz6WxJbA5uCGkfpO7dcmz9K?=
 =?us-ascii?Q?StopJeCNn0QniSG4ywFKCBU8MCX8EEC3OIvSDd02q10zENj6rVj6sVKET/Tf?=
 =?us-ascii?Q?r4K9NvrNYYKspFeJGidGbfpRO90QzZH8B2Y5j0hQvqhfmR7IyMU8aqOhqQrG?=
 =?us-ascii?Q?xlFP1tGrXvRQ2kctRQ7tx0II5TPH/Yiu+948/jiwmOmMHocj+QkG030o95mw?=
 =?us-ascii?Q?ZQgKeHQ4kdl+VcsSAwKl91XenC5gD8YVVw7BMci3Q913kmn+RMLhrMlexKxV?=
 =?us-ascii?Q?mTnzOE4W7BzbL6NE2VatE9x/AtInl17RxfhJbwAj8+Fo5ePJm+jZn+HemAvx?=
 =?us-ascii?Q?0U6b3Ok0emqypEhhh0WElQwOzd4G84RI4UTtZCzzSmOZ5Y2IXhicls6Lk0s9?=
 =?us-ascii?Q?sGU/nX2jNW5XxNpghLl+0v6iM87CmlBYcvk2Z12vCy6QiijiLNNv0VReb1NN?=
 =?us-ascii?Q?rBjTyZL15OSeH1ZZfqIrQbmeYuuHCKE+rsPno4JenZA6xaW3yf0+sfKNidKH?=
 =?us-ascii?Q?/CoyKhTTiJp0DG8FY7ABXwZViX+84umoski8IxF/sqxiRr0esKsrMhkiQahf?=
 =?us-ascii?Q?KR2DWeOigbZBXo9h/rM7VBVI4SA96bJlRnBRqQtjIVY8iupmHNGkeKN9aA2n?=
 =?us-ascii?Q?Zx5hZAEimtB9O9jqmLJEVxLrqQUTgAhTowvMsKElOtXJhE8V1ToJ4vtvRroe?=
 =?us-ascii?Q?49L3zwkjYtAh8p1oAt+2cOB2ogO27JtW66L10aPgiZl8xdvLuDz7DDplhiGY?=
 =?us-ascii?Q?tPh1rP5e2vrnz185uPqCFdzoOo+LgRZQOz8y?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 23:32:41.2709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f80da3e-5828-4417-9dab-08dde8e6ade1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114

The iommu_deferred_attach() function invokes __iommu_attach_device() while
not holding the group->mutex, like other __iommu_attach_device() callers.

Though there is no pratical bug being triggered so far, it would be better
to apply the same locking to this __iommu_attach_device(), since the IOMMU
drivers nowaday are more aware of the group->mutex -- some of them use the
iommu_group_mutex_assert() function that could be potentially in the path
of an attach_dev callback function invoked by the __iommu_attach_device().

The iommu_deferred_attach() will soon need to verify a new flag stored in
the struct group_device. To iterate the gdev list, the group->mutex should
be held for this matter too.

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


