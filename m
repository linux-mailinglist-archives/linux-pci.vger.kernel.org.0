Return-Path: <linux-pci+bounces-41430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DA8C653E3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 17:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C64EF4E1FBE
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995E52FB96A;
	Mon, 17 Nov 2025 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gz3hrKUE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB35C2FABFB
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398237; cv=fail; b=Pn/14IAN902OjRMjoqom4TYHaQvtB6hzZKR7J7dxhzd77fRD/9qirTD5xGwlkRtLTlzwpMPYe0cCBv3AuC2gCh8Xrp49AxuVlE/NIOeSgQCiB02PT8hUVtTGutyDiRKyRjxnP2vdiRzkCImCOTFHb2bE6ymz1USrdIIhLJbC/B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398237; c=relaxed/simple;
	bh=1ZBJ1T8b5zqmAW0ErUTnTZ3RDRIeUBEuwLehNKxm5S4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j9gSfB6OBBUv7oSjpLCAuU8HIl/ZcYsU/cIJKOrB7WR381rZy8pnDeZ0+B2vSmwb6wLsE0nyO/ZLO7MDgl421ZpNt522mtTBzeDxnNgC/EqeOKXhFGYKwm3RiaeErxaIt07QOOhJyEXo7UmYSp0c8AX8HlF7m+xQPv6ng6ofZI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gz3hrKUE; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763398236; x=1794934236;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1ZBJ1T8b5zqmAW0ErUTnTZ3RDRIeUBEuwLehNKxm5S4=;
  b=gz3hrKUEwgAeWa0ySHPttSJZtIvrWBJEtIsRa01H+k1hwLTZfXLGbGjp
   GFQiAXo78IYpra40wTrHAmh8oc4oNv8UMNAEOSpmuBh9tZBlHC+W9a8Oh
   0ypIv2FMyVqOSdKGEYDZ0Wme5Ty9F8zkKLz8PcIanNSVHhN8FajnMiT7D
   4lnFeAIweUqUfap4Sttgdvh+VHOgcSWvncBBHixR7fPsIQDK1SrdojWqp
   2AKkZ92HZ+GrmgA12yBIp3QRalriA4pqU7nwQa6RZHpPSIQgnHUzoSIQh
   jkzL3D86QxIhXVvU5SCBOaqXXzlnK2rj4qDel1CJaSpSb7mcFRzeatGFp
   Q==;
X-CSE-ConnectionGUID: +YZp8B1bQoW9x+/VKwK+rg==
X-CSE-MsgGUID: A4eGO2bsR1Su7LJ4CIqLPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65336604"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="65336604"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 08:50:35 -0800
X-CSE-ConnectionGUID: 2vrcjreFSNm9Pgvm1DPRsA==
X-CSE-MsgGUID: 0choUGaqSvCtb+dDVTY7YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190300815"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 08:50:28 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:50:26 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 08:50:26 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:50:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehYcNem5b2/9FzvvzimN7fLjYkyWFajQIi4sF7BBrIicwUtqSin2HYKMKBG6Sw9HqH4pUQ9KFiEd3m6xNm09kbmiHjWKW8zmgk5tlDL9t/m9d6aYMNU8xp4EMyDeKOefQAyPd4eQCThaqzicMJQzgkIlbbxzZLoYmkB/blvuIRlZcXMyK3HiikDVQctYSSKIW3SGu+yfH45///w3s3q6GcuF+STY19t6Ya4Jni9FNAlt8wHdjYhzfS82oE/hyv59BQT8f/GNZ2zC7MK8mFSeiBVuN3koyxNtEF2iTVEcRZnBV9IR2VPSZhVAHcR4qAoDPMxUdCpYGtCj8PEfAEQcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PVmmF+vuF3S3DQSJ38FbAur0iu/WRJZLofZVZCvcUc=;
 b=q4ozItAhIhAisQtM0BYkiI9QkmV0Q9d6JsJrOGoZYl2sHm2ImQEaq52sWatBxhE01h0piv40s25tzTbc0IdCExTEGOKiS+OY3ZFyfq57VnJLHsW+xVkq29uW4yV5LHxh7DnfLMG2fEUcNbodNkov9+88tKl9jqtwJZGKMr81hLiWXAEwppcp4LGwLJe90HyLM/RveAQqOAPbS9f8/SKvDQaRqL4hqf4BG46p8V/M2ozEQunxOhQ9xcHjNusDh7+jKz25U4aRKo/j4cQWGyfCAjbmc30C4DPtFgY0LylOVvJ4ymki3pRdBDWbon9ndGOn9eTY+rv5aPogsnum4DDYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA0PR11MB8355.namprd11.prod.outlook.com (2603:10b6:208:480::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 16:50:24 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 16:50:23 +0000
Date: Mon, 17 Nov 2025 10:50:19 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: Matt Roper <matthew.d.roper@intel.com>, <intel-xe@lists.freedesktop.org>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>, <linux-pci@vger.kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Hellstrom
	<thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 2/2] drm/xe: Improve rebar log messages
