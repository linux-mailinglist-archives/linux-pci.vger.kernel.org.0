Return-Path: <linux-pci+bounces-28905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C622CACCD80
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 21:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF68E188B605
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A91213E65;
	Tue,  3 Jun 2025 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNkVjCtr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA91F4163
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977706; cv=fail; b=jrhhub2r9CbR1W/MvcdE4K+tQu5NT2gNvkpFL1yZtEhV8VVm/xtMd2kJvwZ/BYp4m5ytWTfa+rSzYn2IdwrG4c8w9+Og6APAJax0rU4Eie3jILy7rKd/YSr0yvQQWVf08o9nsTQgv+D5Le21EVL9k+t1AD2TbAsyo1PWtiZYu8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977706; c=relaxed/simple;
	bh=NsQfSzxfVKoHDRZonpNnlzCGPnHsZjGDcXfmAT4DBj0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TX/N2cjyfW5iTYiPn8wkjr9Nmi5bxo031bZDBKPQauwe89v1xf0USuMnVIfdVfybAq/BZzCIm48WoFVC3MBRVVh5l96YuL30w5D0JzF0FoxL7fzqcuvA3kosxLHERQivo5oEG6wtGwVLfcfR2inCf61cyJ5UUtahBgVljfo/ajU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNkVjCtr; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748977704; x=1780513704;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NsQfSzxfVKoHDRZonpNnlzCGPnHsZjGDcXfmAT4DBj0=;
  b=aNkVjCtrLLTzfvszcMEsUD1iO/yiNUUCK6Wlh7bK3uNG3yF3aND8bw3I
   Oy4GPBqZ4zAgDx8Cs/A3lG0hS12OhuYuvDNaRxXsROEiXM6hJavH8/sQ7
   YQtnAqsoGK9gU0e1Gbe9l0Rp+y/fDXEFB2y5L6AfwgOO0ihaYZWMFFzvv
   I886i2uOpwUuUa608BG3JVzLgGi9B2GX6mS8l99+PZsrKHmCpqSN5wrBb
   Lr0N/zyoP/FPQXE5XNrJxEzfdaJ91sfN7YLXoHzTbGbdjBhtVNr/fD5vR
   L+2zvhWvB2ZZga0cH9hF/EC0yeYt8tRvAFB6dtI2Qrzvjl6DwcsjsFQws
   Q==;
