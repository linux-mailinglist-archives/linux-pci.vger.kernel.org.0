Return-Path: <linux-pci+bounces-10026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ED092C69D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 01:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3B51F23429
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 23:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51417B05F;
	Tue,  9 Jul 2024 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fL/j/LMi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191F1FA3;
	Tue,  9 Jul 2024 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567903; cv=fail; b=mWFL08exNarbSwNC/KyMv/aK2W/O/Q0BA/GtwwVjRGyfs8ZeIrfR+4gDUFu8kypjmzywRAvH+qR1THefjdo7qyfiGBndox8I4HETjKAmRpNoG9KCB4vtL0oVWlCEYfgw2B84ExmRAAc5qqP7RJAZ7r1No1g7Jb8PLVMjp+P/u0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567903; c=relaxed/simple;
	bh=mBe/fY5WEU2mRdpqAzgao79YKlOQlYf0OnompptBC5g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jNEpFxhzqVR+NcSVfxhkd+SpiMv+VKlAnQMXCveg1TSubR+EssBeePDn78Bh2qRWH36qIWxebGzkpey31Y+OsyxFn8spqcSIHTsdIHw4oeFnIlcu04DSII29qGM/wCYh4FRSjTOWoMyTtlbBtVlVWKUPPRYlibWww8kMIf/yebk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fL/j/LMi; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720567900; x=1752103900;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mBe/fY5WEU2mRdpqAzgao79YKlOQlYf0OnompptBC5g=;
  b=fL/j/LMiA+TeiLQjlVEC7pXo/SeEYFh/Ol5F9fEY0vsEJZb+K/VE2GoC
   ZCXbpZ/+2ECJHq+j1p/jxJsIvZTTLCvI45Z19CozCcKItvZhmk0s+lsn1
   j0ciZbnTxul7+JXSOoMujC/S/Do10bxbgWrVld6TdPyPCi4pGf6KvXRW9
   DhlFmq9qGaxP2o1dvn+i4u6ZfpcXb6AFxgQMDn01M4Vfj+AP/8w/We019
   xxXnt20ewqUPXO93JU7eZ8wGP4aVcPpp8Askp3lZCI6eSKDCtRMSP6tpl
   Z0/88Hsv9rbkiYJR5fZI3VOmBvyfzlrTBYTLU39CuIKBtPkkNXM16IRk6
   A==;
X-CSE-ConnectionGUID: tFxrg50YRCC7EofEkrS+YA==
X-CSE-MsgGUID: BomEf8kjTFCgIJMPGEum2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18001937"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="18001937"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 16:31:39 -0700
X-CSE-ConnectionGUID: BSlmd9v1TMytV4bExzBbqQ==
X-CSE-MsgGUID: v2p3oTLzQoKdVazosLcxTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="52414426"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 16:31:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 16:31:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 16:31:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 16:31:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmMCrByHmMdrYeUWG0pmjiOB+CWbEJ0qgX0Bm7/I0cmvRz/KMsppamdhQ7/bGLJJlhzO0E6oVMVRw5aORg1b8rkk0RDjqytmz29fAxbOQGGDSB0Wwi6bROWEyIcK/+wXT5Wz+ydpwI2LvN5JcYP905IH1N3WWazrYPe6w0XdDnB+5uccLlbpPamwGU9Tr2rLfq+mlupy2okKKfLWmtRcrwIjKpQBfFwsjEqTMEtwgiEK52tCPcCqK7LaIdHK5A7AD2p83avaZgHM+vbWkIdVn/6tt5yMu9aqGKgxu2U/WcipAhRUWKuMUnY6K7zAG1Db/JSbgcK7DIXFF8sw8M4sqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/Pa1EnCqmkt5yFbTWfnw5iqep3e2JX3XDQ6Uyu32d0=;
 b=hXrN3NZEf/T11Px8tTOYmnL0c9wbd0fD/a4+PbZ6N3RHuT/ouB8UWopwGhORHwN4bNNJua7kk1Jqzt25EJ/WGTqBdo4MZ+S9eUda//RAO0hzHy0jtNErCTLJ+6Ozl0kJCtNhmc+bSloa6jG9xjjD2TRyhrhLLD2xaHxwgrfYHpKlSz5z9DP86DLmT4mfn8g4e4tUtsgYJmQjoA35mxy1PNe+IqqkbFtog8O/H0ItvoBqWReRqL6V8j/M84QI32kQt5SKT3D8jkJvgnjknw6RBQHDkuhSqK2SLQ/v91bNHsK3PBVUAbUUPyCiZEf1HhTryoe4aurPcHhq0avIRKE2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB8290.namprd11.prod.outlook.com (2603:10b6:303:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 23:31:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Tue, 9 Jul 2024
 23:31:34 +0000
