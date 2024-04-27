Return-Path: <linux-pci+bounces-6718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 377F98B43DF
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 04:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D9BB217E0
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 02:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6DC3A1D3;
	Sat, 27 Apr 2024 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7vvSQoa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62B3A1C7
	for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 02:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714186739; cv=fail; b=UBsFkg3PKeD5od91qNVjPJwS7YWTKSh3ONioeWfP0GzrIW+vnSXNsZ1DqjzutVBtKtI6M5xhA4MGDf3J6y9bcw2jg9SeE1jLb3YUqhR8X/mQC1X0tQQPS6ODJahqJVtRnCiMubAjDogQT1cFqSAhZT1MLw8qRFToSyybQF8OOok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714186739; c=relaxed/simple;
	bh=dXOmSch62m2YahkwsFBDWABnkwUHdYsEkLwWl76lnXU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kQip8/JdzRCCHwIy6Lo8slGuBl9wINPRfKqahuuWQveafpj5HSL/6cQGAq2ASEVd86i+iCWKITqml4W9kY2EW5fHWILnwn1YdqB9skA83H/dvuBFTeGbDQs8urwwWfbHX0anxsqTJB9aJktvxQvtYmdLHHrlgvUX9Q9FLs+rMjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7vvSQoa; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714186738; x=1745722738;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dXOmSch62m2YahkwsFBDWABnkwUHdYsEkLwWl76lnXU=;
  b=c7vvSQoaPWCBQZO+R5xMVxGaHx06ZkeL1m/6gWwVdxichoVnt0QfIZj/
   tnhoMlwLSlCQDRyUjBxjG3U6v3WbG1AOVUy3hN1lTg0g58Qv/HXkLCF+J
   BJOX1AWTydtiQPbVjQPzWfbhrLGxUnUgDHnp1OX5pW/2ce7IukDHbBBIE
   aSelC0UUJLBKBpI2mmLryqU321ZO0UnbL+7zvDRGKg0q6enD03WjbdP9i
   ePqfwxXLs5cx82AYQ3q6tUuUTPjxfEspKM5TJH1jIEt9O0jWsyvjXSgnw
   KUDmk31VU9K3glr83IDJrP00l1NwO5BKnOW0reh+JJ6x0jWvaiPLJDiS8
   A==;
X-CSE-ConnectionGUID: OWMga3MuTtGH0auT9EZt5A==
X-CSE-MsgGUID: 6Ssm8mTUSVmg1NDhOGef0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="13764493"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="13764493"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 19:58:58 -0700
X-CSE-ConnectionGUID: WqAz9rO5T9+VYu4nhdLtQg==
X-CSE-MsgGUID: P+9YH2Z5Q7G5y6+RwwBjcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="25479057"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 19:58:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 19:58:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 19:58:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 19:58:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UycALNw2ppcRuW1v59e9TY499mjBEp0hBtCwN065fWRWr0TeoxorNjoC5J626lOhhbmF7PzA30iTtrkWtz4ZM2USquxeic41FS/YDxYaI8wX4QsPlxjBKfSjgrp3S52feU7b+lvSu80sTjWj22jV+WRh8ccAjTzL93IOVRjXBE9qmdHwL+4GwdtWDn3MQ330BqaBpi//oqK5GdPIshpf42MrdcLryZHMyMgHJ07IrM44lh0hZ4oE4XC7qm4fY5hkuzV60sD8PORSH9F9mJbhgiIg7Le4JGj2bRS0Cz4LuNOR/POEsawXBSnTmn4JKgsN24/Tr2+e9iLgNy+MxRitEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UezOnjAQsJI/0RlAgk0E+bRuxReWiTB2ZhFFOgSCvCY=;
 b=FT1dK03711Zzk0VjJBspx/XVcxH8dIkZN8f/M1JpbvIbLKB5Jn6xNqIzLOEvrz8VoluLuZrqEJ3BA3/Bwa7ML8Hrl3+iAoOfD+ZOdxJJ9rOhowOxzIsPDmZOPp1F1X8/NPTjGxBzNoeGfwkPzjlvgFSB0Y3az6Vx20X33jmsBRvwJa4KJ04z0p0Ng6yUZ8dTb2vizokEX5MdHFYQc1PhsfZdBKtFrmR55Gs3fZaCWi1tcKTlSG9PN7HMt1MhkXt3e2TH85uX2Jbw2kTy7mAjlBaiNwvSUvLvht3V7XXcnKpoQP0e7uoqyAGGnbTS+2jGgzntr7iRVjRshVBukp91Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5938.namprd11.prod.outlook.com (2603:10b6:a03:42d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Sat, 27 Apr
 2024 02:58:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Sat, 27 Apr 2024
 02:58:54 +0000
Date: Fri, 26 Apr 2024 19:58:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>, Lukas Wunner
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<kevin.tian@intel.com>, <gregkh@linuxfoundation.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH v2 5/6] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <662c69eb6dbf1_b6e0294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
 <171291193308.3532867.129739584130889725.stgit@dwillia2-xfh.jf.intel.com>
 <fc201452-080e-4942-b5a0-0c64d023ac6b@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fc201452-080e-4942-b5a0-0c64d023ac6b@amd.com>
