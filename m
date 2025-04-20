Return-Path: <linux-pci+bounces-26314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3765A948D9
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 20:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64E81700A4
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514DC20CCD8;
	Sun, 20 Apr 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1urIrfi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D5915D1
	for <linux-pci@vger.kernel.org>; Sun, 20 Apr 2025 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745173761; cv=fail; b=d+ACy+IwzQzL3hfQa+whygQSCV8gjBfEENIncwrOmXfSgriUQPCbgIcYzw4UjxIBlG3vGWXK0fWctFTqJhqOTEQ1lX/yEHOtElZcpouI7wj22aqqD8UO3XxEmytuIoJCrPnsp48DJOw5g07kCAXFuKNmSgeDRBTqiXcKeD6veLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745173761; c=relaxed/simple;
	bh=I6nTxcuPEjKmjeKQqxqN3Zp3y/ClZXKEXaXqjopelsM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W6kW9D3917UpaIH9hGaZzC2KozGdlew3YNGzPLDKAytd06rO41IrQrtcBp7KcYszFERR/Vos/D0bAVGMzwe2t5smY+WeWEw1jee/IcvPXIFqT9nIln5GWPqjDVgblaY3ZwHX2n9GeDGWatkBnyfsca5e9wqbIeFnc0lZboUEeeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1urIrfi; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745173758; x=1776709758;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I6nTxcuPEjKmjeKQqxqN3Zp3y/ClZXKEXaXqjopelsM=;
  b=m1urIrfiAZAADS8RRNJ8AEUtv55J/2+o8Tw1+oAeJ3+HowSJNhGMwq9b
   uPYeuL4wVZurLEkbjq5x+LcTwuLQ/MurOPyv819VRPsR5L660eApXcXvz
   qwbHO4mpKhTYqcyWXGboFtBKF/rEGLNFTAGwqsfticzjPpw7sa/AiUK9N
   ECRsk1HV9OYif5Q2HkGSxn/ofba/rSLX/0GKc5UaFRgIV1D9k+GyJzYFF
   I6VxKMrrjYU2fcrd5LKjke4VdxPImROINOsBeXEDsqcvzwfPEousZdnuX
   gPOXu5QC2mtCI4HuHmCWHbBoxeIYEsnvsFJRqqsWyKt9ofNKJGvytVope
   Q==;
