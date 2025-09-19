Return-Path: <linux-pci+bounces-36546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17824B8B97D
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 00:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3637B1E0B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 22:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D642D321F;
	Fri, 19 Sep 2025 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k3xRh+AG"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ADF72614;
	Fri, 19 Sep 2025 22:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322640; cv=fail; b=R+F8duDEXzkJ0dgBHc3Klidq4uQElfouBUX6L5qxDGw1SZyOksi+NNgLf9An2Kd+xaB3CBcPMzH8f1ua7X1F79ozpFufDRZ1i3+IjkyP3shipANeEoK/My5KRJ9dmP/yizaMDZBFBttTsknLUM0o6P5rN1MjglWVoW87PVjWFuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322640; c=relaxed/simple;
	bh=AqdxX0dmTKgY9EebKt9Pk7lkjvzU8F/slFZ09okHDmQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tetiZ/ru90rXyroFSaII5GVzdHj2DjraiSz231ZRkx0o5fFNCIefZ0PP4AotbgiiPoaLwfC1f7NdcuPbfYbWlo0g8lPjrzUw1IbiHsSohWiXXQjfhtd2WgiVmXEFl8a6RgT0uveBNcqHRRemrLReostWaxPtsHCjdhrOqtd20vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k3xRh+AG; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbrDQkcL6HULzY+V7lKHsIfU3yXwzmaNqKPuiLe/imQGlyaQx2JBTyw7y23M1uTfQ3fKUgkRqp6WYuJcDYqKYf6biK9SvhWNxpss/ENggHta0+hsQdjwYTElkDKPnoykxLp1g6uCbqmoz5EVB1GqvcNmzVzUmq8NUAJt9q40oVZ6erLo+wvqLwJdeWtU6jaym5Pn1Z+OT6ZMFKx3fH4TZ/4aXzQEEDEL3BJPS3E6h173KQcGXZv07/XG4IUKxaqdABUZDFhCIhAromw/VRtbWJWG0qNr8K0TIHGhAv/G6/4g7ULKP42uc/ok66TaDr9d200VQRcdILK+f4kCY4f7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF+Ceu5/DlqtrdoJvtR8MofU0osi9SKMi4rHws5LAEs=;
 b=rk08/icn1tbBDABzA+++ZJkEmXkY67M/lYFkYGVZArsiFo51KEc2KneVbdDALtCpOg59X4LkNvg7/Fxjd3s4dWM7LTkJFU6YeVnepJrCn9dIkj4KGkP/rH8lpBqUtbYgyTvSV3MfOyKuUmv/eAA9SXk23N4SbbUTgKGZParik0Je09tB5ldC2jr9BSuTggAnCnZQLVmVTMyW2pEKYe58uBz9ur6lU2OjJFIzfeSUajAoqexK7DKI/1Hufj9y7/mi9FYGJGowgS9VHCXN0lZVAcAVFi7e579AoiY4RSXUi7Ave6x1CuFdaW7pz8Who7ZmzRfwGIBu7tC20UVdteBzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF+Ceu5/DlqtrdoJvtR8MofU0osi9SKMi4rHws5LAEs=;
 b=k3xRh+AGX7UezKi17yzO/Ur+vC5QVxIgvHdoZ44pHxGrW86Rno09VwyQJpGAVO7LfOsEWgRLr1pmKNw25VKEYDp4OHXV8u9kE894xQj9sQCnh+BS5SmSxhmcXfuERzhBjATRFwiQjfZOXQLnX/0QxpGK6xXk9zSVVxHU63TFCVcMTeGxoEviLTpnI8t0w+yT1HcAfToE6iDlhdncwrWnLouoM7Ab01bQ0x/8hj2KQVkLh3MPTx777V/my0gl5XiBa+4BUCjBN8eULQaOYN8wTf3gFSkzZH6KSvupdyTdOCZ7SzAsCld8+DFjVmcuv7xnWHjhbYGaNgumhbHGreqPHw==
