Return-Path: <linux-pci+bounces-42678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA594CA6056
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 04:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8247231986C9
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 03:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F422C221DB3;
	Fri,  5 Dec 2025 03:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Of4uxHDW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649A18DB1E;
	Fri,  5 Dec 2025 03:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764905915; cv=fail; b=NQH4nI/v01M4CGQwj+QqXW90AqG4bBbXtyWpn+tFmL87Y7YkYskiWGVT3U/6DVn9HAujW1/Lf3Pt+xx/197YGo+fE29DuM9wuOVGaRd2PMTFMnodJMTXBtOsL8QDMAt4zqKiB1DddrTGcF13V8nCxpLehur8PWFNzlYAo1iXOp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764905915; c=relaxed/simple;
	bh=shJnbhdCP0RtUejNDZ4Wn6wdxye6pXAylKntrMTYEck=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XscXW2cs89dSaoiOSuSR9VlYlutv+Q1H+juDQ4vhBeoyi0G7S83DXgBLKlB2ohBosa4p6LOVNUBlHJWcPdHj+HcovkOkKmEaxcUqyAqxfIKRgI4kDONw0/7+9/XDwdkSeleynh9AE4NWsCUWrQeJKvD5R7oUBrpNgkp+H8d9PFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Of4uxHDW; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764905914; x=1796441914;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=shJnbhdCP0RtUejNDZ4Wn6wdxye6pXAylKntrMTYEck=;
  b=Of4uxHDWg140n3EuqAmPqaqufXjcrdWDbKFIObVgBjud4u90VR2mD8+a
   HlrhMll+RQjAOEQGZfcBfS+j2rElhzYaGb23VvE27aoypUX5kvmlM1eM6
   Wr15HWIhBqDWp9oprEZRIwCre5OSBB/GiFOMadE5dy8STO14okfXDfp2T
   tv14XUQSxSpUAJJKOCDMWkaRIWncMTrR10ENqGz3UwmXFCQuY8/HcZYtG
   xKdRpdamDV4UppXvRMrHVYIJ9+C8cQ3s6X3fpJu9teMjT2KcnVhOUCTKJ
   /R0+Px6DtOE9oMmfgFDJAiE0CYh7k1CcFaPOfQKJxOHPmPq34TMLc5VUe
   A==;
