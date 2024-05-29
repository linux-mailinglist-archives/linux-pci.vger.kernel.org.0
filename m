Return-Path: <linux-pci+bounces-7953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1328D2BB5
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 06:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587221F23FAB
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 04:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B3415A872;
	Wed, 29 May 2024 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzNavDDl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042532F37
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 04:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716956552; cv=fail; b=AYDOS+zmGu0h9wuASzBiCiu7dahjAN6fRezLMz5RWQntbjUEJ+8RXGS/h/KFcGSgDRnEsjie8/8fInAV/XeZrWFeYbzFQ3Yxljg1cRDdx8Tcj+nzIswTtMs8LnsksKEvsn+jnR0KV3/ayMnurZZibkh+/goE9e0Ba7EXz43oB78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716956552; c=relaxed/simple;
	bh=AJTlFFbnwJIu65NLwB2Ulsz9ZcWySC5g6sK9+m+oOjo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p1AnNRByVDe1uVugY1uknBv22jaaFMSakAA38qA8GpupUekb0ZTAuYKTx1Tvv7GOgw5ZmDk2zcvCd2xgBZTmSdCq4jB3JusK5Z5Pz09GB5Ax5BrSRa5nwOr0P2l9VlEr/1yO4EKjV5lJJNq0/naB3/pZEfKOtMy3gp2ogEqyb4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzNavDDl; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716956551; x=1748492551;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AJTlFFbnwJIu65NLwB2Ulsz9ZcWySC5g6sK9+m+oOjo=;
  b=TzNavDDln+mDLnwo3Ar+IciGrNRNY7/8ifQK7WyM+pxGmi7ex8GwUBpb
   /eLYnkjfUqsw4Gqc6+VFCfpsP0/Ws/cz0FqUifHx5BJnQhqxO4vfR3n0v
   tBY42Ui7k2kkUs3liY8sNOI4rKAN/3x25hhH/BLANBYsaHdHvM/7jd3x9
   Ldh4eIGLwXPz9fJ0fXsV5RCjo6JU56J/VMnx5pK/nQHT6CxXXBujiOPYY
   rplKVcAhCsRo4yg7VK8nnLSBHKmtdwHCfCPmul6KjFfiaA01XYBsej5aB
   mSR2UFs4MyCmFQinNk5Oe9j5eml7LxFdw4apoGqSXldcmLyWGcv2FeKst
   g==;
X-CSE-ConnectionGUID: EllQ53BNTiSEVlMypzvH0A==
X-CSE-MsgGUID: uaCApgpbTBCh5q01smB6gg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24468635"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="24468635"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 21:22:30 -0700
X-CSE-ConnectionGUID: mRmHMzflRgCV5aqi7DmcLg==
X-CSE-MsgGUID: 7UIG3XxWRvKT/0XBQ9blcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35216702"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 21:22:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 21:22:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 21:22:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 21:22:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wfb+fauUIsXV+T+7gZ0pBZVXbD69gSEzG5RZMcLeDoWmxP3PqH55zjHuYqlgWV6AjeMvLJjMPP9jMvDtzV6wdN8TGpRKlhul47O9hxpUpktO6IlZlvLyRjSIazliC5Roj9j6VSZSiGwBcWGFtGPwXWSnFsLt+VjnDOC9OTRprbFeYFO5JJ9Od6LTLEkPr4jPLecar2ySw3ni8lvAWr37WxhTUnlLMWDv8LWvYFhjmg0N3zsvz2RlGm+3YSrngJ/msDsLOI0UaX5g3Ek77qyMZgI4IYGM0TXsdxn9P2yQGf9EzrojFSFBLFjQXsUdLnh7CfywEqT1eCOsjAiYSaFwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f8++fT6mnokWb8X+at9Bguxh2iciVxkM8Vtcyr6/Sw=;
 b=LF41OFLAXYmwKADZHKGwWYb1sEU7QzFdxagxbCKh71sOhMeWILMgDdzlkjDrm42ZNRJl47wtOo21i/qQutavxSd+ynUekqaitvLbcubU5nBV4e/r1CFeDpt70vCb+/MSQrxtB86HM+LNkN94Xh8JUT0giXBAtVigLxOMwf/nBe8UsyN2qrVtls4avurQeFoREpz8lrcGZypjk2580aUPqkdtGG98PX2A9S0GlijMAwh7xYRMA0ajvL7ORXeI/I5hQjrnQ2ylPlOHmQy7NQWfi+2/2KE7uXHJjEJ0dMK1QCSDGjOIDfzpLYeqU9rqacIHd2kzn5RIxf+IfMtyjk19gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7739.namprd11.prod.outlook.com (2603:10b6:8:e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.26; Wed, 29 May
 2024 04:22:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 04:22:25 +0000
Date: Tue, 28 May 2024 21:22:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	<linux-pci@vger.kernel.org>
CC: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>, Arnd Bergmann
	<arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
	<dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Lukas Wunner
	<lukas@wunner.de>, Keith Busch <kbusch@kernel.org>, Marek Behun
	<marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap
	<rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v2 1/3] leds: Init leds class earlier
