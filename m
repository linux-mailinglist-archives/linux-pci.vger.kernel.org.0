Return-Path: <linux-pci+bounces-31534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F05AF9739
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8A35A0AB3
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D3B16A956;
	Fri,  4 Jul 2025 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tdksL4Yb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9018A6C4;
	Fri,  4 Jul 2025 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751643832; cv=fail; b=JSe+EqiWkHhGZwr5xycvwNFzI3eHvjaDY9EX9coer2vOmUX4491Ge9H5ZinfTjt/nA9yo6CtWR7HRxgY7nQKQCSom9TA7tXZQxCHMkgFQ4YxkIMdWrnixSCTyzYpb4+zkXCMUaTfcWRMsWgRgdN5b4yWM8+LeTC7YXy7bIfU2U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751643832; c=relaxed/simple;
	bh=niTrbS9RcNOk+EatjteubxF1UX2VuxdEZXe2Z29173Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pPzRf542fYB9QLQozTpAzKQ8ZGrYDN9VWH3hKXgDx1hr1jE0SgvadJMiEHwGdEDVA5nHCKQgZDpn/m9pumK2csBDX8DIq+SSiveXzu9OssTxZku2oa8NR5CyHanF50o76Qy0npqLN8JIGDH1qDYHkw6T4gN795QXlxmtgg7qjAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tdksL4Yb; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8DettXWP2otKcxUnF52d3/MIDrraK3A0Wpe9hWSvA+CeQ8TpnhVLGsrMhoPxvC2t/SJoZSS4crvTpIS5G06lR67sTU0Wt2OzDbrJ/55v2xxcFXkKjsiPUPB5UEu5R0Be7k79WXq12NXvykTIGA1jFj3uydMmevl8NPPwe72GZTlPNMWxbz2PTP6HYW7pcnFlXVGSUAwFY1K1DRtwDfdeiyeYfcQ4CI8wWQWZYQGPIt6bxgg1xoehn8nlnfV079e11CtC2KvC2JmmoKXHGHlpglBpOjS9sByoeZXX8FL65vQDhL+JyYzgf09jO8zfwJsGvXKHAuoTdqkbC7lX+UhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9dUbZp4ykzQ3aI2m7K31yf6s8H6mlaV6d91cR28rjg=;
 b=sWzsqBFo9l8PdFN6qRoDXQy+JbPhmS/HwDYQT3yQwBJ1GOd1p9uH4bcJ4RNBgzBV4FQWgJunQ0jcvx5tZev+hmDcFFU/j4IwcBH+Lp1SLffCXLhT//Ll9NCJS2hxfruI4B7MKw4MicIFBrZejnjoiyjFP3Kdm7uUBH37DEEl0Q8zi1mcriMOt6oZOdIUteEbeqGu1I4n8pVwTXEHs3WeoZEh6JMyTOOkAAybSxGGhjyriSY3ewS9ub3uQDdu80GbROw5hx4MVvyRxqPhSZrCRDNPg6U2BkG8dpcwziu1GU3DD1U8wshDzjsbG5tAQMPNZfRQdjOkL9AinK0tqQ94Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9dUbZp4ykzQ3aI2m7K31yf6s8H6mlaV6d91cR28rjg=;
 b=tdksL4YbEMeBOpD0j2m441vCRDayzoqhaV/Ui7SnYM4ZQNMqPvsecuS9Sn1DETUzNfW7/6XtBp1Vzp92VLyNTwRJznXM+ksFcbRIrJa9D29OLJuSMU8vgU0oFvNvDl24nZ3uKHYFVoG/5u5ZdIB30EkyC323PwDJPFIIVk5GTsiol3aQkMg4o2E+FAbveU8rKSxhDUeDcyfFVPKtP7tZFMY7htxGwok9B914dWapTpRTjmqaOi4LmYXdrzzHu1TOJaG3b8CPPFX0yAYZXo40Nv1GjGo2t4RN090yES2BLRQZ6aP0EcdqLLUL3uZY+Sqe3gpnnI9JglST1QW3IcLezQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.38; Fri, 4 Jul
 2025 15:43:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 15:43:45 +0000