Received: from PH0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::14)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 22:57:14 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::d0) by PH0P220CA0002.outlook.office365.com
 (2603:10b6:510:d3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 22:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 22:57:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 19 Sep
 2025 15:56:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 19 Sep
 2025 15:56:43 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 19 Sep 2025 15:56:40 -0700
Date: Fri, 19 Sep 2025 15:56:38 -0700
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
Subject: Re: [PATCH v4 4/7] iommu: Pass in old domain to attach_dev callback
 functions
Message-ID: <aM3fprNNMZWJysMw@Asurada-Nvidia>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <19570f350d15528e13447168b7dcd95795afdbf3.1756682135.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <19570f350d15528e13447168b7dcd95795afdbf3.1756682135.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a70717-6e64-441e-b407-08ddf7cfdfe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4P+ikkCMWjanWJC+Lmd08CwyojVrhin54NTSmd+wfZSYxrKzMqiaJEl966bF?=
 =?us-ascii?Q?N6ImK4IgN2+lZUvnY48HnodJClU7dMvQQSK8JseD66vgKix4MHZF2jj8LnEQ?=
 =?us-ascii?Q?vgx9YsTrcSKtln7MDmBCyU16bCvjU1ZsKkYnKL5W9XEDjja5dfgo5+Yz4Ccg?=
 =?us-ascii?Q?7VTjd6Bovxoy4mSbeb668ntAhlzYsOt/hfOAYEliTAHMA271tKWdy3cDAT+L?=
 =?us-ascii?Q?dOAbkWSZRZj5B5Q6XMJxLfeiEJmx+Yc5wKIkbisU8RCbDDjq+gPiAp9FjzTO?=
 =?us-ascii?Q?a4e1OvLsRQfD7cNTQscJrGROUNMZZeA/MlUxpxzCRW4l02gFXGrVrFSbqaaw?=
 =?us-ascii?Q?TL3ZNU/pQSzw/GGIJtBjuP14U8mJBOalgQrchs6i7ro+ZzQEWz6eOyv+hfWv?=
 =?us-ascii?Q?l0/FDkYZpIGKLUeCEo4UEXMdZdwa/5ItG11VnjFlvf4WEQd4kauZ0JMTOLx4?=
 =?us-ascii?Q?iiEdhdVEhMT0f5YLfCme+QYj0VtuEo+NT5oeCLrNdfudGJbFDMcAsAUZfMV7?=
 =?us-ascii?Q?/7cJPp+mIDhAVDVo66rZjx0sNiIcZlqZTtcJ4/jydxNjGnguGQZr4WDJyalZ?=
 =?us-ascii?Q?Dvd7SR+GutIWO1ixhpNb0MWF1t9899Wt1UqwvXOl1ks8ckRU/8HbSfhgrc6w?=
 =?us-ascii?Q?H25LzDGHPjdFW5YbqrWAaYKETr6g/1r/BlQp3nPpmum6d6y67nOZzac+OS0N?=
 =?us-ascii?Q?Mb5THr+cTIwp6ebWkHW8trj5N6NEu7uiv+gK3tAXwsylLvDsrKoPSb0DbHXR?=
 =?us-ascii?Q?wOi7EAaEd/eR/q2sJ3hlsc/mTJzLO2feyRFORgcWQn6x8gy6xieDqIZV3miE?=
 =?us-ascii?Q?g+Hcd3Ux0Y8RANsq+QxuuB0iVhx1iH9QmP/Q2oRPsxn7AMqGCWoihFl9iJvQ?=
 =?us-ascii?Q?Y41CnrWfGMJv+DsZTsBi3SzJCczoxkO8uY/Y7hbMqzynQ8MYSq8KwArL8i18?=
 =?us-ascii?Q?ShuS9SJXEBidgprpqRP4qOrALZqTZ24EAjXXvZz9YrxEUMsQjs45qHd/kJxz?=
 =?us-ascii?Q?u0bgeWGH9ZQYqvsK6imhdB225xBM4GKScW4wXct+LoiUCCAuPyUFhvFoXrim?=
 =?us-ascii?Q?yHyupkH/WuD2fVCvM5xTXAqJHo0cIDalXvigjZhwXmQ+g5GFHHA90c0RSiig?=
 =?us-ascii?Q?DxSWaUvuFQYDu7fNk1Baf/zxn7ffVnK1BU1HtcBEBm4wFO8NyEkZZKWL4WJn?=
 =?us-ascii?Q?KScyR7meF6hSdw4FYdtO7jVwFgWfh3WfPfUJefuNLElUP6OG0f9EbEzKNr71?=
 =?us-ascii?Q?CJmiKwUNg+4SQ6N4DvoQWqNremJ5g89jqaOCL6iuoHhpjhXlS9TzY7HhlFQe?=
 =?us-ascii?Q?IS379uIFv06onsvGkjv1oyoM6jGcSUPMp0ui6KfdYn2+dlANdrvl5M3bNfCQ?=
 =?us-ascii?Q?5JKdqNxFbL0uBtHrd8SwgDU+wUohV6UASjPon913CMd7ZPsvFH9Yfd2w4iY7?=
 =?us-ascii?Q?WRpiAwnRv2qVAzeDKkGlYLv7bwgqz7yASUyAwrmSxJRWBhCWayQuUlvD2zKr?=
 =?us-ascii?Q?TeCLN4AFyt0IkMXwbj/d03CtR1ByoHkClnMp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 22:57:14.1393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a70717-6e64-441e-b407-08ddf7cfdfe5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044

On Sun, Aug 31, 2025 at 04:31:56PM -0700, Nicolin Chen wrote:
> @@ -2347,7 +2352,8 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
>  	 */
>  	result = 0;
>  	for_each_group_device(group, gdev) {
> -		ret = __iommu_device_set_domain(group, gdev, new_domain, flags);
> +		ret = __iommu_device_set_domain(group, gdev, new_domain,
> +						group->domain, flags);
>  		if (ret) {
>  			result = ret;
>  			/*
> @@ -2379,7 +2385,7 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
>  		 */
>  		if (group->domain)
>  			WARN_ON(__iommu_device_set_domain(
> -				group, gdev, group->domain,
> +				group, gdev, group->domain, new_domain,
>  				IOMMU_SET_DOMAIN_MUST_SUCCEED));
>  		if (gdev == last_gdev)
>  			break;

This last_gdev is the device failing __iommu_device_set_domain()
previously, so it should not be reverted from the new_domain to
the group->domain, as it has never left the group->domain.

This isn't a problem without this patch, because the revert will
be simply a re-attach (from group->domain to group->domain).

I'm adding a new patch to the top of the series in v5, though it
doesn't worth being a bug fix IMHO.

Thanks
Nicolin

