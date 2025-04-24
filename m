Return-Path: <linux-pci+bounces-26632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FED3A99E29
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862EB4487E5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1CF41C7F;
	Thu, 24 Apr 2025 01:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEe0kcj+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7771BEF8C;
	Thu, 24 Apr 2025 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745457980; cv=fail; b=G04rOCfwkHTcZdWN1PKRS5H2Rq+VN3LhPa9KQBpHJNV/cvTjYqiqpcE6GiRlVBIfzFxtN8ZkKHTGBW0o+ShUSxxX+PvyoxIwEBwyUQkt4zex+wg+nNqgOrwpT6i40ofuF2fgs8ah+6q8IlKdoxBcwyiB1AGwe+aiksIzoJzFBsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745457980; c=relaxed/simple;
	bh=F/gaC3L07sxbVS/aknfR2Q3eUvujth6TPBi3sVNL838=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U7VyCTNje34SoEpQQbUWnf3mlMe+io9tMKaLOBXXDOhFygkQWcvArbdBWNfqESpdN9jJxjlybNiworcCcEmlpppcU4ojtHKsexn3krPY92HidWeYG8NIs25byLkNLD016z8JU1QKCFtiFSRRhaOtQyBrNcVM/UnC8a0ZpC4yGw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEe0kcj+; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745457978; x=1776993978;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F/gaC3L07sxbVS/aknfR2Q3eUvujth6TPBi3sVNL838=;
  b=lEe0kcj+n1oatxibC4Mys4VUWQVPn7XERlahS9ca2Um9Fpi30q1qzHOl
   snsEENxX9OrCIcdCZg+5CQQarSxvavUcCPssn7IRDtwXSSQognoZsu3KV
   dHIZIFqtEk8/f7fCFGML6khBKqHCRR3jgqyo05EkkWgPaZrA1uK15kJ7a
   bDomsW71EtT3CFmAGo4UkSQIJYvbfuPzH+EJMH+kv5ZxCLiBmMgWGXB9G
   ZWciBLGooXXpaFAAs1BgS/evVTUzbWDCdyAKYi8Uwy5tYU6BFKJmMDZEL
   t2nDQz7ZGPvaZgx6NtFtcDn/9Prbjwyy3wcEL/spXxGvNs8eeM5jhDxQa
   A==;
X-CSE-ConnectionGUID: 2D7YBMFlRyevEYa1EDsJcA==
X-CSE-MsgGUID: N9EFD8hhS7qo4TnstJpyYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47200468"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47200468"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:26:18 -0700
X-CSE-ConnectionGUID: Zh/Lrg8BRFaT4+lk/VNotA==
X-CSE-MsgGUID: nt70Bo7HS6W1aPohR8aYWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="169684424"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:26:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 18:26:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 18:26:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 18:26:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esHRHlcR1BWGnGXuqm+PCLrZDi7PQClQhaNrN+cscL4qIufvA78VVifGkSZMD3S9vcWZBCXG6OyAhEbyr5memz2zVjwryYblJkUTvySHM2ht8fUmv7ZesV4JX3k89P0lJxRc69VfjG/QtM/513lr4I4WUsv695Xd99vbLQulfSz5FgESUq8Kv+QstNBh3lDWCJe5P9P1Yw3r0ZqP2Msg7Pb3Es9IVkm4ro5ih8iL/T/oDDHMV1I2QqzdS7k68rqMuGDCBo4OD9Vo4kpsFPqtR4yBo21SFHq5yr2PtdbVL+ZiqoV1UUjzHQuiolOdyV0YiXaw9+jIammAC+ECBGI64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bamLvTJ3a+aEVi3osxMCydGkM4F2gK73xc3RLjLnpMo=;
 b=qI8Kgb/wP/eoLLVRGc7W4CugPEiuH7jqQ+bBfREXcVXWduA0BlBJRd+J5yZxxuvoKrYQPOvOHMPKxzvVQTKMZGf0AM+93FmwsmMY40azjSRUAYtjA+UZjx6SLgy0S64i2y6Nf3vM4XTGoJplGx/mvdDQhbC2+/tO2y3XM/WWZMdUm5HqXDHPGCnojDm+mtraCGQFsujK7X7RwjcUPY5m8t4TQaPaaf7pepfkf3wydprdGcqh8+cGjTixTrHw3FfVYQDE4Iq0ZJ7bfR1nfI30Uh4uaQSLiuemm5JwYES/jAK4/pCO3KjxWYfDm6Cs0i66Da+OTq2Ei8T/oTm2IjmNBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6852.namprd11.prod.outlook.com (2603:10b6:806:2a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Thu, 24 Apr
 2025 01:26:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Thu, 24 Apr 2025
 01:26:14 +0000
Date: Wed, 23 Apr 2025 18:26:10 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>, <corbet@lwn.net>,
	<bhelgaas@google.com>, <kuurtb@gmail.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <vkoul@kernel.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<sanyog.r.kale@intel.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <dan.j.williams@intel.com>,
	<andriy.shevchenko@linux.intel.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<Dell.Client.Kernel@dell.com>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH 1/7] sysfs: Rename attribute group visibility macros
