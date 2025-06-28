Return-Path: <linux-pci+bounces-30990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD4FAEC5A6
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 09:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1114F175838
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 07:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D522253A0;
	Sat, 28 Jun 2025 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="czH7ouRd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6F224225;
	Sat, 28 Jun 2025 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751096592; cv=fail; b=SIg5z/37vwfEOpKxG/basbQ2wgKfNR6//owMS25hobORhBu2kl8+JY0R9oF9kohF6oJydpr1Bzo4L8GhGoY/uTz0WkT7eXhHcp8B6OEPowoi2CQsJO6w2ar4vtKRrM0eYnfFGoDjL0jTX2d5FrKf72s8b/Zk7n6AyTqWz73/dOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751096592; c=relaxed/simple;
	bh=gjeK/1OK3tnOyVVm7rUr3RX5chBgzldzSoC0mifsLYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzU0C89p+2tbwWdjv9VgsDf2psI4oHl4I51OHoRwaHNR2vbQApItNKXRrOaac4feMzqdJDkrj6c5NEUtXcEW+8zjHfGkJCKb8uWvrwLORBeChlnZiGMQVn1E2i8WsVk8r8bWQR4KvZgPngtYHYAR5vY2wx8IaTDcvcZpQNjtnt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=czH7ouRd; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idLw0FyWMlu8tmaf/Sfhsy72RiJmZ2QUzXCz8nQkNXo2Q+vm6D9Nwnb18NAg4jqQvq6taG+Kob40647cZjIOe+aGxNbjM1iBJmnL8pN9ehoGxbFTOECBAp75K4J2XlKibQSXbfoakbvp7cij0Pt+jx1j2MewWvOpeMme0tvt0im/Pk+6mPn5AwLOgKnTRYZjwNzG8k//85GwDUGjj6zwQCEWrXcDJVRpFgewNIOQXUn2VFeci6FbmM4x1hxDHW6q1M/TaV2RuOm/W4mNmTkGHz7t/3E1oG4u4KkE+WuMf+TDHE8qpqkgp7DI4UrmKx4NQChnLtURq9n5aAJGUl8WZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2BEfv/wEVhKAiiZV0RGewMzpgD3BK+7XOCguJwzTX0=;
 b=Oj/THE6jxtD2m3ds32/vZ/lH6k63WNI8R9Wh2ANqV7sStxIr1uUpIrQoKAbYy3f6y5A2D6LtnTMzaN/MzkseuoaiuHU6DykCnY3fHr3Gxf9wAlR70MKhIIQTOyG8oH/23jWNzrFnB4ubYSaVsgYZpfvIeKPkYzxu9SIs9U/1HOcNQTrI1eSJKEV1TlyTanrldHtpK8OSyZb2Nb8MEFNOEaFAs1xF2ZbbXmHIbARKg6Ta4RYgLQ2vorPskHfBCPagHQFfEsula2TZS1V4cgYC29UHgF2hscCOOPKx3m4ESetk+HzYt1sPmSpKhqpj7s+kflk4rin6BSY2VZU7rvy0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2BEfv/wEVhKAiiZV0RGewMzpgD3BK+7XOCguJwzTX0=;
 b=czH7ouRdnsa3aX742WxBWswhETx//jG+R1PHGZwYHoYbJg6czblGDk/PLNZd0kdkxWMUV0JW4SVhnHjlaeBnWdsRywCpA65xhN7H3xjNofM+xARGH5xlDwq3YO6OTQ9jwvev0XHvQ4HiKO3pMmGVXNaGDLu6o8PefCjIM7Qqbp0uF4NjyA9XFA+GKYudaiXLCjkeakCELjJ/xeigkt4SCsx+4EGpq532uILgzE2zzcFmJDEIB0v+C4g13p0diiRA0P7I9peT94AErMZU8ZTQ3IZrsY4j0jOWOy8Ojemne5NH+QTXWVtUJv7WvAbETfPCuu7ss1xPB0btwQ8mLNqxQQ==
Received: from PH7PR10CA0022.namprd10.prod.outlook.com (2603:10b6:510:23d::6)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Sat, 28 Jun
 2025 07:43:02 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::6a) by PH7PR10CA0022.outlook.office365.com
 (2603:10b6:510:23d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.25 via Frontend Transport; Sat,
 28 Jun 2025 07:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sat, 28 Jun 2025 07:43:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 28 Jun
 2025 00:42:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 28 Jun
 2025 00:42:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 28 Jun 2025 00:42:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH RFC v2 1/4] iommu: Lock group->mutex in iommu_deferred_attach
