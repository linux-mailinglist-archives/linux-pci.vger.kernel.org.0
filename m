Return-Path: <linux-pci+bounces-28675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BFFAC7FBE
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 16:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5099E1BC00D5
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B8A22A802;
	Thu, 29 May 2025 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBI7OCtK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B521ABBB
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748529165; cv=fail; b=JgwWUZ4vC8ZPBTUAIyp2qH698CXE06sfFj7rT+sVCwS1aColY8JOOo0u+RELxk7kZ9aDj6Zs8eR5tBvhUXaRJVqMeMxXr3HM3ZwNTdoCIRy92cyole+3IEAZ+nTFnWirTx+SVm9lVJT2ujvx17dCEmkyYZHEGRvI7IyS2c5m/ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748529165; c=relaxed/simple;
	bh=6NWcDxEAnuPZJ0+X3VIszpZXyUN4RhBkHjLbt7pELpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dcyjeLRUBgaycrshK3w1rC7MYRSMPaLFxosMosad0F2HcRy+MtRKf4RYBr8+mtjmGIoAsel1Cg5lyWdwlE5yVSeMEb4s2Utbru060tl/zCyY02HMsYiyN0v7Lh+i3ddi4CIl9QrwZ9jiVAYdglQfSz9TPRMLvSCu/6cvGLuLKxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nBI7OCtK; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2lvRprZG8W48VWegw5IPd+LtPbSwnWlcsy+pMurJI/eqqA3eAydgDQ7FswQtHjJ/IRXlSBV4tYioUcIl197KS8rw6U9Z3f/VLDxClRFj/gMjNb05Y1ys/FHM81hX3Q6D7JCEOU7yNzGN7CDqM+yADGg385ztt1s5UJchn0b/aGcKpD9FkqwKtjjK4Kjt9CDJVL44cn8blmUJjmlbZ/xbArDQa2OaXWSA8OVDA+AzcJUK+10jgRDnNsTe9InYD/G4StakSLtI7odoQLZLLKjYIM9flmpP4LsGs4L2D48Kj/5Xis9AwhLqycXWcI8+GbJ9BmzLfMRQYg+D8ZjmFxMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGXn0tU9rL1FfrsVZ5dA4Dm4oqpY9USoDDFnX18rnPg=;
 b=Flcdd6IFq6+qyOTuIIuqud15xl89x2JsgImoO2uWCdYWPoGiherE06C4pt96KFnRrNnpXXqwWE8/0GTPIz/00NYB0cjS0iQeP6aRcRJpRnHObs144fcLtoOVqg+J7d/cphg/U5vbJODY+VGpshbYmGXmUYlqkoGY3213mkRBsOzumRLv7u+QdJ4cYpw8R4qybiVamgRP92A0VYdWoMOgedXd93qUy3C92c/TlWZ3Pe3/vLo6D4A9aYScXsveaZXKObTkVZTjYTCvU440PTjd83H4M/Sf468ULIwDmvbid8zngTtcv1KkB5ZU3vwYezPDuSKBey5T1E618y844ZfYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGXn0tU9rL1FfrsVZ5dA4Dm4oqpY9USoDDFnX18rnPg=;
 b=nBI7OCtKbtcLYUSiTJ/Oz6yQVJxHtEWNkLwncFntkZhOm2yjOtUwxka2WbLUQoJj+sO68D8hRnh23Z+1tJJsYt+Zb22TALdcvMRCuFCHzk2CgvJ+rTm66cocWfK41cqN6TKg0ar3HO3naoF4qXm2T4Cy7IVVylLQ2c6dxYZwhLRpDQ2QnxuTPJHLlaJxbieyCPzPWwv8SjlRmV74GWYua9CxTCMVoY8AXNo0nJ9VVdJ6br4E6H2dwLdUXYx4307aTznt68Yq3+btt3xXorr9b6IL66v9Mquc56bOfaJ46Lrj++RfUuBh6+zY2fIYAxIFTrVEYUbHWYQxBaCAzSiqHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Thu, 29 May
 2025 14:32:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 14:32:39 +0000
