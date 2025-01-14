Return-Path: <linux-pci+bounces-19792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB0A11584
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B407A0551
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A182139D2;
	Tue, 14 Jan 2025 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StP1vPya"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC82135AA;
	Tue, 14 Jan 2025 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897936; cv=fail; b=CZnSkZtLEzVKnAZe1DA2zGNEl5hGTD4MJ+uOTVHta2pd/5nXBg+FayRL1PHX3swbBqMbNxoHCOR6A8oZF7jF6G1tZcdkrxsFn1pxMZnkraHXKbOMB565/xmg+jJHlf9rcC6ExmiWHu/DL20tgaTea7qlpz574N+5nzwmMjBJyVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897936; c=relaxed/simple;
	bh=Ks2U00oU2YojMBFyMHj7LraFA1MsCQTSghPUlfjuCfg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EaV+nG0u6IS4Ayqe6+8CJuzUI8eYtlMOMuFA6q6mhLGJtUx6egjcT3soC5dohRGRk+YmnmCjx94frshVmxEq+vSz4QX8Yslj754RhRBaVVHp51KHXY76coQ8kiItkcqLk2uAoGrOfJwk5UYuVOWE0asWSxbUddbv/Xq5NVW6nJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StP1vPya; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736897935; x=1768433935;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Ks2U00oU2YojMBFyMHj7LraFA1MsCQTSghPUlfjuCfg=;
  b=StP1vPya2Taj4o057o9uHGpAJKMIr5QXs/JSheDVC9q41IUGviX0/l/C
   nxw8HF3Xipu+BFcX0dZR2dUwOgFcMCJCFWSm0KeHxvX63IXp9D74/ATMd
   H0v3NtylzUoCMsdKacQF4SFW6XI20fE9QpxXwbLKrerwAehkN2RrGMlfM
   FF8gD4dv8mjwrw0TCkQI8ZGNuWSzpjl45i1ZLlEHYAYQ4PezRViLqUmJK
   SY8B6tsofy9bDsOctM1HE9Wbhc4ZQybSQGrtp2S5DX14S1MfeBZjP+ZaL
   Ue+Jcv6jztPu7qi/m5bcatGT6XoVNeLBZZxfCsBqRoN2mw1+/Y4k654xS
   Q==;
X-CSE-ConnectionGUID: GAFfFRNqTc6IOvmDn7HHyA==
X-CSE-MsgGUID: mbQKiwFORa2iqvYmX2zbkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40980151"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40980151"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:38:54 -0800
X-CSE-ConnectionGUID: 3QPZLSJnTTijlD9Zy16BGA==
X-CSE-MsgGUID: 89CDyLFUSUifoBTgx0cuBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109577103"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 15:38:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 15:38:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 15:38:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 15:38:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctQlBQyBEM9UV2JSnSx7yl5txpleDG/rLmXdGvbTDHj3iWDpUpRCCPfMla5MIFhO6XQ5m5xb0Vx3dIRRZ7qcxyVV5hLpl90bK/NAd1EV5lIQinugZZokXq0ERTxJvxtb3nbLfFh/2YZYzKf1MI7HVCNoXpPIlITxRO8Bq4U0093ixDnVCRZ9ixbVPlR+Zq5ZdnrVGFdQ6fdFD/dXK5rFNUG6HzdEJEJgnVqrZV7jT58w8jeLEWsimXyHs3HPFLF6Ab46xbwxQa5xLEp0E6Tij5QiZcUgx+8y/qA5jjWuHhsPCqjfRTkf24qyMgekJVR9HcUpweZQRuTK2AcYEwK0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbiqPZ17C6iwM+J8UlqvqDKThLaBmheHfCH2bcVn7u8=;
 b=sHFdkm8TOxgpvSgnpnO5uqmR6g6UChtLsOKj1eejFvqGRQvrLM5TaswhVm9Va5tg7XuC5Zw/9N6gpnx2IpOdUTH7DyMBK1WfegAZ57lzhWPrBaWEzx48geH/7h+7gxulO8zByMSMBoEZp4xAawtqKxuNL0hF9t1OYnbhyYesvqHe+Uvtw4vA+vVxc1I1MRqvo7vObjgQHawkCchCHoCaMtmDyf7pRuUcibX77VgAOFw6fvJmaOMa6z5YhGsA0agnYookQepPsoNp8kUnWC85VRgkB1MazxL88uEwGvJTELecvT2r83WxUfL9tYSNd7q/C6x+eKaZXT/js1+k5PPzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7431.namprd11.prod.outlook.com (2603:10b6:510:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 23:38:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 23:38:51 +0000
Date: Tue, 14 Jan 2025 17:38:44 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 09/16] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
Message-ID: <6786f5845635d_195f0e29413@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-10-terry.bowman@amd.com>
 <6786df12594c5_186d9b294ba@iweiny-mobl.notmuch>
 <73855ef4-7540-486f-9a4d-e73cfd286216@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <73855ef4-7540-486f-9a4d-e73cfd286216@amd.com>
