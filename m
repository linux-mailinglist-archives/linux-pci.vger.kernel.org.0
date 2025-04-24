Return-Path: <linux-pci+bounces-26633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2699A99E4B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D028F1940BC2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E313AA2A;
	Thu, 24 Apr 2025 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdTAmTdI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36AB2701C3;
	Thu, 24 Apr 2025 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458381; cv=fail; b=WyNaFXYeC4qFUG/gDsA4h+bAnSgjrI6tib6POTAvyvl4PKDUW4ctyj8vNxYWZqQKdxMRxyReP9Xv5M6oacb1Zz+4EfkIusD7+egJkiw6AEOVtobMzO18T+u4UM2L5PQ/Z2PMDUpqZ3vLDtbtYoCeijuFnqI0ot4JPKfW9RZ5E6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458381; c=relaxed/simple;
	bh=bNWrKnI91mqD/XUUGrjCwfp4eUFJJ4Kaeo/67mjBobo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FY+awG6gFGR3+3NvdExE/KnSmwa+DGlTNY9GxgpnLtRIrKHirZV2JOHOKm8aVLNSbz77bHKyvLvzQGQjAsJFKSMwpX4aQ9G26qc7wjbqvJLqjq/Y2ef8+Fcf0eAXcZDoVW+0BAYr/BVdEg73Ll8sd/KGQrEmVaYqk0HfDS15njo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdTAmTdI; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745458380; x=1776994380;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bNWrKnI91mqD/XUUGrjCwfp4eUFJJ4Kaeo/67mjBobo=;
  b=kdTAmTdIJUAYkPRowMUSX9n0tPP79hPirzFBGzFIo4Be328v3Bssx2hy
   LMcJoGxD2Tc6q4WQ+55Q4piHvaUtxeHTjGJsrv6k1x10/Ugh1suIVwt85
   B6IXTRd+BbPpY6JHbvP9uNZexWsxK6MuTKTrXswFdEdLywFNImRsYuOy2
   PhmDPXB/3YAboj/hFinMXfAWv6rVNCvyCMJhvZCd9dWydQ7u1NkTzHp21
   bN2ZGMtPNcLQNF75E904/3a76I8CpNNm5mrfLm6OpVOO6Y1Pm7RYwtv4O
   8AKcN3wB1v+sAHnt32Vbh7tcAE8n09p08q9DWwo7bKZheUm2KMuEt7HGS
   g==;
X-CSE-ConnectionGUID: 06XKIFpVQNSE8xZuD5iyzA==
X-CSE-MsgGUID: /yoa5OTLRLy32ZobCH7oqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46781096"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46781096"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:33:00 -0700
X-CSE-ConnectionGUID: AzzT2Yb6RRyzq1Wd5CpEFA==
X-CSE-MsgGUID: mk4t0I5tQDyAwE1eBgW4CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137325811"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:32:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 18:32:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 18:32:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 18:32:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kambT+roRD/XAob0ynNkCMOfpl6iidluzeirmUprxMFMJS6DvTPrUSXlAMaKQZ/+ERFu/suphu9D91WMRa/uUzfxrcfsAiUpDto9VuXe6oXzugyB6379HyZ47D7btGBQvz90Gs87KVpxJOmhRxIocyB1UPRVDGHNWVtY6YAK8O33ec7x6Y43ydUpy/sVv8F7UsCEIbAROvtTyd+BPlRh4dL8ZpC8KihPSIrvpWk4UePYxlEXP0Cb9foUL3KOrLicpZvEBKIVtkzCEg17BllE/uUNmrx/lSZ7PvwFZjmU9GXuxLtZborC63ohZyTlQOnWkYvSow5FQW1eeHIGlU8jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT5ZrxjYbuUhFS3XyUlpsWyep13wWlL2wKIEcVIwUd8=;
 b=GBT0bdz0NqJTh/i1ERoh4r4+ZCQIomKw7p65Vk/W78wJWrcMABKVL6c+xrGorAEpW48d1aNihUn9nVm7QMHXqPvRsSN71pJekKPTPcQAMWn5ukhNrY9ONo5yRkCYqrkDZdyX93+Bm96/jiQwLlnsGnXOZxEgt57b1TokBzaxkyLdigdbwoGbNnPa+aVjbP9Ew5/Vs1DVubdn44t8YwY+ADr27YtRC9ca+z/EM2HlTNVTsPRqzeXGKyr/rSphgxKy6Zy52j2Ap5P7spipPgqeRKD8GB6vqN6HtB7kwDydL5PmLw+HAYSOlblv5n140PuxfyB89ZOEZ0p+KBcDi0Uaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5291.namprd11.prod.outlook.com (2603:10b6:408:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 01:32:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Thu, 24 Apr 2025
 01:32:56 +0000
Date: Wed, 23 Apr 2025 18:32:52 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>, <corbet@lwn.net>,
	<bhelgaas@google.com>, <kuurtb@gmail.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <vkoul@kernel.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<sanyog.r.kale@intel.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <dan.j.williams@intel.com>,
	<andriy.shevchenko@linux.intel.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<Dell.Client.Kernel@dell.com>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH 2/7] sysfs: Introduce macros to simplify creation of
 visible attribute groups
