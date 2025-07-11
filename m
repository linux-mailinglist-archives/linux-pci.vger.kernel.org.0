Return-Path: <linux-pci+bounces-31968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06621B02756
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AC658772F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D9E1F8753;
	Fri, 11 Jul 2025 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2KMhVXV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3671EFFB2
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275076; cv=fail; b=s1QG0mGfTbIBj8vXzUxQC1PZofwhZ8zFIwFO9Hid6Bbnq4jSxqlaaMV7ZsKQj0POtvNv0AUHCaDcoEXcFIt7cPPpfPjmajpvcw22ZeG2OykBwjZLtT3OB5boxzn6LBRHYXKai2b8Rhbd7d2I8Tt6c7YQS3ZmpWrv0KvuFwtqUok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275076; c=relaxed/simple;
	bh=7ufvsV4ZDQpWF+QAfMHEXAT2k8HpP+BWibqA1WEPsys=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=CLsOh87mhiY0E9jV/mipCkYiLuC7qPOPQNvnEdpqphP6XkQFAfqlRs0FznzvhmffouU4cbBK0pza861EU6Rwv3lXUV4FDWU17kQUH8xpBvajj2YDegs9qOUbvitVOKSOSL4r2GvmUI3RuQMA0qmsBkQqHBi/EFXUfKCklLbqMQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2KMhVXV; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752275074; x=1783811074;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7ufvsV4ZDQpWF+QAfMHEXAT2k8HpP+BWibqA1WEPsys=;
  b=F2KMhVXV/O+PhKVH0LBMHsdU6AK1KNfiRkOiwG9h21v7CXe6zHZdlRGT
   Mk++AWkr2h6MuNz/Omchqqf26iZ6vYsab4J0Fflc/jKlk1CUYNlUA9kxX
   XAOWYXfbrKcFmPTiO2crFh7pi/anDnfd75Zw9ImxfQRufjpL8VeP/Z0DD
   diM5FKGjdgKzOdRQyYdiB+e03dmkbkg9+QP3b2YS7GM1CN3BlNaNUmJXy
   dy3oF/dGnISrJc75VnDsj2Vl04lGqgdNMUKxn9QY61RMgUi6ToINRa6X/
   amDgoDhgOPG4zsZeBCJLyTOsKxrnu02/kqP1KHuyvnV7W0U9OSHnGrUfP
   A==;