X-CSE-ConnectionGUID: d47aoSllQIek7IQr/eAxdw==
X-CSE-MsgGUID: 7aGVXeeIR9WhASa9I2W1eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="50516367"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="50516367"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 11:29:17 -0700
X-CSE-ConnectionGUID: pjG1rBT9QTipagIIqsQgnQ==
X-CSE-MsgGUID: cesT4VdRST2uFSILm99mnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="135630612"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 11:29:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 20 Apr 2025 11:29:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 20 Apr 2025 11:29:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 20 Apr 2025 11:29:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlkDGVIw+qQyIWXGhNLh7G85qtircS0i9u5hNgogH2M85gwNo2FGpIDROebolkvm9XMPKIjDGwXXtdclswUQPzISuaYqujbPwgs9inyi3CWlLoSMRXs7mtU78P8aSB/1snaqNZGOGYlJZDJNGRCPmjQhOH+qPufiq/ZTbAbDcXXWSRQKwkRnfqacOWMv+okk5YCq2kbu1hy6aZMszLlvFq5a12U/hxczm2AnLpFxOB5SBNafFb6w2nEKWHmmlHNVgob6A0yeycmJdprftge+4eDKvxnRJkeFk9IFpxMhr31ptSk7insUHKbVrPpI9Ug3Cm49DEeNNV/sxS9hpyN5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg/v5nNflsW4mKIYB33HpKRLka+pQhnlmdbijPzM5ok=;
 b=g/M1Fp21V+y4VKF0JLEie1nNK9i/6qQzsMRxk2b4O8iDzKA16+CLb2TLVu9bPDnsldIAkrPfwUIrBelbjv5BKkSNDLP1ZVSO9Vn2BRCfBNU8TJp9FsrVIfZxnIeho8OTxZ+sLosfFG3vIWM/N4jX04krEKIc/1ZOvhs0TRcHNj3ui4Z3Fz5xv/YaEYMiQvj2uY9sOAptxMyXoo6pmvDffCFJXXGVNqCa7NCkB80z5s/VzMl+Gfrtplk4wX87a6IAWnVHrrPmJpbMNcNnfQBN6LDJoQQGhdxqtTMImMqeIcV/UFQzJ8KOSiOnKQN1hG9b4g7lPqRfmJ/nQOsCoHkdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8042.namprd11.prod.outlook.com (2603:10b6:806:2ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.32; Sun, 20 Apr
 2025 18:29:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Sun, 20 Apr 2025
 18:29:12 +0000
Date: Sun, 20 Apr 2025 11:29:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <lpieralisi@kernel.org>, <robin.murphy@arm.com>,
	<aneesh.kumar@kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <sameo@rivosinc.com>,
	<aik@amd.com>, <yilun.xu@linux.intel.com>, <linux-pci@vger.kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [RESEND RFC PATCH 3/3] samples: devsec: Add support for
 PCI_DOMAINS_GENERIC
Message-ID: <68053cf43bb54_7205294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250311141712.145625-1-suzuki.poulose@arm.com>
 <20250311144601.145736-1-suzuki.poulose@arm.com>
 <20250311144601.145736-3-suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311144601.145736-3-suzuki.poulose@arm.com>
X-ClientProxiedBy: MW4PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:303:b8::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec6d70a-7ec0-46e8-7f7b-08dd80393f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ObLxAaIqJAkRfSuzDXnQFKe/y3GUk3Gl2xOJql0fxdbBFOZQ7v56+pWu6lm?=
 =?us-ascii?Q?1Z8/YB2yWYspnQLescUT6+wIzvk6enZYrHCsFdkZyrztN1pkwRLaBQnB1nXu?=
 =?us-ascii?Q?jD1NodlFcVLBOAQf8avXDyZF+XN8iRtPYyZFLnAdLeUyqh3Bf+0LoHlp2iSa?=
 =?us-ascii?Q?/2pU0g6vPpZCaeNVNcbdVpOHV4U6KVqgWYTCwqRDBkFyk29+f+iW5AdAGGB8?=
 =?us-ascii?Q?cnUeKnLBMPfIKaPssNgrXRucl4cc6BoYVJb5+7ikBbfQVDat2kWLwBuT+hDN?=
 =?us-ascii?Q?rHA3qfnKpURSQIGFG5BxzyMAdF4svo7HULv95LU1BKZop/mC8yTbM3OhpkNa?=
 =?us-ascii?Q?7FxdfMbQt9+zvHr/BeC1U4kFsNK0DkPCDkucnXAZ5atf/w8hqfNJZ9ThEM6V?=
 =?us-ascii?Q?o/Ltmw+oC7HIx48bzBzsopu/WQCmmYbT6etPFLKNfNKnGRXrH++ciWmn5ELg?=
 =?us-ascii?Q?XZSB14X3nc+Se0k4Pln4KKaw0RzPgZTi6hU3Pl7i2YQ03ulPYXA0J76n2atZ?=
 =?us-ascii?Q?5sc0qgvbZOD7Pjqk/Qtsz4yHJww962Jb6eSJkZnNOHEjydxXwbwi+UNk2nx7?=
 =?us-ascii?Q?qQNqpwpVLm/F5BgvVPyTCiPqYWCRtiqqYaq1OBTZiUGQOyf8pM1FG60I/+63?=
 =?us-ascii?Q?PIZUXWWnne2IbSjiJARdA2JRTTy0Bk1QFOnhLc4D1zgzvEsUguuwgo1zktP4?=
 =?us-ascii?Q?8JYK3pEdS2Xyjdfvklwdh/o26v0Fh5eKm/qZ6WyMkLCAdu5Czuw5AEs/Gg1Z?=
 =?us-ascii?Q?tYrrDI6ANChUx+L6NfAO6vBQvQHqPfm0J9Mhfy6cZD2Vg/2DmpZP1VnCw52v?=
 =?us-ascii?Q?Dor1U5VyNVQaNrW6EoAlL/QNZ0/ul1hZYiehFwGH+S+yTrUQeXAYlUuC0UnF?=
 =?us-ascii?Q?bCY125yrOu+6Y2anF2Pi9zv8NGvTzMADwHOMRObwOxrpD6Ua9hAg6CA9iTip?=
 =?us-ascii?Q?VTEC974RhVWhkJgP91RvWJ6sJRqlaSbf/IY3i2hKaqodtUVMAdUfrddNTdPA?=
 =?us-ascii?Q?fEei2qzqbxUTIbysnn1fX6ocohoy7AwkXWeCjNPwz8CzaFJD/BCU7XEYziQu?=
 =?us-ascii?Q?zWSdfQSm3S5nqa/xnMWQH4fX4c/KuD7N8LgLTX1dSDvcsnGvWkvhOEsP3RMG?=
 =?us-ascii?Q?sLaZADj1OKi9eicay7y1zEg1dY0gl8OwYnkpUfKUEO5e02CBvOWbvgyaJXl2?=
 =?us-ascii?Q?DGkIIa4Z7x5Xmk6Jn4/I3oi24b9M80VWYRtqCIlSYpEPUArPf6vhO3rmRpOy?=
 =?us-ascii?Q?S7KHto6czLc5W92RZSSPN8MX6y+wxB/9oxwdsrgFLNsxN/vE6HVr2DqWP8Of?=
 =?us-ascii?Q?F9uRPuz0c3Xt1sTXeUKvXh5oXRQztQenz4fiD4XQgTgfzKosG2VVOHYNI4y2?=
 =?us-ascii?Q?AtLNSWq3OWrub1m6e2Aj+o/GMi/IhWjFKc+j8jzb4gBHm5x9QWKEQSBBd1U+?=
 =?us-ascii?Q?9XfWZ7pq8go=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0H0KCzNMDkePkgy+OpwwwTfK9Hz1dcakXZsXCjqBIMbhNglX0mYzDCxABOYR?=
 =?us-ascii?Q?bRRxY8CqLcC8oUJlAqD0UaF8Fe35u5OScrlFHHGC0R7askNPe6wwv5UBCQZp?=
 =?us-ascii?Q?1SawuFlslSZ7pA91l0Iej+3TkbG0Pswld5C8FuWHbdL7QLmIPqak8QcPislo?=
 =?us-ascii?Q?JQxcYXK65nT4PhbD4hM50Wf6lvgtei5hMmfOtP6+f/Z6m1NxPq/Y6bwI4G8w?=
 =?us-ascii?Q?xbqdlsI16HYq+lGufnmnyJ/d4yqeVe0rhJTM/vfc4ZxMAxXW1RDgpdXwBsM2?=
 =?us-ascii?Q?9VTeBfkLu1R5HbKnKx6IGFGLYkkrM1A8SxfA+c9WNM9ScrthaWai7PzqE+zn?=
 =?us-ascii?Q?XvBFWa5oeE+ipTq5LLgfUj1aWC8Qg1uNwtmPocBmAC9jUDHsTVrxKosX0gD6?=
 =?us-ascii?Q?AqYd3Ol3p6Sq0E9JSW24L3BqIT5/MvuYdJ5z+k7iarX+Dsy0JMNSTEHFCQgu?=
 =?us-ascii?Q?wpWFqs3ADoCe0vBt1VqB8tVZ4ml7AO5V9y/W3PuugnUAzmjaIYG4BxdgdJq/?=
 =?us-ascii?Q?cfOYs/LCzRq1aHzkjQS9YiX1SHqZhGl7MhjkUM2aIGwQ8vAmUeaGxrkZMYlP?=
 =?us-ascii?Q?/mB55Y4evdxlfKlHBJdL1hhDN+8eX7/2EdtvQoEAl8uguV/9H70jXC9S4UkM?=
 =?us-ascii?Q?BcTIC4sz4NWOJxPh/9YZgwb5NKjK+4gL0LwldotWGZNIZPGEV2zFxG7Z9X0j?=
 =?us-ascii?Q?OhWkMcVAVE0+2DYm0mDHdDc/EII3p6SA4lm1ty2/FY+laqM4yaWFKIqX1URU?=
 =?us-ascii?Q?hOIERL5ZQJC1XaavbLJov9uBCL3o0GVinJBbnIs7POdcSrxedmgxtvIpm9Qg?=
 =?us-ascii?Q?FZ9hiGzt3Mctvn0z8V0gqnpRS81+eM5NynnddmXQ5YSmlpwIoCRTPyJJC5x0?=
 =?us-ascii?Q?w5cEdPuMB/aiGNa3ZGMJEwKGLqaW2jIpK3l/b8eU5b1pD31tFMgDCg9DNKK/?=
 =?us-ascii?Q?hsODz6uI0gklKYzUlJ4Ye3pgpkJkoMGJTp43cGdjCSyzojxqLZmAA3OE3uBp?=
 =?us-ascii?Q?EyOGxzYBSFlUj2FY97gm3CJOpKlBBLlmVNCVXyN0O8zrNhOkkba70FCnBGrX?=
 =?us-ascii?Q?+KVMBQ0aXD3HGJcTRFX7EpBRqKvcTCj0VKJPUJTyPc6Cl9g5DW5cRfMVLQvr?=
 =?us-ascii?Q?+ix9U3uJ70mBgLSaFiV5w423qDNEnVkVqJLwfSOJyiRl+1f3V6Qpbba8OCr0?=
 =?us-ascii?Q?Q+8Q7ASiWbLTUjbq/Qt80iCH6drL4gtYFY7Xzx4Tu8LQWnytWIgDHPJWvYY5?=
 =?us-ascii?Q?LTH1B26an71e35UjMt/f0oCvaNL8AMUfuStI1Oxxp2KK/LJ2zhDVPKbvwfpi?=
 =?us-ascii?Q?Afa+TJpLQRuBDebeApG7i6NUupugClIotneX+ZKTp320R4bZikyH99QGAi21?=
 =?us-ascii?Q?2Wt1DUYKYGg8kzZ28z9KTeYGSVFfjC1ksqeRg6jWk5TI1wNcoo0F9aREk+6F?=
 =?us-ascii?Q?LDuMwY8LsNDSqORxJl8Bbcl8rrU5cATDYR7aUpi6FcNO1Xy9ikMiz5JQ3IPB?=
 =?us-ascii?Q?jlv1udRp+cIt9RvqGF6JRAXWOraOMrZAHtaJLOofF3Vpz6MqyKq7zncX4nGn?=
 =?us-ascii?Q?LLnmtT/qXwCtwoK2JO5DgglE9KtLkopOuezqXh5Vl+GqArsaLsAPnSVQCTqM?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec6d70a-7ec0-46e8-7f7b-08dd80393f4f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2025 18:29:12.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFdC6G6OTBn+3yThFfGpat5ijbTlw9d8u9BS3DBZHCFgrlKSEnMJiabVFepQJhNJAKU61kxuKng+j660RqeiTinx0USRar/L2bxRcHJkIq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8042
X-OriginatorOrg: intel.com

Suzuki K Poulose wrote:
> Allocate/free a domain at runtime for the sample devsec TSM.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  samples/Kconfig         |  1 -
>  samples/devsec/bus.c    | 32 +++++++++++++++++++++-----------
>  samples/devsec/common.c |  2 +-
>  samples/devsec/devsec.h |  2 +-
>  4 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 6bd64fc54ac1..f23be5088b9e 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -308,7 +308,6 @@ config SAMPLE_DEVSEC
>  	tristate "Build a sample TEE Security Manager with an emulated PCI endpoint"
>  	depends on PCI
>  	depends on VIRT_DRIVERS
> -	depends on X86 # TODO: PCI_DOMAINS_GENERIC support
>  	select PCI_BRIDGE_EMUL
>  	select PCI_TSM
>  	select TSM
> diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
> index b78c04b21eb9..8ec04b3549f0 100644
> --- a/samples/devsec/bus.c
> +++ b/samples/devsec/bus.c
> @@ -21,7 +21,7 @@
>  #define NR_DEVSEC_DEVS 1
>  
>  struct devsec {
> -	struct pci_sysdata sysdata;
> +	int domain;
>  	struct gen_pool *iomem_pool;
>  	struct resource resource[2];
>  	struct pci_bus *bus;
> @@ -70,7 +70,7 @@ struct devsec {
>  
>  static struct devsec *bus_to_devsec(struct pci_bus *bus)
>  {
> -	return container_of(bus->sysdata, struct devsec, sysdata);
> +	return container_of(bus->sysdata, struct devsec, domain);
>  }
>  
>  static int devsec_dev_config_read(struct devsec *devsec, struct pci_bus *bus,
> @@ -309,6 +309,17 @@ static struct pci_ops devsec_ops = {
>  };
>  
>  /* borrowed from vmd_find_free_domain() */
> +#ifdef CONFIG_PCI_GENERIC_DOMAINS

The config symbol name is PCI_DOMAINS_GENERIC, so the only way I can see
this patch working is if you have ACPI=n in your build? See below.

> +static int find_free_domain(void)
> +{
> +	return pci_alloc_dynamic_domain();
> +}
> +
> +static int release_domain(int domain)
> +{
> +	pci_free_dynamic_domain(domain);
> +}
> +#else
>  static int find_free_domain(void)
>  {
>  	int domain = 0xffff;
> @@ -318,13 +329,15 @@ static int find_free_domain(void)
>  		domain = max_t(int, domain, pci_domain_nr(bus));
>  	return domain + 1;
>  }
> -
> +static void release_domain(int domain) {}
> +#endif
>  static void destroy_bus(void *data)
>  {
>  	struct devsec *devsec = data;
>  
>  	pci_stop_root_bus(devsec->bus);
>  	pci_remove_root_bus(devsec->bus);
> +	release_domain(devsec->domain);
>  }
>  
>  static u32 build_ext_cap_header(u32 id, u32 ver, u32 next)
> @@ -588,7 +601,6 @@ static int __init devsec_bus_probe(struct platform_device *pdev)
>  	int rc;
>  	LIST_HEAD(resources);
>  	struct devsec *devsec;
> -	struct pci_sysdata *sd;
>  	u64 mmio_size = SZ_64G;
>  	struct pci_host_bridge *hb;
>  	struct device *dev = &pdev->dev;
> @@ -633,15 +645,13 @@ static int __init devsec_bus_probe(struct platform_device *pdev)
>  	};
>  	pci_add_resource(&resources, &devsec->resource[1]);
>  
> -	sd = &devsec->sysdata;
> -	devsec_sysdata = sd;
> -	sd->domain = find_free_domain();
> -	if (sd->domain < 0)
> -		return sd->domain;
> -
> +	devsec_sysdata = &devsec->domain;
> +	devsec->domain = find_free_domain();
> +	if (devsec->domain < 0)
> +		return devsec->domain;
>  
>  	devsec->bus = pci_create_root_bus(dev, 0, &devsec_ops,
> -					  &devsec->sysdata, &resources);
> +					  &devsec->domain, &resources);

See pci_register_host_bridge()... I don't think this works unless you
have CONFIG_ACPI=n to avoid trying to lookup the non-existent ACPI
device associated with this fake bridge.

I think the path here is to make emulated host bridges a first-class
citizen of the PCI core.

The below seems to work. It adds a new pci_bus_find_emul_domain_nr() to
unify a few cases where PCI domain host-bridges are being emulated, and
it allows to the emulated domain_nr to be established between
pci_alloc_host_bridge() and pci_register_host_bridge(). It still needs
to play pci_sysdata hiding games for now:

-- 8< --
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 8df064b62a2f..efef329c359a 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -565,22 +565,6 @@ static void vmd_detach_resources(struct vmd_dev *vmd)
 	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
 }
 
-/*
- * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
- * Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of which the lower
- * 16 bits are the PCI Segment Group (domain) number.  Other bits are
- * currently reserved.
- */
-static int vmd_find_free_domain(void)
-{
-	int domain = 0xffff;
-	struct pci_bus *bus = NULL;
-
-	while ((bus = pci_find_next_bus(bus)) != NULL)
-		domain = max_t(int, domain, pci_domain_nr(bus));
-	return domain + 1;
-}
-
 static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 				resource_size_t *offset1,
 				resource_size_t *offset2)