Message-ID: <680993326d51e_71fe294c6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250423175040.784680-1-david.e.box@linux.intel.com>
 <20250423175040.784680-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423175040.784680-2-david.e.box@linux.intel.com>
X-ClientProxiedBy: MW4PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:303:16d::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 12aae4d2-1b3f-4c94-a50d-08dd82cf00c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XJRXlDviGyT1g1TUdghKDF6GBO9bfVgVc4vL4gMIq6NtvSIMD3lJtxSxEx0n?=
 =?us-ascii?Q?DITMB5gD6eivO62lSUrs75lDSmtye3i+h0pK0idpWvTA0ZzZPxwHZJDoymHq?=
 =?us-ascii?Q?MBD9aepdX3954MMlIIKE8CuLqo/Jrm+FlKRDzKOHhRRdDVlTsCDuWcQH6VL6?=
 =?us-ascii?Q?yIOG0jfwCS64699l8GD+ojk9XThBcf1glOy2MDQAnQ6/WM5gliagVoHaERmz?=
 =?us-ascii?Q?6bDvhAf4lMaRvbjD1EsmR2BYUKFKfEA24ADMnrvCR/ZsSpz3XUOQ5dNospHM?=
 =?us-ascii?Q?2CZXz0cUHHD49KdhJQic5Onao6+vK2n0R1WSE5CoWIn5/j3Dosa4FHB36oV9?=
 =?us-ascii?Q?R0+uoLnGZfb5GsSzTx7mW1ZwxAruTERGUjLvEK8UFVHaPPFX93gzxi5l0R8Q?=
 =?us-ascii?Q?nLtuErnMKGwB8VMlBqQd5nvvu+IwNqx94OeK7Ud7WGb9VnZkILdJdMevuKZM?=
 =?us-ascii?Q?deDqgDgb3XoJ0ugrBD1lTQDsyOn2fZmmPMixMRnb1A/j97A8KDDChb7isWwC?=
 =?us-ascii?Q?EiraLRsAzFyxUaASnjox0LOW9ObEleH+vpu0g4Fgt2xmKSYnGQFPEDezpuHl?=
 =?us-ascii?Q?cyICfsp/RtfZD7onNg44822jJ6UDKpI8PvVeuazbx8OZaFmYLpBGUPWrSuu3?=
 =?us-ascii?Q?Qgf1WRFyCmXL8IgLZKyH162ScdAJPCmRLJ9kIJwfWy/JJqwPLZaKwvhjlzEo?=
 =?us-ascii?Q?h9/9VM7ebJGFmoDJSGoNKtm1yWLSj4HoKFoHnhZMoyZdfxuB/RfYWPjcGaoS?=
 =?us-ascii?Q?C4ZbGnSjuurRvYdWnIE155hywrmeuXtScUxfaTrwIocu/C8Frqy5oLZcUQsx?=
 =?us-ascii?Q?8zjxv5vQnX2Ny9X1z5OBiwGfsLSg7wwDyH7OI4TORTPKWpmktuzK56ABxted?=
 =?us-ascii?Q?UBz6qxQo8rkVFPeT76GsEtkr22MLGrvdm39R5PTUvXIV4TfvZbvn0RBE2Hyl?=
 =?us-ascii?Q?kYBgTW3qXcfNohH7CLif99zVfw1yt3mwAramYARrXviJsG+kWy+EUijyWapK?=
 =?us-ascii?Q?TEdiERdBBQGitcEiATzqzqwVWJO7Irg3bbLTjaPuJkGVwhM8oSi85+J9+o5+?=
 =?us-ascii?Q?vHaoNUHcJPfVcYd/mC9KPG9wSKCsuvrN5bnPEVITIlPSJE8lp5r06g/I4nZt?=
 =?us-ascii?Q?0wBuV1K/GCtyM4j5lZ07FtJgw5P7Ms5u0ticrGQOmUu8e1+Yuyp56/xfr8jd?=
 =?us-ascii?Q?apsf8QKKNLwTRV4I0UdFsYlKrcoQkqc1Xx13GxbHRkU+NZ7gqhLrcgeg/zDP?=
 =?us-ascii?Q?kiOWETL4NYI41YB2u9Q1XpJzlboqwJm5mVX6u8hyIViVkChlgu2GHxNJ42pb?=
 =?us-ascii?Q?eTs8gBeVjrv9XJjMuuvtyxJT50B1bFaRbu/p7n1l+lCCO31sKOdrW3Ql3V3g?=
 =?us-ascii?Q?gv4k7U89R7bLix+IF/+HsdH4br65jgrcD4eNpMIZvxrr+CXZmYEv2xeRVv0F?=
 =?us-ascii?Q?h6cCEiDQOOb4haFoozgLqBj74+9pHUgTz2JscuKwW9lPtdoBxbaekw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8XN81t3qn3uloBW0gKpwsUg4ShYm86cMjcMj5t/5fP9gHxfj73tTfL5gF4wJ?=
 =?us-ascii?Q?TiGq6K5UHfKlM5hUj3lR9u4cfRAmqX3tmG8t1q1V1cgPq2F30E/QPGvbvKG8?=
 =?us-ascii?Q?xIScZYDni6Mzsn4z7R05882k4PfpNe5j+TlOzL7PNDSsyr2FzF5I8+BfbyY4?=
 =?us-ascii?Q?noGnIXPb9u3bKNDxIS3SQnZ5drUUMjneHNqhFyhqhKXXIKPWct5wrFJZWz/8?=
 =?us-ascii?Q?HWRD0VeLyXbQ9a9FL5CbHk7J2GMAT/UUdKIgSqODkaHlHddjNxZv2fiWIIjS?=
 =?us-ascii?Q?c551wx+QeEI4UOKvLMlhJjJGu9XD6YLiD0kDbuSdOQhWNfJ8zu/VwKlGC1y+?=
 =?us-ascii?Q?2k1gL0Ud7Y8taxmq7Vp3ezB9kOIZzekEj9/RjPFexJkZ9Wx/GGhmniuaj4Oh?=
 =?us-ascii?Q?SVZjDDxPPr6Ia5EIX/I0YXkZO70K/aK+yeliBpvA8BLA315b+TbAim4HlYuv?=
 =?us-ascii?Q?SW5HnGOeVaKYrLn+uRmGETawm2QYZynnvtXaQip0cCuzhlggwOrNyLh6uSbT?=
 =?us-ascii?Q?W0d4qnxjgAJMk/L90+PZBO2JMZ9VisjVB4c5s7+iks22ylzDHFSyqPe/BeWb?=
 =?us-ascii?Q?gP02qkE+TjJUCdv+I6kdB5XmDGSXPLvZG2OYEpB2CYSyxpld7NoogbTMBZaJ?=
 =?us-ascii?Q?+YWcrMZtc8EjPpAoKFkh6mhsnDIWyt2k4SFQO68eHVUJf4hMI8j7U0IAUeWt?=
 =?us-ascii?Q?uu2Rr+AS1VK+en576u7JtwFEjBqY1wuF2fv+yEE283Pz6sI2cylniuQ8CaYA?=
 =?us-ascii?Q?Fq9IvIyHgQ6I2B0WrThhMQCcb2fWunu127dGzg3SO/BDUrD08tSqss9YtK3q?=
 =?us-ascii?Q?nYXem1sN5zmXsQ9dtztz6aYyn2aBXXKMYr3MPQrxsA38rh6Iwoo0y0x/jSmU?=
 =?us-ascii?Q?/ZDTS5GcxcEpTfsgEBF6TUEwKCgR7QbvZxGg9pTfd5HkgCnDwUAegWvyrvVl?=
 =?us-ascii?Q?Gju+YDqB9TIkm5atXCG9YrWrbJG0msUoaXmmLR/k0jFvLF5Aaexp8wf4yOqM?=
 =?us-ascii?Q?/8+MoHvtotzXG4GzFUv6me2/98kgbgV4Cw6zS3fZJoE/3g9Fd8FY912yObYy?=
 =?us-ascii?Q?8gJcWp4S9YS8fQ4iHazSGGrXhdgwy0UyIGMfmqxkDp4Ts1R0WaHMAj8Z6AZB?=
 =?us-ascii?Q?oKfophVzXUzgrEKlULxwi0dVBukRvFQHnZK7wfbgscLFCWgNiXAbCayVX/qc?=
 =?us-ascii?Q?AxFGavfn14R5KJgqFNLPA9Od3aOPcVZXj5HNyx02sqYzPmdu/BlhzYOPXTfh?=
 =?us-ascii?Q?CcdSjpjy/0+GSitWjoIX+9/KEG8RFTIXApmNFbkj3V+5+8ez0iQnMRnb11P+?=
 =?us-ascii?Q?+gRu0HLOz1YansrKlK6CK7AmrTDrj9UZkGFNvRqcKdwmntPqdSKx2EoMnbQH?=
 =?us-ascii?Q?zWkAGwrL/5RlGOJMUnNS+WXmfN7+G5slHwRxsGUCksW3rUUl8N+mu7VojU87?=
 =?us-ascii?Q?u/jZxlfXH7p/IfWWYq1nkipLGkYPBac9Lvm8wbWYtN8CcPeaXpxF/WFXp0Dv?=
 =?us-ascii?Q?5f4Mbah1Q3u7Y8r9hj45SKjY/55nnuLMocHamZ2SvJkQ3FOSC45VhqcjIJIs?=
 =?us-ascii?Q?b5u5+vbzzJcT3yAFwWDsbqrUlbfEbYkq9eTDmJopSp47iJgt9CJ/EJfXkq1u?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aae4d2-1b3f-4c94-a50d-08dd82cf00c0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:26:14.1100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KH/GW6LtT8yOHG6B+vS3ogqND1LkvhxLk1a8Ejeegr0lQQvocELV4rtmgzWSoIFfGvQ73DXuzhT4ycB02myZe8/ydZX3HtNaJtR/3JRu508=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6852