X-ClientProxiedBy: MW4PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:303:16d::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: f3dbcb7d-ac57-433a-ac2e-08dd34f49988
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RdIc8QkxRvEHak8Pis6JXMKsQ3qfVALFuB5tV+/Ssr1EaOt6M0O36+++Li6y?=
 =?us-ascii?Q?zywcyKHaCJsTg0DdjtMjURLm+Ni2CIF59hZrXPRt3Sjx7K+EiMadwUsz6XoG?=
 =?us-ascii?Q?4ZcpZ/okjM7pbrk3oL9C2x3T0IwQ9zWov+29snsY+bBrD9iykmDJsotRchTK?=
 =?us-ascii?Q?LmOSbZ9h/Yjic6HCPKQF9W/xrZ4akNbAiJ4kyDamF9dQSJOzoU51p/bBStN1?=
 =?us-ascii?Q?AuZSj5VYrsnQJAwcHDbySzu+Gvcges0IDkYkXs2vk9xq0Bc6x0ncEPpFswoB?=
 =?us-ascii?Q?lBUy2tz/9Nm5xfPPLHe+Oujiw8+ktHqLaRIRmP1aydv0AAXjK736SJEntfmc?=
 =?us-ascii?Q?6aWBbVavUiTxZXBlHogiqx1Q2ztWJ1Hp2U6d4uH4ehazb+1VC0TNQGzC/KkW?=
 =?us-ascii?Q?mEMVkpDpgC3CXj5DlRJTZyVXpBIkUmrsuPNj5HmVs4VXRaatjXc2Cusc6SV9?=
 =?us-ascii?Q?grJQIJ0RpcelAl/2pciuEkVpwgVe1g+j7bptUywdFjeMJqu91XF8f6CgrzsF?=
 =?us-ascii?Q?yRrQ3KtcUBCg+6hd2CWzLbMVw4xyVKmDWKbKk5fcsz7f9nsKOQuRNuIhE+bm?=
 =?us-ascii?Q?RsDilgKgGjEBVHcq1o0DKwz/fGhsvctTHiGqn4bE3sda5TvqzpETR9hRPngV?=
 =?us-ascii?Q?BYRmwBTmwhcdN1zrAJfRQfS/imE4vvdHLWp8XWkMBB0Dphz+XdzWdHOXxkPw?=
 =?us-ascii?Q?QLIK40m4DimKWGezO8/SFEIL9VFPMe1gXcSe/a1v0PjytGqs8ALwMJawAQFF?=
 =?us-ascii?Q?3CV/vGvLTb15QDLtpQU1jun1nQ9BsRWNYHyXP5DIZJVXg6b2Es8FOE6KVq1o?=
 =?us-ascii?Q?vpEOXNUrorOj1f/LVTyxzaiHBSDYqABMw6v9+XkjGwz1P1TPanBfM4CywPMc?=
 =?us-ascii?Q?QgGtV1HTQ8Y32VZM/G2Th/yDrwA/fQvuDyJH74cdIsamNpG4V0S1LmMj7pvw?=
 =?us-ascii?Q?hPAsf93G/vA1MjMiXMcSmceeq75g/pCjXaFFAJdOpLVAqWk1rrTWkFV4+OrY?=
 =?us-ascii?Q?YybJarUYZ0qcylO8s1sJjOpoIrDxpvbfVau28KKDvJwSvh/iW3Emwxd+DFhC?=
 =?us-ascii?Q?QDVYCqB89wrMbshd5qTiqeUpSf/Fe08koA1BA5LV3tw1LPaFwcwwL8KY7zav?=
 =?us-ascii?Q?rg32pEqUsdEx4L6D4AEcUYvrglGmvjeIU2O3KCCtVythy95MEvYy9eP7qUBn?=
 =?us-ascii?Q?Fl6Ihu0PSwa7BlywN+0iHa+vzgaOtYtVFINiUYgPuS95iq7wZ/NVFnh5hrJF?=
 =?us-ascii?Q?t+ZxZh4Trmt9j6AiV8q5DIxUTF6wDj8HvMNW3OLIrlVbbbWMMdgwNSelXWC0?=
 =?us-ascii?Q?CuuRZGEwVrwSmf7wvt3qWPOO6t7uxbw1ofDxAoA1FgfcTt/j1ygCngNSFsW0?=
 =?us-ascii?Q?iWP6iBtvzTSNkoi2J/MNgCjF69fsyIPpegABEriHyEaHSM9Vl27YJd/S0OsP?=
 =?us-ascii?Q?c7d8j+1vAMs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MvGQ9NpmqkaGsv/rhgEGYB/5HqxESj9n0Q4mSDN+rsonjZPx2aq8XoNZMpf6?=
 =?us-ascii?Q?YPPPZ9ysuJKKXOEK+fey99SrITobmr1RxVKGMcunvsKBtcTKIZxq2lDkdIDC?=
 =?us-ascii?Q?8RLKO1GD9eP0k438drO6iurZOpQo1b6dIBC+FwlGr4ZgKjNG/lyGVJIKypzW?=
 =?us-ascii?Q?CUkpYKhSO7WcKAeCfLRtcdXjXidd2Vk6Gzu1DZW6vLVWLb44l9sGVVnutM1m?=
 =?us-ascii?Q?gJiNx6F3BB2HdoGX3ZKphxYi9ndm0r9AKbb40MXnByR3ooZ1h/mIjHbQF/VX?=
 =?us-ascii?Q?4I6QidAhiRpjGMk0RX5jBFxxF4QGWFoa+ILFWG/5fd1EgX+ETKLrEgscsn6Z?=
 =?us-ascii?Q?8ceN4xlzuJL/DR4voFSB8WMLiq1EHW524leZ4YnisZpBJmNg/SuKM03F1ybo?=
 =?us-ascii?Q?Y//1pAl2NKkKn99YCtNdc83+s29GGUIpRTM+XRHAURTDYdO8yaMKhLJJSiMY?=
 =?us-ascii?Q?HGoR7cKBvOqeox+xLFWATSko9wHvMiat3a6VJYbZLtfvbDXnyutjrexzINYS?=
 =?us-ascii?Q?1rO4heXCOTNJEOm1P58RGFnxeXyLAKDV0yea4cFVF9Flqnu2T0eD/2E78Q6J?=
 =?us-ascii?Q?d9nLKESieVjr4B5i3Wy4LseKcbhyyWIFnmyukh4zIyg+y7rMdxKBS9qRZjt2?=
 =?us-ascii?Q?fo+0ylePTCFEywOhCzLlCVEMLFP7o/I1x55akEurhlK/MVk5iAW0D9DomrAR?=
 =?us-ascii?Q?kv9KfN6IQj2HyfAIfeupUuRdrwFbwvLOzbYeby3U56khUoZ7YGW5+mgvqdfi?=
 =?us-ascii?Q?l/z/ILgaDghB25JV6anNFUDCJuIbIHuv6R8FsZsIX12KI+bLWA/vul/wLQjT?=
 =?us-ascii?Q?Z7gPxKivrFgPGOMjF2iQ6/NH+7AxohOa+TxZqgVw+LgNwkq2QaUclSC/tu96?=
 =?us-ascii?Q?eE61Ju3bE5iuMV/UBQR+ITtlPvARIsQqg9U5TwjtDpm+o4I53KEA2Df8mr2t?=
 =?us-ascii?Q?/jcB3XgLTHsSjnGeAiJUlh7LyoP5tQPRd8xI3Vps0V/3F4qHYOFwkhuVFYZc?=
 =?us-ascii?Q?xy5uhgDMRlUy1lQCJNjLcLLa5tb2R6TO0CRbv7aYsy77vr9npGxAcJP/0l39?=
 =?us-ascii?Q?0tqjOg65apxo3rCQO/KR/jZNNTnD0mr/mBavDy94Zgyll4M/tQaFa7qnyVmw?=
 =?us-ascii?Q?eiNZLW4VALeGH1kYlAor892Umftqry3DLYin7MI1ZQVnIsrPXT9/8Tee63et?=
 =?us-ascii?Q?dxMNDHHSHoEcOPNwVyht9y16PBPA1eIwBdhLiKvYFd9JZ9bDLCjNmPtST5YJ?=
 =?us-ascii?Q?GyG12bzT4/0PGcWZe6OkjOC6o+UDjurEz6P+ICrAAVQRvBlAl8OPCNqaYAPE?=
 =?us-ascii?Q?jB0B6q5qNDjLxnjEqS8RGLf4nm3rkojlr5zwnSYmhsBBu0ha7nrT0qzjSNzC?=
 =?us-ascii?Q?F7M3/5e6DQZSk35L42zOSFnbYW+69O+Wt1Saba5dI7jnfnJOxdFYJYopXmPN?=
 =?us-ascii?Q?vuEL3dvPZJUavudN2OdZjp3vZsZpIPmP1aQK49lBj8hCyEyCOcF7FO0jchfO?=
 =?us-ascii?Q?EcwTRAxAlnsBxs44L7on/iyp55X1Rb84U2haMHkfvaAZLaWvO3X1hdn1jCjt?=
 =?us-ascii?Q?QFMUIrixb43HMytVC9Tbgg5DvLxRiqZnYl0q1/7T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dbcb7d-ac57-433a-ac2e-08dd34f49988
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:38:51.1925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWPjAll9EUgwRQZj4lG51x89ihNpB38+xUq5dz3w4xoZua+PT9MXfN3ie+uYNjThaEsh/N1qkEQ209n906krww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7431
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> 
> 
> 
> On 1/14/2025 4:02 PM, Ira Weiny wrote:
> > Terry Bowman wrote:
> >> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
> >>
> >> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
> >> pointer to the CXL Upstream Port's mapped RAS registers.
> >>
> >> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
> >> register mapping. This is similar to the existing
> >> cxl_dport_init_ras_reporting() but for USP devices.
> >>
> >> The USP may have multiple downstream endpoints. Before mapping AER
> >> registers check if the registers are already mapped.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> ---
> >>  drivers/cxl/core/pci.c | 15 +++++++++++++++
> >>  drivers/cxl/cxl.h      |  4 ++++
> >>  drivers/cxl/mem.c      |  8 ++++++++
> >>  3 files changed, 27 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >> index 1af2d0a14f5d..97e6a15bea88 100644
> >> --- a/drivers/cxl/core/pci.c
> >> +++ b/drivers/cxl/core/pci.c
> >> @@ -773,6 +773,21 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> >>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> >>  }
> >>  
> >> +void cxl_uport_init_ras_reporting(struct cxl_port *port)
> >> +{
> >> +	/* uport may have more than 1 downstream EP. Check if already mapped. */
> >> +	if (port->uport_regs.ras)
> >> +		return;
> >> +
> >> +	port->reg_map.host = &port->dev;
> >> +	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
> >> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
> >> +		dev_err(&port->dev, "Failed to map RAS capability.\n");
> >> +		return;
> > Why return here?  Actually I think 8/16 had the same issue now that I see
> > this.
> >
> > Other than that:
> >
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >
> > [snip]
> If RAS registers fail mapping then exit to avoid CXL Port error handler initialization.
> The CXL Port error handlers rely on RAS registers for logging and without mapped RAS
> registers the error handlers will return immediately.

Sorry I was not clear and I should not have clipped the text so much.  You
return in a block which is at the end of the function:


+void cxl_uport_init_ras_reporting(struct cxl_port *port)
+{
+       /* uport may have more than 1 downstream EP. Check if already mapped. */
+       if (port->uport_regs.ras)
+               return;
+
+       port->reg_map.host = &port->dev;
+       if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
+                                  BIT(CXL_CM_CAP_CAP_ID_RAS))) {
+               dev_err(&port->dev, "Failed to map RAS capability.\n");
+               return;
+       }
+}

So no need for this specific statement?

Ira