Message-ID: <gkyss5d23bsdeqclk5y5e22hi36n7eesoig5arlgjj4j5wzucn@lxowwjegpg56>
References: <20251031-xe-pci-rebar-2-part-2-v1-0-c4a794a39041@intel.com>
 <20251031-xe-pci-rebar-2-part-2-v1-2-c4a794a39041@intel.com>
 <20251114215621.GT3905809@mdroper-desk1.amr.corp.intel.com>
 <af1b8517-a48c-0826-b02a-db102424ac8a@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af1b8517-a48c-0826-b02a-db102424ac8a@linux.intel.com>
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA0PR11MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 570c1c1f-69d0-4413-abdc-08de25f965bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?rYclTBFbsCCkPodbU2ECxVa3d82Hkx0wlNV6PGHQO02baXQQZlAqL55I1/?=
 =?iso-8859-1?Q?897uIj8SjVKLxYlpA/nUq46mb/QE4cqmzfMKzSey3E8k98K9JJYdRoTkIk?=
 =?iso-8859-1?Q?EUhj6RIxXsNNm+1DD2Qbg1Z04Ej74eBEao9bQXVSZ3BtGlqdwEoJWH5mbL?=
 =?iso-8859-1?Q?m5tkwbCPjEuUHpLfx3S25AOZfla1SEai7Fi34IkhF/iaI5nDSjN6SC1fNT?=
 =?iso-8859-1?Q?OLKz1alNs1JBIOIRM8AJnAiWjjx/XyVXQ5r+A29icJygo1NXuLGpvMMjos?=
 =?iso-8859-1?Q?nNtlBIKrkIQJLlkumOHJLms9I9CbmI1HOGuhJ6uWpRhTAscFWnquxuqx5L?=
 =?iso-8859-1?Q?+0OZ956LF0eS41j//AFuNz5kqMxmOC/KpafR7KnXZfjrQPUEyVIf6Ov2tX?=
 =?iso-8859-1?Q?TVQRCm9WFi5rJ/VGjix+qLJmCv1MZuM6wxrEWiSxzzA/A3wwyWSdi0s0ii?=
 =?iso-8859-1?Q?px3CXtBEi0akCAnX68tIm5REVnp3ouCjx130zgd+1rhNvpJlDmY0aRpSn6?=
 =?iso-8859-1?Q?BZ1xtTJy8SvO/T49i3jGAf08s0/XNld+p3Vn9PzB12kY4KnTOUhREh6+6t?=
 =?iso-8859-1?Q?UhSQmYRWdFwSbdOVMJFT0iLPiIPV806a+8LGZG+LXRR1/l5ZO/ZIxp4Oe7?=
 =?iso-8859-1?Q?jHo9pcyyZ8TziHeJght3nLUPY6EPjfPez1RxZI2mjyIpLWSYD+iMu7MsBA?=
 =?iso-8859-1?Q?EEaG8L1d6tpCWN+lTr4Ms6e71kglC4/VC5t4bAzLUj5Te/0BzwSpi6n4AD?=
 =?iso-8859-1?Q?4whginF8oWNaVX1vLnpta0t7ZiIzJSUzjPVGcAyWJJZlvK/x027UNxzOFq?=
 =?iso-8859-1?Q?SrJVLmdqShUS9wua0zztA7WGJSNXlzzLzv77BwMpqRxOyfW/Wm0drGp6fw?=
 =?iso-8859-1?Q?6zf5RlO3JnGRmEgM0H/IC1LRiHMEb1b7kl5KUlPM4L79U8AReqpg6Stu+G?=
 =?iso-8859-1?Q?2MeuFr3nHxZY+9D5XYZTTP8+jW10miRw5x7RAOcTsfQDi4L/9BViVWWqgY?=
 =?iso-8859-1?Q?DdHIzkfahAGifwh7FpG9KYf2MR2/3epleZDpq5USIQ7HTkCpMk2TvFwimE?=
 =?iso-8859-1?Q?06qZmMp0ZMlSPzBc7vVu2AkVT1MBgQ2ZAbjnBexaQxF13WwNYUqyXq99KJ?=
 =?iso-8859-1?Q?yH9rtLOZfBoGbuHaWJnO11YUsv70/BqST0m2G3i5z3GPdpyKUcyVrzJenh?=
 =?iso-8859-1?Q?7blFl3ZM9NZfwnGrJJfnHKGPd/TIDW3h49Q2jQGEzz8tOP8uENVhXPZD4i?=
 =?iso-8859-1?Q?sxsu8mLtIJAZvT0c8MhamrlGwujoOIIInh6JAITA1MC8/hqc03fN9+m9xe?=
 =?iso-8859-1?Q?qZHmOPE8tvtECrwIFyOkiy1QiAlBiAukbFyY0yZcHfM/Ua7Ipv1iGE4Qb4?=
 =?iso-8859-1?Q?CJa5MOIPjBkrnv4DODUjaqAzd6VUW+KeT39yXLJbVodSlrOvx91F5sZ+Wa?=
 =?iso-8859-1?Q?XKW4u4snMrAmIaJWx6g/sJMGqDo0eCVuswhcuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Zjog5qnz3K3kTOdFE4vZp7Wl0gGNQGSgrEIkgS9a2O7qmNukiWfjBfJkr4?=
 =?iso-8859-1?Q?KvBkn1KPN7g58w/51lLrjzqGyNQLWRT2Vs31VIg/fY6IN6KUy8OBhdRDmN?=
 =?iso-8859-1?Q?dPY7XB10HPics3C+MvXldTXJt8PpVPKB+3YwaMfJh17cwMSqtzcwLr4xVJ?=
 =?iso-8859-1?Q?H9MwVTkveNoQRRQMID4TsxzH8K2eiF1z53hEy93nJ8USCVEuurRN3GglN2?=
 =?iso-8859-1?Q?BEl3N9IOzkmVT9mWuVqyd4KapGd8u5ZX5cV+ZP4nn4kleIFOG4amdolyBO?=
 =?iso-8859-1?Q?Mhy9xcUdUr8hoZsPNOYBLISl4d8+lUn+D9k+DQMeqYSQNAvBdN9+EFohvI?=
 =?iso-8859-1?Q?j0wX1HI551kuCDoFoPbWGwzZ814Z6IOHJ/YY1vQ6ehMQwqF4V/gfJRJ5u7?=
 =?iso-8859-1?Q?QF/nQb1bc+2e05sEmPSVOx2gm7LZvQJ7Qx8psKQkBSPmTP7AEaf8jiSQw7?=
 =?iso-8859-1?Q?Ed6S2HgOfRqBfJ0l+kqCXMfXGBBioWf3SFBK9a4iv3Ttbp/bf5lQTvCAfM?=
 =?iso-8859-1?Q?+5iLHrzMxiPYaySL2jwNoyuqrTAny8Syg4g9U2iRig+gAkuLtmMFDNGO1l?=
 =?iso-8859-1?Q?QhhHvBZF797/tLZy0KIVdjsxPi03JX8ANmTvGv6FSCLVqO3GBTszqz1qPt?=
 =?iso-8859-1?Q?1hHxJIaeGpI6VVtGUOAdu3/CA1srfkeU0xljehUXTTs5Alz0dTgGrVK4tY?=
 =?iso-8859-1?Q?FeC4g2Yqr8t2LOsnPz1t1JeJJQ5E0LDaDfpN+fmtUzMaPZ8rLactlBJ7Cd?=
 =?iso-8859-1?Q?pXcepC5fjh/DRJkeQXFzEIONNJll9exaCEd3ATgRFk1KmVr6h2F+JH1mMb?=
 =?iso-8859-1?Q?AzRf5tLeUxHBreecaIl98B58PuKQMrsVcEq1g0mKe183vhI9GJALq68TAX?=
 =?iso-8859-1?Q?KBzvxiS448KcfGHargShqChGdlBMffiv5X8K8u/LVyhNNgMZ6Vab1icnPK?=
 =?iso-8859-1?Q?e3PLaGBIcCE0hApZoch4yYgkHH3QFpdDnEKPG++BW54lkXqgg3G+Zo9z+O?=
 =?iso-8859-1?Q?tgIgydwB/uqIOEIKrz9mWon/3wfREwpoq+06PRRA3okoSazqACDIpCOxWv?=
 =?iso-8859-1?Q?ZeTsd8YRjl15HRbyLfwpSOfk0yTswJ/eKga4ojFBRkZLKHyHX02NOczwwQ?=
 =?iso-8859-1?Q?VNbA5lwVGac7lyXjB/P7ozXHrXotJmDgOhf1F4FBmwdwu0adzMk3MI/xum?=
 =?iso-8859-1?Q?X6AYpEw9XaOFkd8SwfS9D+/y65eGc5og6hMgbz0g644vDgzDYKPkwdkKJo?=
 =?iso-8859-1?Q?kdNTeoUEeRVEyia9B1DOAMc+d+ngB1xCTTtpoUBRsPeY/Vje7w+t3Aaaf1?=
 =?iso-8859-1?Q?sTGqN4oUvgy+oaDFGS5KX7fKLGLmbGpQg6DhaiuOFPbw6MEjdomVjGAKWr?=
 =?iso-8859-1?Q?xw9kTxHGUOZPsgYJkMiAGdwcDYCcSRGfVsyaeZl5F1PGx56cZ7SG+eX5DZ?=
 =?iso-8859-1?Q?EOxjWtx+6b3hC7GPP5TzXKtHSMX9bKfkmq0kAddwo/qu3ls1XqiAf18zcs?=
 =?iso-8859-1?Q?FM7btgp8ZQW4HLljqxMk3RXlDiTlld89VAXStUkyMNu9mR52nBnio9btq+?=
 =?iso-8859-1?Q?mC2aqz1wXFejM9Bxq89MEySLubdoJYTnw97U64BbgPD9O7gHPjqLZFm83x?=
 =?iso-8859-1?Q?N/XhVBa87R8orNaJqcBQx0SYVCFVJDHsgM/S2apx5QOhLJddEpP1wKeA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 570c1c1f-69d0-4413-abdc-08de25f965bf
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 16:50:22.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KunP1sMic7pTO9O40UmUdczDh3yMIp3Lm5QN3aImdEGIjg7togrfn7lJo3hctr+wEP2hpkAIbl7vptnCGP5AvdpUWOzMm21Rdyo9zf6r0jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8355
X-OriginatorOrg: intel.com