X-OriginatorOrg: intel.com

David E. Box wrote:
> Update the naming of several macros to provide clearer semantics for
> controlling group and attribute visibility per Dan Williams' suggestion.
> Also, add transitional aliases mapping the old macro names to the new ones
> so that driver code remains functional before changes are again made in a
> future macro encapsulation patch. This approach ensures that when the
> encapsulation work is applied, drivers will only need to be updated once
> without breaking compatibility.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  include/linux/sysfs.h | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index 18f7e1fd093c..00dc88776f21 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -116,7 +116,7 @@ struct attribute_group {
>  #define SYSFS_GROUP_INVISIBLE	020000
>  
>  /*
> - * DEFINE_SYSFS_GROUP_VISIBLE(name):
> + * DEFINE_SYSFS_GROUP_COMBO_VISIBILITY(name):

This patch looks good, I just find myself wishing what "combo" means was
mentioned somewhere to clarify the distinction with the non-combo
flavor.

Something like:

@@ -123,6 +123,10 @@ struct attribute_group {
  *     This allows for static declaration of attribute_groups, and the
  *     simplification of attribute visibility lifetime that implies,
  *     without polluting sysfs with empty attribute directories.
+ *
+ *     "COMBO" implies that both the individual attribute
+ *     @name_attr_visible() and group @name_group_visible() helpers
+ *     must be defined.
  * Ex.
  *
  * static umode_t example_attr_visible(struct kobject *kobj,

>  /*
> - * DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(name):
> + * DEFINE_SYSFS_GROUP_VISIBILITY(name):
>   *	A helper macro to pair with SYSFS_GROUP_VISIBLE() that like
> - *	DEFINE_SYSFS_GROUP_VISIBLE() controls group visibility, but does
> + *	DEFINE_SYSFS_GROUP_COMBO_VISIBILITY() controls group visibility, but does
>   *	not require the implementation of a per-attribute visibility
>   *	callback.

@@ -166,10 +170,10 @@ struct attribute_group {
 
 /*
  * DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(name):
- *     A helper macro to pair with SYSFS_GROUP_VISIBLE() that like
- *     DEFINE_SYSFS_GROUP_VISIBLE() controls group visibility, but does
- *     not require the implementation of a per-attribute visibility
- *     callback.
+ *     A helper macro to pair with SYSFS_GROUP_VISIBLE(). Unlike
+ *     DEFINE_SYSFS_GROUP_COMBO_VISIBILITY() only a single
+ *     @name_group_visible() helper needs to be defined.
+ *
  * Ex.
  *
  * static bool example_group_visible(struct kobject *kobj)

...and then that hopefully makes it clearer what the requirements are
because truth to be told even I forgot what "combo" meant.

With those clarifications you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