Message-ID: <6656ad7ed677d_16687294bb@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
 <20240528131940.16924-2-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240528131940.16924-2-mariusz.tkaczyk@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5dc843-9856-40f2-b7ee-08dc7f96f1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v7mokBUMMhekiRBps17lHJejntHCIWbDjwMNC/Va7Xsa5cCDT93uiiJZbZw+?=
 =?us-ascii?Q?tyAMDzx6o8RWOyAbobcPuCubLM5AHU2NO79zCF6NsAA6uhDv+aD3t9vWYfw+?=
 =?us-ascii?Q?ykbRYsLNQjkZpqZSkB5pPYLEutg461eDWjmrSVTIcQBvDaNLzoKzxVmKaBjJ?=
 =?us-ascii?Q?+p3k4b/VAVZIAX5aC+6mKwOHjUe9Y0wy2gu5tgslpSXGXJDbw6cww0feQp1M?=
 =?us-ascii?Q?miWAaiEEvYamEezpmTI3ZZg1iYupIPaGLVbiTlyhY2SklJAzg1S/96J/tJ/r?=
 =?us-ascii?Q?iRAo6FrbVfKPrOdiHPZ4DGjYovHuE92r3T5aieDV0fwAPvv/d9K8cIzDwGyx?=
 =?us-ascii?Q?7CRsibZ9H9PK1mo5puS07Km+rN6L9+XUmhziposRtTV/nDT3SWpgPhc+9Rfc?=
 =?us-ascii?Q?QkFrinMzDQIiEImzuM8N025L4EKmS2XDI10FsR8DcCN5mJSQ964pJI4zjS9G?=
 =?us-ascii?Q?9nJVe/QGMvSz2/kZpdJr3vp00tnuc/MWB2dGi9QyHSjQMXJmNwX15ND8JabC?=
 =?us-ascii?Q?qhrQpvBztsXKVVXoZLahDdFeMYMrIHMTnckFtsf4V9+RxK7U9aL0r2fmp6SW?=
 =?us-ascii?Q?pSFSu7yn3y6pGLWynNq/goVF1lTSFOeUnZkCKkYEs4BunxvJ2MgWUVXH33SG?=
 =?us-ascii?Q?ztDETGEznSua7hyrZkhAfV4ryEfFSEoGCZL3dpk59nAuSg3iuN2RDTeQOzQv?=
 =?us-ascii?Q?sIE907Yterk6mHbkecuRBePu16Eo7HXFuB2xHZYpuOIGbUgM6l6JqkaGagjT?=
 =?us-ascii?Q?h2cW+NzrYBzYSJA238dhOHxpUpCMbFU4JFkOOSUpyWAu3m6mHxgmQYOTj0p5?=
 =?us-ascii?Q?DGiQ5mq8jlkTbaSdF8BClwrUXZYuJL6MwHayu9JoQTu9BsntY/lpAy2nt/7c?=
 =?us-ascii?Q?rX5fBO12SZ8Yy2PUAW0VYhWesoHBq707sh1TOM1a3ljkkT4NHYNSBnWAe1ba?=
 =?us-ascii?Q?BSMSvESbeG8eD7xkkrXv4xtEz7bn9rev4p/UQ/gpaVJiUFIBc9E0ug8immFk?=
 =?us-ascii?Q?YlxZ0IMsaaN3AXTVTDPXitB2tYM4FHZ2rmxIf4PwSwsLE0NAEo5LuiBEB04O?=
 =?us-ascii?Q?nBPHp6gViSRQxUH8sXMdvj6mOz0Fpt75XD9NsPHM4eA10oJHwfpMPQpa9eTt?=
 =?us-ascii?Q?3Q6R/cG6tRZx5rWEZYXsmgBTJuDjNHKH8LFjW3aucPNuWZj7SOgr4JUOz2F2?=
 =?us-ascii?Q?z18SW4N3lI9L2/gMJ6XccoeBSfBXVztj8PLRmgYThFcr9pYwogpjC5tSz3HV?=
 =?us-ascii?Q?B06uofxW54216lojMb3FLguh+Z1MwrrSi7ZRwyCslQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vz/8pVPfSs4qy56b2jdxIEIUEoOjug68BMKtIK2sTzAumZvdE5jlmhg0orbU?=
 =?us-ascii?Q?G5LnsfZAWCp24+oeVYhy/UfUh/AiLk0qGyP8cpoHmb0Jq7Zm/99PToF5+tRu?=
 =?us-ascii?Q?6ofh1jvcTSfrYsXLMqwPAIf/Cz+IlqPejSDoumG8jllSJyr7jbV07Gbyb/uj?=
 =?us-ascii?Q?O9q2KuLZATWJbsXfzMs/wBnMDAh1FfqtcBlnkAbhvcFtXFL6KEMmtNHDJBWw?=
 =?us-ascii?Q?Xfi0CIc3XckDFKT6pB3x1ohiA+HGnc8V8UcsGQhTYDtbt64o5vPNvq6n8CY/?=
 =?us-ascii?Q?9bLcRvdK/98H60NtDebLKHxUYvITFj787hdyKjaBbsKccLgGvblr+ql7U8T6?=
 =?us-ascii?Q?Cs3XQHv2USwjA79zy39SGiIBRJAqkjuw2g1sixrnrucsI8kubzWryI2wDKUr?=
 =?us-ascii?Q?KhBPA90e6zwkRvz+3mGM05VSsHiehAHDMk1sMP7tspto+q1d3F0dJNMsYsMw?=
 =?us-ascii?Q?6XtCM6kOw5mw7c1pYtztHVfgAWngyA/eX0nklXZzmE1elmxPA4JiQYdHeYBg?=
 =?us-ascii?Q?0sQnFqplH8LkWhUh8td8sN/Nwg+hQrr40dkem11lDI7jjXQXALmq+koje2LY?=
 =?us-ascii?Q?IvziW2sfoClcI6a7aezR/ZsKRBPQ2Wg0lmt0aBxMAjJmJjTUZjuaZK8C6HDr?=
 =?us-ascii?Q?TVS8jEn/n0mmIqq1K16kSA8H+2qwxFIeJtBmmmC7TYN1E5h4suHBh+VF94vk?=
 =?us-ascii?Q?qEs4Y3udGVquu2aajebS64P022MU/PDP1PDl9WvewAOdwhmPNS0QoHYvBuYl?=
 =?us-ascii?Q?YsK7D/o8QSPX3NtnimBUDGiGABXF7Hcl/Ou2CCp+Z99AynA4/xfZJlA/9+xt?=
 =?us-ascii?Q?g+vuaxfW3RNYmfggntzF2yVP01xm1StMAVol6nRoMeNK8BOHa1kUzx3htjmI?=
 =?us-ascii?Q?gNsQ2Sp0CREm2keS0zoHqpiBcpz+2SyxmGeyg7zle8xgWWEtbYz7EoZMMOQg?=
 =?us-ascii?Q?XxLdcSg2fbLRnrpFOPmIxYDDWt8WivwU0FigHKS48BwtbNMi13GgAuTEWA/e?=
 =?us-ascii?Q?bUk7xtq4ThoHhCj5OAfaoqUl3i5A+XQCQ79m6PyajhGQjDlGvwLEjmGdyEHh?=
 =?us-ascii?Q?ql9cxWd8T24M/w2C2ZRk7nrm/13sMEgdesdVZLLDeV4mZETt5hVOGLROXQLQ?=
 =?us-ascii?Q?juB2apbloz7hUBeizYX2db1caNT3hUrfJx6umkstzDAHbqy/RmRFZ+J959jj?=
 =?us-ascii?Q?IKKXHpW9/PtcLCY4jOw1by53vktc9nbHzKMta6NBVCSJdqwSSKVMHY9i78bI?=
 =?us-ascii?Q?AkSL1lYYHbYj5t1udGL2MfwQ3FWEUMOrAojNB9NwNixMHQ/fNRpF/xlkXlBt?=
 =?us-ascii?Q?pCbsGzaRpNYEYstT8JFj3PtIGafEjfcB9pq9d5JIGz1uYfCirr1usKjVkOt6?=
 =?us-ascii?Q?g9ir604UCnGm4wSD3xJWvAYJGWv4e31dsXyWkAocAixQHSz5tCzEf80OOX7m?=
 =?us-ascii?Q?mWqIxcJ8h5qSZO07SrnnbX/BkFpaY4f5xGERgoN5IBYV8DBUesVJVulnPr49?=
 =?us-ascii?Q?kHDTl67SmRZhmnkzS7QWNZf5u8M6rm3v8Mmq6PySNf3fKC9dLd068XS7FYZB?=
 =?us-ascii?Q?oLAZDU7TJ4QSTmVBMCUnUz1emDQWnjuyyJX/PfqqOTW7j3Fcj7qjEyhoKgCo?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5dc843-9856-40f2-b7ee-08dc7f96f1ca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 04:22:25.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln+rn2C2NzA8Cd9+llzh/EQEe6g9EUnkzDAtDJQQ58YmALNIe24vEdAQ6GIm8vC0elx83VGvdXGBrX/r4rgGOpLzvYjksgJ5YQfIV3PPSUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7739
