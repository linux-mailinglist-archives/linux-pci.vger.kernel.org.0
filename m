Return-Path: <linux-pci+bounces-7169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426DD8BE498
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 15:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC87283251
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63013C3FA;
	Tue,  7 May 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keFzAmzB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA98C15E1E3
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089646; cv=fail; b=QXp+DP0VhyMkN0rW5FzCwGTHRYSPNCIZmYMPldOJJZRmUFEsS9fxVrubY07AmjNiBnr69D26NjmlCgPWlnCWzE5CKPArYzkX5IR7pMFU5E8IlJG7gPtcUVfa+yEsh4dQ2Yig9i/WM/1UohxFJDtKhgZvbtYJh14OYvu4Vs7dGOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089646; c=relaxed/simple;
	bh=AQXnuZofhARgeHyMrZF8m2OfkTxsk+pRF+2Cwc+6z/Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YXP59VObi+KSeThNuNrTJxww6rQ3e1deJ6EKCwdjvr3rsnCrcMkvgoQzALQvhoqyoVl8tE3p4ag7ivkqRUetZhXvAo5ckma995CQA8io6JbGztm2fTxRWxML0WPVlZAuY1lGppAJTJibh4vqaWan3HCJFxcPEOehagV8tDNi/G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keFzAmzB; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715089645; x=1746625645;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AQXnuZofhARgeHyMrZF8m2OfkTxsk+pRF+2Cwc+6z/Q=;
  b=keFzAmzBp62Wc0LSc7l0uuP3iTH8jEXAgijIFITrMa3P4AFHrPZ//TIZ
   PGgLndQoDmWXm2gSVD8PybfUZwVMIloJ4ZYAkbUGeuyPY4ZCbl1KvoTh0
   su+6ko75EmgtJMLfQ1BTwmTLm07Tl5BuvQxEF6k3vwkUC1081wN8zb/RD
   mEFawPajZPruqFKY4sfDzw30TPTzjzRwzOmI9DlmN3uKoyi3IM7c+muN8
   h6Ra6I/elznOqzQT6FfdPt4Y+9J0qFBU5edhJo8Esw2e/iUZPztJtEP0x
   CSICpWHIelEiUZRe8aEHmgwQi1uLlpjaCYM6qbQPviSwdbyVpLh7wRXEG
   A==;
