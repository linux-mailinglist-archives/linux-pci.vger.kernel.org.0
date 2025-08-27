Return-Path: <linux-pci+bounces-34864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE97B378E8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFF2367379
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2513B30DEC0;
	Wed, 27 Aug 2025 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zw3f46Yq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63EB30DD14
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266794; cv=fail; b=sIS+wnAdzLWTJ32qDjX7O/xZK9duDgHWpApFvirY4JOnFTBYtbx4BAUYRgJhbqjBIL19g4E6tMzbC9dVAAB3+s72Jb4UNIUVyLhK3R88Bfw1D7I7YUj1FNYINX0RnNcjpjeBSyNNrZiS0Yr/Nk5vsz7QnJ2xTVVSWojABQ9U/D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266794; c=relaxed/simple;
	bh=HL29paftLNROrHy7M9bD1oJbss58fefvovPAKpy3JXc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OgHbXT471fIRbP2XK0tYNEiAH2/Giit37p8Wq8tnubb7ofyT0nhwD6BxOzaJmjFs8kBsPgX2UYQrkRlzBXiSl8fhEtKl7sm6tHyzXL1FHIeI22SQSs6gjqTodITfG4iQu9ENSPrueBcGYikG/fzyTJgdixCpPfghu/00pH/XYRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zw3f46Yq; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266792; x=1787802792;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=HL29paftLNROrHy7M9bD1oJbss58fefvovPAKpy3JXc=;
  b=Zw3f46YqNiAdcCXBKOnvFbwIrRolE87ybAkCGnMjcPfgS8sojC6JF4nA
   KUtnlFctZJPYdP6rStmmbdtLsRvBYph/5rjOPhrt7Fh0z6KvwzRrjXFbo
   v7Dfn4DMFc+oUub2MZ3PpLkPFvujBJifK1lXt7ldvqUQgBBhckhaAUUNm
   rmIi9j77yZ05BwAR1CQur1/jXQqF2dnVg/3kQdc1M4yavgOPvd8Gs1Uuc
   PKqAnpW/LeQO/WBbMKjGdjwyT9nOPiWl5Qx3k+9LKVHWlWxzP/CMdCpz4
   J0WZMQX4wx5DhieDZEF/gpLlaUwKWZHficMep8QUx3IzrJH6uBxX7YbTD
   Q==;
X-CSE-ConnectionGUID: hlCEfaFnSNi1urbIpdx6sw==
X-CSE-MsgGUID: 3IopJj+1QbWS8/bzJNfKZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69106521"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69106521"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:11 -0700
X-CSE-ConnectionGUID: JXiLlsV2RQue/raNy4GWYw==
X-CSE-MsgGUID: 8gq2hTF1TTe+dCcRNtuGBg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:53:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.79)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma1KOnoAQ3AJYzcFzbYUr8kLlkaF9eB/i/yMjMvi7i0g7Tl70B7aBmHaQ+VHZLZUlbXj1Tvmg/QvtodP5JQaLvL6cNccAa9CfUW8UeyQrq18MyYcOcQwHuGXy2aGRI+uUag6z4Y5IAifQXfMR7RBtHwelaKOCouPPCFCHhDJohpaRUP+oGirCeQG0YhDVr7jGdcbsY9vUGfMzkd9UDYoKKspKIWxDlbaqdnvYsZGcdj2Jc3BMI/kSmX0K4ot70/vHwizbeHetXm2/xuTbgLNenuGorth34nTEM2nj3AO/IzjzAkhxkxvBXw/1Iqi67rZXC0MaK1R7+hCZCVFRSQu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1KXPfc2GWNLMXdKfFmAn09W2FmP6Fzja1llcVH12Kg=;
 b=P6xPTaVad7VADZb7d3OE1NB5lEKxnqkKaEbFiqrCj7XZCz4Ews2MjOz/f0pserYCyEavGRNWBVVPygwNQ1U3JiUS8USSt5bRqJKvoZHVa2oc7DEWu+2qEsZZEyMx+okjzsP4nUSqBwTQahMJT84q4vxHDh3Bz/9yDZVPtXKU1DtWvpztbuAgYKAKTiiHj4oew/IlTaVbsV+1AUeYbNH7FCsDmGNJOinPKJZiz3OYVdiY4THtz6jP6ylAWLUQUplg13Y2WlLHDdarGBp0ha0EpTsbwlkxvqlEntT0UDHNI1XxsukK3L88vdA4tGuDAqRvo/Z50gZSQ1G8mRY6Jn71uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 03:53:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:53:01 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>, "Andy
 Lutomirski" <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, "Christoph
 Hellwig" <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Roman
 Kisel" <romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>,
	"Thomas Gleixner" <tglx@linutronix.de>