Date: Fri, 4 Jul 2025 12:43:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
	helgaas@kernel.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH RFC v2 3/4] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <20250704154342.GN1410929@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BYAPR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::36) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: c139498a-295c-49eb-06b9-08ddbb118f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DgjcFVjutlgCGy6CzY9UZrd8IG1dxtTkDfb84eponxuIWblfkkN/FZwkjar6?=
 =?us-ascii?Q?JYO+UNDAeGkBZ/mrc9zZJtWZl+4fQ9aF3lGfOtEuQbuJF4AWodQkGaS7XSse?=
 =?us-ascii?Q?y+IDCS3LZpzkVxTmgglQ7RWfOH7RgWvAtUdMQ3YwGkRgMzJkMDWO0oIKv7Oc?=
 =?us-ascii?Q?B1O1PvuHLexS4sHzFomvBfwxVna2uiZzb4B5v1THnLdnC7DIWp8II3dTHerK?=
 =?us-ascii?Q?2W07gZH/zX8sT33BTcyCxcNvbOqFyfAIgW6ZouNWe1C3Q0TRar4KmJoexnU6?=
 =?us-ascii?Q?ed3cxJzMON6/G+O4od+kNWNdKOsxAY82vkufVls0kEjnevCljAmn2nhAR8RB?=
 =?us-ascii?Q?cj7t/w0uj535ZWOKZBEYSugWdgiT/D79KN9+mAYBt2r5XkmbnB7DM82idX4d?=
 =?us-ascii?Q?Thpl557B87mKCR0ozCXdH9XFzkivgQJOJO4+mRdlFzxcrfXo9UdhhtOasgPR?=
 =?us-ascii?Q?gdcgcI9BoWB969aMcqcvjtI2EmqirY78OioR3A47PMrJiYlw0zzcp9Y+15Da?=
 =?us-ascii?Q?SeaOssUJjna9Ktw9EygD1XmG5L8rshDNKW9fIrzPjy5Q7TMJHdeolz7gwVWL?=
 =?us-ascii?Q?//DCzU25iG4xvXa5VqVtzuVq1m0meQkCvYTB3Bgk/1ZHkXhjoALnszC5dYYA?=
 =?us-ascii?Q?PeXntBalktx5Nh8xLJl+GxVqKURQw/EqY5oNZbCDaKDHuU+8zt2cRh13meER?=
 =?us-ascii?Q?Wfvn0QJ9SuoRIl/QV73ysEE388VaC5yaTnhqume7gAtqM6rqNf53xQ1SuyDh?=
 =?us-ascii?Q?9NDQv+6x3W77brMtg+fTZvLkRj27Xaab5z9sxTOKW/GJdGPtjmjPysIlotAJ?=
 =?us-ascii?Q?NR9R2sPKWCMeXWW5wJRIfNms8SYfqbplL6Pr5y3fr5Xzj0MTyTWQbnxn4Ofz?=
 =?us-ascii?Q?4q+yJTec0D9TCPpKa13opY5szUrUlPwc5a8riV38xLBy7Sc/ox735IRiwzQA?=
 =?us-ascii?Q?fsJXMOq/mQageO6/u+pgrZLuzDiHKyjv6V7Fn7wqHRPH9MdiGuJD77LXwjQM?=
 =?us-ascii?Q?MlKcL2tLwlB6GhB9KzpWEoQFqmjtdagB8mw64ZiGhAG1EuxiYpCyDDGtY1Kh?=
 =?us-ascii?Q?vX37U4sa6+vzXc7pg446iUyg9KP8awD4JHumB3cUV+P7Y5CXm4I6ymVvzgGp?=
 =?us-ascii?Q?4BN6+ceidKOQr+n0ygI47H+Hj4WQ/Si9X/i0EvJOdatLbKaS4GZ8sAjT6jXw?=
 =?us-ascii?Q?88fTFEmD/hz8sLKCaJyQizNVF4ADMQMeDNBo4rsqK57YjFCRe23GqSw2RjjN?=
 =?us-ascii?Q?3D0wH6cMkoOcPNYwapLbSpDM5i7iqiOciY+ArfjPvKY9i26ZdDEa61FIU1vW?=
 =?us-ascii?Q?w7Volynk0TW/s+grbJs/A+OFh6YBTaV/G6q1yLtm/52om72+Q31Q8g47nc7t?=
 =?us-ascii?Q?9x8obf/7WGvAUhqmR7S67bgrbVRbNKRm+W0dPprRFhyI62jPXVupgSDLD6v4?=
 =?us-ascii?Q?SKisFmxUUec=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eCdRwXAMNeGJhkqiF9+zysK0zzavFgfe6OYd7f6fsBGkK5inYG+ufMEErk4x?=
 =?us-ascii?Q?aTVSyB6qYdgx4/OvXmCwdV62cN+abLrXKh/fxdt86kDw6y08C306uxjoJVYA?=
 =?us-ascii?Q?a1la50YCjasKoRG7XQTx9C7RxXYzfTSadVc6uqqypgxXcX1RXrsuRWgzd833?=
 =?us-ascii?Q?JHG1u/ab2HHREz/yXz2bnHW24FIAZxfNgU+GDkEORy8Dsi4WgkIbsd1s6paL?=
 =?us-ascii?Q?rqlGnZgc1zvnOVljz7VxrIGa45roqv7FG/fbbA4evYZ7IenAVppWtrDOAUYI?=
 =?us-ascii?Q?HXaHH8vN1B7Us89325K2XnuxUEBIVKl/tcK8z3Hi83iAFgNI5uodhfcB+B83?=
 =?us-ascii?Q?yv72juQvMGuLW5/VhGhNYAzjAtnA7TUIzdTnwrTjvbEgGuhqt0rPDPO+gb17?=
 =?us-ascii?Q?636h+4Z9rKsjwfUWG5goZ6BkM5ti7O8P2drGwcuCTKN1/FUtySj5v7YTEHUN?=
 =?us-ascii?Q?qRMOPgoc57Dh1SzhJUVcc4IUUl8LbBhFC0Gf6hYmMcpFRzEPbywwNW4SmV9u?=
 =?us-ascii?Q?kFCY6e8ak/ePl7vBooxo2SuSnP2XWDouqM9kW5HNGIYqKSMVbWaPd+3H8KX2?=
 =?us-ascii?Q?F88dYPJ9PGjGvmfvZ/jCHcGavkDKqZ1dplEQtQ3LYD+eGs4CEKLFmAvBXzdv?=
 =?us-ascii?Q?drgtYgZZhtEXDnem3kivgASK79Vn+DPGq5l07nAEleStKPGRzCIOlYOKWnSX?=
 =?us-ascii?Q?W1wA52RxKLpWJa1c3k4yOguXZGouTQ4rxL9nGMbtftqmbKpzUZ5ToR4IU8DX?=
 =?us-ascii?Q?B0JmDyTHQJYyw7XvNMVdFkEmdMl5w8ydS8Awc8kiVmEFciZr44TbSL/Ljhar?=
 =?us-ascii?Q?BfyA9I/U15KTupKCiwZ1W3cMepjT1kZiHPBEVa+MuR+nUGN2+zLJCl7HOLjy?=
 =?us-ascii?Q?4ZUUXEUfagTCzx3jeCuFuvl0DYgboqIJJi18JGRNEsq8E6KdMg/JqwW6fpEw?=
 =?us-ascii?Q?BVn6nKOS6LdAs5WDleubEZI4SJo40IP6Jt9K3B/lpfUuYBZ7tIiqMcpVqcu+?=
 =?us-ascii?Q?cYn0kMPpYz9SY1BO/MfOeRcj/qqbWfm5loasnNveX6IukiTcR8+oT8DoGfkI?=
 =?us-ascii?Q?IYEElSNvP4eeUzT5gm2DiE7vANSpnbt5gPh7CApyiW/IhdXdnSMGf9USvsa4?=
 =?us-ascii?Q?uVAwkLxYevdLasjcf2lStDzMIfYEsTFHFe6swSXWAS48584DCrNah/gqfbKy?=
 =?us-ascii?Q?51ggHvca4GMTi0JIsZRCVb6JrC9NU9LNsrRkE0ycFymsi+d8X8ncPhaEvkVj?=
 =?us-ascii?Q?thm4HDbHv4UFoADiz0n21J3undZbRcUtC/XcUcd0eB8sU4zS85RRl3tCVAo1?=
 =?us-ascii?Q?MF7+Hrn44fXRRYE/osrY2ntGJ88ZKTmCtb0b5qbQzBA2C0FYD1oWhZBsDjPe?=
 =?us-ascii?Q?zzdNRzW+c7UY2ip5cubR2sQ0RhmmmaNKA4f5qGGCS0oPnvHRGZL8aBXJTA/V?=
 =?us-ascii?Q?VchFkEtNSyUAdIBdv1lwjXbN17Xv1spLco1wTBKAFruvCadhY3x5v2KGHbbv?=
 =?us-ascii?Q?ZWoxF3ftsf7cuNzRXUCKOYRSbY9RV+4ATcvW2o8VIileHMipa+kj7bXaLXbv?=
 =?us-ascii?Q?IHkdSwJBqIKyNw8wUuwWTyXi+gD5/j4j/UDaT7GB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c139498a-295c-49eb-06b9-08ddbb118f47
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 15:43:45.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9I/eXdqMtL0AkHzrYAG5Q+ZdbwLvKRWYgKmOLzU/qOfhTVTuFWNs9xVFo3HeGa7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034