X-CSE-ConnectionGUID: pdxBzfk/Q86WLiXO5Q3S5g==
X-CSE-MsgGUID: zGphPFxfQ8aGMEumtc35rA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11009589"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="11009589"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 06:47:25 -0700
X-CSE-ConnectionGUID: wg5M4TGxT7Oz45VNoHI2bw==
X-CSE-MsgGUID: Juso0axxRpykpSp1mfvALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="29113913"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 06:47:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 06:47:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 06:47:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 06:47:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvVJhe6JQeID1yyHOIIxLMNiqST2HzHcpOl2/jcumPx2mV1G8P5WJvw8zuJWGpi6tXPUtGWHCQgg3Fx3tEBtHFDpiAuj14mN3AYDNzvclGq7tBsds8JSYpkJ7wyAoVNiS1J/wn+kjkAd6eTr62T+ZEUnMGwG6BosJMVJrR8gvxMXDbY5s4xLM5jhjYn+vJirwgYchpP3kklqu6BOrXCJoVU+aMii8dZCqeyHxx6jqe8bIG1EnY2ge4nM5NEnDbi2N/4c7Peczj0E6bcaErM3pI5NqlG+SpmPdBGVFwF9MKpYMPO8xGLjROe26B1P77hErHLQtKZCbpW7Q+31WoBLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvy7Vwb3RzgXv7z8jpSjOmuSzMQxa88gNsKPOXo+m/w=;
 b=W7UHbyoFck16N33alVOekeXJeBspkNUaoHnPAujU8veUXTqbs6H4hNvdhnvibSuZtuOM+CnuRTCJDuhp26gzE8IcLu38rk84BjW/xQi1bWeueEYJhURh4S/mkVy7h+XVj9gp9g+407rgkbSFwE9kz/y6w/d6+i8hJpPkuDRFIXvT2R6JFyhfTR4ZXIVyLymjiBRpIqZvHluRTD0eoxCcJTlyYxSS0qYqcgqbm/MWX+fq/HqNpYRe98poJ3id2QH8BpNbf6yw8OPtyMRAxmN7LqLsABHnR6mbXE+YRHJglOboCwHT832KzOvOPxJcNzsITmjzp+4Q4244UXVIrT3KWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by PH0PR11MB5189.namprd11.prod.outlook.com (2603:10b6:510:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 13:47:20 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 13:47:20 +0000
Date: Tue, 7 May 2024 09:47:16 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <lucas.demarchi@intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/5] drm/i915: don't include CML PCI IDs in CFL
Message-ID: <Zjow5HXrXpg2cuOA@intel.com>
References: <cover.1715086509.git.jani.nikula@intel.com>
 <bebbdad2decb22f3db29e6bc66746b4a05e1387b.1715086509.git.jani.nikula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bebbdad2decb22f3db29e6bc66746b4a05e1387b.1715086509.git.jani.nikula@intel.com>
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|PH0PR11MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a38c486-cb4a-475d-8f5a-08dc6e9c3774
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BLVrYL1MbI1BjenyvBoeaqVfCzIbJXCnMT72k0C/mEdp+Ns1tT8oL3RBQ+cP?=
 =?us-ascii?Q?4n9AIGwOhxaBVZHIvbLgVGdneHZcAy6MPX6qvPPLXk1cG7l2MP0cdwiqagCE?=
 =?us-ascii?Q?C0xspfPHGQMd2zy/Yn1rdcoMzvU//sSdsp2B7JjhCKylmXn5JwuOtrbB+4sm?=
 =?us-ascii?Q?FALAL14FZOfACQYQYumyBaaPEAQE3zZHl8zQoIbHAEbsJBoSa7jRj7LTC/jm?=
 =?us-ascii?Q?Isu6U4O9Ozv2xh/APGruZ7vlRSTd23A9xmAHKEWUqxsO0X70j8XjkBeMoWYB?=
 =?us-ascii?Q?o8VZrIt4libhh2xtatEfUYhXIBbmHHEusACLZVgfT/l+PZRq9n+NI3TvwmSs?=
 =?us-ascii?Q?DxCsqXGnse6mI36DTZOw2HulNnqqcL3sIFNAz+WYILNUdIKj5ZreUtU54C9/?=
 =?us-ascii?Q?bpC+8exUliDC/A1ZlzC/tw3pUEVzHVu7Yu8uqDqc8OlaDaSlwkmjN8yrqlHy?=
 =?us-ascii?Q?YWHfzhKiwbFyqn/Q4+ld97UrszcJUBAl9he3/EwuOVs+6Sxy+IkfpaZ0FHh6?=
 =?us-ascii?Q?tT1oS/mriWbCjUGp8exQJxdD65lLbAi26GAUQ7LAU5e6UJnLL8W5RQxltmJ7?=
 =?us-ascii?Q?ulTZp3v94vjqxYYZCUiVSFe4umaxaWWcOL2MlAeKXrPcwuRijJ8T3n4FVHRc?=
 =?us-ascii?Q?8UMAGUZWA+rr5j1KtDibLoV324Q38v9r8qONUA+s2PDW1vm4NMND3FEnI/5J?=
 =?us-ascii?Q?Cwt0oLpRe2M0qHu5hTrs8ZRZi/epjbMtYK5Iwbza6di/MTq5Zxlvn58rp//c?=
 =?us-ascii?Q?7+ygXi9GWYj6TrZZtPeWEA+ovWnGaKwzJDZDHk7EiPQkNaq4U1+NLbxvMWk2?=
 =?us-ascii?Q?MIeBrucIMEszqMXdnERabCdj1ar5Lzg/5e52x38fKqN2IXRYqPDCIzCGw2HB?=
 =?us-ascii?Q?yOl26xkyHDUNUCx08ZLA9idRVJHjU2oWF73sa+TGddVENtwk0YpIm/xe7PX6?=
 =?us-ascii?Q?sEZfBph7TLYr9FBj+fCdGeBqENiRcbSJbNS6YZuV77qPAX2aoiGNbQPq5/zW?=
 =?us-ascii?Q?HFZltcB9mJwcHPwBWlrzFCSSTVtTFyFKrhypHGR4eHLdUDEDgDbPY/cYlGBn?=
 =?us-ascii?Q?GnTGFGq6VqUc+Hc1bqPCrl7ws3UZ2rfTpn5V2o+e+TtVqOQlVuIhgKqdz5r0?=
 =?us-ascii?Q?Yo4lFw07UoXyZoPAa+pNs4TzT02MZfioaCSicPgJUP2CuWDta2tmkYO+OuM4?=
 =?us-ascii?Q?y89p7sm14eRtnOcd0Z3f8EuBo2Pkq1ATunH5QCa8zVRFxm92Ry9zHl9fn/BI?=
 =?us-ascii?Q?/1ysiLPOFmAiCLf+qOjCUVI+ezcyo9wvAJQWFHG6BA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s4NXPCYlsB5fKOAYgmTN7LGcAYbQBvoyYekq4peeOuoUrvUsfRF8vo4JWj/k?=
 =?us-ascii?Q?znZPLcgtfqd8sgF4E7nhsKmj4LaVfdQ9E4JMm4K9NdYpSmyNatLuQonVb/jg?=
 =?us-ascii?Q?ZYDq+CczZUg76JFXTyPJQnu7N9lAdhkdkiEKMM4Nw7TqSGHjOqzpYvQif6Hg?=
 =?us-ascii?Q?a6Zf//LA+uNEf41NFzBQPuvfIhsMGzN4g5yDzo8Zdkeok6BgtqyBbrfGXRqM?=
 =?us-ascii?Q?4FyzFfWDwADg4LFP2HL328tRi3bHruEP51bSDf57gJXYBW9j7RmEkMyLIgQQ?=
 =?us-ascii?Q?3XEVs6AFqsHJTFXoeBU/09R6bopEXm/raACaAVALi1lCtBbqf2iG3F4rXOpf?=
 =?us-ascii?Q?tkPby2Az0XjMwymI2XOJ4Ahb/3p5Z1MZpPnV+bYn7mpjsRzjNPJ0SC2wIyNR?=
 =?us-ascii?Q?09tTIBq9I271pFMUbpISfNz/aCXw8iK9Pn7l8e2gjrD8S3t0gEo6PXzauVep?=
 =?us-ascii?Q?R8gOTz1jcRefU7Hq6B+GAu/rVnAQLUNj1qTfyZeYpxokit9sZSNEwGHWkXyF?=
 =?us-ascii?Q?CKbl+CReuMrwY4px/znh77oWhu4y7f/zyfspob+0kTIUxC5lcRj9ZqkScMGm?=
 =?us-ascii?Q?8WNfjW5y5k1+bIvxmOcci1hUMEX1hMKUoaEV2KyVUzqRXGKM8k1NjootiOlz?=
 =?us-ascii?Q?YZPLMW33cvcAsvXVjAvwBsIY34FN+OU0PfZNDdVPCCdTnJD7eN8mKIM3gl8F?=
 =?us-ascii?Q?zkeT2LkhWMrM7t4m6pVvBLPnOGTpKF2l8zEnfKwzKqzaDnj8zykUip1Jj+89?=
 =?us-ascii?Q?jzX1Nrd4irotT/GEwFicfAABdKA07bsxUa6I38DH/NBic4f3lM3HLqKzD4xY?=
 =?us-ascii?Q?WbTmcNEMxQLGmsoDUIp459sQZlnf+iO+SAx/pltFO9Zg4cfUs3BmKIRc7b8K?=
 =?us-ascii?Q?gwKqmxQzdWSaTqA3nQk7WCYbnqYHr28vtHW+ZzhwX9DjIzRoAKD5aoXvKv1U?=
 =?us-ascii?Q?ykFdhUlB/PUIlLqwkzJfgrDqEss3lmxh0Uim5pDL7aUoppQSmsD+OXJHJ4e0?=
 =?us-ascii?Q?C4cmkXpejHqLohLBcq0JwuPWsXl9iiLZ+xAXrAlHipDSIUXPui/DjNk7A7bo?=
 =?us-ascii?Q?SMTbEoQKNPlQKmujMIy+TLjpYAY2cxR2IOXPFDFBTjjqulOCrdgcETIxqlf0?=
 =?us-ascii?Q?j9GTzGAolUAzZG3ilp1W7LCnhyb6wkGH7h1sJyAtBdOZC9T7Cg0yXsPjTYR1?=
 =?us-ascii?Q?mW4ut0XL0H2Af2aqRj7pd235Snvhrp6bDGnrndmqk0hjA9UJqA7rhNuizitd?=
 =?us-ascii?Q?Uk5yubLwQF7c55UZ9TwgyLzCYh/fLs6+KJl9f9555iE1jJHWf2pOJ8tZefjz?=
 =?us-ascii?Q?i14LrV35E18HMhy3xuW95AjNerD2GGuAwJlYRaCMQvu5pI13sBn8rRQt8zr9?=
 =?us-ascii?Q?A8zn1o//6JkclH1t+S23knucWi+tX7F6ee2utI/UkLzD2jpu995JzAQ/LBEq?=
 =?us-ascii?Q?pMN2IIqwPXIhe6xQ7BL4qIEZ4pnDfhL1lLh0CU2MI4Y3mcGkHfBvGb1HSo6p?=
 =?us-ascii?Q?m2Q1hfzeEW6SAdZrncoNeRrdNuF63pcrUHmVve18HLtB+DrEdTozMg/5wlmw?=
 =?us-ascii?Q?yW2lTUWPeaMucSSurLzuHl2DrJMZ9DHzegoL5J7tQmAsAohA525l6+JGOaV1?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a38c486-cb4a-475d-8f5a-08dc6e9c3774
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 13:47:20.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWKNRl83NHneDhb0rs1+eK/HAzGB6VNZIOTetnW35B1kleiCdkS6RX2qD8LudYBlFM1y0uWK/0ioHXs/PNjV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5189
X-OriginatorOrg: intel.com

