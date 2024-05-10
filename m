Return-Path: <linux-pci+bounces-7359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 303228C25D1
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 15:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86AC8B2445B
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8069B12C489;
	Fri, 10 May 2024 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBTZeB5E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11B12C471
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347940; cv=fail; b=r+bhLteYiIKfvbtKQvUuPBBFkqQYVIZQUFaB7k2uXwQBfk/1wAPq3/Z73aJSd7trk2LULPpTG5uTVoLTV5NweJ7UnxrcCrbGvnW3Q1Dous2lix62joCXkGriOBM6LiRFyA7pIUIZ2mhULBPpzHXfO9lTMluq3UJcgQ83ZkkiQGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347940; c=relaxed/simple;
	bh=iIhOf8dK1vo7E6CdahSds080RpwTJvUWCH1xiUVYLBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V1mnIOnEaO+pXfyY5ZotJTS2Aj48b1Udb8p9hRnj/uAVfkp4Dgsjpksh11Ha42xPObHOI7RgGYpjs7zBWVr67E/URO6i57uhsVGLEtc9OhFXDaxnrpN5ZP88F4Ldp7z33B+IGA3QrT1NqqQ0dFIuoC2kHsRShHNEi7zODyEIEWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBTZeB5E; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715347937; x=1746883937;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iIhOf8dK1vo7E6CdahSds080RpwTJvUWCH1xiUVYLBw=;
  b=cBTZeB5ENVHgh8oQCUvEalb7VgbPBqq1fdYq8mm3fM42+SHz/pMdy/Bw
   x9wc3ibch3xoZDW7QcDxnxidjPKn9/I2pJNMBeg+7uhsHcUg7IHGuci10
   Oo656fUPekIfftgjxd5D3epOsQgqmtsyWnBqjUNTZkpFi3kJg3xsbQcR/
   lgqGEMGsPDxoQqYYgyg+X+zRh+JX9C0firXRVNrzrJXj+7NYrY0m+MUql
   aLUFfb3x8obNwvS/vMaEjqGQg1yLOSWjs/OrEP3FCBYEB/8iWI95ApUQF
   u21KP3Fz6DMtkdrQXETlgodneG7GzPPrsiLX14QbPSaqvJDvrarvyUF67
   g==;
X-CSE-ConnectionGUID: mQr/SMGRRP2c9IcO2bIjfA==
X-CSE-MsgGUID: 8Dsv+KAFSEiE1ZWNmCvpTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11490818"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11490818"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:32:17 -0700
X-CSE-ConnectionGUID: Wkl83ugMTLWsZLgQON41dA==
X-CSE-MsgGUID: QnAK81PITuaGzPuXvt1a0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30170142"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 06:32:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 06:32:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 06:32:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 06:32:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 06:32:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqPQBXZs0HLxp4spsGZu6cJ57Kh8nrKuXbt8P1CyVmhh+Xd+5eoOYnf/sMeOF/mFd5b9//oFKM0oF1hXueJeoC6EUVo2hck3T6GmYYag61XPW8/c/4cgFypCXKENnL8xCwW4SSr/zUYyUr3nV8Xb0+nuBzdAmALTbaHZPkvDipzSMpkvTxJ9wQd/svNDy/GByQg5qxd8MZrVL84tpUGPoVGmTjjqXFOboUcIEiii5VHnvK37dh7oEARh7dwGxKueoGslMRpZyzG3MYsEf23sSd5XeKH2IVngRoPVqw/b3KuuxJ9mMUcHo5NEl7Fwm5Ac3I0HDel+jg2qgb0KwpsZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5uw+3PiqFSfWA8HZg+O+e3Mzt3STWZ84WCCq4Nbnmg=;
 b=NMmlW1HoHXuAQJ2RDcNm1P+Yzk9o32uxc+FxycfCyC98Cjv/8PFGKmlcgv+4TlT1o0MRJ4KhdGIA7m6rd63IlJL0yLl81K23nyFEz45pmzOo4CaNkEWN3ioaBywiSGfiej1d5OyRtZMj7T61uYJwD4lahcWFdRoS2BGWowf0hVDDX2LfC6ycb1BwHEeX1PEgWpaiEW3n1DRYpZx3JzJ4kMGZaaQK6H2AAL1y+ezueO5D3LrGExPhOMhnKWB5GirksGAq/M14VQHmdwuPXrjy4jkfUazTOhWjjjEpHg1vVk//RmDEJ+9945i4ESN07uKfP01FcXWBw9LJP152vf7ggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by BL3PR11MB6386.namprd11.prod.outlook.com (2603:10b6:208:3b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:32:03 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 13:32:03 +0000
