Return-Path: <linux-pci+bounces-41702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4979CC71757
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 00:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 5236D24029
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7430ACF5;
	Wed, 19 Nov 2025 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4ZhpQEh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F430C366;
	Wed, 19 Nov 2025 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763595622; cv=fail; b=FVgMADzrAjJ/XaJCIIMa8ibjjv/cz3e05f4Kv5NsLHsvWU1Fx6EEd6Nv7LnU80S9Csnb4+jE4+Y+hGWmRZt09XjBjGSDWRqNlaVolhZ14rITkxR/OrER93I3SgEBILTguqEXTmsSCDBUcvHOiEHFnI6ySdFNaEBBa4gvukvArRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763595622; c=relaxed/simple;
	bh=GSwWeeMuz3QtQPrSRCoLgA/wuHF8L34VUAFSv+QLDZQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fw1scZQFensUUi/SjUHhfJWds4cCOnMwhpnHqvvMPhljjMfAX5iYfCz90xitH2jB7GVDA6HkCPtUcXC1K6EyXOvOs0LwSLiL0E5P9/QG7wvMgHryuPYRSr4EU5DItpjBZlgAGUPY6XdAZlne9AU0jm3Cy3DAv7CyzR8B/uNbJwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4ZhpQEh; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763595621; x=1795131621;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=GSwWeeMuz3QtQPrSRCoLgA/wuHF8L34VUAFSv+QLDZQ=;
  b=F4ZhpQEhqZMDGXun4iLPQbGCsgfEX65dZIr0Hw9dLbgYuEeX7fORdUuN
   I12ErP3NnkE33n+RKYZwo49+kzTdS4u0pXOJ74l7IcgbVJoxi4ouI4BRD
   dyUeFN3HRa46fI0Oe2aHUOhfxoIjZ2+KKEXkqB2zZoQqCIZuJJW7gEaNk
   EuJmXVuD9jRhonw/Yz0L9ws/tXfVVRDi1PgBjJcSPxOT8hTlVNVrC5+52
   GUfCwrLD1uY5tCIL3tAGB/MuWCEUEbR2Bn5ftlBc1cFJIDD0ppobcbH1q
   hAgJRHsjwAmvxCTdM+1iBm2AUL/buTVmc1egU9ziIFcIBC1yI4Xvo64ec
   A==;
X-CSE-ConnectionGUID: uFaeiiVfRuCfZXA9myqLNA==
X-CSE-MsgGUID: KecyFLFUT9mB1gu9j1Td4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64659808"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="64659808"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 15:40:20 -0800
X-CSE-ConnectionGUID: 3+/m/4bWR3CPGQFLrWj6QA==
X-CSE-MsgGUID: jWQBJsu7SwS77DPr1ky8bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="191633132"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 15:40:20 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 15:40:19 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 15:40:19 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 15:40:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhweaDBFGySG1erSOQ+jWQMoDG5xo4Rf350+zzh6+wtYWLdnOdkl4KDxdEb9MkH/tuY81IEB26xlmtaNOCLZwOotoOmDuAmmFDUR21O8Ff/5a2GYhmEKin8ZXCq9kpH+uGZWec5WlhtOP0maXNrhcmyCNJChts+1nVL/303AKJnCVPLFCXcjtEZn1lwt64Cah8XtYnIWfmJdm5BJN+wCVhA8BLNvAP5MJ29Hg2/yUre5gL4YIHj+2QiqRPkJqfk21K6BrF4ugpf+GvAC8Z/cHDyp5BRwVF92PkFRDTU1XhpdXhnherTmtT/8bEFhkGJpiaZ9xkycFu/kNOtU6sk6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxLO8qp7hFGoNhHEWal/7hOupmxGDZz2HMe9v87IbXk=;
 b=PtrEMySA5ZUOcLAAfc4qSyP6XaC7hRCGZtpWDkPstrUlVRrREmVxV4iXJyIq16GrRtmH6NrA2OI0UuYXMck+ebLIPPof3FWEInptoQEiyZvMb5Yj5xbfX7KRsdbViQVvDz9R/O0uh5lmkYquhOo3rvsetQTwf4UlzDzfMizDa+ZxmNwJgU/WTiPBYZoucItUi/kTAqamkavbxt/xuzubgCKK73hgwt/Aji0eYkQzYSLaYv6fxsKeVXwhzne0VkJQZDx3crWmW7Vo0bCmRs9AxiKrrhVb04ICwRB5K4J/Ahy/pwWoN52AuT0S0nIKLsx8l8lC82v9qqX4X8eIEOrBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 23:40:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 23:40:12 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 19 Nov 2025 15:40:09 -0800