Date: Sat, 28 Jun 2025 00:42:39 -0700
Message-ID: <98fc799d0cad52d6886ed1136e84a654b0065820.1751096303.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751096303.git.nicolinc@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: c174b96e-fe4e-433a-b0a4-08ddb6176901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?203TTe5ElWzM/w2zuE+ieaQxTdZtVljievnU8csIKi7jGFVjyy4tkq1zb2OQ?=
 =?us-ascii?Q?qsLigeepSzF4qr23K760TucWx+N51U1YK+rv1YCuFqlJ9CYzGInOQlijh534?=
 =?us-ascii?Q?TxlMxJex1HD+sgYS7+wgVv24P1ZsT0YS69WDjYsE3Gi+2WaojqgV5CBRs8o4?=
 =?us-ascii?Q?a6M5fIyG3pGvYdz1i6oag8/AQhYRBOz8XO86WpKScY8IClQ3/CHwtzPMUIyi?=
 =?us-ascii?Q?/0dMT/SCgS6KtsMRmJehYSMkU0/Ug8LzE6tUppxOBY3qQTS1bldLbkJqz7tn?=
 =?us-ascii?Q?AVvtegYdUbT2Lw3GHq+kXhIw3Jvurhttmk/Q7OMilfFMBf4jcHMlYI75eZSl?=
 =?us-ascii?Q?8SfjSqOlqQ/pa84AWaezosDhc0oVQRRLZuWuSJhGwFFKnbwaQsvKJVcm9H1Y?=
 =?us-ascii?Q?blUyBwwjjuq9MXGEKgREhitc1FWG3l/ALIwBetOGl/ufEY1SzpQ1oMnfFv/6?=
 =?us-ascii?Q?Oz2JrsWQdWGWyiobXTeavNMuKxQPJhr5WisWk5m/IdfRYS2uG20Pz0b8yJXK?=
 =?us-ascii?Q?1XV+agFNPJkaxyC9zAPdn3yEj0XjbxGeihHO8z9ykub7tPsr10C+ebaJ5AyK?=
 =?us-ascii?Q?yl0q9/YVA/o0XkXmHEX+y0tbywdWOJdzAelmz9TjZjrJSie7cCz4rGDgoHWA?=
 =?us-ascii?Q?xzaKdFgtFfyY3wpf00OQXP0rWgc/RFfWKWWE/GCIUBbwjpui0hYtqfj8CSoF?=
 =?us-ascii?Q?mV2CBjPCCoGX0XldsHohLzWks+c3IlF7BHcwowCZuW/jhhzkm0LnhaRq/qL6?=
 =?us-ascii?Q?y1GXpO2bYi1Zbp9AtLhcDZG+N4MLhhexYTZZR8ILWpmGPd3zk7QsvNuHcjgc?=
 =?us-ascii?Q?MifbNVM7LOThZZS38a0xuFf25VaBuXIsH2QtNfUmmMaPkAIYefGZxjr9T+Wu?=
 =?us-ascii?Q?Ot6B7RyjpATH0Kas+2ESqJVjLdJNIsF7kI9iHRvUDQg9tFQVh9UPiXS65pmq?=
 =?us-ascii?Q?s9ablcIViUo77WAUOxN2nr2kU8+PAkidvPzHxUmidorfIgbVvrGoqjju5o8k?=
 =?us-ascii?Q?eVHrOP2y+Ige7Cv1QHlp+OO+ga5ezVhgrLRfCq8/p4YkY2/nw6TVuCEp6naK?=
 =?us-ascii?Q?pCSZtbnStXDbXjHKrp9AvuqSloLHcCXyoRua7ITR/1rIwAjOAiF5T10Ipkfv?=
 =?us-ascii?Q?x/fFFRlbUaSNW4sdrlJyMGV0t8PWfkix4kc/sI0JO3Mf0tn+qnB+lxabAvgB?=
 =?us-ascii?Q?U7YDLov5qq8APCiimw68pSDM4XmoaotBFUe72qXz0cJffQpnC63waNlWnErM?=
 =?us-ascii?Q?UQDZHIJoH8pwRQDR6jNIG+hKyqtft7KhKgeMPvzWNB3OFtTv2w1p9A12xd3f?=
 =?us-ascii?Q?F478+bCYnUkICuZg4XG1Wqlq8192Q7zKoUHupAp7mVdxiCT7N9IohN+z3kwi?=
 =?us-ascii?Q?r9gpDi5xUjOMl+rCekDI39WFaKnCIV/oy/LIohavpk+VcYhp56iXtofd6wFo?=
 =?us-ascii?Q?/QHBAca0Quvw2+0xX63UbbphHdFz37eqbOT7Gag92hoV0tAugzpRbkzcDxX+?=
 =?us-ascii?Q?ri7pRwEyLAg+DW8AQrYyXoWzmkMAgPAIFvGb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2025 07:43:01.7198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c174b96e-fe4e-433a-b0a4-08ddb6176901
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774

The iommu_deferred_attach() is a runtime asynchronous function called by
iommu-dma function, which will race against other attach functions if it
accesses something in the dev->iommu_group.

Grab the lock to protect it like others who call __iommu_attach_device()
as it will need to access dev->iommu_group.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a4b606c591da..08ff7efa8925 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2151,10 +2151,14 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
-	if (dev->iommu && dev->iommu->attach_deferred)
-		return __iommu_attach_device(domain, dev);
+	struct iommu_group *group = dev->iommu_group;
+	int ret = 0;
 
-	return 0;
+	mutex_lock(&group->mutex);
+	if (dev->iommu && dev->iommu->attach_deferred)
+		ret = __iommu_attach_device(domain, dev);
+	mutex_unlock(&group->mutex);
+	return ret;
 }
 
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
-- 
2.43.0