Date: Fri, 10 May 2024 09:31:59 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 4/8] drm/i915/pciids: add INTEL_IVB_IDS()
Message-ID: <Zj4hz4qepmFYEO2B@intel.com>
References: <cover.1715340032.git.jani.nikula@intel.com>
 <ed89a25b2c6bce318fe59e883d18b62d9453196b.1715340032.git.jani.nikula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ed89a25b2c6bce318fe59e883d18b62d9453196b.1715340032.git.jani.nikula@intel.com>
X-ClientProxiedBy: MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::23) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|BL3PR11MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: c39f4151-7c2b-4c76-1fb5-08dc70f593f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fq9MrngLwjq2owqExkYQ7mrktOkwIP0MNW6++gxKi2xhRn3hmxiJxY7wHWGc?=
 =?us-ascii?Q?3Xtk28+ndGeFMJQENcjCJ9JgDyUj6W7Gto6Lm+F1cwD8O2T8Qya+Qu5yZWG4?=
 =?us-ascii?Q?P7TiRccJwe70IrLSvubtIWcWW94SwdOBvMZn1WQmqJJzSBaWsDsPxrJmj5rb?=
 =?us-ascii?Q?U23bUbHl4S6u2ko2Mm83JcEwYzJAN28EiixOWME6GL2j2QH3Q02MBOd6jphm?=
 =?us-ascii?Q?zRhEHSYlNaFn2paVAIWa5PLdE2MSFulPmYBG/RVehhfclFxGget4ICCI8zRa?=
 =?us-ascii?Q?Zy/Uj2LhdHwCKDNdq660aKmKeQXxzji4702m9muWOC9BpX0TUzCG3OQfMIji?=
 =?us-ascii?Q?3VzD8irfRRR6KXlhoaKh329Ho8AE4mPLxTm9ntgty/e3tVelKkG9vGhDL7bT?=
 =?us-ascii?Q?glpt5T5jrc1fWsRN46v333VHIPbTNagioaF1R2oElGu3059+i84LTMYrWlAF?=
 =?us-ascii?Q?2bEhAYfwilgd6I1DYIu077bZD2Ny0SuvhoPnpVC+eBv8bUNYiIXCeCIN/gcw?=
 =?us-ascii?Q?+NsA7MRuImrsL+oykHWKJPXLxlR0sjmg66fkthNiUHjcTauaCT/0wbca/x5e?=
 =?us-ascii?Q?sqvbIrDj4LtwViQ7765bHnz8mRKLJ7hhtaPbx6Nm82j+6hm0XfJVBHnQEKtL?=
 =?us-ascii?Q?dW1J2m9Cez+cr0TZjAUjSj7gU8gvNEKf4aEiERVhwWz+Cks8XgD6FMMY1XL1?=
 =?us-ascii?Q?8p9XLga1Og/inpd6zhdgncwgcIBXNhvMrF7F6MbP8ukWw1EE4TKQGMNDaGZt?=
 =?us-ascii?Q?88XpA41YAxAeiGSGw3wdEggJxXGAEsZuDptXNGggBvDh7Q3QMR4tQ43EZsaQ?=
 =?us-ascii?Q?YmCgGrWX0Gc8xUvmcGnzo0YaEccbAETpMdRgYvXkDUeGtVGwczkwo4McMw9B?=
 =?us-ascii?Q?XCdmGLDZ0TQaZSkPlbU0uZLWvxo13mH6FykRq7Eyxo8LklM9Wf6vDhi6n3R6?=
 =?us-ascii?Q?ABGirNakhDaxKyA9LiWYVw5vJRKXRdGRLuyfFlTCoxhvONtK5jj8Aiec69kW?=
 =?us-ascii?Q?MUOCAHCJwY82FJMd/mf4YeXEp9ldoaGoWlMKlyFAuSuqPtLpPMadTexeNCK2?=
 =?us-ascii?Q?YqzYYCVR9wrirVoNXkDCgp2Du99EVWmSGGCRKtWFKoJDgkxypk/r+bL5XqML?=
 =?us-ascii?Q?N4nQ5ft4HQSAPaMdS5UZC4rRbPD7r18a+yx3O5CGfdTDbZwTI6FS0y68CEel?=
 =?us-ascii?Q?Zh1fm8iBOZz5rip1BTHONgTuSx+jW+LsEWjVR2haCN1ZctN4kuEF//nefNlS?=
 =?us-ascii?Q?gVFnvMteQC7rtspjl0BTQnM9thWUrkkBqoBKh2jB/g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5A4IvpOf4EYn5aKlStC+FnaEzjLBIgdBpg3rJXjDfCx/U/uqiu16bAEWXMR3?=
 =?us-ascii?Q?s4OIjY+Ag7Mp0pbNwaE3PDQLZblgWW0eTKOLo/9nwxzfcSDjRb6eMlocv1km?=
 =?us-ascii?Q?iGfgLX9EgoKRJF2myxmsKWReTuXN2ZULDOf53ZRdsMPD6GPWla5w67h2a60H?=
 =?us-ascii?Q?nN86DnyreB1Z9lz8AzQMYpPtXArMdTxKPsCJgCaiefSwhbCG4z8uJn0bhzNx?=
 =?us-ascii?Q?xavPQjS4Bw7ud7XiSYS/8ttGiZoxZ1TWOaed6dVqb8/J499LiYcU2LB4OcRU?=
 =?us-ascii?Q?q/z89n51JF571BF9ELKxYNbAII1DUFfEoN4Rh4Y0pJoonzVqwmIl9amzssAt?=
 =?us-ascii?Q?lwH6YWJR4RyyVoZfKKG8kjsfKPXaCnOSZJJZ4Z3ChjG88eWYTY8rhEWMYpqP?=
 =?us-ascii?Q?ii2Aud4FuJLAkxJ21R+RNPWhvSz2jFcAgVU7VRDyJi8LSJTo+hGGRHMx1vsZ?=
 =?us-ascii?Q?J5bMYwX0Vz0uchfilCSIWMYM7hLMArU0eBV+jyc37cwN6/sdM8nGjE2q7NGo?=
 =?us-ascii?Q?87WYowhkJkwVvFi4yfyB9dlmiVZep8ZJMUS6oPL89J9/osXCRkCND5MaSjNZ?=
 =?us-ascii?Q?dwjVC0PhG1jk0A0RvhITBSTc84yOBWgutG+2s7/4okDPiD5Aj7Mrvdy1llyD?=
 =?us-ascii?Q?rBTY6ULnTbkCAnQfB9+bdVvQxm0oViGQgTGis4c2mEmq60u2SZ3weXan+tM6?=
 =?us-ascii?Q?araPo20CbTZa850JbpV5H+8wUbykicTJR8kY6xY8ICPEUnBHPdYxXoEKWmNC?=
 =?us-ascii?Q?e9KcSqv9XfrrH/MLbxpQjLkefbrj2bVs18SKOg9WmOVA9qc9a1ZgrGgdH9fG?=
 =?us-ascii?Q?RRXtjXoucI08KRteZHB8n9HTsJCPC4BGcP58YEMoPFQd4EozaOJSevhMsayj?=
 =?us-ascii?Q?dqaZa+sjyOuR8ZrMW+hUf1y1WUQDrZW9So+HpMlm4tB55++RSZ1jBY5a5W/N?=
 =?us-ascii?Q?gVaed33vw7bseeK6Bi0bSnW8W8e+xjdH/m3QsN99HBsCyPIe8vgpbTSxYCgl?=
 =?us-ascii?Q?n14hKGwuYlBteVE0MJxNNlldWpdkBn5ZeI5Mp0C7vkkO3FBjCQwRrYDEF0om?=
 =?us-ascii?Q?dTjunkP0w3EvOBz9XqL5zHyTYFSE+BW0NiSZ2vK184+MdMbZzRUxQqiL9Ymu?=
 =?us-ascii?Q?gN7v6S87j8YLnCmiJMJ/u5YFYC2Dk4QHoKz0ij3BcjeDhRPQTfmVpSyRWZTm?=
 =?us-ascii?Q?vM4YL9/MMV/9NAjyapTz4yqSAx6ofwtPp/vOR7FGiWrj2GT4T8lIb8o/bmiG?=
 =?us-ascii?Q?xscb8k9gCyMa8RW9yGrXX0oir+9wWAbKeslKwpKAjNzjsI76Q0CQB8zVAbNW?=
 =?us-ascii?Q?mlRvl76q36JanyRz2PdG+vfWqSutiBLqorU9WZGU3GI07zIubOHX1Zfjk0UJ?=
 =?us-ascii?Q?v9SCovbrdHUKul6s4tLQcLp/euVWeU/DQXVXVSI1wweKdWj2w1Er0Lyoh+q/?=
 =?us-ascii?Q?3Ip8oX3hJCteHF7SyPGesMvAOpR0EZnS+/AkWxuDFwn1OwYbMf87A7usCnwn?=
 =?us-ascii?Q?6mZZLhnzfplPq760wTsCLgBy2qPkQH32sgXrJaLqh4f0Qp5EB2G6gxxKJ+iJ?=
 =?us-ascii?Q?75Xcnmw1tii207HUHuhcquz1rxqZ01Vdj5jZsl1GXz+cdLAZadNYTDas0DEL?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c39f4151-7c2b-4c76-1fb5-08dc70f593f3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:32:03.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/ZX8ShokJLvLTapN7EUrwvbgnYKgvY0WGOXihkrF4cZbSgHh3g+OqTx4zx4994UxM8cddaurM0av0CtG4VIqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6386
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 02:22:17PM +0300, Jani Nikula wrote:
> Add INTEL_IVB_IDS() to identify all IVBs except IVB Q transcode.
> 

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  arch/x86/kernel/early-quirks.c                      | 3 +--
>  drivers/gpu/drm/i915/display/intel_display_device.c | 3 +--
>  include/drm/i915_pciids.h                           | 4 ++++
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index 23ded9260302..6549507003ec 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -535,8 +535,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
>  	INTEL_G45_IDS(&gen3_early_ops),
>  	INTEL_ILK_IDS(&gen3_early_ops),
>  	INTEL_SNB_IDS(&gen6_early_ops),
> -	INTEL_IVB_M_IDS(&gen6_early_ops),
> -	INTEL_IVB_D_IDS(&gen6_early_ops),
> +	INTEL_IVB_IDS(&gen6_early_ops),
>  	INTEL_HSW_IDS(&gen6_early_ops),
>  	INTEL_BDW_IDS(&gen8_early_ops),
>  	INTEL_CHV_IDS(&chv_early_ops),
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> index c40d12ca386a..bb681c8ed8a0 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -819,8 +819,7 @@ static const struct {
>  	INTEL_ILK_D_IDS(&ilk_d_display),
>  	INTEL_ILK_M_IDS(&ilk_m_display),
>  	INTEL_SNB_IDS(&snb_display),
> -	INTEL_IVB_M_IDS(&ivb_display),
> -	INTEL_IVB_D_IDS(&ivb_display),
> +	INTEL_IVB_IDS(&ivb_display),
>  	INTEL_HSW_IDS(&hsw_display),
>  	INTEL_VLV_IDS(&vlv_display),
>  	INTEL_BDW_IDS(&bdw_display),
> diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> index 0d48c493dcce..16778d92346b 100644
> --- a/include/drm/i915_pciids.h
> +++ b/include/drm/i915_pciids.h
> @@ -177,6 +177,10 @@
>  	INTEL_IVB_D_GT1_IDS(info), \
>  	INTEL_IVB_D_GT2_IDS(info)
>  
> +#define INTEL_IVB_IDS(info) \
> +	INTEL_IVB_M_IDS(info), \
> +	INTEL_IVB_D_IDS(info)
> +
>  #define INTEL_IVB_Q_IDS(info) \
>  	INTEL_QUANTA_VGA_DEVICE(info) /* Quanta transcode */
>  
> -- 
> 2.39.2
> 

