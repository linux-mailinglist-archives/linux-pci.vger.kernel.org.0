Return-Path: <linux-pci+bounces-26638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FA2A99EA3
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 04:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4886A92052F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 02:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9076E193436;
	Thu, 24 Apr 2025 02:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TdykoAqZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE618DF80;
	Thu, 24 Apr 2025 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460456; cv=fail; b=MD7tQ4Iv0NKzycF1bI+lO20xLxQA4jXY2itBUgvdBNvGVZgXoh+12N5358b21Kt5MVvPZZpK6fea+rxV1OMEOVDcJQDmAxDSvJSXU1hL1mlkTlLysNnbDnFINopMYlY4Lrc4I7xhvSvCjJf6XhG39XxjivWFCetrUJYi7apT22c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460456; c=relaxed/simple;
	bh=wvoi9eW54UZUJwoDAhLT1cYg52tNHzAZSUGb0Jpc7Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AdgXBThTKmDUfHqLTKWQukmnBoEQ0LpU5yBokrR1d2ULzGvwcfc0sTTmR8G8KZAdlMflZKkFisiRMusNAar6ThvsDb6EG950B74u0HuIfo5p4ZpFAx8M2hBAlyeLGbju8LqSr9v1xNGWMrfSLYTMDFC4TpZwyVAcNCc+/JLPDsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TdykoAqZ; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVCVJv/2xMGZkd82VYO94saBptAlWz8H+0DcM9kc7vl+wgOYOJ3TXzVhIN/WJuHbDbDXNWs7P0k5U2dsIHDdFm7yEWtmEJqU4Uw67DxusKzrPljNrpKY/qebjTrfdNU6rwPawheqAUapHt0sHcS3wX2gAmKyUSgtW9siUYRGzeyRBOCL8DKc2wSEUk0eakOr04Og5sLs4qN3XyM+WkVSo75/5U7LWO6S15+ymvxvMuORWnqnc4Hoxx5GsVV90p9pb53uuwdKmif+ZiSeJUod7+3KVD7F3K9kmKMIg5wlAyo4C7LnGpTCahx18NcH7QsSj7Z/YGziGOTpRzje+fbRyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWy3m5y85idamb6Eyyro/+ECOADGQKC0P39Fyuu80eg=;
 b=HxWbP4k4QMKQrudISdfvDmI0oIgibHtXPvtoF3G/mc61dJ7ltAamnTcMA9UK8N6vZoK2KdZ5kI0bWUVnunXSD4AB+2FcXDmebBn5l/1asXMTlajj1ZGvOcd6VWLUKlEFhgcKLhIIxvExIYcCqSMOlDx+9YPTXzuyInb7hwWdQDK9q2D46vVHPi6e45lFaTF0Vv+VIPGA0JuWlm0LCt8Lb7QWeXtOqfgR1hQNSBKKcfMmCa0PjqECLXWeHghJmHTh8E+AaLZnMJeqbE/mwlsnshvTIs383es76OMb2KmepgxGiqeDO/zS4quZYeg4ITYBiLu2K4ttKvyiC8fIQ5J/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWy3m5y85idamb6Eyyro/+ECOADGQKC0P39Fyuu80eg=;
 b=TdykoAqZN9xH6FcNYqgYdxiqRq8KHLbz4cMFm+0Jv+c729fWizsFKDsCenXED4ZnIS0gFqEeAMqm4hIw7NErpbRBHTNRsy8vl8EwS0faQX8soCmHcyZHBf7SJrS+Gl1X7Hst7QH+ElFAgHzaH7hM8mSQ2SwrtDmcHw8nsvLse3btqpAi/0+zY3ahszBmsyVw+ZIrMxvMNDzc+Q7Uxvs78owo7OgopmgvwccoFjmvWrgTOwNSE3x8zt2t6M5G3i5qCNrXx1k4eGbygaOytaksG+AUldXaMwpTCJT2FSeRfS19Zh3Tvma6nmByvVGZzNOOL+S+67EKcmuXhq/AyoE4jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 02:07:30 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%3]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 02:07:30 +0000
From: Tushar Dave <tdave@nvidia.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	kevin.tian@intel.com,
	jgg@nvidia.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH rc] iommu: Skip PASID validation for devices without PASID capability
