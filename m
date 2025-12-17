Return-Path: <linux-pci+bounces-43223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D8CC8EB2
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04E753163C2D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F334B42C;
	Wed, 17 Dec 2025 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nz4VrB18"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071833986A;
	Wed, 17 Dec 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988828; cv=fail; b=bRmsLGfkW9uVypLmy3GDlCnw8Ua/z1FlGUL+BbZpCovQum6HZqxH681GkM02cpUChSyWx6JO+l9QFVFPslFhhMq+fEqcnQ+JAi//nWNelSma0mIZ9IWzQNnPIp+R3pyui++abJTfH1MhXfLTSaoJ/UeZpE/W3VP/8xVURw0+xzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988828; c=relaxed/simple;
	bh=FrAXrBRqfxBttBOsmHQlKhikIQdsd55uzFNNtcQqCDw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=GuR3ft+5qu44mcFDWTXoedDVuH9WmTcShfh2OP2TpdUFZy0W29UTiYf4EyBaPfxQVZ2B64BKO6pG/Zcw2xU5Weca9QzE0/y5dVLN3r5avZTDxUpEvU5xWRPfoBxAk+iDgwCkQ9fKpLGqa6iGyE1JI1DvkCzv6hKk2GTBtJCtK9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nz4VrB18; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765988826; x=1797524826;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=FrAXrBRqfxBttBOsmHQlKhikIQdsd55uzFNNtcQqCDw=;
  b=Nz4VrB18KKObOUhr/Uhaq/Vp9DtEQLIboztfxLuv/qRgMmig7HphqTdU
   yIl8iXnwNoETtfIRcZ8u6VMlP3I4wQFeDkwVbC5E1m8S3fyDGQPuKrPU7
   Wfl8OKPm0LZDTCGBJHVhYWF5oxzzGoqHt//TX85d1cMseHMGjgncwBx99
   VWkG4WG5ldouBhTlPH2xtO2zcn5Fj2rRTrCNlzbOhXU58XLo9vpwphGtH
   s5k9vg7NF7VQ16gkZRhFSX7OBM/dHSODO0wodJJS5VQIc+2fA22tWQp7u
   br17JebgxIGCJtgxRmlqLvBM98iqF+hEsJf0GoE7NSaAKYMWib+bujowZ
   A==;
