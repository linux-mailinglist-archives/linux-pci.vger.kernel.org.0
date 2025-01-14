Return-Path: <linux-pci+bounces-19789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 576FFA1155C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A963D7A0524
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C72213245;
	Tue, 14 Jan 2025 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LP8+DXCD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C4220F077;
	Tue, 14 Jan 2025 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897222; cv=fail; b=s8cb7bl8YBpC5hRtS/imNSw/E57vUizrIQjbthVvhwHuvl13mfUhxYnDA/Hzy7th3DAyN63sqVzUjZbooVBvcNjG2WFZvwNziV0XphQ1I90pimC2ZlPyt6KhAJXPLTSmV7J6meAHq2XNZm5M3iIcspEpUb8BBm6IjBocsvSv9rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897222; c=relaxed/simple;
	bh=zDe6tQ8hvK8Zn08tBnbkYd6dLsje1lvQyAM4TaRM8zY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qe/ENY/TSoxtMpEcQHSsVFr/Qh214wqQu6PfxrcK/uJ8aycUwdfQx5pXM472AlE4NWFiVmYGlyaLpNVEBcQGLZ8nLEFwTOo/HxPwYfPS5RnFPTDVJAKpyiTEoN5XgI5hpieMbQSEy7ryofzcAD4vohmqOxYPO8+OYTvf2RTE8kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LP8+DXCD; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736897220; x=1768433220;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=zDe6tQ8hvK8Zn08tBnbkYd6dLsje1lvQyAM4TaRM8zY=;
  b=LP8+DXCD6hbXnz1hzNk7LlPjUzWYGx5rlaJtM88cwG7yeHtkjbEaqAws
   GoqDJQIN1k2J+O2BwqmP9YP5Gdmn/+4TxdwuOEABBwRn4M/poXJznsN8n
   12kXwOptELmcN7/TjLgAHC9akCPbzPpAkmtYEsERrGLv1ineUh4WNf0Q4
   5AGuwLxSAbvuUJ8jIGRheSFByfsAvJkuAewxfPkj+ryM2w+0gCX4QWlVZ
   rEvFZ0aqXKauZayE3QORyZtNbYzHo7BAhg/YzImfBwOvZxLnHbODbusV4
   kdbXVp5RuRfRYsI48i8vXuVEHoorxsZ8zYKWU3bi/HSJRJG9jnyqtYz3v
   Q==;
X-CSE-ConnectionGUID: 3nY6RegoRTOyoOgV511WUA==
X-CSE-MsgGUID: v1AbJhQeRTOlXM0R7lkW7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37445294"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="37445294"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:26:55 -0800
X-CSE-ConnectionGUID: 0CRliMthTeODXK0FQcp5KA==
X-CSE-MsgGUID: 364oamG3QgyaA0+Ta77lfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="109927347"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 15:26:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 15:26:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 15:26:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 15:26:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNv0FMHXUOHRL5Mn++PXafwoJTEOk+juws233i9Nne99TfKQr7WpomiOG1VuoMSG5omAqKdT+gJWWbfgK70Htt2tPfp7y+VlDDMK2RlL7NF65R+Ga7GKOrl27gQy0ASk+KdBpQ4XY2FivOSdIql0NLcEqZ9RfP1HpeXR2/obzwykMqESAScxwzKGh7tFkD48dt2B0KbyOduhh1KIEl6DbOLjuAbjzGfSlqy/gOZKFwDA1ELJcAZmDB6zdumy8Z+5EIuYo/sZ9UtypwwTgzXmP3TViFcvD6HscXf5m0gl/vZr8oZ14u4zJPlyssxhPJi/xNn86DQqo/3HUWpSGskE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m4b5PB0drLllZwOc21qkuu9oQrIsRUcycuKMFPYz98=;
 b=bHN9hZ2YEi8YBS5kL7g1i8VihoRpy3x9NYhmnwzjhuxZxh5ozJMZIxHoqvD0HVT3mfzCv8JbWKS4vRK0+dL7h3Rq3YpLyJCEnnFQUTpya3NT3EBUpdOudwkZ6YyrajPQwmWUeoaEmirEIvLAWPGML4u6McHZ+NYCFAmqI1YRXxIrjV2OYWpmxE5nWo9EUwBugpEbC6AdFgHY63Sg0f9aASQrq+x7DLvxb+QEK25NncHlLc0JeCpNAJ9JLFTaUujRws5TV8iOjOlSAbaRYkE1OStgF88jqTsPAVa5DSTyNIOOLiR7gcUuBkloPuFWPjKaof/YtSBidCLTvi7b44vaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7883.namprd11.prod.outlook.com (2603:10b6:208:3de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 23:26:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 23:26:37 +0000
Date: Tue, 14 Jan 2025 17:26:31 -0600
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
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 16/16] PCI/AER: Enable internal errors for CXL
 Upstream and Downstream Switch Ports
