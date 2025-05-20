Return-Path: <linux-pci+bounces-28049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34238ABCC28
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 03:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1724171E93
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 01:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B02421A425;
	Tue, 20 May 2025 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qwZcIU8L"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B641925AB;
	Tue, 20 May 2025 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747703989; cv=fail; b=mOKVvler+tX5TNgi19KLsW4fZs0THVJLltMtUCQ18vLkd68KwRbCNKewht0KPYpTA7rV8hmDd4peXhUjAo9F+MP5jZqXyb7iy+kVK0HgMxLuBSawoy3/GXLZd3ILvbjdDa3hnbVFj3ZY4Q0gcarYbBZyfz7yQjDJIQL5Zx+ScqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747703989; c=relaxed/simple;
	bh=fdkWfo59WaNAr1GMvV2UPaZ9oJGlpc5tiU/LNamaVqg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QF1+sfehedzKj0YcBjsS2yCxje+voXVMMj2CbnqY+//dlpZe5gs08bkCt3t0CJBsrdWloMf1MMYyvsi7b3WYMLdf5e5+KxcoIsQhkd7eOY40Ol72qam/CNq7FFggrl9fZHcDr2ml3v1NzBLn95Gp8YvVCiYi8Zc5VS/YzKpFo7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qwZcIU8L; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLfM0vQhbaxFYBs2N705sh2aeUF0tZ/cyP1OY/SQdX5et6E+WZ3mF08nlac4JY1q7kuYyP8BvwxRq/rZOG9khYIfEg7kf3AiHyoyBeX3KK5ij25q5hj7+PDRVpnOGOY/4bCzm5dBetB2yJjX7lTVxuHFVTTK1Mbc48hIr5SSv2d6DTKrI2FnFwTlfoXoKkVjKHjGurn0LcnlhvHjZ/nGEm+tb3uxML0hACAXuIU/PB6bMOrXIkle0MGFv7QIhvSWZ/w23km1vBQ9gsVsdQkL362LjD/1Lo9DHY4hxUhdSJ6nw/4oHdG7I4hGO6OCoosRXGZXdIEs5X9ATyzm5S/8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O211HpBIUG+JouU52oJ91P2YHpVbPjvYBuwpwHzyQ3Y=;
 b=ksuZE6Zdnj+dkECyIvjuWgsbVsFVdXCNFlJYA9ecn8pl11GfcPo2GoiOTGPWW29YmYn6e5sRK5LzBZG1QBxn7czT9I7wnW2FxrK+A0AggZiv2/ILVYklQbiOBzPq+8a/zIiD2on3R7iEyURws2ze8lEaO3DKpltrmWplDley/+TGgPjGVLcdomSjD3hWsP60DqEi0tyG+930sy33jxlFkDDDvpsW+uoQhsDK9/sId5/ySWo7lR5Uo3nZua6tkmHd5tEvxu2frG55CM54z9xPnPhRrVavRavkaOeG8lASsFWGGByR65Bo7VxTEut8NmgAie+OYZtW+/kgAFGI9kIYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O211HpBIUG+JouU52oJ91P2YHpVbPjvYBuwpwHzyQ3Y=;
 b=qwZcIU8L3V63a90c1lPXsr9pQhw5ylt+Lvt/KM8shDGuaQ11oo2XCvRHkRkWOGdz9lkrQfgeFjT6Uxn/HXrpD2JaqyYySMqHEKhouHIkGfxJ63nOr7lX7kNtqWx9hb2YNs02+9tgV8LLECpSVN/zWyxu1MUhCCAB6MxYyLgpxcU+kXcykwZRiADAJTXmLJg1e5x1Y7VFJRlD3sF6G8/5rcz8lGAZw6jf/LhfD/aIiFQMGCNO96UyaTWpEMfav2SHsyc7ZU/GNinB6evdW0lMcnssDopI9r8d5xQX0dWasmHysglk3df3x7l8n3o4KLZe8WJifG1aH4ITdPLs5vgUXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 20 May
 2025 01:19:44 +0000