X-OriginatorOrg: intel.com

Mariusz Tkaczyk wrote:
> PCI subsystem is registered on subsys_initcall() same as leds class.
> NPEM driver will require leds class, there is race possibility.

s/race possibility/an init-order conflict/

> Register led class on arch_initcall() to avoid it.

I assume a later patch selects CONFIG_LEDS_CLASS from CONFIG_PCI?
Otherwise this change will not help.

Another way to solve this without changing initcall levels is to just
make sure that the leds subsys initcall happens first, i.e.:

diff --git a/drivers/Makefile b/drivers/Makefile
index fe9ceb0d2288..d47b4186108a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_GENERIC_PHY)     += phy/
 obj-$(CONFIG_PINCTRL)          += pinctrl/
 obj-$(CONFIG_GPIOLIB)          += gpio/
 obj-y                          += pwm/
+obj-y                          += leds/
 
 obj-y                          += pci/
 
@@ -130,7 +131,6 @@ obj-$(CONFIG_CPU_IDLE)              += cpuidle/
 obj-y                          += mmc/
 obj-y                          += ufs/
 obj-$(CONFIG_MEMSTICK)         += memstick/
-obj-y                          += leds/
 obj-$(CONFIG_INFINIBAND)       += infiniband/
 obj-y                          += firmware/
 obj-$(CONFIG_CRYPTO)           += crypto/

...which may be more appropriate.