@@ -866,7 +850,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	};
 
 	sd->vmd_dev = vmd->dev;
-	sd->domain = vmd_find_free_domain();
+	sd->domain = pci_bus_find_emul_domain_nr();
 	if (sd->domain < 0)
 		return sd->domain;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d7c9f64ea24..0d5a08583197 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6774,7 +6774,7 @@ static void of_pci_bus_release_domain_nr(struct device *parent, int domain_nr)
 		return;
 
 	/* Release domain from IDA where it was allocated. */
-	if (of_get_pci_domain_nr(parent->of_node) == domain_nr)
+	if (parent && of_get_pci_domain_nr(parent->of_node) == domain_nr)
 		ida_free(&pci_domain_nr_static_ida, domain_nr);
 	else
 		ida_free(&pci_domain_nr_dynamic_ida, domain_nr);
@@ -6794,6 +6794,42 @@ void pci_bus_release_domain_nr(struct device *parent, int domain_nr)
 }
 #endif
 
+/*
+ * Find a free domain_nr either allocated by of_pci_bus_find_domain_nr()
+ * or fallback to the first free domain number above the last ACPI
+ * segment number, do not ask acpi_pci_bus_find_domain_nr() it has no
+ * information about emulated host bridges
+ */
+int pci_bus_find_emul_domain_nr(void)
+{
+	/*
+	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
+	 * domains.  Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of
+	 * which the lower 16 bits are the PCI Segment Group (domain) number.
+	 * Other bits are currently reserved.
+	 */
+	int domain = 0xffff;
+	struct pci_bus *bus = NULL;
+
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	if (acpi_disabled)
+		return of_pci_bus_find_domain_nr(NULL);
+#endif
+
+	while ((bus = pci_find_next_bus(bus)) != NULL)
+		domain = max_t(int, domain, pci_domain_nr(bus));
+	return domain + 1;
+}
+EXPORT_SYMBOL_GPL(pci_bus_find_emul_domain_nr);
+
+void pci_bus_release_emul_domain_nr(int domain_nr)
+{
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	/* Note that in the in the ACPI emulation case this is a nop */
+	pci_bus_release_domain_nr(NULL, domain_nr);
+#endif
+}
+
 /**
  * pci_ext_cfg_avail - can we access extended PCI config space?
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c090289b70be..1e65692efc0a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -632,6 +632,11 @@ static void pci_release_host_bridge_dev(struct device *dev)
 
 	pci_free_resource_list(&bridge->windows);
 	pci_free_resource_list(&bridge->dma_ranges);
+
+	/* Host bridges only have domain_nr set in the emulation case */
+	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
+		pci_bus_release_emul_domain_nr(bridge->domain_nr);
+
 	kfree(bridge);
 }
 