X-CSE-ConnectionGUID: Tu+lYxykS8CWVANkggMbuA==
X-CSE-MsgGUID: AXO6zEz/Rhik2PveJVJEmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54734201"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54734201"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:04:33 -0700
X-CSE-ConnectionGUID: 1Dp/m/TETMS1mpfeaA2K9A==
X-CSE-MsgGUID: jdjTcC6sRoOUQBZrE7RVOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156810069"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:04:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:04:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 16:04:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2UsifMnKqGbk/FMwCuReWe0H34WVGuF3MCKl6ogCXkYI3UMHHV9dLvbfyp+qJKo0uuzkRwv+ldVqXt5xG3hYXfyD+iZwUd9i2bWT8lUYL5aNv1Fz+6PnF15+GiUgn6MskIBie9rkm8J7QVzDhxMr3x4+a/0zI5l1FYkXAAFgzw3ONhsyniTEZHD1EXyrdMSwt6YB/LEukzUNtXK6Tri5TCjw4HIOWXGFX3/Jzfu9WWuuS8G5itsdxreVlt+89OVbXCCHmZsyhendXxwry2lyb5TArbZluMHfNEnvkuC9OgnnWRVhKjW1fChGMoHsyfqaBUOhI0rjmCRDnYj1F5lyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FKMghXb2qt1gFH+uKZLEAKJp9Zca6RTYSSK9ukGWqY=;
 b=mnzEzOtSmsrsLGtx9bOMMn3HirHxezMn/ZhCLAt4w5xdiSvEbznF3mkXYJDcinTIwV9wVilCqUgZGju27WY+qSQEZDhSTQtC14YeRBBOmsOEzdYGKMtTXoSfXSP9pNd90hMCDayzEd50DSHgkQPt7j/w5uFZtTTdTwGVsYW2w0nDsfNiNM+QAZj3lhn9UonWo/r3Q3zkzMeXtn6vdyJfvpXa1f02iWPufd676o7sVcoVsjkdIiBxyLsCE2jLDzKhESSB2ok0E73ZR+R0dacBt7ZbH6FgV1LVQI9idQEiBz5lNAPTSV3R/iikyqUZZ9+7rpnfo2TbY6C1WANMBvNUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPF0F15BC42D.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Fri, 11 Jul
 2025 23:04:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 23:04:29 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 11 Jul 2025 16:04:27 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <6871987be5e69_1d3d100cd@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <14944158-4a95-4831-b942-5fc9fffa9f2b@amd.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
 <363a3220-e43c-4965-b138-b85f09a5907b@amd.com>
 <682ceffd717b4_1626e1006f@dwillia2-xfh.jf.intel.com.notmuch>
 <cc0e125a-a297-4573-a315-89f4f95324c4@amd.com>
 <683f76a7324e3_1626e100df@dwillia2-xfh.jf.intel.com.notmuch>
 <14944158-4a95-4831-b942-5fc9fffa9f2b@amd.com>
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPF0F15BC42D:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab95729-70eb-4432-e2c5-08ddc0cf4a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0k0MXJIOUVlM1BaT3dMSXNnOVVpK2pnTEdYd1I0eWhjWFJzZXZqZHIzMEFM?=
 =?utf-8?B?Sk1Wc0UvUitzTm15K1BOS1Y1emlWZFhtb0R1WEJjb29NSmxrYWNDMmZNM1Iv?=
 =?utf-8?B?SU5NQlRLT3hUR2h2dklmN1RrdGIyaFFMdXVZVUNYa29kUUhobjVsR0xCTGRM?=
 =?utf-8?B?ZmJ2THV5ZzkxNzByODJYSlNlbDN5bW1XcUlna3cxZS82OGdWNVlxL2tiRG4r?=
 =?utf-8?B?cGdaSDRlV2RxR0V5dVVaSEZTakdNaFNBUWFQSUVWSGF5M3lzY2taYUFiT1Qv?=
 =?utf-8?B?RVB5bVg0eFh5b1pCK1U1bTEyNEpPajhqcGVvbTJHUUlQSHNyR0laYU9aRWxP?=
 =?utf-8?B?RFluOVpmRHV5S3dsY2duYnZSZkpsdk96WWJlcE5FbE4rcFhsWXlpQzE5TXhS?=
 =?utf-8?B?M2tmdE5pQXJTYmcvVlNxS3oxQ3ZWcGpKbDNSUGd4eEU3dnlKenZTdlNaZ1Yz?=
 =?utf-8?B?NWRsbndkVVlkL0EzZVUxZjY5Rkw4aVZyOXdncDhMcE9oRjI1YVI0cDNGMG42?=
 =?utf-8?B?azB4ajNQaUQrT2tjNjgzdU1TdzVyM0xoT01LWHlmMkZLLzlsdXhpQkV0aFVR?=
 =?utf-8?B?dnl4Vk83VXFBVHlKZ0FSUUFwQzNOWHI0dGwrU1E3dWUvdyt6eGtKdWFRcnNm?=
 =?utf-8?B?LzVWem1xNUc2SVdEeWt6NW5mUzRVZ0o5ZXNZOVFFRVhxZHdxOUZOSUUvQ0xn?=
 =?utf-8?B?U1pacjk3U3o5MlIrZG45cDBiemR1RE4wVTZyY2R3YWsyekczZms0YzE5c0c1?=
 =?utf-8?B?UzRaa1VVdHFjcmFhcFMxaUx5UmxFSk14WjIyYis3YUNkdWhQb3dzbjNoK1pt?=
 =?utf-8?B?T1o1LzVwa0w0NGJGbGRGQ0RrQ3NqcnpwQkZiSE5MMEVHUkdFMC9QWVNNK1ZJ?=
 =?utf-8?B?cWl6UTdxMU5icXRveFlidUhzTUtLSERYd1NwaTh4aUNJRlhYSTBPVlRSdlJS?=
 =?utf-8?B?SzVKczVidzBzMklzYzBOeTFYQXFUR0hZNm1YbGtUbHZCNmxFOEl3N2FrZTlG?=
 =?utf-8?B?Q3dLaU15MXVBUnM3VndTRi9CSmtOMm9icXRhSElFczN1aXhXcnFmRkd6b1dq?=
 =?utf-8?B?eHNEc2NvK2w3TDBOTUNCMTdsSzE0TmcyOWw5clUyR044ZUJHdkY5bE1Tb2JQ?=
 =?utf-8?B?TmQxaWM1OElmYnFCTWZ0a1ZITDluWGdGdWoxSDJQVlM0NUNxTUErZHNlL09I?=
 =?utf-8?B?VEVzSDNiWk9aSEZlMlRITUpFVTc1VHRycUUyQ2NBYjkxZjJXMFMwYUlVa1FN?=
 =?utf-8?B?NU9lZWdoeU9zNlo1KzZZS3JWVUtNczlIU1NyTm5ZTHBWZG9BZ3p1QWFJNWdO?=
 =?utf-8?B?bjVpQWVRNnhKUG55eFpicm5yT2R2eTk1UENROEx2aTV5ejV4MFFzY0pSeUxC?=
 =?utf-8?B?VjlqYVgwR2UrcWlwLzhsd2ovYVdZY29ScW16NTgrQ1MzN2JWbitCWFE1OVpD?=
 =?utf-8?B?bzJNSnRmV2FPc29idzJWdnJHcVppV2NhV2FsVkRzbW41UkRJQmRQR3RhWTM0?=
 =?utf-8?B?ZFlQMlRrcGJHWlNRUlpkTktOL1RKRFZ6V2t6MnpTRW9BZURsSlR0bS9QNkFV?=
 =?utf-8?B?NWxkM2FkS3hla0M4QjA1T2dzLzNOZVJyeGNMN0s1djlrdit5eFZ2bHNFTW9r?=
 =?utf-8?B?LzVtZUtZMWxOVjBzL05sVGVrSWVMSnF3YkYyWnZYa1Z4L0hNcXhjVzNuTSth?=
 =?utf-8?B?Y3M1VWZwL0QzRmRsYUoxWlIyZUMyUmZqRkFFcVpwOVhOam9CcmE4OVdnRS83?=
 =?utf-8?B?dE5HOW9wLy91V2wya0w1RENFUWJVblRya0NZU3BSbTNIbkdhcW1zRU9saWdv?=
 =?utf-8?B?WXR1MGlQUGhCN0ZsWmdzcUFmNFlwSzdtWkkzWEloNThiL2I0eTA1RDhwbzdp?=
 =?utf-8?B?MTlJdnJXTG9mekkzd0g0aWk4eFNLQ05KcjNXdCtEK0tSdUVYUktpY1VRZXVW?=
 =?utf-8?Q?1zXSSLUWWA8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U004WXM4eGwweVhqK2JBRGpHVVoyNDliSml4S21TekVOVXpIZForSTdna1li?=
 =?utf-8?B?SVU0WXQvaDAxcVN0L2I1Z2RmcjVPbEpGRlZnbmEyb0xRRE5jNkhlS3c4b1Fp?=
 =?utf-8?B?VEh5a3VSUjFYQVNwT2ZjWWdaaXdLUVF0c055dkh5c01oSmtRZzN2ZGQ4V2No?=
 =?utf-8?B?dmhOYkVtcFcwSkNFd0hZdTFIL04xcE5IZmJVU2tkYU5ZVi9SeXc4MTFCS3F5?=
 =?utf-8?B?c09EYWlTSmtRZ2pyR0pzaFZLSXo0YTlVYUJzS3crSHptdVlFTUJFODI3T3Nr?=
 =?utf-8?B?UDRUdnZnQVAwYkVsTkNoc2FhSTBPWHhLNlZDSjJUKzNQd1NTRDJpYVR2c0JU?=
 =?utf-8?B?T1dxb0ZESTUzeWVzWHk3bUx3eWVIYnoxYUtqQmR4TWpiWHN2L1F3cjEveTMv?=
 =?utf-8?B?R3B5UDBnWEpWNG82cTRHVDI1VjJhTzNkZW03djZkcFIwbkFmOVo2ZlFFR1pt?=
 =?utf-8?B?MU03TnpXMDlBMkRBaXVwdXo0bGNlT2pBd1RmRk9Nc1BSOUhnZWFRVmdTa0gy?=
 =?utf-8?B?bmt1Rmp0NU11bFJIRGVIaVlMSHMrT3BrYllwYXlTNnprbis0NmQyNXEwWnV0?=
 =?utf-8?B?MWVBelJxNUxwR1hOQ1pOZEpxRktFZWkwVXRVaWNXQXRkKzd1a3R5Y2J6RnY2?=
 =?utf-8?B?V0h2b0dFOC8xK0Y5RCtUNmVSdGRJYlc4V25ra1VyTmpEbE5aanZ3bzRqMXBL?=
 =?utf-8?B?bGI0WGVWM0sxbVkvQy83V0xvZE1zUkJ3V25wdG14aDhNTlJyQ0ZpcmFnSy9E?=
 =?utf-8?B?cytQVUdaTUZ2RzZEb0I3dXJiTmVPSU9JNTJ3T0wvZHlSWUNjWGRRQnpmZm5B?=
 =?utf-8?B?RXFuNC82TTVINS9BaWhRdFdwL2R4ZzVFVkhZK1I4a2dpNis1RDY5WVc2V2gw?=
 =?utf-8?B?S2ZpRTgwSUpCeTVNU25GYklvbWdQWUsxOVNTY2lmbnFTcGd6V3JYMzFGZnhu?=
 =?utf-8?B?bm5oOHZDYVFlQjU2bXREZ3JzMUtwaTliVTRiYS9PUkRnRXMwREg1MExMOGNn?=
 =?utf-8?B?dEF6OXRwdmR4ZkZhTlArd3JIQjRaRDNUL3VKN2twaDdKSGVwY2NpMmtvekg3?=
 =?utf-8?B?bzFTK2ZCcFdGVFc0SGxDTVVhT2dZaWNHRkhCRk4rWkZTcVd5UHVDTXlOTGRQ?=
 =?utf-8?B?YmN2YzJyYVZsZW9MWS9CZ3VaZFpLSnNGT1diYzJjK0o5MGJDV1N3RDl3MlA3?=
 =?utf-8?B?anlkazhrNU5YZ2R3UnpVWjFsSUVScHhTQ29ZVm9jTkRkZ2dHcFp1TGZMTjJS?=
 =?utf-8?B?NERMd1RUNFJ5K2Q5UlZtV1ZoN0lqL2kxSTlrRi8xRXlGKzA4UjVCb1NTRVA4?=
 =?utf-8?B?Wk9BV25hMDJxKy9TRGZGd0RRUjM1cW95UkR4Z3dldjA3VDhHc0JlU1N1OWtD?=
 =?utf-8?B?dlFpNndoaGZ3K3FFbkFVSDBpZmZ1em5PVC91eVR2YlI1WXNiM0RrNW4yZVdp?=
 =?utf-8?B?SjNrRXJQbEIwc1BtTUZlK1ZFcjVhOEZCbS9TWE5tSVIzcDY5ekVqK2hkVWkv?=
 =?utf-8?B?NUpjS2hGZUhmcFNJb0JHNTUvZVFoYWpycnR2ci9BcU5XV3NxRDUyTkNHYjRo?=
 =?utf-8?B?TnRxUGhSWHFJb1RPYkRpN2pDdTQ4OVdCc3g1L3J2UjRDZ2ZZSGJYOUVqUkRP?=
 =?utf-8?B?RWU0OEhmMDJFTEJXVUE2UlVmR2FBMEVyM1hrZFdsU0FTK3EvS2J6UVJ2R2tV?=
 =?utf-8?B?dlpublZOYmlmR0JISHlWQldjdk5pYVJ5NzhlZG9wWUk4Rm03UWxrMlJvbzBR?=
 =?utf-8?B?SnhQZ2U5SEZZb3hjZzhYUFlkRHdTRVFDRG84SnVXeXRzczliQzViWElpS3Ft?=
 =?utf-8?B?LzB5dndpTURDOHlQdyt4QkcxdFM3K1BYNDN6SHNMU3FyUnppRER1Y3VMTzZl?=
 =?utf-8?B?UXFxQ3BJRUFmZjZaNDkwaWxjRGtPNllUZm56S2tueTBmc0Z1ZUpHTTdUMmc5?=
 =?utf-8?B?Sk5wY2xjQUtIcVVhY1JvWE11R3Z6ZVBsRkhFYWdKZUdYeTlyQU5XdlZrTG9o?=
 =?utf-8?B?VndtbzlRQ3I0REgxQlRJaVlKbWQyYmpMRDMvNlJBbFNWZ0hZandmU1VjOXR4?=
 =?utf-8?B?SEJ4aE9iTnJYVEp4ckNqUVpuODVMeFJWL3U3UlBGdUFnS3FlblVjZGhncU5S?=
 =?utf-8?B?TlRxUkFXSEJXa1NqcUlDZ3JOSjk0TzB2K1FsVXllOHl6VURoRkFLU0ZIeHFC?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab95729-70eb-4432-e2c5-08ddc0cf4a71
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 23:04:29.8969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewOJGwPQBG1RPg+sP99/Jy0qWRGs1oduufaA/i0ts+wxQ++ZxdJAB7Y2tbKwEjgawflkrhux332k+yAvttEpi5sPrinDNCB+F26IpbSVyNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0F15BC42D
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 4/6/25 08:26, Dan Williams wrote:
> > Alexey Kardashevskiy wrote:
> > [..]
> >>>>> +static int pci_tsm_accept(struct pci_dev *pdev)
> >>>>> +{
> >>>>> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> >>>>> +	int rc;
> >>>>> +
> >>>>> +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
> >>>>
> >>>> Add an empty line.
> >>>
> >>> I think we, as a community, are still figuring out the coding-style
> >>> around scope-based cleanup declarations, but I would argue, no empty
> >>> line required after mid-function variable declarations. Now, in this
> >>> case it is arguably not "mid-function", but all the other occurrences of
> >>> tsm_ops_lock() are checking the result on the immediate next line.
> >>
> >> Do not really care as much :)
> > 
> > Hey, what's kernel development without little side-arguments about
> > whitespace? Will leave it alone for now.
> 
> :)
> 
> >>>>> +	if (!lock)
> >>>>> +		return -EINTR;
> >>>>> +
> >>>>> +	if (tsm->state < PCI_TSM_CONNECT)
> >>>>> +		return -ENXIO;
> >>>>> +	if (tsm->state >= PCI_TSM_ACCEPT)
> >>>>> +		return 0;
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * "Accept" transitions a device to the run state, it is only suitable
> >>>>> +	 * to make that transition from a known DMA-idle (no active mappings)
> >>>>> +	 * state.  The "driver detached" state is a coarse way to assert that
> >>>>> +	 * requirement.
> >>>>
> >>>> And then the userspace will modprobe the driver, which will enable BME
> >>>> and MSE which in turn will render the ERROR state, what is the plan
> >>>> here?
> >>>
> >>> Right, so the notifier proposal [1] gave me pause because of perceived
> >>> complexity and my general reluctance to rely on the magic of notifiers
> >>> when an explicit sequence is easier to read/maintain. The proposal is
> >>> that drivers switch to TDISP aware setup helpers that understand that
> >>> BME and MSE were handled at LOCK. Becauase it is not just
> >>> pci_enable_device() / pci_set_master() awareness that is needed but also
> >>> pci_disable_device() / pci_clear_master() flows that need consideration
> >>> for avoiding/handling the TDISP ERROR state.
> >>>
> >>> I.e. support for TDISP-unaware drivers is not a goal.
> >>
> >> So your plan it to modify driver to switch to the secure mode on the
> >> go? (not arguing, just asking for now)
> > 
> > Effectively, yes. In the non-TDISP case the driver handles the MSE+BME
> > transition, in the TDISP case the driver also effectively handles the
> > same as BME+MSE are superseded by the LOCKED state.
> > 
> > So TVM userspace is responsible for marking the device "accepted" and the
> > driver checks that state before enabling the device (LOCKED -> RUN).
> > 
> > This also allows for kernel debug overrides of the acceptance policy,
> > because, in the end, the Linux kernel trusts drivers. If the TVM owner
> > loads a driver that ignores the "accepted" bit, that is the owner's
> > prerogative. If the TVM owner does not trust a driver there are multiple
> > knobs under the TVM's control to mitigate that mistrust.
> > 
> >> The alternative is - let TSM do the attestation and acceptance and
> >> then "modprobe tdispawaredriver tdisp=on" and change the driver to
> >> assume that BME and MSE are already enabled.
> > 
> > My heartburn with that is that there is an indefinite amount of time
> > whereby a device is MSE + BME active without any driver to deal with the
> > consequences.
> 
> (out of curiosity) AMD can block DMA until the guest decides it is ready and enabled IOMMU for the device, cannot TDX do the same?

