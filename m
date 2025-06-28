Return-Path: <linux-pci+bounces-30987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6C4AEC59C
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 09:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178CA174BA8
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4619F221DA7;
	Sat, 28 Jun 2025 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhDZefan"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94FD15A856;
	Sat, 28 Jun 2025 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751096587; cv=fail; b=sTL1LwY6wDIic0ST376zIC+QSfkzO6/4tFXB/wqKrDCLpsGeE2VDCrZak0gcOvzQ88qdqFp9/IDeAqZmPhz1BHWQCwtBl85j5114HOZxQDIMb9KxR8QWNCtvOz49OusC/qiRRnyYv/D4/uL+7NwV8fkSpxnD56FuUCNX27uq0YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751096587; c=relaxed/simple;
	bh=/xTnbqaUw46VygF4vXMLrYkMZzqEISELVVriNCwKgug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJrnMwkf1fvDRZJHc+vu+AYzmvyRhrYB3fLTf/MwLfG2aNW7CQbd+iY5qwJsTkLECVpFMrQAFXGzZNMNdeV6rrPjs3X34uYT5oe9+l0VR2tQ2/Z1wnX7fn/wEz8zHrm+1F27+f7N9wvb9Zn8AYZsRcmAiw5ZjoyoUZlR+Cp2oGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UhDZefan; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2Ezvu1uHaBJewAClZikSBFjiU55YHSrdqBthTZJkB02Q4DLdQsjaOZIFbHekpzzy9YDZB8xC1l6QjVUHK33mNmleY/EiM4pJT/ecYiR254zaXRzgpIGBcdcfrWbfjeUEP/pRB3L+ZkylslTHEd59k8TvcPMAFqRS1/YVqPvgKRApg20b8jcDjzl46yEnJeR8o+G8iOztu+XsGljLlT1aJ6Lc1SIMXuE2b31ETX0ElP//r3qQH6V2NR1XGXKSs67WDq0OdiAPTm+aMab/z8ump823mJQjXhYBiUaOV+3AuI1tYGugncwSx+r8Zxj8SCLNdAyAOX1Q0Ii0ZRce8ShtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvttU3IH2zMTh/oVRO9vhdifVWmqUaPXXbK/9IZtB6c=;
 b=E5ArKMrRJAHLAW1XxGZsovz/PO1iLDpoK9k33UWgYwIc4wQtID2tMuIl52+ac9F2wC66cKrjalN/MWPT2L23f6CrJAsKBH5Y8Ud+YcPoEqyAZmvoIY2n+tdmgxf474/lkAP68dDebcAMr8ug0Ux+xSSO5r54o/2cLgzDatI+J4PrglB187RpxIlgezGG1xjAWijeOPWHgvUHRKGRcbB+ZBcspywPXQ20LxGpN0wj3o87naxU46Jj2VzV6jZ+yGyXdGsIIAP3WfDR7biwBbjC3e0PlB56t2auWLA/1WfYTTHsiF6IDEuZ3AeX7Sx25LLg2pI6TBgln0WjN/rxodZTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvttU3IH2zMTh/oVRO9vhdifVWmqUaPXXbK/9IZtB6c=;
 b=UhDZefanmC658f7T1qcdO7sAiHuRwBIqxXJqKruKW3sMdRExzwhLCkvSJRB0TC61b1r+BPtnVYY/pQcGBa3Q2kLQWJhgGtwQ28Mtx1WtcXpMz7aHUg+Kk1JU09aGhImvRuMAYpxzCbt55GJFrcsmyiBfrbt5TRfvH8FfLPuTcQYpBEkNIeQWJ9cQgON34MaaSZi4LK+Z4Zg9sc+GF8Qr/AkoQbmyJOVBFMjyA/lcRCHmabFX6gKC4KBx2hVDtvx6ETkDJ9VJX0Waef8uWjid4sFMgtsI8lWIURj+A5f/HzvQA9aJ6rSbSJcJba5BfWphhwJEnJJPqwIxnHzjiNXEhg==
Received: from DS7PR06CA0032.namprd06.prod.outlook.com (2603:10b6:8:54::17) by
 DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Sat, 28 Jun 2025 07:43:01 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::5) by DS7PR06CA0032.outlook.office365.com
 (2603:10b6:8:54::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Sat,
 28 Jun 2025 07:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sat, 28 Jun 2025 07:43:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 28 Jun
 2025 00:42:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 28 Jun
 2025 00:42:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 28 Jun 2025 00:42:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH RFC v2 2/4] iommu: Pass in gdev to __iommu_device_set_domain