Message-ID: <6786f2a7b2b7f_186d9b294f7@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-17-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-17-terry.bowman@amd.com>
X-ClientProxiedBy: MW3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:303:2b::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 7705f578-74de-42f4-26e2-08dd34f2e446
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YBNpuFjI7zlY4Y+e1NZVTB1Ax/mtGAjXu3YhCv6oaQQlg9dP2rUWUnpiZTCp?=
 =?us-ascii?Q?DDd0wtFJtzCVipbzx6OdeL9ididrgNF3TbKvYbjbKap33DGBrrrmTdvcaZNY?=
 =?us-ascii?Q?olSByZpHnt9Q/4anoTud+ZWJqTBWN9z1YYTU1M9yOLGcR0ndfsB5Mo0CzaJ7?=
 =?us-ascii?Q?Pi17B8Q7y1a82FzTlxn4s6gaz5gshmqld3vQxTlY7kmNTF3F0CvmHZ98bBRV?=
 =?us-ascii?Q?ldemQntmdqR1lKMm0qtvzzTBdBNc1x14hX+1lUhZuiw8rj5ppHQlwK33buMe?=
 =?us-ascii?Q?FaWSjbnysp176IclcbWES4c2Y8vSRw51/hjvLPW2DlYvnHB20gDnmjHaa9Cz?=
 =?us-ascii?Q?xjDTapb+Q9aeeAH6qrakzeLJ+xaR7MljMm9Uu2V6wSdC8LHvmxEzt3GJXnjK?=
 =?us-ascii?Q?YOV1nqWdKDByBo/O2hBb14vf7howq5kSCviS8OMQ13dsz3AITRT67kvSif1A?=
 =?us-ascii?Q?AcFPU8XciF//quexOJ9yy+mmMC5+t3JEmAgoDMYIa2VkYlrctE28XwfxvV18?=
 =?us-ascii?Q?JEVhTg707b6cQPvSAcwIhJdoGBuVpP2zld5/QF7j6MsLM9kHD9OUnaOsFnTA?=
 =?us-ascii?Q?Pnw9yc5Q9awaUVvLF7jxO/cNisdbdo9XRnUPE0phkhaT7bxVFheOHx7cbHC9?=
 =?us-ascii?Q?novrK+ciIrrDweYIfizLg07Sbc7NLwYwJpoRHNfK2HDZWBHRh03IdQ0fyCNj?=
 =?us-ascii?Q?7mw/L24vJ/jxAzcvpouHBdfpRZNrL4xgWURWOxLoRs45WDuq0B5sgKKFrzuw?=
 =?us-ascii?Q?n88h2Ktg0e43SAqs9uIIHeUmy0M8ibXocRWv+pVVQueQ/ieOPHGHgWNMqLRR?=
 =?us-ascii?Q?lU8QMnw8q5jBGmpSqDExvNeuciL08TA4KM0i8+fbPeClzfoSwAv7ehWNJnr4?=
 =?us-ascii?Q?oB+X8BT0OJ3mEgO/hkTU8s3fHvYuHgcb7Hx4BUsnV6QIous7CaHz0ti7RT2/?=
 =?us-ascii?Q?B7qnKdrKbDuJjYpFa0aaHJMD6ecBrYSUz8Lu1HJ6dUQDRuxrfzeR7UzU5tD4?=
 =?us-ascii?Q?lyuZ5GnJfvAhiX5vKnEYwjflyGUQ5Cs40u0hFShtBCjx3TZuC4DgxZbu49D2?=
 =?us-ascii?Q?6SWrxhVRomkC80XVeC+fOAJBOYCuw3UgkvrROwsnL4D1f3UUGeps/eMMvXP7?=
 =?us-ascii?Q?RB1fYCXzmp03f+DhWlOL2zHf1yVPwXrUZDdJ/mkMV5U1Bz/t6I/aElzZjjGH?=
 =?us-ascii?Q?WVto2v+USvqvcApsoGzl6aP2OMQmraER7hbtwFtXunXK/4bG8AtlRDUvApDn?=
 =?us-ascii?Q?W7o2+tlcUeIK5gGhQuT/xK+gc4cXtEvaKyn4kZ/wrpQT+Gwl96vyIEmpToI5?=
 =?us-ascii?Q?gg/MN1koYUfJWerZ1E9uZeqIZEPltL99pkKKAwBSndq4+yrrWPm6k++eloET?=
 =?us-ascii?Q?NKgQauFtQoTW+5okbURKrsd95E3WST/cA1n2FHX6GxtyzovoaDcIkw+YVxKr?=
 =?us-ascii?Q?YhWUDNWLTjM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XFuS/0GUHenVTHgzUbf0S5w/T8traSE+xtE8THfLziUvrwNG7Jwsp2mHyDGW?=
 =?us-ascii?Q?TDy/YQtAxrIf1snTB/iNWZUCiFYHy4FwWPPoTUiMbdalKOZ/C7tyVqWHP2Yv?=
 =?us-ascii?Q?7jVeLUofi0xOVQJKvauUsaEZ7VY0uhmHf7BRb/LC3huNppy0+/8QdJVULRIC?=
 =?us-ascii?Q?zgdX/ujyjh9hhPr/kOEzwBCz9BSHA60s68XNNA59CdimySykblMubFF7wIXM?=
 =?us-ascii?Q?OZSDm41Eo58Wu54njEqHhPASRXOzsI4oIS9Xy3NC42Mz3oN6V1CKXLO+AznL?=
 =?us-ascii?Q?sdR3tqRur2Qoo1dbxOKXrKZ1Vt8jMKAQYVKeV0OMgkr3NTLoovbFVfQzPiq+?=
 =?us-ascii?Q?OuEgVDYWUxIW6mkt5BshISrmOr0Pj11IQESaX/S2dyTu9LG7jw8GlU3iXnaj?=
 =?us-ascii?Q?AV800mFh3Vp/8QLIak9b1YD4f31tJZ+Xbrh/TvCIY/DIr7RqW1/7I2fxRuBZ?=
 =?us-ascii?Q?KC3I7yQPJwgPfeF46fLUK8y3Kv2dGTE4aKj0CFmbS0juAHv9WOk5oJG352Qr?=
 =?us-ascii?Q?QNR3XSgkaFta1tTWVrzW4wKuVeQ2KXNNwnLXrckODbSUOJWCUBFttNDwk8uO?=
 =?us-ascii?Q?HuoPRj6SIQUdVLtKxKLkrud75njjSt4qxa569Z6u/Q2zMhOG8pnzXrS8HOGo?=
 =?us-ascii?Q?onYywse8SEK3rjSm8rbHiDRZOPaYrMsvhEB4Zcou0B/tmrB7oHWLyW3THjEp?=
 =?us-ascii?Q?EL8QIlulyjFhBaF/+Z6JZkat9StaZ/+gShZQou7HXMO+phfWGu2RHei0RMhm?=
 =?us-ascii?Q?VuKxMF8BkWOgYPshsm7NBtAU7tSt3RKAw0pU4vGtlxjdZbtUaoj9WvMMcT8/?=
 =?us-ascii?Q?L40XYqPW/9vxt9CBC28qOul9jtZJ9Na5216aVJFxAoEdIK1E+elJ14cfWtGP?=
 =?us-ascii?Q?pSM6+fk9gPBHnkFyxnwmGlLhIPdF5M+blZhwW9XBW6L8VbSKZtZ7bnFPxDC4?=
 =?us-ascii?Q?qrVMOquqEO6DBB5igm+puEJDTNCBFq4yBw6azQXnBvAaeLzIy1w+1uUsqfRJ?=
 =?us-ascii?Q?qIEmJe79sp0jZK12vctvYY4MACTsfch3QjR2WsoUhGDfH6LL67S93TsoAADL?=
 =?us-ascii?Q?CmkUXqV4HKvBQP8l/1CUzcyoEGSKM10cam9CZ0tKCCSakE0u2cj36KkLDPQi?=
 =?us-ascii?Q?j+8Dy0ygYHX/IxsAs1a3y+/87vtJSUuAIy7PPfCnvzcllSADdzMSG28ToNs7?=
 =?us-ascii?Q?VxXN/n8jYbcJPo0LheGig/EijUrRafIQrns0Dht3V7h5VPs4zDDveCwDu7ch?=
 =?us-ascii?Q?5vinU0uNcL/zQUJPK5H80288x337xVYwZj8GfDgslRssi/6jAt3Mkh0Z1htb?=
 =?us-ascii?Q?bjvErxiKDhGYT1LEa9VrzegNrBWLqBeTXmU35wmni543L/Li8/l1qKSGuEkp?=
 =?us-ascii?Q?gU9S6cytJY1plzsH/a2PKmR5rfYInJbCqeYBooiIPltmPvF36C46W92Wl7K/?=
 =?us-ascii?Q?cMzc5bX4UQ+oOX0VVJspPfMfD6/i5bxWOBOV1vXL8Xl2pzfvM7leg0Sfn87v?=
 =?us-ascii?Q?Jp5BcO5RsoqS6SQCCFyW8gWAQhyBEagU2KRjvmTk+xPc0oX9ErxL8IXNdYhR?=
 =?us-ascii?Q?T2z3pgWPhHib6PAX/g2dAc1zmSwdiQdEYW1HVxRM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7705f578-74de-42f4-26e2-08dd34f2e446
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:26:37.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2PJPm1aAaKSWxc8xMQ/HI2RH1bZDm/K4TH2d7nfXrtYNBGpL9z1p5oF/VSWlooZXGQXRGPoUtFHFsvvp+rYjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7883
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
> Correctable Internal errors (CIE) for CXL Root Ports. The UIE and CIE are
> used in reporting CXL Protocol Errors. The same UIE/CIE enablement is
> needed for CXL Upstream Switch Ports and CXL Downstream Switch Ports
> inorder to notify the associated Root Port and OS.[1]
> 
> Export the AER service driver's pci_aer_unmask_internal_errors() function
> to CXL namespace.
> 
> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
> because it is now an exported function.