Received: from DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::af59:1fd0:6ccf:2086]) by DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::af59:1fd0:6ccf:2086%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 01:19:44 +0000
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
Subject: [PATCH v4 rc] iommu: Skip PASID validation for devices without PASID capability
Date: Mon, 19 May 2025 18:19:37 -0700
Message-Id: <20250520011937.3230557-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::19) To DM6PR12MB4186.namprd12.prod.outlook.com
 (2603:10b6:5:21b::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4186:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 545e8339-dad8-41d7-d0cc-08dd973c6740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dSjru6yPVXMrY500kGo0IjiNamtdogFKkvkBWFkVjsMJlBq78v0C6a4ROP1Z?=
 =?us-ascii?Q?68LUc1bMlngi2M5pEJodVxOLjjKjUK3Xy2dyQaGPJCHMZ6Pn8jJ5WeUveHtx?=
 =?us-ascii?Q?AdAbvKkghDCawDUKhsYUqU+xpJCrIZ5cgQRUUNfoKc4Tnu+zfVtELHHtInYC?=
 =?us-ascii?Q?+1G3Ut/VvDEbGii30K9NbhI2OURL3NJSi17U5oTvtKW9KwWYLYOV771kT0Zp?=
 =?us-ascii?Q?lo9p7FXy3rurgytmMPXRS9OSX0n9QCidcT+U+8KTK8iEqbO4UvHp77afo9uj?=
 =?us-ascii?Q?EkOFY2ka63Rbx/gTV5vbMv+iuSXpln10KDr6SDdZyiouIX+Wg1sPnb4X+NIm?=
 =?us-ascii?Q?Mgrv6I+ksehgv9rYIshj+rlZ94pukcHb7GOuCZCsYtKxGb1ufZFHCqqDQA8S?=
 =?us-ascii?Q?0rw4+DubmWfXbYknDIzSjE3qEmeOYnrRDnOqwRBlUXcVwfQC1jlm2db8Zjlw?=
 =?us-ascii?Q?bjVZEQHGmwyE8zqUvhhSR0bO6NorHp3B9Gjai8ARBVqLgwaM4+uoJgd0IAID?=
 =?us-ascii?Q?+Qze7cE8fCLjyUHfgjzOcz4dSEwEcd4P3XIT4Ioq22++Gmrg+cGgkl7hdE54?=
 =?us-ascii?Q?f0aeY0igyTol7JP6JdgjPhHIkTwQ2Qi+1Nwg5E8gpLrYoYuGBq1u7ehrH34V?=
 =?us-ascii?Q?1kKyWQVA9LiJDVuI3pyxq7uwfoO+0J4lokFUeHucsWF79T9VFcyZptkbCoeS?=
 =?us-ascii?Q?pih1LcYTFwU+8I7AJKmGVA1h9aHwQ3vQgrc2EMI27YEeUXL/T3DIqTEAhItB?=
 =?us-ascii?Q?Mk2xdRtOcWKQJYFCbgzIOuq+m2Su2iFP5fppbEANrVx6wWOv6l75Q3c7uFDg?=
 =?us-ascii?Q?d7nx20BZW+5iA03CMmDIAOxhGwKU6sak2umHoMxUl5RnxYdRVvJ92FhkkPk5?=
 =?us-ascii?Q?ixcdk/MVEmIZBkC+KdseXjSCWVclVQtboP3vnrAmkUUKlFt4stpOrSA2qXaG?=
 =?us-ascii?Q?f0oI3zDw7Ff2cW6CQvvBwLcL5Jrn/S0Zfy/ly3vL6dHSBf6dLAFt3gNWyDBs?=
 =?us-ascii?Q?yG+5HSdRYD2AtxZaCTUon1kHgxUbGN0ZPjb7WYB+qhE1wz3Ll0VwcK51uA9w?=
 =?us-ascii?Q?1NzAdQyZtr5dRU7IQ7lFa8iHjsezYDF4+Ro4PAw40+LrKff3HfUQxucj8AJn?=
 =?us-ascii?Q?37Xw1262Q9g5OWFl178nXGycBGCBshQ78GAXXFlHy3DW2ADWVlqwMGH9GGbx?=
 =?us-ascii?Q?fgt3B+GaIhlU1KPZM1e9qcoaEU8XTKNkwQ4p/R88NpBoCGw6LzzPyGoNdv9v?=
 =?us-ascii?Q?murrWqUpXxS9Bp271MtHoUIzd9N8wbMBA0BX8ZWQp7lmd6axpg60EzPgxENm?=
 =?us-ascii?Q?4jkAXqh7Hf3fze2Eex5Svt3YSEElLY2Kd7EbG03iAVUDKbhF5586YuaHqzKz?=
 =?us-ascii?Q?jEgPskjQTSKZ0MljMO+0hXCvOWhh/CfGJwSYhm2l8cPYyR9NfgWI37EOZy+w?=
 =?us-ascii?Q?5sCQXGg9Qks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nzxA8jRWaXt31IIyfPfbNpjG+7g3VWHTZ4q4zotdHUkmLwMnEf9xytLlWVuK?=
 =?us-ascii?Q?h+Yrv1BpggYXJ5GItyTBiufCJ7ffdwZtjyiYiU7/0P+6J7t0oykIbDcsJ93U?=
 =?us-ascii?Q?uB1p/WnpJVzw+lXfp0W4i6JQBOZIkFLvyrOowbkbUwQuv4dobL4PFMdQubdM?=
 =?us-ascii?Q?lMwtsed6R9gbCZVQd8BaXxZeeM+MEVvZ7e2ghPhr/PWtQ1rG/x7jKOwCdRiU?=
 =?us-ascii?Q?DMrz5e3fsZE0TqQRtpCJmN8vxAKU/C3GQIyrvLBG02ueoHAg0640gzAOVr2B?=
 =?us-ascii?Q?15vz8UY8mmVp0nOMN7maajWlyUc92b7bpTrw3j2Xw3OAQA5ofYF81IR5beDR?=
 =?us-ascii?Q?JSpi0Lw22nipHtveneJEwIQOrbEmfv6JT0YYxWXSsYO0bo1XafH+ag3xipMg?=
 =?us-ascii?Q?8SL6t5+s+mmvR8bdW8uxudaqAFnjG30OAR8OvftXTrc8JdAoO/trU5Em0vb0?=
 =?us-ascii?Q?CDkSXVJeTEFlYHYQlBZQFl8UHj9+3MpaDyxCw1Xccmmi7+0DZKo0Z9zaqmV6?=
 =?us-ascii?Q?QpO0UvauNLd47vHmIxuJqag9P7t0f58lXYXDUlqtr1+HDw/du64PsIWt7YqQ?=
 =?us-ascii?Q?n1QZDCr69qFD1dfmcmK7BRRI9gtJhq5Ez6HseMHbr6OfYFn85M7dn3YWTzLg?=
 =?us-ascii?Q?5H9dfU57u+m6VJw1CO5bE7JgozcwmWsZSuEM1/+H0v/AKEHTHTq0ZxQGSiwa?=
 =?us-ascii?Q?UfXcJLU+TOa8+HhTX1Nsro0A2ZpNWMJOJULbLNZ+2Bw+z6VuwIrkLLZLYox2?=
 =?us-ascii?Q?PkHccl61ptT6OyAOVnZUmCsupzyyrnuteQS0KeVxvlJh+R0+7Fm7UMsmAuOs?=
 =?us-ascii?Q?wiVDYwL2YqH68iPp56ugCAuVYChgDYn+a55+YRgDqY7y6Df0eBKWCuImv8Fp?=
 =?us-ascii?Q?ZinjoQ+fT6o6VzIhRhTr3hp04ERM+2NGAi2rMSpJok+qa00bOcu/Xxd6n/Ka?=
 =?us-ascii?Q?5pcGkAL6/WXe9y1BvoKtgEDFqxIRu2NjJumn73qJIpYraBQiskfvkxTzhJJk?=
 =?us-ascii?Q?k4C7RGoFAx0WDQ3/OZM7dwPj0mJuEcJzYTgJQrYDQ8jwlDvgLLmgnFyItOrQ?=
 =?us-ascii?Q?bu/mlcExW18HNPvM8nqS2npAviOzDieTuNC87duCT3VGmVGDWphBp+ZWqMTJ?=
 =?us-ascii?Q?awdjCThZTgIbRZcbe96iAtdZnTrBo+aOQJKvxik+DU+ws3mNh4DVUSlS6gYN?=
 =?us-ascii?Q?2sv7q77l1xY23nngD2Tx9lPA1GxZkxFPUJrjG3wBby7f7Kar7u+mxDcevi4c?=
 =?us-ascii?Q?4GIMSSPxIh16DK3vBx9Oxga35r4FvTeG4UfQc8WnLe4C3/GbqWpoh0o5Hy1t?=
 =?us-ascii?Q?YI1EdcwAjBJGsyH6F506ypg9XzSeB50GylupP0X22tcoCJSyNM7OpLXzGMeP?=
 =?us-ascii?Q?nsUpJQdqmxYUYUE7lynx1mReZfhvAOKV1qlXc4DbqwWTMb+WudqiW5LDGRNs?=
 =?us-ascii?Q?H8GAV0ToV4qYZIHakcPKlvDZbl/3Hsbsy9rNmC1mW5TvfiJwFfrDAaEh+Eqk?=
 =?us-ascii?Q?fSdpON3noD0XZhUlm+cmn9Ghq+VEdO1gmdAZ4GBdXMHoUVOpJt6P1TctVTKx?=
 =?us-ascii?Q?sjYyOW4YLOXtiDR+5PESSjTT6xOXhuhEqz2v1cO0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545e8339-dad8-41d7-d0cc-08dd973c6740
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 01:19:44.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+UwhjL6DnJ+e44FniYjdWQbQw2vFJD2o4BxTnKnQ2HWUncEWnJNRvCeyRaUvng93TGy2KzhE2J2mTHw/f7QGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028

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

changes in v4:
- rebase to 6.15-rc7

 drivers/iommu/iommu.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4f91a740c15f..9d728800a862 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3366,10 +3366,12 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
-		ret = domain->ops->set_dev_pasid(domain, device->dev,
-						 pasid, old);
-		if (ret)
-			goto err_revert;
+		if (device->dev->iommu->max_pasids > 0) {
+			ret = domain->ops->set_dev_pasid(domain, device->dev,
+							 pasid, old);
+			if (ret)
+				goto err_revert;
+		}
 	}
 
 	return 0;