On Sat, Jun 28, 2025 at 12:42:41AM -0700, Nicolin Chen wrote:

>  - This only works for IOMMU drivers that implemented ops->blocked_domain
>    correctly with pci_disable_ats().

As was in the thread, it works for everyone. Even if we install an
empty paging domain for blocking that still will stop the ATS
invalidations from being issued. ATS remains on but this is not a
problem.

>  - This only works for IOMMU drivers that will not issue ATS invalidation
>    requests to the device, after it's docked at ops->blocked_domain.

Which should be everyone.. It would be broken and racy with release to
do otherwise.

> @@ -2155,8 +2172,17 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>  	int ret = 0;
>  
>  	mutex_lock(&group->mutex);
> +
> +	/*
> +	 * There is a racy attach while the device is resetting. Defer it until
> +	 * the iommu_dev_reset_done() that attaches the device to group->domain.
> +	 */
> +	if (device_to_group_device(dev)->pending_reset)
> +		goto unlock;
> +
>  	if (dev->iommu && dev->iommu->attach_deferred)
>  		ret = __iommu_attach_device(domain, dev);
> +unlock:
>  	mutex_unlock(&group->mutex);

Actually looking at this some more maybe write it like:

/*
 * This is called on the dma mapping fast path so avoid locking. This
 * is racy, but we have an expectation that the driver will setup its
 * DMAs inside probe while still single threaded to avoid racing.
 */
