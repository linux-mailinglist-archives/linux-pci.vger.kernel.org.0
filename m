Return-Path: <linux-pci+bounces-10182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4616F92F01D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 22:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007D7283158
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 20:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A639F12E1CA;
	Thu, 11 Jul 2024 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbWbsx75"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2214F121
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728367; cv=fail; b=HhCpU+FjpW2XYT2EsKfazrlWTY0B+3mKtMUGnejoe02W9x6cGZHFxTs5ydCkU+uP/87CUzlwngOl5XESpVn/LtJM4Y0tQTh5tq2pAxlv6rWY84gQH94vK949opBRzbOn94QtqjETxuoGvcIkVi2X5IY/TybgFwETh5h0j1vB8hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728367; c=relaxed/simple;
	bh=6hGpviGxbQDEFWVwnUHMIVYTMrejF8eq8zqRmPMfeIg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j31MATGzUNDxCa2BJXEJ9X8T8BuViSdUNQYcuY/n1cnlv0HQ8MN585108S/32pujWclpKndGbDTnpijVsBXJDfFTRGEzb/ANWx6Y0+9uzID8HHdz8Fbqk9vO4mokLPdSrmVDGsdNx0YMw9WLox2p5fFKqlRXSLbX7oBhIhJe/Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbWbsx75; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720728366; x=1752264366;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6hGpviGxbQDEFWVwnUHMIVYTMrejF8eq8zqRmPMfeIg=;
  b=nbWbsx75ifI5tJOm71taTDj4zm3mg2R09ntC9jGj4EWGX83epGiM5XqE
   EVZccpspSBh5hVPR9T+djF7Ru8QZMc+nF1aqYWCdzqiKvxz/z43++eC4j
   8ZAa5bGI67H4er+bbC8eCBDzBx0y2VxKl5zef28XBUgiJWvkHgcroC3pv
   P97D9WLI++48dZCoyKzmlPmeBXzvng1j/O52rjdCgUI+fuX9oMP//XcVg
   of8F2LgyO+rDMQwLGmL10qYikoH1CLUkAhbGcLvPCXeyuAdnWnnV/ULUy
   J7jMkdPo7sM0TD8+NDKMjAkScDnZ5ExHcP6YnO2Z9QGq1IGCTduCui/fw
   w==;
X-CSE-ConnectionGUID: YIcNHtkbTPWxJV6mx9QtDw==
X-CSE-MsgGUID: MtELpZ0HSayeoCeQrSVkNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17962260"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="17962260"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 13:06:06 -0700
X-CSE-ConnectionGUID: j93tD3LPQxmQih7cqdLIQQ==
X-CSE-MsgGUID: xa426K5zSiuN4i6SUkdl9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="86189491"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 13:06:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 13:06:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 13:06:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 13:06:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEPKRZP8uWPnyOR4mBm5eKkyO46EbWHbGpTRiJp3OyAUlVFxMky2fB2YyIrdopR++y4XXRqbBKcMCGzOGN2YNQreRTonXoaWKuAXZqZLhbUGnf9gCxyHnAATvVAcibUNBn/DqvzFMSmstdJT4mufcVNEdMMEpuTHoHJ9FT73fJu/32DSp4vXyA3hF+7wQ3iL0wS5zjVs+/Zn/ujxtTe9MxKpISIWCqdiiJAQZ8pUNhZZjZ7RR82nTto63cUHoWtxr++En9TvSaBxf94xM2tSjQFuCwgJy5Jjcf9SDr5QBf0foqbSDRkGzN4eLDrquD+3jrwtI9WX293esMwMBpcdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jibjW05Ei46Ha2LtpGrXSJRn4JYgQ3RnBmgFXsL61qo=;
 b=EfS0gKtjXQHY/yR8unWpTmVAXT5bEw5RjcnV7go6M6d9z2h4SofVQzjHMbUdsddVa5uUTlUX4e9T9amh5c7tAkyfnummOpTVD8cWlP3WfB/snBakBmLNAOvGnap70ex1lYWF/RbJWwS3etXf2NXa4xKL+7tjdhOnArJMt/Z/txtC432MDqB1KH4gu97jfMu9Znm9/92hoIKP8jGZYu7kKSbSr903uW8Eb7bbCPDqNglXlfIV11AIYpy16AYRzCY/G+4dU5G3OMGYT6N6ExIdp2hXsx0Lai7JNA83USxJv7/L152oEoIDffAejjuCDqlbIqFaQsNErpSSaottYSz3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB8266.namprd11.prod.outlook.com (2603:10b6:303:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Thu, 11 Jul
 2024 20:06:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 20:06:02 +0000
Date: Thu, 11 Jul 2024 13:05:59 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>
CC: <bhelgaas@google.com>, <kwilczynski@kernel.org>, Keith Busch
	<kbusch@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv2] PCI: fix recursive device locking