@@ -3379,15 +3381,18 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	for_each_group_device(group, device) {
 		if (device == last_gdev)
 			break;
-		/*
-		 * If no old domain, undo the succeeded devices/pasid.
-		 * Otherwise, rollback the succeeded devices/pasid to the old
-		 * domain. And it is a driver bug to fail attaching with a
-		 * previously good domain.
-		 */
-		if (!old || WARN_ON(old->ops->set_dev_pasid(old, device->dev,
+		if (device->dev->iommu->max_pasids > 0) {
+			/*
+			 * If no old domain, undo the succeeded devices/pasid.
+			 * Otherwise, rollback the succeeded devices/pasid to
+			 * the old domain. And it is a driver bug to fail
+			 * attaching with a previously good domain.
+			 */
+			if (!old ||
+			    WARN_ON(old->ops->set_dev_pasid(old, device->dev,
 							    pasid, domain)))
-			iommu_remove_dev_pasid(device->dev, pasid, domain);
+				iommu_remove_dev_pasid(device->dev, pasid, domain);
+		}
 	}
 	return ret;
 }
@@ -3398,8 +3403,10 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 {
 	struct group_device *device;
 
-	for_each_group_device(group, device)
-		iommu_remove_dev_pasid(device->dev, pasid, domain);
+	for_each_group_device(group, device) {
+		if (device->dev->iommu->max_pasids > 0)
+			iommu_remove_dev_pasid(device->dev, pasid, domain);
+	}
 }
 
 /*
@@ -3440,7 +3447,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 
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