X-CSE-ConnectionGUID: KYyu2OMORTuyPDyPMJSXKQ==
X-CSE-MsgGUID: qhF+zfeOTfiE6r7lmCRZ/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="69532156"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="69532156"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 19:38:33 -0800
X-CSE-ConnectionGUID: 8sYldC9CQCiMI0X5cH2iSQ==
X-CSE-MsgGUID: u8hRq2rDRi6exv2xjcg99w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="232523199"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 19:38:33 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 19:38:33 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 19:38:33 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 19:38:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNnyY7boybdggMwDop6Cblemkc06A8YN9bqlZ/kXeoKrlHJQ3EbNnLNHwn7nv9q/uEs3Y+arf3sfKoZfff42KcrdEebtdfGTL16Uh0LVhxQRJuKy+62B9Yj3mApMmsXoiSajoMpY7J7+9RGsQ05df9Wf4SQTIYWZyJcTLuAG3DTItLlCSlB7D2m1QSAx83uHNmYu00HvnURg5gON6DNfEYDGNhwXceAGkLqN2nJQcFFKZ2jQZjANsJEK78Q/0KSMUQUAxJlYk/DyE0p7NLK1zDAjdh1Z6ZtdhheowxBYL679mU9crcQKHi1LDZVKyyU8/0Jj7LR8JIAYGRam5fsg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHhfJjT0uOzKwNxuy5LhhUtf420Uuh7jFcH0Z+cHQ0A=;
 b=HcsZK+ji/qF0wYnNlhRhmONcZWoXIWhuDH3TsG1eEiJ30GQ6IiBGE8q7NUD+FMb6u+TSfIxveuUbB1fpmtUUs7/YFb3mfmbD7v37lxss1wYe8NTXrqd3vf7zSD72sjF+PW0TIOs0eyuEh6/DjjCQ7i2wwG4ndSgv0JInG/NK04MzeHQJjUfZ3aPZXEpD05eL1TpEQhKl5k2jXdmN6uzRg98VJjDNEY/9ruWeEB5DVsKOk1nFUqdAOhFIDSBbFMgC35X4JFHjzBcfeqs5BbH7vy7z+W7beQbf8hf87qt+MOD2VofSyFxWJ3MPBxCBDHyyPj/DM0hXeV8XBI9vOhV9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PR11MB8681.namprd11.prod.outlook.com (2603:10b6:0:49::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Fri, 5 Dec 2025 03:38:26 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 03:38:26 +0000
Date: Thu, 4 Dec 2025 19:38:21 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH 5/6] cxl/mem: Drop @host argument to devm_cxl_add_memdev()
Message-ID: <aTJTrfxAT3P07CP9@aschofie-mobl2.lan>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-6-dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204022136.2573521-6-dan.j.williams@intel.com>
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PR11MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: cedd4c6d-a516-42d1-e6fc-08de33afbfab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xycuC62WhXgtSDB50ZPWQar1izdLaHqmgoV6BgHlecUKmDHu8cHzceRFxmPt?=
 =?us-ascii?Q?7WGazSI4Iqc4+B2fmozX4MIP5Km61L8u98nFuLiXUKM9+KWGqMb9HTaUy032?=
 =?us-ascii?Q?KZiC26GP5spLl11UUwD1RaqUEoAR92hNnZ28NBWOwp6K2AVRnszJXT4i14rx?=
 =?us-ascii?Q?SfZohy5XODrPhUE8s+4y7CTAvicnZRJhrxsfKd+8/OOjDl1g0aEwd1EUfyGZ?=
 =?us-ascii?Q?Mg2L1RdBLfMx22VdzwwbZaFrRS+Qf8jOHsrl6hfuTRAqNyY8kS3IKH/DZCjl?=
 =?us-ascii?Q?6SuW94YJs1n+t/vZHwMGP5rKMQHiJ1RLaxbQIk/plDIDiXlxTy2IaKvI2RT8?=
 =?us-ascii?Q?nkcNIqG3toHHJUAU3PlVwkZUnQj/mJr6sxrKl/Ef0I4jwN+3BgY8iIzAQgF7?=
 =?us-ascii?Q?bVT6YIq3CtwZh+8nl6Iz0LX5g3efIGDFku4CkAKgjvoZoj2ZVNtX6NKU9YUa?=
 =?us-ascii?Q?NTQpIlo1MRd4Tr+Yfad4bjG6EogxYQJw0ir0cckqrELr3SE4ePWbspkELiLA?=
 =?us-ascii?Q?vQMlJ6i40EQVWNv58BZi0kBIDGYXSnFu0lccFIBpdRBA4dkYKqo0F3bclYcZ?=
 =?us-ascii?Q?p7HzCG3+Pg7UpCrfI9QO7Q1HwSvHh5KZyDJqP6rGUdwjMavu3V42Zy5+LgmM?=
 =?us-ascii?Q?Hmwf3vz2jvEeZn8B4SsLJTH4tX5EaL9Ozqx5kRa28Xnb7oQeA9SA3eWJWuoj?=
 =?us-ascii?Q?Bwa9nKA5AoXD0mAWPrjvaYGe9bi8vKIVYk2kghsdKw9/IdcWjJDq9EtStA4+?=
 =?us-ascii?Q?ZZ28ARiXinNcBtTF88Y4hWTrJquLkEStGGXsMUXBpLf1SWsIh+m/sWNkdSeQ?=
 =?us-ascii?Q?n0IPMQlRUwxii8hUMs2r4zfAu8dG2KPqMwiaI5KbppdS2oyMyk8v0S0biHB5?=
 =?us-ascii?Q?kjCYnz3dCWykbdxl/6CU0QPIfdC2EdDQ2fuw94/vAOYbfgiXYPvMD3w4YqpX?=
 =?us-ascii?Q?IvUqbYBAKZ3sftIO+jarFICEQGC3vxUSBoiD+Wt7TbTRdj9gTWyV8qEjsFWZ?=
 =?us-ascii?Q?M3X5Z0+S/+fTJDdijn83BqujzkFUeesOmV+yyUhFwG9haNJlKnVkxzRVAwml?=
 =?us-ascii?Q?xq2I2f96HaKjt3vgtIb2k6ZdByBVjkzeRhFUYAzUr1GhxZXCWhPXgahw8yKk?=
 =?us-ascii?Q?iLge91pIF2eVkriWpefFVfP1DXhlj1MC6n6bfudmyJWDyA10JKVIevjqAYkP?=
 =?us-ascii?Q?gSIrNyAPIm7bF/gMjNHyPEJ9XDNuqs5o2xjITCVkXo/drW0hJr6l3PmUJ/pO?=
 =?us-ascii?Q?lBSdXYdwPgAzZ4rVdpPbxK2iiZrNClqkYaVk3lZdyNHkJZmIQorp7+r+MoTj?=
 =?us-ascii?Q?9wP/Yj90npM/+TOCoBMg9qnd+P/EfKJr8JzWUFt9IL6f9Z++esrkIcq0668g?=
 =?us-ascii?Q?fojeYKhQqBRAjxNRMyqmaYy+Cc7JiCVWYR7ueH7Hh+rSWFmgqiPnDeRh1J2q?=
 =?us-ascii?Q?6OV1EPp0M1EN1jbo2b4/Nxl+K7eZZiXl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+0Mydl+1JjmUTDJED98fxAS7DXICQxreLdUrqh2lw21bHqL16nmRs0ZhOSr9?=
 =?us-ascii?Q?u3tuxyrzvXw+21FFXC264gcTyE2ZGBdOhyNlN0M2/2HlXdOv5jjPNK6RCc5t?=
 =?us-ascii?Q?AgBwDQFz5Kp2o/pZq3d3MQ8ZDuu2qw5nuKlvR8UbzCM6UJC+XpydMiWCgQme?=
 =?us-ascii?Q?a2wNG5JPrL5kpyU1isvHZQRKZNOYo/xfnXMUUQFHnC9skes3FlQOFxcfpw8R?=
 =?us-ascii?Q?+xE0+BvUYFtVohRGT0vX6cmVn/KcIou0eVxDPVXaJpjuiFqDVJgJlcs9m1VH?=
 =?us-ascii?Q?acbDC+0eadAF7hhqxJBv2oc3TgpRfAj/6YFpEP1iGaOVkc2D7V4+Cb7OuF//?=
 =?us-ascii?Q?WDtVE/xY3G4vZEXCf2SQe1VJ6U67wS4Dd2Cku+tRcYgX2PwpQzYXohdumbQF?=
 =?us-ascii?Q?dg7Gxpej+2T1gJAJdqhSPXvVOUYGCzCLGR77PJqsGEfZ6TZJ0bu8fiUkSNjX?=
 =?us-ascii?Q?RvTjADwHFYuxlaGj00m3QdS9kfp/nJY8sAdxuiylqkXbXy2s+VNJN+p1jTti?=
 =?us-ascii?Q?6P78F2kMxO4i1o+htFowBpVJDyq/Ed3EHq/OsgH/9GRg5gu+64e+5sO4G8tP?=
 =?us-ascii?Q?KrTvHt1NqPO5QAatIDMxqiZfDBSRuikVsZHLWnMrcCrBxddZJhWGX5/SNnfM?=
 =?us-ascii?Q?6B/cRdGhf9o50+iI2lLewyFV0Y5/uWIBGDwUrasQ0d30zfinDXpQOUpMXFeL?=
 =?us-ascii?Q?WMbZ9L7spSwtajAyYyagILnJoNp5aE1CfkcJ2ekM8Onz4G9557XwqYZjdUjD?=
 =?us-ascii?Q?nvGa/4AAB4Y5vFcTjT0OjMSL6pNPTHJ+UW1K//iTfe3Zi6bfdfjbrzm0Yvm+?=
 =?us-ascii?Q?pylzH3MBu0zDmn0OWH3YWAEH5Mg49+UMZhSjVH2RP41jqyqvnR5ICnYa0Pt1?=
 =?us-ascii?Q?Fry0gB1Prfx10eHvF0CxH6H3HIVvTOpLtH3/bHljgPG8+wjemYm2SVakYp6Z?=
 =?us-ascii?Q?z2tIgS7i6WMU0L3h0sAm+T/eANS1jACMidGnDFMsDeBcu0nRUu5cs2mN8iE0?=
 =?us-ascii?Q?t3xWOni1T0Z2jfT4F8Ibdkick+VWAmMAQYscladJ7aD9ergoXx4U6DtC2ZTd?=
 =?us-ascii?Q?Jsdbg04MvR16MNFw2Sf1H4FrlK0KsSONVA6KeJULnNLeNxvdKD8O7scMLbg+?=
 =?us-ascii?Q?vKIphcd+S93trvABN7Zdiblsy1TS6F+XhVPrgh/cEwFn6G7i6zn5PuC+cPrP?=
 =?us-ascii?Q?ketY1rGmS/1FGDRXa6CoRovrfzBFARmAIiINEr/b8kGVL6+P2tF6uONBlNtd?=
 =?us-ascii?Q?6I9INMRfs+1Oe4V1q5t7GaKzx5Xhy71eTnPwgHLNViJt45jHQn64nwoFXwQo?=
 =?us-ascii?Q?EKVREbuHkSLjjFJQgh+JmGfIDzLZC3CeoYu8Q6pfCjlVYC+vk5fTA7+RmCCT?=
 =?us-ascii?Q?bTyEDRuwIKI69fEk4xJhaELTv28MddBewZR8ijQDhywp7l4dmoQNXQIAq9ky?=
 =?us-ascii?Q?vDGCKJeAlkc00a5evPu8hSUpMbjO9Y0P0kNP0rH8F/b3TTIKwfc3fWPUruz7?=
 =?us-ascii?Q?B0QA3KLFJ1sWcntz1tPmG9MbeIlaEtrMBOt4wZoscKMv9uV0zzNX04rsMXlz?=
 =?us-ascii?Q?TtjwQZSUBo8UJUJuG2wQF5ZLjARml59hWjmtFEvRqGi8scY2YIR1rXoKbpLc?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cedd4c6d-a516-42d1-e6fc-08de33afbfab
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 03:38:26.4053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXqnu8c+caaHaAv6cb4AD7PjESghjRkkqSsEChTWT8WAzc6LQo1xrlzD9uk24uTjKsA0+iJ8bhbwngebHJKYij6Yjha2Nx/CEGCveU/pdSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8681
X-OriginatorOrg: intel.com

On Wed, Dec 03, 2025 at 06:21:35PM -0800, Dan Williams wrote:
> In all cases the device that created the 'struct cxl_dev_state' instance is
> also the device to host the devm cleanup of devm_cxl_add_memdev(). This
> simplifies the function prototype, and limits a degree of freedom of the
> API.
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