On Mon, Nov 17, 2025 at 11:34:20AM +0200, Ilpo Järvinen wrote:
>> > @@ -93,9 +92,8 @@ void xe_pci_rebar(struct xe_device *xe)
>> >  		bar_size_bit = bar_size_mask & BIT(pci_rebar_bytes_to_size(rebar_size));
>> >
>> >  		if (!bar_size_bit) {
>> > -			drm_info(&xe->drm,
>> > -				 "Requested size: %lluMiB is not supported by rebar sizes: 0x%x. Leaving default: %lluMiB\n",
>> > -				 (u64)rebar_size >> 20, bar_size_mask, (u64)current_size >> 20);
>> > +			xe_info(xe, "Requested size: %lluMiB is not supported by rebar sizes: 0x%x. Leaving default: %lluMiB\n",
>> > +				(u64)rebar_size >> ilog2(SZ_1M), bar_size_mask, (u64)current_size >> ilog2(SZ_1M));
>> >  			return;
>
>I don't remember if I said it already but this will cause more conflicts
>with what's in the pci/resource branch so preferrably defer this until the
>next cycle so the between trees conflicts are avoided.

I submitted your pci/resource branch on top of drm-tip for our CI[1].
I could could rebase this on top of that to have it ready to be merge once
we have 6.19-rc1. I won't be around next cycle though, but If desired
someone could pick these rebased patches.

[1] Checking the results for xe and i915, I don't see any regression
related to these patches, so it seems good from our side.
xe: https://patchwork.freedesktop.org/series/157585/ ,
i915: https://patchwork.freedesktop.org/series/157584/

thanks,
Lucas De Marchi