On Tue, May 07, 2024 at 03:56:48PM +0300, Jani Nikula wrote:
> It's confusing for INTEL_CFL_IDS() to include all CML PCI IDs. Even if
> we treat them the same in a lot of places, CML is a platform of its own,
> and the lists of PCI IDs should not conflate them.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  arch/x86/kernel/early-quirks.c                      |  1 +
>  drivers/gpu/drm/i915/display/intel_display_device.c |  1 +
>  include/drm/i915_pciids.h                           | 12 +++++++-----
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index 59f4aefc6bc1..2e2d15be4025 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -547,6 +547,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
>  	INTEL_BXT_IDS(&gen9_early_ops),
>  	INTEL_KBL_IDS(&gen9_early_ops),
>  	INTEL_CFL_IDS(&gen9_early_ops),
> +	INTEL_CML_IDS(&gen9_early_ops),
>  	INTEL_GLK_IDS(&gen9_early_ops),
>  	INTEL_CNL_IDS(&gen9_early_ops),
>  	INTEL_ICL_11_IDS(&gen11_early_ops),
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> index 56a2e17d7d9e..3aa7d1cdd228 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -832,6 +832,7 @@ static const struct {
>  	INTEL_GLK_IDS(&glk_display),
>  	INTEL_KBL_IDS(&skl_display),
>  	INTEL_CFL_IDS(&skl_display),
> +	INTEL_CML_IDS(&skl_display),
>  	INTEL_ICL_11_IDS(&icl_display),
>  	INTEL_EHL_IDS(&jsl_ehl_display),
>  	INTEL_JSL_IDS(&jsl_ehl_display),
> diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> index 85ce33ad6e26..5f52c504ffde 100644
> --- a/include/drm/i915_pciids.h
> +++ b/include/drm/i915_pciids.h
> @@ -472,6 +472,12 @@
>  	INTEL_VGA_DEVICE(0x9BCA, info), \
>  	INTEL_VGA_DEVICE(0x9BCC, info)
>  
> +#define INTEL_CML_IDS(info) \
> +	INTEL_CML_GT1_IDS(info), \
> +	INTEL_CML_GT2_IDS(info), \
> +	INTEL_CML_U_GT1_IDS(info), \
> +	INTEL_CML_U_GT2_IDS(info)
> +
>  #define INTEL_KBL_IDS(info) \
>  	INTEL_KBL_GT1_IDS(info), \
>  	INTEL_KBL_GT2_IDS(info), \
> @@ -535,11 +541,7 @@
>  	INTEL_WHL_U_GT1_IDS(info), \
>  	INTEL_WHL_U_GT2_IDS(info), \
>  	INTEL_WHL_U_GT3_IDS(info), \
> -	INTEL_AML_CFL_GT2_IDS(info), \
> -	INTEL_CML_GT1_IDS(info), \
> -	INTEL_CML_GT2_IDS(info), \
> -	INTEL_CML_U_GT1_IDS(info), \
> -	INTEL_CML_U_GT2_IDS(info)
> +	INTEL_AML_CFL_GT2_IDS(info)

Why only CML and not AML and WHL as well?

>  
>  /* CNL */
>  #define INTEL_CNL_PORT_F_IDS(info) \
> -- 
> 2.39.2
> 

