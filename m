Return-Path: <linux-pci+bounces-13127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA570976F4F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 19:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8031F24247
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3251BF7E5;
	Thu, 12 Sep 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4GL+h3o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116E14EC51
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161095; cv=fail; b=cP6ewdAR5aVqrljbqp+5284H+D3HrOo5Q0dahO0vZCDLL7mXlcEtwntiDL5axzc9hQdIsJ8vhnA4JAGdlPFn3QHrohTUnhW+cjpGq4irGNGQx4MO7Z+tFq7OPrjkUv2Zk8VLwmSQO77gwQCm+JsU3f0QQPIXjGU4DminkuIN9uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161095; c=relaxed/simple;
	bh=neMx3SzZ9VCco+ywSAoe+34CGP9c2VkbyY7To1cdP1g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CwHgj0kRZoeQ4PhA1BxxC7px/VXTpt6g825mXPUckLAKsaPrDYA3usFibcVYKqnDvgligets0dj+OE+t8DAvOk12VCqmSLy+Lzij2lcCsxLWpqWnb1/AMnFZAWwBqZ1t+shnpMhzWzBw/wDrqByGpXsCYvdeo2DOU4sw1qoESrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4GL+h3o; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726161093; x=1757697093;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=neMx3SzZ9VCco+ywSAoe+34CGP9c2VkbyY7To1cdP1g=;
  b=j4GL+h3ol5AK9t9qqa1zDZ7zo4U0aJiYydi3UelXQy0XPSSDprvk1X8e
   TS3tHpaDWjXbE+nh+Q/sNkQRugNOaQo/g6XsGcNHdop22RyFnm6cpY2aK
   9DrnHz6kJCBN5Y/FwZbSX0IeHVh+OaDiPXnu/3/FznN/R1fYO8F9sYg/Q
   JjSq4l7T2jB6N0/M/pQsN/Qq7GcuZqbOvzI3BAh4G5vYulaNWsGfMuSxC
   T+VXjYQbVXu4N1sB7gPX7HQMfeRFzu+h+oRQaDWfh1xvBpFTUDRRdVd7D
   LNglM3ZYom/zLeXOt+GrhsD5jOHSRQcDhXR2uPqVykvIWqzUQgA1ri0zq
   g==;
