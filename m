Return-Path: <linux-pci+bounces-7138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6C78BD804
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 00:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7BDB21C38
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 22:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F281B158DCD;
	Mon,  6 May 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8hXXTeZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133913D2A7;
	Mon,  6 May 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715036318; cv=fail; b=NWokQb3AbFwD+/VdQEtonZEH46JaYzZ/9b5nMsu09J/ywzTdSwS3KpKG7mpJLQ0FCPc0xIaIdtHVzr58DwzUWqAJ1b8nkzMm7KAJsPImElQhC7UZmCovRjDIS2SukRLSbQEsyH2fwjPyYe9qQW4a+yWxkxJV67erEAJUHvj2SWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715036318; c=relaxed/simple;
	bh=lNwhwYpGbevHqUGLhRU261ZyhdaWIEgyKSTz3Teq5ZY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=laJ/O4Xy5JyRXlMigmO8fVrQx5c9KWZMVJcE8tfnzvdL9MzCr3I21+yXVO9UjQY47vUSa/bufgdDXGozh83nF8UNwCG3ZCjl+Itwx2/ZbufZB34SpxQT1eFaKVD9vOPX0DyLD5xL+15hCWQnsaym5OCBdQr8e8dafGGs4RtPGsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8hXXTeZ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715036317; x=1746572317;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lNwhwYpGbevHqUGLhRU261ZyhdaWIEgyKSTz3Teq5ZY=;
  b=O8hXXTeZtnMlSP2bUaAitCViXgWCOTnGkwK2b/5BIvYQW/ULSHWD91fT
   cKhDMo4NVCwsZk5famk15d85pnlEf4ACcBXKQYloItDQ7d1GiZhK+A5Uh
   c1ol7Uzbftz8dpSKQFjcAReWsZyphTaUJ8TdIqyueROIw6Pc+MLVpFXP5
   4KOdKX1cL3WZIS/tUTTkgkOSTd+ASEMPMXPCZtkacvTMO08erxMD73IA6
   mokkxXU9nkJfrS+ZuDHf+QelhyleSWNiGDZ412jtsJGpHLp8XxglFah3u
   oT4yI7qGTwjdK3kD0io+ymRu+/3OY78KP+5BAeeF92b4WnIITyaIi+kK9
   g==;
