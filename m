Return-Path: <linux-pci+bounces-19780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62997A11400
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738F01640B0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775311FC7F6;
	Tue, 14 Jan 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXiTsAdl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEFC4644E;
	Tue, 14 Jan 2025 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893449; cv=fail; b=eIqBxEj9nZ2v5YCQu5WiVVVK3pbj7uYhgmOg3NwKr+QPR1G5QVS6jh45TCR9juAAW7RuCiRuPt8v5O5CGv6sN+GXzn3xLeqNbolmYbDENV8NnZ885CaM5EufeQb5jaqH8RjEgTpqODN2ipUjGk9i9LMD5jzlxNVtu257ZmuE4rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893449; c=relaxed/simple;
	bh=dat4fwJ8XLpcT/zo86BULVIf2wQ6z4KEv3nTBLQeeaA=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c1qUDE8EV7gIM6X0isB2QBxid8HLkQGINjkKplC+gmgwlFGL4LLlSK6kwAJmu4KehabByUBV+8AVNwCa5gUBn15NX6YrU5DW+Q7vnAriXWkKUhqpJphXDYnssGzs5ESpkted7M3VkbvgPstoGWMzoG+9dpEqNR3byDE3CAiKdUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXiTsAdl; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736893447; x=1768429447;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=dat4fwJ8XLpcT/zo86BULVIf2wQ6z4KEv3nTBLQeeaA=;
  b=jXiTsAdljtn6YN0EaPHkuhwJXRjZqCgU3NOnVBCADTLA+fKsaGFkpslG
   czImtPWcvSqXqbtKbRCyTBNPG4DKhkr6M4PVGWRTxorvY6xh3QffRpLwC
   vftSVhhnQKTQrYZvyufQWTiU6p1lttCImM7/NcNZC7YoDmO9eXOxQ7BLh
   NMTDRr9qgzrY1Yzq+ap37jtvXAlbrOSa+PzdG9TZidquefZtauHzbb/Wn
   evIy2qM9vr8oVti8aqwJv6W2X206AYz5eCiX4m3wHa6XnITqFT74OWNMc
   1/8H8HKYHwf2xQOqfcFaDoy548PrZvSlUjJEwsHXkJk5/Fk+zZoBAXaK7
   A==;
