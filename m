Return-Path: <linux-pci+bounces-19566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1E2A0669B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 21:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9069B16785D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD5202F89;
	Wed,  8 Jan 2025 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CNHfqRhj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2761DFE06;
	Wed,  8 Jan 2025 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369436; cv=fail; b=fYjdWZveqhoHrOyx9NvRFbgri+fVIAk+/5SLGG7n4Lid9e7Rn2O65O36VoN+39+I4MIUJ9XItnUoumJ1SNlCLZqdIuUcOVcQrdwHpwi+gkJFgm6djWSQIo5Iv5zwdOO7ZcHDpAZPRH7ohtp7LUflOHXiUmjmOv0mog030kkYjJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369436; c=relaxed/simple;
	bh=V18eFdYJCK6i8xudtUFbQ1h6pFcftTkFnQn2OeS8W2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qJOH+cknMQiCTNabbqwIor1kojUknjTiiqxZdLNEFSPNXjmn1Ia7Fb5I3f2rlz5muPoG+Vn98QY7k22hcVCBgsffrjDp+lIOo/vbg3rRxF3LIZy9S0rE6Fv+ev8y2WRHty5+7UXYFEJgAeNhc5DT01P3LFGXiv7qc8ztI2Xewrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CNHfqRhj; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Doq9ei5Y4N+7jahXS1sl/W4RnJtPo4w3aJBvuBsiFz0hLVvvDt9DhQPOniwtea2da1l+eQAqWhyvrnN9MTuofG5ayImoFnM2EPnI+lB8aOzc0DM4GBkBFGM+fLxsJsKsPom+97Qn0V2gsdL43IS47gb6Nql/k4r1EW0BlRAiykweqbXsCZodegusKk0IqGQVqbsU6muXSf19i9Og8+CF3QNDewwPfW0dUCJYjSS/AOJmpPVY4Y5HyjHPAjPIX9+XDq+9TsI4dea92M/KhdjbkbEZQ8CzQi+eh0uKFp0y/Spz4SHbEEJE/nPE4dgAFo4TvrY42KvwM0enpXid2liAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4i7lvJOEfqLjrsDiwkPSHuS/oiZVyi9w+mWiwt+Efc=;
 b=HYwd3TADDkD4woLOWGLSxQnaZCRENmek6Iz6kpOGBttytL/t6D7c0DZUbKyZJGENGTz2b9NDtLCUfZbgUyQPw5FfYK66LE7hYPQTt/D8FEVSSPdivPdcn9oLUZdWL8noQMNLNxwgR/YTEJhMdXt4XmivHqwJmlj8KMgF7KGNc5xCxc7N6vHHPgOyPC4FNBeSOMbPka1iv2MEd2/Sc5qVepz8HlD4KMKA9j8wddrkDq7UiNKckVyI2S2e+6zwunY4Vp6kokgAN8Hwc1WLeRvKUNm6PH8+1MRTXEV7J88jqJbPJ5wUq23FYutewkxqdbxRwRVaUI3aaF7N2irCnwNI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4i7lvJOEfqLjrsDiwkPSHuS/oiZVyi9w+mWiwt+Efc=;
 b=CNHfqRhjNLtB/TU1HRXwcTgbSfzyliQQI6ea/TvTyR6su416U+h5h4QbFVK1sUt4yjVxOTppkn9LRWu6Rwkt2GStoGjkBcFpXT8CU1TKVZ+KTdGzCaIuhf5ykco78+6vptug2pqyeqnnoOECABn3LAIbzc9t4gHC7VZYmP8Gb/DpAHP0MWR0TD0kNZU0c5gGdmMS8EKnMtEK5pp7BKl+b29Slhhc3GJUTC96nGF/3XjHeDRmOgbQGlMSDVzUk5EV9Kus4Mwf6xsmLCQyQUBPdmXy7ALRc4/ZsjT3aHfeDsdQ5EJKPxlVbcRr6R1oUUDyhLlSeVHKhY7Uys3S99ZbAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 20:50:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 20:50:31 +0000
Date: Wed, 8 Jan 2025 16:50:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Wathsala Vithanage <wathsala.vithanage@arm.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	lenb@kernel.org, robert.moore@intel.com, bhelgaas@google.com,
	wei.huang2@amd.com, honnappa.nagarahalli@arm.com,
	dhruv.tripathi@arm.com, rob.herring@arm.com
Subject: Re: [RFC 0/2] GENL interface for ACPI _DSM methods
Message-ID: <20250108205030.GU5556@nvidia.com>
References: <20250106163045.508959-1-wathsala.vithanage@arm.com>
 <20250106180140.00005132@huawei.com>
 <85fb2b19-9d15-44ea-8f76-b3cac14e2810@arm.com>
 <20250107174842.GN5556@nvidia.com>
 <d35924de-a560-40aa-a99d-7278009c5ff3@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d35924de-a560-40aa-a99d-7278009c5ff3@arm.com>
