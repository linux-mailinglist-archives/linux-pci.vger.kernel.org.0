Return-Path: <linux-pci+bounces-7356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 713818C25C8
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 15:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D41B2407C
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B6912C520;
	Fri, 10 May 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P38EJTGS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965412C461
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347879; cv=fail; b=HoKG+ib+wHPhbwCxJ3iEDbSiSlgGFcGPZbiy9AUlpt3NdHtRQbQbKHmXpTsfU1LNbpV+Z52Qh/Rb/I672Ja8L2pnyf7i9MVQHtQ96tVGnokLgb/CCi7ok7rFzVZFkL1sxG7ujblzZbvsiuQXeqL4C0MmL6PKPChg19i7zrKjXd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347879; c=relaxed/simple;
	bh=578OksjjQ1hO6kG65CYj/yeVA6NpCQ4Dk2Bx20359bA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ig/bq5zXZ/R+hsMUqmz2dDwW21aA0/y+MJpHVYH2kVMH9389LviH4qIgl/GpcaWQVa8ASkT4zMT4AZvrctY98fLQv2dn965btGURYBSJ6Eq7Viqaqi862HhVphMn8DFFURAvWs//ve07g0cD8kTMC4m2e4iWUQjJoOVGSmF6rgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P38EJTGS; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715347878; x=1746883878;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=578OksjjQ1hO6kG65CYj/yeVA6NpCQ4Dk2Bx20359bA=;
  b=P38EJTGS6nFdHlnS+VP2TvgyxfaXb+i/432r+Z8qi0aENLuwCATFr5Pj
   XBwn32WIgMJ3TKpLWLQaRzuX81JabDWBNWPcI1RJastQMgbJ55Vgw4kWO
   CyJ938snT6/fHL4X4PzqxyGD/kjdb2wji9mA16CY8tMiqPUaw7Q3hRkoT
   CaEs/L1G7ib6Z0nQMQAcsLxB+UbrCShDwMPfkd4CrIDyOceioqTw+xTh+
   p5TBdNURrKCFYs0HcG2piVwm9jhhDfOEDAGdujlRLbVx+E8n5MHCRET66
   eGP8Nxg49io0aRT5HIa7aetZ6f3Lf/KNAo+z2mJcgrU9Ln5mbt3NzwI/X
   Q==;
X-CSE-ConnectionGUID: r8HNaDANTzC4ZjVamOhFBg==
X-CSE-MsgGUID: WklvrgFOSG+IgUFCeRbFIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22734136"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="22734136"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:31:18 -0700
X-CSE-ConnectionGUID: 274eQCAQQCWaM/364gSgQw==
X-CSE-MsgGUID: k3mjkaB7RIiDrRXrbKkRZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="60785037"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 06:31:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 06:31:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 06:31:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 06:31:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciJ0wpelSQsAestVyiyPdfLMgbVHhN6DoasB4ynrF8HJVQ/Wv5yQEFsA7x3zlET+yU7jvwuUctZCzo5MsuwcFuNh39clhlR3A/E55GSlUaO/GUX4xmmj/a22+ZwOd+U8xS+LXoSh3p8iEcAM9Y0XjlVjmn2aj8kp5uLkXts2XfX1rLaHl4bmUrIrhmSTtfaKp7akrthBkKVwyzGOmYrvXr3KA50d+nQFrD95BHpXlfza1wGqeJbZmolFS6J3IF6KDTJ1w6G04bRtK93prP+h7PW780qoN7Uvbr08cjxCUm4IUuRlxNtaCjfZupKLXxVrpeneQ+QI0PQ+D9g+AiipkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKOVpeB0tK8DmnRSUJKxVRZp5Q8T2Uj01Rl5KpBKFH0=;
 b=JfYtBiXEx/rcv287GD4RU/hUc7gYlAvfYi7MRZDpnhfIxpf0N27rNSCVvdH+49t6UAU5mKhqwt+5bSAUpVPZ4xIoD6HbPDDya0lWV8SA4GJGataZX0de8KoPm45sB3hrLh49rx63ZVfKfp13e5lc1D/9FraMPdT4chF4sgnlnjaNqwZ7j5tijEHY+EOfnNFUalxq+b91w6+fcJoijYkDCsaJpBm6WVphb6g89XOGMCcXPtfkMpq/mYxqwqNzMknpISEBMRChptGCTTk8Ef7eA3P7qXvo19NVtXA/9In1CirQBHFT11ORRS8FON8VyHJZ+o1aBxOW1L3UNCY9woqhaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by BL3PR11MB6386.namprd11.prod.outlook.com (2603:10b6:208:3b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:31:13 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 13:31:13 +0000
Date: Fri, 10 May 2024 09:31:08 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/8] drm/i915/pciids: add INTEL_PNV_IDS(), use acronym
Message-ID: <Zj4hnJJftNlEZBN2@intel.com>
References: <cover.1715340032.git.jani.nikula@intel.com>
 <5f9b34a2cd388244be03263a5147776bfe64d5ac.1715340032.git.jani.nikula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f9b34a2cd388244be03263a5147776bfe64d5ac.1715340032.git.jani.nikula@intel.com>
