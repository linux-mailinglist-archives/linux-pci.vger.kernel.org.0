Return-Path: <linux-pci+bounces-24853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27272A73565
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C423A512C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C5915E5DC;
	Thu, 27 Mar 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUmuHasN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA452AF07;
	Thu, 27 Mar 2025 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743088287; cv=fail; b=JCRI6IUVCNEGpUi8i/bnUa4Co1iK/MayC7NkzBkdIIGox+7jRA29n4hPWUq7hhrRW1lSaf+jLqkFKqRd+e/yx5UtM7IiScKTmHV9qHEcAICrkO5cLu2N6TruKfSF0/KVOG/+JY8RLvDOKTmWzth6qDyNvJWeNgH7lZ/PdIjeNAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743088287; c=relaxed/simple;
	bh=130QZ1yhunWqOAy0oYPRcG1sHomeuuSIejVlBrtNW2I=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lpWDejzDzyRg9qVZ5bcAHigEZOmBMNOxE4bgNttp07njs1NWMnKk9FEOAznAKy1IYh4Znd6bSGtcuMtHkO6BrfY2Arq53j2TKkfzmlQMBlz+5C18+Hzwqvgye+kuKxlMZVQjbydo6JrsMNKHqSYVUMltlo6ms00C0n5dTkCq8vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUmuHasN; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743088284; x=1774624284;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=130QZ1yhunWqOAy0oYPRcG1sHomeuuSIejVlBrtNW2I=;
  b=lUmuHasNU3aJ5bedwaJtZonT/ixfyngtdORkDkLAPbzeEZLRd25+vwcW
   pLP7TpGM/XnD28PClKjTSMpJp1Vh7w2t/282u8t2WnXO6uhZQ9WwrLBXJ
   bCStoWyyqn5fApIRaFFQFsr3ANpM9M+mHxbSrnG+uINyjVIWv2N/hxEDy
   kDIju/z7V2ITsj11TKAtCaaCK8o1njKo/lMXuVfoaGdrqQQwkNXjhQuyv
   ZwPsoJOlOPTV9VSAFUwezN5k5y4pTfYFDa7jlGGxwpy+crfjmdGa5rnUt
   SOY8zjFZFtBoSfJg/DyXD+nts1ronEOOt5j9rEBR5vY/wLwLraO/EhFQ7
   w==;
X-CSE-ConnectionGUID: lUxxOR7XSC+51a+ZXPVMkA==
X-CSE-MsgGUID: KHjxWKCtQDCXaIgEKqh7IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44587620"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44587620"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 08:11:23 -0700
X-CSE-ConnectionGUID: XxIZA1U7QRm+jYQNAs1Zjg==
X-CSE-MsgGUID: lKXuM/xcS3ynFAxKVo5Beg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="125145182"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 08:11:23 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Mar 2025 08:11:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Mar 2025 08:11:22 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 08:11:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOJQO9d9SyXZ7VhRDbdC50H0gGWDgNSU/XM+lbdxyY7Gpf49d9QurmhbnaHb2Pq/gvS7hqWjOyiRHMhI7oojm9uB6OhMWjKsH9rkUaThCRoOwDp9yBfVG64AFQSeyAzPJaWV3hmvgG4D/a27weukwyDhfzPU8ITUcn78RywevasnHXAd+f/tEUtzYcfCn0paWeAtUXk3K0TZAc4t1Nur2LVaYdbyeI8elTgF3xLArlG7OD4+rpEX2VHSRapOC3tFKu+PHLw+JRRJI6gyW9vj3ensxiWWYcSAtrZ6/aq7t2Dt/6AGbR6Q94xnoFYkY0lnYOSBwa7mCf9OkvuX+FqZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpwRoSKDlbpaNTcCxDiddRMkuWd7du+WgrxjrY/UMzU=;
 b=h8MZGV/6RenC1eWrHKTPwyEsRvhWNqohJr1lVaZr+g90GqNfvk5rRxPpx70YkfMqVaHGEXFS6Vewu2CyjroWQ1X4d2o/jdrtEbexFRSbas+IMpsPywgs43PbeT5EqIh1dO4yQ9tiNjESPEb4O5f55wLwSLGJvQo3OIUJJSF7MZzIdfNq1EEnIHzJz7+eQ3ES5Sm3ZzgevXaPWLshfujdFENcbKVKEeI096pyRKrU48wRfvJph9n7PZk3riI/k5xEDBgbCKA/yxneIw6pANm42F9ZGHg1F0RiKNGKoGckNKtmOf09/kkBiKX1LogZjlb8OP2T6gxeFaJP4I09EN1MBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 15:11:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 15:11:05 +0000