X-ClientProxiedBy: MW4PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:303:b8::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 56823fa3-3734-4915-8e16-08dc6665f97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bJGAh5ZOYR0hlynfV953ZxW2gBruwEzc3PzN9w74sXi+FvyLu4+gQBvlzRZN?=
 =?us-ascii?Q?KRRFPatLVNt1+rzd6HaNWQEPdgyM2UqigBPfmj6aALa7A+kWQOTW+f/A9XzE?=
 =?us-ascii?Q?YaFaOyGgU08wnmRJOktCnSSxBDJeeiteVuSRnYpy38/ZwaC/7tBZ/Uljdt4Z?=
 =?us-ascii?Q?tDu5oszGnndoYJNMTwi+mOL538uHy0xb3Go5Yxs0Rr9x4PunqW+HYqpvZOSc?=
 =?us-ascii?Q?PGJTHjOS+8acxhG+PcO3zKlC4GugUtXzgNCjvI8ix5/hq4+1awj1Pv1LoHWE?=
 =?us-ascii?Q?78wJ3P/Xh9wUQYamgWX0WLwbFiMXYXs12DdOXscW0LSrKJuNLtf6Y9IjtOZa?=
 =?us-ascii?Q?yp6eqWHiv9Xz7qsGM1/mhwE7YgT+1nVWPXP5YkGAUmfJbezQY5t6+s+hu126?=
 =?us-ascii?Q?F/timWcuTuR2Q6/R5ljdoTplYrCK2J0PFWWx0IgcItlWIBxlByFBQTS9sO9A?=
 =?us-ascii?Q?0urrKEKdM5wzb7RBsl5YA/pXjywMymL07aWIYhxFe7kgLub62cknfIsLli1I?=
 =?us-ascii?Q?M0OlrI5F2j1fMdC+ZnjfvFw5WVqCfwnjsC3r43GnnBEP0Yf5OvdbwvV0uUKM?=
 =?us-ascii?Q?PKp9eePTa9kc6Q8eWKCgUN6WqBs39GmjlPqx4CEuRvggCtdQMMXsYPzaJS83?=
 =?us-ascii?Q?iA2f2fXU2MN72nZEoVSzucKpVtLwFjt1J4Ph6NW6EYn3K+PUFxOWbM4xuCeJ?=
 =?us-ascii?Q?Le4QwTDXd9noZ9OHWsyy05c/agaBPaNu7BJ6ytM8mfdNQrSe73GxRlUGPxXi?=
 =?us-ascii?Q?rroRp5d/OBiwN1trsRAtDJlVNY0v1PhrlxaFxyb2U4iEAXw3uA5iZHhrfUWZ?=
 =?us-ascii?Q?P4JofRkmwEmC1jX4eHVXByale6pGEv8t7c1P2gE+f8dTgtYRsr9lFauWNzqV?=
 =?us-ascii?Q?Is/c4B6vrHz4rgGuaB/v3U1fcu3D4yAzzpc1bQNGcqg1xQuRJ+NZjxOucmlX?=
 =?us-ascii?Q?AV2BWonihKtTfs4HtvpRTsqc8sHrbCalcgnWO+VB0xVQx1KWjRVkqAULOiZO?=
 =?us-ascii?Q?le4Otf+0Xdid4aYHuZNDmvZJ7H6JT7cjeryHmyn5tJT/91u/q0NOxbi8Emmx?=
 =?us-ascii?Q?YFQ/wFBQ/nGxqBAXcNafHR3ml8xOg5tZQ7td6HSOoODEIE1V2eYIRIyfl0KR?=
 =?us-ascii?Q?e1bUccBQUhZZomlxvjn85e0RlBc7M+mcXc293lN7zuiUI4LTRSPGFc/Ov1de?=
 =?us-ascii?Q?SQ8YRqlAyM95vGjrtciBCaaYWWhUykjyHRPfX2oK3SuLHJL+gd8+gvYRai/E?=
 =?us-ascii?Q?3hXYCXNCq7yF97EIIUqasPyCShuZKf1n42+RZxDHbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wo0hzEMJn2ux36gPxsQdgbQzmJQ+o8lNSpclKIrV4DS1w98G3w4dKeVemF1J?=
 =?us-ascii?Q?iX9zpk8bljLQW3uWfVeNjAz6ucxxKKmyd8EXj0ShL5Twc8whYD/yKjBDxQPw?=
 =?us-ascii?Q?yX4a3RjRD5sAHThf3med6XOFoMDyiQTAsT50z45PgiW7GNml9I9uDa6h9ZMo?=
 =?us-ascii?Q?IB6/wEMP2qN90BQfw3t5XmCyLzeRgv3GolRL+wIvIpMxsKdNzNfCEJKMomcy?=
 =?us-ascii?Q?B9Ng+b6MAItOc9yjL1ysMFHqyb6EecQt/akgJjUmTds/lceY4d46h5Vr7Dqb?=
 =?us-ascii?Q?J6d/zBwsvtzONdE897Tn9Exoggb1QDPtI6hlB+mxZkgf4hjaDYq0ykXYxXPW?=
 =?us-ascii?Q?pMA14jUVmj2mgygeXIy1NoYg4nrpxJPNHJc3O77b6pCoclfW6yQrQ89RZnJv?=
 =?us-ascii?Q?Jx17MCqAMiIWgRu9f7scR19InONp/y7He5fMuMRIY+Cpsjvt8r1SGJDILXgm?=
 =?us-ascii?Q?1+kf0rXWLb5eyMXL+a+neCZvahN8HwSKQNMalbZNWfK8/Iae8yxymtvmwG4c?=
 =?us-ascii?Q?bd6LqJeC/VjHAO1qAZOqy2rIZjMfte4Q6wWywlhE5hkVxjXM90nrJaaFRip8?=
 =?us-ascii?Q?Nctgf0i3TAbeprINQ5HawJFilVb/a9B1Eo1bOL77JNz4levJ5GoCPTOSXm/f?=
 =?us-ascii?Q?N5hacXtQXNHOb4dwLOITpkUBYOk4x6wY5BeNHytecBnJQ/kdZvC3SNY4U8/G?=
 =?us-ascii?Q?+x9FDtAgMiGAfXbmvEK6Mh+hqKcvhHUhPljyRIxRniTFrvsOSw8EEqeITsin?=
 =?us-ascii?Q?fos2zwR8dDfwDiJWz/GZOxezX8/MsGhJke/PqgkbR6wrX1dnq8pIh5MJEg9J?=
 =?us-ascii?Q?kvTA0so9byNmmScUT1cC7e5v11ZPULBxspC8HghwV/DSN2e9o6NeSgGhgxQZ?=
 =?us-ascii?Q?wT+Fzpvh/BCEYU8rPGPFZ3sY8RPw9sb1WV9/vrBJFgVF3YvGJtU9SPU8EtTp?=
 =?us-ascii?Q?3dV8/Txs8jZ9EGy9VeXnL5dyO8/pmfFCDQsapDNLI3XoUHIeBC4mpp4tRUbU?=
 =?us-ascii?Q?ygL/X6LYK1JUH7TXDQuN6EfvwrruyZHXPGa3jAsorPHExMPZR53NspJIXPmr?=
 =?us-ascii?Q?1SaTLwVaP0G9QLwiZkkIqJoJwv2Lz1uZ/D2CUI6f4ibdrG2r5+or94IPKuN4?=
 =?us-ascii?Q?tyjlIVNPxUF2vX0cedwBN7EergPBBFtJcZ42U0JcaRrCbQWCPdZr58gfQIUN?=
 =?us-ascii?Q?/D2RHyTBQgql3CtYB8ZZH1cL0MQOXSnt2UiZo8OWSa381JwKmHtFxSgRgZ5w?=
 =?us-ascii?Q?3zW7j78nNb0fleylNu81kNteqlhfcqPvDbEJ8bavhVpLy8MXCRc4FuZsXHjP?=
 =?us-ascii?Q?2I/gJxNbYk/fXeSKft/ewQwETYZLN4EJWip+XE7w6h4F5tghoJoTpvKkM3bc?=
 =?us-ascii?Q?onwj35Dm6xV9OfUYu7wg2YuAde3KsolNnuJeupH7WhCo8SsCM3HirvmEobYB?=
 =?us-ascii?Q?yUZvvoUcTeifxWrnqp6etw3CE6S8vI3cbeIT+yor2+0xWTxlRzxO6d/3GiSY?=
 =?us-ascii?Q?rBqmlsU/R2njLVlIeK5+vf4bQI2kyLULo118GB5DD/QOjNSx8OX+elb4yr8K?=
 =?us-ascii?Q?istjRKPb6EEPuOW7RNXlPAwk3wen0SFJ0d/XKuuWfJjIpVASKJuV+dVrAhVr?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56823fa3-3734-4915-8e16-08dc6665f97a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 02:58:54.4988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6v+gAzU3KJ2FhXJOBDW7C5OMqHIc8vm+m0bT9Y9DFmnGnzZJiaz0NwhY3wchV88AedUpU2xXRKqlRf6gkovf0nCWRMiWKFd2MGtfLjz8RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5938
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> On 12/4/24 18:52, Dan Williams wrote:
> > The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> > Environment (TEE) Device Interface Security Protocol (TDISP).  This
> > interface definition builds upon Component Measurement and
> > Authentication (CMA), and link Integrity and Data Encryption (IDE). It
> > adds support for assigning devices (PCI physical or virtual function) to
> > a confidential VM such that the assigned device is enabled to access
> > guest private memory protected by technologies like Intel TDX, AMD
> > SEV-SNP, RISCV COVE, or ARM CCA.
> > 
> > The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> > of an agent that mediates between a "DSM" (Device Security Manager) and
> > system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> > to setup link security and assign devices. A confidential VM uses TSM
> > ABIs to transition an assigned device into the TDISP "RUN" state and
> > validate its configuration. From a Linux perspective the TSM abstracts
> > many of the details of TDISP, IDE, and CMA. Some of those details leak
> > through at times, but for the most part TDISP is an internal
> > implementation detail of the TSM.
> > 
> > Similar to the PCI core extensions to support CONFIG_PCI_CMA,
> > CONFIG_PCI_TSM builds upon that to reuse the "authenticated" sysfs
> > attribute, and add more properties + controls in a tsm/ subdirectory of
> > the PCI device sysfs interface. Unlike CMA that can depend on a local to
> > the PCI core implementation, PCI_TSM needs to be prepared for late
> > loading of the platform TSM driver. Consider that the TSM driver may
> > itself be a PCI driver. Userspace can depend on the common TSM device
> > uevent to know when the PCI core has TSM services enabled. The PCI
> > device tsm/ subdirectory is supplemented by the TSM device pci/
> > directory for platform global TSM properties + controls.
> > 
> > The common verbs that the low-level TSM drivers implement are defined by
> > 'enum pci_tsm_cmd'. For now only connect and disconnect are defined for
> > establishing a trust relationship between the host and the device,
> > securing the interconnect (optionally establishing IDE), and tearing
> > that down.
> > 
> > The locking allows for multiple devices to be executing commands
> > simultaneously, one outstanding command per-device and an rwsem flushes
> > all inflight commands when a TSM low-level driver/device is removed.
> > 
> > In addition to commands submitted through an 'exec' operation the
> > low-level TSM driver is notified of device arrival and departure events
> > via 'add' and 'del' operations. With those it can setup per-device
> > context, or filter devices that the TSM is not prepared to support.
> > 
> > Cc: Wu Hao <hao.wu@intel.com>
> > Cc: Yilun Xu <yilun.xu@intel.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > new file mode 100644
> > index 000000000000..9c5fb2c46662
> > --- /dev/null
> > +++ b/drivers/pci/tsm.c
> > @@ -0,0 +1,270 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * TEE Security Manager for the TEE Device Interface Security Protocol
> > + * (TDISP, PCIe r6.1 sec 11)
> > + *
> > + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> > + */
> > +
> > +#define dev_fmt(fmt) "TSM: " fmt
> > +
> > +#include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/xarray.h>
> > +#include <linux/pci-tsm.h>
> > +#include <linux/bitfield.h>
> > +#include "pci.h"
> > +
> > +/* collect TSM capable devices to rendezvous with the tsm driver */
> > +static DEFINE_XARRAY(pci_tsm_devs);
> 
> imho either this or pci_dev::tsm is enough but not necessarily both.

