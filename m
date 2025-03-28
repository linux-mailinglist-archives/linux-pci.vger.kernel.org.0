Return-Path: <linux-pci+bounces-24963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458FA74EC2
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 18:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88432188C888
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D15A1DD525;
	Fri, 28 Mar 2025 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Er/AONfz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC061D5AB2;
	Fri, 28 Mar 2025 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181267; cv=fail; b=g+27IQPe5hrK17CRoQrvjkmnFeZ6Xlo8hIhkkNvwVnKAavCfPirE9GAyX0AdiEJRM79VWmKEOscsKUyoZ4S7uGeTg2qU0RqljhQMs40IdfHtD6kAAZ1aKUyYGVWlXpfmQnCdJq4ZvyObrAItns58fyddMJiVyDQLJ6cYFw1Go2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181267; c=relaxed/simple;
	bh=mmVaz3eqwZqsHvlE6oS9z7LnazEKminMWNQFw+o+OqI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j/1YAEeHF9I3LYewTB+lXijQGFaPcFMSS7Tjtcu8Flriwb7VoWAZU0++pjQ4eIkFMBVHPopDrPwzorOW5xZg1OxG0kpIKmuFh6GfcxN6USPt85f90IcAv4CD9zNpzC7rDru84Xd0d5yDDIQBTbIwymPwRqys/0Ok3rFBMztxdJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Er/AONfz; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743181265; x=1774717265;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=mmVaz3eqwZqsHvlE6oS9z7LnazEKminMWNQFw+o+OqI=;
  b=Er/AONfzSDtUXK/Tyxzr0+n8SaqQT6TnxnvvnSkKZO4qG5kgCQ2oRwYY
   7DTRt6DMRdkEj+XsFvI/XJqKhxPnFbu6Kob58sH+hZYNIOZVzUqM1GFdo
   1SbY/0skgj5ujMeOBzeEAwihVI39R+FYYSZbgft76e8rtkIo20Wq70lYH
   5wa8Lz7RqZB7DKJwkMlS4pRqPadxeeX59bK6qYjdFYEwLMHiN2TCPrx/N
   84JxBnn7bjQUEueLFo/h/goCmacLLV46924nPeAwOWxV/rP9JcX4JrSNU
   KYaZ55V+u0juQdp7s57sl2Ivf1ZGBSA/gGZwyou/sT2Yw9bFqf6W0kMv5
   w==;
X-CSE-ConnectionGUID: gIHAQIuXTR+GqS1S1GV9sQ==
X-CSE-MsgGUID: psf8Vaw6QvqTaRluxK3zkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="55194394"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="55194394"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 10:01:04 -0700
X-CSE-ConnectionGUID: w0wKZv2+QLqJqAzZB2nd9w==
X-CSE-MsgGUID: JOZFHun/S3qI9gTegHfhzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="125501630"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 10:01:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 10:01:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 10:01:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 10:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pw0WS2+nuaxCvYoZFq9axqVjPgotTtvoZbaFEcJf62QbrReun7t6Aeh588mdp3IobO5KD+ovz6DCK4QB9xtQvas47FSFkpMqZOCulub2bvn/hpPGO6BoPX4GRsjHDZ80ZYJXK2s5GN1AzPB8RugCQMzujucdJjJuY4VufP5dohbXN24boPj8QmIJTR7DKImpDfgC8zeOV2pqgJ4Ydj7LRarfRE6hKeyAwgn50+AugLZNYqFzYdX0n+kl/Z/n9pLzmEGtNnZzO7T+EmKfCjtguarAdoqIHhXZhCgK+hmKiCfkWhGpINMQlcDxO5DergsWLp6AdH3XNwjYfuOObTGqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSTAcdkO/V3tm7Yk/DHlnGsKCq878asns3qgHG2/ljo=;
 b=xYgbLfW9i4C9StvYydu9XIYZHjpeGGyCAOqiXh5vdzPxrHj1W+LB7vx6/vCi82zhRlWEyHUR5VmW0MrSkBKqUyBCirUSsbpIR/EnGptbPTPqV4lqnIoHJNPeVmS0U702RxVFyOXzfvxuxKXNhaMGGngbmyfNWwQdWfBtpkgJwyjuMEhYPR7ts43/ZWmhV+jLICFh5TKYt/s0nfbiSG9PJkKR6JYLOotblXPyZQ5YS6ZAp0qwFZqAMziRLm01qq2YHitLk6TC6Lue0dxvoguqEfh+WnbZ4trlGfv5G31aXjEm3ABnFll/fptDedF+0imjk1XoPGgMiZxULo0l1vGptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 17:00:56 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 17:00:56 +0000
