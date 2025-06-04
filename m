Return-Path: <linux-pci+bounces-28974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EABACDE2E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5573916A1FB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F4828EA41;
	Wed,  4 Jun 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GE6QlNoY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664A613AD1C
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040747; cv=fail; b=uyZ9TUy84fLB15nBjThiqqCVfi0WTn9yXGs+fmO0tsUw+H/1gjCt+u9Jb7Rws5c4Yz/OL/m5xqBQmuTHYrk7YbptxyeXHduVX8xtDtka0KdFp0h1z2vGx33s4JrSMgjcNkG8yr5CbHIKTi8nE/g00lT2k6zmhfZh27uKO4/Rkf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040747; c=relaxed/simple;
	bh=6ZPfYymOxoOyYTDdJUe70fbQ637gsscD+m5oJ8JuJB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jkSiLGNvIv6kdjMH7jPxM3EkO6ap++al6vKHSEYthBoMKWj9t+Bmk99evw5sQ1HOXUvt1tltb5oSEfIzTGRYc/CtG/zU6My0XSI4Fqqy9VzPxAdPlNFg2nLLyQd+IsdxMVoZXiCAyBZMeAtl6gsyGDGLMg984ZKW75W+CH4fTY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GE6QlNoY; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTN0lTQidAEZvqG3d4qpOSMn5XU6oWIKHkgh0XdQ90jsczQjn8BX4XH5f9koOPaTK43o2WhfmTdOvRP3YnPDxPQibY252MhCYVFoHlv/44Plh1zTO2iFAkacTr/LPWKk5DAJLyE+vQ3jTO2pCcYFGKGzupN+v34L6LspkubZDegxSg+TYhuz3WALjZg+XYRu1/SXW8Qy8w0o9oI9+o2sCRj0+scv2nuT9f+pXNZ3UI4UcYhrwZ+ikCj4Tz4uCA+claioaz2Tk6KXdbY7u113XXG3iGguX09r1YSVpGIAAEXPJhQ4OILXfD8OKAzz4npHXQHO02+wpGMvfRobTxobew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpDcCh8KCzkSyD+D2BZawsTOJELzXlIjyrNDDKy0gnU=;
 b=eND5x9JWcEC27+QAINL5RIjSqPHk8x101c2BDdGSuKTNoZWsW9rv+pa6c/RDEoUjAEFM5MwJmlNx74F1FKsMkqG1RiOJIrhB/LCAOO2yrmra96p9BIXzYKJuhagnA2viIzHive1CLxx3K1xgIQ9+DLpAA3EtXD+IvSxtqclMx9lwTo4sz8a2e+4E0GgFvG2jsgJwvtFMaxiY1zgPbcZkuLNLpqmIyzSVkTo/W8eJJAC6eJa5770XsEgrKmHqurXy13hxCXSkoWadVKelNHIeR5V1afftP5p5MGvFOL9fG+iLrTFYCdx0lO/rKfrAnDzqNnlW19OwDbFZMg3RAafBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpDcCh8KCzkSyD+D2BZawsTOJELzXlIjyrNDDKy0gnU=;
 b=GE6QlNoY+TldWuLU+Ut42FRqksF21UfUHz39wNTfG/gfcW+VjkGV/ctPlvSdGVQpJ9cB7UIVOnSbAeQwQ/xut7aredt50ekZ70jscOurMqEo4vaSd4lWUVzCNYsz3vCyre57ROeTsacxRFBzppOwrwM9qah3YAIa5eM7VWl3Qv5qPz9Y5U9KeGJNgxZel6el1CWcCzdWIHIWM1M5TbT6/XmGutU5J0bMtQ9u6IGLGiEYPRzl0Z7HixrK9gCwNSeSCwucR1Bbz8ZkjmJxdFQV1xUY+7nfbbgx8ESTIoV+f2kzgSJZZg6Hl6403VsiZPQ1frN+7zVYt9uaMOjZMv3ChA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ5PPFD525C5379.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 4 Jun
 2025 12:39:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 12:39:01 +0000
