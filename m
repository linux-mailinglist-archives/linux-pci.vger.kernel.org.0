Return-Path: <linux-pci+bounces-26258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE81A94047
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 01:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99C18E32BF
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 23:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DB02512E1;
	Fri, 18 Apr 2025 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfbZfQVK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7892459FB
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 23:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745018948; cv=fail; b=OeyCgJu6NT7jONyrSgtC4/w7p6dRSvwMtA+Pc163LdANjng3Hw4JM6qYXZJpI18ec6NZe40RM6E+djMVikfNpdgyOEzCdI10f2yRTZlztClvvF/i2ARpz9O/jgeu8VB4jDAtg+tkcSCj8Mjgkk8KtP9/kgY5h/UdXRaK7nCE/cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745018948; c=relaxed/simple;
	bh=gN/RMWS9/xmd2vyzP2YFRpOoWuFOIjQZvR/Mf+6teHA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EYtt1bAZw8Yalt5YAPqfEh1xGeEsVfzXqO/bQN8bcS5IiYGDTNe6BDva8wyjLfH8wIWxgetEvcVJOwEzeb19R7FMWLMdhChRZTbGquGnKWV/xaJXzlZlomfN1JZ3c1MZy6ZjoF1J9lX2p4aaNgFOA05cjYWphb02oFk/8iVdHd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfbZfQVK; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745018946; x=1776554946;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gN/RMWS9/xmd2vyzP2YFRpOoWuFOIjQZvR/Mf+6teHA=;
  b=RfbZfQVKq7LknfSL4CuE1Y37CD5axBvPOk+S3k0Cw75cCqet0LVlZvx1
   FytLAE6Vb6hBFY4vaUFbeVlhIHpoHelLv5jzj0SyCxELYh81bFdWghLZM
   J7q/YtnChIfc6bcEaltF0ymLUsLgb5gdusKfkfSnYQ3DOtYkmzFnOWDbe
   1r/7vbu6dgmk9h0iA53F3Spj5tcyAbLP0dDC5SyY6g70M80q2dAkp1jZq
   m/PPYBDeHQCZOp7qHiPU3f1KjpALTneLPpyc26xOvddJ6Y/tgHTlKKSVE
   jqNOhdu9j/H9oGwa60YaIdr6pMEFAod/IThknld1wgeRXJOhESz+/2o18
   A==;
X-CSE-ConnectionGUID: QPuCxDQtT8adP3vI1NUhiw==
X-CSE-MsgGUID: O6aq4pklSZiCyss9NwHH/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46660626"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="46660626"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 16:29:05 -0700
X-CSE-ConnectionGUID: S4Ltqsp7RPKBn6kQCalRPw==
X-CSE-MsgGUID: x8omYJYTRQidU9X9Og13sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="132120340"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 16:29:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 16:29:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 16:29:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 16:29:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvmWDcIb891bnXYpx1FbBbh6vY752SORDC1q7cQFnT1oyAmmSWEklJeS5AN+E7UjwHhmZRVpFaOD6WEpOSc1kWMu1CAfAbYR4zqKty5/DCL6KPJFzsxdRmOjjCq0V7t0m2v+Qln9mKmzqoF1C7g79EQsMvyLU3273mDDmYFx++27OH9tBf+mMK7ZoBah550AZTO/+LoqgEGfrMp9XCq948WQ9lpQD8+a45Oms9qdj51dh8kFByq5vaiEamIt/+No2nKt3hxatW7z3K8bvPww2PWHw2ND7qsi3OmldMveVscbgmi0GE5pEAhXRK+v48lKFgEe3UeZa/m2rHLLT35AyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzQh+94+HQV8nuS8SIhl6z/QX6J62PvF/FcI/WjP5Ws=;
 b=R9e31BhvF17Nc1qL485YiDotYUfVNt5rmn9L7f68EKgJPu0JasGn+vdt6KmvoWkxbDUPpcdw6YQfcnB9VZYhjOaAdz5WHlR2nMZ1uVS0DztuCyxZqQuPT1sBK/g+ivmdZi5D3zUKFIEVBSyFx7eipOh7L/N70Nn/+9O90FSJl7K+Ryj+RF+lIwyktbPbfs/v7iyC6cILWIed1HpetLKyG8b3Y2npctNPgBKIfGs5ZHuNzJB2ENKHBR+j6rS+miJA5FYz0qqBoj6t+qn9Y0xfIO56xE1A1OokJRW23Nsq1pOr7yTMUcMdijsmPY1Vf/e/ddn/qd0u/TIzfD3HB98slg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 23:29:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 23:29:01 +0000
