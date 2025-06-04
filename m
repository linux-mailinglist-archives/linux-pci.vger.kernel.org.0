Return-Path: <linux-pci+bounces-28925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48026ACD0BB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 02:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8EC162647
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 00:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACF2B665;
	Wed,  4 Jun 2025 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdNbVfZ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C8846C
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997739; cv=fail; b=anyqJZMEch3bgypOL95NEA7bJ/n3hIuF9kUoyHSr5pVvadUp94eIRrVxTHo7mJxliyUG40Z6KcEOCB46BztSuR4hBAc71qdEV5MLAc2N7Nn+YlajbLB1prt1KT4OcNddfjQ19bCcnT36L3D0vmcX03HRCjWhniwH7yF7UYRUv8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997739; c=relaxed/simple;
	bh=oILX1uJ4PSfjhIxsPvPw1aMroub2jcRfO/u3cr3Sth0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A3mi2DMAdymAdYdt6H1GTChU/+VcjTqKRpb8O4ZVzdWEIEbrpnzdS1AfIMa5sCddZg7RO2UxD9l3NMMRIX0Naogb8LFZXzlgGaPk8J1ZbjsVWIoZX6AGq5IjdtTfsl7rRsmKCszkyndokyyMM8ADoQM+mtosTdnRP7cQjmHrfPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdNbVfZ4; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748997738; x=1780533738;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oILX1uJ4PSfjhIxsPvPw1aMroub2jcRfO/u3cr3Sth0=;
  b=ZdNbVfZ4LxhOIfeCY+zDRCndTJwz0ByNdhdCf7/YgaoawLGf8Xb3gd+S
   8Ml8ph6cI0Pj3SEFjj75Zh3+tMCDfj+rMVITzNzDPMjZEW9pZcZZBXSfv
   N3C60m2dmtRu0IBJSRMxRXyvIst/7U4sdc4jcGf5nOW9bssCtYCZMLINW
   +9ofA+bUPlnAymN35iTcPPSx6NyttvsG8UwIxK9zxN1oXjGfszviG9rmH
   xE92l2oXQKGUwKyw50ZJnuwtCA0gRn6EtYPi6Osdb6Ts2RZVVVCWTmd4y
   eQgro6IqxTnAGGjhM2cS1OlMO903HzFzImMp7NHKXy/Lr+HQonIG4QbHa
   Q==;