Date: Fri, 28 Mar 2025 12:01:11 -0500
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
Subject: Re: [PATCH v8 03/16] CXL/AER: Introduce Kfifo for forwarding CXL
 errors
Message-ID: <67e6d5d7bf0dd_192c6294a7@iweiny-mobl.notmuch>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-4-terry.bowman@amd.com>
X-ClientProxiedBy: MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: ec212e44-fc5c-4d0d-04c4-08dd6e1a1b0f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1D6irvqJsnHEGr0UQ0DRTs77RX/qO9qxQ9R+erGuv4sDJUJMs30uL50Td249?=
 =?us-ascii?Q?DumsaabcizmJegjKqv+xWjp4NeceqcqTC6jxkUjNWaSg0NASuBLa4F2G2Zkf?=
 =?us-ascii?Q?GvmQzEuMhXPbxojVkmHal1/YH1l85leiyJ/JFs/+vjsAtuG6sFmcpCxT5xAq?=
 =?us-ascii?Q?Mvz2VOgY8POUtUt4GG1VYB5WtKfZ6RpOpWTJyFTQfgpQd0GY9PPBjWSfw6eC?=
 =?us-ascii?Q?QDEPKQkb52RSCqLJbgwTccmrelmzacYduUJRaeec016yb4On2muFXhOEttzk?=
 =?us-ascii?Q?3BNil0qD91FoEJlqzbyZpJ5hidN55luaHKb8O61ucCauIGY5uvuABSYbsXSw?=
 =?us-ascii?Q?+zcdMP5l4S0Z6DIkvZH4lRCRNz/rLz3dPEpNBG2Cb5nQF4tkz6wi/75oO0Ar?=
 =?us-ascii?Q?tKYuzEb+SwZ4PQFGbaWe7dhNP5uD2oKgpVSC2r2aA7Lzsjz31fynC9xwiaJt?=
 =?us-ascii?Q?8XWx4lkGGZwgkdoDGUK1kViqlDOC8MsUhAKbOBVZaQ/QXWnIB1adtVjhXrt/?=
 =?us-ascii?Q?5lH2f3wC6i1lgKDNYcRkMkLi9bcHO2QnFhKJjxAhluMLBtm7yfBhY5ytacM3?=
 =?us-ascii?Q?X28aZkkPau55xzkDn24EkrbgQxjkAMXubk76X473Zc6nkko8QFMJS291zxYz?=
 =?us-ascii?Q?zLgpDOrBRaDZTwBTZQVyxJB4tLkwK07jkpnsoxYKu3i7VsyZ3/MUFU9W5x9F?=
 =?us-ascii?Q?mEMn81x7uVL0VjIUtNIRjdv8olf1m23u7128azfAVEB20SmzwBPsUZp/tVhH?=
 =?us-ascii?Q?tm3SuvJ4mA8MKxkN3CyRsTt3fmCFihzOUzRQwl0chWjwqu7UVhenAJCrvxEl?=
 =?us-ascii?Q?LWZEzV3aculh6oG08u/gP0G5a83fru18LwxXY4/C35U3tPn/+J8h9ocVu19h?=
 =?us-ascii?Q?s1lHnxn2QuqsGX0LJ/tDwV7CIpte22xz/Yf1lUl/N0DrCuAHta0tFDzLN322?=
 =?us-ascii?Q?wYLVdkXhh5L92sZQ7RxqXvrR2zGRGmb+ggQjXpmoH8dwiWKLrU0OnVDEV1jM?=
 =?us-ascii?Q?YvkAXITMjq4kt5P+4/dphG5+3DRqZvqyzj6RWG1bPxXd7OT/ReToLmyBWORI?=
 =?us-ascii?Q?dXWBQWAbMHU9UjqI+zHj3LDEJvttzNbEIZzbSohP0lYDfyKfKgZASd9vinfM?=
 =?us-ascii?Q?LHDUoGs/g0i6JGLH6Jc+JlqBFCDraSWsceNI4Ie6Eik1r38j8bdJo8lH3ou9?=
 =?us-ascii?Q?3rkC0nmmaXW+en2HlB1ZA7MzE+P+uM+Pzyh+plqRVU4xGmtrsOJ9kmbjihWm?=
 =?us-ascii?Q?4N67R27MEBX+XsYfZmBsCBOQullKBUwBo2zmBlwaMJP4k3n5cssmgsYnxFhi?=
 =?us-ascii?Q?PyigVyuf0+NnaFaG1kDj4d0BGyBE9fjcBkaUvnL2tfhHB4tMzBcMszt15hYH?=
 =?us-ascii?Q?4zXv/9esGhI1BwCqfxS+rvwkVdcU82hctW98xn1U6N2CCnpWUB+j/QcVuoTv?=
 =?us-ascii?Q?xDblMFgI3m0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5U8WAgFsc58csGemYq6/++3H13dlxxV20hu1HJPJ+WLdKnjWlakDbd3/GfZb?=
 =?us-ascii?Q?BvKmMLLlR80R8XuIyJEJQy7bFDN0qHNaJ8FbHs5GqFa2NabVzKj46HiEbuN6?=
 =?us-ascii?Q?IiJvef5W92NhQ5UvDDHmA61l5HbjdOSk493c4ViN5F1yZjiB9XiJXEeCGX51?=
 =?us-ascii?Q?pDRnEy1Cd6e8JTFp5D2oe4vHjFWepHF8dtK1P00Y5iSqfHg3mUweATCxYTtq?=
 =?us-ascii?Q?ps9Uts5c5yjk7Cn6PBUefEsF0DJbLa3ZE8B4crZrrHpzPCz9xegjnVJY3qSs?=
 =?us-ascii?Q?TuRbaxRAIsbMHFjfJB+ENxNN+8Tz4M4FGkUsfOI3j8AzWyxG5kOOFbNZDInr?=
 =?us-ascii?Q?SGgCTP3EaGvOIjng1+Y8K83zzYhtkm7Wmfw1fufc1yloTShEmNZ+bY1tM4c6?=
 =?us-ascii?Q?/19rIXCCVnL2TgkQR9Y4WybK2sa6wrD0/wP5r7MKEmdokzlLz02g8QWsW6/t?=
 =?us-ascii?Q?lsUNZFFc16I/o2haWrieF6HLvRy3ylXvq5WT5gBqoV0EEiZtbX9MLkhtmVoL?=
 =?us-ascii?Q?jhxN3HYlqYTWo6dWR9EL2IAd+MSH2S32eN1+L2kec8HOuA68G2P4lqJXkmTj?=
 =?us-ascii?Q?YoS2F2r922+iH2XxcBZ73lS1xo/goKedJdH+be97nL3nSQu9ADaSlNQ8ZS8c?=
 =?us-ascii?Q?anSwBYewXCaavK6l7+Nehn7DCIDPX07o9WjEmshxs1oGPgX/8BMjzBpecvMB?=
 =?us-ascii?Q?RjySmLv652sGlVMGzR6umOQ9RCKnKWM4lHoRvvNF16lCVT76N5GAQe+2JUJe?=
 =?us-ascii?Q?KZJBX1vnM1sjXwODDXaOD9snuFmjHqP1uzBeijfty9CqrgA6rkNglUXHZWaw?=
 =?us-ascii?Q?2qk3hYjnjUhQ6ZPySg0MmEUiN68CZ3hDLKweWoc/FN6k4ejM8CBQCIk+CUwu?=
 =?us-ascii?Q?bbuF6tYBRu5NoTQm1/hAsU7vJixCub5n6dFQU7Gcngdga9TF5E0CREbA+oFr?=
 =?us-ascii?Q?bebRuV3mO1x4y+L2XLsvRfZa1cGZwkrFFCDL2C/+oA6oxOZRtJLfM03FZ1mz?=
 =?us-ascii?Q?SIPqKrrDDhU81qxsECU7nahfOAxG6p8UH6pZghjav65b1pZ0p6oDKSZ4qEsO?=
 =?us-ascii?Q?BkugflWvPP3wpxfcTqoWYUlbmUkn5LDredmIboUH2BCWewyZdJYeqXSKZAUB?=
 =?us-ascii?Q?vsT8t8C9KZkE6przTSay9stsSJCiyK9ZUAZ8Rt/W/rbzOur36us0BYLUfVyU?=
 =?us-ascii?Q?K4nSnr9moLRl3F997ralCLkXlJXxmPIQSHNXxuXkyH4og8rtAKuKNJiLzT53?=
 =?us-ascii?Q?VCneEwAryGRw3Kbexm197eIkCXYesm14HFl+JsbI2TLqHUOf6IMXogaUUhoc?=
 =?us-ascii?Q?89vrAU5elYXcZCozJKuWvptyny3O5uhJy0WQ0FYGoQUwb0shvc3c+hi8ZLuF?=
 =?us-ascii?Q?6j8Qort1XoeWEMUyKbeGce8IP5sMyudO4v7yP3nQmIor3KKbMo3cUUu4GHW2?=
 =?us-ascii?Q?4j50EuTL2HbpBbmAPtL8d+QkuzQQ4V2ulthiHu3BPgZHk4eucL97wsw/meyt?=
 =?us-ascii?Q?UqSSGPY9+fxPbBbXOS8/Mc9Sk4xjrRy7U4YtGmYCJo4iPBCnpIbFWQkr9JYq?=
 =?us-ascii?Q?0/VqDN3t2PqHELl7eHMV5ftcT9Xyp8teBArlflft?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec212e44-fc5c-4d0d-04c4-08dd6e1a1b0f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 17:00:56.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CbKFXMz4jW9GgosiUjCWliiYH+ZhDeDEQX2BL2L1QBYrCAdu/4+J1QYVU6KczPjwT9KIakya4WP5pJA5kdzMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL error handling will soon be moved from the AER driver into the CXL