Message-ID: <66903b27b9840_102cc294ec@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240711193650.701834-1-kbusch@meta.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240711193650.701834-1-kbusch@meta.com>
X-ClientProxiedBy: MW4PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:303:6b::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac440f6-a014-423e-4725-08dca1e4e38c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XVAIV/pq1MIEUIQ3ViMlA0jSQJSC9pX7ZicUhDINSwkgFXvwYxphGaFHGOLN?=
 =?us-ascii?Q?QnxDLPIfrlcBh/KVFQDspW1O3PAKaWgkYjvHpgcP11OQ3cUBrx/rs8BpbfPJ?=
 =?us-ascii?Q?E+Se+mxPoxctvFJ83O/5Tqa0Su9fkNlBpcs5ft0uMk9aclMAIUP0tVHOgNuR?=
 =?us-ascii?Q?4lwhm0AguHJqEkywEkDN9ikRAEtNzkJEbBcoSLqrEWzNnURYbFQRuzEm3Hbo?=
 =?us-ascii?Q?uAwKwqhejfiOfkq80Yd5DJdBhztrgRAk8pHfDyqvqEm2Ws38gW8ZBV0395jq?=
 =?us-ascii?Q?YPyTsXcXgF4Qn1T5KKV2NTK/cUv2BTYHhCzIC36CRqGyA2lxLozUt6Qb+TT7?=
 =?us-ascii?Q?oyltl7pGqqjRXbOULodtDLYXSBQMKhFmDsJLON3gJgRh33618FHkFsumboAc?=
 =?us-ascii?Q?HiuVaDg4P6cNU11YzbTIDp5U4KuGLIrFAQT84UAsfS4xPZ4R0oREzdUVFUU0?=
 =?us-ascii?Q?EuPfIsanuFvnUMEL7rvXMwiPgQLo/LPChyikrsh0VuxyocnD6eIOB4WDQEcr?=
 =?us-ascii?Q?puoaBcyhyFkBO+q0Uj0D7uPNvz9VIppCrlXq9MFlGoKoNlGBCn7R4lvSlEkk?=
 =?us-ascii?Q?CczcB+lx2ukrfhihAP8yBkmeGv5KsIymErVGJCiW7RUfnS5syTqimAB2r47p?=
 =?us-ascii?Q?0WPZY/y9Z6DBBAUpPHCtb95TsRSQbguhMcCkwTVbkSjkDMnqI8ZP2/cKrCuz?=
 =?us-ascii?Q?xUCpgT653ZVZPZLB76bozP6x0GDlGs5NuL2qdo7ZYOFA+boVlgNR8httV92T?=
 =?us-ascii?Q?iFs8DBFbPoW+oSSZ3I1kUtl4W+LfZBX8oQ6oI2VFHpCO5pNv4RM5JDsGbMpB?=
 =?us-ascii?Q?uo7F1KMTPqLz92O7pI/Nz6qY9izywlOmjM1rujLA/X8OXgx4okthF75nHHDy?=
 =?us-ascii?Q?lr0fPqpeM8VsMlEvZT2XuJwAlS3yV0kOg25zTIH3DSbK+08XKC/ZkzSgEOlR?=
 =?us-ascii?Q?MTGbQVq4y8IYqbb/HarFEFcUB0+Gk0Xc52RUCvAVDRPy0BJYEkf1hwCm4Enk?=
 =?us-ascii?Q?g3natLtyGLPr7wvl2C2pKu7uPkbeh19CoASWyOvmCmsouqVNSqIs43YAmc/C?=
 =?us-ascii?Q?ND0scOq7x76aphgepccXrVX6/nqd3/bGqbJXzJzP66ZfLIx4bdiCxM5MgPar?=
 =?us-ascii?Q?NWXiWp5QPMUJsBC30i3xdNEwDfhgwPr3R69OrSB3yq61bxLCAmis85CElvN8?=
 =?us-ascii?Q?xEJdzBDRp5xrNIjrsyV3kN8opuoNYSvGBu4hqHJpNhfIVGfCkXsl+xyrcFh0?=
 =?us-ascii?Q?OJHLW4KIUTpc5MNWv2J+3IVkGxQDjTpe8A3toIOAigCFW74DorQ+Aei28i/b?=
 =?us-ascii?Q?6zzzPeEbK8YbghPnABnhg/MI4mh3izhVDJ1/MWBPItkgtw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BweZGeeRURmX5+UTwnYovAho+zzvdQ0XdrXNvPnPWoL3dMO2KInODkw3b2iM?=
 =?us-ascii?Q?L0EYdIGKihKgUCFqUobQek0IjPdzTynlxsVA3vK6GckgRzi4P2PeZls7rhAc?=
 =?us-ascii?Q?BBAcZ0o2qWlUP+aoRcaH7549yWzqqToIx7SP9+8toItVH6yYP7wwO7WiG+H7?=
 =?us-ascii?Q?yIGMR0rfukPZkdQVElJRpnXavo4IxAQ0U+do1X5vpH+/NGJeR6MeEHJBZ/Us?=
 =?us-ascii?Q?qxvwy/mugR7Py0z0iOnpaCyb+F4tLtY4RlM3A832qx9+FfVFU3LD+F17lE9X?=
 =?us-ascii?Q?y6QtKdtMy4jpUyO6BTFTUaf8U7krdvtGv3o+0y6DDja8KmC64yccPzLhMCr8?=
 =?us-ascii?Q?eFqsdPiOR9Ek6QAmkktL8Q4MO+7UjUFUcaaOzsCk+L71bk07UJobsUCCNJCe?=
 =?us-ascii?Q?Dwt+RBkb9GKYnUySTaab5z3xv/LjJxYZ8xIjxfF0GojROB/G1R/ZwjB/XCgF?=
 =?us-ascii?Q?vz2M6NUQtOkaRBPmuYJiT8Vz3M8pc0Eom1zly8htbaMBJlVh2+TK7x0nrB1E?=
 =?us-ascii?Q?fUIZuUhfmx/9Id1Dv7QL6E4M4l8PYrHYdZB07AVs++iF4r3f/q7AOXXCgQz6?=
 =?us-ascii?Q?Chlc1bM4g9gi6Tc9++g6hj/J64Mr2zAw2CcAWdLInJGeVsHA6O/6blCqt5V3?=
 =?us-ascii?Q?hOtaoI+9lsqK/KfSyvZHOxkrmoEi5LEPD1U8NBkDkBPWP1J4DDeRKB0JbYn+?=
 =?us-ascii?Q?bF0rgV+D95ZfVmiH97jJPVnF3UZ89ozVltaN9o3yJJkajmPM//OptPvkL04M?=
 =?us-ascii?Q?AMQnntEhfWbuljMS+mO6uUaItHJhDowrw4f7uY6P/Sv05l3SFY5hbeWgLUWb?=
 =?us-ascii?Q?NkiOaGBtPOeGtO3PwgZOIAp92SjWIccxttqPbRhFrd2Y0T9lXaL0RHMMnVpj?=
 =?us-ascii?Q?yM4FjqnDATmI2LwI1lqOZf7ZhFGuUJyKO4qgbxhtpwnyoDtY3lxCDydFgG4a?=
 =?us-ascii?Q?Jjn/mfg1xCS84KaKAakgChnr/IznRRsioqZuGcX1LNXWKuq/bqvq7+gGxg20?=
 =?us-ascii?Q?dd+APuzbaxUck6G7nvQ3CmVPmOZ69bx2uMC4tD5IO9N3cyygcKDVW/V25w76?=
 =?us-ascii?Q?0KlPf8j623FArmWCJAabUXKjBY7VDbF4r9lN8YQ7ITFBlRiBEVNc3V8hGDOE?=
 =?us-ascii?Q?/RX1tJh9Ji+QIQEDskIq5myIBBqUwfUG4JCCiKEOYReerfZcOr/BYXd9m/tW?=
 =?us-ascii?Q?thp/2elgjdIOeBCAb624GxbXM1fmwKbRRZzAyOTyyO+C5YBe0zioxMt9wIdu?=
 =?us-ascii?Q?Kdhd2HLxfpcUsuEtG+MeDI4k1KarE0X4ULSQcmPACOfe619BDSRU6yB6C82T?=
 =?us-ascii?Q?tamZDeratnYVoFOX8mZTfdOB/XyVefc+QhD8QbZX2bFondp2d8I9wk2gWxNX?=
 =?us-ascii?Q?Jqy9NPAERM1CBdtgKQCuZeDv0Ic2aZwZGWMFlBFb8W1dwZnuNRuwM2ySm83H?=
 =?us-ascii?Q?ZXJQq13ZNmfJkREPg/FjrEESOZESOKWxRFEFJdSQAr5JWnOlXW3zrD4JCtbh?=
 =?us-ascii?Q?Vok67IayqTe2W2wGXX+9kd1hazF/DANHUKkV5+GCmOqtWn/NALfXKU5FT0O3?=
 =?us-ascii?Q?QPEL34QmkGJEXPd9WyB3TV8/FsFUopI7de1HUzcO+0tid6IjVFlgexWm4Sa2?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac440f6-a014-423e-4725-08dca1e4e38c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 20:06:02.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Az3D9dMcLnBIHHVZ3H3/iQXPG2a6lx0t82eNNLi4gW27bF1a57quGMLS6qC7ARjz7Pb7UfEuisqRwQJbkv/DgUIuQIV0JCk0UJYoJKVvRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8266
X-OriginatorOrg: intel.com

Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If one of the bus' devices has subordinates, the recursive call locks
> itself, so no need to lock the device before the recursion or it will
> surely deadlock.
> 
> Fixes: dbc5b5c0d268f87 ("PCI: Add missing bridge lock to pci_bus_lock()"
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> Changes from v1:
> 
>  Fixed the same recursive locking for pci_bus_trylock(),
>  pci_slot_lock(), and pci_slot_trylock()

Oh, yes, good find, I should have spotted that earlier.

>  drivers/pci/pci.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