Date: Thu, 27 Mar 2025 10:11:21 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v8 01/16] PCI/CXL: Introduce PCIe helper function
 pcie_is_cxl()
Message-ID: <67e56a9933d43_160b72946a@iweiny-mobl.notmuch>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-2-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-2-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:303:b7::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2ee69c-7abf-45a3-e494-08dd6d41984c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WnzzFbYQ6WGcZtYpEz2TXfS8YyfS5IviwMoBr/SS+UrCQYAPRh/3Yq+Kjvbz?=
 =?us-ascii?Q?MelLO9g08XBmH8R8Y2dx2o0RLND65wIBt6teLJnVORkz+JYIisio65ouIkOq?=
 =?us-ascii?Q?0xxpSlO+XAorj3HciW41pe8F9vvdWoOalhdX+c01TxtH1DO6DE3YhoSBi8BI?=
 =?us-ascii?Q?WFadG+XU7MtgKuWKrk0vfN4/fQjdzP2dmp7mCsTYVft3icBppPv/pHrt0to0?=
 =?us-ascii?Q?PRhxZLF5hyF8CBE51qo8p6k8dfzBkXBWYC6o7Gf/7BsYoLKdY8yY7cusOZsb?=
 =?us-ascii?Q?/dcD2U7ULrY+wwmiFPTm5XZ7hT92SC6IhGQDu120Juw6Dan6yvAP4blBHN6/?=
 =?us-ascii?Q?DubHzYCftTPRMux22T0Nu5MrcJ0BQzJ0TxilXScoIMs3b07AlUoikPHO9zQI?=
 =?us-ascii?Q?udrPM31k8tjQZKdYJsmndzfSmqJ8MMBFHcdiXHeFhQ90wTHbgmplLcEfb4WR?=
 =?us-ascii?Q?egDWIEB4q3Zz8JN8WH8VJRKQR49qk2bmFdfb7HlRzt9tR8qMPOvSiR7iN3IA?=
 =?us-ascii?Q?gXovbN2uMUZwizHHYdhyZTpyDvlKIe3ReQjmm0WmY+H9GsF4aBwZ6qBsMfzU?=
 =?us-ascii?Q?50i+jWdIkf7etcafgPQDY2GB5VWB+dt0nuOAJSgDhFur3KYOI2w1ymNtJgL/?=
 =?us-ascii?Q?uaIKbgoHojknFRhVkzaqdJv3+YwM1cd/zO1Lz5hUMub3XO5v3OnWLaLlrBfu?=
 =?us-ascii?Q?WCqetFCCGK5RVVBulKvL0Z6KBXloH1uHj3r+0k+nxLU3NeUIeECf374RoVNW?=
 =?us-ascii?Q?HV9XcEnm9V6pgTSnoIoqjkNb9q/7RpPUyZu617knAxh+ax9OlzhZpm6lzRyf?=
 =?us-ascii?Q?fjwuc5VSjf0lF0s/JLL2V5rWwXIU6BCS4JQ4AXan/x4T21quTIt3y33qmnrU?=
 =?us-ascii?Q?bfZFQH4xL5iiJ/v8XJydYPtI795TPHapSAx9BjKD/4Yc7CSPkV9ttGP4az6P?=
 =?us-ascii?Q?dTo3lKKr0A99r1jGWTfI6zhR3kxbc2XI+/aC5h/+7KxooAChzJGP9xkYXuHn?=
 =?us-ascii?Q?cHYnEdtcwhK74WKVvBijrRrIMSOBZH0LprGdcgN1D7Q9KQQ5yYxdNDLQ2i1Y?=
 =?us-ascii?Q?22zu2Z1JuWlbI20I4aV20qGqaEhdSH+TvDTsNVk3yZcwdzsZNZSwEccAyH3F?=
 =?us-ascii?Q?M2xWe1HQH7X+5zocd0jzvryIoPVrMFhl50P/H9CzB4g0ZgJQpebwRU4sSluq?=
 =?us-ascii?Q?NbMkC13X1d7Smz7sMXxwj1khPZujh1CzJwbTxxbm1JDwiKa4YTY927F1GXCw?=
 =?us-ascii?Q?VuRZRw6xFADoXwTLK29Ij+JIW5B0Os7Wy2RQfU+LYmQRrvjerbM/Cr3GBI34?=
 =?us-ascii?Q?ykcz/Q1CPs110VsEm/5gBIg6L6CkSxQTlA/pC2Gus4xsg6e9+MOyp2cPQWri?=
 =?us-ascii?Q?qXYtOoORyz997QXKLr1+vD7x9RJOgTlFHzvGacZeQTEpTe+gRZvnU8NyQdcQ?=
 =?us-ascii?Q?ubr55wBvoqA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ICLRxUmugi4g0SnNk/VPP8EhHSBkkZi2UkrEzlIpslFNyClRnRXD8Vxo7tsw?=
 =?us-ascii?Q?CJCjtvXrAeEjW73/eyocl33H8CLKPFuM/OBWUxo2pGvOp46cCvtNflibQb6I?=
 =?us-ascii?Q?62mxoEl58p3zNgeGsUHE7pZ5aehtqCb4F9+AP7lewU7x8GFZ48AFv+5VWPvf?=
 =?us-ascii?Q?mwShOPcLqVdmmbD0eVb3Nap/v8Wc3BA8f3m7Ul4k8j8GYmuSfBi4RBeKsShk?=
 =?us-ascii?Q?V10VNazonwVKUsprdjQdSYtLO2wWNgts8fiEMX0a/EFqXlZjz/HwBfOfUMBM?=
 =?us-ascii?Q?XuUfyLCFtPFFD59Vrlvd4RtIgITWX+R3BJYywaXQ+SGp1kSWzW7sSo+jCnWF?=
 =?us-ascii?Q?LrU6HJmX+jY7wAIfyTAojpEyHWyXNjQcv6xVFWWLXACHmd8bD9JVVgOFa4Sk?=
 =?us-ascii?Q?7RR5iKzFpTwMKybAfI8BpM3jTYMhk/4+mkqZrPRs4dKSPvO8fvJvRhWowGUO?=
 =?us-ascii?Q?4/u84HhUEu2LXgKNzJufUVrva3mvFI9R6a8cgIH0/OYVI+N2RBs/Z9t92FBs?=
 =?us-ascii?Q?NcU4an2HXva8C5ZhGj6ODoY91qLwNOL5rrUIw3B9BBG70qN4B4Ju51Oz3BS9?=
 =?us-ascii?Q?RZqHDCsBMH7coCGBKb8Vhe/TKUlx6P6imc/tEYxLRn5xcZP07Lf8U7DdzzdT?=
 =?us-ascii?Q?1ETdMbEXJF0PigAsL4la9ADUfiy7Fmz8h+8jD9E5FaEnKRPQg2Gi5DntZnTy?=
 =?us-ascii?Q?LIhw9vdCQDQr1vRmAPeP3MSvoO429LW6zvpBUd42nMz+3zH5oD9exyXMoAet?=
 =?us-ascii?Q?Qou6KNkuGUp6P8VGZ9ZHq9GppCzSbvIr6EhrdKnN47LrE89f7PeyzWepETZY?=
 =?us-ascii?Q?nk2HJ6L/TT3/LOGPiHyXWvB7pyPR7HigqB1qcDec6+OGBUvMhQDN0NVNN8kz?=
 =?us-ascii?Q?+NyZUvMhKTIi4CKSXkKXQWBYclL8d3WiPTCW5mDkbbCWu5ayWfa7AG4mKZFJ?=
 =?us-ascii?Q?uJLhkOdygVnqlNLIokEbTEgYGZfC/Hsc0YJinKP5YzPfMDRZrwHBqdYIjPJD?=
 =?us-ascii?Q?1oJW96lEb5jZPjbnw2lhGvMsIyX7b1IPG51pqe+GsiT+kE+CBJ5wolSRgL9Z?=
 =?us-ascii?Q?cuzm0FiUxLGKqpoyNxmJ34pwf3Xuhxdy+IB/ReHFLpUND1fnrnFgCsyhe22y?=
 =?us-ascii?Q?fthRjUjQiiRkvyUSBuPH53z8ZatLKKzJvw0qnUy84KKg04xsFmqaik4QgNbH?=
 =?us-ascii?Q?M6/IoQtJ3gUmWrmxxLj3s75lAf/fBhMd9yFnWbB8Xzfj/gxUox9+jq0hbVXk?=
 =?us-ascii?Q?tUpKtgH0IrXK1NcJHzbPueJA5CmHF+DaMhdwod5hbTiZLKC18MPEkzBH3Zu+?=
 =?us-ascii?Q?LAvoNIYHBNEGUNHzp/nhdAtLf+9VQ1R2GDSXi1F2MgVhbpzfx6oaEBH53bhv?=
 =?us-ascii?Q?BrFJVplVnWtwioDXP00t00R4ebmrg3JNioh5cyNWmcRY7YAZT+gPbOrZsj/g?=
 =?us-ascii?Q?eAA+VUZGkNM2oStohmWvSVTgOpsQPLZHfBlCXb5XuS51Cx5cCogEOLfT1eFz?=
 =?us-ascii?Q?k17PP1Sq+7LuAnIKbX8mRaibsU/EBVxJTTlrrWkyh9IPRQPs14tV6Li+BKbl?=
 =?us-ascii?Q?FaTXUlo9RwYNE1dAlJhfm5ceDNE7jwJb2PcMg1me?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2ee69c-7abf-45a3-e494-08dd6d41984c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 15:11:05.4365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1Jdc7MrrQzFsVUY6/b9FjRBFc5Q9TuPxkYshARRQnHkodh9E7UKDa1x2wsgdJOtUD/CtOeJ3/x70rSEDee7BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices.
