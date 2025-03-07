Return-Path: <linux-pci+bounces-23174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32505A5763B
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 00:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588C17A812C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 23:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF3214206;
	Fri,  7 Mar 2025 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNZZA4C0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD32139D3;
	Fri,  7 Mar 2025 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390682; cv=fail; b=mJAu0fGdPfsrJJ9rWUEbnooPiPUfN5I/HOrCbFkxSQkueKhZK033UCE8OJuuFd/z9pU9xxc3YU2qwOONDZ5ftV39vZw27WB53QssfjW4HMcJYHfQUP/9bnzoIPjmq0Noel7IDY3IpEE9ZJmBe9KTIFEpzeeFm/FsmMrzbDMzAT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390682; c=relaxed/simple;
	bh=suzLrkRyhRmhyNosmkewQPiSKgUNCby7i8bp8ju30D4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q5Om4s8yVA7CFX6w4TvgYXveoC1vWBi0naYEuGGlHBb2cKgIKf0yZ9D9BQAQ+mfNYlX9S9SI6988H/MgVdZNYqPi++daAuuHl3d3aT6dIk6t9L9WOSYIGijR6HPGJIY31wsYkE7waQrO3g4vIAJh1P7exrZTQfTRe8CMOv8Ebzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNZZA4C0; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741390680; x=1772926680;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=suzLrkRyhRmhyNosmkewQPiSKgUNCby7i8bp8ju30D4=;
  b=LNZZA4C0O6aPpD3jl6/UPx/408MRhG3qNwDw+7+p7Q8Rjgf1JZBoJIHt
   SloP0YJ637C9yKii/6Mu6kZTO8s1goz1qgJNTHmHyYGDZtIhawTksmpeK
   FvOQ9ZPD0xJT221QKD8zaBj6yCv4b1AitN+4ruUXZmf0py0rjxZAauaa0
   eD13+xOBu6Z0k7wGQYLbumlevCWGO35Ks8dA5+lH/r7i7yczyKgvz48rY
   FJTNNhQnH8OTB0D0g1ur3r6NgoPM3nMWKNaJBaVfKipsrOLOws/MVQZJx
   /OVEUpXdAt/w+RJ6UGOPW/E/kRXXC4pUqP3FeBUl36cqWf8DPLqKNNU0+
   w==;