@@ -949,7 +954,7 @@ static bool pci_preserve_config(struct pci_host_bridge *host_bridge)
 	return false;
 }
 
-static int pci_register_host_bridge(struct pci_host_bridge *bridge)
+int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
 	struct resource_entry *window, *next, *n;
@@ -1112,7 +1117,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	device_del(&bridge->dev);
 free:
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-	pci_bus_release_domain_nr(parent, bus->domain_nr);
+	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
+		pci_bus_release_domain_nr(parent, bus->domain_nr);
 #endif
 	if (bus_registered)
 		put_device(&bus->dev);
@@ -1121,6 +1127,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(pci_register_host_bridge);
 
 static bool pci_bridge_child_ext_cfg_accessible(struct pci_dev *bridge)
 {
@@ -3176,6 +3183,22 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
+void pci_setup_host_bridge(struct pci_host_bridge *bridge,
+			   struct device *parent, int bus, struct pci_ops *ops,
+			   void *sysdata, struct list_head *resources,
+			   int domain_nr)
+{
+	WARN_ON(device_is_registered(&bridge->dev));
+	bridge->dev.parent = parent;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+	bridge->domain_nr = domain_nr;
+}
+EXPORT_SYMBOL_GPL(pci_setup_host_bridge);
+
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
@@ -3186,12 +3209,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	if (!bridge)
 		return NULL;
 
-	bridge->dev.parent = parent;
-
-	list_splice_init(resources, &bridge->windows);
-	bridge->sysdata = sysdata;
-	bridge->busnr = bus;
-	bridge->ops = ops;
+	pci_setup_host_bridge(bridge, parent, bus, ops, sysdata, resources,
+			      PCI_DOMAIN_NR_NOT_SET);
 
 	error = pci_register_host_bridge(bridge);
 	if (error < 0)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 72d07ad994fa..f3bed5462279 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1165,6 +1165,11 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
+void pci_setup_host_bridge(struct pci_host_bridge *bridge,
+			   struct device *parent, int bus, struct pci_ops *ops,
+			   void *sysdata, struct list_head *resources,
+			   int domain_nr);
+int pci_register_host_bridge(struct pci_host_bridge *bridge);
 int pci_host_probe(struct pci_host_bridge *bridge);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
@@ -1919,6 +1924,8 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
 void pci_bus_release_domain_nr(struct device *parent, int domain_nr);
 #endif
+int pci_bus_find_emul_domain_nr(void);
+void pci_bus_release_emul_domain_nr(int domain_nr);
 
 /* Some architectures require additional setup to direct VGA traffic */
 typedef int (*arch_set_vga_state_t)(struct pci_dev *pdev, bool decode,
diff --git a/samples/Kconfig b/samples/Kconfig
index 6d6aeb736c8f..523a7129aed3 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -317,7 +317,7 @@ config SAMPLE_DEVSEC
 	tristate "Build a sample TEE Security Manager with an emulated PCI endpoint"
 	depends on PCI
 	depends on VIRT_DRIVERS
-	depends on X86 # TODO: PCI_DOMAINS_GENERIC support
+	depends on PCI_DOMAINS_GENERIC || X86
 	select PCI_BRIDGE_EMUL
 	select PCI_TSM
 	select TSM
diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
index 69117db10897..0ca8acaf2204 100644
--- a/samples/devsec/bus.c
+++ b/samples/devsec/bus.c
@@ -20,7 +20,7 @@
 #define NR_DEVSEC_DEVS 1
 
 struct devsec {
-	struct pci_sysdata sysdata;
+	struct devsec_sysdata sysdata;
 	struct gen_pool *iomem_pool;
 	struct resource resource[2];
 	struct pci_bus *bus;
@@ -307,17 +307,6 @@ static struct pci_ops devsec_ops = {
 	.write = devsec_pci_write,
 };
 
-/* borrowed from vmd_find_free_domain() */
-static int find_free_domain(void)
-{
-	int domain = 0xffff;
-	struct pci_bus *bus = NULL;
-
-	while ((bus = pci_find_next_bus(bus)) != NULL)
-		domain = max_t(int, domain, pci_domain_nr(bus));
-	return domain + 1;
-}
-
 static void destroy_bus(void *data)
 {
 	struct devsec *devsec = data;
@@ -582,12 +571,60 @@ static int alloc_ports(struct devsec *devsec)
 	return 0;
 }
 
+static struct list_head *devsec_add_resources(struct devsec *devsec,
+					      struct list_head *resources,
+					      u64 mmio_start, u64 mmio_size)
+{
+	devsec->resource[0] = (struct resource) {
+		.name = "DEVSEC BUSES",
+		.start = 0,
+		.end = NR_DEVSEC_BUSES + NR_DEVSEC_ROOT_PORTS - 1,
+		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
+	};
+	pci_add_resource(resources, &devsec->resource[0]);
+
+	devsec->resource[1] = (struct resource) {
+		.name = "DEVSEC MMIO",
+		.start = mmio_start,
+		.end = mmio_start + mmio_size - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_MEM_64,
+	};
+	pci_add_resource(resources, &devsec->resource[1]);
+
+	return resources;
+}
+
+static int devsec_autofree_bus(struct devsec *devsec, struct pci_bus *bus,
+			       struct list_head *resources)
+{
+	devsec->bus = bus;
+	return devm_add_action_or_reset(devsec->dev, destroy_bus, devsec);
+}
+
+static int *devsec_alloc_domain_nr(int *domain_nr)
+{
+	*domain_nr = pci_bus_find_emul_domain_nr();
+	if (*domain_nr < 0)
+		return NULL;
+	return domain_nr;
+}
+
+static void devsec_free_domain_nr(int *domain_nr)
+{
+	if (domain_nr)
+		pci_bus_release_emul_domain_nr(*domain_nr);
+}
+
+DEFINE_FREE(free_resource_list, struct list_head *, if (_T) pci_free_resource_list(_T))
+DEFINE_FREE(free_bridge, struct pci_host_bridge *, if (_T) put_device(&_T->dev));
+DEFINE_FREE(free_domain_nr, int *, if (_T) devsec_free_domain_nr(_T))
+
 static int __init devsec_bus_probe(struct platform_device *pdev)
 {
-	int rc;
-	LIST_HEAD(resources);
+	int rc, __domain_nr;
+	LIST_HEAD(__resources);
 	struct devsec *devsec;
-	struct pci_sysdata *sd;
+	struct devsec_sysdata *sd;
 	u64 mmio_size = SZ_64G;
 	struct device *dev = &pdev->dev;
 	u64 mmio_start = iomem_resource.end + 1 - SZ_64G;
@@ -615,37 +652,34 @@ static int __init devsec_bus_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	devsec->resource[0] = (struct resource) {
-		.name = "DEVSEC BUSES",
-		.start = 0,
-		.end = NR_DEVSEC_BUSES + NR_DEVSEC_ROOT_PORTS - 1,
-		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
-	};
-	pci_add_resource(&resources, &devsec->resource[0]);
+	struct list_head *resources __free(free_resource_list) =
+		devsec_add_resources(devsec, &__resources, mmio_start,
+				     mmio_size);
 
-	devsec->resource[1] = (struct resource) {
-		.name = "DEVSEC MMIO",
-		.start = mmio_start,
-		.end = mmio_start + mmio_size - 1,
-		.flags = IORESOURCE_MEM | IORESOURCE_MEM_64,
-	};
-	pci_add_resource(&resources, &devsec->resource[1]);
+	struct pci_host_bridge *hb __free(free_bridge) = pci_alloc_host_bridge(0);
+	if (!hb)
+		return -ENOMEM;
 
 	sd = &devsec->sysdata;
 	devsec_sysdata = sd;
-	sd->domain = find_free_domain();
-	if (sd->domain < 0)
-		return sd->domain;
-
-
-	devsec->bus = pci_create_root_bus(dev, 0, &devsec_ops,
-					  &devsec->sysdata, &resources);
-	if (!devsec->bus) {
-		pci_free_resource_list(&resources);
-		return -ENOMEM;
-	}
+	int *domain_nr __free(free_domain_nr) = devsec_alloc_domain_nr(&__domain_nr);
+	if (!domain_nr)
+		return __domain_nr;
+
+	/*
+	 * Note, domain_nr is set in devsec_sysdata for
+	 * !CONFIG_PCI_DOMAINS_GENERIC platforms
+	 */
+	devsec_set_domain_nr(sd, *no_free_ptr(domain_nr));
+	pci_setup_host_bridge(hb, dev, 0, &devsec_ops, &devsec->sysdata,
+			      resources, devsec_get_domain_nr(sd));
+
+	rc = pci_register_host_bridge(hb);
+	if (rc)
+		return rc;
 
-	rc = devm_add_action_or_reset(dev, destroy_bus, devsec);
+	rc = devsec_autofree_bus(devsec, no_free_ptr(hb)->bus,
+				 no_free_ptr(resources));
 	if (rc)
 		return rc;
 
diff --git a/samples/devsec/devsec.h b/samples/devsec/devsec.h
index 794a9898ee2d..64e35731325b 100644
--- a/samples/devsec/devsec.h
+++ b/samples/devsec/devsec.h
@@ -3,5 +3,38 @@
 
 #ifndef __DEVSEC_H__
 #define __DEVSEC_H__
-extern struct pci_sysdata *devsec_sysdata;
+struct devsec_sysdata {
+#ifdef CONFIG_X86
+	/*
+	 * Must be first member to that x86::pci_domain_nr() can type
+	 * pun devsec_sysdata and pci_sysdata.
+	 */
+	struct pci_sysdata sd;
+#else
+	int domain_nr;
+#endif
+};
+
+#ifdef CONFIG_X86
+static inline void devsec_set_domain_nr(struct devsec_sysdata *sd,
+					int domain_nr)
+{
+	sd->sd.domain = domain_nr;
+}
+static inline int devsec_get_domain_nr(struct devsec_sysdata *sd)
+{
+	return sd->sd.domain;
+}
+#else
+static inline void devsec_set_domain_nr(struct devsec_sysdata *sd,
+					int domain_nr)
+{
+	sd->domain_nr = domain_nr;
+}
+static inline int devsec_get_domain_nr(struct devsec_sysdata *sd)
+{
+	return sd->domain_nr;
+}
+#endif
+extern struct devsec_sysdata *devsec_sysdata;
 #endif /* __DEVSEC_H__ */