Date: Sat, 28 Jun 2025 00:42:40 -0700
Message-ID: <46a1c0e7d07722c542084be9611f2fdf770c3a1d.1751096303.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 111e2dc0-5c3c-4115-07c2-08ddb61768ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DH/aq1Ag14s7rRoos+kjWRQWPtxd0DoQ46J92Ot+vQUlUW8qCJ/oIl3cFUYP?=
 =?us-ascii?Q?1RJdVg9zrBadpQVj3GNHVKwbMreIpZ4kFRRhESk8zfejgjcGnJtQFAQyUlmo?=
 =?us-ascii?Q?ZlzTlsESQF0MJNEbIl40bbg0BrVRHxyrODeVo/qJUyH34hEiAuM1Uzt7R4ot?=
 =?us-ascii?Q?AV8FtR4QmfX5F1ts3jUB90FzExFDNUnbAGpbCBRyrgBjZ5T7Ug6u5wsY5RlD?=
 =?us-ascii?Q?2fbP3twzA7VJjnHEH5HoakRNGcTxh3K7QqE6BC8N3Xww7SjME1lhrTYlwbd6?=
 =?us-ascii?Q?jcK6G29XfT0j43rfXwSf5lCk2OSXL6q+OSgAxNOjOjsvgOWvdFZUh6Y3QdvE?=
 =?us-ascii?Q?u7R93HjnBRK8O0aiJBdGCtRGgUuQl9YIbmZH+d/OSzxx0TsOSrzrLNwS9GwR?=
 =?us-ascii?Q?Z7alvQGVP0yVofNdScGrs4xQN8f/HTjVNNNUDs3FelMv0YxgrFOPuDu2KkNK?=
 =?us-ascii?Q?MlUOjN8wnlPdV+GSqf0lJdnjUIGf0MKX6CGTYsGAPdU/kPwE5f0lcg0MaKIk?=
 =?us-ascii?Q?nQDT+KytM93/qZ985rhZ54c159Zadg5yYjneW2y5pwodN73+zthyS0C7PRQK?=
 =?us-ascii?Q?UUTfgBrDVW9fupuxc8BCjRE10ZQYdL0rjvStm+i27OY5cfxZdZp2yGE6jUpR?=
 =?us-ascii?Q?V8dAMjy4eTzYhoW0g7d5Gbv7Ghms0wIPtXD/XZFpsVU8smQWpDt/jjn/rYSx?=
 =?us-ascii?Q?89Avuw17qAvoeV5nUNkjcrHoHuvtTiIjOPiMmJYPOcBS7EMXsAmVZU+fwDMZ?=
 =?us-ascii?Q?/yoRnCrsJ2tdXoCL7tKNDO+o8qLsq6eR9ZgxNL3kJBWZ2nGBI2XQ+oRMo18f?=
 =?us-ascii?Q?XRKgXa9hiQqkPbO9BAPWzIp1L+7SX3ek6aHOYbWRGXROuakTgyEDDYjgmy//?=
 =?us-ascii?Q?2hQX3YkM5GYED8pMfb9N5PY1UV6s50IsxZyoTcs5DfV5/0Ksy44qqfiWsrJa?=
 =?us-ascii?Q?iDttFtQXJ4nz/ClZgHfBA3SoARPPvC6eXCAN4gCMGpku+AUukSEfmQQFAKQq?=
 =?us-ascii?Q?kOGqKJ7qa44kU/pNR2O1z+7EUJeaRql1vRy+tlxq4E+DWjCvCSL1NN8Qjhqt?=
 =?us-ascii?Q?LzjOxq9v5KCxJDkUAWZaFd+aAbWUXJ8Vj8gitBR/nw1RE9Oo4f7s5K2pbLqa?=
 =?us-ascii?Q?XKA6s6Y43yHMilOUqGgu20+FGX4XJHkPla1bkTEl4BT2U54LpGrOki0HgoLe?=
 =?us-ascii?Q?U0CA4ZhuSQVMc8HGWZAut9AgehT8I7pEeicMzgFp656V9KeRT8NkaIyP2gta?=
 =?us-ascii?Q?hUbBdBIikXyjclXg70stZdaMU7LA49Zt9DUGcue4k/gx4/GeiFULXQDAwgIR?=
 =?us-ascii?Q?G9fRMoHVnVtj7Rd5GuxAx2ADll+KhVn+9abQLagdssVYdt4gdJ8JhOPOjVBH?=
 =?us-ascii?Q?yV1vGc5zAn+Xj9Jyxw//lqsoJNQwFMeeSzLLdmZz5e/iQ4jpOFG6spax+VO3?=
 =?us-ascii?Q?+0/qaeusaL9cFlLhKsFlgKot4Ktb9imnE6zH0v1BoOViEF2KnZizXmnX5YZE?=
 =?us-ascii?Q?lUKSsruTKSuxEwraEHOFa0MqUfy6IUDtf9QW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2025 07:43:01.6031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 111e2dc0-5c3c-4115-07c2-08ddb61768ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

This will need to check a per gdev property, since the dev pointer cannot
store any private iommu flag for the iommu code to use. Thus, pass in the
gdev pointer instead.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 08ff7efa8925..bd3deedcd2de 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -112,7 +112,7 @@ enum {
 };
 
 static int __iommu_device_set_domain(struct iommu_group *group,
-				     struct device *dev,
+				     struct group_device *gdev,
 				     struct iommu_domain *new_domain,
 				     unsigned int flags);
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
@@ -602,7 +602,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	if (group->default_domain)
 		iommu_create_device_direct_mappings(group->default_domain, dev);
 	if (group->domain) {
-		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
+		ret = __iommu_device_set_domain(group, gdev, group->domain, 0);
 		if (ret)
 			goto err_remove_gdev;
 	} else if (!group->default_domain && !group_list) {
@@ -2267,10 +2267,11 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
 static int __iommu_device_set_domain(struct iommu_group *group,
-				     struct device *dev,
+				     struct group_device *gdev,
 				     struct iommu_domain *new_domain,
 				     unsigned int flags)
 {
+	struct device *dev = gdev->dev;
 	int ret;
 
 	/*
@@ -2350,8 +2351,7 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 	 */
 	result = 0;
 	for_each_group_device(group, gdev) {
-		ret = __iommu_device_set_domain(group, gdev->dev, new_domain,
-						flags);
+		ret = __iommu_device_set_domain(group, gdev, new_domain, flags);
 		if (ret) {
 			result = ret;
 			/*
@@ -2383,7 +2383,7 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 		 */
 		if (group->domain)
 			WARN_ON(__iommu_device_set_domain(
-				group, gdev->dev, group->domain,
+				group, gdev, group->domain,
 				IOMMU_SET_DOMAIN_MUST_SUCCEED));
 		if (gdev == last_gdev)
 			break;
-- 
2.43.0


