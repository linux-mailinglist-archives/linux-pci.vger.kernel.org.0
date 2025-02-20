Return-Path: <linux-pci+bounces-21862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B1A3CFCC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 04:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768703B8753
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 03:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950A1CCEE7;
	Thu, 20 Feb 2025 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4qA57+g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72E1C5F34
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020741; cv=fail; b=QoCzb15WP+phiHnqUcyW1wmfrFyEIFVkGH634SvJuo1+EuhHjq4uHeXuLGtR8JWTUaOtsgKHHPp8QVh414S4sd4X4oCXmHGXYs1UV4mnvzlyRHVQKjJP+3EP9D0Qyn9emK3m2bWgltjSmsb6lxhI584r3BhXMMGOYJtdUo7uaWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020741; c=relaxed/simple;
	bh=WmyVkXvEW+BYU0eDAqmC/U8dw/uXe0gYrMYfxZpw7TY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E0sgSdixlpnZXOTxai+XGA0P81qVfQZuzYwQwRw9vIAT1MzwQDXWBFpJtevKVP6BHetCTv9xnD1m+gaJjyim1MceVC1uNxaFKdoYmCk2xl8j8Cvjxddy2n0fWeSxBWkwq72qOQMSrnXv7B/Bra1jkBLsZxQfZJBjJM6Iu+fS/tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4qA57+g; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740020739; x=1771556739;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WmyVkXvEW+BYU0eDAqmC/U8dw/uXe0gYrMYfxZpw7TY=;
  b=N4qA57+gDarG+hRnqkA9qiJDsfaIMX+/DpbcYjv2s8w6S6GRWmilS6w9
   b7xIwwSNgiXYeO/9sVMWK3yrXBO0xVKFjaRY6n7iY/KZRKI65aJPDZ1a0
   peic7bCRSXBIwiJTf3/aqLqXJUnigG4yLv2K06pvkJR11UM9UzajQXWRb
   2yKuQOBPtFTnGnhmxeb+UQzi/lXPlhNWzHlySQFCuFzkxwQLIkqElVLwh
   p/TlLQToJekc44Q3Lh7ezkk088N0A+z6R/EGayRXOBhpQeTUneZ0SZ0V2
   x3f4IcqPTyh9zFxCN9oOiocipNEyGF/7+8VwyJYAZhpmLbLhIuY9rUYxs
   w==;
X-CSE-ConnectionGUID: jlDgiUODTX6TAnNuyG8gOw==
X-CSE-MsgGUID: 7SkNH3X5QkaGyJ9wdibuHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="50998219"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="50998219"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:05:38 -0800
X-CSE-ConnectionGUID: iprDiwckQ1WM0GwRvwfKJA==
X-CSE-MsgGUID: Xy5EjqOdQhyQYHQqzhGlFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119003696"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:05:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 19:05:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 19:05:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 19:05:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0qx14tXiq36wGP5q5pfGW/SFaOg4DbN0SRLMn58+QSyvBpozlBbOobo9bvCPGUch3z/KqN3TifNqMvdhPGEj2ml98VyTR06TvovgukSmYtIX6vMYwp5gbgsvPEZYnKtk+QeszXUaFnCbA6lO3pN5cjqh0iTlUSnGtFYzZkJDpmfCnmyUpxPq28gmj6r2hl+s/w0BWLF4ej6CrsPJ3JT0w+716Lg2uUL+3C0XVVh2ew+0sWPYVt7t01FFy2auFxNoCd5rktF+MbBSChdA2BsMdnpt2zJAu73QUEZo6pcORyHB5mfKjmy6jAWj0zGUhhakpKnWjVMI5SdiMVctI0TWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/DHbx1M9NaoqqMpzQh6CJoGnvtVkyDqFV1Za4a8NDQ=;
 b=M9SD9ecdFoAmLH6VavJdDv+ciBM/ZhRmKs/Cz8JN/XJtFZA3dO4VW/rIezBOui0mXd4Dd2ACh710eBwx+Rod4ICYF/RJ6ChRigbI5anUM0D6iWzbnVnolkCjvLTJFCO3NB+yxzJPJ9lx1M3lnwoRWBdDogtmz/1/9Zq5SqXwD3tdYYuPEoR8D8dr7n4XMThWx5g3QPPQ3O3b5dPXW/+iBwyJdcczDvOz6xjfBhS9f3aQmsJdM7c0GVOhBjNi3ut49BLzwTOjo3EySTnroI2yyV4BgRdrScVLBhtnpLxI3+whPtg6zVuKsjLYGFbujGierfA2rxOvvwSimwiN2GgYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 03:05:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 03:05:13 +0000