X-ClientProxiedBy: MW4PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:303:b8::8) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|BL3PR11MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: d077b931-fedc-495c-6174-08dc70f57624
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lHLSAUBiqY+dCo6dkJcqJ1foiESBPy+GnUfmxUo6F5mMtlSZaJ8y8ypfHtMt?=
 =?us-ascii?Q?6ibrXioqVr5+wDYcHByvCRQmpH73kOQUSYfTRLBxjKPwrfsXbyHxI+cU4fLL?=
 =?us-ascii?Q?1plOL90OHK77EpGBYnktFe0wcrsIvUK+UzTU2GYB1WF+XniUN+0nvHbhkMEi?=
 =?us-ascii?Q?wVfwST++MBbRw5/dRBqdFsUQt32y8GLAqb5FoNmu7QE1Hf0nVQlvrtD6ZwKM?=
 =?us-ascii?Q?Xo1LA0Hq+kpg63oCMvdoC/z5JAvwvNso7JEYaE8gkelOCG+ISzslIPuzomd7?=
 =?us-ascii?Q?T44Xx/16YhEhgZ4r5DnXl/hSuz+3gf3gTJO0zW9GqVPYKRZmKFE3BRgiLMS2?=
 =?us-ascii?Q?dPIOM6D/YhogXqgNxB10+95x/zktR7FFruS6pvgDjCuQ3KkT9lv+CZkFN8KL?=
 =?us-ascii?Q?3UonLnNlrScUI14FqTGq+1KLUxwiAbJTCvwmUGVhlYMTKeCeEx6U7EAsp76F?=
 =?us-ascii?Q?qbw8q4t+mslFh+c5egJbQszOTfDcrG2b/xA0oau4yO11SGusw5EARVPXFcDJ?=
 =?us-ascii?Q?3+HwWFpaXTX0jq9h1H0bSsL+uFJ21tW+DPs6kdG12cbapeAKY4txDpoAjaQ5?=
 =?us-ascii?Q?w39R0ecmfH0VRuDEc+svviy2wCLaHca2Sm+jTI0M4+NDczU/0+85+0tEBbxL?=
 =?us-ascii?Q?YvG6fbdQG+TNZfk9+JoukYyCj0/pitrKugVOCi1f84CKNZQ0/80XhK1NCnk3?=
 =?us-ascii?Q?ryCtObrGNg11DdxO/b262OdP7Au7LqFEjl/3izAW8HxyniZPp+csCGUCzxk3?=
 =?us-ascii?Q?uTZ67smEfN58YAU7HAHwK+c2RTSFvcldqvi1+stKSmeKPBaxOlyopdnML7dL?=
 =?us-ascii?Q?MSkLuGAoqWHtyvUQ4QbxgJ8koBz7tjI5wvR4nE4/kV7HSWp2rTBBz4W3B7oH?=
 =?us-ascii?Q?hvV3Mn7Jw87fgS16hegWduY7pcGYETCwAq29Z2G8VYHKxSjOr4OGuWkPr8S7?=
 =?us-ascii?Q?SwQe1MkSkGQAnQL9fiOkK6unrJLq0LazCzoUKQsakC50DQcX6NOmJC2FdTWA?=
 =?us-ascii?Q?+74TMPnw2Xf9km5EWmh7fOVDLW3Cibatifb0U970XmkHOj8i0A3fxAct1t18?=
 =?us-ascii?Q?dMGQMQ231dlr6Tfbc0tYO5/zUV4EzkX/TpY/AL/EjZq7aQGoE2lKbhAIlLHa?=
 =?us-ascii?Q?dCgluPtDcajkexH9xBqPCCJHomB54epfhuW2bZD57MCAfXEvfh8TK9iJew+A?=
 =?us-ascii?Q?VlFTQ7B5eFMuTl6Gi0IGzhdSxti2zLjviXUOT7jeQaScuOr2ihAKWRzBxCBH?=
 =?us-ascii?Q?Yc3rYehuLkBSIDH469gavFKLZQ4MFpD0sMD7ArBz7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RgIrx9Y7xXp9B+pPQ2hsqf5qhwTxALwBvnsN8NljIZlKujo8byBYWMIi71Rf?=
 =?us-ascii?Q?Z9UbfDo3X3UKvHAug1p41a2t3QJMbQGTotkMxZCkagzl27gekKQh19thwSZz?=
 =?us-ascii?Q?Am0Jkcc9qknGgqonYmLAinj/W6VGz1ivW6KUYs8Uurlldblx56WLJTzj9HyS?=
 =?us-ascii?Q?Xo69HTESRKa1dUjYFppXVtPnTpgNjWp32IvUBi85oDKy5fffvI/X5n13SSo3?=
 =?us-ascii?Q?QFJ5GE/8hVytFFfshUvQybs1J5g/5cBR2Ltcsqr64w/ozh+t6WrIUb9jFMxY?=
 =?us-ascii?Q?R11JqreJwXSHm9ABS3P1ShumP1tVqKkv1nd4Bw+yg1iuTRHtBeppfNgyBRlV?=
 =?us-ascii?Q?QOEAPc9Tw/YhQ7oN6t0pjqVYiLvP6xN9arBaZafJdZvZuxwXVEOCEKUtCzrt?=
 =?us-ascii?Q?sqLU2EvGvUeM2uBpkiTX6y03Nq9v7yEat7wdLFf+GwZqRzSpRJEkQiU9B05a?=
 =?us-ascii?Q?zFoz11y00pTxIAqdemV2FPf3d5dyZLiy/PDgiqQuOoP1gCyndI7Wh7GC5GZi?=
 =?us-ascii?Q?FDRM5XplABGlpYiZdNnNlU4yx+N3bSMkvUBa85c3W7kj7z2WXjccVNlCm/mL?=
 =?us-ascii?Q?a8o6EffegHHf8EZCHZB4ecUOelfDn8pdIM1UUnXTqNN2EOdgzxiKD9CPqgWc?=
 =?us-ascii?Q?JQbZJHMBn/TaewGQyhKdTZbBaCrghpXeDT6XmZOaOh8cOiIhZ5Lde+KmDr8D?=
 =?us-ascii?Q?QAbbLFpmOrGrtslqD7YXSERXCVQNLlThGZVv2b0cHKFPH4r3eNN3tYGcZMx8?=
 =?us-ascii?Q?1KVUIWz2riMfeDpLn83By/wC9yKQatT08gMnP6SObZEiLbKT+vMctKXPkmS+?=
 =?us-ascii?Q?csGeMhEVRg5+kn2pMxZDWbb+0R9OSQkDMD8t84WNFZRG0SXhL3RHdWiCa0i3?=
 =?us-ascii?Q?aj5xldfdL+3jM59yCEg7E3KYTJL+mCRux4MrtpB65Kt/9koIyzzjNGXVqt69?=
 =?us-ascii?Q?XzTGrFlC14jAN9f6TJfmpa6ATkQurrKsUNSXrr5nTvTRUtKVJmAH11OHT1Jv?=
 =?us-ascii?Q?lJFDYPTTRz7pbx3A1GwkCSh+pZE19Kgcgg3fTzU/o1B8JvnyRPwXkVbgZzaj?=
 =?us-ascii?Q?Ybxmz5VPTY4KzGBFSkIJ1E7/nJWw5PzYnMWHY1X8pbgoLijt8IlDWIpE8soE?=
 =?us-ascii?Q?8H80zdOlisA335TyQG8F6FLohrVS5Y8mbudgdgA1PHbcbNKJBy8n16WqjTi+?=
 =?us-ascii?Q?C5KHYEcbX0i1FbJ7i/zqa4Mlv/Rxok/NK8LtSTSgZOvEv4mG3ziLLtcPDU9q?=
 =?us-ascii?Q?a0F8G1oQ7xM2/9vgU5qp4LLVB1Use1np9f3PZRDJc6iiQaGcr2WqaoHpc2yi?=
 =?us-ascii?Q?pnv6v4LBj3SQJIMOZxweyNvLyJB5v+6xR8Y8tH0G4Pt9iU/VRauB1nzE+SZ7?=
 =?us-ascii?Q?1uFO+fi42OuB6gaQSTDv6eQ7zzlJ/i6sj4/paqLr6sjOmez4/BXwC+krMivL?=
 =?us-ascii?Q?36ihtN1EoHpgAp8XxlQR3FKp7lXj4sNK69lr+61GXqwLt2uTKkPQcXtClvw1?=
 =?us-ascii?Q?aqmzxKb7/vzAyvn29Q0C6WJwavfPdfRAzGqdom0pVy2oZjGmqhYfu0kAmchG?=
 =?us-ascii?Q?XoQ7LjUmUxut9bp28nkWc0h/77g6ffB1/mX2kpRRnaWzXeUPOJ1w9IX3KhU0?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d077b931-fedc-495c-6174-08dc70f57624
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:31:13.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBO4sxXUUEvEWVT5l92O15rTdi9k9lQPi4QxT0R/Cu7RQWHjPINISxmVbgcEwu33Piu8ofpljM5wGj4bifgRBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6386
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 02:22:14PM +0300, Jani Nikula wrote:
> Most other PCI ID macros use platform acronyms. Follow suit for PNV. Add
> INTEL_PNV_IDS() to identify all PNVs.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  arch/x86/kernel/early-quirks.c                      | 3 +--
>  drivers/gpu/drm/i915/display/intel_display_device.c | 3 +--
>  drivers/gpu/drm/i915/i915_pci.c                     | 4 ++--
>  include/drm/i915_pciids.h                           | 8 ++++++--
>  4 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index 59f4aefc6bc1..f50394a00fca 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -527,8 +527,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
>  	INTEL_I945G_IDS(&gen3_early_ops),
>  	INTEL_I945GM_IDS(&gen3_early_ops),
>  	INTEL_VLV_IDS(&gen6_early_ops),
> -	INTEL_PINEVIEW_G_IDS(&gen3_early_ops),
> -	INTEL_PINEVIEW_M_IDS(&gen3_early_ops),
> +	INTEL_PNV_IDS(&gen3_early_ops),
>  	INTEL_I965G_IDS(&gen3_early_ops),
>  	INTEL_G33_IDS(&gen3_early_ops),
>  	INTEL_I965GM_IDS(&gen3_early_ops),
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> index 56a2e17d7d9e..0e0f5a36507d 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -815,8 +815,7 @@ static const struct {
>  	INTEL_I965GM_IDS(&i965gm_display),
>  	INTEL_GM45_IDS(&gm45_display),
>  	INTEL_G45_IDS(&g45_display),
> -	INTEL_PINEVIEW_G_IDS(&pnv_display),
> -	INTEL_PINEVIEW_M_IDS(&pnv_display),
> +	INTEL_PNV_IDS(&pnv_display),
>  	INTEL_IRONLAKE_D_IDS(&ilk_d_display),
>  	INTEL_IRONLAKE_M_IDS(&ilk_m_display),
>  	INTEL_SNB_D_IDS(&snb_display),
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index b5a056c9cb79..aa8593d73198 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -810,8 +810,8 @@ static const struct pci_device_id pciidlist[] = {
>  	INTEL_I965GM_IDS(&i965gm_info),
>  	INTEL_GM45_IDS(&gm45_info),
>  	INTEL_G45_IDS(&g45_info),
> -	INTEL_PINEVIEW_G_IDS(&pnv_g_info),
> -	INTEL_PINEVIEW_M_IDS(&pnv_m_info),
> +	INTEL_PNV_G_IDS(&pnv_g_info),
> +	INTEL_PNV_M_IDS(&pnv_m_info),
>  	INTEL_IRONLAKE_D_IDS(&ilk_d_info),
>  	INTEL_IRONLAKE_M_IDS(&ilk_m_info),
>  	INTEL_SNB_D_GT1_IDS(&snb_d_gt1_info),
> diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> index 85ce33ad6e26..21942a3c823b 100644
> --- a/include/drm/i915_pciids.h
> +++ b/include/drm/i915_pciids.h
> @@ -108,12 +108,16 @@
>  	INTEL_VGA_DEVICE(0x2e42, info), /* B43_G */ \
>  	INTEL_VGA_DEVICE(0x2e92, info)	/* B43_G.1 */
>  
> -#define INTEL_PINEVIEW_G_IDS(info) \
> +#define INTEL_PNV_G_IDS(info) \
>  	INTEL_VGA_DEVICE(0xa001, info)
>  
> -#define INTEL_PINEVIEW_M_IDS(info) \
> +#define INTEL_PNV_M_IDS(info) \
>  	INTEL_VGA_DEVICE(0xa011, info)
>  
> +#define INTEL_PNV_IDS(info) \
> +	INTEL_PNV_G_IDS(info), \
> +	INTEL_PNV_M_IDS(info)
> +
>  #define INTEL_IRONLAKE_D_IDS(info) \
>  	INTEL_VGA_DEVICE(0x0042, info)
>  
> -- 
> 2.39.2
> 