You mean:

s/pci_tsm_devs/tsm_devs/

?

[..]
> > +void pci_tsm_init(struct pci_dev *pdev)
> > +{
> > +	bool tee_cap;
> > +	u16 ide_cap;
> > +	int rc;
> > +
> > +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> > +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> > +	if (ide_cap || tee_cap)
> 
> I'd swap if with else.

Oh, you mean:

	if (!(ide_cap || tee_cap))
		return;

?

> 
> > +		pci_dbg(pdev,
> > +			"Device security capabailities detected (%s%s ), init TSM\n",
> 
> capabailities

Incapabail of spelling correctly apparently. checkpatch spell check let
me down.

Fixed.

> 
> > +			ide_cap ? " ide" : "", tee_cap ? " tee" : "");
> > +	else
> > +		return;
> 
> 
> If (!ide_cap && tee_cap), we get here but doing the below does not make 
> sense for TEE (which are likely to be VFs).

The "!ide_cap && tee_cap" case may also be the "TSM wants to setup IDE
without TDISP flow".

[..]
> > +struct pci_dev;
> > +/**
> > + * struct pci_tsm_ops - Low-level TSM-exported interface to the PCI core
> > + * @add: accept device for tsm operation
> 
> 
> What does "accept" means here? "Accept" sounds like some action needed 
> from something but this is what exec() for.

At the lowest level an "accepted" device, one that returns successfully
from "->add()" and has its tsm/ attribute group in sysfs enabled.

> So far I have not noticed that allocating platform-specific structures
> prior calling a verb is any useful, i.e. having a separate state -
> PCI_TSM_INIT - is just an extra noise in the "painfully simple first
> TSM implementation".

As far as I know, not all TSM implementations care about the "!ide_cap
&& tee_cap" case. That said, regarding painfully simple, if the only
difference is some TSMs support IDE without TDISP and some do not, that
standalone-IDE support can be added later.

> > + * @del: teardown tsm context for @pdev
> > + * @exec: synchronously execute @cmd
> > + *
> > + * Note that @add, and @del run in down_write(&pci_tsm_rswem) context to
> > + * synchronize with TSM driver bind/unbind events and
> > + * pci_device_add()/pci_destroy_dev(). @exec runs in
> > + * @pdev->tsm->exec_lock context to synchronize @exec results with
> > + * @pdev->tsm->state
> > + */
> > +struct pci_tsm_ops {
> > +	int (*add)(struct pci_dev *pdev);
> > +	void (*del)(struct pci_dev *pdev);
> > +	int (*exec)(struct pci_dev *pdev, enum pci_tsm_cmd cmd);
> 
> 
> A nit: the verbs seem working (especially reducing the amount of 
> cut-n-paste of all this spdm forwarding) until I get to things like 
> "get_status" which returns a structure to dump in the sysfs. Doing it 
> like this means adding a structure in pci_tsm and manage its state 
> (valid/partial/empty/...). Or we might want to generalize some input 
> parameters for the verbs, adding u64 params is meh.

If it is just for sysfs cases then I would just have a facility for low
level TSM drivers to publish some attributes directly at
pci_tsm_register time. Something like the following, and just require
low level TSM implementations to agree on filenames and formats, but
otherwise avoid complicating ->exec().

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 44b998a1c824..d34c3477ddc3 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -113,9 +113,9 @@ static struct attribute *pci_tsm_attrs[] = {
 	NULL,
 };
 
-const struct attribute_group pci_tsm_attr_group = {
+struct attribute_group pci_tsm_attr_group = {
 	.name = "tsm",
-	.attrs = pci_tsm_attrs,
+	.attrs = pci_tsm_default_attrs,
 	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
 };
 
@@ -169,7 +169,7 @@ static void pci_tsm_del(struct pci_dev *pdev)
 	tsm_ops->del(pdev);
 }
 
-int pci_tsm_register(const struct pci_tsm_ops *ops)
+int pci_tsm_register(const struct pci_tsm_ops *ops, struct attribute **attrs)
 {
 	struct pci_dev *pdev;
 	unsigned long index;
@@ -180,6 +180,7 @@ int pci_tsm_register(const struct pci_tsm_ops *ops)
 	if (tsm_ops)
 		return -EBUSY;
 	tsm_ops = ops;
+	pci_tsm_attr_group.attrs = attrs;
 	xa_for_each(&pci_tsm_devs, index, pdev)
 		pci_tsm_add(pdev);
 	return 0;
@@ -198,6 +199,7 @@ void pci_tsm_unregister(const struct pci_tsm_ops *ops)
 		return;
 	xa_for_each(&pci_tsm_devs, index, pdev)
 		pci_tsm_del(pdev);
+	pci_tsm_attr_group.attrs = pci_tsm_default_attrs;
 	tsm_ops = NULL;
 }
 EXPORT_SYMBOL_GPL(pci_tsm_unregister);

> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 16493426a04f..dd4dc8719c5c 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -515,6 +515,9 @@ struct pci_dev {
> >   #endif
> >   #ifdef CONFIG_PCI_DOE
> >   	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
> > +#endif
> > +#ifdef CONFIG_PCI_TSM
> > +	struct pci_tsm *tsm;		/* TSM operation state */
> 
> 
> I am wondering if pdev->dev.platform_data can be used for this.

No, platform_data is for ACPI or OF to populate.

For example, see sst_acpi_probe().

> 
> 
> >   #endif
> >   	u16		acs_cap;	/* ACS Capability offset */
> >   	phys_addr_t	rom;		/* Physical address if not from BAR */
> > @@ -550,6 +553,12 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
> >   	return (pdev->error_state != pci_channel_io_normal);
> >   }
> >   
> > +/* id resources that may be shared across host-bridges */
> > +struct pci_hb_id_pool {
> > +	int nr_stream_ids;
> > +	int nr_cxl_cache_ids;
> > +};
> > +
> >   /*
> >    * Currently in ACPI spec, for each PCI host bridge, PCI Segment
> >    * Group number is limited to a 16-bit value, therefore (int)-1 is
> > @@ -568,6 +577,8 @@ struct pci_host_bridge {
> >   	void		*sysdata;
> >   	int		busnr;
> >   	int		domain_nr;
> > +	struct pci_hb_id_pool __pool;
> > +	struct pci_hb_id_pool *pool;	/* &self->__pool, unless shared */
> 
> 
> What are these for? Something for IDE (which I also have in the works, 
> very basic set of wrappers)? Thanks,

Yes, this is something I had sitting in my tree as a rough draft, but
did not intend to send out, but I guess a useful accident. Hao Wu has
taken this concept further. @Hao, lets post what we are thinking here.

The concept is that stream-ids are a limited resource. Host bridges, at
least Intel ones, might share their stream-id pool with another
host-bridge. Do AMD platforms have similar constraints?

The end goal is to be able to convey to a system owner which devices are
consuming which stream-ids and which host-bridges have available
stream-ids to allocate.