Date: Wed, 4 Jun 2025 09:39:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250604123900.GH5028@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <20250602124718.GY233377@nvidia.com>
 <aD5wVXINV1QJnMbO@yilunxu-OptiPlex-7050>
 <20250603120810.GD376789@nvidia.com>
 <aD/qF/6vjxjJEXcM@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD/qF/6vjxjJEXcM@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: YT4PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: c37847e3-31f2-4066-cb29-08dda364c898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1KAJt2Tpj2tFfcaJCTZyFiD8K4N8vaehjW5HM6kp3VUoi4kRIuKyBuJTOQsY?=
 =?us-ascii?Q?W0i/afCdASTYm8b+NIqYLEwnIC+RFhjcvl1R19YtELtWFzjVPiLv6EZJ6Fd1?=
 =?us-ascii?Q?6XtLmlNM9BVQYbEiba5ii5P27vy6sp0hCkf72LOO6aNuHC443RT7SxccvBSh?=
 =?us-ascii?Q?hCkpq//Qe46Kkbelqsz48Po/EGhm3ck5b/6rX95UXxYWVPwZ4x8u74vByUUI?=
 =?us-ascii?Q?s5V9wtQTEiLnsr113PIvVuPPiFJoyjNbx/XTzCKgzMdEYnbACTrHHuqEZWxI?=
 =?us-ascii?Q?UdIb1Ec8ADmM93Vs5IQKRuaeahqe2lgBFAlpgIB2lhyup+YCPZbJqQqs8T7S?=
 =?us-ascii?Q?0uc4OKOA/y6r8nOHZ4fXYj8jvA0k4TDS+aRFXWhvwThjKz5Rrl0JytpWu4jG?=
 =?us-ascii?Q?tcvXZuifPHmyZscyvR2KLYbGrryNmZeU37pUiLjXOPKzyaOsMXRd2CL1/kzP?=
 =?us-ascii?Q?yLOZc6hzUWqnBZOJNqqLTPvS9nDaoo3kxgMYHoYutvQDgegocCWrssPo0NPd?=
 =?us-ascii?Q?bFGLfElBZe8pxVYDeUYqaeZbzWjOuy4V8DvfRWLOdTPy/efPf74h2c79bgfg?=
 =?us-ascii?Q?OmxePSQASI+z40vRd6YTZYoEwCZ2W7fSlfHm8QDAGXvELosU8TSPqWA8w96X?=
 =?us-ascii?Q?xGX0oigLFDHqQWEWKMrsSD7IRH0k6ADpoE+pKqPSwcSbhYf/PIoKQVo9Bq57?=
 =?us-ascii?Q?BqQ23MHolRl3doDxMTHTMgPhTSXAgSHI/YLiFoBSRx5J814DNFijAkTRr7Cp?=
 =?us-ascii?Q?Kwjkv9WWIdjG9s71gfFVS5iqTEpI8NEx2P47Oabx/uNJlsAHnO0wHWhmLFt8?=
 =?us-ascii?Q?p2Z3bg3XPciLGYGJcXLYCCC/2TD4lthIpxlRYm7IwdVtp8hneFh40qmhocEa?=
 =?us-ascii?Q?ret0Ojbjfo+UNzZ642A051c/wUwJXBkPGypEKHtsflsEgHAAKQuH9H2BKvgj?=
 =?us-ascii?Q?BovLjvuBHciuiYCBX9gThwpOrJnBcbW5TCiGuCCCHcZp4rR0Spyv6Jlf1uHH?=
 =?us-ascii?Q?n7XrLHi0uQ9Gi6m0Y/HdPodmwJkqXN9LzwV6WHHk1Axwb6GEymI2XWJgjtZn?=
 =?us-ascii?Q?MNIG6OhK9bhS0Cg/85vKSMtyJwXXZxhq+duhcy5txo+JfU3N6b0BhIn1CkCe?=
 =?us-ascii?Q?QZnLg2eBBqhfys4HNlz80LxYWE63nx5PCi30VzeJ+pw8Uv5CWPaZsOtZ+0ZF?=
 =?us-ascii?Q?BOfkaihZ9UcYiYpnnY95qt9gDCpsoPy3WDXlSgi2M1zUfPmoLtXWWeXJdCBt?=
 =?us-ascii?Q?kenrRTuvoNB5CkKmV6ADAG52iEghDM255xB7BsvzomBvOYbtrTfUse6/2woA?=
 =?us-ascii?Q?GbcNVi56+MG5oddNaYscqt7XGDygLT7GClid9ieeMJJez2ZATdUhjFxoSZHM?=
 =?us-ascii?Q?V9mwSJWr3XGvOqQQAicqxZwqEhb8yHePECddF/yRIELyUgRm0wJ1uUeMeFRi?=
 =?us-ascii?Q?B7CJMcoq8q0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9TW1kJKvlm2kKcAvwlUl8vWyMl9eG6gUhoMnUHSzlHIQjTUcpUVClFM6Perw?=
 =?us-ascii?Q?iztD3+CrYLNbemKVLOgz/CnYhVmXhnFsz7whze5K5EJnMhhODDTcbYcgbMsE?=
 =?us-ascii?Q?XjwSQ6lcbkTi99RSmAEmxmseGRI+2aNfcRhO/nfCCuXxi1WELbAAYPM7PeIq?=
 =?us-ascii?Q?wZ3KZEQMMp9PwV6esfwgghAqvyzdLVvH4iw421SxKUTPts4TmAFTJfUf7gcJ?=
 =?us-ascii?Q?fvaoGEpdrOLeNXC4QW7lNo8+ambytTeAX58Ay+ziDvjoXss/0V3SCoLGArav?=
 =?us-ascii?Q?o7QuEg4FeXLpi1LR/YJwkHNgXr6fS0j1euogEusm+QHATx4W2SMMZOtqDymd?=
 =?us-ascii?Q?gt2wySi3IFo0j9csgcoC67oZh+ilhfrfx4FR1lO6CHOwWbGLaZqAVvTgTx3R?=
 =?us-ascii?Q?6m+tqUclL7e1P0OMSRzrRo3No7VdaxkR/KwPIqDb3MxS9UtZJbgn9uwiPnYT?=
 =?us-ascii?Q?qz9G2bQGbR+pQg45jBrQRJi9gwTq/Ou8QHkAt6fiw/lRmDsyQ3BFRxos0cGw?=
 =?us-ascii?Q?mW7vvcQNQcuY1x3xZplbOfTb9d1m6CRK/ipjRL+VU0u0J9KGlC0ga572jcRC?=
 =?us-ascii?Q?UYZPFPCAqZL9Aagba9VUTZ5IP94oCj4VLu+6Z66Fq+Gaj2OS3UfOcGJ8c+eY?=
 =?us-ascii?Q?+89x4cmeKSkGQFqSiMnOmFrz08ngJMbMkbvpO6bFQFkjPTsgOk1KUk3yEnGQ?=
 =?us-ascii?Q?PEhs/aWTr5ZN8ATHmHp63KqKIC1J206KftgrDa1XbjN37NhQ2oClUJ5h8T82?=
 =?us-ascii?Q?0Dmkc6CQlyzqdhu74NRh6UFRXLSOzCPy87k3j1rKHGrgYLX3PffhcCYm8JHU?=
 =?us-ascii?Q?67RN0RzyD7F+KPCthllRQuWIG4QjFlMdahOA64p0+DSfaIuv/fkd54Nr4GwM?=
 =?us-ascii?Q?LHWU7LHY0cKtymHx45HXZrRy6wuHGM9qIy6wH4lXEpWvRdM7FHa3sZlnBCC5?=
 =?us-ascii?Q?ojGGC2YsedW/amgM5MqtyR7zTK1gxHOg5xTWr9IrXCV3mzgWAS29FPvQ2E9O?=
 =?us-ascii?Q?qScMXncUgNaggWHTzUAam4g/5zWdNq6+EabIvboC4CsUFN5cxHuP3Usz5h1U?=
 =?us-ascii?Q?Aa+l5XEcPHL4R+J9jDwcXyw+6HLkp8zD8N8rTKIDYkMhuLH3W6C643y54wsu?=
 =?us-ascii?Q?dWw8e6Q4rjs1OrlNdrUEHv8nmr9kDSCA3KroAydp3RmaXvVJpH6pPko6BuRk?=
 =?us-ascii?Q?kJKwAd0Fx7s4xiqEXHNbNLv29q/IMRuJC5DNPYJyudUAHk5zaWgn3VFjip7o?=
 =?us-ascii?Q?6auaX5iAUwwZb6IoRb2SCsl7ZYCQTVw4PY4qbEFN8LGeIvZYgat6YsZouZbh?=
 =?us-ascii?Q?Zpai31ur1IJvFSRq9ksLbqZCG+nA/7+Ifcr2ANbwR18prYE1E/F4719pwhdW?=
 =?us-ascii?Q?B1RCpEjUFx6nrO0RwvzJ32w81XlPZ8mlLEgGXWQ3lwp7XGGoygDs3ckMN1SY?=
 =?us-ascii?Q?fAsZxcKfDkFqGz4uafMd+Fhn5pJPNsaiRA/EBf7fNMunuMjBvVBj3N4dkETZ?=
 =?us-ascii?Q?aL+reHULh55IwBhM2jS3N/uHMfuvlgF2tIDttSMsco6FNbCjAYA5fzWmG4h4?=
 =?us-ascii?Q?Gv9QRLWBgcluqxdIaL4p5BSfCZpmTJ0Oi123q3FI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37847e3-31f2-4066-cb29-08dda364c898
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:39:01.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qA59rHfK74tIdcBdQWcoPEgUGCsM4uWUZSnI64QFpQi1Aoexiq2vrbGwF8HR4lyR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379