Subject: [PATCH 0/7] PCI/TSM: TEE I/O infrastructure
Date: Tue, 26 Aug 2025 20:52:52 -0700
Message-ID: <20250827035259.1356758-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: fa949fce-bc15-4567-a177-08dde51d380e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yrwQ161H+4unKP8ZhzaWWAhf1jF+ObXn6GtZw9/S/p8q7c6GH1sCBXNNPfH1?=
 =?us-ascii?Q?bbeuqk9Cko5aYWnAFRCFxpe71tUdfO24l0mllk09kNctEZvLh0DNnRNEbor4?=
 =?us-ascii?Q?u6oQEyL1vPr2oanU8n/GmG435duNhbHK1JA9G4ppjg2HQYVe+tAQaIXiUj5m?=
 =?us-ascii?Q?XSvc7Z4RiLcwfWnEbq8wUZ5hZ34MzhgtTrtRpvM9Twe7Y3T8t8P3qUNv+1Na?=
 =?us-ascii?Q?roQPE3eiHl+P0isLSl/GckfA2N+8aZ1/hrfePmpEygB03r/dUYW7Y3yW8ZMh?=
 =?us-ascii?Q?giRzuqi2zEil+Au7WS7RglfPKYIUUCwveMBzd54Sts35trx4imUMlk9HJy4b?=
 =?us-ascii?Q?EQsjFh0vtmmxxxyKtUG/Gi7HgRJgWJlwa7Dy14kvt2m7rcrVKpNIoPZH/dY4?=
 =?us-ascii?Q?liovwlfW2QNHiwG9+w/HL+kCdpGFnOBxG/joqQX/aXGkQQ6C7tCbBDhoFP+I?=
 =?us-ascii?Q?DRucukbNBWxVJYMFS9fJazrDK4T4eHqPPUqSt0djOLO7DCPNcdNNgkTYCnfI?=
 =?us-ascii?Q?WSArpbXqWQOi5RJCDlgzyU9JfzL+P0nkyyYSWQKe6J60PFuxUJEXpFyXE6r3?=
 =?us-ascii?Q?oWRVp1eiiw9JKCLaBIo9WUAvNYx9+Qaon4XmzCrrhOj8y9HcDOJAyk9a0PJV?=
 =?us-ascii?Q?iwn/2x5etwDIeCiZ22W+AoNNvza/dJjyCL3004AA8YqybQ5/ViD08ilshpLi?=
 =?us-ascii?Q?vhBUBTQXN/x1Au0HYe24nrsiEzbJIXguGuH7BC2wkLhVjCaBsDMOHOqWSyLh?=
 =?us-ascii?Q?XsytwQWPkFTjzmBjErkhjx56lfyuia08toq/nICzMDwEE6fr6ZB9z1IL2xmu?=
 =?us-ascii?Q?MnBtbmkFZAwqt+sXKQLGyArksxANXTWG2K5ATbfO6n1L02DnUTYV7HvM+kua?=
 =?us-ascii?Q?65wWXk7yuFNLMTUpceHR14dNt7/+nXXdhYzb9WfBot1chdAEvCjRE4U1+lt/?=
 =?us-ascii?Q?Mo4gJH0jT4mmzaPeOY4QkADbnhTMW8rG26Wtlmfn209yWqNt4JLkj+x3vNxg?=
 =?us-ascii?Q?lCcW7Olwtsd6qOiMN7qg5zWgwKi189Bv8PfmRdPry/QyCXXAWe1EReIpEU2B?=
 =?us-ascii?Q?g54RtlWudvmAEdjNdgEE3BAsGJFoO6NbwVW1amYfuY1D1Q3k5B/Rl26+A+Zw?=
 =?us-ascii?Q?6K9IYxaPcgToVFxZ0ghG/f0USTSUaQDuUM7IjR9ybdTDgfR7U0mWm2G+BgPc?=
 =?us-ascii?Q?EQHXqJZOeR8KfcJjcj7iA/EaGjppxw1nLQiyJHHgXdIbmqJUI/YNYvBR1z1d?=
 =?us-ascii?Q?gN4Hnju6r2DYKawGfjmiJDqtp3093HFE/9adTQke6s9tRK4WDvn4IlAC0eyp?=
 =?us-ascii?Q?WANtvQohl+jWjABC9nvoTQraWCAetVnhEa0gCp03zWQCQ0PBvvvn6NMv/+Un?=
 =?us-ascii?Q?mSj56RcRqMEHUq2ehaqL83noSfoscXjldnG+nAWg6nIlNoeMqUAC8KEvhA6z?=
 =?us-ascii?Q?JelMO5+BThg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RrLNNdwoJNfCNr7uLJtgNTTFCG4yOmFdgzFPhiSfMs2L3+jeRr6Wc6onPNlN?=
 =?us-ascii?Q?pU3cLb3Wro3CfDiUsk4uhhOoeaha+icRkcwBKy/5zXYLliGjUSaPPxHlrfeR?=
 =?us-ascii?Q?V9V/yeItB/5MbtDaEbJNltezS8P1+nLK9l2F9dcxlLKO3S6pKQL08V6SE8Rr?=
 =?us-ascii?Q?9GqoHfKwImgX6mPmurAJpcBCKbogtFgLH083CoxIIzBxLB3NtJoBwB6zENmy?=
 =?us-ascii?Q?WH/MhDq+me9YZ/hboX0wu54I3CtwCNCtk/NNAopunNqvki3ixnCSVayzM8cT?=
 =?us-ascii?Q?8gbumrlU9RK3pHtm6oP2GnLfkWn126/5dPui9kxlO3UmVvK9bzrHqqiDb479?=
 =?us-ascii?Q?2uScoIWKf6z5dmJEVnu+rgLDvgnjJKISDask0T9/OgiOs0PKlMyAL1HhWR0u?=
 =?us-ascii?Q?yddilIjJVrkIkcc0dwPCz74oZRFlkCj5Uyybsr0PN8ZVzThR/KevXEcCh3K9?=
 =?us-ascii?Q?80u58lEy+9QFheAd2ui06B9Iu3+SZqgxSMLf74y0mmBbT8UDnyCra6zlroPP?=
 =?us-ascii?Q?ku7+3EJGXY9IFKeoOmTehnPd7fzxvXN0sRl2Z/Xs35l85SzAS4sCKbe77viq?=
 =?us-ascii?Q?Fv46YFBT8ziq9z6oXq8pMzOy/BuwAhz2R9Ra3Ut6ev0840kr6dFkR12XfM0K?=
 =?us-ascii?Q?g5imV8YHqK0V9HRWk3vsxF/05Bo8a3ade+goVVizpIHumLFImZ7r+gwU60WE?=
 =?us-ascii?Q?a+9AUrTY12h+TyTQKVYr2X9DN8aG+IWiBR7oJYvxo6MogXtr18ihaVjdD48E?=
 =?us-ascii?Q?j6ptvd9MT58aRgqg+zvm4am8VfEcLTIeI8jrhxx2FGfldC/w5w2ozFUONUhW?=
 =?us-ascii?Q?m8wY5myXxgII6P9jTcSNaVdMk105hNBTNkhLAZG2fhDF0rs0FCgvKFienHKW?=
 =?us-ascii?Q?MD/gqtMX4nC3OnwbIK9XOZlwYdFQtFf5h4PP1O/ZC97IOdM+l85H/tKY6RTR?=
 =?us-ascii?Q?z9YbeHsi88aSAOVnlHOsPwJg0112RGQPI3KcZ9TkF7B8t9y+lb7lY4Y3oAri?=
 =?us-ascii?Q?b7w3D+dgkUBcTEis70wknzPhH3Iyw9vNep8T/9IHUAqQcdoglvrh696c9uZ3?=
 =?us-ascii?Q?d40nA9m7ec6pwVr5nW+1893v51aaqABZBH4Ci5Rsgy4D3WcFxKtiE+YKqnzR?=
 =?us-ascii?Q?YX476h/vo2D/ZBzx0TSQPHIcjNbwaoYk01sOZIrq4fYMJyog8LSruZmBtoFf?=
 =?us-ascii?Q?czTCkIlSQAAE6L3+2vBrBm5ZEwe40DEcCDoUMfLtRY/wcnh5wRbMWCqcvXGH?=
 =?us-ascii?Q?Pgmalo564Ml8uEguN90SLFsItxWB74CNN5oyi/iTu0oDa33xsHrfUpgH/+KK?=
 =?us-ascii?Q?ctH9LwGpLNJoPMsN1r1N8rMSBFB9AtCiXnLOXiqToktucAFnMTN4GgWiKhk1?=
 =?us-ascii?Q?pg/H4E56IquEeEK0chE4jaX6YcU90yOzTh11hAuZhK/7f9wiAZlyD3heC1Mg?=
 =?us-ascii?Q?Pym41xd9kl4ZvaGJXcdN0cm4UvjzSbYF+pG1urSV2sFKr7e+zH16C2h4oeBh?=
 =?us-ascii?Q?ajMlKmKcsuHMj++1i7Gl0oxadYWSdLI/4FdFNrOvYqBTkFlXvRou1no4kHi2?=
 =?us-ascii?Q?Z5/JQ05kcg8BhMmr2B4wL8xi9kKpFjEMJ/8UuA+Vh6Y5KRNeq4HR+BQix1x+?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa949fce-bc15-4567-a177-08dde51d380e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:53:01.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUgS6c+05o0vbPV5U1ZPgvjd/WjuSylxvJPiCc/wtZ6ZJXuCKhGMLJ9yshW+TFqc2+oemK3YhraP9pNoUuJ/3LYXAvE0ctRtQa5w8rIjhzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

