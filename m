Return-Path: <linux-pci+bounces-40436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4445BC384CB
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 00:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D4804F8972
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 23:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0039A221FB6;
	Wed,  5 Nov 2025 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmKFVYpY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08752E7F25
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383852; cv=fail; b=AabSdkFe0E/np3eWRyFqdKyK8jVFXn6eSEKXW9hwzmMJG8XrUcCO2RD95dxONFEyp2UYqtRXwJ8Ipqrf7ItOrUP+JVQ0zL1I78SThlJXbXbOPNBkHnp4DgZ2S0mk/J/eVFDOo7B7hvGPTij36xHKVEJNgd+utK7bjjPEpOnQ4IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383852; c=relaxed/simple;
	bh=yWC3QCNA6yJuKgFDc/4BIrmLM3UCZjjPF6A0LDrh5zA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=CdB6iGVcQy4wZUI2fMTBmYf+DraE/iMYstYbdE9fBqWNc7Zt23N1JmdwD7FR/KChRksq2TLwmF1/jNqjBitd0vD2te713Egl0zeC59S05S5vgbKfHupIcL5rJwwSgk3OYtwgKMOvTBYhJ7cMYD85BbCf6dEn64H2RhAzKYaIKZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmKFVYpY; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762383852; x=1793919852;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=yWC3QCNA6yJuKgFDc/4BIrmLM3UCZjjPF6A0LDrh5zA=;
  b=cmKFVYpYbowg0xY0/TosGs/O9xwEHxPB9OR9I0Zd1mZ4Vw35rLnVf+EA
   nX7QDBkrBWkMoelmwgQT6gxFAYrLlACdA8/NJ3cQfGJg1AEDE5TZykvIc
   NHLJ0RowU+V2F6WxmU8msGZEzUYvJutACsw996pYfOyr+U4DdVOm46pnA
   HBRWN8IdyDcd2FVkov3POp+ikdsL9OiYvsIJsotwj5Zt7uy4Ny8tYPsFd
   B0liJoOoaS7Rs3YWxhJslDtWWY6WWQ8dJ5hDJzrQbgIxIwmEHahl9r4X6
   AXZy5JablCMUbDz3/OJH4sBbqujVozhM+X6fAbNizr8Akx7yVG2wmfi01
   g==;