This seems wrong to me.  As of this patch CXL_PCI requires PCIEAER_CXL for
the AER code to handle the errors which were just enabled.

To keep PCIEAER_CXL optional pci_aer_unmask_internal_errors() should be
stubbed out in aer.h if !CONFIG_PCIEAER_CXL.

Ira

> 
> Call pci_aer_unmask_internal_errors() during RAS initialization in:
> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
> 
> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/pci.c | 2 ++
>  drivers/pci/pcie/aer.c | 5 +++--
>  include/linux/aer.h    | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9c162120f0fe..c62329cd9a87 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -895,6 +895,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  
>  	cxl_assign_port_error_handlers(pdev);
>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
> +	pci_aer_unmask_internal_errors(pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
>  
> @@ -935,6 +936,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  	}
>  	cxl_assign_port_error_handlers(pdev);
>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
> +	pci_aer_unmask_internal_errors(pdev);
>  	put_device(&port->dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 68e957459008..e6aaa3bd84f0 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -950,7 +950,6 @@ static bool is_internal_error(struct aer_err_info *info)
>  	return info->status & PCI_ERR_UNC_INTN;
>  }
>  
> -#ifdef CONFIG_PCIEAER_CXL
>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors
>   * @dev: pointer to the pcie_dev data structure
> @@ -961,7 +960,7 @@ static bool is_internal_error(struct aer_err_info *info)
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 mask;
> @@ -974,7 +973,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>  
> +#ifdef CONFIG_PCIEAER_CXL
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
>  	/*
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 4b97f38f3fcf..093293f9f12b 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  int cper_severity_to_aer(int cper_severity);
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		       int severity, struct aer_capability_regs *aer_regs);
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #endif //_AER_H_
>  
> -- 
> 2.34.1
> 