Date: Wed, 23 Apr 2025 19:06:26 -0700
Message-Id: <20250424020626.945829-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:303:6a::19) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1a7e7d-86d9-435d-e690-08dd82d4c49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J8+QVU6L+ca3rQ/w/W3dijulCarBkyPKGgZl3O/b4TJn4Ei0GyGrvUmnhGcn?=
 =?us-ascii?Q?aWT5h8NaodyU7NcS6syj5DAY3gwvsR/KfW4gnMAuVskbzLT5LJNrW8RNbsKB?=
 =?us-ascii?Q?kCO7fWehgf9bsSWnFAyfSyQh5XEDglQoPyftyEq0yWlsMqtHZCNOc/AEbiWf?=
 =?us-ascii?Q?lZWRiU1l0dxC6Au2PCtoJ5azwS9dqSXwjxZIRRDVVBM2jR28rkvRe4yhRoRh?=
 =?us-ascii?Q?mov3xlh9T6DP+Np4olHvj6Bch2hh4Mqvs+yJQAE1GroVEpxnMXzEuRZROaG+?=
 =?us-ascii?Q?xBvc0f15DCuDZDie7j955J1DxEdrak5k2dvwGC6wTcSVkHYi3nj2b2GqJ1CJ?=
 =?us-ascii?Q?H4Td57ZD2+Ur50utntY/Wv3/WHRWgPOxstHSe71rOSeNAyAILYrCyOv/itNm?=
 =?us-ascii?Q?OVmKF6MceL4x2jMH7Nyqx/kaYVBiNJZXMPLFuAVa9RcCuNqtay026Zel9qld?=
 =?us-ascii?Q?ps050TZiGk43f1NgF9CbliPtphQ/+Q12FFQ7d1kBFWqwonHY5w8yrQG0nn5r?=
 =?us-ascii?Q?hn4TWUJQaIJXf2kVhq0BEpevPc3to99Fdm35q+bnXKbhWR9Hswd40SOgIszS?=
 =?us-ascii?Q?Sn0gaGcnOcvSDsO+U2CZb2ebZMl40uqg1KUX+VOy6vO3DYAV/5x68bR6pfPV?=
 =?us-ascii?Q?8lFkBpYo5VrgWzR9lkrqwSalE8+JHimMyLS4IUMh1mfdQ8b2EHkz1XjRhFBU?=
 =?us-ascii?Q?FCCfKk5P0UtwIG2fyYJoY1Er4RCPXXrJmG3dy1iHWw62+uUXCOGywdl6/OaM?=
 =?us-ascii?Q?boXINxBzdE+cE8WtG6c4jkZiocg5Te0Bg1OV2z1DJUiGgfUyOs9aLUkXxC7D?=
 =?us-ascii?Q?ACCWb/xUm3eQDjAK6UzSbgq9ov5xMZY566EfqM5/OQ8SFuSIaz/9hJXkpQ3R?=
 =?us-ascii?Q?QBoF6HdrNFdVin88db5SSt8sH5oae/TRLx/qSZ5D+nlsjMagqGtHCL3XINi2?=
 =?us-ascii?Q?161aGiR3AkVtNZ56sBqam7OasZg4a2WRviv3I3RZQ+loA7cxpcd2/wo+gitd?=
 =?us-ascii?Q?4092MfpukBbG4mlNyvWS/gyysGywFMYZONHQoH6lQYf5NEVk7UxnLuspB3Rf?=
 =?us-ascii?Q?viFkcuvJo4KpdDVJg96qhszBrI53nMdE9c9IAvaYhVvUqBMADx860U/VD5RA?=
 =?us-ascii?Q?eiFlAa1Fn2HHcxJzSsghI63iypnaXJ19RZkEY7jRzB32XG9tYedhGDgFkoS+?=
 =?us-ascii?Q?xEkCe/rfhuvVJmYti2yXtdPPLtPVcKEQ5uZDPGOM66YEurlPf3kJtlsb0UQf?=
 =?us-ascii?Q?11hqo15Datq86P92AINGPXCfuzhSmAbavl05XpIlGvSn6klaRGYbFoVEFfjJ?=
 =?us-ascii?Q?WWUgSNr8w7kM7neCl6caK5efJ+y/OUir8DRDrU4JJ/vGyn+AyxyEuopZj2Tt?=
 =?us-ascii?Q?t8bql74MBNymRjdIgS40v8+RNCcxb3HnBe0nWmjm52rND7BplVsKcT2Z5HrV?=
 =?us-ascii?Q?O5PrLI4d0GU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dJciSCrJlf3PW2zmyPppdIVPd+46uoK3fBnLTRLIW9FF5G4qcprAur+XbVqR?=
 =?us-ascii?Q?s+dC8QyEwenjcMLcMbmT9EKXeUVWYlByUGyAM6E1b46Cjl8bhYgj7v7oes9b?=
 =?us-ascii?Q?OlJ3sDFTWCEeOjeRkCqIBlomPxX/YRyt2R+GMR8hwzeL4AwOLdp6nZBh66zZ?=
 =?us-ascii?Q?L7tCVLBQnG7M8weR67OyRy5wIea2lK6iNVmYetOi/qriTNP0GW4U8z5uGwyI?=
 =?us-ascii?Q?7eSJbWnNjv/+IU4Wwqo2cpewkayujVvDQCkZpbq+wY+rt7J/p893819W3yV0?=
 =?us-ascii?Q?waLM0qT5DKLPJzPBz/CQdj/ke5CsBy8lX5duxlewczLlbkL59cjLUYlO3hOt?=
 =?us-ascii?Q?b619FMtP8e4PWlylxuBhbymNDpJaum4W9oXki9cyoqUDr9j9704PZEjo4eaL?=
 =?us-ascii?Q?kOuF1PoiNAbdeyKmcfeAnVKitmXdayuM+FQQGdSg6fPlioQreWs3vNKjY7TV?=
 =?us-ascii?Q?7nxPuAjFhCLJTV7YRMS6V57YVtxTFyY9oCJFEykE1kqTV5PORJrmKmt/hUua?=
 =?us-ascii?Q?s9YD2xyoihalr5hRqCp8kgYeaf3NU1M+glX4AzbnfN4y8kyyA1UgJnA05UPy?=
 =?us-ascii?Q?pgCyMNUcmzDXn86Q0ADHhR1QiXOjSiBdPQhgIF++kqSZdSe8rjQuaVhztSsM?=
 =?us-ascii?Q?yZNh2jjGqGvTLgprRPD4e9LBg4uYFKO6qQmInjHSLShw/9vptRkJcFdebzkG?=
 =?us-ascii?Q?KhccqHLxC+ehq9eYNBeIFB7lBgFDpiFJyF74idZcXxxFCiuomo0LPlDq8xhl?=
 =?us-ascii?Q?o2ROx8VLcpvLPhEv0Am7BwboU/F3BglW78JdZfdoL9O6NeBVlAKV/xD89/+L?=
 =?us-ascii?Q?631ku1jGaUAPtbCFR2KaVWeV4r6AA0VFs2LUnRlQ4MqxTiBXgYxkDJDHyDrB?=
 =?us-ascii?Q?vcqWvyGU2q5CP8MYTDjjq/USAN2kiDWFCvPVvow82G5JDZMl2OeHVd4WCIcI?=
 =?us-ascii?Q?6WCA3Yot2MPSbFrV76CD9wq86Fai7AYL795nL1/fB/ek5DSr+3mrvwyXcSVG?=
 =?us-ascii?Q?yzdJcimV4nNSVd+mWZo1H753FhAhs65vCJL8Y60eIBD9E/1Ggim1N8BzxqKd?=
 =?us-ascii?Q?fG7RvlOhiWAdSxDM8FgftjxTrozjUG3KpHPDw6+1PrqnWK+2fL4E5ypgjQI7?=
 =?us-ascii?Q?fgcJaTVhCY7K4IJPffc5ri2wfo4ee+YwiGxUzpOv7l9zciYNWkbcU6ED+C7G?=
 =?us-ascii?Q?imtgjue59HM39CtglnLnBYwGwFgmTfCVYsr1165SJcGjrqt9Gl9uarCTMMtL?=
 =?us-ascii?Q?vymqbp10ecuu1EiBbkqWLypBRZ7HVeNjWjyhzXiJrrdTFw5eE0vCnHcvwji6?=
 =?us-ascii?Q?2CJgQq0MAu2CGAn/BTWViCUW3UIsNeiQZ89RacfmRd6XVgytzM4+/oZDouzD?=
 =?us-ascii?Q?g7TLf1TCBGcQXdIiDKk3107UXsRLiST/lmdmVkhs7Ddg/ONRDQdRUGkSu4LL?=
 =?us-ascii?Q?L4hWBbKHk8CSkw1q8WAjC6LoRGBTL85syz9KWRju/gTXMTVpWvnOgOxKWMOp?=
 =?us-ascii?Q?dIVGRQCG+a1MwyrUiJS8JsK/pwTDEASnKaVtJsSGWks5FwSsgqpAQ9BGGFSc?=
 =?us-ascii?Q?ko5qelJJpzgS9Fm4hjB9b8PAXyrdcs3PFHSig4Uo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1a7e7d-86d9-435d-e690-08dd82d4c49e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 02:07:30.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LWPXPfpEFgN9Y9aNr3DsEHyoBGyj9ncHpiyZle4nJawmGAgkdEMYRqYYIvd8/NfuFiut04eaa+Z1wAikYD5Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758

