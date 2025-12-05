Return-Path: <linux-pci+bounces-42677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E263DCA6050
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 04:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55B173045697
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 03:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BDA221DB3;
	Fri,  5 Dec 2025 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMKPg4fX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330B1F7580;
	Fri,  5 Dec 2025 03:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764905871; cv=fail; b=ZpmguiuNU7wVYsB+JLbPrpJwERs0HSHU6WjGRu8Wg0JI2W51/uyQxb4toiwgxzdob2x0jquZfg5dKiFyTaymE4QKtVFXnMnn6PC4UxBTm5V4vJxrIFaAO+4SW36DoQ2ut8jkuSxTYm3l6K/mWhvCTE8wGmh4TjEwLzf2va6+1dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764905871; c=relaxed/simple;
	bh=p2r5vyygtkEvA+xjmf/AgLgIo90qWP/nzkMBm1zWoyU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VuUtU4bujUd1ofdZyKQ0uRNtgi5w3LMtjGGNMr4p49/GPcxkeTu2vvJ23j65FD5L7RKDRk+X8uRx41GCe32BYu8fKxdf7pUIHmun3c/OEmG3X1j0ek+hQDxVs5NzxrsKrHtT6M7euXCsgbuanSD+Y46gE8wFVaNTCU3bcGuKYg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMKPg4fX; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764905870; x=1796441870;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p2r5vyygtkEvA+xjmf/AgLgIo90qWP/nzkMBm1zWoyU=;
  b=XMKPg4fX32Eopwb/FmXetRwRwPPwfLJYupwYpZoVunLwL9jkhOxl/kv3
   JtK4Pn3BfnyQ8LRmM/QukjY/4owTA+QBS32u4Higkgwl4H3HC/zGziv9L
   B3cO8q1Dmi66r53NWpyqZSMnlyZsCkAgE3a5f6nSfqy69fDLT8DgVHsZ8
   ozo3qHXLI1PN71sZIXHlwoT3ZLJSwBBKay6zAmPihA6AlKEfYyyi3sGlc
   d5uFHvQNoOSfcn0TVLXc3C/JgVioh0ViHuu2n00fchB+8kujTi6lzN4x0
   TUPC1Q1GtGOAhsFcZyXiNgzmCsQRoZR26xX+p2LNYYzqYZpkJG0+Am45c
   w==;
X-CSE-ConnectionGUID: UKwZmBQXTVaxEO3tXZJKhQ==
X-CSE-MsgGUID: UknRysA7SqCZg8ktVRCeyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="70786966"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="70786966"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 19:37:49 -0800
X-CSE-ConnectionGUID: 4MRMOab+TtGgn0Cg+89R/w==
X-CSE-MsgGUID: 9a6bTJwXQAOA3LayISS35g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="218534957"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 19:37:49 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 19:37:48 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 19:37:48 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 19:37:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPA3cXOsdcjmQrJ+X5rqj5+20UHpr9z0j+zzRyUIN3P5ysJ5F5M9927Iz/dzQp7SsQO0jaWfNU3uTQZpulYp0Cfr9RtMBwE4yZfHVEihHyuMm2Gb+orQUK42KEvVlt5uTG9+cVD33texgXhy6hUzbppwDIWs8ur9tpKx0RLyy5djUtY1lH461X6QR8YMpEK0V1Ah5+8EWNQ/0G1ruS2UoAXJHH0eAYr1FbVzKTldUyJ7nPxyhcjYvrpzAelYalGBDD746ZJ3fPbeseREHs3enCcD9QgAQxrS6ijqx4mOp23R5PD0huy/INwO7X1mxSLPkqu+j0YWKzvGMcGcaQL0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Pd+iisUF4i4gY6lEZTCXIYL3hfKQdyeh6FghkEa8Bk=;
 b=nTxrH4lzNQr0SetybZLUPEjV8MhAEiXTu+gzhXn5JKpojT13jq+28G8BvWj4aesblnDFzNGecWfAsnPY0k1hB4l392a5eQp30WS0Xb4+WjZQpj9wdbjqRmNg4Piyf3U5Su0TNbsyuDFE4InaNR8v883aKfyk/pUToBW2yu62LLlF8xPQat+v5Bt93+fc6eKlxX2aCzJQk4tjX2fYo9oaG6Tbk8Yiqmhayb7bAngPYblTcGEKqpuKhypuR4zMvlV7Fn+4EwxplfmKFz7uFNR4OSSJtxf/nkvhq6hZGJJuKWTdk5eWqhVOU441YU/srb9Ih+4czSrbV29KKK4w3uXagA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PR11MB8681.namprd11.prod.outlook.com (2603:10b6:0:49::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Fri, 5 Dec 2025 03:37:45 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 03:37:44 +0000
Date: Thu, 4 Dec 2025 19:37:40 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH 4/6] cxl/mem: Convert devm_cxl_add_memdev() to
 scope-based-cleanup
