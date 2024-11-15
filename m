Return-Path: <linux-pci+bounces-16945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2616E9CFAED
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 00:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1619B3BFC6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 22:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF9E1917F0;
	Fri, 15 Nov 2024 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TX61Zrk6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23C18BBB0;
	Fri, 15 Nov 2024 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711243; cv=fail; b=QN0jyACZnJ4gX8APz12ivqe40eE//ocmSBFG+xqLM6U9KI/NLUE5CFlsWapbInLRIhBubh5jV/NkaUU1JqbhHUdQ6TPL8V4seMOC/MEsDJ7ah5GDwkvu2Y6UGVjINRNth6scFzabJnL7vg+SyzA3SquyTTtXUghBW8OPpZTx4rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711243; c=relaxed/simple;
	bh=LQ1zPnGx0qfAsYZJpDANYdsxUrXWI43H29hnHwVIahA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FkCK8wwu4RX0L3V1kw/DmwHgUEyBiygsh0GpSqUGK16dgpw8+URd7tpqu7SzL+h2QtVwbp66CgXY9DRlmOJwtj3Q7hPs5vmrbtnNyl73Br3MAZXp/J6jwa62ZtE5nw+r8Wi0tLY+JD32p5MHQO7f1uZztvAYHk3/GHTSr/X9Eiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TX61Zrk6; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731711241; x=1763247241;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LQ1zPnGx0qfAsYZJpDANYdsxUrXWI43H29hnHwVIahA=;
  b=TX61Zrk67zWAIPfB/SpGbclX6t93BpoUBP5w7OspSLMIGmglI7DlPr7V
   mcb8TArTDfDOxVwfRfrk7SHc59tKIp0z8eeO5JyPFIpC+HaJBP5q/vY6Y
   4t++1zy5pN0gFllJxgl1zsgRqKhqUqEAyENKS+3SnPBpABV1EWk7mDhpS
   FWgTGTfebY4Tmc3mBpuZsglZKQdA7c2yU5R7VWd6Q3AD/htPQh388v8bI
   4mDJ2JLlaJR0KUBrMnaDpnYptQBnpS5SLRMeWxpDZxzy4Pe/mFeiKSVaM
   Kme5zqTMuropEQCPamhueT2eu1W9/meWGuDPRnBqDXxLvjhH5KaUt9b1W
   Q==;