X-CSE-ConnectionGUID: X3/dAR/ERMmcdIBvRJc5Vg==
X-CSE-MsgGUID: NU7u3oXtRK2lE6i2+dIaPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="53088123"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="53088123"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 15:37:59 -0800
X-CSE-ConnectionGUID: Fa33Wc0wQqqM+5tMsTI9kA==
X-CSE-MsgGUID: gDLWgML5R9Cnq82Z4bDfGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="124375004"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2025 15:37:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Mar 2025 15:37:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 15:37:58 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 15:37:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpuBnf+cH7gzMLPkMiAPItewmc39T9Ru3D7wijAPL7CBNbfsL4Aod0tmFrZ5Hfn+c7UPVrVYzhm+oysKntalntqOso/k38EqWNrXY4tI5U5GZed06WOsae3zOuKSkvjuN4kvctRR1RtwOtHjey7M/WMC/fMWbcP9DUNWNNNsD6R/tWo2JpJM3n/r2Z8NfrQ2Eq4ZwR/+no15i7HThY7dAii4fcl3KSRcqCG8we2Jjas3V+8EyeVAkBoOEmztX0kMX0n26T2wxTyohWSf/PUT6iifD4ixmLFP/uRn2m7pU00LjJK6IIGzavDsuOMLd1JNgh3yce78GCqLwJkmrXUY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwCguXgi+K7YMjCqBUu/Mjb0B9e4XD7VJKSOSCCtHjM=;
 b=BWzCfA/dm575e4ZmEC8CqbXjnf+TfU9VQMLPGpXXlkQof50Xu5skpT/3RACeh83RTWameZAPYib/ZrRgyjcAmzEameivgzThTpf4m/ULnXNZlc3mQCm/2RxF4NJFMT+bk9ar3Pb5qqe/ETrDR5kFIVmDnwdVvRTQQRA7IZZGt5ZRlxuOwgnT2mtKMn5oxyOKhUzXiPK5udrAkgJyH3jILxmbVvzp4qvY1I3mceKDAMWFcj8/x7WmYBzV9HFA0+K9n5bqS4e0d4FiqoFvTOVNhbjFo8xTsWIuxhZmgmTCct7QY45q1sHoTYPaDKR1XkDHY+D4H9jcRLbmGe4yOtuKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6551.namprd11.prod.outlook.com (2603:10b6:8:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 23:37:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 23:37:40 +0000
Date: Fri, 7 Mar 2025 15:37:37 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Francis <alistair23@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
	Alistair Francis <alistair@alistair23.me>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lukas@wunner.de>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<Jonathan.Cameron@huawei.com>, <rust-for-linux@vger.kernel.org>,
	<akpm@linux-foundation.org>, <boqun.feng@gmail.com>,
	<bjorn3_gh@protonmail.com>, <wilfred.mallawa@wdc.com>, <ojeda@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <gary@garyguo.net>,
	<alex.gaynor@gmail.com>, <benno.lossin@proton.me>, Alistair Francis
	<alistair.francis@wdc.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are
 authenticated
Message-ID: <67cb834117c15_24b6429474@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me>
 <2025022717-dictate-cortex-5c05@gregkh>
 <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>
 <2025022752-pureblood-renovator-84a8@gregkh>
 <CANiq72kS8=1R-0yoGP5wwNT2XKSwofjfvXMk2qLZkO9z_QQzXg@mail.gmail.com>
 <2025022749-gummy-survivor-c03a@gregkh>
 <CAKmqyKNei==TWCFASFvBC48g_DsFwncmO=KYH_i9JrpFmeRu+w@mail.gmail.com>
 <67c8abffd2deb_1a7f294d5@dwillia2-xfh.jf.intel.com.notmuch>
 <CAKmqyKORk5n_b2DUDfCVmttE4T+S-LQvcp0NoQD_O7D-csdEvA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKORk5n_b2DUDfCVmttE4T+S-LQvcp0NoQD_O7D-csdEvA@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0363.namprd04.prod.outlook.com
 (2603:10b6:303:81::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: e33b651c-0b20-4e23-28d8-08dd5dd10cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEJIdENWc2FwbnJYeG9FSmdlekszRTJzcXAxdDhDZTZQN3lDRGt2Q0IyRlJQ?=
 =?utf-8?B?VWRxbmJCZVJmTDc4YnBhU0t3d3FlYk9RNjk1SWV5d3NxeW1xckw0Rk9kNlJT?=
 =?utf-8?B?T056MnJNS2VpUDM0SkV3czVnU3h3b0Z5VW9Fb3V1Zi9HU2JRMVQwaUY0Nno1?=
 =?utf-8?B?bC82aXVNSVMva25NalZXSm0wVVlseDY2aXNQYkZEYllmZWtYR3QwcGI5TmRa?=
 =?utf-8?B?Q2NjNm56Sm82bG0vRWxnWTM1RXdaRWZ2YUJJTm00QlloSkxQemkralBNTndr?=
 =?utf-8?B?MCtkSXRtYzNvMVZISVZRdE1lUXBTNkt6a0lLZjNheG1sZEtWUWhBSy9Rb3JD?=
 =?utf-8?B?RWgwcGdUdDNaN0xOMnRhOTNFbGsyT3hibkJoL1VUSFdrcE9oTzEya3YxTzlW?=
 =?utf-8?B?NlVSalZtNlB2ZFljTW1PeE91TU5PcHA4TjVVdjhQbXVHQ2NjMktzak9ZNTNR?=
 =?utf-8?B?dU5PM1dtcWV5QVJHMzIwYXJ6SEwxUjZ0djVTU1JiWFZOQUJTNlNONkdWbTZR?=
 =?utf-8?B?azQyTFEzdThTemZzQk9rRkE4TDdLbkg4SHhweHI3RUhFMGVaLzJQVStGWXEy?=
 =?utf-8?B?YXRVTHdsMDloK0tjRVY5MEVXOUEvOFVEQlU0YzlXeXR3UVp6TFRvNzBzSkVk?=
 =?utf-8?B?dEtSNzhxWkZiQ2hSLzkrVUlraXN6d1NCR2pUeEpicUhJWFp0aThILzQ5TmhE?=
 =?utf-8?B?VFZFd01vMEFPYlJ0MnlBbGQ4dU1jMW5xZG1kZUVFUGhQckcxaGJsS01qcHlq?=
 =?utf-8?B?dmNmbUU0cUkzL2hLcVhsSEJBSHkrNXFQU1RrdHhSRDBTZ21NL3l0dUZ2SHgw?=
 =?utf-8?B?NWdORWtGaGpyaUs5THZ5ay9lZnBST1NnYzNqZVNQQUZ1SHBIMjRaWTQ0Q1JH?=
 =?utf-8?B?UzZRdnhjaXN5TUlnYmZvNVBoZTI2NVhNYUxQSjV2QnhkajNjdktDci9nS0RW?=
 =?utf-8?B?cFpuSGdMK2daTkNZeUFMR0k0QlhtcWFqRjRNZzBBVHV3N0Zrd3lCZGRiUmFV?=
 =?utf-8?B?SkpXYUROVm8xcUV0clVDQllMWEJNVEFGV1VvNGZmeG5EdHhPSzBhWUFaZ285?=
 =?utf-8?B?cVJ5NkFUTjJhSXBjbHhJbmY4MHFKUUd2MG5LdytVVVE4cElhZWlJaUhzVG52?=
 =?utf-8?B?SUdtUlNOYXY5NlZMOWRzN2JhM21Ec2sxaUpUaHJqdkhhMXpGUlhDMS9HVGts?=
 =?utf-8?B?U2pIb0ExcjA2QWRaWlBDdGFmMXRHdkRFc3ptcGVzMG1kZHJXd0NYeVo5eWZX?=
 =?utf-8?B?TWRCMktqRVNQNFRJOVBBbDFoYkRFRTJGck45MkxsK3ovbVd4UDBEL3dnMFVT?=
 =?utf-8?B?OXVPd3BsUzlidnpIU3AzQzVVR0VzcCt2Qmh4a3N0aHgzVmd0RmtXMXpBQk1m?=
 =?utf-8?B?QWFqQ2lqQ2VPdzJkY01uK0JPNjhzdVA0bk44UG9ETjFidlRQcEJ2VGZ1RklG?=
 =?utf-8?B?UTN4MFkyZHJrQmgyd0w2TDZzSFRPRnlXdkFsZVFRY3BmZEIvcW1pR2J2MEhY?=
 =?utf-8?B?MTJjbGlzY3ZGNTFwaUtucEcrNmxobncvOHo2MU83am01Wm03RWhkemtQNjBo?=
 =?utf-8?B?TTVzUi9DM05KSStRQURKdnVCdkpqRldhN0tXUXBpQ0trSWNvcGhrRFRmSFV2?=
 =?utf-8?B?ckN1S1g3TUJSUmdWSThSMHpwWjVqZ21qdG1FOGpQNjFpVlZPcWVubzhIYXFZ?=
 =?utf-8?B?YXNVSjkybzJ1QlkyM3JXQ3NPTUVscDRwSS8yNnAzQWVuWGpHZ1YxMFNYODlE?=
 =?utf-8?B?YmVXUDlKNXRDM285T3FsSWRMWWY4UkVHdG9UNEFaS3lTelVLeUtNYVFHajg0?=
 =?utf-8?B?NU1aYlJUb3NDSEVCZW5YNkxjd0ZiYjZhZGwwaDlKYW9DY3dsSWw1dmMwSW9a?=
 =?utf-8?Q?jPnlCy4P99e6f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUtlWll3MjBYdGJNR3dpekJKMzlIazZTQjcvVjBIR3RZL09hb2ZzUzFKb1dF?=
 =?utf-8?B?NFNtVUpobnJDRnNQWjhsUTlkQzl2ejFjcW92ZmhubGgrUlZUVjZBWEtCSnVW?=
 =?utf-8?B?UWlUeUQyOUNUbzlwRHV2TlNRc1lTNjV5d00wVTZBSVM1ZzAzOUFVLzZXWnVu?=
 =?utf-8?B?THJpTmNmY2F6d2tXc3htVzYxdXl3K25hUXErT3NrVzlycXVlSjFCVkQwMlNG?=
 =?utf-8?B?TlR3cHBKOFErdEZZYlkrTXV4c3Zic1JHdU14SkYwZ2R1MmJLeDc0R3poVVNv?=
 =?utf-8?B?dk1QeTlNVGg1dGVhY0VmY2NwNU9pSXF2QVlpeEFpQzBubk15TVp2blY0VzNB?=
 =?utf-8?B?byt2S2JPVDJHdXFKNnZvcHJnSEllQ0VjOTNHMTFvbklpVFZMYm94WEpUbWlG?=
 =?utf-8?B?eGZGYUhPdE1ObEQybFU1V09iNjN4YTR3MUtNZVkyalU1U1hCMys3SUM1NjAw?=
 =?utf-8?B?MWlUcHlVeGNia0hLaUpaY1pNS2ZwK001aDh0eWJwbFhjUHVQRWhLNW41WXJK?=
 =?utf-8?B?Y283R0w2dXd4VHhWMFk5cmtaYm9qSS95WHpENTRQQ1k0VnFoZTJhdXNwTnBl?=
 =?utf-8?B?b1JaSE5Zdi9uODJqZng0Slorei9XVUo1NFBaRDZ1MmtQREdPQStjL1FoQlY4?=
 =?utf-8?B?Q1BuODJyVnowcEZ1dnVTTWs0dm5aRGg1cnY5N3lQUDZWTnZMNVJEUENPMnVU?=
 =?utf-8?B?Z0VRNGFKbnd5eE9YOWhYbjFvSmZRakVhZUxYZ1NyRUNRd0sxNm1URkZGeTc0?=
 =?utf-8?B?Z0hOM3pTWlJEeG9DS0tqS1hKZ2VBYlhCY2tDditDSUt6b1U5cDhoMTJZd2s0?=
 =?utf-8?B?WmJqSXJseitnT3pheUFzajI5RlVLb2FabE1Vd2FlN3FMcGJudnE5Zk9JS2RS?=
 =?utf-8?B?MWJOOHZZa2pvZ0tjU1phdUNObmcvdU1ZYkltWDVLT2Y4K2ZNSkFhc2Uvd3JL?=
 =?utf-8?B?V0dMbm5EazZZNTcwSWl0QWlER090d3lHOVJza1lRdUY3U0h0bXZLS2pwRXNK?=
 =?utf-8?B?QzYyMjJZZVdsUVBZbHhDRVU1MTZ2OUUrSG85a3JhVXMzVHpwb290djZHenU3?=
 =?utf-8?B?QjRNSnp0K0grdVgxcyswUUVkNXJHRDkvUm52eGRMd210RzNJOGVjMmFyVzdx?=
 =?utf-8?B?ZU93VzdhWTlLOEV2NHcrYUZaV3JQWXN6bExFOXVLdHdXSHpUaGZYMk9KRlFU?=
 =?utf-8?B?WTR3UVJGTi93WmJYN1pudXpjRHI0LytkblNQSXlnSDl5RmJRZWNmS1ZCNjFu?=
 =?utf-8?B?WFhNWmRsOSt6b2V5aThKQUMwWC9KM1g0VHIzZEVWNUNqYzFtR3Z3SXo1b2tB?=
 =?utf-8?B?THErYjJJYlp3UnNxVWhlSXp0UFJjbTlVeEI4NnBORGtFKzNidlptYVJld2Ra?=
 =?utf-8?B?eGE3aitYTHZqT3hxaTFwVjVkeW1BSkozclJDSzJKZVdkZEduMWNSbHpRbVo0?=
 =?utf-8?B?NnkvcUUySFlXY3FSaHNHK05Uc28xMURGRURieDNUamtaS2VrR3UyMG84V1Bl?=
 =?utf-8?B?c2JMT1diQ1A2K2Jmc2JKbFowdmtqR21nQ0lFYUlrUnpXaHArUjNKd0VQRi9t?=
 =?utf-8?B?dENsSTJOWk9aclRLcU9vSWZLaTNrajdiWHRabFVOVlVjQ3VtYkQ1anBDTXI0?=
 =?utf-8?B?eU1nSXFxWjJMaWxoei9EaHQ5Y0h4dmh1S3lXaWFUbDNwYjMrZ0tud01wdTFq?=
 =?utf-8?B?dkdVUWxIS2ZPa1NxWjRpeGNRd1VSYlpRc2s1Mjh3cEtPM2RUUkJMWWo0WWhL?=
 =?utf-8?B?UGxaMXc2R2lUUVVucGlXMkVwNGJVQUVOcy8zWTJTQ3lGWGsvdDVJVlRpTk5x?=
 =?utf-8?B?MElQY09SMTZTTVFMNm1lVjFkUjBabSttcnNuMFozWkorclFjdWUraWRub0dT?=
 =?utf-8?B?eGdLRVg2M29hdklxSUprZzl0RmxoSC9WY0pGWmN6Ny8yRk5ranlHRC9XTVRq?=
 =?utf-8?B?OUVQYk9CQXYvbkxHdmpDWTYvZGEvMTZxc20yaFdwb2x0eGFyb3VwNmI2ait6?=
 =?utf-8?B?OFR5YkxHZlJ0U290Njl1YWRhUVFSTDV0ZSt1cEswdWUybWpITUc2emJkd1VD?=
 =?utf-8?B?YVM1bk4vYm9iUFRlbkJRQnpBNlNMd1BVMXNUK3pqTm1obm1LZUtEdE5rSVRP?=
 =?utf-8?B?YlBEZ2ZWeU5lcW11YWs2eG1aem81SVVnMUtqbXFKMnlqSFlNbkdKb3oyWHhm?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e33b651c-0b20-4e23-28d8-08dd5dd10cf0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 23:37:40.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDVytBM9k3MuXZKzeHOS6T8PU+yrDvFAIZwSfP1LeWYYjJ2C3bvM+JFRjcNAcU5CNYIhTOBUIzpcnq81TuHVBUIADNV6xWSgteBjiL41U2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6551
X-OriginatorOrg: intel.com

Alistair Francis wrote:
> On Thu, Mar 6, 2025 at 5:55 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Alistair Francis wrote:
> > > On Fri, Feb 28, 2025 at 5:33 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Feb 27, 2025 at 05:45:02PM +0100, Miguel Ojeda wrote:
> > > > > On Thu, Feb 27, 2025 at 1:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > Sorry, you are right, it does, and of course it happens (otherwise how
> > > > > > would bindings work), but for small functions like this, how is the C
> > > > > > code kept in sync with the rust side?  Where is the .h file that C
> > > > > > should include?
> > >
> > > This I can address with something like Alice mentioned earlier to
> > > ensure the C and Rust functions stay in sync.
> > >
> > > > >
> > > > > What you were probably remembering is that it still needs to be
> > > > > justified, i.e. we don't want to generally/freely start replacing
> > > > > "individual functions" and doing FFI both ways everywhere, i.e. the
> > > > > goal is to build safe abstractions wherever possible.
> > > >
> > > > Ah, ok, that's what I was remembering.
> > > >
> > > > Anyway, the "pass a void blob from C into rust" that this patch is doing
> > > > feels really odd to me, and hard to verify it is "safe" at a simple
> > > > glance.
> > >
> > > I agree, it's a bit odd. Ideally I would like to use a sysfs binding,
> > > but there isn't one today.
> > >
> > > I had a quick look and a Rust sysfs binding implementation seems like
> > > a lot of work, which I wasn't convinced I wanted to invest in for this
> > > series. This is only a single sysfs attribute and I didn't want to
> > > slow down this series on a whole sysfs Rust implementation.
> > >
> > > If this approach isn't ok for now, I will just drop the sysfs changes
> > > from the series so the SPDM implementation doesn't stall on sysfs
> > > changes. Then come back to the sysfs attributes in the future.
> >
> > This highlights a concern I have about what this means for ongoing
> > collaboration between this native PCI device-authentication (CMA)
> > enabling and the platform TEE Security Manager (TSM) based
> > device-security enabling.
> >
> > First, I think Rust for a security protocol like SPDM makes a lot of
> > sense. However, I have also been anticipating overlap between the ABIs
> > for conveying security collateral like measurements, transcripts, nonces
> > etc between PCI CMA and PCI TSM. I.e. potential opportunities to
> > refactor SPDM core helpers for reuse. A language barrier and an ABI
> > barrier (missing Rust integrations for sysfs and netlink ABIs that were
> > discussed at Plumbers) limits that potential collaboration.
> 
> I see your concern, but I'm not sure it's as bad as you think.
> 
> We will need to expose the Rust code to C no matter what. The CMA,
> NVMe, SATA and SAS is all C code, so the Rust library will have a nice
> C style ABI to allow those subsystems to call the code.

That indeed alleviates a significant amount of the concern. I.e.
multiple planned C users makes it less likely that the needs of yet one
more C user, PCI TSM, get buried deep in the Rust implementation.

> The sysfs issue is mostly because I am trying to write as much of the
> sysfs code in Rust, but there aren't bindings yet.
> 
> So if we want to re-use code (such as measurements, transcripts or
> nonces) we just need to expose a C style function in Rust which can
> then can then be used.

Makes sense.

> > Now if you told me the C SPDM work will continue and the Rust SPDM
> > implementation will follow in behind until this space settles down in a
> > year or so, great. I am not sure it works the other way, drop the C
> 
> That was kind of my original plan (see the first RFC), but maintaining
> both, with at least one being out of tree, will be a huge pain and
> prone to breakage.
> 
> Also I suspect the Rust implementation will struggle to keep up if the
> C version is merged (and hence has more people looking at it) compared
> to just me working on the Rust code.

The practical questions that come to mind are:

   Do we have time?:
   I.e. How long can we continue to develop both out of tree? Presumably,
   until the device ecosystem matures, when is that?

   Are all users served by Rust SPDM?:
   Once the device ecosystem matures can all architectures and
   distributions get their needs met with a Rust dependency?