Date: Tue, 9 Jul 2024 16:31:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas
	<helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	"David Woodhouse" <dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linuxarm@huawei.com>, David Box <david.e.box@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	"Alistair Francis" <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
	"Gobikrishna Dhanuskodi" <gdhanuskodi@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, "Peter Gonda" <pgonda@google.com>, Jerome Glisse
	<jglisse@google.com>, "Sean Christopherson" <seanjc@google.com>, Alexander
 Graf <graf@amazon.com>, "Samuel Ortiz" <sameo@rivosinc.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <668dc8525d9e7_102cc294f8@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1719771133.git.lukas@wunner.de>
 <6d4361f13a942efc4b4d33d22e56b564c4362328.1719771133.git.lukas@wunner.de>
 <668d7d318082b_102cc2942f@dwillia2-xfh.jf.intel.com.notmuch>
 <Zo2QZ_4xkMR_Nmsf@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zo2QZ_4xkMR_Nmsf@wunner.de>
X-ClientProxiedBy: MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fa5d96-07a7-45dd-6ae0-08dca06f4537
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BN5gmSzBtdhqc91F1JQ07A7Y2ozNcCyOBKmKW5+iWrQ+Ft/YprrzVE+ivSNG?=
 =?us-ascii?Q?8tVuvqhoHEwJ0OdOjSIdbyVhv6emeDbvc0bENIaEVz1kFf6L8qJkCZuJ0sVo?=
 =?us-ascii?Q?fQFGSpFUs9WxcXpWhrFBgoELZCsw2Nqx3QTHf7lX/aKdIb7b9khe83znZegx?=
 =?us-ascii?Q?78yCmkoeNt/sfr1LMRsmht4rJUknpEDjKw4nkW3fDheCIBbUFtSA2ihznVMz?=
 =?us-ascii?Q?6kuZFyluRU5s5tE8nJjETfacFSM2V54H2hPDHB3XVUTScc4lQYTTaH/a27rf?=
 =?us-ascii?Q?BzueBXDKixWUgtTn8bJkd/lMeQPSu2MJawbwJ6xINcSxmLCb7u4yan+uJRHB?=
 =?us-ascii?Q?JlLk7TYXqg3UOZSG3k7TFMN677LUPm1QMAsrpxx5zKGNcjlLuZAcO0B8NlcN?=
 =?us-ascii?Q?CwT3ayru+bRhkV0rEToRmniZdxcNnFmC+IFl1cxE0I4DqH4F71lsHTzIJTBu?=
 =?us-ascii?Q?FZTBtkd5Aufh7BS9HBBlv1c+e5idDpGk37vyQpB/FyMFP3EEwwOzUL/vJAgR?=
 =?us-ascii?Q?Q4MWVLfUtx3zd78SkVnuSyKwPauoPy/fQo6NcuQiWT6lEmT7mMkq7lEFDIOM?=
 =?us-ascii?Q?fR9wTmZniQf5dvO7ukzUyF4osVbhb5x43Xj8vkkac6aQEgnWevksMlpPtuy5?=
 =?us-ascii?Q?loVdmkri6jygCJ508NSRJo0nNiPeZKYQsA1Kq2xSf23P7jDiSbXeaI5vbZaE?=
 =?us-ascii?Q?ZQeWcepnAJWrNGEutEHtVlaEYMGU28q+ArA7QPg+hE/pLUAC9JeirXpIAQOP?=
 =?us-ascii?Q?QapEvg4jb9RINAJ2uqUAVZ5YxTgM/jJqPCyeDzz2W8G5J3Iy8i3Twl8Y72ll?=
 =?us-ascii?Q?OmLOSzj6xwB1g3+OSa7NehVsoGB5G4oCmwCURPnrJIsO6USdSQZClcGaju5M?=
 =?us-ascii?Q?dILOzKNJ6/28HAydCpwF1YI6sogo4Qec5I6znp9AJV6PFIpSq3RuahfNciuq?=
 =?us-ascii?Q?pIPRJlN6IaPJJZyEeRUSIBOR64RibxHvbBiPMpIfc0LGLz5aBtKHiw7ShZAN?=
 =?us-ascii?Q?suVMK9rSRgA3ff0IMF6xQ1bPu55gng4kmALtclsT46mZaALjEcMmTT4Sy5sl?=
 =?us-ascii?Q?2TibS+YbwaFLFODAu7vLErMZCT5f8SxAqaJwHwuwDJ+XtecvCJoTf9Xzx8lU?=
 =?us-ascii?Q?oO3EGf4+yfpmLDbMvCdfmtwqLNzAjulGQxEAyBhbAnrCJEu4RMFGCyD74lFw?=
 =?us-ascii?Q?WDxeFWOqz+dld7ZBmuDH1toXyXD0Qh4Ave7AJXKJXbgeTe/IWpLMPrpMNouS?=
 =?us-ascii?Q?vRKfvAA/4/sTCG+VziaSxP8NQvMpa22ti82KUG/dGZc1uwqTBy05EH4qToYH?=
 =?us-ascii?Q?wqQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fDV2WUpHkBuKl/hQs/hzALnNS9Nweg4TvXWNt6Tu1oKjlLp5uxMB65fsBfjc?=
 =?us-ascii?Q?uhIAoFya9m+DUqegBJQPpVTGRa3Iwi/bKHKETwGsBXt8Dqg3ARsekL8YhSqe?=
 =?us-ascii?Q?015M9dhffm5jc/6y8d9Iy0D4SlIiwUqSeQe501os7GYj7otXsdt5vXKr8kE0?=
 =?us-ascii?Q?cq9DYbC5ySn5ykVc8GAe1uzXmMzQZ5NKA+9Ca8x0KvSW9NCkbpuo+DXHoPYL?=
 =?us-ascii?Q?Qyjs+XW93KBxVPulHxQPeYz5ojzdn289t65UnLL9j3HHarkaxrTJ+CzjKc6A?=
 =?us-ascii?Q?xjcb5GhenKzev2WU7GWJ8keJC8PLtAqeRAlU3SWHeh2VLg/QPJoro/ST72bb?=
 =?us-ascii?Q?ccUfskQWCJg2yWQpoK3xAMxHp0UqoNx0BZiiKnhCJjH3KS1HTCvwkxpIOdvv?=
 =?us-ascii?Q?UixEhmlRFNd0g8to52bTP9/+xVyg/VgsVZH5JoJ3NbsD9l17iugW5Mr1ugAT?=
 =?us-ascii?Q?AwLyIQDYkwNAREVVO4vlEgarRpczyxqBROgFW/Wh8vCiJJpP8u7fQxIyYr4b?=
 =?us-ascii?Q?Ee/pMGdKwShkLvm+cMfUp3vQS79VzeDWcCZf55r3KQiejPeBajjfVKw8Q4VH?=
 =?us-ascii?Q?jD/kaYj4lRPBG7wXrN23+hN5nJiYytkFYG0rYrgtSpdb2RwmK95L2GhCZ+Bu?=
 =?us-ascii?Q?cxF2Re3C3qaxuI73WgH8ZRm13GVbSwaz88F5wlgGnR35YmfTp3xx6ASHx5DA?=
 =?us-ascii?Q?eROPAdIi2OmhUntrYsdi1Q3YLJFwvmU5tVy3PuZk5em5a8o7uGn85isOkU2C?=
 =?us-ascii?Q?4E4VPiahs/py6Lkzbx1E9V9hPkboiIb7xlLheAuabwRantST3oe7bC3TLsmm?=
 =?us-ascii?Q?59OI7YkcjKAC4lknIgcHdwmWTzqtt2r7Trv+XI5zqYBvDk6bkMyPq9xQzHMC?=
 =?us-ascii?Q?F2+zvwKOxNCmMX6/piDUNL8tBCvqx2bt/U0Gt5y3akxEpEn9DMYBe9Z9XXBR?=
 =?us-ascii?Q?mfQxOFxjqwqfulEVLwWmvxRwUWZPvuYPVsTqTZpziqWpTG/LtoDAeRldKYNt?=
 =?us-ascii?Q?feQJIY6R8Tzqlie6ZwIAwgHe6WimwFSTibc7yLqi2EwLXexzHQpeZIcMoYWF?=
 =?us-ascii?Q?dVbBZiFjocHBIIgy+MizFugRf9YcGRXkDVtq+7slJpQoexL05xVBLwj9MEVI?=
 =?us-ascii?Q?8iw/xebeh41mELMjcJbKLdKlmus7yzbpPtX7m9xbbuAkgt8jAEdD5pnfdnkO?=
 =?us-ascii?Q?7ulwrxew9DVwk+i7k4XFgK+LaUxVxOG2FWKmFwHFN/Qys27RVWMsJCS44Q/P?=
 =?us-ascii?Q?X38Wu14Aiw1g3DArrr442HMlNL+aNQbnuAdJl8r4bq+IRBghiP+8jgEZ07Ah?=
 =?us-ascii?Q?IuEZncRA6Lodz4cehpFssQYh9qy8ZYQS6rrDesA35tMl26v3y/EHB2z1I5S9?=
 =?us-ascii?Q?JUllOoCg+W0/7A62YhtnyyFx6ZAHsi3gx4bJXTIi0KJCUyET5WJj5Fh/xZtn?=
 =?us-ascii?Q?roN4qdMmmq8Sk8EgweRkBtZWrc+lxvdfAZZi8HbEw9o5sNk63pmB/L6ZhYyL?=
 =?us-ascii?Q?NkKKbPf7EsTZfcO/5EwRfBDNDnFiMy1cjC/lWA4OtUS4LTO0I6AsVbfDiOX4?=
 =?us-ascii?Q?HDJ25cwJeofvGk80rptfMgcqPKhxJbfQ/sLoo8nID26y0sf0XT6tHbXMPk0x?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fa5d96-07a7-45dd-6ae0-08dca06f4537
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 23:31:34.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moMJsUixbg0iIpf3/2VsXOK5yTAFOX0DX48pYGPArSPMYsgCweglKXbOn6/K4aQe36SHs+o8tTD8/SVUQ0XQdaXnDYqdLSJR7cajS6JhMmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8290
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Tue, Jul 09, 2024 at 11:10:57AM -0700, Dan Williams wrote:
> > Lukas Wunner wrote:
> > > --- a/drivers/pci/Kconfig
> > > +++ b/drivers/pci/Kconfig
> > > @@ -121,6 +121,19 @@ config XEN_PCIDEV_FRONTEND
> > >  config PCI_ATS
> > >  	bool
> > >  
> > > +config PCI_CMA
> > > +	bool "Component Measurement and Authentication (CMA-SPDM)"
> > 
> > What is driving the requirement for CMA to be built-in?
> 
> There is no way to auto-load modules needed for certain PCI features.