X-CSE-ConnectionGUID: /DumVEN3S3a0N5tXTlwS1Q==
X-CSE-MsgGUID: XcU2n00tR8eQGrWmr8J9fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21358026"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="21358026"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 15:58:36 -0700
X-CSE-ConnectionGUID: D3VqXrPxRkijK+EHXlbXgQ==
X-CSE-MsgGUID: ajXPLfY1Qn6ycJH4Wgub/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="33129436"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 15:58:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 15:58:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 15:58:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 15:58:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 15:58:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbvKDoU6pDBYX4VGv0mScXaffKeHEAupwSjIxhswjC6hWKpOIMGCU2Is5Q6GIf4C4Tkb7uWaaXeBaGY1/v1DQklsB+xJzhLRMnNOoFo5O+DtZFKt7BDrkv5E5Trpls3BXjEA2YNjO1pXGT90mUGLOhPduMH0v2g/1Gfj6oeLjpWWellvJ8KylsjdznCFqN5i6UiWt1Z4nPjaKBOQ0+sKGN3DCfXrt0QzDH4AF+YNhK27I+ULZxSXioJw2+81i85pItLEqeTk//hrAA6Gn5Z4D6nZIz02dee1MpRViLkXAUhrR2n/hMY/IAimRMAwltyxcMDcRP45erO3alGE2wJkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFsvLV5FHfdAcs6/Ds1VvFD3mv//E69EMixbC89Og+c=;
 b=l/Y84Vm838GVp1emdv9SN9VCXqJ6FS1f+snKyxz7gb8stfqsKNcX7yWKlG8pnWCQsKbKr74euB8uajBACFjRt/bfs9FWTXb08wXSWSmC/nDBCsEwNyMa5YPCgweLXy00tBqnP/BlYOy0D82UexEkdZ7p65ik9GfrWDvTeolpvnXaWZE+ECslTB4dB1/DqB1ttl9H7/mi4nhusCFOgMILP444LnL6UKpi6i8/Gj96+Ul7ereVuf5Hsow8Px2wgqIwtd8KLzSkJGN2mdUi2SI0S/EGAoGkLOvARagz6bfjLsRGsh7E+zCz1nn+2W5JndaCb4xLUWMglMu8ngajPsmRCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6976.namprd11.prod.outlook.com (2603:10b6:510:223::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 22:58:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 22:58:28 +0000
Date: Mon, 6 May 2024 15:58:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Adam Manzanares
	<a.manzanares@samsung.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>, "Fan
 Ni" <fan.ni@samsung.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"gourry.memverge@gmail.com" <gourry.memverge@gmail.com>, "wj28.lee@gmail.com"
	<wj28.lee@gmail.com>, "rientjes@google.com" <rientjes@google.com>,
	"ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, "shradha.t@samsung.com"
	<shradha.t@samsung.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>, Jim Harris
	<jim.harris@samsung.com>, "mhocko@suse.com" <mhocko@suse.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
Message-ID: <663960911a914_2f63a294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
 <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
 <3d18ae36-4dea-496a-a8fc-253b21135838@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3d18ae36-4dea-496a-a8fc-253b21135838@intel.com>
X-ClientProxiedBy: MW4PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:303:b9::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbacab2-6d27-4d6c-9d0a-08dc6e200ae8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EU3bVukZB/Sz8g0xJ68utqJAT7qezaCJ062KEL681Cb5VRkPHjlRpm8nPPpU?=
 =?us-ascii?Q?rQycY4kY9WYZPBsPePGgxnFRM8ib7sWi67DTKwEkTc4eTVasMZ9jsdUYzZf7?=
 =?us-ascii?Q?CtFajhD9mlF+eNep0JeR9a2tfXe6tJuDDWUy9jozdJjyv/uyUdALfRv/BF9n?=
 =?us-ascii?Q?2vzRInfZlEbS3AxPejE3VI4K1XU7FldnduKmpSqxmy5Z9fpbPIUN/Z1I2dbA?=
 =?us-ascii?Q?Tk9xXp6h3djcFZsrHNn/a6opNdqQuvjhC4woQLg2DqH3HzraRoAmgFoRR8cv?=
 =?us-ascii?Q?ETcdubIbAPLzLMVjLveHhhQG2EXkL22TmdMpMKWLwCzVLx5SHXh+nS44TsQv?=
 =?us-ascii?Q?V4c3tvnLb+88l3xpVHHaDubQ7oso+PDATxjUWel03pDwLBZQwwQla4CMYWj7?=
 =?us-ascii?Q?C4l4r1pcLCGrpAYwW+UkojdhCqUZbd9nM6tuQIRDfaGwCVQTKltPUETc9vvG?=
 =?us-ascii?Q?K6tkky64+FHQe+1WQu0xKDi9DZy8gmL+lcThtnNWyBGUiRjyh07S5iC9WVP2?=
 =?us-ascii?Q?+vZ4nINifNDC1Gv5RXTcn2TY+b/cDyUxDflnTKPjDY4dORj1m1HF98Yv35gB?=
 =?us-ascii?Q?/k3eMOPUmCfN6u0vMUFVzKd+e/MRcn2Ng+P5MDPZuWYg7+HnvnEHAEQp6nVp?=
 =?us-ascii?Q?lZiqviKflFVR17G5ZghgfSgnbdcj0IRDDPm6uEc9/mtyQdt7DseVuAoOSJ5t?=
 =?us-ascii?Q?0ciwB71rz+yzJun4tbqcSHEhXULLp3w2BYvvb1kWQgkQ7pJmytIrmAgos5Y5?=
 =?us-ascii?Q?c3S9bBWiePkW+fe2E6axNAzomIYgs6OVg4VbXezaTylFxZcWebhh4ok/7625?=
 =?us-ascii?Q?CrNQG+CbttcAxvIV2h+Eh08Aknv/l7A9ZPztxlf+vylgjby/iBhcQyYvQFlO?=
 =?us-ascii?Q?Eqj7x+lvNIomnXGpjqtm0L6RFOcs33mgwV+tqC83PJeKi1wcBtc1t93G3xDZ?=
 =?us-ascii?Q?TWHcNhiIOAQc+ZEnZkhP51Z7WgP8cnsk+PbhT5yxEoPsFDFseNC8EpghNEBw?=
 =?us-ascii?Q?tbuoHnye/ACi3LcaBlnygA2yg0DxA5wWTH4G3G08dionjRju18MaSBUTETUs?=
 =?us-ascii?Q?7pYFa2Li5oe8AURKKBB6h0fuy+o2TRlvahCF6vu+7iKhBn/tMUh1wZz2SGsE?=
 =?us-ascii?Q?mGIMxgatT2lSwcLftdGFTDrvNDLhFKi0EHzMs/wOgADTOdLj0b6dpaLGvhqK?=
 =?us-ascii?Q?jfYSLu06vwCb5cpXu+m/I2C2uBCXhPXLOCo4Rabg4hMHdn7b4QKUOX3lZ9MH?=
 =?us-ascii?Q?B7NV+r/eFawLYEWmIPXCYacxN3Zfm/J/o1JMvtyaz8DEx+uZp4oMmrekZPAc?=
 =?us-ascii?Q?4GA6qwZDFhsRhAilIILKcuL4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y2qvkLzEksTkn4OYmCCtY5zfT/bdeHKEhNzAeDZLwTMtQNPIuWqGxB97skLG?=
 =?us-ascii?Q?WsfIODdUNwZUl1phKb41MGXpUhGBi6dbZhZzTTKm4vYH8ptr+dRywNf57O4E?=
 =?us-ascii?Q?YDDHkGal2QiBXQL1Ckf26Lsgzryid03yjqcfQW5IAMxpKnunEy17aTcrB4Xp?=
 =?us-ascii?Q?LTLUuvDInhRIaVATkWfe0rx6EPup1g2HwGMdNAy2kn5di8utcCaO9U/nZv7Z?=
 =?us-ascii?Q?QqR+cTJZQnSEUtcztvLO+2qZFMueq0BjoxRqlhdHlPtpqqTfMpjDXmD2W6p0?=
 =?us-ascii?Q?jIWdbCvXLKBpVz70Jv4WNL1f62NijlGi/pYdXz5/lnfPIxPWGmdkekI00LaI?=
 =?us-ascii?Q?xsit0JlgxDnfKla/qys3NYFJPYgvZl2IUi5SGGWQSn5PY8AlH7F6vxXSaPKA?=
 =?us-ascii?Q?DR56cYehQGZ19G7BiF3vmpZO0lvQJVkGq+M0fDK2qgeoJJVhi18Rd6fJw672?=
 =?us-ascii?Q?Ou9pvj3/EU6+JmmsXCD1/2o75Dm8PeOEXcocTOoQ+9a/4qaoOK5UW0tykMZt?=
 =?us-ascii?Q?Tbyum0FF/QzM5FuTuzUqTgX3MI+dYxLii5mHw4s0Ps5K1E6JFhfXkFIgOhlX?=
 =?us-ascii?Q?w5x7dWl2MdNYasY0OVySYUt3oBFymiUNvNhpk6RJ2vj0JG2t8Fq7XsIVsk8T?=
 =?us-ascii?Q?6+YfireETtzrx0gIuS0oLTzXUa6ibJrhfBtYgVCl6f7kN7Ce6ZUiKRiKdVvX?=
 =?us-ascii?Q?PkDZwaVWk2NAsWqxQJIFK+jf2LF3HgT4EB0u88R75Tu/uCCL6gexhUAsnXJh?=
 =?us-ascii?Q?bQWY0Pg6BieGsI8xrRR++LyP2zpH+CZEDolhM3iOx+JKfuVwcRm6mxwulNxh?=
 =?us-ascii?Q?7UkRV/hTpZ7LyQVucBz6GmhnKBnrdZ2omLFxZGhRkFZPExhHhOnb7TW81XI4?=
 =?us-ascii?Q?SVaObTftWwO1bPkxj9lbuQg68vroQocaSw+gkscVdmZImv4Tx+PalYo/1d1I?=
 =?us-ascii?Q?QkQ0JDUjlrRW387/Kt6Qvyq+5vXEPydonp2VIFw69SlzKTlqGS21/LaFs9fb?=
 =?us-ascii?Q?SilWvzTCEr7RuSRmrBzLnwgWCy82mBzVQHgZvaWm+swfyZx5Ey7Y9zvuLRTV?=
 =?us-ascii?Q?llMn/jn4LKkHWaolMv/L6sLAInZiP6LsDiXAu7+1YC66jU4BqU5yL+Ad3hcq?=
 =?us-ascii?Q?X1Zobx5wdChuLJHuGhwcZz+HSIc4kfguRG6S4gB276PucKRNLNntSYoLTKLB?=
 =?us-ascii?Q?JkbnJ3K/MLnwN2U5yJHnbqblvsrJ34mZlYtF/khnrymCQiofh5z1oEQRVw2u?=
 =?us-ascii?Q?3SVKQqf0YI2xuvEzs3DdQMNrTE2s5DvgdDkaT3rwMylha6qoqlnJcCxTa/vm?=
 =?us-ascii?Q?e8qBaxYt7FTc7flgfzqoXl0w4ZoNa2IczTnifyVOtPuZAppAKKobO1dS8KgZ?=
 =?us-ascii?Q?7zMV8mxua2usjbi413HVnHaXvmwrP2n6WQyc8ZY5YBq/lno9m2AjSfdFN9Fh?=
 =?us-ascii?Q?DpbeJ1gsdbTyoYw4xVhDCpFfBL/1wa5l7a8VKejIjjRdbJVMEfQgfRWEbdti?=
 =?us-ascii?Q?9xbF60QVwYulyhg2X5O9B49YjL8Cc+xwnWzylz3Q2OyxfVsYJXwI3xTWJ+ex?=
 =?us-ascii?Q?sUlCug0uv6Yc3fl5G3etwVvKaQb9G6bwpg9H4NO7pKDyAQkn7TQBENh6093X?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbacab2-6d27-4d6c-9d0a-08dc6e200ae8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 22:58:28.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dohqj3VZCTAZQhj4L64D+MBUg83adDE9EMyEW90G4kY6SM/lsDr+wn9Berp0Yrxuu+/4Sb8XGZj/kF+wdS209GBZ7RextmhkS9Z5JqWXDto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6976
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 5/6/24 12:27 PM, Adam Manzanares wrote:
> > Hello all,
> > 
> > I would like to have a discussion with the CXL development community about
> > current outstanding issues and also invite developers interested in RAS and
> > memory tiering to participate.
> > 
> > The first topic I believe we should discuss is how we can ensure as a group
> > that we are prioritizing upstream work. On a recent upstream CXL development
> > discussion call there was a call to review more work. I apologize for not
> > grabbing the link, but I believe Dave Jiang is leveraging patchwork and this
> > link should be shared with others so we can help get more reviews where needed.
> 
> Bundle for the potential fixes
> https://patchwork.kernel.org/bundle/cxllinux/cxl-fixes/
> 
> Bundle for the next merge window
> https://patchwork.kernel.org/bundle/cxllinux/cxl-next/
> 
> Just be aware patchwork only takes patches, so the bundle are
> registered with the first patch of a series. The listing does display
> the origin series.

This seems solvable with a bit of scripting.

I went ahead and fixed up one of the series (CXL 1.1 link stattus) to
include all the patches in the bundle. I think it is useful to have a
one-stop shop for the queue and the state of review / testing.

Let me know if that makes things easier.