Generally PASID support requires ACS settings that usually create
single device groups, but there are some niche cases where we can get
multi-device groups and still have working PASID support. The primary
issue is that PCI switches are not required to treat PASID tagged TLPs
specially so appropriate ACS settings are required to route all TLPs to
the host bridge if PASID is going to work properly.

pci_enable_pasid() does check that each device that will use PASID has
the proper ACS settings to achieve this routing.

However, no-PASID devices can be combined with PASID capable devices
within the same topology using non-uniform ACS settings. In this case
the no-PASID devices may not have strict route to host ACS flags and
end up being grouped with the PASID devices.

This configuration fails to allow use of the PASID within the iommu
core code which wrongly checks if the no-PASID device supports PASID.

Fix this by ignoring no-PASID devices during the PASID validation. They
will never issue a PASID TLP anyhow so they can be ignored.

Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
Cc: stable@vger.kernel.org
Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 drivers/iommu/iommu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4f91a740c15f..e01df4c3e709 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3440,7 +3440,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
-		if (pasid >= device->dev->iommu->max_pasids) {
+		/*
+		 * Skip PASID validation for devices without PASID support
+		 * (max_pasids = 0). These devices cannot issue transactions
+		 * with PASID, so they don't affect group's PASID usage.
+		 */
+		if ((device->dev->iommu->max_pasids > 0) &&
+		    (pasid >= device->dev->iommu->max_pasids)) {
 			ret = -EINVAL;
 			goto out_unlock;
 		}
-- 
2.34.1


