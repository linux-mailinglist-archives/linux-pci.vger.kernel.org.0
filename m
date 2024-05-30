Return-Path: <linux-pci+bounces-8070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4561E8D4622
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 09:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4B7B2274B
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324E2176AD7;
	Thu, 30 May 2024 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kp71d2ZT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A251176AD3;
	Thu, 30 May 2024 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054458; cv=fail; b=D4ff0V62SSEod7JKJeHsvDR4GSpwtxaKiNZirGP1JjGs6/TP+U1C3Fq65v2NsBFVrg7a5xYkHB8xX9VNv+h4AhYcSLwp5T+EmS8xpnMG22M563fmdhuEvY954ynvrO3KW+OSs4guH9W5XDw/PlahGIAXQBRKqup+FpjMIbrcli8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054458; c=relaxed/simple;
	bh=0rOi/LHi+FN5ktzWjYIu//ejW8oEpHYjxJHciluiTWg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q66PatUclvGd4qhhvDEVZc5HgTa5+DFC/Lse7QJqs8DdKlIgnWj7S04kQm/i6fQkza+2KDvYkeumCXroOqp/L9UK/549sdI8gnC9F/Qaox/meTXC6xlkSjdurge9+2JNzdTsb+vAwHGuBtPtyMW4Fvv2EM+Emn2vC1uSUgWiizA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kp71d2ZT; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717054457; x=1748590457;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0rOi/LHi+FN5ktzWjYIu//ejW8oEpHYjxJHciluiTWg=;
  b=kp71d2ZTkS8HY0XV8SmJzUQ+ZjKy7+jdZxoClNPJO08xZbvVRjA7G1CX
   TUoX+jMgGRf9se5KlrlWaDY+D0fsSatZA9+d2yBJLdGKpXFJGzyhn2r16
   /UfljP+247ublZhXfCPiMrF5dk3fDpWXLo4/Gxq7T7q336QzNvx87y1ht
   wQm0nRiX6g86tw9l6UqFEX4GdjQN+X5GnrPIdhfvpfQwX5dKdiCp4iS1a
   oZpTJbL25Q3Sa+heRlhT28r94bjqvbOjHyv4QQ0UxsmqqdA5lWPt+Susu
   HXFawE2JlAyMnYvjCmMln50dfNXZY/ayAlYKXBOl0pF8e8Omc2Mge+uFq
   A==;
