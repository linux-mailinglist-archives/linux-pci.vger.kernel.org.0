Return-Path: <linux-pci+bounces-22800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 338B9A4D06D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 01:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33108188EAF3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 00:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F5026AD9;
	Tue,  4 Mar 2025 00:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiV0KAxk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC8F2F46
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 00:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049885; cv=fail; b=kLzjciuU+ZwFOAPQ6pkg7e4Gj/vPY8kBamFjr96vty1Ldt8D13CAk9SjvRKx1JyhFm/xjIExreO9bJ/2xGGUZs4+DHuiOnXlTpgBT0AjVceVDnb7B9CkA3dsBBy96CBxMbM1jAQ+7QxxtBJOqPJYMVcN26v6YsILZZYyhB5ggfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049885; c=relaxed/simple;
	bh=k+6QPVv3lNhL8hXGy60cMDAXXFArpEVAVdsxXM8E5Uk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A2/hxtxg5R6ulGNmr9sbMUHPHcjUFgrEXGgbUPp39VH3uYokVoXQXMDyevw+ui56kCjM17QtdWMPOMJeVmYg31hhMWEXx8rwbtOwEFGV4a/W9ZSCv9JBgjuwTqajCCTOIvFTqgJXkhHnL7JJyMLqsMRpcxZXoh85lk21TBXzQss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiV0KAxk; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741049883; x=1772585883;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k+6QPVv3lNhL8hXGy60cMDAXXFArpEVAVdsxXM8E5Uk=;
  b=aiV0KAxkiG581w1vL9FsfyuKD7aJD++ClgGMUxk8OeVdQxMC1fXcrmiP
   MlrkRYJKavg/KZ0/8WrJYvQr9y0qAsHAV/K8dRyDMUJewrcd5LMBnNu0W
   bV69tshf1VjDdZIeq+0WgAiExFjR256vEfpBAUAZc0n65H2LM/A+YdlNP
   3pi7HPTaUrZAaFB8fjBV3NNxcOfJ1jFisbz/Qzs3tYbT+z0dn8BynA+KY
   iyfZFFa4OZrwsufBDaZHpxiZEe7x90dpZX4gJxaMNAEiJbtrC/n73GwNv
   wPtvNaXQR9rX6u/mADIb91Q81Rqhdi87hntv2aW+mlk5Qr5C3vfm/XO4w
   w==;