Message-ID: <680994c499125_71fe294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250423175040.784680-1-david.e.box@linux.intel.com>
 <20250423175040.784680-3-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423175040.784680-3-david.e.box@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:303:b8::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ee8ad0-bd43-494f-2b6c-08dd82cff04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xJESvRQB5f2kWP3x3mldpJxat64TFlzqe/zH/WGgxz9w4u1rn/WhJSxY2m1O?=
 =?us-ascii?Q?ZfUdzDUzlFcE4cBb8Ql1f68wqsdb8RQmFuEFhoK3nG5ySX5SMKnGUP2Jhh+J?=
 =?us-ascii?Q?JeEfVxE0F47tsJ5T3JvmDYn2G9s0V2JZm6Dy2Bysva9hElp++KdBkV2eijeN?=
 =?us-ascii?Q?T/zAcIK4HsYj9HIEaPU/YiHoUuAPwD2zIrXZicrwCdx1yGEIoInDk7jJrhyy?=
 =?us-ascii?Q?mWfCIiuVx3qqfEkv5m/9/VVuBihIsNQn2GMTAts5TtZg+yiD3qGd/HowPErc?=
 =?us-ascii?Q?f35KM/rWJUzPqd2nclsPlz/fpD4kdJrPqUmHRPd5ql9c5cD5lSRWJPOofUT8?=
 =?us-ascii?Q?HJUWZ/Ake6LugkISbXwxofQDoAMGQwAeVZyLuoOR+VVuBdu0yvdP/DUppPN9?=
 =?us-ascii?Q?P/h0NdJ9EWsz6CC1vvsmiVRq8MLQRhyqL2UozNNMj0MQ/9MpYQB7X9OvPLFD?=
 =?us-ascii?Q?AtrF1+mog/ZoD6hvtxvDYDXsuQLVZBJzOzfAq5JBZexT8OH04yl1yarQ4OBG?=
 =?us-ascii?Q?xLJxMyYhkyV8Blc976SWSXzTg3lE6yYCai0Kntk+WqiOSK0anYRrUlXrVhe7?=
 =?us-ascii?Q?qcYE3A/kfTAqv7+a6fdvuhV0XZpRnr1cwJChmw+tdGCdlaoiL4dHGAmh4CfJ?=
 =?us-ascii?Q?f6RFV+eDGT70enoG42kAzBGgAOY9IEiS5/141bNK8dixa8+/TTdpOvaRHlCb?=
 =?us-ascii?Q?6Ieyme/1U74Oe6fOJJ/aqB0VcL1wpuqG9E5W2EZxQPgOrwbCmZSuiOfoEAJD?=
 =?us-ascii?Q?+RgBhUFumQ+HXhanRl1wlHtwPV2AOeLhSbnd4lnSlTOunu6vI8RIn6wXPqyA?=
 =?us-ascii?Q?n3/gbkzbRzXv5UKYTstQvrXVkzxvldt93fgzhVMZw8BdXMCE2v+59PqqsQw/?=
 =?us-ascii?Q?fxqgOsyM22tWTgD/Vzrlm/3G1ltmtucKoYBV0W5OxNezhBp/dyhw4ikKOhXz?=
 =?us-ascii?Q?jZu356dL0Ex0xisDWKstSNcMfeOiyak8jLoNrwhjQ0brGlAD+VDEkluTdg6h?=
 =?us-ascii?Q?9sFJOZxK67tZ1s+iNTYx/70+D3ccN2PQB7ycjkbq/VpdoSbXbkU0kYsaqDaN?=
 =?us-ascii?Q?SII5g4h3W6juSV57Q75sJ3M+wbEIaHn5vWP+45nqbWgUPxxldhCC73Tsq9yp?=
 =?us-ascii?Q?i8+yw6TBg+E6sJ6OKJ0RLjJDJkiY0VKAsWny8WGn9fU/Ric/9WRw1oY103KW?=
 =?us-ascii?Q?Lezzi4trXXSxc6uFMI3cfMAQ9Wi9Bl/reopOTc4vxIuwOP3LBSxox6Utu95F?=
 =?us-ascii?Q?N72LGpehJDUjs63l8OZZpP4k78yc/5ZAfbZk4QupulftZ4g7GfGoGDu6X35W?=
 =?us-ascii?Q?ddNvIMHToZLSONJOumVfnbEQ162anPlJsuGEO2h2nOilJB/+m6fr3c1eup/C?=
 =?us-ascii?Q?mydRRT5BRg6Q9x5FrgRVC05xIpoYnPqF6EwkzX5LTfVbfwy3ZWg9cPhV5Vw0?=
 =?us-ascii?Q?B8VzW3ykp/8Vtls0uKHGgnATiAXW1NgthjZKccFXyk31F3WYmwDmxw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3L3nojsW4trLObvL0sJFuFlLsV03Gs7yzS+ELKC+11kGeGeiBY9suDJmHfnb?=
 =?us-ascii?Q?v7DwtEzV3d0fioWmgucryqtjUn+DWunqXpIpdAa637CFWCvlgDSt0zLrHwZ9?=
 =?us-ascii?Q?fKuWEsacbTWnXyj2KEJN2zkOuqa8/Zcx1ig2HS5Jaisy48zxeo/puYlHGu2H?=
 =?us-ascii?Q?LgCyCO6KWTxGd0wsItBoVkxdrP20ar+MIHIc+SQpjUhG9LYG5EXu328HEDcF?=
 =?us-ascii?Q?OcTq82K24dbCOjHim1Fvg7AD7VOZALJi+sZZJ/UvrZlrSmGwr+D5oXdx4ej3?=
 =?us-ascii?Q?SNRAHu1MfKejMUEohhyS0698HqrLdbdcrOisNm9okWkdiYGSyuwu1RvLOQs4?=
 =?us-ascii?Q?3D6Sp1cfgyN8hg+czMJKC4cUbUz6e+HZ43gg1UMlD5C/Phmzx2gQ0u7fFZxu?=
 =?us-ascii?Q?ssgC9f20ajMZhBSh353aXMzym21Sv8N6Mlz3EHblS1xUtaAdHCzW8D38AQyH?=
 =?us-ascii?Q?r4o+x4+t3zcNhumQ/n4oiUOhlYKEFvomSrJ2hZAa0F4Hsb/Mi3+/DHxpR30i?=
 =?us-ascii?Q?jI3U9uIIVIp11cNQDAJ5i/QVaSQLLPzhc3oo/2gPaFuh2BXGitgJCHeWI1NW?=
 =?us-ascii?Q?sac4bvOPOzo3wfQCgypVRt3gMf5r/FZPfycCxbvvfE5/M8P0UFCH7Mg1B7w7?=
 =?us-ascii?Q?b8cYH1pffcSUymSXmo+Q/MlSkQnxYCmtBd89TgITwOLTldYwwRkjwdUjwa4W?=
 =?us-ascii?Q?ZPqEFDj+IHK8gJLhplzfCBoDKZe5Ku/LIrdnXdAcJ2QI+MU1Kb8ZkB5hF99d?=
 =?us-ascii?Q?knZWnPx014cuAQOzNHSgLs4tQSghN+giDi7VwZuUk0MlyuqOU/xBYUVQ81gw?=
 =?us-ascii?Q?C8JUNW87GGc5eDay77NmTi5ZsTWM0C3kb7YQjI7lQUrlDWVjIT3QO/pKzhnT?=
 =?us-ascii?Q?qO9erIFA2hwsIIhO1eLh01FMgovlntl8Bj/m4TF2P58a/eAS0G0qrK4xY7ay?=
 =?us-ascii?Q?3hC8SBx/OFasXLzHVOGGEi7xNPTwCwJw3wXEKSvw8+eLTvxzvkoO/SUgmCb1?=
 =?us-ascii?Q?LNTm3Or5qeVub5IYWm1Z1zC7wk8sH6J1BPDf2mStJzBJCAnWV1ecrhx4k8Dt?=
 =?us-ascii?Q?jY3GgCQaAj/S3EFJh5Zxb2hAJM2aPQZDq1LXFc/GVB0WTPwZFDWGU4sJrtrY?=
 =?us-ascii?Q?CJnOdUOr6wXWXt8gvh881JYWDvQsPc5qBFQFy77A1CWoOMR65oe/srop3a9Z?=
 =?us-ascii?Q?Px/icgHDcsjFsr6sXLx9k0+eTXtyquJQmtXb0aUx31noObaY8qB03vMm1f3B?=
 =?us-ascii?Q?GfTlKvVjyfW//eGbDGfr3KW7AAizkUE7VLj5YCWCHqliSOrdu+D7Y632eeCG?=
 =?us-ascii?Q?J8M5dstQpcSiXqJsziNLQEDNo/LPS9R5sOGqE29x6jA3Wxm/Qlxx+BEUsTCu?=
 =?us-ascii?Q?wCZiwRzUOxZlBh5VrNbo7yFqjQCdfp/qcMjtg4FOlSwH2UK9DQK0Cc+V8LSy?=
 =?us-ascii?Q?xCpn3paH04DRFKBAphk5JYakGVgEG2SM+DeJoWgrNb0Jcd9Xk5+jShnxu4Q0?=
 =?us-ascii?Q?961HV4kEiAzHdK5Bx+LO9aD7ewtEnY2r75FcHbvYzR3j/Bjv0uVwTVE37hnU?=
 =?us-ascii?Q?yd4pt4WJ3rntqoIHaFFrnWgrHgStgqM92gpY+kJQyTcb2BmZuf24pgUcCmuT?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ee8ad0-bd43-494f-2b6c-08dd82cff04d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:32:55.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtOuFMs78/88sl1oPxIw4iHKXvbaElZkuu4IBu2N9sqAvNlskxRMaBw2Rv5gAowXPQOhiy2p5+35JTUZ61367Gq0GxVcXQuwMtJhM0qsMoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5291