X-CSE-ConnectionGUID: HF39qDW3SL68ABtP+CqR1g==
X-CSE-MsgGUID: u77Mbs9ATnCEQx2W9bxkQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62450203"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62450203"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:42:14 -0700
X-CSE-ConnectionGUID: 0YS0QQJiRWeT6k5dULRzJA==
X-CSE-MsgGUID: gTJPSA+dR6qIRXL0o1u/8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="145633606"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:42:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 17:42:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 17:42:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.71) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 17:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nY9x7OxY6pHEBL0nuvnJmDN2qPqIqyeqliOUxIi2/M8tzLnV/Vr4LOejloHsBBX612Mvg5/kRVvEPVbC4lVqFnzuWKVQuWPRL8XApQbTiCbs8aMzOlmB8HHlSNeRBxcnjxAdlj2iYPnr2cHBV109HvzEhiNPFZLSgZrcvI9wyw/yz5LQZN6iZZQwipwd2JtjqW7H9Jq90Iq/FUIlpBGpk8lGnnCgie0+gWojbWHdgiimQtl6eR5tpkghWWAZe7lVzOv2khE/AyXC/W2aR9jKdrjrbyXtIfsx9q+xSmevfou/F5b9qftcVwKUx2r8NT7dWnnyI1QRd12wszte/EMYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anXVMf910GzxytHsRSgIQ7sAyInmx5CBnM6s606RHzo=;
 b=f/WoRi39qIMjxrOjfhEIfuJt+TLor/hkd6C/bqvRyTtTUxg737/KsSvfhfHwT+gWuegJtedx8RpLvE7fbCCvaQWP6oBGA8Y3a9Hf25wwc5D9P0iKMlANNF01pPEqZ7ZusL5H3e4sLWjonWzJOg1ZD98JHaVsCM/SrczsKoCDqescG40sencuRKsBLe/PwQgVOweE8l6Lhg4aby0DrMp6bwCdUNKOgkviGYjGf4OtImkFtUA8VTNNdEM5SO3C3g9lRd81bSYDLSLQHvNDMCL6Aopn79jbjIVeBhxZWSykezSNSJFaqFjeItg7khtxqnKrkeouMfYYiPGSl6KM2ap7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6873.namprd11.prod.outlook.com (2603:10b6:806:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 4 Jun
 2025 00:42:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Wed, 4 Jun 2025
 00:42:10 +0000
Date: Tue, 3 Jun 2025 17:42:05 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<zhiw@nvidia.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Yilun Xu <yilun.xu@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>
Subject: Re: [PATCH v3 01/13] coco/tsm: Introduce a core device for TEE
 Security Managers
Message-ID: <683f965d41634_1626e10043@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-2-dan.j.williams@intel.com>
 <20250602131847.GB233377@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250602131847.GB233377@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d820a78-6633-494b-c3fa-08dda300a35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w0IMDmbJLmNkfJSd6uk9qgAZt4vkY/9N+yCJlXaJSdaSJgnqhZ3oAbL1HBS8?=
 =?us-ascii?Q?qJxve38Be9N6w2+f/GXpgKNOigX6AqKFDiLn0kC+xNg0zAyMNm39J+ouA9Xp?=
 =?us-ascii?Q?OejFNhAORuI1HYvcETDU51GrGOQkW3XkSSZeYLb7sj4UIazNtnMUhp5xOaya?=
 =?us-ascii?Q?RMEyt3swN5EBeWQ+hJA4GvFBPuvR8uvWawKvDqn/YIJJPIYYiKnQdAuk+Jxr?=
 =?us-ascii?Q?AEHD1ub7RGrUF2P74ciUXTwcX5ek4YfPbyRrXYn3WyVmpLd/YblccX5rJ6NF?=
 =?us-ascii?Q?eL2PHprpT76MMW86lEJIpcX00FNakAktLUgStyScLpmUbnH8M6lxbqc5OC0t?=
 =?us-ascii?Q?cjt3VRrxr6XBXR1LdJonuFuAc/MJBvWWHGUElq7iofwthV9/y4vQ50H2uwSP?=
 =?us-ascii?Q?xIf/OXGp5dMUSzePlRXN+RLGTIG9hFz/lEV8eNIgi60qAuvBPdliszAf4Jht?=
 =?us-ascii?Q?3mwl8LPkzsfgLGeKALjEkjcpRoo1I7Tg1Dcypr2pocCWm3mkxJl2rBT8AXO0?=
 =?us-ascii?Q?SgZDraoIbpr5602Zv/B0cj0GLpsMXrIkttoNMjSaKUUsNv/urSwU/I5tiShx?=
 =?us-ascii?Q?yJ4xm/5dtmfl24zEEJNPoMjqr6BI8uwQYufcmBUbhP2+wwk20L/bkllMxyPk?=
 =?us-ascii?Q?b0L26LhUtyIkVx4XgOSw3k94wsrQaMwotlf8a1Z56m4oLOIMAxZIXT9HBfoz?=
 =?us-ascii?Q?BqmNr4HG7EWpQ+Kf7VxlRHLZ1SaLAkiZpMr/RJM/aEspR6E9EpCe5K9Cq1MU?=
 =?us-ascii?Q?GZdoTf+do29WjPAkbywtcgLBsdCIhBAoZwKNTQx0obgxCAYgoy9AqLvOF1Uj?=
 =?us-ascii?Q?12sR0Pe9XMnjySgcOUk6/lKJmERYPlEzFNUlExtlgr9h6m/5lzDnllDXxG3e?=
 =?us-ascii?Q?aaTgod/VVbqrPmNhAAznehDq5I2erJSK91h3l9d5lv07moapn7gzqKVrbu1D?=
 =?us-ascii?Q?8bgWDVBjCnt7umG2l7ydbAhFk80wa1upuWEIWvTpxascsVANb3ALoJ8bAtrC?=
 =?us-ascii?Q?NiImd7XPMPEwQV0saDHN3KyzNBBJnasj5PSbqaU9kIBam11GGCMDBKf2lVCk?=
 =?us-ascii?Q?iQEFHfMGD8MsGbV3OyT0eBazxHGGn/krdMFfxNGYB/w38GB8xRfp6esYZE7I?=
 =?us-ascii?Q?agdn7eyELs+Wqeaa0nF8DV11T3N+BLCmkhm+PjslxloNNLrAeuWop9+hgrTO?=
 =?us-ascii?Q?TsTQLgZ3c8gsOIunyEWMdR5ual80dFnua4CqMCPk1vwxuDK032PW0ea3irav?=
 =?us-ascii?Q?IP9aNsa6vus7KGqdaZE5xayYmnqBJNlOm0ybAyh6MNfmisTyN5E9nslbdxoT?=
 =?us-ascii?Q?DI6QSKOdt0Sm1OC2POWPSrE5XkWOzba1TpU0EzoNkQwCwYRWcaH6U79qIWQn?=
 =?us-ascii?Q?JOY1kqdM1o5J3DWp5QE4ZFTe5cdxBWWc2hu2Sl+N56mBgX0vAVJqQ5oFDeLN?=
 =?us-ascii?Q?M49sRr4fY+g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aCTuHzP09Bf6NPuyveYeKNS8VjDRPHQYfGhEt/bRf95VgSFyAmJtMq7Lc9Ek?=
 =?us-ascii?Q?RdD0DbXWklOh9OYJRgverwcbhxThqbQpU73Do0TK9Lp1kHrVCVseDV5vfiI6?=
 =?us-ascii?Q?qC9H3VFd1cdai7FV9Xq98C+FK22mOZ/bDpYlV32cpAnRMk7HK2+JN2Twb5fj?=
 =?us-ascii?Q?oJnr/NJ/5jdYTDhmm8lxzi7GPRvdpmhkajzZNscfncfEIm/98gYfuvmKDI9C?=
 =?us-ascii?Q?RvNfs1V8azCQ+o7ewd3XNDviClasxUvDUCYSMCBgsDM/Idc47XVSSwteTTKm?=
 =?us-ascii?Q?GuX3tm81u5AWb18TaWXz9WTYLNZBWGTzMICvdetD3TCZmJEn4asgHRtArYIG?=
 =?us-ascii?Q?lwXjB3uvJgMO2jPqqRLOyHJztn8u9a8poO1/9cwa6hBYaNf9CxSVWMEADvsz?=
 =?us-ascii?Q?4K/rIEJdjmI9RVgtLospCaDFXDrGKRXqVRV2rAhQnnAaTpmJeZZMOM84jSS9?=
 =?us-ascii?Q?pfpWZKx6Xzm1tlF3Y/S02qajriGQSrc2EVbxPkeoJJlD1Aq8aVXKZImHVK+Y?=
 =?us-ascii?Q?cp7sCjm9iQ/oV3PXq5TWkA3KcU5WWPj3yFAWAfQ2qj/Cb+MHXyUC6R0I3Im1?=
 =?us-ascii?Q?oDGkQpFMWYLTj/rLqCbSMpzGIdXY7GQ2oUDEnGHl8QLT4UxhRJhpv0+EUlCw?=
 =?us-ascii?Q?pcPp0uJNV+HJqPkpLpkHpEsW9tLUfUETlEq31cX9zOvuLGauWjSZ/6gZUkS/?=
 =?us-ascii?Q?K4b8AXmsBy0r3Dz55H+FhUsarWWaXZReKWG92CMThEPypiOxad0may0+cf0k?=
 =?us-ascii?Q?qOnm56YdtWFQE/kgY8zyoKX+klx5pwC5Jwx5x7Uyc7FGaCCA5/jb9aTH1253?=
 =?us-ascii?Q?cxVujBHiRx4EiuiZtlMdzII0W7VZN83SZAsGb2bzu4K+T9yqeylfzo4XxSup?=
 =?us-ascii?Q?nbItiz3vdXz7SdIPoUTUX3/oRlUvCZGXmmiAyIGwoBeSk5grzhuSylmKaOdm?=
 =?us-ascii?Q?ezX22XZN4XiVmlfuPBYQyFrBiSL5PPrHcJEJhz9slG8nuuOGNWO5nCpqeKao?=
 =?us-ascii?Q?8CxAhwoe/Kmi4w8Fjz4forFtrPy79F+thgQEEJjc3Rc0YsSyY1wQ5MWoCkd9?=
 =?us-ascii?Q?oqBkS37TpFjKwVgnDB7XKCsNh0WeN27Y30LCXYNaYNIlzmM+Hno2Kon55lBd?=
 =?us-ascii?Q?61hFGeZ5aEC8ZefvfyuXBSoSw3LoDpnWV0BLq/I7RYvDqaiwznWyba7pdy9F?=
 =?us-ascii?Q?5u56CJpMd/36MxdhQxfBOeuFlUDhl/ccmrDvt4RQAQV7XVs54vwnUtYOd0LI?=
 =?us-ascii?Q?z4OmUWoNPDpyJRMqFcVCdzcfn8ZADH21lUwpanu6KkiSzlZ9Sw3xdQN4D4Q5?=
 =?us-ascii?Q?AADyYnPGEBxAZRs4jJQJsBi0pnt/cSraKrQq4B7EsW4L7G63g1pdL5hIEYwa?=
 =?us-ascii?Q?QmaZ+xy8QrERlr31uT4AGbuP/r+xJyc/09yxFE4H0Bpx4/Ec1Pwm1VmTgzf+?=
 =?us-ascii?Q?dB8IYJqW/JsHVieCh5ef2fbjsrx8n9nFirIiDl1i2x9IpSmYgKw8qqm+kNcC?=
 =?us-ascii?Q?961Y71CFdTz9jaS8WQm4yvxE3cOE7y/niniv3I17K7BgNO8ren7DuQUJAfaZ?=
 =?us-ascii?Q?A8QADuOzh9R71CkGA6ErZfVav8cR9JifxX2jr/f1+QbCqXzsD4lwKFaUTFfU?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d820a78-6633-494b-c3fa-08dda300a35e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 00:42:09.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+eIVjhEyUeD36ksS+Zjy7eMto3wY9g1NpBF6GxdOYMHPj1CTVS0uANS9y8RSAdaz3L3u5Dm96UIibEpYq/q1c2IvZAlZU39PZ6ETYbgQ6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6873
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Thu, May 15, 2025 at 10:47:20PM -0700, Dan Williams wrote:
> > +static struct class *tsm_class;
> > +static struct tsm_core_dev {
> > +	struct device dev;
> > +} *tsm_core;
> 
> This is gross, do we really need to have a global?

Let me restate the assumptions that led to this, because if we disagree
there then that is more interesting and may lead to a better solution.

* The "TSM" (TEE Security Manager) concept in the PCIe TDISP specification
  and, by implication, all the CC arch implementations, instantiate this
  platform object / agent as a singleton. There is one TDX Module in
  SEAM mode, one SEV-SNP CCP firmware context, one RISC-V COVE module
  etc...

* PCIe TDISP is the first of potentially a class of confidential
  computing platform capabilities that span across platforms.

* There are generally useful details that platform owners want to know,
  like number of available / in-use PCIe link encryption stream
  resources, that are suitable to publish in sysfs.

* Userspace is better served by a static /sys/class/tsm/tsm... path to those
  common attributes vs trawling through arch-specific sysfs paths. E.g.
  SEV-SNP device object for their "TSM" is on the PCI bus, the TDX
  Module device object lives on the "virtual" bus etc...

So, create a singleton tsm_core_dev to anchor attributes in that
"cross-TSM" class.