X-CSE-ConnectionGUID: Ic6OLvEYTLiTAueTPkxCqw==
X-CSE-MsgGUID: wWl9wrzbQKKVz0DUbgCSqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61700936"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="61700936"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:08:24 -0700
X-CSE-ConnectionGUID: VoY7x7h8RKu4WYZXwIQg0A==
X-CSE-MsgGUID: 1nPWlbUvRmqoch3pRElFTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="144839621"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:08:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 12:08:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 12:08:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 12:08:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLEXlXvbrtyC7Tf1VtkkG9hwKw90whB6kMQw3V/sJmeN1O4TPQl+eiQAVNMwhrHm1JTLFT+cX6Y6GXC+42cxyIiEAeNh1L4JlcDWSNgGt2rWJB3C+yuo+I/7+nHAGNMMM/U66bhnY59MBzTZmqlT1g/2PeQVj1VKMAYUDZo8yQhEt/EjOeRy/fLFwMqTUI7oB7LOLzw5pj81tRTv++UdKD8n/mONDmcfHbHPdJRLqJf1enr79mk7YOnpM4Gfk1v98P+l3BcrNlxmThNdjTHgUVoVrZphKKvja3h84GDRCkd7JaernLMX0cORvnBvCTaTO6u5G7h613Zp8ZMHxrg4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA6SlV8rC43DZYSIZYUlhP2LOJJNO6YS1XF8ZyBXk8Q=;
 b=ow2H/zTIJvW4Uc4Y3chGudU18Q32kNKxqw/cQI1Z3uo8KjhVJgrNixAICjkm44b4hbwE5mhEGHcxQfd4NOHwGUBagdojCmRyEmFpfGunzrlwvtV/LVB/lz9L+N8FFsXOYFUuz+YKCuhHNlJqDRRxw+jpiZQZwjt3Oc3T+s/VqFHzPMgcxgI9mbkpfyBQ3y/kz+vDL1Z6+/MDNfYy2TgUsKdgHdgs0eIS1qh4mBK8VSDCgiHGyCO1X3sWiFj+dfQYAGVtRY4dg/cU2C4JWNxB96oc58bHxJRHMD69R89NIyGCO+6XKCKjiFB5BfId0kb6d4S8RAKISq3R47atOjeN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7567.namprd11.prod.outlook.com (2603:10b6:806:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Tue, 3 Jun
 2025 19:07:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Tue, 3 Jun 2025
 19:07:40 +0000
Date: Tue, 3 Jun 2025 12:07:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>, <suzuki.poulose@arm.com>,
	<sameo@rivosinc.com>, <aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
Message-ID: <683f47f9933b9_1626e1008f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
 <yq5ar00j4kem.fsf@kernel.org>
 <682cf4aa3d682_1626e100b4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <682cf4aa3d682_1626e100b4@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY5PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d12157-34e9-4eb4-7306-08dda2d1e982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oqK3BxYGyfDMyIXAsFJnTYLTaMCqsAIu6788yilWTFZjLNR+zBbme7Oq9Z6P?=
 =?us-ascii?Q?TgmYmBfx3UNc7bpa429ymGGVoZJcKgNLoiAx9vuxYWvdGDvnNXxNYOoDQHWG?=
 =?us-ascii?Q?THowzj5om0k5IxDWS6oBYDWi93gZ1gA7YofST2DsoKpqeBTX076ll7K5V5V3?=
 =?us-ascii?Q?UWWUtrXQbiGl8g3HgqdXowsrChcM5gwW6rG0VrA+h/44OY0+JfOTzBZzwpb2?=
 =?us-ascii?Q?BsQ9ICy6bdDnMiOUtHmPHJnkU1XVN5mnjJuJbWfn2M9KavCHB0DyM+4tsFqE?=
 =?us-ascii?Q?NDa6yCmBiQtQ3IzlpfWnAVa+UCemAzcPrsQYImzqb7Ot3L6SU+o342kYIaOE?=
 =?us-ascii?Q?YY0spXky4sT6Ixfyaj0Wjp24pAunJXtgMzSF1wYC+MS8BbR5KMlO7DeEwfa0?=
 =?us-ascii?Q?4lLdyzFIM7uOwlWMA9L+iu1WMNZd8NQR5JEH/7SHmScTTYwpD/By5Hdn+o1U?=
 =?us-ascii?Q?90i8G+fSZkVAjaIgu83p0c/wAdln51r1IMaGrfR9t1QXMyJVrzuc8N9QAFKQ?=
 =?us-ascii?Q?F7CIe/zs9RpNBDgYDhFCcCn9a778shHmhGH+AqY6Rwop5h9NQdhaC1aNHDU2?=
 =?us-ascii?Q?p6f7Khr43+yrVrtSsX3Z1JbSwXPm7v809Sw29RwPifWSxkh6ReTQ/vo1rUWh?=
 =?us-ascii?Q?jnahscTlp+L4S6ndozsDQGn/zVTfJmuTx+vfHbMJo5gYt4lT6CMZmllLbQ5B?=
 =?us-ascii?Q?mEr7/41Fc8pbqD4QBomFuNWscX9x8nyafRph2HOFZqBRmbAwCo6fMLLG+txn?=
 =?us-ascii?Q?dXmJZNUdQqkp0BBsuQp7PAjTFma6YATNejmgLEBQzrQaHEf9indZroHjWfEG?=
 =?us-ascii?Q?HVEqIrrXurRyHI5YQohcWNBmMfHqGDSk8h0M1oCbybMIsH/LnbK3W543wq2F?=
 =?us-ascii?Q?ky2tE9efmCCi28Ud2VwJ6YIGYiSGBMmjRQP6pH19gcnhxiobZ81MY3odscXL?=
 =?us-ascii?Q?4HhDSrPrTEQyLqWuehuwA6bWSKDfMuNqWHf3dwsbl3PdQfS6mdHgMBYmebUV?=
 =?us-ascii?Q?n+6PIr0axHseKKzPg5TQ5dipfsMpS+LU7pbGwt8ydB2mTV09LcCdr600uXJL?=
 =?us-ascii?Q?ovMuOFSIqnlSntvp0W+IV+Wdy/DUau2+KV2ZIfKOSbF9xnG5uZsdOY6fZ+s/?=
 =?us-ascii?Q?uwabGFlCGGrkn6dWXchFkYB9Gt+JMYbmxYO9W7FG4tul6+Q5xfmbccXHvqNw?=
 =?us-ascii?Q?S9dBmQb1vs754vxliyvX1QD9QXU1E5nO/jnTImIFl2mo0QM3K9KAgla9Kyvj?=
 =?us-ascii?Q?9v0GiVJfKnzJRtOqKUGMCepJNhpyOAiZ6x7ukmI6tCB52FBVlSHEw5RLH3Ox?=
 =?us-ascii?Q?xeZ87Dl50VmEAkO1pSFiSkYkYAdS4RuEJZPmDMIyhAz7UT2Z2f9yfiX4js/O?=
 =?us-ascii?Q?wBALnbffb1WD24PZsmnlF7u1VtA2GCQlTIQ3o8jJHTueMI+avI42V1icGTwq?=
 =?us-ascii?Q?2jb50nCaxzk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ahGeH9oMcAc3bIIgC7YCDGIhBSliHn1AJlLdw1s3TVWOpJ3S8MrEO6pxPkk2?=
 =?us-ascii?Q?mhPcfZvNVkvACJvt3uy7wRDnmGLbBGJfwhqBonpEoRhamZI9ABYuOoePTZtE?=
 =?us-ascii?Q?96Ok4PpbELw0xgDMKPNvSNfIJhqmmqs4fo2+kHO7BKaWsTVmxKFFrMm69U7z?=
 =?us-ascii?Q?MPj2mH+O+BmudWIBjqovU84ukOms83gYesl7vSeQtUKJcmcCw0WWXXzguT5t?=
 =?us-ascii?Q?23wfKlARv3C8i/tOGhw6RF/CyEBnpERaTZkynp9QBe5uxjAMEmBiUQ78T8G8?=
 =?us-ascii?Q?4VavFGNYIpsRuf+BBdInaHQLtoSegOWNxStm4BkJjszUKhqr6t9AGV9k+mDl?=
 =?us-ascii?Q?MEAWul/r4VFq5wT+JVuAyLqQhL8WGrZSuwqL8zL42Ppvc5kQjsGvTsPYb3WU?=
 =?us-ascii?Q?U5NF7ypzpaJjviquRLXNMjy9vZ3eNLhZXpqJIcWN7xOkOMMyW1dg9D7QPkTf?=
 =?us-ascii?Q?KX5CjEGNg4IdZDsi/cLVhlAMafRGBSunGpE+t2xFjL7IFstgsQBIR229xqaH?=
 =?us-ascii?Q?nDOhMjkB1fVuCN6/Ca5OVYuSUlRlBcO3wF+rLn92m7CntA+mZkSE58D3OuDv?=
 =?us-ascii?Q?PUuLhez/COxDrjkHgk5l/MET4/roSdZMZUR+XhLMi3hI/VFJVZdWfQvqZvm7?=
 =?us-ascii?Q?aSdiCXtzfxXrW1NIP5iRkOG2r4Z7Y+JVYMYVvEqS9H8gAF5P5x5T0A6RAlio?=
 =?us-ascii?Q?BZgrkEdy6C90NFX8FEZ3XpTzGRQJwwcEE6+9ZgQ7+W9mwbKxQIJuBE6cSYU2?=
 =?us-ascii?Q?szVHVzKqojmHEtm1OQ/yeqTQFo1q3SK+p9wg9lrXZ+TeE4/iEE8BpNjmUy5m?=
 =?us-ascii?Q?jONEfTa31UbBFryG5kWcOGojXqptTZ+OplyqbkeOKskuNN8BNzTYM5mhzOur?=
 =?us-ascii?Q?a1+xKP3R0FNbd40Avd+eYr/LjyGO1rUhMEs6CS7rponpEN6UfeTC13FQCH0W?=
 =?us-ascii?Q?8tDHc43HmMZ5y7ClCQxmKYvGLFx/tERgmgLzkKgKi1zLzxx5H44VMe8aRMIA?=
 =?us-ascii?Q?IKWCX5R47YV6Lq6H25B8RAyCw+hJ5AsSCv6K6hOxfUbS2BrtUIjVsirFp6zc?=
 =?us-ascii?Q?oHaiHy5J6AKURawkF9VncQZtgmpNC2vd7L8d8wEJ3DqYkvZ5uNIifJnnNV8c?=
 =?us-ascii?Q?aTRun4OUucmejfgCSR3tfU088I3/O+I1lhBUGaqM1gYFm0EEp0rflvVu6Hs5?=
 =?us-ascii?Q?cyQBOcnQTUoyrj3kgnDhpk3DzbMhAdan5CsB4OdrexFX/BJWDF14ivLNK9tV?=
 =?us-ascii?Q?zS1uOjnhlt49tDh9s3GEviLph5g88df30/b7nKr4FCJPTSnrldA3yaY3Fk8o?=
 =?us-ascii?Q?xkuqihpDbDajoZVqadoAQ+4RBcpMUb1k7tm5ECiZoEYZ9UW3Eg33PUJzGkVy?=
 =?us-ascii?Q?IxHoofPOwk5MOKPvG2WZfStyUzEsO59AQhWgX5b+aYp3HcKnzkoQ9ylGZGQE?=
 =?us-ascii?Q?58/MDm+8gbeuYz2usDl/8AQrRXe/TCqheJ+YDFA6OCQtB+NvMqiykc8vuQNb?=
 =?us-ascii?Q?nB7dc4lqkLXEHHU3rUpsczsa3EHSlKynXm/Nv942Rrqc+r5WwuE0JiiOgx3v?=
 =?us-ascii?Q?SQP7ZYAuBr7JZARr37HGrA3tlX4GdK+H8dOE7ZKsO20YeSDkT0joSBNQJgtY?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d12157-34e9-4eb4-7306-08dda2d1e982
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:07:40.8283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvDjK/csYUQZ7+UyGr4T6Kfg+z7rupPit/P3knbHuGNq/hzah18gld6yMy6oUGNzJo/pgx95JSQfY9BKUtFU3y1KOa/tCOyiohVny9Lf/PY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7567
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Aneesh Kumar K.V wrote:
> > Dan Williams <dan.j.williams@intel.com> writes:
> > 
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > ...
> > 
> > > @@ -558,11 +675,11 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
> > >  	if (!pdev->tsm)
> > >  		return -EINVAL;
> > >  
> > > -	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> > > -	if (!pf0_dev)
> > > +	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
> > > +	if (!dsm_dev)
> > >  		return -EINVAL;
> > >  
> > > -	struct mutex *ops_lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> > > +	struct mutex *ops_lock __free(tdi_ops_unlock) = tdi_ops_lock(dsm_dev);
> > >  	if (IS_ERR(ops_lock))
> > >  		return PTR_ERR(ops_lock);
> > >  
> > > @@ -573,10 +690,13 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
> > >  			return -EBUSY;
> > >  	}
> > >  
> > > -	tdi = tsm_ops->bind(pdev, pf0_dev, kvm, tdi_id);
> > > +	tdi = tsm_ops->bind(pdev, dsm_dev, kvm, tdi_id);
> > >  	if (!tdi)
> > >  		return -ENXIO;
> > >  
> > > +	tdi->pdev = pdev;
> > > +	tdi->dsm_dev = dsm_dev;
> > > +	tdi->kvm = kvm;
> > >  	pdev->tsm->tdi = tdi;
> > >
> > 
> > should that be no_free_ptr(dsm_dev)? Also unbind needs to drop that
> > device reference? 
> 
> Hmmm, are there any scenarios where @tdi can outlive @dsm_dev?
> 
> The end of life of @dsm_dev includes pci_tsm_destroy() which should
> invalidate all outstanding @tdi contexts.

So with the move to add @dsm to 'struct pci_tsm' this mess goes away.
That said, it should indeed always be the case that a registered PCI
device always pins its Device Security Manager. In other words there
are no scenarios where the registered lifetime of a PCI device can
outlive the DSM because the DSM is always an ancestor.