To: "Bowman, Terry" <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <691e5559eb0c7_1aaf4100c3@dwillia2-mobl4.notmuch>
In-Reply-To: <b104b695-a966-43e1-b4fa-1c8cce6d65e7@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-13-terry.bowman@amd.com>
 <691e3542c1b2a_1a37510046@dwillia2-mobl4.notmuch>
 <b104b695-a966-43e1-b4fa-1c8cce6d65e7@amd.com>
Subject: Re: [RESEND v13 12/25] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:a03:338::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: eed9b30a-e88e-4010-9d3d-08de27c4fb54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGFPZWRFRGhXdEpDUWNKRHhvVnd1S2tvNU1FajY4WDVTVERRdjMweXJTc3JC?=
 =?utf-8?B?WkZCZmZsb0Ftdklxem5pbEFmZVIwQTEreENDTFlVdmc3QU5IaVQvSFcwZ2VJ?=
 =?utf-8?B?YW8vdTlQV1VMSUtKOWpTWGlRT0FDdkEvcXR6T1czMGp3ZzB3cmNjdHo5cG1p?=
 =?utf-8?B?VHp2akdpMlptQUd2TVNsT0JDSjR5aEZjM3oxaXpPblZMbURGa1RkOG51WXFk?=
 =?utf-8?B?Ni9MUEQ1SnFzd2U3aVErSUtMZVVIaHcyNXBPd0tDYmUrOGFJRThEZFlGcVdj?=
 =?utf-8?B?VjhMc1h5YTdRQ2VqSHR5UHV6SDlqcHJZZHVIWWh1cUJGb0FBR2VnQTRGMHJW?=
 =?utf-8?B?d3dUSS9CVGdQKzhXVE9odGZNdDQ4MktybU9MTkk2ak9VQjBjZSsvRjU5d3Bq?=
 =?utf-8?B?cnYweGxDNFJQWm5RZEFZWjZaaU9QWURhWXZkOWR3d1paRVRNd2FhV1Vya3Ex?=
 =?utf-8?B?TVd3Vkp1Ynd0ZUhKMU0wSFpVMGtzT3NhUDFlWVFZN0tYNW9ZK0JMeVZNcnJq?=
 =?utf-8?B?dDhQNXRSNXB1NjRBbFNKU2RyZTR1azgzUUd2ZHR0NFhPZUE0Uk1zSDE3RWxN?=
 =?utf-8?B?dGYwRVllLzREb1Z2TDh3dm05SVR2eENCQW00M0U3UVNvQkNtZ1dOSmVoVG5N?=
 =?utf-8?B?WVR5L3Bjdk5vUnhRVGpjaHd3ZjdGT1g2Qm9tSXBLaDdkUEp3emFMT09aVGFo?=
 =?utf-8?B?OGQ2WElGaXpqTlZ3RUtFUUhxVml1YXhjTnBOYmFrYVdMMnJ1aUp3cmQxN0Jl?=
 =?utf-8?B?aklSZ1VOM1o2YnhsZHU4SStyVmhidWhkSlpwc1RoNFVQL2psc1BoVE40Sjdj?=
 =?utf-8?B?ZG9NWVlHaSsyVSt3blVvSXlheFFseGdhY25YeG42TDZaTlh5YlhNU1pCeGQz?=
 =?utf-8?B?VHdxV3VUN0FrdStZZ1FXUmFRUCs5R1NZTHRTdnRxUXgva2pFZFAvc0JNazdJ?=
 =?utf-8?B?akdqT2pWNnk3QU0vN2JkNWdGVytubEhtTklBaHVpV2xaL0RyazNYWWQyMDZR?=
 =?utf-8?B?NldUNnlOdjg4a1NGb3VGT3BNNnBVUnduQ2oySnRUNDJyQ1dTZmZ1djkrakxp?=
 =?utf-8?B?Y3dFS3kxamFEbUljM0d3MEZJbmY2R0txK2o4MzZ1czFNbWVteE5TWUpjcVBR?=
 =?utf-8?B?bHE1cGtlTnIxVFlSMWFDQngvSW5lMm8zK0IrNHg5NDBKWWJrTWQwZzY5T1l3?=
 =?utf-8?B?VTdzY0ZIYTBHQ2pJcE5nVTZBdDZDR2dyV3VzNWNmb1AzU01PSHdxek94aWZv?=
 =?utf-8?B?R0JiT1FteDBCSUVLb2J1ZDNla3I5c3dJRUY3dGNDNnlJTllRcVZKeDN6SGFQ?=
 =?utf-8?B?MzlLT215YUI1RG9NUUpUT2hJZnR3NFZLU08zM1paK3J6TTZaeHpTTDh6ZXpr?=
 =?utf-8?B?ZWk4VzYxZzZ3TWRwM2daQmRCRXU5MUtZSHNwRTYrR3oyYnJjd3RGcVNiSThR?=
 =?utf-8?B?YUk3S2M0WlkzUE01RkFaU2lMWUxHR3Fud1pFaFhpRmRORk51ZXVmd0MvMmZK?=
 =?utf-8?B?NXhobHE1YkNyWE9ub2NjTTFCcy82TStnQkk3Z0dSSEdJdUdJMHFCdmx5ZjJt?=
 =?utf-8?B?blo4RUVOdFRFSWVIY1dIMnlnTUhkUitGcTJoRVJhRHBlYmlEQjV6YmtldUht?=
 =?utf-8?B?NXF1eG5OT09DS0lHYzJNYWdZVC9JN2xsWk5RUHdEMFg5UVdPdEIybkJyNnNq?=
 =?utf-8?B?dFU0b3VGbEJUbEZhVjlSUndUajVwcGlGODNxNC9KRkFsYmZHU1VXRWl1N0lH?=
 =?utf-8?B?Q0gyRFJrMlhOemV2cVhKRGcrbnhVL3JST1p5Wi9icXM4YmVENDZTLzhOM2Nw?=
 =?utf-8?B?OCs0Z1pjMXFyZ1h0TUFYdHk0ZUE5dEVKcFRzWHF4KzZ5TFpKQjcrWEdiYUEv?=
 =?utf-8?B?NW85M3dRYytQQkcvcWNqZTljWGphaHFTZ2NZaVJuQnBGRVIwRWRFZ1lRQ25O?=
 =?utf-8?Q?GMRslZ66rYvqHDkfxa1zMeKjSFY0clga?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTdld252QXdRSk5lUVdYSC9DNzVMaTAyOHZoNm54Z2wwclo3RWtEVUljMUlC?=
 =?utf-8?B?VGRBcEdHUGhiZHJpeU1VdUpSTUFwWE8zemJCMUJhd2lvR3BmTlYrc0dEdlFh?=
 =?utf-8?B?bmswQ2Y1NXFBOVJuTWZmVnR3RFZVbml1ZExQWGYzQU9iOVJSdUtVYzlMa2R6?=
 =?utf-8?B?OVlHMEk5VnJ5MFpwV0pJUE9qbmErR3pBaDFySHM4RWFxYk42eExzbTM1bHY1?=
 =?utf-8?B?YzNSd29WVU5ySjhTcEFzWmZlZXBoMXZIZTMyL1FCNUVLYlcraWdtdzlvVEo5?=
 =?utf-8?B?OWFHVytzODdRSy9mRnh5NGl4K2grRUpqMm9lR0pFbGFTb05rM0NaYmRnK2h5?=
 =?utf-8?B?UldSNU9jT0JtS1VCUUJZanU5Y2ZtQUQyOXAzeFZhM3FOM3RkTWt5OC82WHlC?=
 =?utf-8?B?WXFrMllCUmlFSUcxSnJxL2FxR1pyU2QrL3JYekErcmdkTWYvaXBkODRNRng3?=
 =?utf-8?B?QjFhbDhxbktLMkZFUTRncSs1L01JclVsNjY4RGVOQjdSSFZpWXorek1ZT0R0?=
 =?utf-8?B?VFRLSzVlQ3JhR2E0OCszNE1LaFZqaHRhcndva2tRck9KbXYvQ1EzYlRta1d5?=
 =?utf-8?B?V241M0xWOCtFQ3h2QzJKRHRHOUw0cEEzc3dDaTV2bWVHM2VEbU0vaVNUZXMw?=
 =?utf-8?B?M2VCMGQ1ZkxHdlVqSTAzWk5oZHpjTjh3UWJnMUVpUFlJa2Zqbkx0c3dMbkhx?=
 =?utf-8?B?Q0x6RFJqanpsU2V5dHkvMnJ4OHRLczVtUVlRUzhYbWNBMGFvblFaQURyZXRO?=
 =?utf-8?B?MEZuUjR1Q1BlakxsWi80KzZ1QjY4bERmSkJMWmxMZWJTVFRxT1hXc3VyTFUz?=
 =?utf-8?B?WjdOUk5aeDMvT2Q4RkZCWGsxRzByUTc1R2J4dVVhTEZheGlYc1NqNHY3dHVw?=
 =?utf-8?B?RW5YcmZvVUVrUXNxcHIvSnd4akFaWDZ6VElNd3Y5RlJjVXVvOGtYeS91NC9h?=
 =?utf-8?B?M3E4YnVyaXZxMHFjcWgyNVhodmdVMWVyYkxLV1Q4SktFSGM3WGJFblZpazBu?=
 =?utf-8?B?bkZDZmtXVGV1S1lxWjBSanBQVXNIZllnK2g2eGJjZWNYNDJpUG9hc2ROVEZ3?=
 =?utf-8?B?d0ZkZEw3cm1UU0J6NWMveDhLZzJmLzdqa3lrT2NBQmt1N1FMVlgrTEVwby9w?=
 =?utf-8?B?V1ZIVHJRYmhTMm5LR1huYnpjWkRjK2lSeEdtY25MRXByM1pVVmdRdThpUEhY?=
 =?utf-8?B?emJKZnhlY01IVWV2alRpN0FlM2c3c3A3bWVJTGxhUVB5L1RreFdsN2QrOGJF?=
 =?utf-8?B?VmpFWUp2SS9UaSs4S3NROFlGb0NUSUtpdzNuZW5icHRPRmVid2J4MVgxZjdZ?=
 =?utf-8?B?RGdLTzBONEViMktvQVV6YUNxdVdJMzZIaUlNaW4vZDc3L2RkQk5yM3J1aU1W?=
 =?utf-8?B?R1UyblV2U3l1dU1sZmV6SVdyNkR3YjB1TkNtMVFjd2FhVHA2b05wdm9haDlp?=
 =?utf-8?B?OG9FY29lYkt6NElRUTJyTWZBbFIxR0IzSlo5ZElIUEZYTS8vQ1duVTVZUVhX?=
 =?utf-8?B?YmRNQzZwcXl3TnV5TW0yNWlwWnNYOVh2SmVYSUU1U2NsQ25QRTh6L0tmc1Vj?=
 =?utf-8?B?VmpnUkNRcXN5SDhSZ2toZUhkSmJHaTdmZERZc0ZKa1Z6dkQ2VmlJMFVqS0VZ?=
 =?utf-8?B?Y3NIV1QrQm5sdkg2NWdieUM2RXFlTlZGcTNCT05NV2FaQjZjOEdHMHlSNUh2?=
 =?utf-8?B?Z29JUWtrdkxDM0RhT1lEeVExVXBGYlFHQU9kYmxQRWJ1RlRBdVMyT0xUUjlD?=
 =?utf-8?B?OXdJN21nbHlpOTNHS2M2Tk54NGpQU2FjTVdkMlVzaXBpeitZWUlUMkRGVWNu?=
 =?utf-8?B?a2ZMelN3Y2ZGaW1iVW5ETzNoRmtGbnIwaStDRWRWU2FFQStiSmQ3OTlubW1v?=
 =?utf-8?B?akJLVEdpeDg4SFJiTVhFUTB1ZVM2dm5jRnVNRXptZnQrTDVzbHVvTnNXcXI3?=
 =?utf-8?B?enZHY2d6SEhDcFdndzkrbm1Sd3NaYlExdmMzbmYwOGd3TVpBbTZ4SkpmMWND?=
 =?utf-8?B?N3E2TnVydGtHQXJ6c0ZoZkxPaENPaFpXdFo0ejYrSDhZSW9FQkhCMU9sMGsw?=
 =?utf-8?B?R3lhTEgvZzFUanhWeVU2RkRRbGpnREFBbHB1elFEZjIzb3lLZHorOWMvR1Bv?=
 =?utf-8?B?NnI1bEtwUHZHcXRuZEdSRnNUTm5xaUJpa0NZdTA0OThmSG5ycVkvMmdlUDY4?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eed9b30a-e88e-4010-9d3d-08de27c4fb54
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 23:40:11.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+lCdePXsqga+yXu7gF2FLp6F0ho6bSl7E2+n1078E7jhZKhE9N0+NiPK7oKQICUHryYqKMTapn7+H55ldZ4nTprDwvDdYjwSxWoboppoVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6502
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> 
> 
> On 11/19/2025 3:23 PM, dan.j.williams@intel.com wrote:
> > Terry Bowman wrote:
> >> CXL currently has separate trace routines for CXL Port errors and CXL
> >> Endpoint errors. This is inconvenient for the user because they must enable
> >> 2 sets of trace routines. Make updates to the trace logging such that a
> >> single trace routine logs both CXL Endpoint and CXL Port protocol errors.
> > No, this is not inconvient, this is required for compatible evolution of
> > tracepoints. The change in this patch breaks compatibility as it
> > violates the expectation the type and order of TP_ARGS does not change
> > from one kernel to next.
> >
> >> Keep the trace log fields 'memdev' and 'host'. While these are not accurate
> >> for non-Endpoints the fields will remain as-is to prevent breaking
> >> userspace RAS trace consumers.
> >>
> >> Add serial number parameter to the trace logging. This is used for EPs
> >> and 0 is provided for CXL port devices without a serial number.
> >>
> >> Leave the correctable and uncorrectable trace routines' TP_STRUCT__entry()
> >> unchanged with respect to member data types and order.
> >>
> >> Below is output of correctable and uncorrectable protocol error logging.
> >> CXL Root Port and CXL Endpoint examples are included below.
> >>
> >> Root Port:
> >> cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status='CRC Threshold Hit'
> >> cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
> > A root port is not a "memdev", another awkward side effect of trying to
> > combine 2 trace points with different use cases.
> >
> > So a NAK from me for this change (unless there is an strong reason for
> > Linux to inflict the compat breakage), please keep the separate
> > tracepoints they are for distinctly different use cases. A memdev
> > protocol error is contained to that memdev, a port protocol error
> > implicates every CXL.cachemem descendant of that port.
> I misunderstood this comment from previous code review:
> https://lore.kernel.org/linux-cxl/67aea897cfe55_2d1e294ca@dwillia2-xfh.jf.intel.com.notmuch/#t

No, you did not misunderstand, I just did not realize at the time I was
asking for compatibility breakage with that suggestion. Apologies for
that thrash.

> Are you OK with the following format for Port devices? Or let me know what format is needed.
> cxl_port_aer_correctable_error: device=port1 parent=root0 status='Received Error From Physical Layer'
> cxl_port_aer_uncorrectable_error: device=port1 parent=root0 status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Erro'

That looks good to me.

Also, I realize this patch set has gone through many revisions. We
really need to get at least some of these pre-req patches into a topic
branch so they do not need to keep being sent out in this large series.