TSM is taking the approach of dynamically adjusting the visibility of
TSM attributes when the platform TSM driver registers with the PCI core.
It is forced to do this because a TSM controller may itself be a PCI
that needs a driver to load before the PCI core attributes are usable.

For native functionality, yes, it would indeed take synthetic device to
play the same role.

> We'd have to call request_module() on PCI bus enumeration when
> encountering devices with specific PCI features.  But what do we do
> if module loading fails?  The PCI bus is enumerated in a subsys_initcall,
> when neither the root filesystem has been mounted nor run_init_process()
> has been called.  So any PCI core modules would have to be in the initrd.
> What if they aren't?  Kernel panic?  That question seems particularly
> pertinent for a security feature like CMA.

Non-authenticated operation is the status quo. CMA is a building block
to other security features. Nothing currently cares about CMA being
established before a driver loads and it is not clear that now is the
time to for the kernel to paint itself into a corner to make that
guarantee.

> So we've made PCI core features non-modular by default.
> In seven cases we even switched from tristate to bool because building
> as modules turned out not to be working properly:
> 
> 82280f7af729 ("PCI: shpchp: Convert SHPC to be builtin only")
> a4959d8c1eaa ("PCI: Remove DPC tristate module option")
> 774104399459 ("PCI: Convert ioapic to be builtin only, not modular")
> 67f43f38eeb3 ("s390/pci/hotplug: convert to be builtin only")
> c10cc483bf3f ("PCI: pciehp: Convert pciehp to be builtin only, not modular")
> 7cd29f4b22be ("PCI: hotplug: Convert to be builtin only, not modular")
> 6037a803b05e ("PCI: acpiphp: Convert acpiphp to be builtin only, not modular")
> 
> There has not been a single case where we switched from bool to tristate,
> with the exception of PCI_IOAPIC with commit b95a7bd70046, but that was
> subsequently reverted back to bool with the above-listed 774104399459.