> driver. This requires a notification mechanism for the AER driver to share
> the AER interrupt details with CXL driver. The notification is required for
> the CXL drivers to then handle CXL RAS errors.
> 
> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
> driver will be the sole kfifo producer adding work. The cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement the registration
> functions for the CXL driver to assign or clear the work handler function.
> 
> Create a work queue handler function, cxl_prot_err_work_fn(), as a stub for
> now. The CXL specific handling will be added in future patch.

This part of the message is no longer valid.

> 
> Introduce 'struct cxl_prot_err_info'. This structure caches CXL error

                    cxl_prot_error_info

> details used in completing error handling. This avoid duplicating some
> function calls and allows the error to be treated generically when
> possible.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/ras.c | 54 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxlpci.h   |  3 +++
>  drivers/pci/pcie/aer.c | 39 ++++++++++++++++++++++++++++++
>  include/linux/aer.h    | 37 +++++++++++++++++++++++++++++
>  4 files changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c7..ecb60a5962de 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -5,6 +5,7 @@
>  #include <linux/aer.h>
>  #include <cxl/event.h>
>  #include <cxlmem.h>
> +#include <cxlpci.h>
>  #include "trace.h"
>  
>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> @@ -107,13 +108,64 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> +int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
> +			     struct cxl_prot_error_info *err_info)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
> +	struct cxl_dev_state *cxlds;
> +
> +	if (!pdev || !err_info) {
> +		pr_warn_once("Error: parameter is NULL");
> +		return -ENODEV;
> +	}
> +
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)) {
> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +		return -ENODEV;
> +	}
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	*err_info = (struct cxl_prot_error_info){ 0 };
> +	err_info->ras_base = cxlds->regs.ras;
> +	err_info->severity = severity;
> +	err_info->pdev = pdev;
> +	err_info->dev = dev;