Circling back to this as I go to refresh this series...

I am not worried about the host protecting itself, I am worried about
diverging from the model where the device is expected to not be active
while a driver is detached. If the device is enabled to, for example,
trigger platform errors (platform self protection from unauthorized DMA
/ interrupts), that is a difference from the non-CC case.

So this is more about symmetry of behavior with the typical non-CC case
where PCI devices are not issuing or accepting bus cycles while a driver
is detached.

> And what is the consequence of MSE being enabled?

I think the problem is reversed with MSE, you *want* errors to happen
when the driver is detached which is what happens in the non-CC case.

> It is in the guest's best interest to avoid touching MMIO before
> things are set up. p2p DMA?

Yes.

> > For example, what if the device needs some form of reset /
> > re-initialization to quiet an engine or silence an interrupt that
> > immediately starts firing upon the LOCKED -> RUN transition.
> 
> The OS will have to ignore such interrupts, what is a problem with it?

I don't know, but I do know that it would a bug to fix in the non-CC
case. I.e. it is a problem that need not be introduced by maintaining
"driver is in control of MSE+BME activation" (LOCKED->RUN transition).

> > Userspace
> > is not in a good position to make judgements about the state of the
> > device outside of the Interface Report.
> > 
> >>> There are still details to work out like supporting drivers that want to
> >>> stay loaded over the UNLOCKED->LOCKED->RUN transitions, and whether the
> >>> "accept" UAPI triggers entry into "RUN" or still requires a driver to
> >>> perform that.
> > 
> > Yes, I now think entry into "RUN" needs to be a driver triggered event
> > to maintain parity with the safety of the non-TDISP case.
> > 
> > [..]
> >>>>> @@ -135,6 +141,8 @@ struct pci_tsm_guest_req_info {
> >>>>>      * @bind: establish a secure binding with the TVM
> >>>>>      * @unbind: teardown the secure binding
> >>>>>      * @guest_req: handle the vendor specific requests from TVM when bound
> >>>>> + * @accept: TVM-only operation to confirm that system policy allows
> >>>>> + *	    device to access private memory and be mapped with private mmio.
> >>>>>      *
> >>>>>      * @probe and @remove run in pci_tsm_rwsem held for write context. All
> >>>>>      * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
> >>>>> @@ -150,6 +158,7 @@ struct pci_tsm_ops {
> >>>>>     	void (*unbind)(struct pci_tdi *tdi);
> >>>>>     	int (*guest_req)(struct pci_dev *pdev,
> >>>>>     			 struct pci_tsm_guest_req_info *info);
> >>>>> +	int (*accept)(struct pci_dev *pdev);
> >>>>
> >>>>
> >>>> When I posted my v1, I got several comments to not put host and guest
> >>>> callbacks together which makes sense (as only really "connect" and
> >>>> "status" are shared, and I am not sure I like dual use of "connect")
> >>>> and so did I in v2 and yet you are pushing for one struct for all?
> >>>
> >>> Frankly, I missed that feedback and was focused on how to simply extend
> >>> PCI to understand TSM semantics.
> >>
> >> That was literally you (and I think someone else mentioned it too) ;)
> >>
> >> https://lore.kernel.org/all/66d7a10a4d621_3975294ac@dwillia2-xfh.jf.intel.com.notmuch/
> > 
> > Ugh, yes, it seems that joke: "debugging is a murder mystery where you
> > find out you were the killer the whole time." can also be true for patch
> > review.>>> "Lets not mix HV and VM hooks in the same ops without good reason" and
> >> I do not see a good reason here yet.
> >>
> >> More to the point, the host and guest have very little in common to
> >> have one ops struct for both and then deal with questions "do we
> >> execute the code related to PF0 in the guest", etc.
> > 
> > Now that is a problem independent of the ops unification question. The
> > 'struct pci_tsm_pf0' data-type should not be used for guest devices. I
> > will rework that to be a separate data-structure, but still keep
> > 'pci_tsm_ops' unified since the signatures are identical.
> > 
> >> My life definitely got easier with 2 separate structures and my split
> >> to virt/coco/...(tsm-host.c|tsm-guest.c|tsm.c) + pci/tsm.c.
> > 
> > Here is the reason my thinking evolved from that comment. A primary goal
> > of drivers/pci/tsm.c is to give one "Device Security" lifetime model to
> > the PCI core. That means TSM driver discovery (host or guest) lights up
> > TEE I/O capabilities in the PCI topology. That supports "pci_tsm_ops +
> > mode flag" vs separate registration mechanisms for different ops.
> > 
> > I also am not perceiving the need for guest-specific ops beyond
> > ->accept(), as part of what drove my reaction to that RFC proposal was
> > the quantity of proposed ops.
> 
> 
> But this is all the guest will ever need, why allow possibility of
> (not) dealing with IDE/DOE in the guest? We will end up with
> "host-connect" and "guest-connect" when talking about this, having 2
> types of bind (VFIO bind and TDI bind) is already confusing people
> whom I tell about this TSM business. And a global pointer, why... :(
> 
> "tvm_mode == !!tsm_ops->accept" - this kind of knob should really be
> compile-time imho.
> 
> Is it going to be one TSM driver for TDX host and guest, sharing
> measurable amount of code? I am definitely missing a bigger picture
> here. Thanks,

FWIW between this and Aneesh's comments about the different ops needed
for guest vs host side I am going to separate them in the next version.