On Wed, Jun 04, 2025 at 02:39:19PM +0800, Xu Yilun wrote:
> On Tue, Jun 03, 2025 at 09:08:10AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 03, 2025 at 11:47:33AM +0800, Xu Yilun wrote:
> > 
> > > VFIO doesn't have enough information, but VFIO needs to know about
> > > bound state. So comes the suggestion [1] that the VFIO uAPI, then VFIO
> > > reach into iommufd for real bind.
> > > 
> > > And my implementation [2] is:
> > > 
> > > ioctl(vfio_cdev_fd, VFIO_DEVICE_TSM_BIND)
> > > -> vfio_iommufd_tsm_bind()
> > >    -> iommufd_device_tsm_bind()
> > >       -> iommufd_vdevice_tsm_bind()
> > >          -> pci_tsm_bind()
> > 
> > This doesn't work, logically you are binding the vdevice, not the
> > idevice, the uapi should provide the vdevice id, which VFIO doesn't
> > have.
> 
> Yes. Sorry I just too lazy to provide the full API format.
> 
> The original suggestion [1] is to provide vdevice_id in VFIO uAPI.
> 
> [1] https://lore.kernel.org/all/20250515175658.GR382960@nvidia.com/
> 
> And here is a piece of the implementation in [2]:
> 
> +struct vfio_pci_tsm_bind {
> +	__u32	argsz;
> +	__u32	flags;
> +	__u32	vdevice_id;
> +	__u32	pad;
> +};
> +
> +#define VFIO_DEVICE_TSM_BIND		_IO(VFIO_TYPE, VFIO_BASE + 22)

I don't want to pass iommufd IDs through vfio as much as possibile, it
makes no logical sense.

> > If you really need vfio involvement then you need callbacks, I think.
> 
> Only callback is not enough, there are cases that VFIO wants actively
> invalidate MMIO, e.g. VFIO_DEVICE_RESET. In that case, VFIO needs
> dynamic unbind then invalidate MMIO.

We've already talked about reset, Alexeys solution is good it is not a
problem. Block FLR on bound devices.

Jason