X-CSE-ConnectionGUID: qQtRSE1tQ4O4jfdG6JPAug==
X-CSE-MsgGUID: rSJNMTT8QfmOHWxx/pAW6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13639577"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13639577"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 00:34:16 -0700
X-CSE-ConnectionGUID: qACT1QYSSoKBuaZJm/3c4Q==
X-CSE-MsgGUID: 4GeHTZyXS86EZzOdQRBYcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35660690"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 00:34:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 00:34:11 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 00:34:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 00:34:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 00:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koLgvlgr9LV6h4bYZKcoXdmSbKJGwnMm8tss9VvDGQGZsGz2HUlExucFi7ax2DYy/FLZXC5abMn78pu4yeZ8tJ/I5Dna3M7eb4AUsUu44t3I2zFp3VOxRAdKxPc3e2dnlRErYAFc+BKpYauV1An1VSTeHGrNXYazWqqt/2sV22/7hswtfxwE4YxEMqMj1SyGpnDcEbgeeiupkvSrUDgYY32zUxCFHtSt58WKdnMJm1CR6f2ciA8WYAlpSavEWUnMV16NagDp01gpECvjOD0tvc5Xf3Fj+liNy4SaTF3TnSMgQWs0EaPrMFugFQU2DKJeP0B/VUhkGYJDGAzgWZUinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu9u29B8gqfxfR+Lb97bh5PezNDz5Xp0N61UHzL3/bY=;
 b=XCo5Xuqf1UgradigPPHAoUnDBNYaKHPpHEVLums7aILWv7/n6tc6l15uYVfSkXE9/tN2XRQv2DnEuqASy7pUgD8aSWWwT6ClZoZ+PRHYt2nH4biQ+e3/TiIAPi2cO3C1+uc5xBTiiK8JhcWQfLSf/GL3H9UaESdI8qz39wQX9rRGfwrW8XjxeA3O7Sy1xihAGwQmgnXPTtCoNgJ3XXpyp+ZdZ9ODvETxvU0pVO3KDNJ4o16XHqYVujNOsvA1Y/Y2xOLpOcbC7RCC9QUftj2IvTH7OaJdOoGqMsANcGfTJZGZgQLMrmULJpg68ui/Wlm5KpxEQhliwrhO5UViVneZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8520.namprd11.prod.outlook.com (2603:10b6:610:1af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 30 May
 2024 07:34:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 07:34:09 +0000
Date: Thu, 30 May 2024 00:34:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Kalle Valo <kvalo@kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
	<regressions@lists.linux.dev>, Jeff Johnson <quic_jjohnson@quicinc.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [regression] BUG: KASAN: use-after-free in
 lockdep_register_key+0x755/0x8f0
Message-ID: <66582bee45da8_6ec329496@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <87v82y6wvi.fsf@kernel.org>
 <87wmncwqxf.fsf@kernel.org>
 <87sexzx02f.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87sexzx02f.fsf@kernel.org>
X-ClientProxiedBy: MW2PR16CA0072.namprd16.prod.outlook.com
 (2603:10b6:907:1::49) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: a3436705-2a42-428a-6dd3-08dc807ae4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?exkDl79hTq3PXdk1InmjYKZRTCr6MERlogK1KeZSHtRkiyZ4RqU4Em0aD5kT?=
 =?us-ascii?Q?/hfkVSAXbrn3QzHY+zhEMmvnProXTgz9gHjGIYIXr+6ojbrBEr7AV5iE18or?=
 =?us-ascii?Q?hsKfWEf7x5LGTVEDt89yx1KiqbGIiepn6Z/8rKd3jEtH84bHsTTok9bMHxX+?=
 =?us-ascii?Q?A7/IUSo8kKSnkWfpBjZuv9nzrIbLWG42W42Nz3xdw8PgE1ea7CXXOr8TWiNj?=
 =?us-ascii?Q?xQZXDyQOesGOYFW1+5vE3QhJC2g/PLMFnZQts+dGQOMcK0mP6U+GFrsx1WVO?=
 =?us-ascii?Q?nQ+QmwIpX8elHQeMqj6hD1T5bmlbnifWWBIdCFgqy+K/eAkxM/QN1pkFK25O?=
 =?us-ascii?Q?GPiQ4fex323z8fzswuKa2YOShpWAsqgm34lnOnhNxKCmQhZdwZOv4FPbKkoq?=
 =?us-ascii?Q?h0ygNr9FxIXUDSTBedA0RD0Iz8vbpAdv4FdcxjanMXSt+Y16LwFY0lA38zED?=
 =?us-ascii?Q?BKRELGnUUTcdUJMigzs5pBPlcx1P2i8PCcCNdkW8LWUFJnIZAXU+eDooB/Gv?=
 =?us-ascii?Q?BfF5N/rcKf5FVKCzWt1zDlRn39CCFc2ktqvnIZYqSbRp91bfK8y5xJOoRhtg?=
 =?us-ascii?Q?Nz1b5z2z52TLbnFky9DImQ1c8Ldp+F0q/CE8U9VZsQVwzPXwuXxYQWEH3zTF?=
 =?us-ascii?Q?HZx9F25gsokMkNkeBz/Iduj6kAjyLVepmULgS5X8qGVjcjIJVmV6TB2lfgPs?=
 =?us-ascii?Q?Q2Q1oO1dtzF3MBxBUa2NLMaKVvU95BnR5ITS10ahr1wcW7lsYokix58TcdJa?=
 =?us-ascii?Q?O4G41LfoT6sy4P0v97isV0882MTYSI/QjnQreeYRrUUdDmkjdonDGQdKV2CA?=
 =?us-ascii?Q?vTQlLfmD7xhYYJTlf4WlYTeovX0cLIBWZuK77ULVeW458WlFrQqLgSqgabIZ?=
 =?us-ascii?Q?eA+dXmUEHv6rxKh96/B5I3C5vkGi9zBJIKpjx33foTjGt2TpESgvqzpVVYaF?=
 =?us-ascii?Q?sENyRzkRBGW2K9qchRjHcxLz9+HNUHctDKi6uHHqud/jTgf7oN+mWx9itq5w?=
 =?us-ascii?Q?8OD4K/fnQR6vzr1aPEx9qIa/RPbk679EntfGA2ZmgRsSZ2FVKY4ymBNREKYH?=
 =?us-ascii?Q?cLeXCPT9Gkcjd9lgaRQ1SB2UivPe6hW/B8T5Vg8lU21JQ607si3YTheHxNLk?=
 =?us-ascii?Q?MH4DzTroHwjA3CEiAIn9A3bslDaviLrKYWHNaJFDGuJ4pvRywpNiu3i2ptGs?=
 =?us-ascii?Q?7SveyTHPKx8COC6c6ZUaSA2stRip53oaEawkNYWJf02ww2HOSUOOOaT7LgM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NZc4XMVkaODW0WWFatE1V77H9Ij9ZsfzND3SnE+1URd54tO7KZQDYuZIZV0h?=
 =?us-ascii?Q?fBdUvS48fL6rrfnaSQsDvJ80gQRB2rey8QLLVBc2iuQYpEur59IvL9FpCQ9z?=
 =?us-ascii?Q?wqBELn6sxsqK0TMxx7+C4Vm7wy6f/TI06JWHRanC+ZPaMHjEhrzZOv6ltxWz?=
 =?us-ascii?Q?eAFla2RUmIGtBiRU5wtip5Wlu8xXjDg5zVQ1aGj8E6pWM6oeuk1ESOPNrqpq?=
 =?us-ascii?Q?icNTbKQZ5LwzBfZcLxUIyiGbGiSQkQr/LkPfXjRPWlLqdPLc35idAmkOwQ5z?=
 =?us-ascii?Q?pTQu9iSH2Z0Z0LP48Nur4BIvFQJemIZrEi1EG15hxCwnhfufXQvj+PYgbMC5?=
 =?us-ascii?Q?ZkUyenNZHTu1K6wco/ObNLBIVHL+CMH+yjmr3Zk2aKyh2+6CLpHf+A8aJVSv?=
 =?us-ascii?Q?W+yaq95Ml8QsZfWHhIwlKZjEXm4X4RGnQlmuNXA0htSQBlx16wfvDF0Der4W?=
 =?us-ascii?Q?BpY/SwJ/0jhzw0uHJxwGWAWfYORuHne1Y5m8eXjA2LeUZoqcSZ0KKifeYNyr?=
 =?us-ascii?Q?zuxwFxyA98be7Qergy1i0MJ/znYpGBy0WeDYEF2Z6YfAK1b8LmG8Fuf20idZ?=
 =?us-ascii?Q?B74AxxJXLZY2BuSwDb3gcCDQHjEiHh5Mbqh94bo7KbVW/kkRGs4MfxR78pZy?=
 =?us-ascii?Q?9HRm9+JQh9ugbGWGfBjro4lwBuEXRvZE9EIOJ/3GBAOhfZ4NYb+wosju2yb5?=
 =?us-ascii?Q?a7VPYhU/rAZimFtRIM/5CkPYIKxHGNj4ZTSAblo1VFO4G0flo6/nsESxwBi0?=
 =?us-ascii?Q?EkYKHHwJB+wLPTOJ79bkhj2BsqRLwzqhkp6KqiTOWVMCdcaufCcAX+TgcIcv?=
 =?us-ascii?Q?7urRasFtRj3rHBhgoKKQaNDQ60Rvk1NuieiQkr5uVWSwWF31wRbdQBYnf8Ye?=
 =?us-ascii?Q?l2TLjXNBn/Bh7WgBxW4Mokgd9QyNNoKcTY9IBwk7+kHvnr99C3ncN/xRS2Dh?=
 =?us-ascii?Q?cOKow3KfuGzu4Bvm78LpoRasM5E/Hez5/N9d7rUVS097RB8ye65HOxDRymbM?=
 =?us-ascii?Q?BilHB0mMvy+1De8ABAOUDc4GmbMRCHEJqHezCdD7YVb67XeU+pU8u20Oz9+S?=
 =?us-ascii?Q?Dv1jkXZnPZ1gwhc5mUMa3RDLD2s0wz/fhtCuYMptSSBZseQZVp8bCexP5C2K?=
 =?us-ascii?Q?OrzmKTOmLzTpGW/1fsnWSakS3sOl3VtNdW/BlsrXLL/l2rKhNYWqAtZ7an0P?=
 =?us-ascii?Q?jcvS9im+qDg9QVKw6Wn4L1S12TKB8ZGIK+FPu6iVIW8SweUBnbkc5XfTZ5Ra?=
 =?us-ascii?Q?5Fd6CbsKSSOydXiGVDfEiuPmKShhRfgHXNHvebVURcE8qC9hD1Y352gm/dBp?=
 =?us-ascii?Q?xOZyaekLYjdUjyCLwPggWC16Hz8QmEFO5JmeIH5zdn7U2Og1IkNmVMoyIlKI?=
 =?us-ascii?Q?V+uVAAechXupePXX3KkgxpYfJ4p0y5YdpcL/PWhBmp3GLbWPJ/C3STdOMqNW?=
 =?us-ascii?Q?QG0PIni9DoM+poGyagEpNG1e+O4jZ2N8LQVvczg2HL2EfFfJ5vBV9DE/cmqQ?=
 =?us-ascii?Q?5RJV2YqMR3GEkERj7IMDQZM3sgQVo+lr2pbd5PsfepmcECyPxNgEqtZQn0LC?=
 =?us-ascii?Q?wZrJLvvfssMsiHwIN8cS0xqbrZ9zQe7bNFrrQvv3/CO6ygx6ZYTsBmF3KvZ8?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3436705-2a42-428a-6dd3-08dc807ae4ae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 07:34:09.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQJUvQ1puUTLZ7T7oFUk0joz+x1NslXpJZQ1LcenMlL2uNLjxf1KpRl28RfR9WLTGBHU/wXrb+ZeQACy1Ps0LpS9zVtL89jSFWRJShn/8oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8520
X-OriginatorOrg: intel.com

Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
> > Kalle Valo <kvalo@kernel.org> writes:
> >
> >> Yesterday I run our ath11k regression tests with v6.10-rc1 and our
> >> simple ath11k module reload stress started failing reliably with various
> >> KASAN errors. The test removes and inserts ath11k and other wireless
> >> modules in a loop. Usually I run it at least 100 times, some times even
> >> more, and no issues until yesterday.
> >>
> >> I have verified that the last wireless-next pull request (tag
> >> wireless-next-2024-05-08) works without issues and v6.10-rc1 fails
> >> always, usually within 50 module reload loops. From this I'm _guessing_
> >> that we have a regression outside wireless, most probably introduced
> >> between v6.9 and v6.10-rc1. But of course I cannot be sure of anything
> >> yet.
> >>
> >> I see different KASAN warnings and lockdep seems to be always visible in
> >> the stack traces. I think I can reproduce the issue within 15 minutes or
> >> so. Before I start bisecting has anyone else seen anything similar? Or
> >> any suggestions how to debug this further?
> >>
> >> I have included some crash logs below, they are retrieved using
> >> netconsole. Here's a summary of the errors:
> >>
> >> [ 159.970765] KASAN: maybe wild-memory-access in range
> >> [0xbbbbbbbbbbbbbbb8-0xbbbbbbbbbbbbbbbf]
> >> [  700.017632] BUG: KASAN: use-after-free in lockdep_register_key+0x755/0x8f0
> >> [  224.695821] BUG: KASAN: slab-out-of-bounds in lockdep_register_key+0x755/0x8f0
> >> [  259.666542] BUG: KASAN: slab-use-after-free in lockdep_register_key+0x755/0x8f0

The proposed fix for that is here:

http://lore.kernel.org/r/66560aa9dbedb_195e294b0@dwillia2-mobl3.amr.corp.intel.com.notmuch

