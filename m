Return-Path: <linux-pci+bounces-28673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05988AC7F87
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 16:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B263D1BC5F23
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857D1C1F22;
	Thu, 29 May 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B6pwSGSH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F96C147
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527986; cv=fail; b=okDR+O5j4uXiGqZNodkmmS8289uMXHxFARGQV/feUSjZd7WEMj262OsKjfmzINX3Fg89oVJD/FJ3YTEq63QdIST2q4sqjnJwXRnnJGllZ9uP6XxjQL1fW7MRkYckJ415l8L+Q/IDQHDb+qKEMPGDs/3JPP+K/xR+H9T9P0E2SFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527986; c=relaxed/simple;
	bh=uWjJQXvr2lvWUsGTIRbXCKK7Y3ZHj7M0qyqCljH+kNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aJ0U5IZIaSKyOyOvrPrQ39ei/9Yl3XyV5gRaOZkmbaAKnlFtDhe/9690R7W8ortF7/sRGi+2WSkUhyqm0yXwaZm3OrUaqQVV7yTsvEQtj/Gd7ubuHK3hQwiem3MwUyh54jmn4j1QkWeTu28BE4eCPFznj4j9JnkJa7LO1SGBFns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B6pwSGSH; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTBeIq0akDe7N4SgCmtFlJLcqvEJihN2GdTkwgaAhpU0zfZ63wUZFLTJaczHmG2xOieiofLZ0dFZab5h8+GwX+EpyEzPh7naCz0QYcrkLt2zO7MllKpNrA7Dcw4n380+YHxlRXGVXAZRQARq/rOabyGD4gcCkS5sFZhvrz/ZFVVuXpGT1UraXy3VT8ytMkrfzbA/vvhiJzrOnz3JF8SrAxDLBY7ckm+uYrZmz/YTtjmJcNm3WIV+lPj84fd4GNwvLY9I9kw0OJ1Cgfqae9dhrNTrSo+CNJpAKt2t0J2ewEz2G4sUw/K200kmb0iLLQ8pPcQDJI2sOtuijgyKErkdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2G+5UQJ+nKRoUaqjDVn8u1LVUQh6kvclOnNdT6ybS0=;
 b=Soapa7mkMPN3p5YI63Gdwfr/BAWQlYlYkFQU4BoGhX6erZ3n8n4yfvXZByetK7MUbqTG3MKtZNnjDH+9XQsqp/HsAcEdMNPgAh2l7bARvW2WYHLviuBg3SFrq7HFRlQ3TiombqM/cv++nRLcnw94h1V3+PLG1/FHcNNQaqRZ/oZUhCDOacjpe7+3pNAlwcwxXaObUVQl/YjdIQveH6gP515OGcMAngGD5OL7ZAPjEBdenF3L5aFqMncJJeGxyHjf+/gRK4nNoe5EtbhAqisSYTArmSfZ3lN23PKDmyaFtRA+TrlKx0Y8rTJn24RG9PDsHchG/Qtdydzzfb+buuauIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2G+5UQJ+nKRoUaqjDVn8u1LVUQh6kvclOnNdT6ybS0=;
 b=B6pwSGSH+jYCHqrTAwKNjVd7LhjJP5N8NLAqzQszYCU2kv5FXLF5TFzcEdWBVP659a/VYVvxnDXan0IGOMxV8iIr/8eom9PmBTXnKGesto0Jx/KqSVRToWwUPOAKSaIzdvmi1vBJZSZanG38cr5p+S5CypAS9XuxQbgCJ1zpyeZ/Tppg5x/Ib2LECovT3wLr45MEIowlcbEyHFrxys3SbyeoEmguZUaYwNIpGvb2z7zYh1lqpIKaEZId/AJrESxHhoko5GcjNCUyjuKZOn+Nzir/fmaLzv6gHCq8P3UJ3fv57wdwAMgD9tAt1cn+fBfwSWvrQp+h9+q9NyGA341BgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 14:13:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 14:13:02 +0000
Date: Thu, 29 May 2025 11:13:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 2/3] iommufd/viommu: Add support to associate viommu
 with kvm instance