X-ClientProxiedBy: BN6PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:405:75::49) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5b9f68-458f-40b0-7a53-08dd3026175b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1M8NFUJSQRLfuk8kFSx3DDw0Nm6/0P0JOUsY2ssXgX8BJNLCzcq49digFGSw?=
 =?us-ascii?Q?RdMLq2PCdfe2aNhAIngFcJMF1KF/KyylC3Xyp7P2ls3Rt/geBhGb2nA1X682?=
 =?us-ascii?Q?JjpHsD9SMdbmU7QDaMZkTs2NmjwuY/gCct2BSTmDz724m2trAtSCvoLV+B9V?=
 =?us-ascii?Q?jBBUmIZRuX/5HlAS/WXb3Lfjar6Jrre2eQjc8gvZIioAyu1SlZhHeI8M63SX?=
 =?us-ascii?Q?vT/oZVq55Qhmsq7vyhk0x2BnMKuMxFp/lvSyCaJdWH7jFeFhGmgvgTu77wbW?=
 =?us-ascii?Q?honZA+GW35cOc6jnfJ3KkrH/XtLXho3ZDQQc/nv3OQZoRCIayfg/DZipjzRb?=
 =?us-ascii?Q?NEWL26noeSHiZN34f8sH2WBXlBdJn1oC/769ErKyR1QYRTEc4QIaNsi8OK/R?=
 =?us-ascii?Q?4Y3oFUa4ktVxPvHiP2KCG4aLwYbRgEikOIx6q4D+KWUC9BG3pe332/n9mTiy?=
 =?us-ascii?Q?/vtQYkUvIwv+b+WaC8+zvRaaAtC0rrnSzuGSBRGHBg2BofAa4sLQilzzB9QR?=
 =?us-ascii?Q?n3SrT46iAoDQmUL+NNPtQM2Ih8H0GMyPbPlVCC4idI/RHKqo9FEMSnkPOCVR?=
 =?us-ascii?Q?ny9h+6IT2STS4a3Q5UepKylzdg2FWs/8uXO6BhOq7NAyp5TtzB91q1ciiEEi?=
 =?us-ascii?Q?54OThOfEQ1A2ok5+49xzKmJlZ3/ltgei8Dxvb5ATFTgDB2BUuPIwZUAvI2BW?=
 =?us-ascii?Q?xPZf3rebGjl/rKs43XwnnhYY1aGfGqQS8WygGy5Wl56uhiT3jKrI2tmawa81?=
 =?us-ascii?Q?LeuSF0Nvsuu3pyaVNzsCvUsg8Hxb6WIq2jj2plXTELZBiSx0geck+zJICfQw?=
 =?us-ascii?Q?6W+xOYdYAiGc2borTMynWJJcD+XOjxUY9iniUzcKN/l8yI1JZlke9HhU+2al?=
 =?us-ascii?Q?zPPSiF2kknxsbBaRU7mfKJbYs7Qo6w4L9SDpMBQ7Uj/WWqwjBvOZG3bLUtns?=
 =?us-ascii?Q?DfwiSQdmOqlIErSbUf/Qh2ni9B6DJcsV9DHqUg1fQR1FcfRtuX4KIG9BYA8I?=
 =?us-ascii?Q?4YlIiu/NCIw4UgAoZPBgIC0jRGvDZGDbkcPwuYsw4Hps58jUp71Nu1sY8+3o?=
 =?us-ascii?Q?Oxt2RtjtZBVlCFK1/cV2FTlNg4ZGpd1eZt4FGkbQIuqcwmjKMQG9SjD/mp9N?=
 =?us-ascii?Q?C1mzqm7DTannmY09n437rTVxewqVhaVl43magujKvlUDgDXWCTdgqGqzExPC?=
 =?us-ascii?Q?HZb7u9wSjJn6U8Wc+nKIPaRg/fMHDpeRDK8+sP6oATPTpvfqQKW7zyy2bo97?=
 =?us-ascii?Q?IGG6moepd9DXmucN2EcadMJ6oZwQW19bHTlJ497JpVRQANFAOEGOFor1nhwn?=
 =?us-ascii?Q?K9IK3RtgqepZXrthieD09I1Bm3Fp0V5/jIPVAqRvkgxDiMO47sHYu1zzvc74?=
 =?us-ascii?Q?AfJsWfQ+yWvSyLMUyxC3JoithlYV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJ3vPBVKrGigNLkegN/O6URt+Ju3GXh7cku/LabhrKL7vAFL2tv5QN2kVQ1o?=
 =?us-ascii?Q?QiAeWHUPXlMs+VXBdWNIQy2kloWWXSUYaE9VXG4u6SwfQfvSVAnPLd938xTF?=
 =?us-ascii?Q?HdpOSWPf6+rakMnk4avFEv0YeeND7z/1ZTbuIYS/VO4qoL3JcPY1UUqEyJCV?=
 =?us-ascii?Q?w7zgTZv0B2AgWVRL5PyqdxKmiVKp7qbVTmiGPXUokTq65fYC1Rt1wzC7fYgL?=
 =?us-ascii?Q?kFP+ElMu7GELDqPEaiPkXNafahi2Sv2Il2B4t/1nLN0WQH8m1RHPNCpmONyO?=
 =?us-ascii?Q?gLV3UWeTxSP5aHpBjXEFtKlHK28xlUf5FG/4qQPTACoo8IAbaH4VuugqzAU5?=
 =?us-ascii?Q?gHbnnIYtpzyxcrBy7vAJ2J7oV4VA8yeBv7jW8RMAewqMPLhUCY2MjGp6Sw/Y?=
 =?us-ascii?Q?en2wSBUrbMrRdxfuj1YkmfJt5xD/btBRSKc1Qpkr+g8eZDaWfRM1i/y9umUf?=
 =?us-ascii?Q?RTReqcIuxf68rZzS3bBZQw2QWtkakWCRChEgkir+5xfehMVn9hjEMauFRi/M?=
 =?us-ascii?Q?SWLjgLKQsypVqXKKNsdSMUBW51HiJ9yzXT3HBqjLRxNgV+A6J8FCRiRcHrW6?=
 =?us-ascii?Q?6HravRNrCYEAWNw/KR9BpODWjzR7hikwsYSKekqU4trBhAPy6zNT8ZWV3hMr?=
 =?us-ascii?Q?1vCk7thALwl1zAW0ZyF2TRVo68MHQJYMMYROfL85N8YPc2TMpmpPm72Qke9B?=
 =?us-ascii?Q?7B5LAxWPOH3a0zbRZfE4kAT0G3OgNJUDZXoXxoZSVGN0kIV7jX5o3G1XIqub?=
 =?us-ascii?Q?/F/ARTe2aBtgT+FBL++T8ksbvxEkumzlMWPjmQ9u3+0uBzVgMYRXIa925/FE?=
 =?us-ascii?Q?K+EMWGc1+Dnu7DPyf0M+OzxxMoYnAlJD7uLWnRm9seeMy/NR3spDt0vTMmZY?=
 =?us-ascii?Q?wF3YIchjr69mbOvNVt8KDcEcGkS5NkzxV/AyipnC/O4RX4I8d96HVo7g2Ye2?=
 =?us-ascii?Q?zy1eBual0d7KIAqrCKuSChtHsHh5swpX7wsEvckEVhY8bRKL1VCiJenM7pek?=
 =?us-ascii?Q?7gXSTFv5SYh3fy37yL5PDo5YFUUeD4hCEYELJqdIvrTHntt5NUAeEKiddND4?=
 =?us-ascii?Q?vJxoRCaqfzkMSchF+FwxHiGKLSB0GFoWQRTZe0zEOBw3uI6JtqNNQW3XCPMB?=
 =?us-ascii?Q?8E5d3wFOBFWxIlqJ92ZSiBgH4n6AQWyCH9Nk1ZLCuWhGC32BtndEPU4zN+6p?=
 =?us-ascii?Q?w3yFwKFBnD79cCmp1bsc/YhhI07mTnkbfJRL0gIved6gAKq017GPIvbH81J3?=
 =?us-ascii?Q?XSHXGAkPkVY7cUmw8blBC0+5ej5KJUwMGfCBTpNx0SL/B+T0Yizql3WNkCXx?=
 =?us-ascii?Q?LYn4+lGduhGL8PrpdPwZMmrDJcloLyTPQwppNijBuxlHDqIlhvQisvTnmMk2?=
 =?us-ascii?Q?WsWv6fJ79AuNV013q0btpeEXDtrwKjKPs4MGWNaeCfBOpqsR/0Mva3paPeTT?=
 =?us-ascii?Q?a8aSuX2+/rIfe877JiRKxa/+Vpfe7W/J/fb+VjqlAWwu3DAXSnUrj/uB3DeB?=
 =?us-ascii?Q?2DMQ2loE9yCT7uDmB7QGh59j20k104wQB2pPtgR5yoEN+N+IIoAJAkBx/skx?=
 =?us-ascii?Q?Pf1oGKOxVfDoiGiZDP0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5b9f68-458f-40b0-7a53-08dd3026175b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 20:50:31.6627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zrQowy2tISohMJcwzDO5+KuYbfWoF6fMpyEM8fqxMK9dMtJmWj1VOzam32aFtJu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948

On Wed, Jan 08, 2025 at 01:59:35PM -0600, Jeremy Linton wrote:

> I'm under the impression this is a similar problem to cpu/irq/numa affinity
> where the driver/subsystem should be making the choice, but the user is
> provided the opportunity to override the defaults if they think there is
> benefit in their environment. 

Which I think has been proven to have been a mistake. Instead over
overriding irq affinity though proc/irq under the covers of the driver
and hoping for the best the driver itself should have the opportinuty
to set the affinity for its objects directly.

Lets us not repeat this mistake with steering tag. The driver should
always be involved in this stuff, if you want it to work with DPDK
then go through the kernel driver that DPDK is running on top of (VFIO
or RDMA)

Jason