Date: Fri, 18 Apr 2025 16:28:57 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
CC: "sameo@rivosinc.com" <sameo@rivosinc.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "aik@amd.com" <aik@amd.com>, "hao.wu@intel.com"
	<hao.wu@intel.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>
Subject: Re: [PATCH v2 02/11] coco/guest: Move shared guest CC infrastructure
 to drivers/virt/coco/guest/
Message-ID: <6802e03990cc3_71fe2941f@dwillia2-xfh.jf.intel.com.notmuch>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107246641.1288555.208426916259466774.stgit@dwillia2-xfh.jf.intel.com>
 <e196f01be3b5e744cd51014fa7a3cf5595a9ef5c.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e196f01be3b5e744cd51014fa7a3cf5595a9ef5c.camel@intel.com>
X-ClientProxiedBy: MW4PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:303:b7::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4648:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef1de3f-568a-4c9f-6df0-08dd7ed0ccd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ye+AFeMZiIjbzKD3VeLBG+HLbDAxcNptYI9mC4MCHv4H+FfJzudMUmAmxf3?=
 =?us-ascii?Q?eXQKShEFgxOQ58R0m1jzjrjvKqUBGF000GMltptrWLelR85l316FxonwDJhK?=
 =?us-ascii?Q?8keOx8cT3YiSHbjtpympGwX45GqSEBveHPzeelY9fkcZ6rNREx71Y7BRxniG?=
 =?us-ascii?Q?kCn5P7dQWj+IQamoIOOf1YIauF3UyXS+e4iKvdW5BPcCd6wd1Sxqa7EEs38k?=
 =?us-ascii?Q?NgnuPHndRXwxTdqd7M11F0wQWnnr0ZB5J6LmfQ4cDlynN8EZ5izM2wjN4eNN?=
 =?us-ascii?Q?NLi7yCqIp41t491NFSCgvadd6MkSPWQqoAhPCYSxz+pK7lA3AMi60X3n1Y/g?=
 =?us-ascii?Q?KdRoFlHJurIjIpeHet7JgWb0xM8Q248lqM6xWG4wUbUkz+lagUQQYzRNO+tA?=
 =?us-ascii?Q?ZL4i9ZEIn3HHTeSTdOuQlweJF/odO/T4YNBh2LC4LtRvP1sW7GnwLJGqeS0M?=
 =?us-ascii?Q?nBAAAseZs1N4fjer7+QtnTFM+spPiIh2jR3Azj/yjPNRVFSdvYdFy4OB17Xc?=
 =?us-ascii?Q?4b5Ua7tl74z9Cd2kiUFn+ldeGrX7BFsMnlklzUVHXsLSUz/aCxT18ynwZVp1?=
 =?us-ascii?Q?ALzHpFlhIu6iD2nzrO1r+FyIdqFeXA50RalJ+Un4sCzGnTojHfanQD6agyYG?=
 =?us-ascii?Q?CCEFge13kdEzrF+gAYeZRis17RbleSRgHCA2auBHZ5/+A+9K+7lVsmAqZ4EY?=
 =?us-ascii?Q?Vh3QNir/ZPlR0V7jpytxy98pk+U5ejYQoCbthLB3lm9XajiUCm6BpCkgfMIh?=
 =?us-ascii?Q?Mrh7mfWaunuNv9IB4b5ZhwZQSNF2Qo4IU31q61RxG6WSgA6a1qNYNXuhzxLy?=
 =?us-ascii?Q?NBnbqQu+ElF3hTfNNVgVsNKJLB3QMTqGFk2nPDiFHOsJy3EUEStAMT6qOwk/?=
 =?us-ascii?Q?zQLrmhD/P4EZasuhKfzyGpMFEFLWQljwWZ/ZIhQt2dYwfVAEghAnTv4gAAYf?=
 =?us-ascii?Q?K6KjZrlE1ZP4sLJoYJgyF4t15bp3hksTkLSrttR/lITtbSFTGX3SAQ6lHymZ?=
 =?us-ascii?Q?tN0xtKnfwMZ/+rG0qmyMjYLHxWlMbEID8S345p7sxs2PWCU+CJ7rbfx8L+te?=
 =?us-ascii?Q?bL/McvmujaZ7ddJG0SCRXgdOEv4kKhqYKypA9wFsMXHg2h6+QcyD5HiOLDOC?=
 =?us-ascii?Q?x54cs+gZS/0jP3PqztIWLjVTJLVdp2XOKm1nxmqd01RYAY+ATHielwhzmOMN?=
 =?us-ascii?Q?BRLBr6TxlBy/mJJ6PfTZSAEpkY7dIckmqZq7rdKKluPvya/DeP087mM54E55?=
 =?us-ascii?Q?PY6BKbfAxidY7T3NnxAmrT4NQgpMk/4QiotNZG7rdbMjGBT6nAbMboLaP4K/?=
 =?us-ascii?Q?2yMX7dMuCR/MlTyakZXUnOPHO630nj4ktFBSYW5GNvWMLA5lrUmnDr5h2G4V?=
 =?us-ascii?Q?1zGWCFX+R7ywjzyzBGsfy5A7GZr3O7PBffRYaebve7fSeBALdD3PnMBEKwmD?=
 =?us-ascii?Q?xby5llYUo1Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3oM6kjk7FFBuYbn29BiUZ+O60qSmya5KQ56ThQZQpV/PHn0KMGVPtuEVyS/g?=
 =?us-ascii?Q?s3JaygJeoGIrZ0S8fMpoe1k3oYCx2GHJImIRb5zEWCaFk3/fPGFtZ1l+ugPh?=
 =?us-ascii?Q?lkkubriF7C05vfvd1c+4vPfm/nmIWXaN1SNtCrExhqmwtwL75dwOCiCqv6YP?=
 =?us-ascii?Q?FV9gJ9sgMwJ15pp+zkrZ1nPWsKMMVrB6tjSebn/XyEL2C0V37gLaxWK/yFFL?=
 =?us-ascii?Q?Nqm+y+caD8Wl5QF7PtA6wdrEIaD17AitInvMIDxsijvKBxRhfLrwA4WIysxu?=
 =?us-ascii?Q?w0XhlIycbPr/8Fgie4oK/fxN546ufZ8K8B1syo3NQ9O6rkXDJmaRiKByM9kg?=
 =?us-ascii?Q?bckjM+nfenXSJarfylQWgr4DtliIU335hsVzdmOP2KTvb0zkcgewfz0JQBFT?=
 =?us-ascii?Q?6Y8myn4B7MuUnTpgtmVmdnbdCLitf0h7cvoSY/2UYoaxhIFJ6UThA6NoGBoi?=
 =?us-ascii?Q?uFtTIylQfACkAQBwJxg86q3AkA6aBjRs/R207iMuAwaUS6HSDS3e01F/sBNP?=
 =?us-ascii?Q?Wof6rGxKeXcfdbz/FNp75rBOd2jf6xuSdm5Iu8BPsfe+4rdsbFi/4VGhjlPd?=
 =?us-ascii?Q?oRnR+ukqxmGQ5jykSGLjEIk4oH/9YoQjaR4e5HFhtJvCTqmajPuW5druBDY4?=
 =?us-ascii?Q?q9Ds8W3sd5u/QjZghUwMaQ6Ypw1OpuYXMzhXBvSBkcx2XyTC4JC2Qfv06YuG?=
 =?us-ascii?Q?zE1DIcB+zmF1wS7+CdfM66TUj84e1mnvucg37CMHJHakkSemM52uybkLEVdk?=
 =?us-ascii?Q?Q/rUDw/PthL5/oQQWUxDqiFktmnF51NPG71H+KJyWlSL2Pg5mRK+1sqn2ht6?=
 =?us-ascii?Q?zC/EI83sr89EFsy9XvndVwU+5CUnNDlyRFU6OhpeviX8SW9/Iorl/32bzALH?=
 =?us-ascii?Q?8wOPjZBHRDUCBqEwOHkRCtofmHvJFD+I6RBwZGVo+Ivck4nkVt+nxV1mCPnk?=
 =?us-ascii?Q?O/uC9YepwpslSmnmCCSF64wqV9TXe5UmCnyT04nlZT9bF4EQsxBeCXPMx05P?=
 =?us-ascii?Q?qtX9Rz8nLMm3nFn+LVMR4OlnwhgbuFd1HRfg6y15FcKa6Wfwi66+P1KvFJio?=
 =?us-ascii?Q?vZ/8xwwz83YNYhQtZF/Ljh+lSASprh62GQF/iMhhQQHP76ZBk0uxjG23FY1m?=
 =?us-ascii?Q?xxQ1o3TT6ptJ1z0iY9mll2W771WUQPCH1kuuUVaK+NYvCfHZAqCggkCyoHjD?=
 =?us-ascii?Q?JBWPa0Vq1yP+dZODrw3FV/6PvnCou+xewjtBtZN8+jS/kfds+pJlPs9sJCjM?=
 =?us-ascii?Q?N2IUqnOZQADLqR1a9KofBnczT3R+FoKXH3YDjOEKy3JwNo3iWUCVznEH09ix?=
 =?us-ascii?Q?/6aKLFem/yTnZKLrsKN43FiRj5mZFjKGR15k/oq970gBdgOTWIt6nZFAL9Sr?=
 =?us-ascii?Q?h5Ca/uktkuQpel+RQviK1KemVT6r+2GHO9vZx9BN0siH3dgp3d3EK80otwvU?=
 =?us-ascii?Q?R/T6VlJr5T12B88ciruvxYH77g2DKgpN7AMDc4qCeusoGGsw+sQZxUXW6+QG?=
 =?us-ascii?Q?OfoaVUzBqdQ7Pvx6dFH5gdobnxOMp/bsmty5/4YZzb+dkKK6ebqm6lL2jjol?=
 =?us-ascii?Q?bIdz071N5g4pNTCZ1FIipPrp4YuvlJLLEMngBVmO/o5V+MXlEUlllSs4gSIM?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef1de3f-568a-4c9f-6df0-08dd7ed0ccd1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 23:29:01.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+rqoJSvqw/GjPLVk2Cg6AxM7g8e95gHOcNqt8l8j4KTBnDy7uwYammLf5jpMaJqoc25DgrnVMXSV7CWdGjBm0iGdQyj66BYGFLkhqwqSts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com