X-CSE-ConnectionGUID: nj2kqHcCRgaom0bOs8LZsQ==
X-CSE-MsgGUID: hWG4u+CSS0iZFDdtff5DzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37236897"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="37236897"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 14:24:06 -0800
X-CSE-ConnectionGUID: UUK/a8i/SOyfaSg53Di5Ww==
X-CSE-MsgGUID: Ift3ttgMRjGubAF+XHsRsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="109912101"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 14:24:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 14:24:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 14:24:05 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 14:24:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ol5DLQW1NJdh/Jezm1G65lsRx3NogX6GUCzOYPCiHg6nMz7npkLemBEBDc2Ovh3M9rApjgeWxvwO1GYMX+/apc22qq7tt+N4Zu761KacY2+Xhhktp7QNVJA4kdBiKiDILLWGOSQVjXTxX5GfrnHR/jOOCrqd2NbINJ4revQu2UPz3iNTg7dEN5JNm6Si3X5A1uBJhmLzJTOoWMw3uNYeLg3mW53kis/i/jFZAhVxPQVWlRybIDv1GA/EtIem7cp4coLxCT2gBnIU9EeljRkF0PjSPOq7IM0qiqJHdcKeaH7+KmwXNIRhZ0JYRI4cnskoOZcbm8fYL3ZgoXBlrDH2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ5yp8oUjeCr+vrnqS34SgQND3icF5x52YAe9fh8Wm4=;
 b=jHL5KoBPtqKaRIc1FreD+iuDNerpiveQdMYP/56Wzwl9WwsJYAQ0/bxYf6d7VWgtRRz314IMXYGC6GrxzUfhDjjGUCn/sc2JHKif0wi3c2v5neJ4cZ7s3a9Tua/CIQb7BmoeoXSn22uFswnNVEMvLLxwUB8TZnXcBO9F7P0WHPK4aGVzvUTqDX9CyM0K5WxkQfYDIg6hr3wdEN3mQO6Gq9ef6irrOf2wLeHVAL3GX5mdBBLmF87vQkZa/N17wIVzYE+yCbAC2mgBXlXRjalyAT3mK3qY0vPLpNOHJkJG3edvWuRUI4iENE+fwvdtn9WCrqO1vT2bzNVtZ/PxeB+E4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6190.namprd11.prod.outlook.com (2603:10b6:8:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 22:24:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 22:24:03 +0000
Date: Tue, 14 Jan 2025 16:23:56 -0600
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
Subject: Re: [PATCH v5 12/16] cxl/pci: Change find_cxl_port() to non-static
Message-ID: <6786e3fc8432f_186d9b29414@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-13-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-13-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:303:8e::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b925169-10bb-4084-073c-08dd34ea2664
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zbnaor+19edHq9fNB/VQlA5Zf/2C2Dt3NzmDI6gXMHzII6DfErhXIT6et6dY?=
 =?us-ascii?Q?p99jsGoEt6Jl1Tw58oxRlLpGTYCgXClRNK0G5nco5GEsedzWW/7JmBHf1ckz?=
 =?us-ascii?Q?yOX9etCLK4XGWfKY6kLAV5jk7Mr6p/9QdNjGrSdXc9ip2Njxb7NpftyusO5k?=
 =?us-ascii?Q?zytSsYleulj7w0zZe5fZkQ/cpiHDZhYJA+BVnuzyGM7RlPW81AXEIC6It8XE?=
 =?us-ascii?Q?M51lPRXLRWSdEc1WRibFMBWByXuDsYZOg+GX4zKSfSKEvJfE0Q6usk3GJhvr?=
 =?us-ascii?Q?FBcSFTJ29ziwlYii9t+2Xd6y5eNx2Ro1Ls7LaPByuQJXzf+qBA67Pgp/i6SD?=
 =?us-ascii?Q?8I6zYJyIC847wSMjTDOE6V3UmBHU5WUJ+1LAF5eqQJx4zhR760QufRP2LklD?=
 =?us-ascii?Q?g0xO9QtNox+D5QItbYEe3EYAHGIgqdTl6nprApqYDWGtcdMlwYr/cUSciUlO?=
 =?us-ascii?Q?TqQJQvLn+brbWsSxhxNB8nGPTFF0py5XdadBpnLp2/K6NB2HJ3stOQ+3HVgx?=
 =?us-ascii?Q?oEpDXM5XmUGt8tibJgmJrLOUBfDOuHV1Oa2zo69jllfKQe2bPjj7UUeIq89W?=
 =?us-ascii?Q?9wvISsruYINwyWRpf43HVmslBD8XpZ910e+C+MFOP+/wNdMtm4b7GRiFza5H?=
 =?us-ascii?Q?oaJH6/WWSXxDpugYbzRZdrDsyk83z2J6blovkxU4LRKqbb03/HIxDxwKXdE+?=
 =?us-ascii?Q?VSXTCveXOOdblv/hEG3qEhxq66kOlSjdXEaOXChjsy8eozZfZBTRW+xCT1hx?=
 =?us-ascii?Q?m4aLX0uks3Q1A9FPZII8tA1CuXSntBmUJeHjDxyzRLdGtuaeMJ6g45boBR+0?=
 =?us-ascii?Q?OrBI8Ax905kHjmxs4a9yPisJONZ72beeF63e54fQdqNI/1b4sSMK3Jzic5UH?=
 =?us-ascii?Q?CEpMH6eUvrUVn4hSjeKrPJ8wa41CkNpt8uXG9PzXwEe5wmtRdiNMTxqSy9Dq?=
 =?us-ascii?Q?9b+/zR31y9GCxkUVOsWktp+za8G6xPZ187oaTUFRR8l0egzQPbr0gtFft2tx?=
 =?us-ascii?Q?MQgEgxDses3am4d6hWZKf0HOQ0rQgjUEGWzJW2yDguEyjNPo4TB6Lb08boK8?=
 =?us-ascii?Q?Q6xSS1vmvPNW3vHNVGSFxHwUN4isarJdAQ3+lGEnaxW5l0SFR9k5bPug3/T0?=
 =?us-ascii?Q?bnOhHEbippWigWbQ3usgavLVGRA8cia+bOZpusn23Z5VMd/QXqcHi+yWKe9v?=
 =?us-ascii?Q?fMpoRtAL/wpgtO6EN6xeydm6cVjp2Lx2bGGRyTKrA2vpjk9w3It5GnZZCw5o?=
 =?us-ascii?Q?taAq0tooHi178OeWhaIp2zNtVQE2+il5aIqAlzKONk5uASBWGA3T1oJ2qoWy?=
 =?us-ascii?Q?tCTlx5yMi7WuctLbYsO+E+9+pq2MpnRIoOc7Oqy4K/z9LSok3RuGjm/pt1XQ?=
 =?us-ascii?Q?DYPgxlDUr3JpcKbBT/1ef2rKgdhhJXjhFCVI74pBhRoNZWBp1etXVzik6T9D?=
 =?us-ascii?Q?yPz83vjY2QI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zFx5J5a40hUjdzPd9YDckyl8H5mXRTh2yvcy40JhP/6UMo482j8/WmVh7gqn?=
 =?us-ascii?Q?MubbH14cVi1rpq89g4i8zcWhP219KJmasysHFReTk2PmhzeWNViX4NOjyfAr?=
 =?us-ascii?Q?zrYPoxAktvvgRwzh8pn371Ztb6xPA8f4VINAo5iDaIL4XjUQmp1/mvZmdF/1?=
 =?us-ascii?Q?ldbMx5jzM/BSooki/rCHlkNV979rgM3v4uYpEvNXx+NglI/+yr/c1OXXItl9?=
 =?us-ascii?Q?39LBMxkwwZYRPEmew2x1I2Un9UKI0K3XqyaaKk8lzjZnMRG1gR+tg8DNcJxC?=
 =?us-ascii?Q?wORL9603rMMJPcfhxe97DiYZ9oqdgqTL0dQYETyGajhxna12BGpXJYisQLMf?=
 =?us-ascii?Q?HEOOBMOFxJ1QqrsUSr+DEzyqnjgyXTsarBwr9bkSj3yXmHOIcKGalp/OH6Nn?=
 =?us-ascii?Q?B/pViFstwA2V5CLaK0wUjmbYx8938f9jLjJqgwf+PtBoQ30ov8owMB1R0Okt?=
 =?us-ascii?Q?3c9759JT7bWANRgZo0mMr/HM38fCbmiaApNDHOESwLQHHvuWgrD3RNppx8h3?=
 =?us-ascii?Q?FHwfW5wHPNsq+0FtN/yX9O9Ch3yUzUJOZdwcqBEJ6D4KKQ+BhOashSjjAL/1?=
 =?us-ascii?Q?+szKhlTODvz4i2AO7fvD5RcIydmoi6eG+FqafZA243ERHVg6SXGJa9K0cRl3?=
 =?us-ascii?Q?y1xATLKC0ruOaLabs42vcFVtPS9+fC4O5IEbrbVyCbEMpJX4HIg2/uDm9reJ?=
 =?us-ascii?Q?oosiYZRfRrRSKQhPMH0t3UqkdfjVcf0M9hxeR30DC/k7W2vRfDon/1EKr/aD?=
 =?us-ascii?Q?zIM5URa8vHO83oksBhFws52r9SyXsOEtGi5xXowSZHhHS4ECSdzGMFsYMOGc?=
 =?us-ascii?Q?9ESxidFO9Ixxuj4R24Ky1/bT9bLxdF+jssSm9cnDfkUtbtUqN7gFybXVM2Wk?=
 =?us-ascii?Q?jPqHJWQaQeN6MuWaniPcUnGZdynd8x3aT5Bt1R7iNKbA242/axxg+zLuMVU+?=
 =?us-ascii?Q?AovKH6Yv4qQNywz10WbGtQ7Zowutv8vOkyiBrMhL7traIA8rE8DXmuBEV5df?=
 =?us-ascii?Q?+OR5hbhqWmSLTP5nADd7qhKlFpT/VzesOwKrzS/teGPsHe8OD5O3i2SCXa+6?=
 =?us-ascii?Q?kI78zTyCtSHIJ2V18MySU/Oed6npP+cmmIQKoXKAK2d49ih7BjcjySHhbK54?=
 =?us-ascii?Q?zKjCNLY5j+cz1FyuaSBQYs8hoWYjXlydgkCLqvUOP46IbNneHuh1uQjBVKWn?=
 =?us-ascii?Q?cRFFq1a1K2VCdiFjlLfSHODldepfmFbvLJjVuWVKOzdSn2527lJzY/7qK/Is?=
 =?us-ascii?Q?3T2tGJYp1i5zOQQKOUwL4hMWmOflY/mZKjeP8yRedJlQaJxd+YgFz7x4uPe+?=
 =?us-ascii?Q?v0bRByFiTugGETZCDBppS8BvDdYNXb9+QykeKAWGKVFrmixOa+wJHA07VVG6?=
 =?us-ascii?Q?W+dUYOotC59vR6l0xhpdWUtqaGnfumbESlMhTemoJVNtKmwOdGjiWfNL3fqr?=
 =?us-ascii?Q?G8rxBbnPqG66T7/YIYco+c+XR2MJ42bN2bwjcwb/FHzyqhd5teVqOv6Jwf67?=
 =?us-ascii?Q?sxMxUjWhWSfz77WpfHp/1wjqlGi+Alxn5HejEDVVZACWjKpTdP7Xix4A3FS1?=
 =?us-ascii?Q?8oJPSEXmzbpdavqcq7yT4EXI/RHs6aKqtqFB2QPT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b925169-10bb-4084-073c-08dd34ea2664
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 22:24:02.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OkLK882jiVx4UG04CnGLmOGvMKzM98HQ2L0NwkagOLLPvbtoA1CcsC4ZSM2SNnBKxI40Og9udKc229xpUAIuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6190
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL PCIe Port Protocol Error support will be added in the future. This
> requires searching for a CXL PCIe Port device in the CXL topology as
> provided by find_cxl_port(). But, find_cxl_port() is defined static
> and as a result is not callable outside of this source file.
> 
> Update the find_cxl_port() declaration to be non-static.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Generally I think Dan prefers this type of patch to be squashed with the
patch which requires the change.  But I'm ok with the smaller patches...

:-D

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

