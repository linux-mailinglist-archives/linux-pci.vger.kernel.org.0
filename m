Return-Path: <linux-pci+bounces-24912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D600A7440B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 07:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074F7189ABD9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 06:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056642BB15;
	Fri, 28 Mar 2025 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfXdhbg5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E2211276;
	Fri, 28 Mar 2025 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743144050; cv=fail; b=PlFxFANFP4yATX7g/shJs+h0siHVOcwm51aWIpROjCJBF1fFxuJFAHgAMZokJUWQ49eSgTX7XyOelWmZPzMZ0saYjPj+MxRxbOkV1S35R6Vd9c2epJbchHJMvHyW1uShDy1jAEHgtMt7+wupZR3vlDrM43Q9N1QEze8dzIhQMJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743144050; c=relaxed/simple;
	bh=yJ6BtY/WddbJKSebJkB33UceEL7WekYZaqFHXwVbwaw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tz3HB0//qGZC0ZnSSZKQejjbAK7JsAmufcd9DsM2qW6yiKxZGF5CrBj6eY/jMVoQ2VNJI9fct/t94PcmnZlCwye0CHj2BtI1d0pi7KcldvE/v690GyQ7zzOZkQfJzQ6T2CSrBvB4mVOLneluy2ipGd3mPH7TnAFoxQovsL/iwm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfXdhbg5; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743144049; x=1774680049;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yJ6BtY/WddbJKSebJkB33UceEL7WekYZaqFHXwVbwaw=;
  b=SfXdhbg55THSKq7HvwTdAqV1RbNpnqL7O74Vh83HixbR+YqXrs61oqw5
   DCkDjOvce5LERn1CYVnOlCg24LYETH384P1FWoSpSuaDADyuyovMCQxUN
   O27XLwFvsjFuCon+76D/QpL8bpu9F0dr3tprJK3Lh3ecXwIn51wuPHNEx
   C3LFsjF04AIQNuSYqXA0bApAyQzwAZ/OMZBmh9PajdDnBlQGZW2JVWsht
   BfW/M1/V9KnkjCzOMT3K22ibcXqJfajy9XyL4Tl/bqZzZtxD/kwWDK4H/
   Xv6VyELeIOjhU0o4dUVu38xmB8WxUGR7Dt+y4OixKXsvByBBkfYeKlhDI
   A==;
X-CSE-ConnectionGUID: g0pQQlzhRXyT8QTr9dK1lg==
X-CSE-MsgGUID: dF4KUsU7SlyIvRMsmv0G9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="62031890"
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; 
   d="scan'208";a="62031890"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 23:40:47 -0700
