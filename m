Return-Path: <linux-pci+bounces-11813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55002956E29
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 17:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB7A1F2204A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0331741D9;
	Mon, 19 Aug 2024 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKug9j8Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7C174EDB;
	Mon, 19 Aug 2024 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079839; cv=fail; b=OpVGc+8nhIQ3IpUpdhuwrE7ed89RDuPkgbWbRjrXLK4c2ih7RN+XqdESHnF1UvvN6bvJOht5DRw+ty3/fI5QLqST0VmHX4tyDk+zxd/4+CRy3LReBsbSr6kTyFKUW4t7yG63JA+uHDONRBQxhG6kDwzChyDnlVMn6Ny3YNCpUmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079839; c=relaxed/simple;
	bh=ocSIGTfIOGiNGiZjDaU3ka5BWRfVk1frqeCagFGPIh0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YUWJwhFG5NFmXoDW8S9Jjsn31+mvHxCRGAUnCHYDJyWYEOl4pyVuq05aY+yTizG6CIt1cHvzn/G1l0HR2wsI4hN42HTBYUwBMUVD4Xx64BYLt0raEPg1IVYis+aQNrHKlAVO7rd9xZHroR3xhOdUE5VNTWJLV4QDO6s5X5Ssxhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKug9j8Q; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724079838; x=1755615838;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ocSIGTfIOGiNGiZjDaU3ka5BWRfVk1frqeCagFGPIh0=;
  b=ZKug9j8QfRWH2pqD6Vp/es+y3eyBj4ztCNBZvxowegF2rWVPtlw50lAM
   ULEtMiRGgydNSGcHlEIvUdErBkXUfmKw+s57Bl5v1ZBHwfPh3qthZrI3t
   42gGcqXuVR/NlrwTZBreklsIeA0WzYNOFA1fCzJwFlEg79uDAQ91LAZbI
   d7jveZgbw2mgxFHA/34FR+EedzgrvvdAWFdQL2ic9zPVMQnwkmmRY02QY
   hBecbY5DD2RgVy35fwFwYWESfHhSpV2/3G/SyoUIEnYrmPdHfYipkxOzd
   9CZNMYLWlk2HzQT5F/3WKqFArBhwp2cKTbQx5N5yBvDh66Lu6LZRIcFwN
   A==;
X-CSE-ConnectionGUID: sKzoQdhNRY6FNfDblpFDwA==
X-CSE-MsgGUID: IEkzFoUHTgarVYwZna7FFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22303332"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22303332"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 08:03:56 -0700
X-CSE-ConnectionGUID: NtGVscOVTom51azfPzVuoQ==
X-CSE-MsgGUID: TULXgVxwRG6gBYbfOiTYGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60381641"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 08:03:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 08:03:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 08:03:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 08:03:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 08:03:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxD+LTdEvBvglvG2nFPMTEdZYWVGdvFprHMWU506HF9RZAwLw3lURHJr5ho4aQqQBNPxROFHDvXrWBiUZsfVJCfbIvK2dHK0fBJFGwgXjyMA/GnYcZZ3qE1DpEvD+gVNBm0ETnYySsXeZa40tRmaxkuLylayXqnc9okmEh2tz4cMn5CogTLujPQoVdB4Sfxr4WEMDNqooYP/sqfPzRsZqHXNhsWG/i1XEIKOBWNjpWznw78FOFIn67JjL+bESfwFJ1iab5PxatFvgIk9unZbXyCBqkfKHsBhJgfrzANmAJfyJyAS6lfiHvkjI5Ly2caQJIl0BwlfAfBX0IQHK84Lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB11/LKC3NDmm14MYkLaiKo/lge8+CqF3DPr+zyXEi0=;
 b=susrxihducRVWifHM1cMUeyP8fspkvQSVYAQ97svslwWVCs43DKL0UkgaFJgL78qwKKhaKsGHhswO4DtWV5RKP6ZCk8reiNFaKG8p3lKtj5+X3yx1abPNIpfjRSdACNbfMvn0hOyHB5NbsnCjMVyYc/PbC8AfSv7SaMOkeaEpNwzMpMCB+vWYWN19B2GOoxUtrzjYjO/rZyUFgh3TYuTuxaA2xOYBb1Ixcqns2GHtUyUJx4DR19LS4KG8B+PY02q1XuzI1gvMqaUnawtWDHixLvJ1fWAP1TEeDeQpZ8KuNWjD3766wSDRu26N5z+Zt23RZ8pkMqqXUToWXOuhrTtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 15:03:45 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 15:03:45 +0000
Date: Mon, 19 Aug 2024 16:03:30 +0100
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: Philipp Stanner <pstanner@redhat.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jie Wang <jie.wang@intel.com>, Shashank Gupta <shashank.gupta@intel.com>,
	Adam Guerin <adam.guerin@intel.com>, Tero Kristo
	<tero.kristo@linux.intel.com>, Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>, Srujana Challa <schalla@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>, Bharat Bhushan
	<bbhushan2@marvell.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, "Johannes
 Berg" <johannes.berg@intel.com>, Gregory Greenman
	<gregory.greenman@intel.com>, Emmanuel Grumbach
	<emmanuel.grumbach@intel.com>, Yedidya Benshimol
	<yedidya.ben.shimol@intel.com>, Breno Leitao <leitao@debian.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown
	<broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Uwe
 =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <qat-linux@intel.com>,
	<linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] crypto: qat - replace deprecated PCI functions