X-CSE-ConnectionGUID: QAR4h9nsRBSPgBIe0Y/VGg==
X-CSE-MsgGUID: NOneONJfQne6Rx3LiHQ4Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67125418"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="67125418"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 08:27:05 -0800
X-CSE-ConnectionGUID: ovM1aCxtT0KUcjzmlpV9Hg==
X-CSE-MsgGUID: NUr4or3lTQKn0Eysitgscg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198348135"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 08:27:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 08:27:04 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 08:27:04 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.27)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 08:27:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q607RBL7XFZ2WzWUGgFNPwnDhafnMvz4P0us1/PZymu538a8qKhJUCPn/JkaP3TOD/xYNCe+4AKFFE+6IgAxrGYHC77MpDy2ECxqiekhbEC34v1mfmLBwvZQQ31MxoLnCibAZkLTmVUvn+vzy/GTzwV8rj8S6nlTPM2pT7iWDqv71jlKDfRsvmhiuu/AP5xLqk0i8+1pbmF9o3diJtgnpxUoYpTTsZ/1IlHiisK9XnpKMcum71D0tSXI/bxjfTIqVhWQr1/fBrJbyICP1mX14zW/JL/ncx051lF9m966LMe3RI/IucDHbybfA9DKnR4eQEgbtJCAz1VmnehwyXIE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+L/vPtFuExvwsHxCvjVQVMOzAxFAEQ6gdyfc1lCZEmk=;
 b=Q8GTM6Zd1O8BCtfALfTilPpw898u6C+zVQYr/yxzD5dsc9CsMD2nGO0RNATLE27Yr37DNnW/qC8P/U6Xf6UeWX2kUiUk5iK6U5WJDN65g5G0/0F/QWUx7lltPBD9NreZcyNKBeYIpf9EzBFDlob6Rn48/cLJCNjht+76aecbPTrnm8FYj9VZPPAatXKLLSEHpHHC3wuEVPugVYnRTrCnKS1NdrGEq9A7aZEkE6LSyOTCnQMCNmdQ6AJUBYzcARAhvgUQQPhm3nBvbKc3Au+MqiwA0+zF9c8osWD4wWttKDrN2Kc+l54yfFqnCk2+R1bH0WaSGTJL4Ar3ucFEsATvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7778.namprd11.prod.outlook.com (2603:10b6:930:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 16:27:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:27:01 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 17 Dec 2025 08:27:00 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<alison.schofield@intel.com>, <terry.bowman@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-pci@vger.kernel.org>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alejandro Lucero <alucerop@amd.com>
Message-ID: <6942d9d46e09e_1cee10089@dwillia2-mobl4.notmuch>
In-Reply-To: <20251217155712.000012da@huawei.com>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
 <20251216005616.3090129-7-dan.j.williams@intel.com>
 <20251217155712.000012da@huawei.com>
Subject: Re: [PATCH v2 6/6] cxl/mem: Introduce cxl_memdev_attach for
 CXL-dependent operation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0158.namprd05.prod.outlook.com
 (2603:10b6:a03:339::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0646cb-eb17-4efb-d528-08de3d891b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wk9QcENLRUxzUmkreTdnU0R6NWNOZ1AvNVh3MzZrRUltbFY0U3NjSndaTktj?=
 =?utf-8?B?V2VpanBMTldzL0tkK09CTUNYbnQ2bTFPZ09ITU1hVnl0b3BDYnZRK2JZNlY2?=
 =?utf-8?B?dEMzRWUrVVd1YW5lSGdEVmkyczdIYlU0N0dtcnArT1pSTG42WGtqODFoYVNv?=
 =?utf-8?B?akNaajBmZVl4QXhVRTJkRW5GVXY0QXB5cEhWaHhmMm1GTDlLcEwvVEd5eEk4?=
 =?utf-8?B?OTNQaExZNElvYlNxb1ZzZ3dNcjVFaVRTVHhGVmhmTm1LV3dnNzhEMDdIMklm?=
 =?utf-8?B?SVFqMk9nRWpIaTltRmVlODdUYWdzaXdPOFlKbC9acnJJSExWNTNESHlNc2Na?=
 =?utf-8?B?RHdQUDhLZTI4VkNsYWMvSzVFQzhqKzhyUkJOQWhFdUtST2ZxR2dBSUduS1Y1?=
 =?utf-8?B?RXdIZ0NhRjJScm1EOVZvUExrRXo0MFZSQ1Q5UVdvQTNiVGxxTVgrQVViejNx?=
 =?utf-8?B?ckcwODBUZThvWHJHU0g1NVBwTHRUK21ndmVwYTdLWCtLZFZRNnVzSThDMWdr?=
 =?utf-8?B?Uks4RUJPQjlvcWRTWFdnb1JZNHpTYnY4TktFdHRVV3VRNC9wblV0SmdDdmZl?=
 =?utf-8?B?czVoNU0zZFFodml1ank0MzVpSHVQdDJTbUJyMUcrQlloT0VVN2tFT2I2djZl?=
 =?utf-8?B?dU8zTlVBeGx2RXVtS2tsVFd2NE9oQjNMcnJRUW9rbElJQ0xXY2lFTFkrQ0lH?=
 =?utf-8?B?bngzZFZhNStMZU9DdXFKMjN6TVhJdFJWbnNySXBiSlhWenlES1oyQ2lLZkVE?=
 =?utf-8?B?S1NxcWFxZmd2YXlVa0d4anREQkRORGF0QzJvMU5icDhrbHlWbXUxcWNsczYz?=
 =?utf-8?B?b3VBeHFTOFpPY1lPZDFwUDQ2c3lTRExlNEdvbW5LbnVyQU56enAwNG5acW1G?=
 =?utf-8?B?ZmpSWlczaXYxSEVFMjZtbXZ4U05Vb0VyNVlUNG9GblQ4VHo0T1N1VlRLc0FQ?=
 =?utf-8?B?WFVmQnNBTWFSTjVvSmpFd2FoZmQ5MzVQVHlrRW9QVm1WWDJXNmNsbWYyWkUr?=
 =?utf-8?B?eVc0S3N5ck9CVzZuWVNqdm1zUjdFVDlwamw4NjkvTkZKaFNVYTMvdVZwRjNX?=
 =?utf-8?B?SU5YYndVUmUybWQ0M3VuNHJCZjdia2pacFlQcDlobTJuRjd0eTNKSjMwYmxH?=
 =?utf-8?B?Y2VrOEhXK215VzJSbWt1bTV4Um55MzRVdEpKQm1GYWplY1ZxOXdKZ0ptU2ZS?=
 =?utf-8?B?ZmxiVW41ckRiQ2VSeVVGb21XZWRVMklJSisweHRVMU4yaFFVNFB6dGdXK3I1?=
 =?utf-8?B?V2w4dGZyY01XVFNZbGQyV1BkYlgzdndBQVJVR0NQTWhmRTRCNGlQSzl3d1A3?=
 =?utf-8?B?V0FMWlNaeVFNcXZyM2h3VmZuc09pek43VTMweTJCclBsMWdpR2VIb3NNdzF4?=
 =?utf-8?B?eDU4eUVScEMzQitQN253VzFKTzdRdFRzaEdHUXJQbC9Pc1RMOElaUWc2RC9Q?=
 =?utf-8?B?eFp4ZnhyM2h6VlNkT2FCRzJxYjdzS2o5eS9FQkNhZnNoemM2SVBIWmRvVG5F?=
 =?utf-8?B?bFFNWEoydWp3aS9zWDROWVRUc1g4R2xwMStEdWpZN3ZscnUxbTV6dWJjOHFO?=
 =?utf-8?B?K0liNDlmU3VBemFMM25rcHEzcXFBWXFTZlpuY09DRHpDKzFnWjFQbWVOcWpu?=
 =?utf-8?B?Uy8zNE1YMlZVZmNKdXlhQUJscUJyRmpONkNvd3VJZk5QL3FHRnlabjRNblVa?=
 =?utf-8?B?VFc2RXZEY09XcVFudEw1Q29vRFUyVlVLdVNsVlZ3MjRYMDRmaVhjQVpjNy9E?=
 =?utf-8?B?RkpuamhBRFBHSDJSdW4wRTRxeEhON3dpc3E5ZW0zV2ZLSHo5b2gwd1QydkNR?=
 =?utf-8?B?VHVySWh1Q0FWdlluRDZTN1V0R3hlUllyL3RzdHI0czRVOU5SYjA5aWxIMW5m?=
 =?utf-8?B?QUx5UVQyc2pwZFFyVFAwQVhPUDBjRFg3WHJna2YxRWFvVkhPTjN2S3NDODhC?=
 =?utf-8?Q?3VpjVvebjnwir+ltxoR3ATfYldr1nBva?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVlPVEd5RFpoU3owNkpac0hKaHk1L2J0Y3ZDOXZLOUE0aWgwN2VvbjZmZXBZ?=
 =?utf-8?B?TzRxMzdJOS9qdlpoVnFRUnJqN3U2WDhDbVRhQzJuTHZlOFN6QlZhLy9ESmhh?=
 =?utf-8?B?Mi9neGE1ZkpyQ2x1aWd6WnlIQWVzMkJTQ1l4cSsvYW9ORVJYaTNyMTZ1cTFw?=
 =?utf-8?B?MkVIQno2Y1lHb3BPcVhYc0YxbXZQTWhZVHM2bzhUS003dE5seHB4ODFFa2lU?=
 =?utf-8?B?Zjl5eVQ0ZHpvaGtVK3JjM1RtVkduSXBPeVVRUExKSWZjMjV4WGlRK2RuRk9C?=
 =?utf-8?B?cnVFWkRRTUx6QkJoRXdzZzVqWXJZRkU5YWNoK3dZRkk2bFVncWNkWElPaW5x?=
 =?utf-8?B?QlhGaXhXSzZOSTJsUUcyTkVZamVMS0h4am11VTMyUnpBNm1Wb0k1UlFwZFNz?=
 =?utf-8?B?cERFSFZGQWEwTlRSenFzZGlmNTBSc05NaGpzQ25pRkpVbWtRanVtOWNLNnBF?=
 =?utf-8?B?aDNkVVQwT1dBeWkxNTk1RlpoRVpTbE0wV2VaeHBUNW55ZzZ1TzQ2dTQ5allC?=
 =?utf-8?B?Z3pqQlh3WnRRbkxLOU9LSXptcmZhcHVJRDhGQUdLR3RwR1BUSS9KZ3UxaElJ?=
 =?utf-8?B?enFGS2JvOUt0UDBNWWI3WDh5MGF3aUVOdWpHTXpBNGwwWTVQdURQQ2k4dlZK?=
 =?utf-8?B?L1BPbTNLeFNwRG5YUmQ3YXRXcUtWaWluUFRIajgycFRtSFBVcEg5UFRkZXRj?=
 =?utf-8?B?aXc0S0VOMjRtRStZcytKNFhsTEsyWDVQRG9kRkRqNWtwRkYvUGVYNTRzNDhl?=
 =?utf-8?B?RzVIaTUwQnNOejJQU29RKzFIbUM4cTJ5OENMekRqNEozYVlybVRVU01yWGh1?=
 =?utf-8?B?MTZmbXk5a0VvMVZzNitCVjVqbFZMc2RWSEM2V0duN1ZQRGlGODlEUVg3VU42?=
 =?utf-8?B?d1Uxb0hBM0lKOHpFYXQ3Vnl1QWM4T2VGeWx3YnEvYXo1d3htSGVMbTFqYlRO?=
 =?utf-8?B?T0Z0OThxRHc1dDJURXdRWGtOR2szdzljbytUMXJZOWV6eGw1bjFONVZySG5l?=
 =?utf-8?B?Zm16dllnY3RIVW1WVzVjclBCTFU4ekpNVFhvZVVDY3kvbThDVHU0N21mdTNE?=
 =?utf-8?B?cWFhMU9qUmhIN3JUcjU4c3B5MFQ4NENMVUw2ZEZ5Z3c0SHhYTjJOOUVDNU1M?=
 =?utf-8?B?aGRTVTNHTk1pTXZSUnpkeCt0SmNBVE9ocjNDZlR6V3hMSXVqQ2wySlpEcEZT?=
 =?utf-8?B?VjRpMmtVYk53TWxKVnF0WTlhak0rMlJNVXIyWFBkS0tvRDA0Y2EyYzJoMS9B?=
 =?utf-8?B?M2RFeU55RDZHUEpHa1dVMlZES2hGQmkrR2QzUmt6eXVhVXlJSHplWGE1NTh4?=
 =?utf-8?B?dExxVXh2K243MWRDcytkNFBBZWRRaStGOXAwUWZWYWlxZWVkSE0wQnlqeFBZ?=
 =?utf-8?B?WGZxcU5GZHdOcklzU0RSMTEzbE9kcnVadmg1cjE5Uk5lUzVpNEhaQSs3Y0tO?=
 =?utf-8?B?Ymk0U1IwTW1RNCtjS2FsdTRYQVJWMlFVSFlZa3ErZm9DN1VBV0d1ajNoVG02?=
 =?utf-8?B?VmswNW5FenlhUVliQnpIaHJSTkRVTy9tekVTMm9rRGo2VnA4dGZBSjZDQlJn?=
 =?utf-8?B?SzQyaE9FdW9DYks1Nm8vOFh5Z2pyUmM3NytaWFFyTTJLSUxqdldWVVpNbjMr?=
 =?utf-8?B?WS9nQ2FDdUhUeS9UVGltQlBiVlZYQ25QMGNiOEpsamdMRjNTR1NCU0R2WU1N?=
 =?utf-8?B?ZkNsRU5RbUxyb1J6SVBla2FRUjVnR3R5b2dSZDRVL24zNGQycFd4cUNJeUxR?=
 =?utf-8?B?VkJoY29FdGFmL2U2d05KeGlTL0NDdnZNOWNCWC95Sk82ZkRFYlJ6UXgrcGNN?=
 =?utf-8?B?ZW0yUG5ORlpxK0NNaFY2bldaM05zOElxUUUwSmRad3QrcHdQUFE5eWhza1Vi?=
 =?utf-8?B?QXFRdDI5aXRYcTN0R2pEVkl2TDVjMjRvN2N4bnJlRnZ6eU5ucFNOYjVWREZw?=
 =?utf-8?B?REFMUzdPb3pDMEppMDBZWmtPaHBTSTdwUWc2R3VNMDlabVVDbk9zejhmd3oz?=
 =?utf-8?B?aXljbmxhSlJOd3BqL29lZUtwMm9YUUpnRWlmTXR0TnhBdjNYRGVwM0ttQnN2?=
 =?utf-8?B?WmtuSWN3QW9pYUNlNitWemZSK0ZhVktSbXJKc296d0IycW5IUGlaaGRNMkRO?=
 =?utf-8?B?UW05QjJkbXg3N1V1WkxlN0dJR3dKYmluWWlMbnV6Z2lzaWVtT24zSThLUmY1?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0646cb-eb17-4efb-d528-08de3d891b93
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:27:01.8453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28lKmE1P5LnomlpdxwSO4313Dj1zlH42wyiMnlhMnrdYowvd0u8VsGT+Qdu139LaYN6Z3mHh8k/PuJD0OWKvnSSOYBhVUNSZboTBd/VbQbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7778
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 15 Dec 2025 16:56:16 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>=20
> > Unlike the cxl_pci class driver that opportunistically enables memory
> > expansion with no other dependent functionality, CXL accelerator driver=
s
> > have distinct PCIe-only and CXL-enhanced operation states. If CXL is
> > available some additional coherent memory/cache operations can be enabl=
ed,
> > otherwise traditional DMA+MMIO over PCIe/CXL.io is a fallback.
> >=20
> > Allow for a driver to pass a routine to be called in cxl_mem_probe()
> > context. This ability is inspired by and mirrors the semantics of
> > faux_device_create(). It allows for the caller to run CXL-topology
> > attach-dependent logic on behalf of the caller.
>=20
> This seems confusing.=20

Is faux_device_create() confusing?

> The caller is running logic for the caller?  It can do that whenever
> it likes!  One of those is presumably callee

No, it cannot execute CXL topology attach dependendent functionality in
the device's initial probe context synchronous with the device-attach
event "whenever it likes".

> > The probe callback runs after the port topology is successfully attache=
d
> > for the given memdev.
> >=20
> > Additionally the presence of @cxlmd->attach indicates that the accelera=
tor
> > driver be detached when CXL operation ends. This conceptually makes a C=
XL
> > link loss event mirror a PCIe link loss event which results in triggeri=
ng
> > the ->remove() callback of affected devices+drivers. A driver can re-at=
tach
> > to recover back to PCIe-only operation. Live recovery, i.e. without a
> > ->remove()/->probe() cycle, is left as a future consideration. =20
> >=20
> > Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com> (=E2=9C=93 DKIM/intel.co=
m)
>=20
> Have we started adding DKIM stuff to tags?

No, just a copy/paste typo that I did not catch.

> > Tested-by: Alejandro Lucero <alucerop@amd.com> (=E2=9C=93 DKIM/amd.com)
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> One trivial thing on function naming inline.  Either way.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>=20
> To me this looks good to start building the other stuff on top of.
> Thanks for unblocking this stuff (hopefully)
>=20
> Jonathan
>=20
> > ---
> >  drivers/cxl/cxlmem.h         | 12 ++++++++++--
> >  drivers/cxl/core/memdev.c    | 33 +++++++++++++++++++++++++++++----
> >  drivers/cxl/mem.c            | 20 ++++++++++++++++----
> >  drivers/cxl/pci.c            |  2 +-
> >  tools/testing/cxl/test/mem.c |  2 +-
> >  5 files changed, 57 insertions(+), 12 deletions(-)
>=20
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 63da2bd4436e..3ab4cd8f19ed 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
>=20
>=20
> > @@ -1081,6 +1093,18 @@ static struct cxl_memdev *cxl_memdev_autoremove(=
struct cxl_memdev *cxlmd)
> >  {
> >  	int rc;
> > =20
> > +	/*
>=20
> The general approach is fine but is the function name appropriate for thi=
s
> new stuff?  Naturally I'm not suggesting the bikeshed should be any parti=
cular
> alternative color just maybe not the current blue.

The _autoremove() verb appears multiple times in the subsystem, not sure
why it is raising bikeshed concerns now. Please send a new proposal if
"autoremove" is not jibing.=