Message-ID: <aTJThDXvgavF7X2S@aschofie-mobl2.lan>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204022136.2573521-5-dan.j.williams@intel.com>
X-ClientProxiedBy: BYAPR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PR11MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c60906-595a-4254-3639-08de33afa6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P0ek31mFMUgmbxI5JVjxVjdnBAXK+svBODF5Afu+ZXuCaO2CrfK3P/BVp+O8?=
 =?us-ascii?Q?+sHK4ZgY5lQvPFehuIt3+jVl9ZBCDpAzoNTxaKM4P6l1csezbqkbLDBd6VxD?=
 =?us-ascii?Q?+dqV1E9ki3yE1WWb4/USxHKe5yhYROzqXEpPbbXStMwBDFCn5UBzuI5JB7fW?=
 =?us-ascii?Q?tZYimsbtR2jKzDTcmF6z2Ing2szkxOMVJM3btseHMntKFTNc+Xxd24nZx96F?=
 =?us-ascii?Q?DC16OsiicrSbZgpA1ZVbG4ogYRBDaVObkO/Xb8BM/ANHuR9hyP7HDxi8GzFo?=
 =?us-ascii?Q?X7TuE+phVSQCdRm8ZfepwmD2Xck5I582aXF2CEY3bBKUE34M341E4qF/Bb3t?=
 =?us-ascii?Q?jNyrrvU31QJ3o2zCIJxq1gEt+ycaW7CJuhb9eQWbLXxzkGfLKuvAXos1QFbq?=
 =?us-ascii?Q?2DAEZZMkEQYuUBQD0wsKzjw7xzRxCKTMHa+d0UqPqcYLeKtyImTUrSCqIvOO?=
 =?us-ascii?Q?bjzxMIJoMdBK+v4BFyyAUmUVZsaDW9lOsq47jyE6lRRs7Oo3cxcsIN4B+9oV?=
 =?us-ascii?Q?9AmCypoPj4S8eGw+EIkZ0pvIjrU0V7aJQuAFuO5EidM0Ye07ndtYD3WmJKah?=
 =?us-ascii?Q?O4o2OFHjG6ylR/KUpRP7TClybC66l/VEiWbUFEKWJW3n5uymolkdQhsOW5J+?=
 =?us-ascii?Q?qz+61mRgYSTuPRN9tkHlAeBC0bvIywJqIPus/VFmLhVbuPq3F1ARdkceUQej?=
 =?us-ascii?Q?JOMRr9K5zHawaJyvPkYT3Bn+TLFZBhmwMFB9Ljhac0GJA1BW/C0NQs7xYVZq?=
 =?us-ascii?Q?QjFf0zvfCQtXz1Qv3L2Asja1rn2JKPhBOL1lx27jNcEclvNIcPfvrOn1KkaF?=
 =?us-ascii?Q?lKoo9LEgaBM39IhF+NZE+izTlfreOvKmAP4M82MdscEOffu/YBdb0tcaGjq7?=
 =?us-ascii?Q?IG0wTcmUJlBZXpO2+CkEOYuwFrxFHYhjfOltNnIgZJ48p0NshaseED7uBWMb?=
 =?us-ascii?Q?UbgKyxpn2YifyEPm2fRR0JOoOrv2USX+BXRWu0I/tLb/2GWixUiqY1bE2GJx?=
 =?us-ascii?Q?KvRc/i2jH6THYSUnjxkaGDjVMi862HyocSBFAM5VAaFZBKBAna6mY+n5aXOR?=
 =?us-ascii?Q?70qgjoBdhEwQPfJPlie6vjn/UAtHzFabNFR0ZdL4h9ZygpX2te7lGnQKKXPj?=
 =?us-ascii?Q?rVn7BpSa6gK0fF6KhdpPuKtY/H4bYYp+SDFJkMweaEqQjfqa1nDXL5fJj1N2?=
 =?us-ascii?Q?kBw59F28qvVWP6A+NJbDqvpa7pZsXvH022uEqFYeSgAcNqH7NXUQ0BJO8d6/?=
 =?us-ascii?Q?5pHdzO+EtfqHODnLu5AWmuFuWWw7iHNTYRtl8Z4hUCoE6FXNIt7CBVtzeuL9?=
 =?us-ascii?Q?5dYb16LatwLH6hjPx2X1h9ZMK+NQfwTjKUf0+fRmwY6zXxZhrMPtL+vXpAnn?=
 =?us-ascii?Q?PSL6Qu2O2FLL9WJ4/VtdcIamNoU3J1LQ/2cKJg7gdtZyo+3OQF16V2SLjFJd?=
 =?us-ascii?Q?FtqngtyGhEQMpPzlPRLBlvg6mBDah5OU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KgVzp/DDgSDtb6Zzh3vy5YwWN2IsbzTPwiWaSsnhXQVjNvK8/QjEd0l1O/LE?=
 =?us-ascii?Q?oMKAAyMlCmXNuPlvHmFl242x9wq4e7/rudCsdV7TfjIxccHByXHahgez+ln/?=
 =?us-ascii?Q?9AXG8ctrze4QEghqWO693aLbuOJOAwbUcDg8wWag0wBci0wbN9Neu511e3ai?=
 =?us-ascii?Q?Y0Yeup6WffYI63OL0+P2N8vOWQtFOK+uFKjiU95Lu/Ogoe9A+cyormlAL/at?=
 =?us-ascii?Q?N83S6QqgvfPUyoB1S9l1VP52gMwL1KK0z+WAb3SMpGp77NQFGj0lHoTqWxR+?=
 =?us-ascii?Q?2/WzgJ6569dP/Siuxrk0yqZM0kANVDlExuN/5nW65b0FQd/JCSOWUvqqpB8g?=
 =?us-ascii?Q?oBwrXZNl06wEAF1rfvPTcY6PTebqQbpx+y9oc3ESo9BoWxXvm/BUB0UlM85U?=
 =?us-ascii?Q?owxY8pzq19QNPn3H6u+XuNv/yjrl2Gbg9Tarpzngu9E5N+ZKRWmkXr0heFdU?=
 =?us-ascii?Q?vcV9XkgIuo0BmkKq+dSYY7ywLwYG/WdGfbW2A/tdZUPSpyL89aAxzLQDC2Sp?=
 =?us-ascii?Q?xEtxaFRSWHp25pGYVH4wHsP2heohJ4fcjMl8rTINT4p1gmlsHNC3RWn7j0kS?=
 =?us-ascii?Q?XgIwvSM4jV/I4q42rs2lDgbZZnKQl3i6Tc9ViT07jo1vh2UFchfhhhmlD3uM?=
 =?us-ascii?Q?944/d+xUKHYR++pq3KZ5ZuQ+vYciNssxBJbEC5jG9Ve4uLipcyre9XJVQ/Ki?=
 =?us-ascii?Q?CrO/t62mbYXVLHBpHS4tHmGB8mU3GTID/d0pmKiUCMAVnBWacB9/TPfKSDlx?=
 =?us-ascii?Q?xnBWDUS1KFJ04yhXEvAQWMJpzF4c+7qTN4vgLDwtFa+H6/e8ZbqHesEsGpAb?=
 =?us-ascii?Q?msr9iHFgzrKnTaueMAKb+o81I9j4UKQar9rzgmHDk/F2+NUPjZfy2MfCtEgR?=
 =?us-ascii?Q?ees9b2lvY1phrWA6j4Hi7h7cnn/Ol5KNcLum+ZrsKfIrELffs1RsRE4EXGmw?=
 =?us-ascii?Q?jMQRxAak89Aao2MuNwLuozBwuLNsrRDYvnEuqnDN2CJCR6CDwZvgunJRF0s+?=
 =?us-ascii?Q?bj9hasJPqndeFyJDucdI58MR8fzC0pneLv2qZER7BCDoTK+3/ehXau3PUn3A?=
 =?us-ascii?Q?PwSScWdd878dz6iYi5QcINftY2z3w6bFY/GzQ4QzlwT/Hugxx3vre71F0n9F?=
 =?us-ascii?Q?aVhrTk0yKwD7GT20nKWSlIXSHb9Di1+EvQZnRHVo4y74hKUut6U8YAnScEeS?=
 =?us-ascii?Q?YQeJHAJo0SCsayYH+tNxnbpgz839N086eih0+4lqsa+XH/xDa9n6wg04kSca?=
 =?us-ascii?Q?89fMe8K4oM3GhPWJzS0fk3vVtmngUbdorXWKvVhZbnJmfv8gzNpOagXcdsfI?=
 =?us-ascii?Q?9zttaxoOdtL7kQSVCNJ7u1cCf3rw++atddUOzKfRWb3nS2Z8Lqdnuk6k9rWO?=
 =?us-ascii?Q?z2AMzo0sHwQ0qi3ZXBeIIVHZKO+LTMWYcKMDO3wsufsQj1c9+y7U9YDzrD/I?=
 =?us-ascii?Q?KCvkeDC5fUyXUPr0TX4Eo2zlpCdTm8Du/HxLFxlKUL1qMD15yB/ujnw8Q+LD?=
 =?us-ascii?Q?F7fW52EiBcsfl8e6DMBFUb4Qy2/9887V1qcs18e3jnoNJ9gMjaAaREBq8ukk?=
 =?us-ascii?Q?yUeaYHISSVkGmFiyEYA9LNqNd9/uLBYV+6n5PZLiu9zm7+RbqabpNDuBPQam?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c60906-595a-4254-3639-08de33afa6ea
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 03:37:44.7552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDdrAsjhh0wYcAIwXFR4K59t7BBkUZSAjIgacH+aBKO1UkYQEnFO6ZqMW9itlUx6eVQhNyL0C/0Jrqo9ge3UvAtuYFei/5RuAN7acRXaoxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8681
X-OriginatorOrg: intel.com

On Wed, Dec 03, 2025 at 06:21:34PM -0800, Dan Williams wrote:
> In preparation for adding more setup steps, convert the current
> implementation to scope-based cleanup.
> 
> The cxl_memdev_shutdown() is only required after cdev_device_add(). With
> that moved to a helper function it precludes the need to add
> scope-based-handler for that cleanup if devm_add_action_or_reset() fails.
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


