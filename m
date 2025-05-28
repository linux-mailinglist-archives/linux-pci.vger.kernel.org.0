Return-Path: <linux-pci+bounces-28511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C940AC6E6A
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 18:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316867AC368
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A517B28DEEC;
	Wed, 28 May 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OzfG1LnS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB728BAAB
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451149; cv=fail; b=QVjdDz1zlAIGFURNq8kQXyiuCeYXCk7FDmT/dDJgwWhL4bB+bEe4fp7IgglOvdMs9FbWByDCRKW6uKhKnb9cZyAlWW/x907XlPi9svCSIKBjFw67iuGvAiL2IctdSSFmITY6U9QnncQXJ+F9wLRJRlLfoLB65ncBrbHjkdjp62M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451149; c=relaxed/simple;
	bh=bPhknB4tPqEXcnxbqcCKwcOVLSwTxBVTrlZVs24BXb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UyTqyHjYQxMINJzv8JKigN3oDUy1ysHaIvUiYiUGTz5EIiTT2WWINIcpNwzaLWYySIxG5gtcpEtGwEE/AdXIA/IuVb0cJeVdMHs37S6YX45nXDV5d5J3IbotwEQwAbRIdR0Awmb72RR76aM4XUplEme6uRHtevL9aj/aj31z3rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OzfG1LnS; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oV5R9bSmelKUFcA4ZdUukLDRW5Fev0tL4UK3qPi/t+xyG/OdafM6AuYVX2Y+Qp2p3obpzmKjGoK6a/uhXmfHhbuORFxL8SgwBY9RE2LFAsMITkZPRm9oBysSZvKFU7UWsjiD78iY0NBGm4oNLe3f1M2NygZRBuoPu9EA/YreDbwVnaE+Zyj187zPuhrI/YIA/HDOaXAvlyNL/i/rwYb76LCuG6yAfbUP3etRdh0sygtqcUzdInwA6oZtP5tuK9GQFho+WnPvpq94DzpOgHd3Zxm17YwA7PCKv+3ewo+DiJhgy1pz0DAAPSAegtlqsDHcc/BPXQ/ByjjLyml+FD6F7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9LtakincRnYfM1NqrCfYWjZyklpzIB1w1dP64f4la0=;
 b=KJcCdOuI9hByyHsknB77Dv1TkGDtP93TdxVCW18oyed3Bzzn0I4dGurX+TTaIxUUceYu3glYG92eh3w+/bcJ4fGzr0szzBDKTowqtQHqLlARWbCTBqDTdES2kzMW7bV0PNI1XF+8f+PtWtYtCqXLfjX/quxmbb1wP6WEqBF2bgXQRIYcz87/X0JV3S3WBdG0dwkGmL38bViiCK15Z8fa3fBf7/PDpgFHRYtfWAQivbFvjjbpR6iIuCBdvTpz9cvOoypeogUg41JgNwBosvJuiXy/k5IyJ/M5YeRf5IDgK0wHVT6jNzBVnxyW1SrEZ3XfMs+m798WFXUXA7GWygDWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9LtakincRnYfM1NqrCfYWjZyklpzIB1w1dP64f4la0=;
 b=OzfG1LnSJ5gwZH+MNIsWmvEYQKGpRPis9PEkx+iz7BYjjg6YI9t1D7NF/Lix3U8outEt2RIYugHdwffIJqXwKh0UtNlVK/juKU4V9F8u0mdrFEYnC/0r5AubluNwgz9+CNxu2j7TWDKpz5GdroFuyzopabsK5zVsPFQm/HWSylyGlhDgfLStBUVQyDrxBcnQIEwNmEYRXafjmn/pLLlBgwyRxSHxaxqzdwk2sieki9O+uLXLmm4kF44k5W9Be7K0o1DXRu8/830EF8M1kq5NAImbz7m7BkXGy1B5kT3aqvk8YZjda7lMQvDMxWcaTOezETwk2vqNsZwNH3AA/rJYCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Wed, 28 May
 2025 16:52:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 16:52:23 +0000
