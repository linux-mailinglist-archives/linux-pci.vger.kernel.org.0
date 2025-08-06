Return-Path: <linux-pci+bounces-33485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EDCB1CE52
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 23:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADFA3BEDFB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 21:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA1D1F2BB8;
	Wed,  6 Aug 2025 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTvjQVpi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1521D585;
	Wed,  6 Aug 2025 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515135; cv=fail; b=DffRI+xFoq920n2U4Krjs1GZk3MHOXBD557tBKuB+c6mq8K2+y15nVWbWKcPNnE1hKX7i9llvpKD8Ljf9/TU5xuL3kqzND5WE23DzGUKTa5Qp+/RRmqTK5WLrEcKID4C3z7ODxcTXF77+nfqqwQp/7fhqJmT5AOQSS8NWmmNxKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515135; c=relaxed/simple;
	bh=MRtau3SeAFvKP+CyCLIN0UTpOA0vuFwnCpbiUcmDXrI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=bya2e9dlL5jgwt2jLdtn9pp7bCTy9YTZTDLdfqamVcEvIfzgqLCX6qckJCpao2a/PAKIwatXBBMd+lRWMCEo+kf0DccnFUG6IeUTnWQ6jTIdMC00Mchv3nEzSahUNkE114TmGZSWKmRNqySf32lVpMQ2TBZ0FaE6wJuOOWRG4W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTvjQVpi; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754515134; x=1786051134;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=MRtau3SeAFvKP+CyCLIN0UTpOA0vuFwnCpbiUcmDXrI=;
  b=VTvjQVpiR8b0/UTyXQIJSRVc5CA/uRewfN37LYg+gOvicuhyzx7QD91C
   SlxUwDVGgjINyYRrLFfz6vlzVFidPSDOEWgTAyzzWAPNX+vYjcH5oP2nA
   HBniNoJgFYEGfb9MFWs9hacu8/x9U49X6j5mobWZVSUXMWJxnwjhDSLer
   apzlIJ/A15pzK0KoUlxF0y/+5Z0tJOF2MP9VGnMK6z2F0Ld4eOvRKL97y
   x8+K8F7boiMZ071PVu5bu+3bs25okBj40gnBtp7B/a6q0sMbRw0OHsz+V
   1hQpxSHyIqabtMpEjBc475eCHTlRnFWLOUVBVM7ML7DdulhD2sQYqa4uk
   A==;