Message-ID: <20250529141301.GE192531@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529133757.462088-2-aneesh.kumar@kernel.org>
X-ClientProxiedBy: MN2PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:208:23d::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: e48afa05-547b-44b8-041e-08dd9ebaec54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VdphWFZTvuKxYVP+v3Ny1APb58aXdNIbl4VBMAjB+32qSDQLwbm4QS1a5w8H?=
 =?us-ascii?Q?KcKNVtBrEOmnDK4b6e+saJ7dsX8B7BIPhsncojH3l3mdrUtG+YwSA0tZ55Nt?=
 =?us-ascii?Q?TgyPqC4d+VDG1oyJjtD91CokMo1AcSJfFZgstEZ90jIVibKfEEw5M/moVPYA?=
 =?us-ascii?Q?+5crbH2DWaXVH/xoItmKkDn8fIvzlJXx872ftqnoBfT2/yp6QtsRNZyZ90+F?=
 =?us-ascii?Q?y9U4zZydd8P6UJe9L10punRageULz2C8WO73G2lbVMsljcm5PIwsN3njYbds?=
 =?us-ascii?Q?Pn65Af3kFqY425K3T0cImtAAA0tPzpkYECmU58T+QZVpl6jlRJr3vfTcW/YO?=
 =?us-ascii?Q?fmz3cYsPnuXRipVDKDHO2+08It6rSwIN4rzw22A/Pym/P/V16g4ZNLgzxvqv?=
 =?us-ascii?Q?hJTLo65KnIrrh8YhqTqmFUGxXz52BT7ZJxQpkSUFn7PqlpVOMcUjOIPxSU9G?=
 =?us-ascii?Q?1GdgLLCBLkY6pQRLQKTv6brZGR0sPXDOdW1Z0UcVtjvPEt/tMd0t/LMQbQrg?=
 =?us-ascii?Q?+xW6EhFLHhxFkRBzRzDA2bdRkioKw8jaaw56/exOGt3cg7FzAGwxhPSoX55t?=
 =?us-ascii?Q?IdtXchxKJMmr6inXrRAMFOchpsPUrjaS+qwvKax4bOUxq5ZfLDDbQFuxo8TN?=
 =?us-ascii?Q?mNA0qUez3duBjoGQjfk+53tpaMJZ5X4tcCUB42pb/N6wIwcEzdgVkO4435M5?=
 =?us-ascii?Q?NtEShV+vI6yDotOGOqOXlgUjAQ5NoP1M7VKBZBPXmNmTvkXbqUgsPKRKrtEC?=
 =?us-ascii?Q?rgZCPMhoZmJ07xkf/SuSFDkvAbO7L2tfdG9ebvOOGKJMp7UN+4fj28WuJxkS?=
 =?us-ascii?Q?NgMw//BAZvlpjKTG0YWnzk4XNyo3sAzgi0A+mgCnUtVDMidw0C4xdsT5xZcL?=
 =?us-ascii?Q?hbpLrlOL/u29cb6kKNEgliL1U80QuFoTq053Qv7S959dfhGxAwe/XTawSooY?=
 =?us-ascii?Q?Z+q+vEaux8HlCo2VR4GdzJT63ScDN93/hWF+vs22uStvdPVMsfm2+/eNBZwH?=
 =?us-ascii?Q?B+kkKQm9xF/TnLCu289NFA/LT7EvNjIObS8txo+dHgenwMeboKTTcX5wU99Z?=
 =?us-ascii?Q?ai6UPV1M1Z5YGnVsLlMYZLFZ2GFwCSwk3F5nCSr+YSlzizMe/240bUGZcXdt?=
 =?us-ascii?Q?pgcYEp5gMo1CMRdr+xaCSyzCQOO90MaPgpVIKF75toZTUXMMRVErtQjhCI/Y?=
 =?us-ascii?Q?f/bVBw6926BR3x3ChrSldAoPU3N/0d3cr84G64QUBGZ5Cf5unpVgI3jFKElV?=
 =?us-ascii?Q?SqplPaZHWPla36WTxmtp6fIA49OaceGiopHdYn2q+I6Ccb86OjREpoX6Os1Z?=
 =?us-ascii?Q?EnCqAbpYZ97aQIsHA7ZbVIKGgV5iPK4YQni6RyOgGoy5B9IIunJc3VSxm3Et?=
 =?us-ascii?Q?PpgpD1tb0LPf61BLTKrqaGKX9VGqXjhbsG3qgbD/GLQeZWu9d6eeNdu1d+K3?=
 =?us-ascii?Q?qXwrnFQtvxM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rpMyAb4Y/Tqzfm9gR+l0LwzjkyZ/wvM3FNjMpCLow9ErlqGGw5KYs8uNuAQf?=
 =?us-ascii?Q?KIIgGhQNWIqUCzE0tAZZosNG6eEAXVrXlkKfOXclgqGATaRibHOf5JmThGdd?=
 =?us-ascii?Q?+XW6SUTTbSA+3gbvaENlKlwuyo4UJK4FksB3UTApeaO/TsQBfXJsTh1/2Uyo?=
 =?us-ascii?Q?fZ1YpdlduGl3/hVKRpa8gKMFmr8xUEVBAyyigIrb24el92C0YlB2/eaLPPkc?=
 =?us-ascii?Q?EXIxxIqj2q6y+duh7J2bKlVBqOQMNybPhNzTB7MWCCbPGl/NQacG5Bk0QLLc?=
 =?us-ascii?Q?uPUqrLk58gCf/kw+zJKFNTrUSW5uNpHPWXAmSj5ePsSJQiZJXGg8SgMF0mKL?=
 =?us-ascii?Q?3PhdflK7WFQLkc4hiaZE20Wtq75XZJjRbd2zFwwwGHutGzQBiKxUAo6GaY/W?=
 =?us-ascii?Q?sPd9MLihhbENmDGjiSlcYuOUxE5VBzRGpCsJWcP2nBIheSlpMNe6OTyp84tT?=
 =?us-ascii?Q?2UOdwLKGqLt1SfvHwBbiVXXD+tWV8tXoghwd99rJOqJgXphyDY9AHr8B13yO?=
 =?us-ascii?Q?28sb6W9UWEZXWbONCiFIv1JhGctBq5FJAk3z6Mu+vdLD8EiaMJNqnfKFPQYT?=
 =?us-ascii?Q?2K84A+yM028oGg4dIY+pcFUeQe+G8EesPkoOXxKT1dK9fV6BBw0pUapkNBIe?=
 =?us-ascii?Q?IHIqBiKFmOCaH5JSfOIg2z2c+RGHmlHhOXm/jZku9E2uYLnwBo069KZHkhmj?=
 =?us-ascii?Q?M8GTB5QujLUZFr0/ad4k6jUgh+q8mCVibkK129EldzkWQGgYtwMJGwVMcDk0?=
 =?us-ascii?Q?6cmFa1Br1FrHkG3moAYcLNe4X5bVCNd+L3cYiH+hb5McGW4H4GVQ57sP0vpn?=
 =?us-ascii?Q?qQd0pCQBwkFLGOxILDgw/4DBDR9smXyAlVASb286SD0IP/2bYdzrSO+DM2Vf?=
 =?us-ascii?Q?MyMONtz0gSJF6RthVOOXxpwHP5rAoHAzB35z4pafRjTHUVf3hzoYCXYtN4dL?=
 =?us-ascii?Q?5XaPg28kvUfrjLPPngG/kigg4ZIZ7WrQK+1+Q3WohJli/eChMkl5xkH9ILC3?=
 =?us-ascii?Q?BWPbfdeiCM0gIcVAwBcFlM0ibe2CGaQAmqXI2vRgSNLes5ucv/a76w/+WxhQ?=
 =?us-ascii?Q?XE1aoxikGFLdBrOZCND0mRV6Qi1j0rwgkUyAp1h6x9omL0TEWoNp1qFo6FxX?=
 =?us-ascii?Q?F2sGwd+e64fKtzQuB6CMpkrRPRGpyyRZ6/mZ97genx15/qUlqg/9t6hngCeU?=
 =?us-ascii?Q?aZzNaoagCMWJwIEm5TXD22FWpXPyW9He6jDGqqbhr7SzdZLK7sS5CAp8SE1q?=
 =?us-ascii?Q?bpRHelOsLnMsyOisUt/XDZ3qcxY2xepLNXFNEtOtlismD7Npk33sML06ZSl/?=
 =?us-ascii?Q?2GiWfCk0OYc89XwJ4sMZJBEU54iZi5QzG0/toiAsArdOqzaCjG7mFaKdusF3?=
 =?us-ascii?Q?RyBkJsKn/oQRi2QTJndUKN1zb7N5H940tSfHA4V81p+exagkvCvME0ooNinQ?=
 =?us-ascii?Q?PWeAlk5trPbFAAzCDGv/md/dLKwF2ikr638gDPhq7CMh/KfYadD56Mp/MXCi?=
 =?us-ascii?Q?ZWhXsypRukuxVXegHR9TzYhtHvCAdiXqs6nulIgB1F/yTvN2j7R+UZoDn3Zs?=
 =?us-ascii?Q?0yUzRpYO5K5Y5G4UAwR5I54yEIhraU/OXg2gBQbg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48afa05-547b-44b8-041e-08dd9ebaec54
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 14:13:02.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paib7bjRMY5j3I09choRl9CuyCQjoOiffD7unn6kGHNikkATmShLN9NHS5+d89XY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862

> +static int viommu_get_kvm(struct iommufd_viommu *viommu, int kvm_vm_fd)
> +{
> +	int rc = -EBADF;
> +	struct kvm *kvm;
> +	struct fd f = fdget(kvm_vm_fd);
> +
> +	if (!fd_file(f) || !file_is_kvm(fd_file(f)))
> +		goto err_out;
> +
> +	kvm = fd_file(f)->private_data;
> +	if (!kvm)
> +		goto err_out;

Is this actually possible? Doesn't it suggest that the file refcount is
not sufficient? If not possible then remove it.

> +
> +	/* hold the kvm reference via file descriptor */
> +	viommu->kvm_fd = f;

You can't store a 'struct fd', fdget is a special "fast" function that only
works within system calls. You must use the normal fget flow here.

> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index f29b6c44655e..b3b962d857c7 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -957,6 +957,7 @@ enum iommu_viommu_type {
>  	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
>  };
>  
> +#define IOMMU_VIOMMU_KVM_FD	BIT(0)

Needs a kdoc

Jason