> 
> Add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC presence. The
> CXL Flexbus DVSEC presence is used because it is required for all the CXL
> PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> Flexbus presence.
> 
> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/pci/pci.c             |  5 +++++
>  drivers/pci/probe.c           | 10 ++++++++++
>  include/linux/pci.h           |  3 +++
>  include/uapi/linux/pci_regs.h |  8 +++++++-
>  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..a1d75f40017e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5032,6 +5032,11 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
>  					 PCI_DVSEC_CXL_PORT);
>  }
>  
> +inline bool pcie_is_cxl(struct pci_dev *pci_dev)
> +{
> +	return pci_dev->is_cxl;
> +}

Shouldn't this just be a static inline in include/linux/pci.h?

> +
>  static bool cxl_sbr_masked(struct pci_dev *dev)
>  {
>  	u16 dvsec, reg;

[snip]

> @@ -741,6 +742,8 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>  	return false;
>  }
>  
> +bool pcie_is_cxl(struct pci_dev *pci_dev);
> +
>  #define for_each_pci_bridge(dev, bus)				\
>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
>  		if (!pci_is_bridge(dev)) {} else
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 3445c4970e4d..7ccb3b2fcc38 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1208,9 +1208,15 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> +/* Compute Express Link (CXL r3.1, sec 8.1)
				r3.2

> + *
> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> + * is "disconnected" (CXL r3.1, sec 9.12.3). Re-enumerate these
                             r3.2
Same sections.  :-D

With changes:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Ira

[snip]