Date: Wed, 19 Feb 2025 19:05:11 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Lukas Wunner <lukas@wunner.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Samuel Ortiz <sameo@rivosinc.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 07/11] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Message-ID: <67b69be755d6c_2d2c29440@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343743678.1074769.15403889527436764173.stgit@dwillia2-xfh.jf.intel.com>
 <37f7c14e-e104-0508-4a41-e62d9e36ec47@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37f7c14e-e104-0508-4a41-e62d9e36ec47@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:303:b5::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: acaf68c6-2181-4257-abf4-08dd515b6506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?fckdGTNvTO3RSZw7W5FhLPlf1TpBSiTEa3KUtzSJqB7HFy5Is+r5a5sVD9?=
 =?iso-8859-1?Q?5CpDPKFtS8Ef1orIHByE177C02BOuhfg0f61e+4Av1Va407lkhuTDX3guz?=
 =?iso-8859-1?Q?sbxMObaswdvTZEX3A4puZxyVFTyTzBpJexuzgQwCFvpEXxlyXWeswXbez0?=
 =?iso-8859-1?Q?3e1A2AbGhDB0ycy06flLL4K9LjkHGmr2hzC2JyltK8yGc+tphKe/JaedZK?=
 =?iso-8859-1?Q?dteP484Wawm9ghL19BOy4qIlJhEurzC25MvgVDWfm3NwozsSrwtnnJUcuC?=
 =?iso-8859-1?Q?gt4/9VAtZEvJ4BcK+e54ftcae/WKNcU2wmqwkksx5jZb6TL95w0rP9fVrc?=
 =?iso-8859-1?Q?BTRcvwc1NhRgjsLwrqEJuFvcOXsw1ninDH9lIWp2IdhbKSLN7TayjjUCb1?=
 =?iso-8859-1?Q?XntaUaBZ0UWHCJhqTka80JFs7HE3GFKznGdIvftcgU2y7rytBeew3PUgjr?=
 =?iso-8859-1?Q?ILoiiUy5y+L0sL+yBcqXnOg1ifXR8tmgP9kRxArkbymlRGGjRRNVPWhMBy?=
 =?iso-8859-1?Q?3Jy1Gf4EnOkrP+c2qCnEYDGYcziCfPhJ00Fk68ke2aBAbclPqez9tCSQAH?=
 =?iso-8859-1?Q?0xCeWN2LFN/RwfOSqTVGXYsdgEmBx5zdWvwSu0d3I/XSKvEy+agf+Cpm39?=
 =?iso-8859-1?Q?e+kslqxfmpwrPGIM2N8pKebacsznBU5AT7Ag0yq97bMGXhhiMDW+AA5fGb?=
 =?iso-8859-1?Q?k1rbYFmLPtIWm/lj3sYLo+KeyDDsxQUNuGfgiK7fwj7hxRVpCq9io9g0mR?=
 =?iso-8859-1?Q?KwYkQG6/8e4zRH3SgKQrrOzPA6WTXkWWrW6KYcOacQZTHWcK4kvehRLdJO?=
 =?iso-8859-1?Q?8BrOooffQNiruW+KhtvQB1DzGQX9FzPqplP796KmmB/Fmo0BnWKK1Rowux?=
 =?iso-8859-1?Q?Lf0c7Uouqtmc4VQlLEKRj2rwisG+jgUT8DPyxoPdKoojqzrANZWgd41CcI?=
 =?iso-8859-1?Q?D/tdCyFd/K8azvCEKrh8QhqTu1aoyCl8FqqzKfqDRwrHkzkvkR9AFd+XYj?=
 =?iso-8859-1?Q?3/XUUBbrvrxR1IHgpeRWJRHgtzEt22G11apo1ImWgFMsQxuIUuu3SUBCH/?=
 =?iso-8859-1?Q?ZIO6yvdfZd0pJuFX5w+rDYOA2H72wMvrsRJr4sBrjbAqXxkSSWDZIxp8SD?=
 =?iso-8859-1?Q?HW3FaNKCj+Ef5gD0CPwxaM4+fJA+nD+pZz17AkwfZB1hd2z7WD9T9xpv1I?=
 =?iso-8859-1?Q?l/rfURiCU/XWYzGnaiieUICITw0An3jqhkswHurAuGjQ6JQrYKvUOck7ra?=
 =?iso-8859-1?Q?4sxd9FGyfEfb/tbtwTUo6AtwWCmy27j1HzAY7pNWwHymQrWcNk01C2YwJY?=
 =?iso-8859-1?Q?8Dv06VsWAV0pEya3VbLB3E4nJ3RTc/x4DeEjUcNTlUjFTcK0aszBLj+gWM?=
 =?iso-8859-1?Q?44PNciNN7YNZ6itMk6y90XGzMwHkgJ4VT/rN/YkHpSPu40yznZrjYIMvvd?=
 =?iso-8859-1?Q?J0TtcQJzOCf3P/FX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+hnO5KYBPpW9r2gSkvXqP9koHnRJS5/XXbde8lFW+BjNbNrvDB40KrLpQf?=
 =?iso-8859-1?Q?HFxn69V2bhI3N8GDwq9jjkU2xAWIHxR1Ra57x24Msm1h2zAMS3Pwxp2fTZ?=
 =?iso-8859-1?Q?r6ZJlCh2emllo4/UaOyR7Rspz6GlE5F3ity0dLT15IL17qtkkoUWBD2mzP?=
 =?iso-8859-1?Q?6HneyqZiVphRvQwl+inNvn/Ee47EMvMr2IHGTNtg9/7bdnUuDaFSbkntpx?=
 =?iso-8859-1?Q?QrMt2n8YcR0nJ6aI2aKgHHBZgLqrw/SYlGiIWqP6QFOX1xjehOv7+xKZ2g?=
 =?iso-8859-1?Q?dam30HM3fvGy8TylYONig23kjRP3mBkGmt9SbnAN/kmjEEuK6eq2bjdMtq?=
 =?iso-8859-1?Q?kMckG6yVUR9lE1aU9hko5bjx5+oNtM3gvOzhGEhdc+heO3NGlwRTNui7ls?=
 =?iso-8859-1?Q?9U6Dy2TuifqyOurIWtucVjGuYqRPVh0h7gPVk3JwG2W+c+M7EmdTIA04A5?=
 =?iso-8859-1?Q?SKUfq/FKMoZhIb5Z0G7NOHEArfHHq0iaSjR1VtwbTKSvwVk4QPrFYwBv7S?=
 =?iso-8859-1?Q?kpsTzjs2/O2FGgQPDOfjth1r83lY+9FePnieyjRstloLRW60r3DC2UI/a1?=
 =?iso-8859-1?Q?DsB7YFyXqYWUTnGFnQGIBy1TVQS/Q+bDj3i3GFirGUx7G8BrHpgdHXLNX/?=
 =?iso-8859-1?Q?GTR11zTUSryJRNlF1DvgllJ1T/GhTTMsBfVT+WtaEvtEifDXedqB2rchtd?=
 =?iso-8859-1?Q?W8BS7Ebc36eDIDbxfWkOnShkkbAIsFFZPj4Ef/9XN2An2Jw9K9YS41M/FY?=
 =?iso-8859-1?Q?geBapNJbYLa5DTN00UeeiFRQ9hrAxsZezGX+J1e2BzeJw1xHInbHZYF1An?=
 =?iso-8859-1?Q?2PyWnV+07Ix8mXZz3+aFXOnLz/vWaeZ8ar5ISClSy3rv1f5RqOUZKy/J+6?=
 =?iso-8859-1?Q?YxU3IyjhTgtkktOLPjRMrOo5q7ezwUVYi5fkB2UITp7KzqDHFq/EFId4+h?=
 =?iso-8859-1?Q?aTTH43sayePEXqmQObg1sLA/kTCQ8aETKRcKjNSjUuYTTmb5mgK1d2BVsu?=
 =?iso-8859-1?Q?18XEpNJdcXxzeeEe3Ju6tNHqJTiAsTH3khE+XeNMmu7iA2eNe2p1s0L/Yj?=
 =?iso-8859-1?Q?s+u1mIuVROsC0PRTtk7pvhiqUHWh7inYMF5J15uKmvdD2JCFf6gCQZ59Xc?=
 =?iso-8859-1?Q?ATnCbs4dqunDjCenE+pzXUJAXUY+ugq+Si57Wylr8JKq6fuMVmlq6zNhf4?=
 =?iso-8859-1?Q?TLqRJ6h2yKgg5GYu54ooTd+3+br9lCpF8a8uD4m1K+pM+GSc1+KW1OXg8Q?=
 =?iso-8859-1?Q?lJWo8PupjZ22LYudvInM+uSHdIIdZhyC5YzN0paJcJS5QGEd7SyvAWpnhF?=
 =?iso-8859-1?Q?L0NjJYXsVuqUiOR7CwQNdiA7XSKTm5uqNG8KNV59PzVWbfv0BnJxTYmQh9?=
 =?iso-8859-1?Q?E8QU5NVycDq9Es6ZYbPfqWIKKti0uoTQriCYeMPecwJrY+n5nATWsFA2zl?=
 =?iso-8859-1?Q?Jyb2OuiaZZaSLZqU5D8yEvfMXXeGGAW3D1UW8E4IfhctlWgVGX94VmMsQQ?=
 =?iso-8859-1?Q?6qeGpBI+lrMBTN6aXfPX+mOyqdhYG029//9UpvAoZ51ub12PUNCgPpa5d/?=
 =?iso-8859-1?Q?/r9rGfnXTcEnYXVS3fhpQV7GwOrQ3BK373lxrSlvwIMHPxqfs6rrCWc5JE?=
 =?iso-8859-1?Q?Wh9vheG7ROVd7qAhhP0j1rlIs0rd8YGpSsMHh/O5ScxkKEq86/99/cXQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acaf68c6-2181-4257-abf4-08dd515b6506
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:05:13.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFgRckmLYmzDTnAjct4Yr3Yk1Ncc2pZ8jWhbeFOYlQ4gzBMJm5qarMhgoc2xwYF1UpmIGVEI2Z/IAa7G/3xifnZlbElOSO8oZ+4RAwvVt8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
X-OriginatorOrg: intel.com