Date: Wed, 28 May 2025 13:52:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <20250528165222.GT61950@nvidia.com>
References: <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
 <yq5abjres2a6.fsf@kernel.org>
 <20250527130610.GN61950@nvidia.com>
 <yq5a8qmiruym.fsf@kernel.org>
 <20250527144516.GO61950@nvidia.com>
 <yq5a8qmh53qo.fsf@kernel.org>
 <20250528164225.GS61950@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528164225.GS61950@nvidia.com>
X-ClientProxiedBy: MN2PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:208:238::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: b123bc62-5ac8-4608-5069-08dd9e0804de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bT/nQD0DWiBat9Ofmn1ECVtZ0+z4+V1tFm2Sty8RJQKzOK6/2KdAELhQivRG?=
 =?us-ascii?Q?3SVb5mJ4EN5koYcBIpAjxUeMnxeBWuCbyuAB9cvry3u+DcLppJnykbr6mZn8?=
 =?us-ascii?Q?xrKdciVbIEng/XuDgZSumZvASBh16l+flLySyN22ZDMaLn/hFZTesPx+5lqi?=
 =?us-ascii?Q?eSzeVcVkKu0Jqv0MYgGcfMCVqF+1MnWk9igqibD9c+Uc8RJeDZY8TP3pXGBh?=
 =?us-ascii?Q?L9vffo0c20c1/w5xXSJ/Z12KUznj+Cg/o3hGTeq66BheAwaH9wOrJuxP+CTN?=
 =?us-ascii?Q?rmmKVo2e4KWtlKXOBiN5xGkY/hS7kCBnN47mkoEV2hIqhqZGVvq5A7gFeuX6?=
 =?us-ascii?Q?3nVVz+EjEkS8+jXxRMW0ODXbsroT4L47N0H48t7wb20dcqKZLUdMX7VW0ET+?=
 =?us-ascii?Q?LjD9eREXUW0LOfuHoVJGZtgXQzWoGHTen5hBsHuEIyV+/9JkOpEACK8Eb8IX?=
 =?us-ascii?Q?8L9ZZug91BqRwkrNII99YrzkP91pMtKp/vjUEMJzFD9vPrdVH8JhTpE6q/em?=
 =?us-ascii?Q?yZbOrxPyEzH+o05/CWZL7kaIhyzILzf66ZeeybjixXkNw/KsloBP70JqcRzo?=
 =?us-ascii?Q?OJUSOGciLPs3uAZ3hs2MpPoPtz00QGWCwQK9dwgaUWqcXqvw7P0Alpbs1Cpp?=
 =?us-ascii?Q?WictrGshJEO1jUrv35L1LYdZR+1oxTSvLDWRfilF0tgq7VUG2MODEaaVuPDC?=
 =?us-ascii?Q?obOit45zRJFpoqNtPRnHFYviW8igS18oxmEcEkkM5J2V5dbMHktYDTvKLnzO?=
 =?us-ascii?Q?7FQ3FLwq6i855SNupjzQLYrFjvLYBm65/5oNjnl4upUudUDTD/DuhW+KHcNZ?=
 =?us-ascii?Q?ffwghpSjZuK44aLnAMwosXTpN+eLuib1pnpK7q1JJ1gNrz9ANEsid6+osPD/?=
 =?us-ascii?Q?2s4A7m5VH2oUZto1Pkm0WUgDBOB/LrK2XMwUw4+aKa8kWsxUFVHxfgrfhVC8?=
 =?us-ascii?Q?6SN9z4+vr2W/h55v8h+P7AwMRjEtYjM4x/yis+z18O+F4qOcCIomIAM1/iZr?=
 =?us-ascii?Q?sKp3XkhwXWyjYxNXYEpnVr0bOcX4Pi2VeHNbRy50t7Injwb3DT3ETDKjr3dk?=
 =?us-ascii?Q?egvK0ZO7zS680vP/ZALXJXBT5l+BkxfPtYheyFz9+p+cBdZ8ImddP+OZWwvW?=
 =?us-ascii?Q?bc23I5k/wVzY4erde77sZetrt442fPyv7A7YC2pzOoVNO0drCrc4G5bvslRr?=
 =?us-ascii?Q?8r1FWWT6ceF2GUGz7aRF6YHVYAXfuEliKmBG786HkkEAaAB+5yLzkt4itz9v?=
 =?us-ascii?Q?ELsY5BCXryzuujs39OJPZ7aG+6uemPH0NBVePe5vuUV2YHAKgI9JQIDPbGfU?=
 =?us-ascii?Q?ry9X+22hAqpLW84dmLfM2avZSajy0MbRAaRaOP4cLFuGGp6U10KvqAvVHfyP?=
 =?us-ascii?Q?io/bszDr/dnVWEJ6sc748Bc0lKvS05FyPHSk11arf9cj+QyMAA0PdvWdRJWP?=
 =?us-ascii?Q?32rCnqfEhmY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZTA80mvd/O+njwOr1ZlSa92rzLaIvEgfPLSfPhP7KSrGsaltt9GorR5r7Xrq?=
 =?us-ascii?Q?tPbT2SxyjxzMEJpdk+uUXUKgJ+zagp9RPcSVZjZYi79Rh8fWWz1L+khnUD1z?=
 =?us-ascii?Q?UkwsL/2ZVUhW4SYETBqg0SIw6BgUNCii9mMNZH1pMkJAPqHi7kZCYcBemzU/?=
 =?us-ascii?Q?YZxSZ/FDnyOOpOtMTA3iInKUAmyk0JYFz/kOwWW1onTLwn2NiaNumRBaONzN?=
 =?us-ascii?Q?1/Wzps8hNhdVor5aqwt9Gqdf5dXNw/8JY6QY4qjbQ+cIKBNsQVy/gioElrPu?=
 =?us-ascii?Q?6N9ovEhzXpx4vAeVNbdUWarj7phsdmWfXO93CUkUZ0RkGLch4gA1FaeSw3LO?=
 =?us-ascii?Q?p7G9Xd+lIwOo1y/BbsPAr+yGn/sKaJYxyrH1WmVEyuHc7ADxO9RYKABs3HaQ?=
 =?us-ascii?Q?Nqtwp94TZDpY7n/SZWe8FoBACeBjEx5Kpe6R4Y7wCGdw2H3K9UgIkgJjbr1A?=
 =?us-ascii?Q?08NA/iUGLlSMQT40OVisN65/xqQ0YjVRDg3q9jOjlW5+PtsJJfGN4+Dl7K4U?=
 =?us-ascii?Q?+GPFTSKI/Q5OTHUzUxWXZvTLylITf6E4A4zvnA7C0ki12GGEqHFEDO0AHKU5?=
 =?us-ascii?Q?CEwGZ9HNZvmJQjw1a5SsGuCEGM9YMkrVgaQu6T1yFkW2jD/aoFMx4Zif/ngl?=
 =?us-ascii?Q?ddPRKHJNT8k+VJbDhjK1KCAZE1TuL8cHPTTZMmO8RHxHJ8BtyCtEQnQIQdm+?=
 =?us-ascii?Q?IJ0QBYnVCELETfTLAscL+0OlaUbJWmN3r8qt58M1FitELrOScgo2vFrT2zDx?=
 =?us-ascii?Q?zdHpScabyuTUVAFLvpeSzw8zPf39g0/qo54SWWU0a0isSIU0OCfrUsacnoYp?=
 =?us-ascii?Q?pKTm6hd3D3VxQPuA8OWv59WOEP/W/OhTc8Fe0ABQQnl/rSJPJSWEBjn0pAUd?=
 =?us-ascii?Q?xyPrIjZOX6W1KwxKmR54BvtHY2dGufSlzvy3H64qOvUFJEV76FyaB7cGR1/+?=
 =?us-ascii?Q?/jf5ARGOwaC1SFmIOAUUfyAAtQSqD3P5maAwS1UefH3W56Pf/J34GetRoAGg?=
 =?us-ascii?Q?INVx2h27NoBBd/vuWQyEAm4ESsy4KFhh8QrvXwFFRuL7N+Kc42TPQrLuWDf5?=
 =?us-ascii?Q?b/GqU0UrUG+kuesJIh5gl1vfmCGz63EfenvcMLlTvWzMCydFMs+M+/mgXnjB?=
 =?us-ascii?Q?01rfkMamm0FENCHeh4HXCt3BDivG5vK3RR5v07s2oLyqolnFdkUCJUR4xHaD?=
 =?us-ascii?Q?i/GtnfNC685BuCPcRxiSs60F+MeDZtJfwA7lkJfXmzwtvBXZRnpKChuByN3z?=
 =?us-ascii?Q?nAjg7MZHh8HdtTaXnrPlOQPhLqxo/cXkPSdGkeJILnP2tgs+Lj9hFV9wfPSN?=
 =?us-ascii?Q?A3MW8T+L5Zc01YuDYmIeia97OEMAf3x5w2Dm2HXU8phpeu2Z1oT45TAGO1YX?=
 =?us-ascii?Q?Tv1uoYTY+OKVW0ZoHmVFrGB101Fss+5OJaEVAtPk7atheHqc7pGK6bB8oLom?=
 =?us-ascii?Q?8JYCUjGBRCxMLA6c0r6lbR5tnAKawXw0FZTsRVYDtibseqtSKEGFXcN21iUu?=
 =?us-ascii?Q?TesXYsr45f+yhypuGKBr9svJZpcKqicixI2VICLnS+68cvlhKJn0j5X5GBTs?=
 =?us-ascii?Q?A54Dvb/k/rMBYPO2BrUSZ6zip0FtuxWbsWHtYj6G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b123bc62-5ac8-4608-5069-08dd9e0804de
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 16:52:23.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HFzbmplfAGSnnfO5pfqGFxUpPiOo1sEhx+cM+NQRdGE8LLJ+CUyAImxCvtOZuHY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938