How are pdev and dev guaranteed to be valid after the put_device() and
pci_dev_put() free functions are called on return?

> +
> +	return 0;
> +}
> +
> +struct work_struct cxl_prot_err_work;

Why is this not declared with DECLARE_WORK()?

Without that I don't know what cancel_work_sync() will do with this in the
!CONFIG_PCIEAER_CXL case.

Ah... ok looks like that comes in 5/16.  :-/

I got side tracked looking at the rest of the series after I found this
change in 5/16.

I'll send these questions out but I'm thinking Bjorn is correct that
passing cxlds or something might work better than stashing pdev/dev.  But
even then I'm not sure about the object lifetimes.

Ira

> +
>  int cxl_ras_init(void)
>  {
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	int rc;
> +
> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	if (rc) {
> +		pr_err("Failed to register CPER kfifo with AER driver");
> +		return rc;
> +	}
> +
> +	rc = cxl_register_prot_err_work(&cxl_prot_err_work, cxl_create_prot_err_info);
> +	if (rc) {
> +		pr_err("Failed to register kfifo with AER driver");
> +		return rc;
> +	}
> +
> +	return rc;
>  }
>  
>  void cxl_ras_exit(void)
>  {
>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>  	cancel_work_sync(&cxl_cper_prot_err_work);
> +
> +	cxl_unregister_prot_err_work();
> +	cancel_work_sync(&cxl_prot_err_work);
>  }
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..92d72c0423ab 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -4,6 +4,7 @@
>  #define __CXL_PCI_H__
>  #include <linux/pci.h>
>  #include "cxl.h"
> +#include "linux/aer.h"
>  
>  #define CXL_MEMORY_PROGIF	0x10
>  
> @@ -135,4 +136,6 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
> +			     struct cxl_prot_error_info *err_info);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 83f2069f111e..46123b70f496 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -110,6 +110,16 @@ struct aer_stats {
>  static int pcie_aer_disable;
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>  
> +#if defined(CONFIG_PCIEAER_CXL)
> +#define CXL_ERROR_SOURCES_MAX          128
> +static DEFINE_KFIFO(cxl_prot_err_fifo, struct cxl_prot_err_work_data,
> +		    CXL_ERROR_SOURCES_MAX);
> +static DEFINE_SPINLOCK(cxl_prot_err_fifo_lock);
> +struct work_struct *cxl_prot_err_work;
> +static int (*cxl_create_prot_err_info)(struct pci_dev*, int severity,
> +				       struct cxl_prot_error_info*);
> +#endif
> +
>  void pci_no_aer(void)
>  {
>  	pcie_aer_disable = 1;
> @@ -1577,6 +1587,35 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>  }
>  
> +
> +#if defined(CONFIG_PCIEAER_CXL)
> +int cxl_register_prot_err_work(struct work_struct *work,
> +			       int (*_cxl_create_prot_err_info)(struct pci_dev*, int,
> +								struct cxl_prot_error_info*))
> +{
> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
> +	cxl_prot_err_work = work;
> +	cxl_create_prot_err_info = _cxl_create_prot_err_info;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_prot_err_work, "CXL");
> +
> +int cxl_unregister_prot_err_work(void)
> +{
> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
> +	cxl_prot_err_work = NULL;
> +	cxl_create_prot_err_info = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_prot_err_work, "CXL");
> +
> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd)
> +{
> +	return kfifo_get(&cxl_prot_err_fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_prot_err_kfifo_get, "CXL");
> +#endif
> +
>  static struct pcie_port_service_driver aerdriver = {
>  	.name		= "aer",
>  	.port_type	= PCIE_ANY_PORT,
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 947b63091902..761d6f5cd792 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/types.h>
> +#include <linux/workqueue_types.h>
>  
>  #define AER_NONFATAL			0
>  #define AER_FATAL			1
> @@ -45,6 +46,24 @@ struct aer_capability_regs {
>  	u16 uncor_err_source;
>  };
>  
> +/**
> + * struct cxl_prot_err_info - Error information used in CXL error handling
> + * @pdev: PCI device with CXL error
> + * @dev: CXL device with error. From CXL topology using ACPI/platform discovery
> + * @ras_base: Mapped address of CXL RAS registers
> + * @severity: CXL AER/RAS severity: AER_CORRECTABLE, AER_FATAL, AER_NONFATAL
> + */
> +struct cxl_prot_error_info {
> +	struct pci_dev *pdev;
> +	struct device *dev;
> +	void __iomem *ras_base;
> +	int severity;
> +};
> +
> +struct cxl_prot_err_work_data {
> +	struct cxl_prot_error_info err_info;
> +};
> +
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> @@ -56,6 +75,24 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
> +#if defined(CONFIG_PCIEAER_CXL)
> +int cxl_register_prot_err_work(struct work_struct *work,
> +			       int (*_cxl_create_proto_err_info)(struct pci_dev*, int,
> +								 struct cxl_prot_error_info*));
> +int cxl_unregister_prot_err_work(void);
> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd);
> +#else
> +static inline int
> +cxl_register_prot_err_work(struct work_struct *work,
> +			   int (*_cxl_create_proto_err_info)(struct pci_dev*, int,
> +							     struct cxl_prot_error_info*))
> +{
> +	return 0;
> +}
> +static inline int cxl_unregister_prot_err_work(void) { return 0; }
> +static inline int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd) { return 0; }
> +#endif
> +
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		    struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);
> -- 
> 2.34.1
> 