X-CSE-ConnectionGUID: KpiYKxEiQq+UYC6z+uzSxw==
X-CSE-MsgGUID: DLN4PSU8Tdy/WlyDAnA4Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25227329"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="25227329"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 10:11:33 -0700
X-CSE-ConnectionGUID: aQ/NUFv0QeakxYUygPNZww==
X-CSE-MsgGUID: n1VeHLSvQemmDO3aSZ0IZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="98471552"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 10:11:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 10:11:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 10:11:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 10:11:32 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 10:11:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F14mE5UjO8bpWq1katRiJ0RnMlp2XFQG7I3CLS9rI3xiRyq1WHb5kXbGSHAo4lQFOH0gTRFXc/BNi5eVKrDeg9sDNIRbARrW82kmflLPENwmbvmlvkWccZlAKfkWYzxmsLNSJ0kNXaGE8j7/1fSiiCp7khMaxjsOxUmDtquAwIjjQez7VjMU7wzPwvxu5Y82P0BksYNPUWRSUqAzGL9z0SVa4biua0qKG0L1GX5Rxq89VXMTLC0ahxCKNczZZ8Skt+nK+CguaENZ/0bxk+dukBX0aF2GR8kTMb2p+dsuxU8eQtNBsnQqOxPPuNHPfBDCmZx7lCw6eL7rIeiQROz0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEkNAYcymaZcBJqFLDwwlNMYP4yEAJyQMosH8s5mDDg=;
 b=YuRtpQC8SN1PF+22p8UPld0rrnmXLrfZ90W/7SzYrHbp3nnbb/77+u5/GGCfPEoBx/8P2oykT1Lm/DT+sRFozZfAkA3Aw7wNtGCwkNdkWQoFPyDeuNz0U/1K9OHUUeEoQ4OKgKftZ60t1sWNv9eEpZuQOieR5GBEEjB74HyaVzYD56rvV4l1iteMm73OYk0DjT5koBVvRLBAz5vf2qBrHGBhVCB7gWB998lUOdConzW6bNcIOuO8ed4FS59FZ31uHkuuG9Hdn/1w+hBODKgjkg1nM3xn2MbKcY2aZIWZaV5+a/X3VHgm9FJm3uPRhKrpVd2uxOQ146LBHanbDOVtCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5899.namprd11.prod.outlook.com (2603:10b6:806:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 17:11:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 17:11:27 +0000
Date: Thu, 12 Sep 2024 10:11:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Nirmal Patel
	<nirmal.patel@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, <paul.m.stillwell.jr@intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD sub-devices
Message-ID: <66e320bd9c800_3263b29421@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
 <20240822094806.2tg2pe6m75ekuc7g@thinkpad>
 <20240822113010.000059a1@linux.intel.com>
 <20240912143657.sgigcoj2lkedwfu4@thinkpad>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240912143657.sgigcoj2lkedwfu4@thinkpad>
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba09deb-4195-4cf6-a5cf-08dcd34df010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hfIyLyT/TcL3tXZKFW1ANHayIeqp1gOo/cxxLk/It/vLiSX3G5eWw8FlVyFB?=
 =?us-ascii?Q?e72dRc6Ax6hbQfBzXnjRMCJyU9qZThqKEJ2eH8d9IiQVN+fGpyXsnH6QUFYu?=
 =?us-ascii?Q?zA4PGAW+zsvf+NIz+zx5MDT08U7cLTDn4tv5zIJQF/sh+1YaZfi/6TNCrC1n?=
 =?us-ascii?Q?y0W6GlH/Enh+GCy4LOhBpgxNtbMW9hUDOI2cI8xBFGNJT6FW9ECI1TpogIvb?=
 =?us-ascii?Q?SDBXfadEKqoqDUijfPqG/df+7+wKvSKyYxaKgGrzIjnWNruRPTa6jdSxOSSG?=
 =?us-ascii?Q?qzd6sQc8CbYw33nCUWqLYCc67NJGMPylCBQw6og7728CDex0tpbR4io6it6j?=
 =?us-ascii?Q?/bPChQaHZaQti1eMJ7TozrbsxVsMSPpdpTE2IeH06Le33DKFhYOb2lfLS3BT?=
 =?us-ascii?Q?7bz0qbyIUN6vzorjfHBHZ7BKlsHnipym2Z8+5akm4sS65o3hm0ajFWKpjGqd?=
 =?us-ascii?Q?kWjaXmmDxJATLR7m6VShBDmgIvFScLVv1gRqcBYjYmLt0glFwvlHhXMnXJZk?=
 =?us-ascii?Q?DWlu9404+Vx+lUoSNC5M2VRvSIMlsohQsLDQfV1S6g+a9sB7d2cYIgosST1J?=
 =?us-ascii?Q?LIZ5dn6vveVLWeup+ZFtP081eoqbtkLIm+n9BEtU0d2qIOt0UdSh0fVdzQqJ?=
 =?us-ascii?Q?YpgHhvOmuHHT59BVtimWEQ9+T5dyvGV1XrXFeAGTEx5o8zw6282wG/5CHdGk?=
 =?us-ascii?Q?/tj898zx6UwfErKtKZvsBRixJJUnqJqZUBDfpf+QcLTKQ/qxcjW0H+nRR9zx?=
 =?us-ascii?Q?qnzxzn7g1THQWLYRqTf4oDrFTnEGgKaplp3RU7R4eiIUq2D+54cNhDVuYunZ?=
 =?us-ascii?Q?uNzI0c6Ftdba/xUmt7ppus38gw7rv64UohzuASc3EFUWA/3FvqSFD/Hz/2Hk?=
 =?us-ascii?Q?8HFbWi4rJqgusmte4Pw0pxDMIQJjO//lLp6sg8l0FFvw9tAcSIOZUZgLnb6Q?=
 =?us-ascii?Q?MR3on7AQ1xuNZL9Oji0amRSMMYdP7lEsxzE2C1/EFP068dr0f9stKBc9Uqat?=
 =?us-ascii?Q?kuMJ9PJ3tfUDEeYGw+UbBEJ7WRIjdtS/9DXvocX/1oANovwjS9yZnxsHq9I1?=
 =?us-ascii?Q?l575ORwG7jfjhLrWlBYdKoFM/VioI87mHKXT9XvmJzWHcrnOU1evy+gAJMR5?=
 =?us-ascii?Q?aSmrmNMcSa1/Cm/uimRl8eZE1Bi24dF5nstZt6ORC2gbWU4LObFH73rwGNy6?=
 =?us-ascii?Q?HNuabbpxHtUiDpRDjhYPEtQ6rwciNxvExoBX5/WCMfE+Rvil0vJGpnns08Ec?=
 =?us-ascii?Q?OtB2P4Ntl+ZAKxRYLNSAsS92rkVIZPBjQ8KCs0sxrZXTsztBZiSF+kKy2GnC?=
 =?us-ascii?Q?mjxA4sh0CmgB9fbgfuFRLLc8lkkuutEYI+Q7c/NpnUJ/3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aj/RelHOs6YZ6Kr8vCOYPLtMjr3+fbNvwBDYNuC0W6GomDUHRxx/d5rE9g7a?=
 =?us-ascii?Q?noL0gAiKp/cUMm1tClR9sNQY0EEJ/YTTU44FVYIE4LcUl/HBP36tE+zVfbd6?=
 =?us-ascii?Q?0pIeFJWwxdsIPbDWo6YGJTzWvCKxzJ5sxrmhM/09sCGZizp9e9aVahcAY0xV?=
 =?us-ascii?Q?N8OFqNLGRkkFiwtB1M8osJUK7eI0TQAwMXhNrUW92ajNfnN1J13AykNWD+h/?=
 =?us-ascii?Q?7NnjG7D7SH11UPl3BL/dxQhFeNKWc5jc/Z+pAgy0ZxrfwXVNxKOeiooCLfQG?=
 =?us-ascii?Q?B/U9pWGKGgqupw+d0cjEmkM8cKlhnuYNXpljZvHlD55GNwPhxqJ46215zbef?=
 =?us-ascii?Q?FqD3NxCtqVJULNsvz6cRU+EuJ/e5HHudiFVWqA2hAgYkUNrAPleOXQUJSn6b?=
 =?us-ascii?Q?9DX9RoGbcrQc5xaXypmn9VF92dXMsjSFBbjr0RmtghZ4mp7tPs4qInNp3T6F?=
 =?us-ascii?Q?ZRPogeZ3N+aJzM5gEmq2rcrhl53qrXsKz+yg9jWLpkWjhos+rPx2UOV5qYLA?=
 =?us-ascii?Q?8pLMKqBuxIs32zun2VjD2R5bKEELfUB5qDIbsw8DY8rQtDS1RPpdSWJVfDYr?=
 =?us-ascii?Q?59bvZI/szVMfEu3how75ysaYmKeQont5qIemAQSCsHBDszzXO9pUqSFQxgNm?=
 =?us-ascii?Q?69v5+yD/Bj219WqlJYqa88IJUsxWeuCF3CI9uOqvPFeVBEvYvH0fSyT9XLXV?=
 =?us-ascii?Q?CfrDJGkas33roKLZItBFp9x/5CNToXjd5LtVrzLwFF6UGWXU+smVnEe7NPUM?=
 =?us-ascii?Q?Ut37Yc75GfWnpdilFzRVX97IcTd7iA+qAsOPH/Mliy7Ahk6sKfnC4N81xzTT?=
 =?us-ascii?Q?p7jHaW8tySVXef/wxas9nlwPezh858uiFFmSU6UKP5MmZREp6okUS25m6ld+?=
 =?us-ascii?Q?LLyvbO0/m0F50xIJvR68n8oeTqfWvq5kv1uPnuCz8B2bikrx8dOohHWNirVh?=
 =?us-ascii?Q?Jz4tK72u5t3pElGQB7CEmx1t4AUian2PMRBYxsjFGvFabQqH1fesNSHcxvGZ?=
 =?us-ascii?Q?h0IDKuX0jX5yQqFs2EvPISl5LVetrROw0PCRYhduG4ZsfLbKTSkRxbkUT9pz?=
 =?us-ascii?Q?tCWPpR8Cpw7Vq2Z5A2E12cxY4kM10hBsnozXqlTkzGuGlrKU/tsUAWsmoZ5W?=
 =?us-ascii?Q?1DAui3y7qG/cKvvCbBd90W7LihMGcVoeCq0x2hetr3gDwzlnCp1ic5PT3mkF?=
 =?us-ascii?Q?dpLZoULWRsqC+joe65tqAp0c4zVumPRXYljGAmsGMr4qb/Dk5UZZXxisTWGe?=
 =?us-ascii?Q?3HXaK7CoSU61tHzkbOPxp9paI/zrtkrdgrLJceNMszRuJPURw4VjxHht30TS?=
 =?us-ascii?Q?ulGo+kV+KJVtYFZp6i+1qnahpwVrVRzvsyqUPVKH9cFj5zZLEJyK09v0nzRl?=
 =?us-ascii?Q?LuhcHSoWpu6iJNyxEjrY/LBSAZg8tMhANCptj482gGV38Sr6tJ3KkPyZzBWm?=
 =?us-ascii?Q?wJmVGIX3bGesgD9SLdSscun1zexwmZ3GoMtcA1EdGYn6Xox8F9fXqXzDHxDt?=
 =?us-ascii?Q?1sYkWQCkOQSfVagA5L+c9uuk3c4HpWhtgf7A5Sn8ej+BJbE3GIN+BLKZk+9B?=
 =?us-ascii?Q?O4wGoQN1WSSFA0fxGK7CdqBHc9zETsmqbZb5ew9ZQzAL5Ms+JUtvmWwjN31y?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba09deb-4195-4cf6-a5cf-08dcd34df010
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 17:11:27.5267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdNTMyjWoAGyzWYCq2MoLBwHGDFby1ULQVGaPEHV3YmL4/oTfzSIv4Uufhykl4YnyHFBagRYm071f+WUWe1Qis2BU2TI+L7IqEurXeME4bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5899
X-OriginatorOrg: intel.com

Manivannan Sadhasivam wrote:
> On Thu, Aug 22, 2024 at 11:30:10AM -0700, Nirmal Patel wrote:
> > On Thu, 22 Aug 2024 15:18:06 +0530
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > 
> > > On Tue, Aug 20, 2024 at 03:32:13PM -0700, Nirmal Patel wrote:
> > > > VMD does not support INTx for devices downstream from a VMD
> > > > endpoint. So initialize the PCI_INTERRUPT_LINE to 0 for all NVMe
> > > > devices under VMD to ensure other applications don't try to set up
> > > > an INTx for them.
> > > > 
> > > > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>  
> > > 
> > > I shared a diff to put it in pci_assign_irq() and you said that you
> > > were going to test it [1]. I don't see a reply to that and now you
> > > came up with another approach.
> > > 
> > > What happened inbetween?
> > 
> > Apologies, I did perform the tests and the patch worked fine. However, I
> > was able to see lot of bridge devices had the register set to 0xFF and I
> > didn't want to alter them.
> 
> You should've either replied to my comment or mentioned it in the changelog.
> 
> > Also pci_assign_irg would still set the
> > interrupt line register to 0 with or without VMD. Since I didn't want to
> > introduce issues for non-VMD setup, I decide to keep the change limited
> > only to the VMD.
> > 
> 
> Sorry no. SPDK usecase is not specific to VMD and so is the issue. So this
> should be fixed in the PCI core as I proposed. What if another bridge also wants
> to do the same?

Going to say this rather harshly, but there is no conceivable universe I
can imagine where the Linux PCI core should be bothered with the
idiosyncracies of VMD. VMD is not a PCI bridge.

SPDK is fully capable of doing this fixup itself in the presence of VMD.
Unless and until this problem is apparent in more than just a kernel
bypass development kit should the kernel worry about it, and even then
the fixup must be contained to the VMD driver with all its other
workarounds that to try to get back to standards compliant PCI bridge
behavior.