if (dev->iommu && !READ_ONCE(dev->iommu->attach_deferred))
   return 0;

guard(mutex)(&group->mutex);
if (device_to_group_device(dev)->pending_reset)
    return 0;

if (!dev->iommu->attach_deferred)
   return 0;
return __iommu_attach_device(domain, dev);

And of course it is already quite crazy to be doing FLR during a
device probe so this is not a realistic scenario.

> @@ -2295,6 +2321,13 @@ static int __iommu_device_set_domain(struct iommu_group *group,
>  		dev->iommu->attach_deferred = 0;
>  	}
>  
> +	/*
> +	 * There is a racy attach while the device is resetting. Defer it until
> +	 * the iommu_dev_reset_done() that attaches the device to group->domain.

"There is a concurrent attach" here and other places

> +int iommu_dev_reset_prepare(struct device *dev)
> +{
> +	const struct iommu_ops *ops;
> +	struct iommu_group *group;
> +	unsigned long pasid;
> +	void *entry;
> +	int ret = 0;
> +
> +	if (!dev_has_iommu(dev))
> +		return 0;
> +
> +	if (dev->iommu->require_direct) {
> +		dev_warn(
> +			dev,
> +			"Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.\n");
> +		return -EINVAL;
> +	}

I don't think we can do this. eg on ARM all devices have RMRs inside
VMs so this will completely break FLR inside a vm???

Either ignore this condition with the rational that we are about to
reset it so it doesn't matter, or we need to establish a new paging
domain for isolation purposes that has the RMR setup.

> +	/* group will be put in iommu_dev_reset_done() */
> +	group = iommu_group_get(dev);

Probably don't need this. If we are already requiring no
iommu_release_device() then we can keep with that.

> +	/* Caller ensures no racy iommu_release_device(), so this won't UAF */
> +	mutex_lock(&group->mutex);

It is the group_get above that won't UAF, this is fine once we have a
refcount.

> +	ops = dev_iommu_ops(dev);
> +	if (!ops->blocked_domain) {
> +		dev_warn(dev,
> +			 "IOMMU driver doesn't support IOMMU_DOMAIN_BLOCKED\n");
> +		ret = -EOPNOTSUPP;
> +		goto unlock;

Not necessary, just use the existing flow to allocate an empty paging
domain to group->blocking_domain

> +	device_to_group_device(dev)->pending_reset = true;
> +
> +	/* Device is already attached to the blocked_domain. Nothing to do */
> +	if (group->domain->type == IOMMU_DOMAIN_BLOCKED)
> +		goto unlock;

Should be group->domain == group->blocking_domain

> +	/* Dock RID domain to blocked_domain while retaining group->domain */
> +	ret = __iommu_attach_device(ops->blocked_domain, dev);

group->blocking_domain

> +	if (ret)
> +		goto unlock;
> +
> +	/* Dock PASID domains to blocked_domain while retaining pasid_array */
> +	xa_lock(&group->pasid_array);

Not sure we need this lock? The group mutex already prevents mutation
of the xa list and I dont' think it is allowed to call
iommu_remove_dev_pasid() in an atomic context.

Jason