Message-ID: <ZsNewmk3HHDFS3hv@gcabiddu-mobl.ger.corp.intel.com>
References: <20240816082304.14115-1-pstanner@redhat.com>
 <20240816082304.14115-4-pstanner@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240816082304.14115-4-pstanner@redhat.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: BE1P281CA0271.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::12) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|CY8PR11MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 050693c6-c398-484d-0247-08dcc0601f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gnygsZzrhXqZ6SaXKa2TaZkudv8PGfcJ3/0+7r/6Sy0IHUSOSQTzvdw+jetz?=
 =?us-ascii?Q?ktVYgBu682W3KNx4Yn0NZtzVylAUoniN/Jo9XoYMujPinO6MBA1pS0ulN/Y+?=
 =?us-ascii?Q?/fURgOEIK8eFN72VBCG/ik0Iqfc9ujc7R8UayJBB6bi0emVcpnVp8+bz/qHP?=
 =?us-ascii?Q?4Q0/ihQHxQBFcle2VPezN2eASwl9nVxsKgJN3ZViTBlIdI3jbb4nmwpuyq7/?=
 =?us-ascii?Q?Mc/Wf7SN0MUA6XWjEXskoAMWY+V31dus4N19xIIN0R7VmD1NdDcBgnQ4b9Xw?=
 =?us-ascii?Q?yfEwtPdXG5FDw0ARXveaFadLuTJDJshAMqarLprvgqDSYmdYlwVR2is9nyXM?=
 =?us-ascii?Q?DvxKsM5X0cuA22xARj5wOYYI3oR8zhtZWnizJRjur8pdmJzuoUqGnd+3Q/da?=
 =?us-ascii?Q?qBJs08y/SztoANKx+MIUeU8CqGamoCR4KAsZNJE5CuiJfzWNQJZmzfOhXj1u?=
 =?us-ascii?Q?R3SXsAxcRP0AFmaIbJvpVlQwpkXToUurY/NbDm4eK4y/QTAZTsesDj0Q6ySV?=
 =?us-ascii?Q?DF4BwXGaLPzQS/33FUXOq+mpwBwB0Yv1NkUAPVdH1Q7CzLJ0z0yNAD0qTeFF?=
 =?us-ascii?Q?IL4d/d62giVtNSZ33WqRJCyFbTFb16mRYtQaWtGDTG0l2vcdSlxQP4/Czh6e?=
 =?us-ascii?Q?dw/Y6H2vWlJDaCzpduV/hPLMEg5tYmaC57tHJrJVG6I1D0B4lzvvH4E0JdOa?=
 =?us-ascii?Q?BStzBf4FAZn4g0hyBStq2B2AcLqTOUTFO8VSMe2IE/QRSBTndnXnEuhkbOWo?=
 =?us-ascii?Q?l8BjCSAUVv/IfQvVJXE91MeoN/I5qkpi7MGz+7yXR24wvNnXijXC6L+cFOa3?=
 =?us-ascii?Q?AGVfm2Neh7sSjIXDHA/nvZvMOQlnU0f3Vkq+PTNk6/SmZt4suy09Ods1Zl9S?=
 =?us-ascii?Q?T4jijhPoEBSf00sHcAohZqPPnmCYA/dMQ52cfQBwIkYTd1k4oMz7hgxHQi3v?=
 =?us-ascii?Q?Lr5vvsXkGWkwDU/s5ZPcLpNyD7gsNDrDsSaACdjaoDwCWNmxi0MSqW1JJSl1?=
 =?us-ascii?Q?EK7sVw4iwHYikblV8ecg4iWekmo+qzjeqUagL7aAVBmumAKYyuF+hQu0E1Eb?=
 =?us-ascii?Q?G574Jyp0Vag9cX0Db46WZSHAi/nEsfBY/jdsSbPqpijrTvkwZb1l35PtiE7U?=
 =?us-ascii?Q?1EXHVZpUB13qMszLtCg3Zuzi1iSUIXlD7tDmI1gV+xANYV7i0RNGR9P6kge5?=
 =?us-ascii?Q?8fylWk4Bxk++NO4/dU/2vLxoro80hbnQVxOlGh5rEeALgwkBWictRxcMUVce?=
 =?us-ascii?Q?uyl8DZxbj57AzW2BpvIgeSk0JBtZHqe/KkxmHsSaO87ZmOQwrfS5L85GMBxh?=
 =?us-ascii?Q?xPBYhi7tyIxpOglp7XLYy7W8YaFY+XRy9eb4m73aJwg2qg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xCfVerYownHMU0mMC7XAWrzMYzg5SkP9z3G0nTDPBY79Hmgn+K/+GGsbPnLC?=
 =?us-ascii?Q?tKf575Jilf/uRxOxqL7eqe+MwuO55G9dDk70ADE+yCvY1aY/cZHNr0qwyUyp?=
 =?us-ascii?Q?kmk8FgyDCVNdxy/rJ8FBGzB4Y8ck0cvjLyFzTNONoq6+3kx9CBRKi04a+rRK?=
 =?us-ascii?Q?26hrE80rtQiyH34/fb1Gq3/BOi7y+ccFxq/j1D4Onbwb7PwXP1phFRI3ttoN?=
 =?us-ascii?Q?XJ4NJB//OxBGa8efgNoCDt372efZlqoqgFZZcSK97Q1Lhhj6x9/wFCyO30p3?=
 =?us-ascii?Q?1rw8LR3FDB3UTbEwKZ0D61N6Tc6oL7MqpsAYEwY1AAQlkCPBm4db7NmfNzD/?=
 =?us-ascii?Q?ARR0o01dCksQMesyFBF/Fmg1wElUWgpq92d7ehGeGMLb0ZO42ynyyhKTYhAb?=
 =?us-ascii?Q?sowXzM1vh4H+vTkxKcnefQKv3eOdLHBNDSu+hz+wcKl+zvUZoGNW+8eaSESs?=
 =?us-ascii?Q?EcgrESOxqT+lC5VzujzUxecrWaEx4ZCBnqZMB3qN/uY6WkiJXlzbdOhKA91j?=
 =?us-ascii?Q?UKWBRu4C1G8Mi4awnxj30LPUXApRvFGVNjtfsrU7nZoSbgh2NkrqSkHtRrMW?=
 =?us-ascii?Q?X3jO74AhLvSMFhM1Dankc7m4A+bxs7pw161oy0HHhtQ9N/VvkwBy4orHwLE0?=
 =?us-ascii?Q?Ql+pS/MKW6kw5/4UJaC8Uusdm9Sns2DoFguJGJeeQERXUH+lZHYpiuuY9j4v?=
 =?us-ascii?Q?eXhnuJoErKx8Dss3YF8SFHWcfPX62Wv+NO4qAcs1GNirARsX5ctiUrvcvtlg?=
 =?us-ascii?Q?qI0T27jf/DcNo2PL2hk4yUDZbmRdQ6fhyYyuf8QlvpwY4nYHXQ6Xx8fa7Fpw?=
 =?us-ascii?Q?u4U/pvYo8jATW3L3iHx5ZcY4NDjKe9JuKJ63vhnVHIIClsvFh5EpfwO8Q3Ih?=
 =?us-ascii?Q?HuxXgi7LYClAChr8hTyHIcyU/J1JtBW8YdAAMIf5wUaoOt1MIXQwHReYFdX7?=
 =?us-ascii?Q?FUFqiuWsG9oqDS8I5pt5+ElRDSqhKa7ripcuz0rbf+HUEeo+e99SMFZw5YN/?=
 =?us-ascii?Q?KCEd2IH65VFbWbv7u1z0bcnJdhp58pP6UaQWUHORiDxllquu5lSifYSwtoTv?=
 =?us-ascii?Q?66zkao05nuMT+dPdZVmUuYnpbTX2HOsFxJ+9VysXiNYpbS1OSCljZ1CyJZuj?=
 =?us-ascii?Q?FXb3Er72tMsirAiLBTH3YY43pVS1LHnHjU5T8+SGOHCpj6JYOiy/w/qKuj1o?=
 =?us-ascii?Q?EopxslSC6yh97hTcJlQfaA3apitrNVv9V5ePoyXvFRYF7PV/NlCS2kBe85sl?=
 =?us-ascii?Q?5SIVr5HSzQWhZvSBm5E3WDKIpB152zKv3X+P/Tk/VfO0vyOKIccgAlfr3a1C?=
 =?us-ascii?Q?ZMi6KTsn432/tRvWes+rLfeBLljFYBiM0gi3E6lObwgDWScIabAAZeu49gyl?=
 =?us-ascii?Q?wktP0vFaKiiJEKg1dQWo6O1d1C2NHAStTtVx3xd/vhHX2s50n5PsqvpG+nhx?=
 =?us-ascii?Q?2IK0FY4JtbI5UkTKzgKDsSWszchQ2BDSdRYc0J+k7im1CmN3zSgAgGlIpP6b?=
 =?us-ascii?Q?aFH4QBIDEpLAjLeWojoLiYZFihDjKdw8hGhdtX4hjBMkIXv+ud3A5MJAS2+p?=
 =?us-ascii?Q?gv2Rl2/9aQGmYZomnSamV63MOreiUaWvBYsC9wJ/en+FEWFrsPlb/lp7uLA+?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 050693c6-c398-484d-0247-08dcc0601f59
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:03:45.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkQVYHlu1WQd9vLCrmbSklmHoyfFUaKOu12VZ0xADhaG8HZAwi5jIdskg1eUUdITgZAlGbb1gNyYbD3+7+BKuQ1xY/u9B39CKt023j7vc84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
X-OriginatorOrg: intel.com

On Fri, Aug 16, 2024 at 10:22:55AM +0200, Philipp Stanner wrote:
> pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Replace these functions with their successors, pcim_iomap() and
> pcim_request_all_regions().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