The PCI/TSM core has two users. The first, the VMM, uses the core for
physical link security and secure session establishment. That session is a
transport for managing all the assignable interfaces of a device, "TDIs".
Once a TDI is assigned to a TVM, the second user of the PCI/TSM core makes
requests to transition a TDI from UNLOCKED to LOCKED, and LOCKED to RUN.
That setup needs to be coordinated with device driver attach and MMIO + DMA
setup.

Add the support to lock and accept a device into a TVM / Trusted Execution
Environment (TEE).

See "PCI/TSM: Add Device Security (TVM Guest) operations support" for the
bulk of the infrastructure. See "device core: Introduce confidential device
acceptance" for a modest proposal on new device-core machinery for
coordinating a device's transition into the TEE.

The incremental "link TSM" / VMM side infrastructure in this set, "PCI/TSM:
Add pci_tsm_{bind,unbind}() methods for instantiating TDIs" and "PCI/TSM:
Add pci_tsm_guest_req() for managing TDIs" is not exercised by
samples/devsec/, but Aneesh asked that I am include them anyway. All other
functionality has a samples/devsec/ consumer. The simple smoke test I used
to verify the mechanics is included in tools/testing/devsec/devsec.sh.

This set is available at tsm.git#staging (rebasing branch) or
tsm.git#devsec-20250826 (immutable tag). It passes a basic smoke test
that exercises load/unload of the samples/devsec/ modules and
lock/accept/unlock of the emulated device.