X-CSE-ConnectionGUID: PWlmTS9BQkypqKaJfpKdXg==
X-CSE-MsgGUID: VwgYFPuAQDK7l+Y7eR+VXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64438240"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64438240"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:04:11 -0800
X-CSE-ConnectionGUID: 3DJb83Y5Rn+PtLpfN/H2kw==
X-CSE-MsgGUID: nH9JvfaRThmFr+KrCfhf7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="188311344"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:04:10 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 15:04:09 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 15:04:09 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.38)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 15:04:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LW26STW3ym3EAqUKNppYbLnqOJQHxdXSGrHqX2ghdeOzQuHI1tUvveiEnI+iVWTHJ9eVx27oSKpAQ4Rwmm+p6sbtHJfpsKKYUV08eqOpDcFPFKss6SqsiWPp/CUK79HzRekvY02u15EJldgUX+Wx6hzGTqDimQLu1dGZmKCdiphiTv91d3Ca56txCGTSmi3CssIo94N9UAcPFjX/XdNIu9XqQt33tTLSv6sMLBkr3HGtFnTjWV1TCc/gr28s2BDX+jvWNJgMtBTiSjIRzmL09Hgn8AM9l2k2SMsL63dz7umwiwor67ycVf/nnamnWCENwjbxJ+7fjEEB8qTIusNOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbWD/wPiF5rJ20vbEsO5QBClla4RF9imkP7V9zdD7ns=;
 b=FrAEP+exGRCMat6MPOGwyZ+/OTYAQfLGj8NklrnimJbrbnNGgXs4ccIjK1sUgfKmSEGjjVvvsROSgJKr586/zojvb3PZ8lObAdP/3863Lg4TYF4mnCw/4ySdefRCIdV2FkDzNo7BDIE401jx95NsibK55kKg0m8d/hO5VwkbISzbKR9C79B7XBym2/Prp1voyP2JEIkfiR2b0SlH8Gq4aBLb4/0O3JtZqg/ZD4bCx3UV2cHSEOoh0Z7v7gUQvVO99s3Vg8w+JvrWjr25krIqJhgZiwnGW7uH5dQSVUpa1k/ArvyLnigjMFvugJur3fcd4vskQ2XoWjYUYQ4GMaELJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6956.namprd11.prod.outlook.com (2603:10b6:510:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 23:04:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 23:04:07 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 5 Nov 2025 15:04:05 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>,
	<aik@amd.com>, Arto Merilainen <amerilainen@nvidia.com>
Message-ID: <690bd7e585c47_74f76100f@dwillia2-mobl4.notmuch>
In-Reply-To: <20251105095832.00000871@huawei.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
 <20251105040055.2832866-3-dan.j.williams@intel.com>
 <20251105095832.00000871@huawei.com>
Subject: Re: [PATCH 2/6] PCI/IDE: Add Address Association Register setup for
 downstream MMIO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0366.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c90a05-4a1e-4541-7912-08de1cbf9f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|3122999009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0dhTDNnS1pNbHJ6WUg5bUlUOXk4WmRyQ2d5SERVTEN1YXFXVGNuTVdaK0Qv?=
 =?utf-8?B?elBkTWQrUm9DbnAxUlhzbHlEL0xYeWJrdDZJQ1VDMnpkbWhKZlY5Q21ET2JN?=
 =?utf-8?B?eThjdktLSUZlZllaYXpVSmduQm5LVkQ5SkthYWZvWHdrenV0WUx2NUlpZTM3?=
 =?utf-8?B?TUZSUlVqTStWRUp4NENVZ0RaYTJxa2xBM1dQbzQva2daYllxUG1WY0VOdTl3?=
 =?utf-8?B?Y2lYb0YyM0liL0hkbkFMQzZwWlZ2dHZNTStCRkdxcmJQRjBsL3pYM2Z6cTcr?=
 =?utf-8?B?cGU4TTlUQndGWlRIdjVkQmRWSk1ldkV3M3RYeHhoMHB0UVJKZnNTL2hiM3FL?=
 =?utf-8?B?cWRRUG9TRHIwNnUydGxYSk4vdVVVdnFCd3o5MnBJYk1vbGw5QXYzbVJEcStX?=
 =?utf-8?B?US9iL2toVmtENW5RZmdJdG1zK3RxQzVmT2dmbHhyblYzTVF4WFljRzZQNm5D?=
 =?utf-8?B?c2xZTGpqR1dtOWVZUk5Hd3JEc09DSXBLOWxsajk4ZUpjWWQvMkUxNms2dTFx?=
 =?utf-8?B?UjJWOVBvcDVhWnhZUUxCZGszTUtwTGVGYXJNdDZsVnlNdWt0eUR4YzVIbTJa?=
 =?utf-8?B?d2tvYWZoV3l2YUpDYU8ySzZtRDZDMjFZdVduV0Z1MFU2R0p2MytXejRTK3po?=
 =?utf-8?B?Vko2dHFuTVJWWllzY2wvTmUwRlpjOUl6ci9RRlNCL0JBTGlEVzhqRFdKS00r?=
 =?utf-8?B?dE9rbmVDWUd1UW56bUFkUTF2RHhJbWZHcnk4VFJ2OHppc2lzL0s0VW5CV2Yr?=
 =?utf-8?B?dmxHOGNWbVRkNlVtUFpzbE9sRVpGbmpNc1VNK1VkK0paVmJoTU5MS1FiY2dU?=
 =?utf-8?B?OGZvcDFZKzRmYUtZVTNrYkgxNW92bDFTL3dpcjIyUnl4UUxHeUZ5S053OGQ4?=
 =?utf-8?B?UndaT0NZVmNVbnNrV1oyb1k4SDM3MktsRGJNOHc4NDlqUlhnRDE3aGMzTy9T?=
 =?utf-8?B?enJSd0ZHWThSWnlybnZUdEdNb1Q4dHEzOGJsTkxFVmZuWDQ1UlNuOENWeGJh?=
 =?utf-8?B?czczWDlZS2d6SHk3QjVtTC9MZnFlcVdQR3JhSGF1MG9PWFQ4c1QyWllUT3Rj?=
 =?utf-8?B?eWNCZ0JlM1ZHUVkyUUFEUlJIYmRzNHFiSXFmS3ZVbzIva0xld3hJbFBRbFpB?=
 =?utf-8?B?NjdrT2NOZUwxcGYrSUg0V0xXTmpvWGNHWXhpZ0xaSWZxR2tiVGxmajBZUTBn?=
 =?utf-8?B?bTlJZmVCYzdSK1ZBL0tpSTJhNnJhd1JwTmpxTjBHZFBwL3B1eEtzTno4MzBR?=
 =?utf-8?B?MFhUWExVbSsrbHV4OERmQXdpVXphZnZzYStyK2NwcVJSbllkblBQRkRxMEpx?=
 =?utf-8?B?cFFSdHM3KzNoZHh3QnpoSGVXZUpNL2g4R3Y1U1VuWXZIb1JWbDBzSEJEVlBp?=
 =?utf-8?B?dG5wRVY4OVRSOG1VNXMvUmoycGlES1plQm44K1RTUlQwVkdUZnRHTXplRU5s?=
 =?utf-8?B?NDZncjYybjR2THg3dTV1ZWVNR0N1Z2VWWFY5R2wzLzV5d1l5MGd2aTNUcHdJ?=
 =?utf-8?B?WE9talFpdEVKREZLMlR4ZmxPa0dxS3cwa3BSQS9xOWs4aER5VXhqbGtuTWgz?=
 =?utf-8?B?b0FXbjN1SEJ0ZGNkcnVUWkpjVXZPN1lwTWdXYk5nY1ZuMHJsSlY0anZtM3JG?=
 =?utf-8?B?QnJ2eS85WkNGaStFYmgrdUZpenhKRXhZVnJiVWpBRGlHUEdSaFYxYXFqK1ZH?=
 =?utf-8?B?MXJnUFFST1RsRjJqNE83N0FTc0tBVU83WUFSVXVHQis5cU9sT2xRMDFpK1l4?=
 =?utf-8?B?czZzNUJaUkwxT3ZKYXlya2dIajhyZ2wydW44dEZVcEZrcEVMQSttY1UzZnp0?=
 =?utf-8?B?Q3JDdUcvMzZ3UGtlNDRuRE5QaHBzSXpiMzZpbllKWVdTa2ZOb2FxczR6WnpB?=
 =?utf-8?B?Rk9SQXNRSFE2c1NmNnM5MGIzYkpTSmVvL2VuRWRWQTdJb0ZmSVVZTzEzS1RT?=
 =?utf-8?Q?cjR8LQaB+FCOXVegkl44IHcCj2j7Bjzv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3122999009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmhKQXhDL2hrcDVqV0NpM255Ri9TYVFrMEw2TG92T25EeU9ZNzYyc1ZOdHg5?=
 =?utf-8?B?a1B3cXhaWENyb2xxeTd4bWRyU1lYcnBXVTRhVTM3RWlhNnRqbFV0b0ZVb3BU?=
 =?utf-8?B?UWtYaCtqcHdPOHZ3R3U1TWtxL1N2Mk5SNTY4VjBpYmcyeTR5NERMVzlsODJk?=
 =?utf-8?B?RXpkbDhDVFozdWlyekhKNGQyWGpyaWR5L1NMdE92Zk1TMlJFakprWXp3S012?=
 =?utf-8?B?R1RLT2VOUmphWWd5aFJZUEVRVDIwWU1kTUtkb3AxQXdaR2J5YmlyTjc4WENp?=
 =?utf-8?B?YVkyU0NTVXJNanBhYndTN2hURWM3Mi9DUmlVYzF2Zy9NTTE3Sm80b3UyMlZu?=
 =?utf-8?B?anpUWnp0N0VvaVc0dDd4anNId2xuV1FVU1R0QlVsZ1lCank3WEdydnNoRFhN?=
 =?utf-8?B?RW9DUCtvdDBPdUZsbUxualNCWkhUMnBGVnpCaWlJYW03TENmRk5kVXcrSDcr?=
 =?utf-8?B?a1VKS3NhSEcyZ2FwdXF4dWRsZnp6eXF3bnEveUZtRFVzMWgrSzk4WldoTmhJ?=
 =?utf-8?B?RkhzUnNPRTd5MTBFWHZydVdVL3o2MHJpSUdnbnpDbk9hQSs4eituNEttZ1B1?=
 =?utf-8?B?b2xwUCs3dWV4UHFFL3JRM2dKeDczaHFxQjVpblZwakd6M0JoZW1WRC9ka05Z?=
 =?utf-8?B?eWsyU1hxWGZHRERoSHJSbGxQYjRrMDE5c3JISFN5SmVhTm9MenRFUWsrT3Bx?=
 =?utf-8?B?SXo5d2dlcmliZEFMdkJyYlQyMnpTcnFOd013U0NmT2NpSDVNREUrV3pVaDgr?=
 =?utf-8?B?L3pnNm5mTW9LdVpNUWRGaWNreWs4WFh0Q3MxQ2FIU3RyT2I4V05aNytVczkw?=
 =?utf-8?B?MkVpeUZEY1QyN2plS1RhUGY2eWQ5cStWK0Y0RlBCWTVmT01YYWNZV2hiRW9u?=
 =?utf-8?B?Yll6WDJyMVdaN2N1SktURzVDS0RpTXVxUk5odnJvSXgvWHVJdzd6ajZkdzBu?=
 =?utf-8?B?ZWRtUGFyOEg2MjY2YnF3ZjBhZDlBYmRZZDVXNkk2c3VZTUZkMUtUV0JXbTJv?=
 =?utf-8?B?cjAwNVJKa2R5ZzE4TThhb1ZLcTdtS0I1bkh1SjBOY0RERmZLZVhJU0R6Zm9i?=
 =?utf-8?B?RSt4R0greWxucHQwcWF3bzIxUFNlcnFJclU5ai9naW1FalErcmE4VmdFeVly?=
 =?utf-8?B?VEZRMnN3emZWbFFOSzFqOFJIVHk5eHZSMzl4WHA4Q05KRm5HVy9WM2RjSVcz?=
 =?utf-8?B?aTU4Rnh2K2ZTTlk4MWdXNkZqWERReERBNDVIM2R3aU1qdkFVVXQ2MHREZHBa?=
 =?utf-8?B?Syt6a0ZrOTFXWnhadjNXT29BWUlQV0pJZGxxTVZQL0xadjhsVzdpNTE5N0hB?=
 =?utf-8?B?SGZFMnRHZzAyMm9qN1FYcVczMHYySU9KdlhzMEFNODlCTkFYNWViK2xYeEhF?=
 =?utf-8?B?VjJBWWNrUG1lZFRRK3gwcm8wdlUycEtLQU1teUxhRktUUXR5djkxS1N3TGs0?=
 =?utf-8?B?QkdrSTlnUDc3SWdqelo0Zm0yTW9KQk5PbTBlNlkwNG1PRVpPemxyYThQWUJi?=
 =?utf-8?B?MWl2RkN2ZHBjWi9EQ3k2NHdCNmh2SG9yS3pwdnpPa2llVGF3OWYzbHJBcVl6?=
 =?utf-8?B?NHRpOHl2N25yYmV0ajQway9kVjJwalBGZHQrUEh6YVZ0WXdjTW1Gdzg4b3Yz?=
 =?utf-8?B?bG5zOFhWN1F1cUlxeldTd2treklTODQxZHR6NWY2NDByYzBrdExlaStaOVFH?=
 =?utf-8?B?WU9RbXZ6c2ppUWhVZTBQeHZicm5hTHlGSUp6N1ZjMG9KMnVkRUJmWG5iajFL?=
 =?utf-8?B?LysvazhkWWVpRW9YcjVSUHFsRkk2ZE0rek1Pbm5PQ3lUNTlmaTNmVjJmSW1E?=
 =?utf-8?B?dzdCNDVwcnU0QTBjT3lxaUxNaXczaDl0NEpCRm8veDYveDBLNkxGRkx2YW9Z?=
 =?utf-8?B?TUcrbUN5WGxmSFdYL2Q3b2lxTlRPWjVqd3pmaEhwK1EyU2pwcm9kalBkMTc5?=
 =?utf-8?B?VGhMbWxxazlZdVZlMnFNTXFsTWZpZVB3aE1lTTIzTUVDV3lvUEVpODcxM2Fw?=
 =?utf-8?B?clZwUC9yZzhlSExyRTFaUHVUYlpndWtPUjNPd1JNMkxxR3I1N2taL0h1RElI?=
 =?utf-8?B?ODhDMlk1WldaR3VaUGdIcHNPQnYxRFJXR2FFNVVwSGIwb3M1b2VDdGdFQVdk?=
 =?utf-8?B?K1BBZGY0aVI4SitxeTFpWGVNOWVVbHVlalMrRXpQU1RFM05UNXBSUWJlNk9B?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c90a05-4a1e-4541-7912-08de1cbf9f38
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 23:04:07.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DYcezDUBQS+SMyzeuK5p3H5x8doFQ5K/AfWVmcO3n8XM5JB6Ide4b+PZPrrNlz3AFeMz7fJkdf9Gnh+ZJbv0hWTk0N7v/5hbrTv4KwdDmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6956
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue,  4 Nov 2025 20:00:51 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > 
> > The address ranges for downstream Address Association Registers need to
> > cover memory addresses for all functions (PFs/VFs/downstream devices)
> > managed by a Device Security Manager (DSM). The proposed solution is get
> > the memory (32-bit only) range and prefetchable-memory (64-bit capable)
> > range from the immediate ancestor downstream port (either the direct-attach
> > RP or deepest switch port when switch attached).
> > 
> > Similar to RID association, address associations will be set by default if
> > hardware sets 'Number of Address Association Register Blocks' in the
> > 'Selective IDE Stream Capability Register' to a non-zero value. TSM drivers
> > can opt-out of the settings by zero'ing out unwanted / unsupported address
> > ranges. E.g. TDX Connect only supports prefetachable (64-bit capable)
> > memory ranges for the Address Association setting.
> > 
> > If the immediate downstream port provides both a memory range and
> > prefetchable-memory range, but the IDE partner port only provides 1 Address
> > Association Register block then the TSM driver can pick which range to
> > associate, or let the PCI core prioritize memory.
> > 
> > Note, the Address Association Register setup for upstream requests is still
> > uncertain so is not included.
> > 
> > Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > Co-developed-by: Arto Merilainen <amerilainen@nvidia.com>
> > Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  include/linux/pci-ide.h |  27 ++++++++++
> >  include/linux/pci.h     |   5 ++
> >  drivers/pci/ide.c       | 115 ++++++++++++++++++++++++++++++++++++----
> >  3 files changed, 138 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> > index d0f10f3c89fc..55283c8490e4 100644
> > --- a/include/linux/pci-ide.h
> > +++ b/include/linux/pci-ide.h
> > @@ -28,6 +28,9 @@ enum pci_ide_partner_select {
> >   * @rid_start: Partner Port Requester ID range start
> >   * @rid_end: Partner Port Requester ID range end
> >   * @stream_index: Selective IDE Stream Register Block selection
> > + * @mem_assoc: PCI bus memory address association for targeting peer partner
> 
> The text above about TDX only support prefetchable to me suggestions this
> is optional so should be marked so like pref_assoc?

Maybe... I think I was more considering the fact that PCI compliant
devices always have a 32-bit MMIO range. Given both are optional it
might be better to detail that in the Description section:

diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index 40f0be185120..37a1ad9501b0 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -29,13 +29,18 @@ enum pci_ide_partner_select {
  * @rid_end: Partner Port Requester ID range end
  * @stream_index: Selective IDE Stream Register Block selection
  * @mem_assoc: PCI bus memory address association for targeting peer partner
- * @pref_assoc: (optional) PCI bus prefetchable memory address association for
+ * @pref_assoc: PCI bus prefetchable memory address association for
  *		targeting peer partner
  * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
  *		    address and RID association registers
  * @setup: flag to track whether to run pci_ide_stream_teardown() for this
  *	   partner slot
  * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
+ *
+ * By default, pci_ide_stream_alloc() initializes @mem_assoc and @pref_assoc
+ * with the immediate ancestor downstream port memory ranges (i.e. Type 1
+ * Configuration Space Header values). Caller may zero size ({0, -1}) the range
+ * to drop it from consideration at pci_ide_stream_setup() time.
  */
 struct pci_ide_partner {
 	u16 rid_start;

> 
> > + * @pref_assoc: (optional) PCI bus prefetchable memory address association for
> > + *		targeting peer partner
> >   * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
> >   *		    address and RID association registers
> >   * @setup: flag to track whether to run pci_ide_stream_teardown() for this
> > @@ -38,11 +41,35 @@ struct pci_ide_partner {
> >  	u16 rid_start;
> >  	u16 rid_end;
> >  	u8 stream_index;
> > +	struct pci_bus_region mem_assoc;
> > +	struct pci_bus_region pref_assoc;
> >  	unsigned int default_stream:1;
> >  	unsigned int setup:1;
> >  	unsigned int enable:1;
> >  };
> 
> 
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > index da5b1acccbb4..d7fc741f3a26 100644
> > --- a/drivers/pci/ide.c
> > +++ b/drivers/pci/ide.c
> 
> 
> > @@ -385,6 +408,61 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
> >  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> >  }
> >  
> > +#define SEL_ADDR1_LOWER GENMASK(31, 20)
> > +#define SEL_ADDR_UPPER GENMASK_ULL(63, 32)
> > +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)			\
> > +	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |		\
> > +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,		\
> > +		    FIELD_GET(SEL_ADDR1_LOWER, (base))) |	\
> > +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,		\
> > +		    FIELD_GET(SEL_ADDR1_LOWER, (limit))))
> 
> Whilst complex, if it is only going to get one use, I'd just put the
> complexity inline.  If it's getting lots of use in later patches then
> fair enough having this macro.