X-CSE-ConnectionGUID: 7tdipL1bRYKIEtDSqBWSjQ==
X-CSE-MsgGUID: f+idZjDtSDSOK8JVbSzHVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41801987"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41801987"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 16:58:03 -0800
X-CSE-ConnectionGUID: Z4/2E1fuQtaovpKJXj/SZg==
X-CSE-MsgGUID: HArdcWcbSiGwiTIF0HSqiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118209775"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 16:58:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 16:58:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 16:58:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 16:58:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqCbdhnWrvPfYubOim+b/Wx/ZpWKuHN8HkodihHsyIhuzw04le5sw6vBfGn5yfbkR1wouGTjsqAmjWoNHpqOgJm717EAdwZTYiFRdOlkeAiNq8lVaia45/09excUl/V7dVoYkCob7mOGddO+NGEKfs4yrOEkss21zU7/o8E/cOC2t73RQLKYKx8Z4o165CdFZDvkDkSkkuEaFQwsMrHWgCTHVbywjAe1vu03c/Ie2LWgdZxaDfrNay1T3PXtAp+AGLFTtbiKGv00vgJbqNa4EtEQOKeXN/qi84Z14UZ+BlNZ49PevOicfMjvytXwpYz3tT/SCFPkHghLGyoigqVeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFDZSLeTJn0hO5pxyURQx5lUyqIFZhKVV/OPgq3kPfs=;
 b=WnZycsOjU1/m/j0O/E8j5TvEpGDErngCO79GAe8a2s7PBsu2KltQfs3cUij0YOFR7Z1do8/CvGjdE5zLIfwIjQQd2nCydyw5BFEGverBFlbzEyqxEc7dxGHJ4tmSmeAyjQEYfrn+7MjWYaBE8RDzoKsUHHBOjZoF+vNWcpKmCXrupfYDdYdbGoDZl0lTawswIXn43j/dGUeuq3ErTC8vjM9jAIZZi2E9Q4BW65HERRWnCZbgXIev7JlDQTSVHwCRGvipNXzP+Bo2jycaj4qv3fk09EOWiqU0gH9GLOIPtkCbGtSi7NccpV42k3dfWVEgvrNPo8DoM/xu7AZ9TDkurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8490.namprd11.prod.outlook.com (2603:10b6:806:3a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 00:57:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 00:57:59 +0000
Date: Mon, 3 Mar 2025 16:57:56 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-coco@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67c6501494901_1a7f2941b@dwillia2-xfh.jf.intel.com.notmuch>
References: <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
 <d71dd5c5-4c20-4e8e-abaa-fe2cdea4f3b2@amd.com>
 <Z4A/g5Yyu4Whncuu@yilunxu-OptiPlex-7050>
 <a11c82c3-b5fb-48d9-8c95-047ac4503dc6@amd.com>
 <67bd098f4dcd1_1a7729449@dwillia2-xfh.jf.intel.com.notmuch>
 <cf2f615d-2a28-45ec-8bb9-563c2a5bde73@amd.com>
 <67c11ed38ff8_1a7729458@dwillia2-xfh.jf.intel.com.notmuch>
 <8c091787-9275-40db-9167-af270dc5bb8e@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8c091787-9275-40db-9167-af270dc5bb8e@amd.com>
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 9199e195-0d16-47b3-ef83-08dd5ab79b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sdtL8gjlZPyfuNwWhNzXDZmKKpQoQ6pTLeqNYdQzokvUEFZCi63xwEQPlsR6?=
 =?us-ascii?Q?TzztViRN24hZoevud1BxO5m8lRslf5y+Z9tY77QVgLpgNooHup/hg52CHu/g?=
 =?us-ascii?Q?GalzHf0vgQWworDAlfqazd2a9mHOzaRhJ+De9XuzIJ4nens66HiTUh8nSlOK?=
 =?us-ascii?Q?L3eEUHgmyot6FpTH+hnidlRqfAn/cl6de7dg31N4NGy/cyxNbYnCz/Mcak5i?=
 =?us-ascii?Q?WF4WlZgx5mSzuP1eZocqF7pueaKRCABcuBMoBDIdvj8o22FdIw8VqRmFtzXG?=
 =?us-ascii?Q?PVjMsp0kzKuq6ERJtT6Y7uWvXAclHnmMfkcxmebMN1rvaCpwHOnSUQK9v5wS?=
 =?us-ascii?Q?tNQ5KHHhF/2N5ZzeU3bMUKfdxbCLcIdN0iIO/598geAwUgvOBAIu92do198a?=
 =?us-ascii?Q?nXoS3MAvX5MXh3YT2CwW+PlFfn2gk1/rshzaAM/raYIv0GCoRUtpVEISnr8G?=
 =?us-ascii?Q?M2MX66QtrghcIy3oA7+AK18CDCFJlFZAzbpBIMbhY9EtcJQ874O6e+URS7zd?=
 =?us-ascii?Q?+ZH7VtY1V4GceQ3uiGbaWC2LnUwBg6vMuWnut2JNemoib7vmjO/CuKn9iXTy?=
 =?us-ascii?Q?OkiuIQuJUNubAl1f/BcfBqTjJogB7r6qqPc740+L40zp0Sphpv4ML7SxR04v?=
 =?us-ascii?Q?m39zZGL6AuuL5BR0uk63+gzEXWnJNv6B8Evy/C5qr+ExskHX0goV/J25mffk?=
 =?us-ascii?Q?PDr8hf2CFKhoI3hcD3YWLCGDihH1SUVvd+sS91aGEaJVd2D5eO9iqUPXSM7m?=
 =?us-ascii?Q?7G5KfL1Rufx9wu9+N9ilVDVnji5tmALOf54xXQ+Daa7mqc3vmquu+Y0g1gO+?=
 =?us-ascii?Q?55o5anKlIc4LPXge5T4rPuwa3gJDQO0X+t22BC2FF1wsSstPxs7ufZy9GyVU?=
 =?us-ascii?Q?e90AzAGBKBWFuwupHO5PA9WB03fWvCM9CYs0GtCDUaW0AWSDlGUdukDf7REq?=
 =?us-ascii?Q?PxhQSoq1uFQXCfYlQ9CO3U+LKA8A1wFbJyrRgbmitnEw8YJCzCyZZG+E5zIX?=
 =?us-ascii?Q?+mGVeIbK9P5teGlMX/jJdSUUy3hCRsUYKSsTekOKWt8KLwwEGxFHcD+Wnw5E?=
 =?us-ascii?Q?XaUeo3ga2Zr/ANknOY0y+I63Iqa92NQ/u+jJlOsI178eRxF8eda+qnm/q/CE?=
 =?us-ascii?Q?73bwms09cta7KjPRc915snpHRWqhVvpdHVFV/qN1eAwT7UWtbjsKShg8VlJY?=
 =?us-ascii?Q?SbFOnYlROJMJJDhF0UcvcV+xaiuVqYA+GD62vg09g44jIUpiL3MUh6W/PTRd?=
 =?us-ascii?Q?g76/cPCCYPpfpkU70LgS+uVmz/hs9eezxmdYnBBDSBZWXqcAdKe/LNF1HwAi?=
 =?us-ascii?Q?ZZRmcqRS2N6sO7K7VzB/oE+FlxyRyEYRDLoOebgcP4+qTvt+js5Kzfc9Tw0Y?=
 =?us-ascii?Q?MbvS216F3JXEMXxsptD578OSmntA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LbQZhZ8s6pfHFKjf+Pl+yrMkkL1tsa4FVHRapz56TXBQvQan/Q+rYPer8V51?=
 =?us-ascii?Q?a5ghCwFubP7gob0QVw2htBeVFxUuGUr8kk9JnNTVRMUciZLCVSI7qWNvmXCT?=
 =?us-ascii?Q?MsV0S6XK/ysUeIHc4nOjtExNHcmU/GycgVn1zhl5Q8GTW2rPawciEJ/0s+VX?=
 =?us-ascii?Q?oDwB7C8HeJRJhmPf7UqCBO+fggnr1WJdfVA8ES+84w2eWnSyzNl3Ny3kX5Xe?=
 =?us-ascii?Q?k7yvIFw/G2T2zhHQkiXQ72mcV3FXt68uFJyZbAH4Z+NMoY2uk6CLw4a9I1L1?=
 =?us-ascii?Q?qC4HJIoBTryC3psACwr+cMr45IZk8jwtOSQLKaAvYD9/x2foNz+sUOs0aE9c?=
 =?us-ascii?Q?Bs2vlQog6959ZZgturRk13wZzG1MKuHkAacNj3lUqhYfaFSRfYQqmllUWN3b?=
 =?us-ascii?Q?84PBOcIdDaDReRvtInkBBjCUqkpCyrBR3HZwVByXo1PSwK9JKZE4hkyboqLG?=
 =?us-ascii?Q?SZLfXEVJGSAInKuTrHr+lelsBOxmAANq/eGOoEMN7t0ewRmKW99LXkqNkQ3c?=
 =?us-ascii?Q?gdwXt90vKkrga3vua3fMCa7u9z/LCXOpeY/uq5UsE5NJIz8esc1kFI0hMP99?=
 =?us-ascii?Q?+pSNPnJBOjf5WUBle+Y1gzxe8n8biAJAyKhl85N78u6EjNJ1/OoQjYqDF9D6?=
 =?us-ascii?Q?0tAW8BNpBVmJniGkvrV0fs2I5Cm4MM7byG82QGiBVjr4TGcAC1sTagvl1E/v?=
 =?us-ascii?Q?fHQnkkX+OUK09R66ACOmIc/nsVVnNOuB2dJvd7Z8Md5etjZoakc3U0TZmeX2?=
 =?us-ascii?Q?J5DCVfSjmCcRmj4bgxA0lk8assZr1cZc1yP23/z3OGs4URKZMlB+XPpQTRur?=
 =?us-ascii?Q?88ppRadYj2fddm6TXBwYxwmWzlZf+4rH5m40zTQFoHFFiFUNl+9c+o3Ib+YV?=
 =?us-ascii?Q?Uj17kKrBu+fnJUhn8JYO9+1xKUaBDpTl3qIFDi2ThkxpF0V1bEY1irXS4Z42?=
 =?us-ascii?Q?6WKlj3fKjwRYUlUCS/y0NjMZFfCfkT2s9lYu/9CVn+ECA0vLmCTy/FUWjWwc?=
 =?us-ascii?Q?N9xZJ+RenkaadkeZc9nCxI0MdzgEIV7DvwasXfT1/wjEdj5aafhvE8qpbsnM?=
 =?us-ascii?Q?nIyveI7zblnJIWRB1kuGeMk3747DXoNoo+2O56L5QwaT1txANfGMPQizK4+f?=
 =?us-ascii?Q?O1bxEQH7AEBQ9l/IBaKhr+Er77YEAF/yU4RpFrAXIUSwwwB6E6uE5VTcOD9g?=
 =?us-ascii?Q?K12DNRf2BYkbPEsooMvVCRZ2FWVTWv7YBTXqahiw+PL+NdWMYFeKP2qBLLUm?=
 =?us-ascii?Q?Bqfbmwf9CjsoomVyKJxXMNId0lM2YO3Shn7AigbowtrGib2AWcEvV03Yysvo?=
 =?us-ascii?Q?WiEoLn59wzGC/mXpuxTUakqipPycerWUL1BnnvFiGa7NhjuW2GeOYTMR21dR?=
 =?us-ascii?Q?jUN5zBnvWUP2Hzm5AEoJOQ2WQ8sV7Cp69b9nPMJrtm9rlD+CxsCnhpkNN0XU?=
 =?us-ascii?Q?zZqdZFEsuYlNnKW/K96lbTy+K9Si4XEhbMMxQu+/7so+3/NE+CoJKX0r/tw7?=
 =?us-ascii?Q?xcTg539smBLpuyXTNfMh4yLiW98h36IXTR6iyhfSUo9+ZuMXWnBhsxa612Fr?=
 =?us-ascii?Q?RUb3TwjPDgegraVVBHewuiQaKoes0nvpPXaAWRsdo5FcBKF19bYtUwukVNOl?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9199e195-0d16-47b3-ef83-08dd5ab79b8c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 00:57:59.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4hxmt1TkAscfZuuWJoqzwDLP+0jFlvJ9/yCXvIX3GaOh1vuCXGXUPJYOSQbxMbugZmLESDoX1cjPkYJyfpkBklrGRkFGWVVqWX8BiYyxBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8490
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > Otherwise, at pci_ide_stream_setup() time I expect that the core would
> > need to do something gross like check the incoming Stream ID and walk
> > all idle streams to make sure they are not aliasing that ID.
> 
> This is what PCIe spec suggests doing now imho.

Ok, I am about to send out v2, let's follow on to that with an
implementation that simply sets all idle stream indexes to Stream ID
255. Then, catch cases where the low-level TSM driver tries to use ID
255. This is on the assumption that most implementations will allocate
starting from zero.

> >>>> And then what are we doing to do when we start adding link streams? I
> >>>> suggest decoupling pci_ide::stream_id from stream_id in sel_ide_offset()
> >>>> (which is more like selective_stream_index) from the start.
> >>>
> >>> Setting aside that I agree with you that Stream index be separated from
> >>> from Stream ID, what would motivate Linux to consider setting up Link
> >>> Stream IDE?
> >>>
> >>> One of the operational criticisms of Link IDE is that it requires adding
> >>> more points of failure into the TCB where a compromised switch can snoop
> >>> traffic. It also adds more Keys and their associated maintainenace
> >>> overhead. So, before we start planning ahead for Link IDE and Selective
> >>> Stream IDE to co-exist in the implementation, I think we need a clear
> >>> use case that demonstrates Link IDE is going to graduate from the
> >>> specification into practical deployments.
> >>
> >> Probably for things like CXL which connect directly to the soc? I do not
> >> really know, I only touch link streams because of that only device which
> >> is like to see the light of the day though.
> > 
> > CXL TSP is a wholly separate operation model and it expects that CXL
> > devices, and more specifically CXL memory, are inside the TCB before the
> > OS boots. So there is no current need for Linux to consider Link IDE for
> > CXL.
> 
> Link IDE or any IDE? I know very little about CXL but some of those 
> device types are not just simple fast memory but also do read/write 
> from/to that memory so they cannot rely on CPU memory encryption and IDE 
> makes sense for those (especially Link IDE as there are no bridges, or 
> are there?). Thanks,

So there are 2 use cases CXL.cache and CXL.mem, and of CXL.mem there is
general memory expansion and accelerator memory. Most of the devices in
the market and the sole focus of the CXL TSP (TEE Security Protocol)
specification is how to get CXL.mem from general memory expansion
devices (Type-3) into the TCB. From the spec:

    "This CXL security content scope focuses on features that are needed for
     confidential computing utilizing CXL Type 3 memory expander devices"

The TSP definition specifies that CXL.mem memory is brought into the TCB
by pre-OS software.

It goes on to say, "Transport security is optional for TSP", i.e. IDE is
optional. If you have initiator based memory encryption then you do not
also need encryption on the transport.

So, IDE is optional and any optional IDE establishment will be by pre-OS
software. There is nothing I can see from CXL-land threatening to make
the Linux IDE implementation care about Link IDE.