Dan Williams (7):
  PCI/TSM: Add pci_tsm_{bind,unbind}() methods for instantiating TDIs
  PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
  device core: Introduce confidential device acceptance
  x86/ioremap, resource: Introduce IORES_DESC_ENCRYPTED for encrypted
    PCI MMIO
  PCI/TSM: Add Device Security (TVM Guest) operations support
  samples/devsec: Introduce a "Device Security TSM" sample driver
  tools/testing/devsec: Add a script to exercise samples/devsec/

 Documentation/ABI/testing/sysfs-bus-pci   |  46 +-
 Documentation/ABI/testing/sysfs-class-tsm |  19 +
 arch/x86/mm/ioremap.c                     |  32 +-
 drivers/base/Kconfig                      |   4 +
 drivers/base/Makefile                     |   1 +
 drivers/base/base.h                       |   5 +
 drivers/base/coco.c                       |  96 ++++
 drivers/pci/Kconfig                       |   2 +
 drivers/pci/tsm.c                         | 513 +++++++++++++++++++++-
 drivers/virt/coco/tsm-core.c              |  41 ++
 include/linux/device.h                    |  29 ++
 include/linux/ioport.h                    |   2 +
 include/linux/pci-tsm.h                   | 106 ++++-
 samples/devsec/Makefile                   |   6 +
 samples/devsec/pci.c                      |  43 ++
 samples/devsec/tsm.c                      |  99 +++++
 tools/testing/devsec/devsec.sh            | 138 ++++++
 17 files changed, 1161 insertions(+), 21 deletions(-)
 create mode 100644 drivers/base/coco.c
 create mode 100644 samples/devsec/pci.c
 create mode 100644 samples/devsec/tsm.c
 create mode 100755 tools/testing/devsec/devsec.sh


base-commit: 4de43c0eb5d83004edf891b974371572e3815126