X-CSE-ConnectionGUID: 93Lilp3wRTKOg4T5x/o7OA==
X-CSE-MsgGUID: JxB/CI/kTtKQdSY76+86mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="54240153"
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="54240153"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 14:54:00 -0800
X-CSE-ConnectionGUID: TRG9gcKYRMq5Kd13jlXsMw==
X-CSE-MsgGUID: IbN6ThuBSUyM00ERfMjePg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="88800789"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 14:54:00 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 14:53:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 14:53:59 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 14:53:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tpjd//ty8EFpl8g9RjJ3yvMwkYnME5JrjxlChXHXf26wIHVuTiMv97Vn574hOKvgUdj4I1A3Q1ZX/P9T1lUNTES9fsB7stj7qmDOw5t4RBTFi7Kl+zLZ3CLZDSYMazd7//RT/0TJJg/6an8tSKkS0X+VOpKDiNcUrcaBi8ItryxiaOue/1Pp5braLUD9xvrrDidS4Hh9lF0h80kvbBZ33KmrtjTpQBf5NEWQRdIggwCOq1y2EMU2vsFCglnnfAuFZcNDbJDG+rxJCka6l2ZQsjae3hToYuG5HRw1shlkPPG/szb/75S9JOymWb71/QvoxnheKkEE2EHwEorLTVs0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAo0wvPukWcMnUH/huy8NkZhBKGKVJHkOXS48cZEtlc=;
 b=RTSW8BN580enULWOBfh8i1RJJ8DqhBEnGiGCcdtc2x9c26fGPQUs9n1BzoiGzrF9dL079xguT5lgB5GevCifi98LVWnDK/efMKHadTtdCBnRpzf5bA713Pd0n7IIxDqteJOErkzBkazGWCHGMOnnR6+b22jBczashuPCVoFoC68cgA6yZEqbroJH5Srm0FlulzCLTmqRnMGT7H1URpaOH5VZY5Kf264PGsF6/Qz99xzkoLdKuYKOOSrUVsbvWHTBWsITRPzlKFUVet+oMs4ld+d6YYYqRI6aeD9rzwhifFpn+balVGDwF88x1u7B+i9apv+hOvfaDpX7KiHM+5bWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW6PR11MB8392.namprd11.prod.outlook.com (2603:10b6:303:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 22:53:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 22:53:57 +0000
Date: Fri, 15 Nov 2024 14:53:53 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Francis <alistair@alistair23.me>, <lukas@wunner.de>,
	<Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: <bjorn3_gh@protonmail.com>, <ojeda@kernel.org>, <tmgross@umich.edu>,
	<boqun.feng@gmail.com>, <benno.lossin@proton.me>, <a.hindborg@kernel.org>,
	<wilfred.mallawa@wdc.com>, <alistair23@gmail.com>, <alex.gaynor@gmail.com>,
	<gary@garyguo.net>, <aliceryhl@google.com>, Alistair Francis
	<alistair@alistair23.me>
Subject: Re: [RFC 3/6] lib: rspdm: Initial commit of Rust SPDM
Message-ID: <6737d101993ba_5c832943d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115054616.1226735-1-alistair@alistair23.me>
 <20241115054616.1226735-4-alistair@alistair23.me>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115054616.1226735-4-alistair@alistair23.me>
X-ClientProxiedBy: MW4PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:303:16d::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW6PR11MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: 8845a055-8c11-415f-1346-08dd05c8632c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NeoRlIRXecq4+aMrdO9LmGNni3gScqubrRiArCkzOhBSFSWqanflZyl49Ku0?=
 =?us-ascii?Q?v0Wj10xBO+MQr0Yv7Sy/znZJ9G8BxwV9GQuwCP1HfRQfKeFTs3wXWhqsMgPy?=
 =?us-ascii?Q?/fjLSIdhnN1MlmFceIv60NcnPN60KIHb4vKmR8jiw5U5WuM/IzpmyrHHoRsV?=
 =?us-ascii?Q?WrUt9FeYYjVA7AsJp7sySXRLd6lETcD2u1JK3GXu6JvFG/+FBji0TuTxq1dH?=
 =?us-ascii?Q?ejUloPyg17+Kq27cNUtSJsIdkAB7XA1U0uvn4mpU//afb8pxymAE1IZYzicR?=
 =?us-ascii?Q?+rFSs/8ZtsYFyZ9X2CfoDZFNzrmSPDHoq0Sb8jTTGFQXWnOFtgNtUmrOXGGa?=
 =?us-ascii?Q?1vI8f19ayiJRxZmTC2izfnhWUz7d7PsXbuTQoE0xD2yuOoBWeekwhDiOBCU7?=
 =?us-ascii?Q?6767eUJI4WbxcQom4PYWMyqoYUXDcgJdiVN1rUByyZWERha2oFc2WQSySqwM?=
 =?us-ascii?Q?s//wtFlemMkgDt2tplE9cuKqYy0MU4WQbvFzY/Y9qlHkAhimSgWiAkCV8X7r?=
 =?us-ascii?Q?Exn5HzlpKUIGksFq1PgEqz5WyUqr+zuAlB5QaIJn35lzGF87QEQ7538r+ibz?=
 =?us-ascii?Q?2DijoPEJ3zOEBPLS5G1fFddc3mqe93H0CFJLIBeK9YCv7VOaPiWszVSLoQht?=
 =?us-ascii?Q?rv8EpsmCdrFR3/NM3tkJ/vwXSbiBFh6K0ljYvtn7q/E+KbjObQvtIEkruJtP?=
 =?us-ascii?Q?WR4Tosl4quxE65x3YhOsp0noLDBzxYO629bszXOCxc2IWCqE7nG6m/d1MIyR?=
 =?us-ascii?Q?0HHmZSqcS+gQaMXPVcysqdwqXajH8rMkkjwsV7yBfql1JbED3wzTehbWnWYu?=
 =?us-ascii?Q?W2bGcIJrOqJmsjILiYu2St01u5M+R4pAKYtgj85eJNmFb6nixmWpvvd2TVWQ?=
 =?us-ascii?Q?joC96C3cx/Kp1fW1hUaBY8tRXH/b2MkwvLqhN44EFWtEXobk2mgL8ke7KgDc?=
 =?us-ascii?Q?hV61DYGvqsUKe31hLh/sOXcAI0xyoktZtoSwaVQlRcwfEN2YEs9TwL49/n9/?=
 =?us-ascii?Q?TyguWLnT4ikLTR2FTueztV0rjhWRUaTjPcw+kBzk+hxOMJgGYcBSa9F/Khwj?=
 =?us-ascii?Q?uPTgLQwgF8E4bfnUJ6AULLBBmk4bJhSFz8j2D7CXw/CqoFxLFkXTeJrfZ1W7?=
 =?us-ascii?Q?gzN1Gj8bgYCSmblGNfAcHZNIKrS+FBEclool7wQu19LPJpm1o9RqMiSLUVRm?=
 =?us-ascii?Q?GN30SqmLVreDh06e8d6+zgTLCUeOAE9QpGViPyW6lSWCo2HFuf4Ic6OyOxsf?=
 =?us-ascii?Q?lKgtrI/cJXRzZS/Yy4ASO/nTNY5bKgzNd9yBCls5LgFfKV7vVE6rUutntSVb?=
 =?us-ascii?Q?k+k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hy47lYIVY3q5LPVU21DlYsknZL+A9K5GrPgnaHAVf7Hyrn7+BZmZystFRWVQ?=
 =?us-ascii?Q?qM5hke6kpWsj/LGe7nL6klEeJxAqsf9U6r3+TEMrKymppjsr1h/yhYbgG118?=
 =?us-ascii?Q?J1qGSwqQi0B9p4Y8Ib9NXI310rK2biMuIDjc1Z/PUXj1DjCehsMEvfo71BbW?=
 =?us-ascii?Q?0Feyu9IOAG5x1hGQtK9zEI6U8nnHHBGO2VnXVZyV1KV32SlAXd4QE3jFBX+R?=
 =?us-ascii?Q?B9j+f479cRfzYUeD2p3UVJN628kxsTyRFHT6pJy7v3ytunxeufRzLlLTTTnv?=
 =?us-ascii?Q?J+EZrg3neqc/1ko7zL4+QVw6oFw/qUNqlPxEV2dmJ/3dtd96L7S6pjCursQP?=
 =?us-ascii?Q?IKz8m2OxdFqp/cHV/ggZWmGfVbrvCOJA55Wb35DFpZDA6h92fBIPhOUgoh0p?=
 =?us-ascii?Q?1hGAp8LG1/X1xq3lOa4czqkfiv7OzEHKrgWkIpftiJU3Y7VvqfuU1hMEU11e?=
 =?us-ascii?Q?tcudx+b+syK6vI3QxGD2pL08Gw0JEFiNF21kE1a2/Oth9dtEmNTk1rzWzhqs?=
 =?us-ascii?Q?lh+NTgo75xeZ5isI3fHfG4x8Gp3UqH27hLnJbSj7GeacZHKUWDWvwNjEIp45?=
 =?us-ascii?Q?LlJqBKmeONsYOrXbeDcM0X6NrRpzLtZoo5lnEa91gpxRiLCGfyo0dr5MYPPy?=
 =?us-ascii?Q?U6vqmFfWxiioSavW7QuzdOT4MSFomzdxkEiH5by3csTV8CKibhJZuzQO+XZk?=
 =?us-ascii?Q?iLK6KCFOU8jBDmd7x3Bg4xRpnHS9/OfVmW1nOijf2/Hqo7Iut6fyilWKVyTU?=
 =?us-ascii?Q?nuxZa83Hteq0AnjHn3LkPh2OyQT7eDnrldOOQJeiynKaH9KyWv6h4iIfcAIL?=
 =?us-ascii?Q?PmHPEGiF1NN6Tf1KehZq+QHUdh7gUgudaz2zmbQpUA8BG3OSd6Rwfk63QxIS?=
 =?us-ascii?Q?cl5E2/loN+6iO77LEP51vCjtMUL0bP/ZWrV0ehdSa7tB81x8W6YBtXyOcGV/?=
 =?us-ascii?Q?++wpXIizZJz6z5xbOg9qfazqD95mzzhblgRw8dynO0JUYGzmNrX0iFlgKrPv?=
 =?us-ascii?Q?r5hOAthgjuUbjljFEYB3PhnDRliuxTxl787g6XDmvB/hYIehujhX+DzC2Ae3?=
 =?us-ascii?Q?4NC4hLgYwV8WVyuWmfLxxA11CBkwkH3yseq+0LUVGPkK/VVeeYYnBN9hfwbi?=
 =?us-ascii?Q?6aN8z8zuCKyKq0m0cDcjwpEWcylLE8emPECk7MLC/c2akU2wDGe0rnzSpbXm?=
 =?us-ascii?Q?jLBywMZJgcFgd1wVnhTFwCKsv38id6g4TtIB6AysenrrzkNZ0QSriV/bTsNp?=
 =?us-ascii?Q?4V91bCTSrUzH8Icr3MB5Tj3Pf7biexRbKCtBmaA71bzsrQPU1G9+a3CSVd6b?=
 =?us-ascii?Q?do8cRzEYwRBPyfv3kAA+ZqiMTAurMgy7ZFy/g/3wcZScp51H4jk4YPOWr2sn?=
 =?us-ascii?Q?w9whXhABljAHpg+eWcA09W29Ir6dYU4n7OuWE8un2M5PGmfBW6Xyq77gyN0l?=
 =?us-ascii?Q?1PkHzJ53EzH5j7CBaV/YLCEyf3q00YxVOtJ+AILATeBzgaL9misrpiqF7mch?=
 =?us-ascii?Q?3w+RACPo+RjNPwZS6KcZ4t4F8+DiRhbQ7/TnKR2MS44MXlnJWxmiK6Sqe8nz?=
 =?us-ascii?Q?f35NoF0BGQ7i8sh1IoqsR6vRQQ1BLyhGQVS69hwbibi8lCR4likzN/6gpsvH?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8845a055-8c11-415f-1346-08dd05c8632c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 22:53:57.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbCq1guoOb5Ia4X5YFtXGHeOhTMiJGsnawQKqQQ7nnj7lYiYWAQVg+P5q3vkBxMOtOdAKVDh/nwxJiqTBiacG8yHyten8I1n/Ahi3qg04wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8392
X-OriginatorOrg: intel.com

Alistair Francis wrote:
> This is the initial commit of the Rust SPDM library. It is based on and
> compatible with the C SPDM library in the kernel (lib/spdm).
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
[..]
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 690a2a38cb52..744d35d28dc7 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -128,7 +128,7 @@ config PCI_CMA
>  	select CRYPTO_SHA256
>  	select CRYPTO_SHA512
>  	select PCI_DOE
> -	depends on SPDM
> +	depends on SPDM || RSPDM
>  	help
>  	  Authenticate devices on enumeration per PCIe r6.2 sec 6.31.
>  	  A PCI DOE mailbox is used as transport for DMTF SPDM based
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 4db9bc8e29f8..a47650a6757c 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -754,6 +754,23 @@ config SPDM
>  	  in .config.  Drivers selecting SPDM therefore need to also select
>  	  any algorithms they deem mandatory.
>  
> +config RSPDM
> +	bool "Rust SPDM"
> +	select CRYPTO
> +	select KEYS
> +	select ASYMMETRIC_KEY_TYPE
> +	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +	select X509_CERTIFICATE_PARSER
> +	depends on SPDM = "n"

I trust these last 2 diff hunks never actually go upstream, right? I.e.
if the kernel has no SPDM today it should not plan to carry 2
implementations just for language differences.

I am not sure if that is already the plan, but the cover letter seemed
ambiguous with its "maintaining compatibility" statement. On one hand,
that does not make sense when this is brand new upstream code (i.e. C
version is not even in linux-next), and there are no chances for
regressions. Just embrace the attempt to be a Rust library for C
consumers or otherwise help the C version along.

However, if "maintain compatibility" means "make it easy for the
work-in-progress C-effort to switch dependencies", then that makes
sense and is worth clarifying in the next posting.