Huang, Kai wrote:
> On Mon, 2025-03-03 at 23:14 -0800, Dan Williams wrote:
> > In preparation for creating a new drivers/virt/coco/host/ directory to
> > house shared host driver infrastructure for confidential computing, move
> > configfs-tsm to a guest/ sub-directory. The tsm.ko module is renamed to
> > tsm_reports.ko. The old tsm.ko module was only ever demand loaded by
> > kernel internal dependencies, so it should not affect existing userspace
> > module install scripts.
> > 
> > The new drivers/virt/coco/guest/ is also a preparatory landing spot for
> > new / optional TSM Report mechanics like a TCB stability enumeration /
> > watchdog mechanism. To be added later.
> > 
> > 
> 
> [...]
> 
> > diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> > index c3d07cfc087e..885c9ef4e9fc 100644
> > --- a/drivers/virt/coco/Makefile
> > +++ b/drivers/virt/coco/Makefile
> > @@ -2,9 +2,9 @@
> >  #
> >  # Confidential computing related collateral
> >  #
> > -obj-$(CONFIG_TSM_REPORTS)	+= tsm.o
> >  obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
> >  obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
> >  obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
> >  obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
> >  obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
> > +obj-$(CONFIG_TSM_REPORTS)	+= guest/
> > 
> 
> Would it make more sense to also move 'pkvm-guest', 'sev-guset', 'tdx-guest' and
> 'arm-cca-guest' under the new 'guest/'?

If folks want that. The main motivation is that common infrastructure
for the host side should live in a separate directory from common
infrastructure for the guest side, but for now I will live the
vendor-specific guest directories alone.