X-OriginatorOrg: intel.com

David E. Box wrote:
> Introduce macros to reduce boilerplate in attribute group definitions.
> Combine DEFINE_SYSFS_ATTRIBUTE_GROUP_[COMBO]_VISIBILITY() with attribute
> definitions in order to simplify group declarations involving visibility
> logic.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/sysfs.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index 00dc88776f21..0804bffd6013 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -303,6 +303,30 @@ static const struct attribute_group _name##_group = {		\
>  };								\
>  __ATTRIBUTE_GROUPS(_name)
>  
> +#define NAMED_ATTRIBUTE_GROUP_VISIBLE(_name)		\
> +DEFINE_SYSFS_GROUP_VISIBILITY(_name);			\
> +static const struct attribute_group _name##_group = {	\
> +	.name = __stringify(_name),			\
> +	.attrs = _name##_attrs,				\
> +	.is_visible = SYSFS_GROUP_VISIBLE(_name),	\
> +}
> +
> +#define NAMED_ATTRIBUTE_GROUPS_VISIBLE(_name)	\
> +NAMED_ATTRIBUTE_GROUP_VISIBLE(_name);		\
> +__ATTRIBUTE_GROUPS(_name)
> +
> +#define NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE(_name)	\
> +DEFINE_SYSFS_GROUP_COMBO_VISIBILITY(_name);		\
> +static const struct attribute_group _name##_group = {	\
> +	.name = __stringify(_name),			\
> +	.attrs = _name##_attrs,				\
> +	.is_visible = SYSFS_GROUP_VISIBLE(_name),	\
> +}
> +
> +#define NAMED_ATTRIBUTE_GROUPS_COMBO_VISIBLE(_name)	\
> +NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE(_name);		\
> +__ATTRIBUTE_GROUPS(_name)
> +

Looks good to me, I like that this makes clear that it is setting {
.name } in the resulting group.

I would not mind a comment like "See DEFINE_SYSFS_GROUP_COMBO_VISIBILITY
for method definition requirements", but only add that as a follow-on
patch if someone else acks that idea.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