Not sure if that buys much just to move this down a few lines into
mem_assoc_to_regs().

> > +static void mem_assoc_to_regs(struct pci_bus_region *region,
> > +			      struct pci_ide_regs *regs, int idx)
> > +{
> > +	regs->addr[idx].assoc1 =
> > +		PREP_PCI_IDE_SEL_ADDR1(region->start, region->end);
> > +	regs->addr[idx].assoc2 = FIELD_GET(SEL_ADDR_UPPER, region->end);
> > +	regs->addr[idx].assoc3 = FIELD_GET(SEL_ADDR_UPPER, region->start);
> > +}
> 
> >  /**
> >   * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
> >   * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> > @@ -398,22 +476,34 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
> >  void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> >  {
> >  	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> > +	struct pci_ide_regs regs;
> >  	int pos;
> > -	u32 val;
> >  
> >  	if (!settings)
> >  		return;
> >  
> > +	pci_ide_stream_to_regs(pdev, ide, &regs);
> 
> If I were being super fussy, I'd suggest doing the factor out to a structure
> + helper as a precursor patch then just add the new stuff here.
> meh. I'm not that bothered but it would slightly simply review.
> 
> I'm not entirely convinced by the helper as a readability improvement
> but don't hate it.

Note that the helper has an ulterior motive. TDX Connect wants to have a
copy of the desired register settings to pass to a TSM ABI for root port
setup. That will become clearer / documented later when this helper gets
an export.