That's good history that I was not aware, thanks for that.

However, most of those seem to be knock-on effects of:

https://lore.kernel.org/all/20121207062454.11051.12739.stgit@amt.stowe/

...where init order constraints between ACPI and PCI functionality led
to modules not being viable. The DPC one does not fit that model, but
DPC is small enough and entangled with AER to not really justify it
being a standalone module.

> > All of the use cases I know about to date are built around userspace
> > policy auditing devices after the fact.
> 
> I think we should also support use cases where user space sets a policy
> (e.g. not to bind devices to a driver unless they authenticate) and lets
> the kernel do the rest (i.e. autonomously authenticate devices based on
> a set of trusted root certificates).  User space does not *have* to be
> the one auditing each device on a case-by-case basis, although I do see
> the usefulness of such scenarios and am open to supporting them.  In fact
> this v2 takes a step in that direction by exposing signatures received
> from the device to user space and doing so even if the kernel cannot
> validate the device's certificate chains as well-formed and trusted.

Userspace validation of authentication and measurement is separate from
whether the functionality is built-in or not.

> In other words, I'm trying to support both:  Fully autonomous in-kernel
> authentication of certificates, but also allowing user space to make a
> decision if it wants to.  It's simply not clear to me at the moment
> what the use cases will be.  I can very well imagine that, say,
> ChromeBooks will want to authenticate Thunderbolt-attached PCI devices
> based on a keyring of trusted vendor certificates.  The fully autonomous
> in-kernel authentication caters to such a use case.

I think you are conflating automatic authentication and built-in
functionality. There are counter examples of security features like
encrypted root filesystems built on top of module drivers.

What I am trying to avoid is CMA setting unnecessary expectations that
can not be duplicated by TSM like "all authentication capable PCI
devices will be authenticated prior to driver attach".

Now, might there be a reason for native TSM and CMA to diverge on this
policy / capability in the future, maybe? It certainly is not here
today.

> preclude such use cases just because Confidential Computing in the
> cloud happens to be the buzzword du jour.

As if CMA is somehow not part of the "buzzword du jour" of Confidential
Computing?