X-CSE-ConnectionGUID: yCN6G25uSoWe5V0uy9N3UA==
X-CSE-MsgGUID: apEYRPprTMebVIbpCJrR0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60682694"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="60682694"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:18:53 -0700
X-CSE-ConnectionGUID: wit3qwKdQOed10XUmg4Bhg==
X-CSE-MsgGUID: gUQ07AOpSTOpNMRT3nGA1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="170243956"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:18:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:18:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 14:18:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivQdcO/YdGC8s0QjZEqT+lsXGxPmqlMQNyTmcPk7AogNB+zd8zbj3bxAgu9YJTQyCH7mVBzha1xFMKawTbSSACigftvn2ap2t7wOyI8YVQrffBRENDHM4xQ3RbdgGDmq3HzmVEOj2dL7pG9HWaJfuNsbmQA67sGQROSvhxonQ/+ZzBl/CWGRAMlqlyKpcYP3K3CUka7jjMoJVgv5dLfqlgeAdU8r99FH3hRwYsamehUeYrq5gid0jaMDm4VSc/y3kRtqYiXiHjsUESKG3IOIgiZv+32UEmKWZ6oJeMl0+sIV1mTY5JRqulYGlZNr7Oc5lbGjUKCPWT02ylpDUqecLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBXbjqqNziXWo00EuBcNxpNR5DWrzRhdHFWUKfbN4cQ=;
 b=mYUeSFbK0yw910CUQFefCtGqIrbTRkqTYl+mPISHbqAttrTSVkzdIOmf1WIy2UATcY392cFyxwYj0wVp/Hvw0WgLT+yLVK0WQ8d3jhAL0fTgVOW6XCnKAvzxRJoHylrxLWOcRfjTDMIzry/LsP+2aj71jJc5awtIua8Pk1zeNbZ4a/y2+tA6DNgXrGzcppIZqcjPVgnkixPVS9Ec4hPPPC9MxI1QPdX+lEjmHHob9wT4RlVyCTYaLO3wSv4nUIZh0lVKQo/IpTBCZIY/2nRxnovek/oeciew/asIFqGp4Udgnwp3pCPPiazV6QkYfTRjf/Ax4xTHrTEvklbgy7anrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5022.namprd11.prod.outlook.com (2603:10b6:a03:2d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 21:18:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 21:18:50 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 6 Aug 2025 14:18:48 -0700
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will
 Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, "Aneesh
 Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Message-ID: <6893c6b8a921_cff99100d7@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250728135216.48084-7-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v1 06/38] iommufd: Add and option to request for bar
 mapping with IORESOURCE_EXCLUSIVE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 552a879b-d5bf-4981-178a-08ddd52ed67f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3JGb1BpdzhpSUt6NzUwQjFVV0xoejNGVVZTMXlTY0NKOVhES0NYdDV1SDdl?=
 =?utf-8?B?MFRmL1lnZTdkZTgvak1OS1hKd0tzU2dheWhManlUSFM5Mk5WN1FiR2hwbEZW?=
 =?utf-8?B?QUQ1cmZkU1JCSnhMWGFsUUZBd2dtUmIwT1o4L0JSWnNJNlBlYjFmK2dJVXZW?=
 =?utf-8?B?ZU03TWtuaDU4YVBJOHlqNG1HUEtqZUh0YzdmOTZRVlhRYUtrdGgvb1pzTzZQ?=
 =?utf-8?B?SFZ3djE1MXV6b1RNeHRUN1NUVUk1dlkrOXJmOEJNL3Jmd3ZMUzM5T1VnWFg5?=
 =?utf-8?B?SEt0MW51QVJLaDRkNXR1Tkl6Q2lZTCs3L3U1UUxORXFYQkxVQURqbGx3Qisw?=
 =?utf-8?B?S251MDZybXA1bnJRUUoyK0hHdkhnbUF1Wk5PcFd0dVBtVFF4cHpxRTZRVG9m?=
 =?utf-8?B?azNuRFZVQWtWRkJ5cHJPOTVyMVJrR3NZV2JLL0VKOGNGcFkwcndkWTBEc0Fk?=
 =?utf-8?B?MGc1YnR6dU1qaHBoRkRxTXZ6ZjlRMWFHUzhLb3Y3TktKdEU3KzA4NkZEZnRw?=
 =?utf-8?B?TzdxbWRXbzJJYkxPQjZYektkRlZHUUd2ZGFXY0Voc2kzSWY4QWVIWitVemZq?=
 =?utf-8?B?M3ZzamhaTU4xQ3lBV1kwM1M3WnFpbVZKYkwzZzZBc0xOenNaVk1leThvdHFQ?=
 =?utf-8?B?TnhDL1JmN1hiNFNIMVJBU29uUkswNU1sSFNOQldPSkZNUGVGUUZyUU9EOERJ?=
 =?utf-8?B?d0VvdlZzQ2ZuenRvK2Q3eEhOaTJuR3BzQkh0S0Jsd0x5VVdaMFZ0eDUrMndF?=
 =?utf-8?B?aGVuUzliWXFZQ1I3alk3SVlFd29FRjA1U0xGUlRoUU1ianVra3B1cE5hRk1N?=
 =?utf-8?B?RnJ0ZVRNb2xaeGVlemJZN1V3RmNEM1d4YTgzYk8yajhsQlVwRTJNZkQ5TzVi?=
 =?utf-8?B?T2dSeWt5dDJVVUVQa3crNlUwU0czMDB0U0JZdEsvcmlUNG5XTFdXNG44akk0?=
 =?utf-8?B?U2c2MVdxZ0VjRkVOcjZVOHdRZjVlTnpmTm9tSXRLSGZENXVrRzc3a0M3RGUv?=
 =?utf-8?B?azRzbmVQczVMZjdIazdpT0xoSUpiUmwvKytqb3NaTVRNdFdYOHlQeXZiV1My?=
 =?utf-8?B?UFFtaEVpbW1lZmhXMUhqaHdGb0x2bjgxQ1I1U0hUY1NtT09DRWphODNUa3lo?=
 =?utf-8?B?anNsUFZDL2JYdnVzdkhQNi9QTWRsVGJmSDI0UW1ab3R1WXpEZDllN2hPKzRN?=
 =?utf-8?B?L254RlpySTQvQXBwSVRBTmJBVVkvM1hqV3lESDhZVVhXcVBPdVZIZUx2Q3pM?=
 =?utf-8?B?aFRYSHBUN2pHWTV0SHl1cjBYTDExb1FjR3QrWDFsTEVTZmkwd1BCZGVRZEVM?=
 =?utf-8?B?TmVYckNoN0tjeWtPaldIYjJjUTB6ZlErL09WK0lhc0dXMklyNTZmMndsSng1?=
 =?utf-8?B?QmE3SEhmV2lUanlBREVkR3pZWmZNcGNaMFNKMlE2dVRzaFl6NW0vRVlDdlMr?=
 =?utf-8?B?TUQ4MmVNQU9kSlNPZ010WVJxLzkwU0pST0pMQVpMcDF2ZkNpS2NRV1dWNFY4?=
 =?utf-8?B?TjJjK2R6WkZmUW8zajV2QkNZQk0wM0JDbGJXTDJMSUZwVHlBU1FJSmdHMkkx?=
 =?utf-8?B?QjJlY0NBLzc0bnZOaXE1VTNNOVFsMWdWc3RtYUljMzZ2VHRHMldKME1vTHp4?=
 =?utf-8?B?RTdxbUlOVmJlMXVPYjc5MldIY200YWtsU1p4d0pFVURpQkJBeHMxRHZXUW9j?=
 =?utf-8?B?andVT2wxSml4SnB6UkhqM1NONGVtTW80alZHYmxST0h0UXdEbnpVc1JwY2N1?=
 =?utf-8?B?WldqU2pNYVFtcStOdUZGVytlZEIzN2J6TmZBc3Q3cDlLRi9vYk1yYVNzemor?=
 =?utf-8?B?TUsyYnpYQUFSd2N3M00vM1VpaGZHZG1GeG55djNIeDNxMXhxZG9hTVdaZFlW?=
 =?utf-8?B?M0VkSjJ4ZCtTczQvN1JPN1o2N2l5OUZYRURVb2NpWW9NZjE5OUdIdXRrcVJq?=
 =?utf-8?Q?UVWgW8408cA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTRYMXVXRG1COUxUTFV5Q3hYdXhad0p3UjVib3RjUlR6dEs3ZXY4cGZsTXlz?=
 =?utf-8?B?Sm5UK3ZpNlRuV0djN1RiL1RDT1Rwa1NwcGtQUVUwa3FCMEloRHpQMU92Zm5G?=
 =?utf-8?B?VW5GMmtYWHZoc0lPWEUvVjlQZzZ2YzBCb1NSclRqQVR2ZHFlQU41TVlsMlh4?=
 =?utf-8?B?YkVDNHhleUxwcFdxSVZQOGE1T1hQUENTZk1yZ2lxUW9TUTFVWW5WaDZ1dFRa?=
 =?utf-8?B?VmVNUk1Dc2w4RGtKSFhBbDVwOTQxTGtNWFlCRFVKNHNSNnoyeENINXNOOXBQ?=
 =?utf-8?B?MVB2WW8yNFFmQmRBMVFiRVR0dzNKQ3RLVWpZbmNGa08wNUwwTVJNR3h6bmda?=
 =?utf-8?B?Q2R2MjdWR1NEeWdYMzJtSEliYXJIbUNVR2pOYi9BQTh0M0FsL0tFYzFqRW4w?=
 =?utf-8?B?amwxMjhoOUc2Wjd4eHZ4NXY1VkJkY29VTlRjQTE0cjRkMWRVT25LR2RDWkZm?=
 =?utf-8?B?QlRnRmt1Yi9MSUJNZjBVczNqb0FYdFRtOGVlZ05ydW5FY2QrY0NHWnI0Smlm?=
 =?utf-8?B?Qk9zMlVSYWxKUjZ1TDd5aGtJOElrZlNCdWd1ZDRmWXdiMzRvMXkvaFZOWWRD?=
 =?utf-8?B?cHNiNVJkUThHSm80UDdzU2lERFkzU09oUWw2dUpzZ0o5SWN3ZGtPMzNYSHMz?=
 =?utf-8?B?T3BkSCthUE04ZWdPUlFpL1EvUlZnRHcyVEw3SEdMZms0eHdoS2JYVDFobU1M?=
 =?utf-8?B?bHZuZ0xqeXV2QkFkbnd1MFhPbnRxTmozRWlJcUZMSzU2SERIZlM3QlY0cjVj?=
 =?utf-8?B?S0FDb28rcDlnekd5REIzVnZwMEl5Umg3bFk1TS9uYmp3c1R3YnA2MFhpcTJl?=
 =?utf-8?B?SkdWUTMzRjZ6ZUZ2QUlHdUh0Qk9FWUtBcVpBbHh0TUZ5K2JqOEJGMko0K3ps?=
 =?utf-8?B?TTNhRUt3NWxmSWMxNzN2VDZ3UGdYaFoxblZQS1hTTTVBREdEYVl5Vldsc3VU?=
 =?utf-8?B?RVpTWmRoMi9mVzh3T0VlUWJEYy9tQ3FxWHdQMXBMS1lKdHVYb1F6QnNmOU9V?=
 =?utf-8?B?RkNDVjV1Y1J0REVHWjFoT3l5VWd1UXZqQnd5dnF1WjlYVnlaaWpLUklUNW15?=
 =?utf-8?B?VytIVUFrVURVbGp1czhwZGhFdVg1S3ZaZ3FtT0FTMWhXOW9VSzhEM1J0cG9k?=
 =?utf-8?B?UlJNU2h6cmZiTG5tRGs5Z01yajBLRURJV0FKVTlXdy9YSkxwcXRqK3N5dUd4?=
 =?utf-8?B?MDNSbXFRTW5MeldBNlpRT09ubmtRaVAzK0pEYmdwMXdwM3dMQ1ovY3A1TUIv?=
 =?utf-8?B?NmxFejBzdlNzNXNXTHczRWMrMjhIeDZVbkdyZmI1WTJtbnJwYWNLRjVFdU10?=
 =?utf-8?B?T05CTDNQYW52SDkybGIvRy9ta2wxNkxCdnF5OU52dGRpVURST1ZCcDJCZkor?=
 =?utf-8?B?b2k2Y0lZbThzblRFN29rVG9TYVhXbnNOckYrRCtSa0tTQit5OVB2b1NPNFcy?=
 =?utf-8?B?OEhtRXRxMktLbGwwMW5FdllNVlNaVEZYSnd3SUMxZWVIcGtiTC9hT3FzcFlu?=
 =?utf-8?B?RWFkc05MRlJFTm16M0hOV3dnK1RzbDNoNi85dEptSmJoRmxiNkdjaGY5bVp1?=
 =?utf-8?B?eHp2SzdONXV5Y0ZoeHJsWE5sMWd2UmdRK2Jyd2ZHVmdmeW85cEYybWJqRHd1?=
 =?utf-8?B?d1V3YnJ6MVYrRy9LOWJ4UnJlK1VOMElXVUdsNWo2V25mOVEwbnBoczdMVkJR?=
 =?utf-8?B?TXNmdkxyczNnY0lsNFZVMjdDNmdmWUxOanFrQitHWmp0cGhvVy9vSG91NmxT?=
 =?utf-8?B?dHNtTUtLYlhSZ2tmTXk5d3RRZWNaQVBjVmgzalRXV0tHeHRNbUl1UDhFMjJU?=
 =?utf-8?B?SjAxOUU0ZG9jcGN0LzNJWS96WllhNWdES2xTTTlMY0FCQkRIUENTZElYRjJV?=
 =?utf-8?B?ZVAyU3l2YWZTcWlEOUJ2RzRhZ1pVbEJ2b29tVFJzUmZ1T2NZWUVwUWdmSmhm?=
 =?utf-8?B?YjJieW1nWnFEUUhNbXVPV1NXU1RaQkJVcWRRUENoMHh5RTkvdHBkczdVZzla?=
 =?utf-8?B?bEVWNjQwV1FZRlh0UzJKaW8xdUtZVkFCVkU0c3FWUWZ5ZVMxVFRjWnVFYmNL?=
 =?utf-8?B?QnNBa0JVL1U5UmljaFJNWGVDeUFvK2NhbU4wVkQxTkdmMGlvcWo3UGk1anVN?=
 =?utf-8?B?b25YOUt2M2dlZUVtRTFQMG5ycXVoOE5uejNQOFN2NkFKN1I1cnNrTVhTMEVQ?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 552a879b-d5bf-4981-178a-08ddd52ed67f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:18:50.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHvSmHNED/USHbYXXsm13bAGjqcf0swc0gT04AqEWxX6yeh9jxv3s5S41RAgTNHcaFBzC8xGzpDGQymSQ8lyDbqVEM23/+ILq+xs/w2K5kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
X-OriginatorOrg: intel.com

Aneesh Kumar K.V (Arm) wrote:
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/iommufd/device.c          | 54 +++++++++++++++++++++++++
>  drivers/iommu/iommufd/iommufd_private.h |  4 ++
>  drivers/iommu/iommufd/main.c            |  3 ++
>  drivers/vfio/pci/vfio_pci_core.c        |  9 ++++-
>  include/linux/iommufd.h                 |  1 +
>  include/uapi/linux/iommufd.h            |  1 +
>  6 files changed, 71 insertions(+), 1 deletion(-)

I think we simply make the rule be something like this:

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 700addee8f62..d84158aacabf 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -138,6 +138,7 @@ config PCI_IDE_STREAM_MAX
 
 config PCI_TSM
 	bool "PCI TSM: Device security protocol support"
+	depends on IO_STRICT_DEVMEM
 	select PCI_IDE
 	select PCI_DOE
 	help

...i.e. the base expectation is there is only ever one owner of
potentially private MMIO space.