Ilpo Järvinen wrote:
> On Thu, 5 Dec 2024, Dan Williams wrote:
> 
> > PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> > enumerates new link capabilities and status added for Gen 6 devices. One
> > of the link details enumerated in that register block is the "Segment
> > Captured" status in the Device Status 3 register. That status is
> > relevant for enabling IDE (Integrity & Data Encryption) whereby
> > Selective IDE streams can be limited to a given requester id range
> > within a given segment.
> > 
> > If a device has captured its Segment value then it knows that PCIe Flit
> > Mode is enabled via all links in the path that a configuration write
> > traversed. IDE establishment requires that "Segment Base" in
> > IDE RID Association Register 2 (PCIe 6.2 Section 7.9.26.5.4.2) be
> > programmed if the RID association mechanism is in effect.
> > 
> > When / if IDE + Flit Mode capable devices arrive, the PCI core needs to
> > setup the segment base when using the RID association facility, but no
> > known deployments today depend on this.
> > 
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> > @@ -1210,6 +1211,12 @@
> >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
> >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
> >  
> > +/* Device 3 Extended Capability */
> > +#define PCI_DEV3_CAP		0x4	/* Device 3 Capabilities Register */
> > +#define PCI_DEV3_CTL		0x8	/* Device 3 Control Register */
> 
> Should save/restore too be added for DEV3_CTL?

Good point, yes it should.