Date: Thu, 29 May 2025 11:32:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250529143237.GF192531@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529133757.462088-3-aneesh.kumar@kernel.org>
X-ClientProxiedBy: BN8PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:408:4c::37) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f7fd88-015a-4230-4cfa-08dd9ebda988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hfn7CiI/KG929ydgnGrKq9by4PADyYXnFt4Bio/yL8BBcan9DIuRa1vkY1ir?=
 =?us-ascii?Q?xaqYYaoteAI+/fTJ801Ob+mN6RJwy3S9493ujRDp01s7saDJecsvC1p8mfv/?=
 =?us-ascii?Q?GmD6zVWVO/E7beSE6IuzOe28DOolKRL0vc3aaYb0nQGSF40rB9qziaRzRhDK?=
 =?us-ascii?Q?L2IqRoMgHABB+tOJQ7DeU08AN1BOZNGAQO/JVTHmkX1MTLr6NZra7dG02qkB?=
 =?us-ascii?Q?t5L0VqW83M+tOIEUcqTSxkiCYaPPlFlHcv7f2EJkci53N8zh5cGCAMsmXUmj?=
 =?us-ascii?Q?ukiA1ovqylIvi/yfSqQ24IvVwvZQm2q6N5jEyPrywWjoRMdAAgvv8rSFmNgn?=
 =?us-ascii?Q?021AQgezXsmT1LCTMWkXqyFJeE1BZuUtEIB9JGfF8ynRLvKIBzx4OwTdYAiR?=
 =?us-ascii?Q?MZk/QxCVRRa23vyGM3Cx95CgswfxoPS6sVE632JKDnO2uQuzqoAlUc+9sczE?=
 =?us-ascii?Q?mvtlsYpnQprx9yOspV5uFhurjgwUhA6t50mQqV0Y9l2h5P6OHro7Sh3anP5e?=
 =?us-ascii?Q?XsW4qEbqhZYUUmtxL4aD2NG9+OTf7xRHfEDJGukjV7XIKQMwGve2eINWlpor?=
 =?us-ascii?Q?/PeBGHVoeSrX1ZDZP0pQCcTO2gejyuEuu99iU28lOrkm5qEGUsRP8EoQZKYI?=
 =?us-ascii?Q?hs3SMiEDijTKT/moJ18E3iUPaPfRkrymhLk7c5x6gc6Q7pCIroqbYhY8PnGL?=
 =?us-ascii?Q?nN/nAo5oAAW8zSSZ+V/mrHvcQ98U+EIgqoMj9aaAkMFOJ2MKUHy2zDjpgjYr?=
 =?us-ascii?Q?GhsOPrfoGrrF83TjNNKTv8jzbRHz9lY9N5zWn0ZfdAl7HXf8J37pJ0bjd0rb?=
 =?us-ascii?Q?try2GCCwB+zyIq4ky5LBDo5MaJiZGrlEsXsHYBZS5eB4mR6FXJ2VtQ0s/u0j?=
 =?us-ascii?Q?dKm3x6Jl1CEJwJK+k3yTYaquKPU5qBuivS6WLdYBD0dR4OO8CILDft/mirJY?=
 =?us-ascii?Q?qmhIW1GkxmAMRuNiVW/HFARFxWact71dJCFvKs9PmwMCgdXzLp+G2OPICUkJ?=
 =?us-ascii?Q?yhRuOvVG+wvHi2g01QqDPegx2FLe98J4V+RC0SoFBpaQoiLVOG8npzhPl1SN?=
 =?us-ascii?Q?E6LM4lByhAOjlKawTgcU4eisUyuJ9AI9fylTHRFJL9H6XWEO3BAinY53ouz0?=
 =?us-ascii?Q?hvD6+T6yOAKNiOZ0AQoWuZqwY/0zRRVtUm5j4HflxsupALM6UOUlrGq2HJ4v?=
 =?us-ascii?Q?vH250ZlWxKqyQGXBnS29ISv4+TyF/xKJfHGzb2RagFP3hs6vCvmZjXE/JE5Y?=
 =?us-ascii?Q?y2tb2cPRYUvBMIpkbgEU9hGMs6no0WuhDTEP/N/1FLJaBJRJI5OGM7/CqvvG?=
 =?us-ascii?Q?ie3dAKJ5TPfs7sH5/B5YRkQKWKFVMRL+KiWSbBYggjQEEy4Esrc1ygxqRkDV?=
 =?us-ascii?Q?dTA+HJL5F8sbP89zvIHH5mu5olZBqh/SGMNAbrka9Wac0UsMzegB6UUHsAIT?=
 =?us-ascii?Q?yb9C0QNEr+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Aqhw1pEfvpQC682l4+fn3cyz8dYmMuRg8Zt2SkRhyU4VMYyoYPjA/tRR7M0x?=
 =?us-ascii?Q?7SU3PEoKT3/MpGPrlgjCz5HkfLD0Ptzpfnk/jHXNClDQrWcViWBKGxaR3/dL?=
 =?us-ascii?Q?ZU8njQldJ2BXpbPpH0aj2DXQ2erMVIN7kSH/fM/RW5MjK3haWMPSKeUluqBH?=
 =?us-ascii?Q?sRRz5HkBC3K3delLikD467KqrzxJy/SRrOMExhbcF9c7JwD4Y9mYWSbfDEjb?=
 =?us-ascii?Q?jH9Lg042M39hrkGYRt8m2lHulrdBjnjriFver5yYBo/jsDQjZe2E3/lUzG78?=
 =?us-ascii?Q?5PLUGyIh6MkI8Fh0Qym8LqfXSLuheHVf2ayHyNMs3xszjYFCuxOlpqvqoW+K?=
 =?us-ascii?Q?imciL9ooyVXLikpzpr874WK0Pj4kWrUMdFPviCkN7xY725AnzJ1qI3MVTjAC?=
 =?us-ascii?Q?qSQ9CPJOB6ZqKVZN6rKuzcUUbd6boMNTmSoMFMSgXaPBG9L1azelG/27AI9T?=
 =?us-ascii?Q?YeKaCkU9WClrO2zQkfRjbdURx7Ppq9fRgImJw1aKW/9XzoY6aLrw2waPw7U/?=
 =?us-ascii?Q?STKeUiCKZtAUeE33ReOLozGkOlR/mm2Qx0DovNYgF8ShJztT5RnfQL+8/Sh1?=
 =?us-ascii?Q?l1wbQ7tYIxYbuufkzyovaZRxhlGzaP5c9cixFltzXuVZdGQrp+4nTrN+jNvn?=
 =?us-ascii?Q?8lTLoRE3mJ4gfWxptppTsTWtCUoAfiSbjkN6Fbpcwk65xuZr+dSNe88Fo46F?=
 =?us-ascii?Q?KzJeefcIQsveVP3wcA2ug5S4M3MnxMeFINQaCUxplS6/yhaNHYfhCivx3QZi?=
 =?us-ascii?Q?qW4h2+7Io4l77b5jFOO3abK7S/zPUMSYqSm7TorCbIhohLFQs+emydheA26U?=
 =?us-ascii?Q?Etwpsy3M4hEa3BjySRw4N4uIfHm7C/0UZ5Gz1o1HkFROLXiX0mP/lPkHJ8Bx?=
 =?us-ascii?Q?ReuATfxXo6gGZUJ6T3Ze3s7cDCv+rb4BtZZiPk7J2wGk5uopuLydvhFF9QiP?=
 =?us-ascii?Q?b59We3+0fzusdtMHo87XnN6BQHT+X8IROqsHYjpDYYL8vTp3wz0ZfFuCFH8z?=
 =?us-ascii?Q?LYuSS/g0CTA0k043R2L0GdVEoot+EQXgvqfXOSLEQlHjENL/R2z5QEUJeTeW?=
 =?us-ascii?Q?ZNjea29L2WBaWQgb48XjOwMHn87AV5WBgx4taf3oNKXAZcF6Y0wxtpFo3WAx?=
 =?us-ascii?Q?wsOuBRdrb3V6yXHH8Au/l4J2lExTvI8E2eNHUiXD0mdxDN0Tmqlao+ko8t8S?=
 =?us-ascii?Q?/IU9lFyZQIjpfAC5lAw4Q54oyL/3X8vP79V0Hiu77KIkDZs/rZBGfEqIs2GZ?=
 =?us-ascii?Q?/O0fQIGqycExeZbTAEYaKRY6vjrZEFUW5SFboP5pEEkIyZaCFDRT2WKbUAvn?=
 =?us-ascii?Q?pD0fpOnU2m5CdKR2CblnYXtml5rmXtcenFDbGFBRQ/doig1ybu6K+Fddpm67?=
 =?us-ascii?Q?yOuoeKbx9CEVHu8eqMsaZhv7CuNOxwdVkxbXOuv7BtWskXmhS+yAdNYKM1jF?=
 =?us-ascii?Q?rOj/GyteJnf4R2E7ETn2KGG0nc8ZZcIdmeFmOv7UyARDasyn1pYEvdzLFtxI?=
 =?us-ascii?Q?rHUSf1/+jDnyj/zIioL1zoCqWOlRp6tDZ1i3NTKzptD6qImqEbXUev+2fOkT?=
 =?us-ascii?Q?76+YUUfLQK8cRy8YZQmtkQOhhv0A190rdthc9azd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f7fd88-015a-4230-4cfa-08dd9ebda988
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 14:32:39.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqRJK9rEXAuvxmv12RKiPwt/0IhrF0/3Rf7vo0wnffj4W2wPpGDZPmsIxVUmA/xl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888

On Thu, May 29, 2025 at 07:07:56PM +0530, Aneesh Kumar K.V (Arm) wrote:

> +static struct mutex *vdev_lock(struct iommufd_vdevice *vdev)
> +{
> +
> +	if (device_lock_interruptible(vdev->dev) != 0)
> +		return NULL;
> +	return &vdev->dev->mutex;
> +}
> +DEFINE_FREE(vdev_unlock, struct mutex *, if (_T) mutex_unlock(_T))

I know I suggested this, but maybe it would be happier to use a mutex
in the viommu?

What is the locking model you need for TSM calls here anyhow? Can you
concurrently call tsms for vommu creation with bind/unbind or so on?
> +/**
> + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
> + * @size: sizeof(struct iommu_vdevice_id)
> + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
> + */
> +struct iommu_vdevice_id {
> +	__u32 size;
> +	__u32 vdevice_id;
> +} __packed;

???
Why is it called vdevice_id?
Why is it packed?

The struct should be per-ioctl. Does anyone need a TSM specific argument
blob for bind?

Jason