X-CSE-ConnectionGUID: 26bGu+ozSdCtUsArpTvO8w==
X-CSE-MsgGUID: 6pNKqz0bTwuiIpkGPIoMoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; 
   d="scan'208";a="125163890"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 23:40:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 23:40:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 23:40:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 23:40:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRYNPI+zyy0QMeA44yQkdUpI2NO7sb4OMxS5veb9EABSRGM0EnMOLG0g5v5gQTXGhzEmhXtvKHDk0liMYhsp9oX1DrpP7nfFMB0+bkAh8W3a3BLaTqJYbMZjctO5uDrkeJYJXopDponDFcFUQyvqbxo2S86Z25dVNWlUekZWZdLqI+wmLT0Y63XBUgbspixI/j0uO+PTbWZ2+L+9rS5eezUKctu553j+D3FXEreTjsHzRNcW2m8vvTw0d5oVvIk087y0Toc/XbZER0XCaMuYMTg/+CZUVuG385UScbGL+s4Lj0avyXxgIAqYwrsBd5fZNxqPaeTFJJggIg52tGr2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMUvIo2rwylshhYvnf9F7ItTjyaDKiQVYNqcS80DwNg=;
 b=Z8VJSPcZ3V0zAKpdZdjh7Idr57P8PLyaRb5lznATZ06rMNalaSw4L7tfLQpJznqS3ffu8iVIo4B6shd8Wubl4+2hEvZ6jxwSsrFMKwEjTc+qXTdd/mHQtskiTBMDfq3hxE1Cl1m6F1zgq8O4KE5k5+l+FKo5gSxiQ/W1zo/SX/W0izsmf7m87kU5Q70slUSyTZQ02EGJY+e4ClWRgCxbRFw/j2HoFVnB7Ye+76+SrCFh5Fvecn5Ams+3Vu022lOdNWgbt5INkLO49OctuBGcsP0PTkCNLx6UF3mEFfOz7U+ctoZQpUamLFSQSM1a2YTGRAeD92jQbws5rGTcxgkjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7645.namprd11.prod.outlook.com (2603:10b6:a03:4c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Fri, 28 Mar
 2025 06:40:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 06:40:42 +0000
Date: Fri, 28 Mar 2025 14:40:32 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Roger Pau Monne <roger.pau@citrix.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Juergen Gross <jgross@suse.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <xen-devel@lists.xenproject.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [PCI/MSI]  d9f2164238:
 Kernel_panic-not_syncing:Fatal_exception
Message-ID: <Z+ZEYJtLwAlAAv8Y@xsang-OptiPlex-9020>
References: <202503271537.b451d717-lkp@intel.com>
 <87semyy925.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87semyy925.ffs@tglx>
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: e892dec7-8913-4b7f-3443-08dd6dc375f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Ojo1vgrl8j0dGlO0i9wkxxDJ9oSW41j42paho2HeegcTbBeibMyIhtawmGE?=
 =?us-ascii?Q?avGPp33fxJuHxkA7mJ/eXdRYRVhTNSHKVZpk5OO3If3pnQ928xplZaeR9mBs?=
 =?us-ascii?Q?S6FyhTRMGDY/j5SXxRMmQS82g/DGQ+SI/EEobIfMUW4lVg7xzbyZzRlPVw4c?=
 =?us-ascii?Q?gh98jUpJUSabbKiWXKXG7UOSUYleycQccypxHVq6MY/+PQmQZJSY1njCFnGB?=
 =?us-ascii?Q?sj79NVhIHoGl4d3X0Kv8drA5izN4YVBWLXHcWy5Fio+DsRNtoARqfcmAkgA5?=
 =?us-ascii?Q?zh7bdM9spLUvX01TYftkIj90Im1Gxh0hFgA7DirFm/CyObxwzi1s1ycxitov?=
 =?us-ascii?Q?ZgK+uTHwUpU4+11HpKUhGpIY1WjwFThx54nzVo9YyhSUf2wZaEmsMFqii8GB?=
 =?us-ascii?Q?aZRbY/5rnaDhZZaKYge8S46MF6JPLFxy45V/iBLIlpT/7+PQO5wjN7FEyg/X?=
 =?us-ascii?Q?+3Vfo3qROFvVYhX1/h5J10XOYX10xrW6PH0ZjmxMykEiODRP7l3vLn8iE05I?=
 =?us-ascii?Q?lPiOZGqRvQlS2in9cl2oBgFJZ7lVYegfZ0HZvOA7viOUq9FM/NuYWda5zzOb?=
 =?us-ascii?Q?jLsJ9eFsp8sDMbOTGcWdm/T5p9D2a5V2KMaP9ZElenhN84ONpRoJ6at2BDqK?=
 =?us-ascii?Q?BfGvrBzqO1WOayiSdbjaPpxMFvp4eUX8dMvBH9knPl+B6Ai+26Hztpe7XHZu?=
 =?us-ascii?Q?3aARgToQfE6i0FXcY3mRLTophYDugsvDg+D9kQNW2J9UuKNKxRfEeRCSBmlM?=
 =?us-ascii?Q?Sjk05WovcWrmXnw1HjKxl+zSeOhgr9yPxK+N1kXt2xyq5lMkuyQAu7a9cYk/?=
 =?us-ascii?Q?cI+NnatehkCbeTLviSfj9IkofMzcApAPdXTRM0KV1X708jOBWCPirsoxPzuV?=
 =?us-ascii?Q?A0kk8DbOXk0hb6/1CqQfcYTvyXwH25w5IlUZaU2BM/FElv5M1whuuiWiNBAe?=
 =?us-ascii?Q?bUXdsiHll40wugE/rKIhfqiNSH+id0W3ayjvkLxUs0S6SJRjJWsQckvx47uZ?=
 =?us-ascii?Q?gnr5foU6JSaK9BrLZYx4cCRk5RKKRdYOgTtiQuzOmuavMxHl0nwhP5tZzr6d?=
 =?us-ascii?Q?9FuMObjCsyuZOyiykt874ZmuFXzVTTrzZmqpP9Z2GSll1qdKMjiVc6kIqeK/?=
 =?us-ascii?Q?9mcI6BBztqAQwMoTnC/XRsbUaJsTVkqNei+Tq9Y3b574vlWBy8nGIrkSkejO?=
 =?us-ascii?Q?TzgmcHgWWi+GrVwndd0G/mlspyHuPlHTz/wV/WGM94CNEp9XlOYAXlff5MmH?=
 =?us-ascii?Q?yfD+g5nYeoLuRZQsEnIyARt002JmJA6mipctuOcrR3UFNKzVDTRyCmj51KSQ?=
 =?us-ascii?Q?pvu+Sn17pBN84WRbpIVl6xHxQx2ff7f+CSX02FuevQ7okUVQ5BX4BAEkgYCH?=
 =?us-ascii?Q?vHnQaAL8dClxnVanmPe+l/WhbgyM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kcOOIsvCC3L+I+QimPzF1Jbf2VQtONEHs3WmXRTdLTe97Parw6uhW0yrRlCh?=
 =?us-ascii?Q?skKElTnqssWf60poeTz6hokLQPDK4g7ail9gd0YpeTSkYOuAw3GaP2iuUIGX?=
 =?us-ascii?Q?iGQdK+EDiT/y/Ri/7njkCC0T17vnR4pIRCc+f5sZM1+nL1SDkXbsPNXEbv6Z?=
 =?us-ascii?Q?5UIt5u0Zp/SCQXdkby+hKg0vMdWCPJze7gKlv2B/c+ilMh7xc6DUKn1+ZcQk?=
 =?us-ascii?Q?Nm6w0xefbeT2SWumiw8EvLmUbh9RJXYftgaHPH7deS0FsOXybcX7vxkgD0sP?=
 =?us-ascii?Q?YphYuQNne4gmbnlUDjnYkBErMWf/cHJdph4KSQmhd1q1n6fqVSWZ1mMwHZ3N?=
 =?us-ascii?Q?14R5ldNTHfdiGVnUHmeaT1H0gJMmtI1OszUFtlzFkG5eQlf7vkEFSph9fGgh?=
 =?us-ascii?Q?S6PUBbpAvsD3Cxit73d8lnTFjdELFpy+D+/4ZNyQZuVcQ2V75aUg88c2IkxG?=
 =?us-ascii?Q?cTnUKn6LLisZEF5aLXJSRnyVLOsHq5EIyoJE/b4MMTKBJmlL2XJ4eNKwt3Hk?=
 =?us-ascii?Q?U0I6pFPs0T3nyH/1eNryKEcxaghnHJ7LiWSX13ifpwYKKcKaIqTU2wmlZ1ll?=
 =?us-ascii?Q?d0A7QsEaBq2hcV20X37uS20ALWhMRAdvpWIw64hPdX3SIFgjSUNadEe9cD8e?=
 =?us-ascii?Q?owQ7upJD2LrNXbwfCS4Hhmk6MKZ58uFBjK05t/o0h9ECC+yZ1ZWP9m62p/Uv?=
 =?us-ascii?Q?a5d5vkPWlzhY5RTzQGN/M/CXbyM/vQWF1dACh6rExmcJYtNf3DEn1NAoYY5x?=
 =?us-ascii?Q?KB24m+DmVtIz4XRwx4PflcINXOaaVCHJhssvZYxSicjTY9lWFdMvWGx6ptBF?=
 =?us-ascii?Q?v2jxLqs7uCl5z3OD/LnZ5dSw7SfenZQ8F8uRWR2a9z+aA+q9bOP5uwCCncrz?=
 =?us-ascii?Q?Xi921Ln8E0sHelSQ45Y1j3JlpySU1s4/I4NRqhevy+i1hPwZBj2Cb9Ocw2Zi?=
 =?us-ascii?Q?VmFENXpng5CLiSLAraGzjeDDdyrGTnpp46Ru8PoIQJqjes6eqQ4pCA6U5Yz0?=
 =?us-ascii?Q?sQSOBmlGK1sgbW3DLONRv6KMkA8V+G+MOZnB4wD/6DJekvsNvmgJebUmSY1C?=
 =?us-ascii?Q?HNjLOM0f39RUy3dbXaFwPDfXbh1GFqrjmXF2HfjukJIe9WfZweN15p3heYoB?=
 =?us-ascii?Q?FK83ivfQwc3SJ+9ldLxcmOgJnotNpga86NfANVzzgg3kmYj9UanaPNsLDQus?=
 =?us-ascii?Q?+JRwAbhORERJmDJ9r+Gfs2q9uzB5W85qOkljZVbr5hfnHytw8Ub/tahrCQlr?=
 =?us-ascii?Q?NUDxJKsJQ5oZQ7ihAsbNBUtaAf6a410HqELjSMn02BL892CfFCV1S7gQH9cm?=
 =?us-ascii?Q?kxzkUWYdUIurBc0br/NnuW4PhRjGUMt7ksn8jhE6I6EaosfJ2q5zXPdx8eJb?=
 =?us-ascii?Q?w8zvKevf6tAY8cGrDVPyMhhx3lyqPV9TUXmchNgxIRXm+0MQPwXK1d8RVcDr?=
 =?us-ascii?Q?AdgH8mVxh7vhisnRCV0/IzJmJaPo2M2YI1FGonJ/M/5ut0UCsjG2KcxhGlif?=
 =?us-ascii?Q?C66XRM9IyBHwFZ+rhSGmhvnrKOzJnEKXaPtrvX/Q4BtHgNrMTlTw31YJTQaj?=
 =?us-ascii?Q?Fm9FnG22W3P6OBj6mUIubaXK9dFCkJSqwKc31iEih/D+zyU52g/yZc8ULzAO?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e892dec7-8913-4b7f-3443-08dd6dc375f9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 06:40:42.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44xw35j4X2DpcDqbHWp7A5p+rmxyDoHTJI1defyakPXNANFOoeFdarDOtUpPJG7wCfZc6q7Y5OA9Srd13TQ46g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7645
X-OriginatorOrg: intel.com

hi, Thomas Gleixner,

On Thu, Mar 27, 2025 at 01:03:46PM +0100, Thomas Gleixner wrote:
> On Thu, Mar 27 2025 at 16:29, kernel test robot wrote:
> > kernel test robot noticed "Kernel_panic-not_syncing:Fatal_exception" on:
> >
> > commit: d9f2164238d814d119e8c979a3579d1199e271bb ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> Fixed upstream.
> 
> 3ece3e8e5976 ("PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI backends")

thanks for information! we run the same test upon this commit, and confirmed
the issue we reported cannot be reproduced.