On Wed, May 28, 2025 at 01:42:25PM -0300, Jason Gunthorpe wrote:
> > +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_vdevice_id *cmd = ucmd->cmd;
> > +	struct iommufd_vdevice *vdev;
> > +	int rc = 0;
> > +
> > +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> > +					       IOMMUFD_OBJ_VDEVICE),
> > +			    struct iommufd_vdevice, obj);
> > +	if (IS_ERR(vdev))
> > +		return PTR_ERR(vdev);
> > +
> > +	rc = tsm_bind(vdev->dev, vdev->viommu->kvm, vdev->id);
> 
> Yeah, that makes alot of sense now, you are passing in the KVM for the
> VIOMMU and both the vBDF and pBDF to the TSM layer, that should be
> enough for it to figure out what to do. The only other data would be
> the TSM's VIOMMU handle..

Actually it should also check that the viommu type is compatible with
the TSM, somehow.

The way I imagine this working is userspace would create a 
IOMMU_VIOMMU_TYPE_TSM_VTD (for example) viommu object which will do a
TSM call to setup the secure vIOMMU

Then when you create a VDEVICE against the IOMMU_VIOMMU_TYPE_TSM_VTD
it will do a TSM call to create the secure vPCI function attached to
the vIOMMU and register the vBDF. [1]

And finally bind will switch to T=1 mode.

But if someone creates a VIOMMU with IOMMU_VIOMMU_TYPE_ARM_SMMUV3 then
the vdevice shouldn't be allowed to work in TSM mode at all.

Finally IOMMU_VIOMMU_TYPE_TSM_NO_VIOMMU would be a "NOP" viommu type
that enables TSM support but has no vIOMMU and works with all the
iommu drivers.

Not sure exactly how to wrangle this all, but it should be done
here..

1 - IMHO alot of the architectures I've seen have messed up the VIOMMU
design by having completely separate IOMMUs for T=1 and T=0 traffic. I
hope people will fix this and allow the secure VIOMMU to translate
both T=0 and T=1 traffic as walking page tables in secure memory and
then rejecting T=0 if the final physical is secure memory. Meaning
from an API perspective we want the vPCI to possibly have a working
secure vIOMMU before we reach bind.

Jason

